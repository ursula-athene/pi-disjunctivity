# Copyright (c) 2026 Ursula Athene. All rights reserved.
# SPDX-License-Identifier: MIT
import hashlib
import json
from pathlib import Path
import subprocess
import tempfile
import unittest

from tools.check_docs import check, parse
from tools.inspect_review import inspect
from tools.prepare_review import prepare


class DocumentationFixtures(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        (self.root / "docs").mkdir()
        self.write("docs/session-prompts.md", "# Sessions\n\n## Current prompt: B2\n\n"
                   "## Old prompts - do not use\n\n<a id=\"current-prompt-b1\"></a>\n\n### B1\n")
        for file, prefix in (("README.md", "docs/"), ("docs/proof-attempt-session-prompt.md", "")):
            self.write(file, f"Use <!-- current-prompt --> [Current]({prefix}session-prompts.md#current-prompt-b2)\n"
                       f"\n[Historical]({prefix}session-prompts.md#current-prompt-b1)\n")

    def write(self, file, text):
        (self.root / file).write_text(text)

    def errors(self):
        return check(self.root, [p.relative_to(self.root) for p in self.root.rglob("*.md")])

    def test_valid_historical_references_and_current_entry(self):
        self.assertEqual(self.errors(), [])

    def test_stale_but_valid_anchor(self):
        path = self.root / "README.md"
        path.write_text(path.read_text().replace("#current-prompt-b2", "#current-prompt-b1"))
        self.assertTrue(any("active entry" in e for e in self.errors()))
        self.assertFalse(any("missing anchor" in e for e in self.errors()))

    def test_missing_target_and_anchor(self):
        self.write("docs/history.md", "[Missing](gone.md) [Bad](session-prompts.md#absent)")
        errors = self.errors()
        self.assertTrue(any("missing target" in e for e in errors))
        self.assertTrue(any("missing anchor" in e for e in errors))

    def test_multiple_current_sections(self):
        path = self.root / "docs/session-prompts.md"
        path.write_text(path.read_text() + "\n## Current prompt: C\n")
        self.assertTrue(any("exactly one" in e for e in self.errors()))

    def test_missing_marker_and_bare_prompt_target(self):
        self.write("README.md", "Use [Current](docs/session-prompts.md)\n")
        self.assertTrue(any("one marked" in e for e in self.errors()))
        self.write("README.md", "Use <!-- current-prompt --> [Current](docs/session-prompts.md)\n")
        self.assertTrue(any("active entry" in e for e in self.errors()))

    def test_fences_reference_links_and_heading_ids(self):
        self.write("docs/target.md", "# Title\n\n## `API` & types\n\n## `API` & types\n")
        self.write("docs/history.md", "[One][ref]\n\n[ref]: target.md#api--types-1\n\n"
                   "```md\n[not a link](absent.md)\n## Current prompt: not real\n```\n")
        self.assertEqual(self.errors(), [])
        self.assertIn("api--types-1", parse((self.root / "docs/target.md").read_text())[0])

    def test_encoded_paths_and_parentheses(self):
        self.write("docs/a (b).md", "# Space\n")
        self.write("docs/history.md", "[Space](a%20(b).md#space)\n")
        self.assertEqual(self.errors(), [])

    def test_dated_source_citations_are_narrow_exceptions(self):
        (self.root / "docs/agy-reports").mkdir()
        self.write("docs/agy-reports/literature-review-report.md",
                   "[Sibling](../../../deepmind-formal-conjectures/Normal.lean)\n"
                   "[Snapshot line](../session-prompts.md#L999-L1001)\n")
        self.assertEqual(self.errors(), [])
        self.write("docs/agy-reports/literature-review-report.md",
                   "[Missing](missing.md#L999) [Wrong escape](../../../elsewhere/a.md)\n"
                   "[Traversal](../../../deepmind-formal-conjectures/../elsewhere/a.md)")
        self.assertEqual(len(self.errors()), 3)


def capture(response="No findings.", **result_overrides):
    result = {"status": "SUCCESS", "response": response, **result_overrides}
    events = [{"event": "init", "conversation_id": "fixture", "init": {"model": "gemini-4-carbon-high"}},
              {"event": "result", "result": result}]
    return [{"sequence": 0, "started_at": "2026-11-25T00:00:00Z",
             "captured_at": "2026-11-25T00:00:01Z", "requested_max_tokens": 1000,
             "original_token_count": 100, "exit_code": 0,
             "output": "\n".join(json.dumps(e) for e in events) + "\n"}]


class ReviewFixtures(unittest.TestCase):
    def candidate(self, chunks):
        return inspect(chunks, attested=True)["review_completion"] == "candidate_for_human_acceptance"

    def test_success_with_and_without_findings_requires_human_assessment(self):
        for response in ("No findings. Scope fully read.", "P1 tools/a.py:12: fails on empty input because..."):
            with self.subTest(response=response):
                result = inspect(capture(response), True)
                self.assertTrue(self.candidate(capture(response)))
                self.assertIn("No findings is not proof", result["human_assessment"])

    def test_missing_result(self):
        chunks = capture()
        chunks[0]["output"] = chunks[0]["output"].splitlines()[0] + "\n"
        self.assertFalse(self.candidate(chunks))
        self.assertEqual(inspect(chunks, True)["capture_completeness"], "incomplete")

    def test_empty_success(self):
        for response in ("", " \n", None):
            self.assertFalse(self.candidate(capture(response)))

    def test_nonzero_and_missing_exit(self):
        chunks = capture()
        chunks[0]["exit_code"] = 1
        self.assertFalse(self.candidate(chunks))
        del chunks[0]["exit_code"]
        self.assertFalse(self.candidate(chunks))

    def test_error_timeout_interruption_and_denial(self):
        for fields in ({"error": "service unavailable"}, {"status": "ERROR"},
                       {"finished_reason": "print_timeout"}, {"finished_reason": "interrupted"},
                       {"denied_actions": [{"tool": "read_file", "path": "diff.patch"}]}):
            with self.subTest(fields=fields):
                self.assertFalse(self.candidate(capture(**fields)))

    def test_structured_stream_error(self):
        chunks = capture()
        chunks[0]["output"] = json.dumps({"event": "error", "error": {"message": "timeout"}}) + "\n" + chunks[0]["output"]
        self.assertFalse(self.candidate(chunks))

    def test_truncation_and_malformed_capture(self):
        for change in ({"truncated": True}, {"original_token_count": 1500},
                       {"sequence": 1}, {"output": '{"event": "result"'},
                       {"output": "Warning: truncated output\n"}):
            chunks = capture()
            chunks[0].update(change)
            self.assertFalse(self.candidate(chunks))
            self.assertEqual(inspect(chunks, True)["capture_completeness"], "incomplete")

    def test_unattested_capture_is_not_complete(self):
        self.assertEqual(inspect(capture())["capture_completeness"], "unverified")

    def test_json_event_split_between_execution_chunks(self):
        chunks = capture()
        original = chunks[0].copy()
        split = original["output"].index('"response"') + 4
        chunks[0]["output"] = original["output"][:split]
        del chunks[0]["exit_code"]
        chunks.append({**original, "sequence": 1, "output": original["output"][split:]})
        self.assertTrue(self.candidate(chunks))

    def test_diagnostics_and_terminal_fields_are_retained(self):
        chunks = capture()
        chunks[0]["output"] = "CLI persistence denied; inspect coverage\n" + chunks[0]["output"]
        result = inspect(chunks, True)
        self.assertEqual(len(result["diagnostics"]), 1)
        self.assertEqual(result["terminal_result"]["response"], "No findings.")


class PreparationFixtures(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.git("init", "-q")
        self.git("config", "user.email", "fixture@example.invalid")
        self.git("config", "user.name", "Ursula Athene")
        for name in ("owned.md", "other.md"):
            (self.root / name).write_text("baseline\n")
        self.git("add", "owned.md", "other.md")
        self.git("commit", "-qm", "Baseline")
        self.base = self.git("rev-parse", "HEAD").decode().strip()
        (self.root / "owned.md").write_text("owned change\n")
        (self.root / "other.md").write_text("unrelated change\n")
        (self.root / "new.md").write_text("new owned file\n")

    def git(self, *args):
        return subprocess.check_output(["git", *args], cwd=self.root, stderr=subprocess.PIPE)

    def test_scoped_diff_includes_staged_new_file_and_preserves_unrelated_index(self):
        self.git("add", "owned.md", "new.md", "other.md")
        before = self.git("ls-files", "--stage")
        output = self.root / "capture"
        record = prepare(self.root, self.base, ["owned.md", "new.md"], output)
        diff = (output / "diff.patch").read_bytes()
        self.assertNotIn(b"other.md", diff)
        self.assertIn(b"new owned file", diff)
        self.assertEqual(record["baseline"], self.base)
        self.assertEqual(record["diff_sha256"], hashlib.sha256(diff).hexdigest())
        self.assertEqual(before, self.git("ls-files", "--stage"))

    def test_unstaged_and_untracked_scope_is_rejected(self):
        for name in ("owned.md", "new.md"):
            with self.assertRaisesRegex(ValueError, "stage owned"):
                prepare(self.root, self.base, [name], self.root / "capture")

    def test_deleted_file_and_literal_path(self):
        name = "literal[1].md"
        (self.root / name).write_text("new\n")
        (self.root / "owned.md").unlink()
        self.git("add", "--", ".")
        record = prepare(self.root, self.base, ["owned.md", name], self.root / "capture")
        self.assertEqual(record["paths"], [name, "owned.md"])

    def test_directory_missing_file_and_output_overwrite_rejected(self):
        self.git("add", "owned.md")
        for paths in (["."], ["absent.md"], ["../outside"], []):
            with self.assertRaises(ValueError):
                prepare(self.root, self.base, paths, self.root / "capture")
        prepare(self.root, self.base, ["owned.md"], self.root / "capture")
        with self.assertRaises(FileExistsError):
            prepare(self.root, self.base, ["owned.md"], self.root / "capture")


if __name__ == "__main__":
    unittest.main()
