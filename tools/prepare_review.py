# Copyright (c) 2026 Ursula Athene. All rights reserved.
# SPDX-License-Identifier: MIT
"""Prepare an exact index diff for an explicit list of task-owned files."""

import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess


def git(root, *args):
    return subprocess.check_output(["git", "--literal-pathspecs", *args], cwd=root)


def prepare(root, baseline, paths, output):
    root = root.resolve()
    scope = sorted(set(paths))
    if not scope:
        raise ValueError("Supply explicit task-owned files")
    for path in scope:
        p = Path(path)
        if p.is_absolute() or ".." in p.parts or p.as_posix() != path or (root / p).is_dir():
            raise ValueError(f"Expected a repository-relative file: {path}")
    base = git(root, "rev-parse", "--verify", f"{baseline}^{{commit}}").decode().strip()
    # Stage only owned changes first. Refuse to silently omit unstaged edits.
    dirty = git(root, "diff", "--name-only", "--", *scope)
    untracked = git(root, "ls-files", "--others", "--exclude-standard", "--", *scope)
    if dirty or untracked:
        raise ValueError("Scope contains unstaged/untracked changes; stage owned paths first")
    changed = git(root, "diff", "--cached", "--no-renames", "--name-only", "-z", base, "--", *scope)
    actual = sorted(p for p in changed.decode().split("\0") if p)
    if actual != scope:
        raise ValueError("Every supplied path must have a staged change against the baseline")
    git(root, "diff", "--cached", "--check", base, "--", *scope)
    diff = git(root, "diff", "--cached", "--binary", "--full-index", "--no-color", "--no-ext-diff",
               "--no-textconv", "--no-renames", base, "--", *scope)
    record = {"baseline": base, "head": git(root, "rev-parse", "HEAD").decode().strip(),
              "paths": scope, "diff_sha256": hashlib.sha256(diff).hexdigest(),
              "diff_bytes": len(diff), "source": "index",
              "prepared_at": datetime.now(timezone.utc).isoformat()}
    output.mkdir(parents=True, exist_ok=False)
    (output / "diff.patch").write_bytes(diff)
    (output / "scope.json").write_text(json.dumps(record, indent=2) + "\n")
    return record


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--baseline", required=True)
    parser.add_argument("--output", type=Path, required=True, help="New directory; never overwritten")
    parser.add_argument("paths", nargs="+")
    args = parser.parse_args()
    try:
        record = prepare(Path.cwd(), args.baseline, args.paths, args.output)
    except (ValueError, OSError, subprocess.CalledProcessError) as error:
        parser.exit(1, f"Review preparation failed: {error}\n")
    print(f"Prepared {len(record['paths'])} files against {record['baseline']}; "
          f"SHA-256 {record['diff_sha256']}")


if __name__ == "__main__":
    main()
