# Copyright (c) 2026 Ursula Athene. All rights reserved.
# SPDX-License-Identifier: MIT
"""Check or install the evaluated B2 tools from immutable local Git snapshots."""

import argparse
from copy import deepcopy
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import tarfile
import tempfile
import tomllib

from tools.b2_skill_adaptation import REV as SKILLS_REV, prepare_skills

ROOT = Path(__file__).resolve().parents[1]
LSP_REV = "7932203d79db213852db215835bd79c943bb99b0"
SERVER = "pi-b2-lean-lsp"
PROJECT_SKILLS = ("pi-argument-critic", "paper-to-lean-contract")
UPSTREAM_SKILLS = ("lean-search-discovery", "lean-proof-patterns")
TOOLS = {"lean_goal", "lean_diagnostic_messages", "lean_hover_info",
         "lean_declaration_file", "lean_local_search"}
DISABLED = ("lean_build,lean_code_actions,lean_completions,lean_file_outline,"
            "lean_get_widget_source,lean_get_widgets,lean_hammer_premise,"
            "lean_leanfinder,lean_leansearch,lean_loogle,lean_minimal_hypotheses,"
            "lean_multi_attempt,lean_profile_proof,lean_references,lean_run_code,"
            "lean_term_goal,lean_verify")


def run(*args, cwd=ROOT, timeout=240):
    result = subprocess.run([str(a) for a in args], cwd=cwd, text=True,
                            capture_output=True, timeout=timeout)
    if result.returncode:
        raise RuntimeError(f"{args[0]} exited {result.returncode}: {result.stderr.strip()}")
    return result.stdout.strip()


def require(condition, message):
    if not condition:
        raise ValueError(message)


def present(path):
    return path.exists() or path.is_symlink()


def hashes(folder):
    require(folder.is_dir() and not folder.is_symlink(), f"Expected regular directory: {folder}")
    result = {}
    for path in sorted(folder.rglob("*")):
        require(not path.is_symlink(), f"Unexpected symlink: {path}")
        if path.is_file() and "__pycache__" not in path.parts:
            result[str(path.relative_to(folder))] = hashlib.sha256(path.read_bytes()).hexdigest()
    return result


def skill_action(source, target):
    if not present(target):
        return "install"
    require(hashes(target) == hashes(source), f"Existing skill differs; preserve and inspect: {target}")
    return "reuse"


def snapshot(clone, revision, destination):
    """Read the exact commit, regardless of clone HEAD or working-tree edits."""
    require(clone.is_dir(), f"Missing source clone: {clone}; see docs/b2-tool-installation.md")
    run("git", "-C", clone, "cat-file", "-e", revision + "^{commit}")
    archive = destination.with_suffix(".tar")
    run("git", "-C", clone, "archive", "--format=tar", "--output=" + str(archive), revision)
    destination.mkdir()
    with tarfile.open(archive) as stream:
        stream.extractall(destination, filter="data")


def tool_environment(root, path=None):
    elan = str(Path.home() / ".elan/bin")
    return {"LEAN_PROJECT_PATH": str(root), "LEAN_REPL": "false", "LEAN_LOG_LEVEL": "NONE",
            "LEAN_MCP_DISABLED_TOOLS": DISABLED,
            "PATH": path or elan + os.pathsep + os.environ.get("PATH", "/usr/bin:/bin")}


def canonical(config):
    """Codex omits explicit empty stdio argument lists when rewriting config."""
    result = deepcopy(config)
    for entry in result.get("mcp_servers", {}).values():
        if "command" in entry and "url" not in entry and entry.get("args") == []:
            del entry["args"]
    return result


def config_delta(before, after, desired):
    old, new = canonical(before), canonical(after)
    actual = new.get("mcp_servers", {}).pop(SERVER, None)
    expected = canonical({"mcp_servers": {SERVER: desired}})["mcp_servers"][SERVER]
    require(actual == expected, "New MCP entry does not match the requested configuration")
    old.get("mcp_servers", {}).pop(SERVER, None)
    if not old.get("mcp_servers"):
        old.pop("mcp_servers", None)
    if not new.get("mcp_servers"):
        new.pop("mcp_servers", None)
    require(old == new, "Unexpected unrelated configuration delta; inspect the backup")


def configuration_action(existing, desired, legacy_launcher):
    """Reuse exact configuration; migrate only the recognized previous B2 entry."""
    if existing is None:
        return "add"
    entry = canonical({"mcp_servers": {SERVER: existing}})["mcp_servers"][SERVER]
    if entry == desired:
        return "reuse"
    legacy = {"command": str(legacy_launcher), "env": desired["env"]}
    require(entry == legacy, "Existing MCP entry differs; refusing to replace its settings")
    return "migrate console entry to module"


def validate_install(python, source, constraints):
    """Check runtime versions and pinned package bytes before using an existing tool."""
    code = ("import importlib.metadata as m,json,platform,re; "
            "d=m.distribution('lean-lsp-mcp'); "
            "print(json.dumps({'python':platform.python_version(),"
            "'versions':{re.sub('[-_.]+','-',p.metadata['Name']).lower():p.version for p in m.distributions()},"
            "'source':str(d.locate_file('lean_lsp_mcp'))}))")
    expected = dict(line.split("==") for line in constraints.read_text().splitlines() if line)
    expected["lean-lsp-mcp"] = "0.33.0"
    info = json.loads(run(python, "-c", code))
    validate_runtime(info, expected)
    require(hashes(Path(info["source"])) == hashes(source / "src/lean_lsp_mcp"),
            "Installed LSP source differs from the pinned commit")
    version = run(python, "-m", "lean_lsp_mcp", "--version")
    require(version.endswith(" 0.33.0"), "Module entry point did not report version 0.33.0")


def validate_runtime(info, expected):
    require(info["python"] == "3.13.2", "Installed tool interpreter is not the tested Python 3.13.2")
    require(info["versions"] == expected, "Installed distribution inventory differs from the evaluated versions")


def smoke(python, output):
    text = run(python, "-m", "tools.check_b2_mcp", "--output", output)
    print(text)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--install", action="store_true", help="perform writes; default is a check")
    parser.add_argument("--lsp", action="store_true")
    parser.add_argument("--project-skills", action="store_true")
    parser.add_argument("--upstream-skills", action="store_true")
    parser.add_argument("--all", action="store_true")
    parser.add_argument("--lsp-source", type=Path, default=ROOT.parent / "lean-lsp-mcp")
    parser.add_argument("--skills-source", type=Path, default=ROOT.parent / "LeanAutoformalizationSkills")
    args = parser.parse_args()
    require(args.all or args.lsp or args.project_skills or args.upstream_skills, "Select components or --all")
    lsp = args.lsp or args.all
    selected = list(PROJECT_SKILLS if args.project_skills or args.all else ())
    selected += list(UPSTREAM_SKILLS if args.upstream_skills or args.all else ())
    require((ROOT / "lean-toolchain").read_text().strip() == "leanprover/lean4:v4.37.0-rc1",
            "Lean pin changed; review compatibility first")
    home = Path.home()
    codex_dir = Path(os.environ.get("CODEX_HOME", home / ".codex")).expanduser().resolve()
    config = codex_dir / "config.toml"
    skill_dir = home / ".agents/skills"
    constraints = ROOT / "tools/b2_lsp_constraints.txt"
    with tempfile.TemporaryDirectory(prefix="pi-b2-install-check-") as tmp:
        stage = Path(tmp)
        package = stage / "skills"
        package.mkdir()
        if any(name in UPSTREAM_SKILLS for name in selected):
            snapshot(args.skills_source.resolve(), SKILLS_REV, stage / "skill-source")
            prepare_skills(stage / "skill-source", package)
        for name in selected:
            if name in PROJECT_SKILLS:
                shutil.copytree(ROOT / "skills" / name, package / name)
        missing = []
        for name in selected:
            for alternate in {codex_dir / "skills", ROOT / ".agents/skills"} - {skill_dir}:
                require(not present(alternate / name), f"Duplicate skill outside destination: {alternate / name}")
            target = skill_dir / name
            if skill_action(package / name, target) == "reuse":
                print(f"Skill already matches: {name}")
            else:
                missing.append(name)
                print(f"Skill to install: {name}")
        if lsp:
            uv, codex = shutil.which("uv"), shutil.which("codex")
            require(uv and codex, "uv and codex must be on PATH")
            snapshot(args.lsp_source.resolve(), LSP_REV, stage / "lsp-source")
            tool_dir = Path(run(uv, "--no-cache", "tool", "dir")) / "lean-lsp-mcp"
            launcher = Path(run(uv, "--no-cache", "tool", "dir", "--bin")) / "lean-lsp-mcp"
            python = tool_dir / "bin/python"
            exists = present(tool_dir)
            if exists:
                validate_install(python, stage / "lsp-source", constraints)
            else:
                require(not present(launcher), f"Executable conflict: {launcher}")
            if not exists:
                build_python = run(uv, "--no-cache", "python", "find", "--no-python-downloads", "3.13.2")
                require(run(build_python, "-c", "import platform;print(platform.python_version())") == "3.13.2",
                        "Tested Python 3.13.2 is unavailable")
            require("4.37.0-rc1" in run(home / ".elan/bin/lake", "env", "lean", "--version"), "Unexpected Lean version")
            require((ROOT / ".lake/build/lib/lean/PiDisjunctivity.olean").is_file(), "Run lake build before the MCP smoke test")
            require(not config.is_symlink(), "Config is a symlink; inspect manually")
            before_bytes = config.read_bytes() if config.exists() else b""
            before = tomllib.loads(before_bytes.decode())
            existing = before.get("mcp_servers", {}).get(SERVER)
            env = tool_environment(ROOT, existing.get("env", {}).get("PATH") if existing else None)
            require(str(home / ".elan/bin") in env["PATH"].split(os.pathsep), "Existing MCP PATH lacks Elan")
            desired = {"command": str(python), "args": ["-m", "lean_lsp_mcp"], "env": env}
            action = configuration_action(existing, desired, launcher)
            # Include effective configuration layers; do not shadow a project/plugin entry.
            effective = json.loads(run(codex, "mcp", "list", "--json"))
            require(existing is not None or all(e["name"] != SERVER for e in effective),
                    "MCP name exists outside user config; refusing to shadow it")
            print(f"LSP: {'reuse verified installation' if exists else 'install pinned source'}; MCP: {action}")
            if exists:
                smoke(python, stage / "smoke")
        if not args.install:
            print("Check passed. --install performs selected user-scoped changes; app activation is separate.")
            return
        os.umask(0o077)
        state_root = home / ".local/share/pi-b2-activation"
        state_root.mkdir(parents=True, exist_ok=True)
        state = Path(tempfile.mkdtemp(prefix="run-", dir=state_root))
        receipt = {"project": str(ROOT), "lsp_revision": LSP_REV, "skills_revision": SKILLS_REV,
                   "new_skills": [], "new_lsp": False, "config_action": "none", "host_tested": False}
        def save():
            (state / "receipt.json").write_text(json.dumps(receipt, indent=2) + "\n")
        save()
        print(f"Receipt and backup: {state}", flush=True)
        if lsp:
            if not exists:
                shutil.copytree(stage / "lsp-source", state / "lsp-source")
                print(run(uv, "--no-cache", "tool", "install", "--python", build_python,
                          "--no-python-downloads", "--constraints", constraints, state / "lsp-source"))
                receipt["new_lsp"] = True
                save()
                validate_install(python, stage / "lsp-source", constraints)
                smoke(python, state / "smoke")
            else:
                shutil.copytree(stage / "smoke", state / "smoke")
            if action != "reuse":
                require((config.read_bytes() if config.exists() else b"") == before_bytes,
                        "Config changed during checks; rerun without overwriting it")
                (state / "config.before.toml").write_bytes(before_bytes)
                command = [codex, "mcp", "add", SERVER]
                for key, value in env.items():
                    command += ["--env", key + "=" + value]
                print(run(*command, "--", python, "-m", "lean_lsp_mcp"))
                receipt["config_action"] = action
                save()
                after = tomllib.loads(config.read_text())
                config_delta(before, after, desired)
                (state / "entry.after.json").write_text(json.dumps(after["mcp_servers"][SERVER], indent=2) + "\n")
            receipt["module_and_protocol_tested"] = True
            save()
        if missing:
            skill_dir.mkdir(parents=True, exist_ok=True)
        for name in missing:
            target = skill_dir / name
            require(not present(target), f"Skill appeared during installation: {target}")
            shutil.copytree(package / name, target)
            require(hashes(target) == hashes(package / name), f"Skill copy verification failed: {target}")
            receipt["new_skills"].append({"path": str(target), "hashes": hashes(target)})
            save()
        print("Selected components installed or verified. See docs/b2-tool-installation.md for host checks and rollback.")


if __name__ == "__main__":
    try:
        main()
    except (ValueError, OSError, RuntimeError, subprocess.TimeoutExpired) as error:
        raise SystemExit(f"B2 setup stopped: {error}") from error
