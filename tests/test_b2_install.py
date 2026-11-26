# Copyright (c) 2026 Ursula Athene. All rights reserved.
# SPDX-License-Identifier: MIT
from copy import deepcopy
from pathlib import Path
import shutil
import tempfile
import unittest

from tools.install_b2_tools import SERVER, config_delta, configuration_action, skill_action, validate_runtime
from tools.check_b2_mcp import generated_search
from tools.b2_skill_adaptation import prepare_skills, URL


class ConfigPreservation(unittest.TestCase):
    def setUp(self):
        self.before = {"model": "existing", "mcp_servers": {
            "node_repl": {"command": "node", "args": [], "env": {"KEEP": "value"}}}}
        self.desired = {"command": "/tool/bin/python", "args": ["-m", "lean_lsp_mcp"],
                        "env": {"LEAN_REPL": "false", "PATH": "/existing/path"}}
        self.after = deepcopy(self.before)
        self.after["mcp_servers"][SERVER] = self.desired

    def test_actual_empty_args_normalization(self):
        del self.after["mcp_servers"]["node_repl"]["args"]
        config_delta(self.before, self.after, self.desired)

    def test_nonempty_args_loss_is_rejected(self):
        self.before["mcp_servers"]["node_repl"]["args"] = ["--required"]
        del self.after["mcp_servers"]["node_repl"]["args"]
        with self.assertRaisesRegex(ValueError, "unrelated"):
            config_delta(self.before, self.after, self.desired)

    def test_unrelated_changes_are_rejected(self):
        for change in (lambda c: c.update(model="other"),
                       lambda c: c["mcp_servers"]["node_repl"]["env"].update(KEEP="different"),
                       lambda c: c["mcp_servers"].pop("node_repl")):
            with self.subTest(change=change):
                after = deepcopy(self.after)
                change(after)
                with self.assertRaisesRegex(ValueError, "unrelated"):
                    config_delta(self.before, after, self.desired)

    def test_missing_or_wrong_new_entry_is_rejected(self):
        with self.assertRaises(ValueError):
            config_delta(self.before, self.before, self.desired)
        after = deepcopy(self.after)
        after["mcp_servers"][SERVER]["command"] = "/wrong/python"
        with self.assertRaises(ValueError):
            config_delta(self.before, after, self.desired)

    def test_new_empty_config_and_owned_migration(self):
        config_delta({}, {"mcp_servers": {SERVER: self.desired}}, self.desired)
        self.before["mcp_servers"][SERVER] = {"command": "/old/launcher"}
        config_delta(self.before, self.after, self.desired)

    def test_repeat_run_reuses_module_entry(self):
        self.assertEqual(configuration_action(self.desired, self.desired, Path("/tool/bin/lean-lsp-mcp")), "reuse")

    def test_only_exact_legacy_entry_is_migrated(self):
        launcher = Path("/tool/bin/lean-lsp-mcp")
        legacy = {"command": str(launcher), "args": [], "env": self.desired["env"]}
        self.assertIn("migrate", configuration_action(legacy, self.desired, launcher))
        for field, value in (("enabled", False), ("startup_timeout_sec", 500), ("command", "/other/server")):
            with self.subTest(field=field):
                modified = {**legacy, field: value}
                with self.assertRaises(ValueError):
                    configuration_action(modified, self.desired, launcher)


class SkillPreservation(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        root = Path(self.tmp.name)
        self.source, self.target = root / "source", root / "target"
        self.source.mkdir()
        (self.source / "SKILL.md").write_text("Reviewed skill")
        (self.source / "LICENSE").write_text("Retained notice")

    def test_install_then_repeat_and_reject_user_edit(self):
        self.assertEqual(skill_action(self.source, self.target), "install")
        shutil.copytree(self.source, self.target)
        self.assertEqual(skill_action(self.source, self.target), "reuse")
        (self.target / "SKILL.md").write_text("User edit")
        with self.assertRaises(ValueError):
            skill_action(self.source, self.target)
        self.assertEqual((self.target / "SKILL.md").read_text(), "User edit")

    def test_notice_loss_extra_file_and_symlink_are_conflicts(self):
        shutil.copytree(self.source, self.target)
        (self.target / "LICENSE").unlink()
        with self.assertRaises(ValueError):
            skill_action(self.source, self.target)
        shutil.copyfile(self.source / "LICENSE", self.target / "LICENSE")
        (self.target / "personal.md").write_text("Keep")
        with self.assertRaises(ValueError):
            skill_action(self.source, self.target)
        shutil.rmtree(self.target)
        self.target.symlink_to(self.source, target_is_directory=True)
        with self.assertRaises(ValueError):
            skill_action(self.source, self.target)


class RuntimeInventory(unittest.TestCase):
    def test_exact_runtime_and_inventory(self):
        expected = {"lean-lsp-mcp": "0.33.0", "mcp": "2.2.0"}
        validate_runtime({"python": "3.13.2", "versions": expected}, expected)
        for python, inventory in (("3.13.7", expected),
                                  ("3.13.2", {**expected, "extra": "1"}),
                                  ("3.13.2", {"lean-lsp-mcp": "0.33.0"}),
                                  ("3.13.2", {**expected, "mcp": "other"})):
            with self.subTest(python=python, inventory=inventory):
                with self.assertRaises(ValueError):
                    validate_runtime({"python": python, "versions": inventory}, expected)


class IndexWarmup(unittest.IsolatedAsyncioTestCase):
    async def exercise(self, results):
        calls, delays = [], []
        async def call(*args, **kwargs):
            calls.append(kwargs)
            return results[min(len(calls) - 1, len(results) - 1)]
        async def sleep(delay):
            delays.append(delay)
        return call, sleep, calls, delays

    async def test_warming_then_positive_hit(self):
        call, sleep, calls, delays = await self.exercise([
            {"items": [], "index": "unavailable"}, {"items": [], "index": "warming"},
            {"items": [{"name": "hasSum_nat_add_iff'"}], "index": "warming"}])
        await generated_search(call, sleep)
        self.assertEqual(len(calls), 3)
        self.assertEqual(delays, [0.25, 0.5])

    async def test_warming_is_bounded(self):
        call, sleep, calls, delays = await self.exercise([{"items": [], "index": "warming"}])
        with self.assertRaises(ValueError):
            await generated_search(call, sleep)
        self.assertEqual(len(calls), 6)
        self.assertLess(sum(delays), 8)

    async def test_other_missing_results_fail_without_retry(self):
        for state in ("consulted", "error"):
            call, sleep, calls, delays = await self.exercise([{"items": [], "index": state}])
            with self.assertRaises(ValueError):
                await generated_search(call, sleep)
            self.assertEqual(len(calls), 1)
            self.assertEqual(delays, [])


class AdaptationFixtures(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        self.source = self.root / "source"
        for name in ("lean-search-discovery", "lean-proof-patterns"):
            folder = self.source / "skills" / name
            (folder / "references").mkdir(parents=True)
            (folder / "SKILL.md").write_text("---\nname: " + name + "\n---\n"
                "[Companion](../lean-proof-patterns/references/math-to-lean.md)\n"
                "[Collection](../../INDEX.md)\n" +
                ("See the `lean-project-architecture` skill's `references/module-system.md` for\nthe full rules.\n"
                 if name == "lean-proof-patterns" else ""))
        proof = self.source / "skills/lean-proof-patterns/references"
        (proof / "math-to-lean.md").write_text('| "Skip this for now" | `sorry` (development only — never in finished code) |\n')
        (proof / "tactics-and-automation.md").write_text('| `aesop` | General-purpose automation | `Aesop` |\n')
        (self.source / "LICENSE").write_text("License retained")
        (self.source / "THIRD_PARTY_NOTICES.md").write_text("[Sources](SOURCES.md)")
        (self.source / "LICENSES").mkdir()
        (self.source / "LICENSES/Apache-2.0.txt").write_text("Apache retained")

    def test_complete_adaptation_and_local_companion(self):
        out = self.root / "out"
        prepare_skills(self.source, out)
        proof = out / "lean-proof-patterns"
        self.assertIn("no placeholder proof", (proof / "references/math-to-lean.md").read_text())
        self.assertIn("Mathlib.Tactic", (proof / "references/tactics-and-automation.md").read_text())
        text = (proof / "SKILL.md").read_text()
        self.assertIn("compatibility overrides", text)
        self.assertIn(URL + "INDEX.md", text)
        self.assertIn("../lean-proof-patterns/references/math-to-lean.md", text)
        self.assertEqual((proof / "LICENSES/Apache-2.0.txt").read_text(), "Apache retained")

    def test_changed_anchor_and_escaping_link_fail(self):
        phrasebook = self.source / "skills/lean-proof-patterns/references/math-to-lean.md"
        original = phrasebook.read_text()
        phrasebook.write_text("The required advice changed")
        with self.assertRaisesRegex(ValueError, "anchor"):
            prepare_skills(self.source, self.root / "bad-anchor")
        phrasebook.write_text(original)
        skill = self.source / "skills/lean-search-discovery/SKILL.md"
        skill.write_text(skill.read_text() + "[Escape](/outside-the-package)\n")
        with self.assertRaisesRegex(ValueError, "escaping"):
            prepare_skills(self.source, self.root / "bad-link")


if __name__ == "__main__":
    unittest.main()
