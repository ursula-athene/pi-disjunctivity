# Repeatable B2 tool installation

This is the maintained replacement for the temporary `/tmp/pi-b2-activation`
bundle. It installs only the evaluated LSP and four selected skill candidates;
it does not start B3, add Lean dependencies, or upgrade Lean/Mathlib. Run from
the repository root in your own Terminal when the agent cannot write user
configuration. No sudo or changes to host permissions are needed.

## Prerequisites and commands

Use the existing `uv`, `codex`, Git, Elan and pinned project environment.
Python 3.13.2 must be available to uv; if absent, explicitly install it with
`uv python install 3.13.2`. Keep the project's existing locked environment:

```sh
uv sync --locked
lake build
```

Add `$HOME/.elan/bin` to PATH if needed. The installer reads immutable Git
archives from the two source clones; it never checks out or modifies them.
On a new machine only, create missing siblings with:

```sh
git clone https://github.com/oOo0oOo/lean-lsp-mcp.git ../lean-lsp-mcp
git clone https://github.com/scottnarmstrong/LeanAutoformalizationSkills.git ../LeanAutoformalizationSkills
```

The commits must be present: LSP `7932203d79db213852db215835bd79c943bb99b0`,
skills `1837b95b3d5a9fd8d311367603902ad7fe261adf`. If an existing shallow clone
lacks one, fetch that commit in that clone. `--lsp-source` and `--skills-source`
accept alternate clone paths. Source HEAD and uncommitted edits are irrelevant
to the archived commit and remain untouched.

Check first, then install:

```sh
uv --no-cache run --locked --offline python -m tools.install_b2_tools --all
uv --no-cache run --locked --offline python -m tools.install_b2_tools --all --install
```

The outer `--offline` applies to the project runner. A new optional LSP install
downloads its constrained Python packages using normal TLS verification. The
installer does not change the project Python lock. The default command checks
state and, when LSP is installed, runs the five-tool smoke test. `--install`
performs the selected user-directory writes. Select `--lsp`, `--project-skills`,
or `--upstream-skills` instead of `--all`, or combine them.

Reruns verify and reuse matching packages, skill contents and configuration.
Differing skill files, symlinks, duplicate skill names, unexpected package
versions/source bytes, and conflicting MCP settings stop the run for inspection.
An interrupted skill copy can therefore require removal of its confirmed
task-owned partial directory before retrying; it is never silently overwritten.
The script prints a private receipt/backup directory before persistent changes.
After a partial failure, retain that receipt and rerun the selected components
once the named cause is resolved. Completed matching steps are reused.

## What the installer does

1. Archives the pinned source commits into temporary staging. Recreates only
   the two evaluated upstream skill adaptations, retaining their full resources,
   licenses and provenance. Adds the two reviewed project skill folders.
2. Uses `uv tool install` for an isolated user LSP environment, with the 42
   evaluated transitive versions in [the constraints](../tools/b2_lsp_constraints.txt).
   Checks the actual tool interpreter is 3.13.2, the complete distribution
   inventory matches, and the installed LSP source matches its pinned archive.
3. Starts the environment's Python with `-m lean_lsp_mcp`. Checks the version,
   exact five-tool protocol inventory, declaration search/source, hover, goals,
   and error-then-correction diagnostics on disposable fixed B2 material.
   A warming/unavailable symbol index gets at most six queries and 7.75 seconds
   of backoff within the overall 180-second smoke-test limit.
   Removes temporary root probes. Installation receipts retain protocol responses
   and server diagnostics; check-only staging is deleted on exit. Use the explicit
   terminal check below to retain diagnostics from a check-only run.
4. Registers `pi-b2-lean-lsp` through `codex mcp add`, using that **Python module
   command**, an explicit project root and Elan PATH, disabled REPL and the same
   restricted five-tool selection. It migrates only the exact recognized prior
   B2 console entry; other settings are conflicts. It backs up the config and
   verifies unrelated values, treating omitted empty stdio argument lists as
   equivalent to `args = []`.
5. Copies missing skills to `~/.agents/skills`, verifies their hashes, and saves
   a receipt under `~/.local/share/pi-b2-activation/run-*`. Existing identical
   skills are reused. Installed candidates still require usefulness evaluation.

The earlier console launcher was zero bytes despite a recorded size of 335.
Its truncation cause is unknown. The one-time repair restored the exact recorded
bytes. The maintained MCP command **does not depend on that generated wrapper**;
it tests the supported package module before adding configuration. This removes
the repair step from the normal setup path without claiming to prevent all
future filesystem damage. Neither the current working launcher nor the MCP
configuration needs an emergency repair now. Running `--all --install` once
adopts the module command, after which matching reruns reuse it.

Codex 0.172.0's [versioned implementation](https://github.com/openai/codex/blob/rust-v0.172.0/codex-rs/cli/src/mcp_cmd.rs#L418-L428)
loads the existing server map, inserts the named entry (replacing that map key),
and writes the resulting map. This supports migration and rollback without a
remove-first gap. That is source inspection; the maintained installer's real
user-directory migration remains an explicitly pending Terminal step.

## App verification and the meaning of a fresh session

Installing software and editing config do not prove an already-running app has
loaded its tools. Reload/restart when the actual tool catalog has not refreshed.
A new conversation is not intrinsically necessary: the user's restart exposed
all five tools in this existing conversation, and all five native calls passed.
There is no need to repeatedly restart once they are visible and working.

After a configuration change, ask the agent:

> Verify the five pi-b2-lean-lsp tools through native tool calls, including an
> intentional diagnostic and its correction in disposable B2 probes. Verify the
> four installed skills appear in the catalog. Preserve production Lean and
> configuration; do not start B3. Report any tool that is unavailable.

That is the app test; the user does not have to write a Lean proof. For a
repeatable terminal protocol check, run the installer without `--install`, or:

```sh
b2_tool_dir="$(uv --no-cache tool dir)"
"$b2_tool_dir/lean-lsp-mcp/bin/python" -m tools.check_b2_mcp --output /tmp/b2-mcp-check-NEW
```

Use a new output directory each time. Terminal protocol checks do not establish
native app discovery. Source search can return useful positive hits while its
index is warming; no negative result establishes general theorem nonexistence.

Native five-tool functionality is now tested. Clean descendant-process shutdown
and disabling/restoring the actual app entry remain separate checks: earlier
server stderr contained an ignored event-loop shutdown warning, and this agent's
host denies process enumeration and user-config writes. In a permitted host,
stop only this server and inspect its process descendants; temporarily set only
its `enabled` value to false, reload, run the shell replay, then restore/reload.
Do not stop unrelated Lean processes or alter other MCP entries. Keep the shell
fallback until these checks are complete. Skill transfer benefits beyond the
known cases remain unmeasured; the earlier [evaluation](b2-tool-evaluation.md)
and [review dispositions](agy-reports/b2-improvements-review.md) still apply.

## Rollback

Read the run's `receipt.json` first. Remove only newly installed skill directories
listed there, after comparing their current hashes with the receipt. Preserve
modified or pre-existing skills for inspection.

If this run added the MCP entry, inspect it against `entry.after.json`, then use
`codex mcp remove pi-b2-lean-lsp`. If it migrated the prior console entry, restore
only that entry's previous command/arguments/environment from `config.before.toml`
through the CLI; do not replace the entire configuration file. For a new LSP
installation, verify it is still the task-owned 0.33.0 tool before running
`uv --no-cache tool uninstall lean-lsp-mcp`. A reuse-only run owns neither the
pre-existing tool nor skills and must not remove them. Keep source snapshots
and backups until rollback is verified; then remove only this run's state.
