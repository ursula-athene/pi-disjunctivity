# B3 process improvements and meta-plan rewrite — 2026-11-25

## Baseline and endpoint

User-authorized adoption of the [B3 retrospective](retrospectives/retrospective-2026-11-25-b3.md)
and a major edit of the [meta-plan](meta-proof-plan.md), extended during review
at the user's request with a protocol for finding new ideas when stuck. Baseline
`86fc08a679557acf968904bad5930610e4d10980`, branch `feature/attempt-08-b3`.
Preserve the pre-existing retrospective expansion, `.codex/config.toml`,
Obsidian changes, notes and papers. This task changes process documentation;
mathematical contracts, indices, Lean sources, audits and pins are unchanged.
It authorizes no new proof research, tool installation or permission changes.

The endpoint is all seven recommendations implemented in their owning
documents, a concise strategy for evaluating/revising the proof plan, required
documentation checks and Carbon review, and a local commit/necessity inspection.
Publication is local only; no push or PR is requested for this task.

## Adoption and acceptance checklist

| Retrospective recommendation | Implementation / evidence |
| --- | --- |
| 1. Read by dependency and question | Workflow's bounded reads and single acceptance checklist; required guides still read in full. |
| 2. Explicit worker delivery | Workflow requires immutable final scratch path, declaration names/types, verification receipt and completion signal before parent integration. Applies only when delegation is authorized. |
| 3. Choose proof feedback early | Workflow routes project goals to native tools and `/tmp` probes to shell Lean; suspicious results need hover/pinned-source corroboration. |
| 4. Focus required reviews | Review procedure uses one checkpoint question, exact scope and concise receipts; retains all guides, categories and mandated reviews. |
| 5. Observe progress | Both review templates request periodic updates at meaningful inspection boundaries and before long analysis; caller polling supplies regular timing without artificial task splitting. |
| 6. Reuse stronger audits | Workflow names established-object consequences and offset-sensitive downstream applications; B3's existing `Test.lean` examples supply concrete patterns without new duplicate tests. |
| 7. Reduce repeated status | Meta-plan now owns strategy, workflow owns execution, report/handoff own evidence; prompt-required `PROGRESS.md` stays a pointer. |

The meta-plan replaces obsolete pilot instructions and repeated B1/B2 histories
with a bounded evaluation loop, decision signals and tool-trial criteria. Old
incoming anchors lead to existing historical handoffs. The Q2 observation
request is closed using the actual B2/B3 review samples; ordinary receipts
continue, without claiming a measured speedup or detection rate.

- [x] Implement the seven recommendations and meta-plan rewrite.
- [x] Validate process tests, documentation, whitespace and semantic alignment.
- [x] Complete Carbon review, inspect captures/logs and disposition all items.
- [x] Inspect committed scope for necessity and record publication state.

Caller validation: `uv --no-cache run --locked --offline python -m unittest
discover -s tests -v` passed all 38 tests; the same prefix with
`python tools/check_docs.py` passed for 64 tracked Markdown files. Working and
staged `git diff --check` passed. The initial ordinary `uv run` commands exited
2 because the existing cache was sandbox-denied; the documented `--no-cache`
fallback passed without configuration changes. Manual comparison of README,
proof plan, blueprint, current prompt and the two `Test.lean` examples retained
current status and every conditional premise. Protected Lean/audit/pin diffs
were empty, and pre-existing files matched the task-start hashes.
The initial rewrite shrank from 3,066 to 987 words; the user-requested recovery
and TRIZ strategies plus review refinements bring it to 1,866 (39% below baseline). This is
a size measurement, not evidence of improved proving performance.

## Review evidence

This section owns the process milestone's review report, avoiding another
status document. Required background is `AGENTS.md`, `docs/gemini-review.md`
and the full [strategy/tooling guide](code-reviews/lean-proof-strategy-and-tooling-review.md).
No new mathematical argument or Lean change requires the proof guide.
Carbon uses High effort and read-only file tools; caller checks remain receipts.
Initial exact seven-file diff SHA-256:
`e145c3980bfc10a3d4fc2405bcd3477f53d2e95535b1cc23fa77f1d734835698`.
Conversation `6d933a34-e280-44fa-9d0f-50cad1bb8fc6`; exit 0, substantive
`SUCCESS`, 424.757 seconds CLI runtime / 426.159 seconds caller wall time.
All eight lossless chunks passed complete-attestation inspection. Raw prompt,
diff/scope, postimage hashes, captures, response, inspector and CLI log are in
`/tmp/pi-b3-process-vl8890f1/review/` (temporary). Only `read_file` was used.
The strategy guide was supplied in full and read from disk, unchanged at the
baseline revision; SHA-256 `c4a04d75a297c6ec361d31ab11e465e3c3e74a6c89eb590bddb03d95c243ad3b`.
All seven post-images and relevant status/audit/history context were inspected.

The log shows successful silent authentication after initialization warnings;
optional `cs`/plugin initialization and relative Gemini-directory fallback
messages did not deny review coverage. No persistence/summary-store errors
were detected; the conversation database existed after this tool-using review.
Terminal error/finished-reason/denied-actions fields were absent. Five inspection
updates were useful, but one analysis step lasted 243.737 seconds: no timed
heartbeat guarantee follows. No retry or missing capture occurred.

| Item | Original recommendation | Disposition |
| --- | --- | --- |
| I1, nonblocking | Remove the 45–60-second heartbeat target; retain boundary updates and caller polling. | Implemented: both templates request periodic meaningful-boundary/pre-analysis updates without artificial splitting. The user's progress-update requirement remains. The claimed internal timer mechanism was not independently verified; observed silence suffices to avoid promising a cadence. |
| I2, nonblocking | Guard against conditional wrappers posing as progress, and supply a decision for inconclusive bounds. | Implemented in the decision table and recovery protocol. Conditional probes can diagnose a route but do not move the frontier merely by repackaging its open premise. |
| I3, nonblocking | Reduce routine durable transcription of granular events, budgets and separate unchanged-guide hashes. | Implemented: compact receipts retain scope/model/conversation, wall time, capture/log outcome, guide revision, dispositions and retention limits; full raw capture/inspection remains mandatory. Anomalies and uncommitted guides retain relevant detail. |
| Q1, acceptance-blocking until finalization | Populate receipts/dispositions, inspect real-review persistence, complete commit/necessity review and final checks. | Resolved: both review receipts, dispositions, final checks and commit/necessity inspection are recorded here. |
| I4, follow-up nonblocking | Give TRIZ ideation workers concrete statements/structure/counterexample checks/bridges, with parent filtering before Carbon; suggested at most one surviving candidate. | Implemented as a minor clarification of the existing bounded-role and handoff protocol. The parent sends a focused candidate, with both guides for actual mathematical arguments. Unknown bridges remain explicit. A blanket numerical cap is declined because a discriminating comparison may need two candidates; breadth still needs a concrete purpose and bound. No new review cadence, agents or research are introduced. |

Focused follow-up reviewed complete-diff SHA-256
`544bf3a4f4173c8b228db1bbe58fc9f61ee536e3f5292e37d52b1dd5d2cd87ba`
and delta SHA-256 `e8aa4cc2ae78b9178be23c67d13bdbbb65731dc3cf426eb3a99994b8ea3e8dd2`.
It resumed the same conversation, exited 0 with substantive `SUCCESS`, and
took 196.141 seconds caller wall time; its CLI duration/usage were cumulative
and are not used as invocation timing. Five lossless chunks passed inspection;
only `read_file` was used, with the full strategy guide resupplied. The five
delta post-images and adjacent procedures were covered. External source checks
remain caller receipts. Raw evidence is in `/tmp/pi-b3-process-vl8890f1/followup/`;
final scoped preparation is in the sibling `final-scope/` directory.

Follow-up log inspection found the same harmless initialization warnings and
successful silent authentication, no persistence/summary-store errors, and no
coverage denial. A 170.393-second analysis step again exceeded the former timed
target; the caller continued polling the live session. Full response inspection
confirmed I1–I3 resolved, no defects or open questions, and the optional I4
clarification above. Final factual receipts require no further review.

**Whole cycle:** two successful invocations, no recovery retries or capture
gaps, no defects, three improvements implemented/rechecked and one subsequent
minor clarification implemented. No acceptance-blocking review question remains.
The procedure's compact receipts preserve full captures and inspections.

## Recovery strategy and evidence limits

The new section provides an obstruction note, a menu of mathematical heuristics,
targeted source connections, discriminating tests, fresh-context criticism and
a stopping/reopening rule. It separates useful diagnostic reductions from
discharging an open obligation and offers no automatic research authorization.
At the user's further request it includes a bounded TRIZ adaptation: conflicting
requirements, ideal result/resources, selected transformations, exact claims and
tests, with distinct subagent proposal roles and Carbon criticism when authorized.
The caller checked the Altshuller Institute overview and joint TRIZ Body of
Knowledge; engineering heuristics are not claimed to be validated for mathematics.
On 2026-11-25 the caller read Tao's relevant model/counterexample advice and
controlled-extension passages, Platt's original strong-inference prescription,
and the Sio–Ormerod incubation abstract, linked in the meta-plan. These inform
the methodology; they do not establish gains for this agent. No new π argument,
mathematical source-contract extraction, or visitation experiment was attempted.

## Persistence follow-up and limits

Before this task, the user authorized a writable-runtime configuration change.
A subsequent short Carbon High test saved conversation
`ad9dc46d-5ab2-4753-9893-c3e98548ee9c`; a separate invocation resumed that ID
and recalled a unique marker absent from its second prompt. Both exited 0 with
`SUCCESS`, no tool calls, and no detected persistence/summary-store errors.
The conversation database existed (524,288 bytes after recall). Raw evidence
is in `/tmp/pi-agy-persistence-nv1wvljr/`, which is temporary. This verifies that
test, not guaranteed future persistence, and does not retroactively restore
B3's missing conversations. The review procedure now distinguishes runtime
persistence from review completion and describes this optional diagnostic.

No Lean rebuild is needed for unchanged Lean/audit files. Process tests and
documentation checks establish mechanics, not productivity. No worker or new
proof cycle is run merely to exercise the new prose. Benefits and remaining
friction should be assessed during subsequent authorized work.

## Restart and remaining obligations

Implementation commit: `cfa0c4c58d29bf9b5ce4e0f4676270e896a9d20b`.
Post-commit inspection checked the seven-file scope, committed meta-plan and
procedure diffs for necessity, duplication and preserved contracts. No further
substantive simplification was justified; this receipt is the only follow-up.
Identify its commit with `git log -1 --format=%H -- docs/b3-process-improvements-handoff.md`.
Both commits are local only, with no push or PR. Final documentation checks
(64 files) and working/staged whitespace checks passed. The Obsidian workspace
changed externally during the task and was preserved; other pre-existing files
still matched the task-start receipt. No unrelated path was staged or committed.

Use the [current entry](proof-attempt-session-prompt.md) and
[proof plan](proof-plan.md); verify actual checkout state before resuming.
V, Hπ, T and π disjunctivity remain open. B4 retains vanishing error and
arbitrarily late visits; B3 discharges error decay, not visitation. P3 retains
open-interval visits. The next research decision should test a candidate's
central implication before substantial formalization, within separate scope.
Existing tool lifecycle and source-transfer limits remain in the
[tooling handoff](b2-improvements-handoff.md).
