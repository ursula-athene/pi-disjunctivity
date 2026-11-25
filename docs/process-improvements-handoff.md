# Process improvements handoff — 2026-11-25

## Baseline and authorized endpoint

Baseline `563ffed` on `feature/attempt-05-b2`, two existing commits ahead of
its tracking branch. Preserved unrelated Obsidian workspace/hotkeys, notes, and
papers. The user initialized a root `uv` scaffold during the session; its
Python project/lock are used for these tools, while the generated `src/`
placeholder remains untouched and outside the task scope. This milestone implements the proposals in the
[B1 retrospective](retrospectives/retrospective-2026-11-25-b1.md), preserving that
original dated record. Scope includes guidance, tools, CI, prompts, and evidence;
it excludes B2, Lean changes, permission changes, and new Lean dependencies.

Implementation covers the five durable rules, mandatory consolidated Gemini
procedure, document responsibilities, project memory/handoff conventions,
offline documentation checker, scoped review preparation/capture inspection,
CI integration, current-prompt consolidation, and lightweight evaluation.
The milestone is complete: validated, reviewed, committed locally, and checked
for necessity. No push, PR, or B2 execution occurred.

## Contracts and indexing

No mathematical statement, theorem, proof, or dependency pin changes. B2 prompt
steps 2–4 retain their exact text: natural indices, inclusive prefix through
`n`, tail from `n+1`, real division, retained `HasSum`, independent recurrence
`y(0)=0`, and orbit index `n` versus recurrence `n+1`. It still requires updating
the proof plan before implementation, authorizes full B2 only when invoked, and
ends before B3. Archived prompts and earlier handoffs/log entries remain dated
snapshots. See the [B2 contract](proof-plan.md#next-bounded-task-b2-complete-orbit-bridge).

## Acceptance evidence and limitations

The [tools guide](process-tools.md) documents `uv` setup, tests, checker scope,
review capture fields, and temporary retention. Unit fixtures exercise real
failure modes, including stale but valid anchors, valid history, exact staged
scope, empty SUCCESS, errors/timeouts, missing exits/results, denials, and capture
truncation. CI configuration checks preserve the Lean build/audit and wire the
offline checks; they do not claim a remote CI run.

No Lean file changes, so no new Lean build or axiom-audit run is claimed for
this process-only milestone. Local validation passed 23 unit tests in a fresh temporary uv environment,
40 Markdown files including task-owned untracked additions, and whitespace
checks including each new file. Preservation checks passed for 61 baseline
files outside scope, the exact B2 steps 2–4, the mathematical roadmap from
Step 1 onward, all blueprint remaining-route hypotheses, archived prompts,
the earlier research-log prefix, and existing CI build/docs jobs. The moved
Gemini procedure preserves the original text, with only heading/link relocation.

An initial mixed `git add && uv ...` execution was denied when creating
`.git/index.lock`. Investigation found the existing repository Git allow rule;
a standalone `git add` succeeded with the same settings. The earlier diagnosis
of a general staging blocker was premature. No permission or configuration
changed. Keep Git mutations separate from other programs when using that rule.
The scoped preparation utility then produced the same per-file patches as the
initial read-only review input (only file order differed).

Carbon High's full review returned explicit no findings; see the
[review record](agy-reports/process-improvements-review.md). Caller inspection
also tightened the historical sibling-link exception against traversal back
out of that directory, with a regression assertion. The focused follow-up and
local commit/necessity outcomes are recorded below. Raw temporary review captures
are not guaranteed archival storage. No quantitative productivity gain is claimed.

## Restart and remaining obligations

Use [the session entry point](proof-attempt-session-prompt.md),
[proof plan](proof-plan.md), and [blueprint](proof-blueprint.md) after verifying
the actual checkout. B2/B3, V, Hπ, T, and π disjunctivity remain unproved.
B4 retains vanishing error and arbitrarily late visits; P3 retains open-interval
visits. No current B2 prompt was executed here.

New-document checks require staging owned additions first. Mark active prompt
links within paragraphs; historical archive links need no active marker.
Inspect full saved review output and findings yourself even when the utility
exits zero. Keep the actual `agy` invocation literal, outside wrapper scripts.
Future measurement fields are specified in the [meta-plan](meta-proof-plan.md#lightweight-evaluation),
not another status store. No global memory/configuration changes were made.

## Final review and acceptance

Both Carbon High reviews completed with explicit no findings. The follow-up
covered the resolved sibling-path check, regression assertion, Git rule, and
corrected records. See the linked report for both exact diff hashes and full
limitations. Two invocations took 347.101 and 225.375 seconds by caller clocks;
both raw captures are complete. Prior conversation persistence was unavailable,
so the CLI started a new follow-up conversation with the supplied scope/context.

Final validation passes: 23 unit tests (including CI wiring), 41 tracked Markdown
files including staged additions, working/staged whitespace, 61 preserved
baseline files outside scope, unchanged mathematical contracts/archives/pins,
and exactly 24 staged task-owned paths. No remote CI or new Lean audit is claimed.

## Local commits and post-commit necessity review

Implementation commit: `3ef470c6aced848edd7675e28fc9b5f99d92f3c0`, parent
`563ffed22c8dea726a95f71eb37e081ce9974f76`. Only the 24 task-owned paths were
committed on the existing branch. Both earlier local commits are preserved.

Inspected the committed utilities, test coverage, CI/project configuration,
AGENTS, and documentation changes. Each utility has one consumer-facing job:
validate local docs/current entry, prepare an exact scoped patch, or inspect
review transport/results. The parser dependencies avoid a bespoke Markdown/YAML
framework; the historical exceptions are narrow and tested. Required Gemini
operations have one mandatory home, with compatibility anchors and short links
elsewhere. Snapshot records preserve evidence instead of creating another live
status store. No unnecessary layer, unused API, or justified further substantive
simplification was found; no empty code commit or extra review was needed.

This handoff and the concise log entry receive a separate factual receipt commit.
Its ID can be retrieved with `git log -1 --format=%H -- docs/process-improvements-handoff.md`.
Both IDs are reported in the final session reply. The receipt is checked for
links, whitespace, exact owned scope, and preservation before commit. The tested
and reviewed utility/CI code is unchanged. Remaining work is mathematical B2/B3
and visitation as listed above, outside this completed process milestone.
