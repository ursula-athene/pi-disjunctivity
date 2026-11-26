# M4 persistence instruction review — 2026-11-26

## Scope and acceptance

Process-only correction requested by the user after the initial M4 research
stopped too early. Baseline `b20e1b34f08e73ce16389637ebcf52700b8f452a` on
`feature/m4-universal-visitation`. The intended change distinguishes bounded
experiments from continued milestone authorization, permits discovery without
an existing candidate, and preserves continuation context. Mathematical
contracts, proof status, Lean files, pins and scope exclusions are unchanged.
No new runtime, tool installation, global memory or review exemption is proposed.

Final owned scope: `AGENTS.md`, `PROGRESS.md`, `README.md`, `docs/gemini-review.md`,
`docs/handoff-template.md`,
`docs/meta-proof-plan.md`, `docs/proof-attempt-session-prompt.md`,
`docs/proof-plan.md`, `docs/proof-workflow.md`, `docs/session-prompts.md`,
`docs/m4-handoff.md`, `docs/research-log.md`, `docs/proof-blueprint.md`,
`docs/m4-visitation-obstruction.md`, this report, and
`docs/retrospectives/retrospective-2026-11-26-m4-persistence.md`.
Unrelated Obsidian configuration, notes and papers are excluded.

## Caller checks

Manual scenario inspection of the instructions:

| Situation | Required behavior |
| --- | --- |
| A candidate is refuted | Preserve the witness, suspend that route and choose a different inquiry. |
| No proof idea survives | Investigate unused structure or a failed bridge; discovery needs no preexisting estimate. |
| A self-selected quota expires | Reassess and state the next bounded cycle within the same authorization. |
| A required review fails | Follow its existing recovery limit, stop acceptance and continue useful independent work if available. |
| User stops or a binding resource limit is reached | Respect it; retain an honest incomplete continuation record. |
| Context resumes | Restore the target, evidence, failed approaches and next question; verify the checkout. |
| Only a conditional reduction is obtained | Retain its hypotheses; V/M4 stays incomplete. |

Caller validation: 38 offline process tests passed; documentation checker passed
for 70 tracked Markdown files; working/staged whitespace checks passed. The
commands used `uv --no-cache run --locked --offline` with the workflow's unittest
and documentation entry points. Protected Lean sources, audits, dependency files
and pins have no diff. A direct comparison preserved the archived prompts,
exact V text, and historical log/handoff bodies (apart from the handoff's new
supersession notice and appended follow-up). Only the twelve owned paths are
staged for the initial review; the follow-up also covers three small orientation
corrections in README, blueprint and assessment. The host's literal Carbon
command prefix check returned `allow`.
Lean builds were not rerun for these documentation-only changes.
These checks can establish document consistency, not future persistence or
mathematical discovery effectiveness; those behavioral effects are unmeasured.

## Carbon review

Initial scope: twelve paths, SHA-256
`ada30b397b596d8b15fe55fb3a64d9e93f6acce724b4d8491847a422180bf23e`,
against the baseline above. Carbon High (`gemini-4-carbon-high`, plan mode)
conversation `3865bde9-9acb-4eb8-9020-5fd20ca3a18b` returned substantive SUCCESS,
exit 0, in 493.411 seconds CLI runtime (498.138 seconds through the final
caller capture). No retry, denial, error result or capture loss occurred.

The complete strategy/tooling guide
`docs/code-reviews/lean-proof-strategy-and-tooling-review.md` and Gemini procedure
were supplied at unchanged baseline revision `b20e1b34f08e73ce16389637ebcf52700b8f452a`,
alongside the complete modified AGENTS. The reviewer explicitly confirmed
reading/applying them, inspected all scoped paths and relevant surrounding
records with read-only file tools, and assessed instruction consistency.
No new mathematical argument was proposed, so the proof guide was not required.
Git, Python, archive/contract preservation and test execution remain caller
receipts, not reviewer-executed checks.

The full response was inspected: no defects or open questions; three
nonblocking improvements. Dispositions:

| Item | Original recommendation | Disposition |
| --- | --- | --- |
| I1 | Qualify the residual Step 5 deliverable and restart pointers; optionally label the old assessment and align adjacent entries. | Implemented: Step 5 now requires unconditional proof through acceptance and distinguishes an interruption checkpoint; PROGRESS/plan/README/blueprint pointers and the assessment's supersession notice agree. No mathematical assessment body changed. |
| I2 | Permit uncommitted interruption records rather than ending research early to reserve review/commit time; put per-cycle questions in the research log. | Implemented in workflow/current prompt and the plan's named log destination. Unreviewed work cannot be committed or accepted. |
| I3 | Make countermodel separation explicit, use authorized fresh-context ideation after two same-gap cycles, and keep refinements canonical. | Implemented with adaptation in the meta-plan only: name the distinguishing invariant or test for it; repeated cycles without new learning trigger a change in the source of ideas, using authorized/available fresh-context help or a separate reconstruction. The fixed two-cycle threshold is declined: no evidence calibrates it, and informative repeated failures should not automatically trigger extra agent cost. Existing authorization limits remain. Other files link to the canonical protocol; short scope-specific summaries remain where needed to replace contradictory clauses. |

The review's note that behavioral effects need observation is retained: those
effects remain unmeasured in continued M4 research, which is already authorized;
no new invocation is required within that scope. Its request to replace pending
receipts and rerun affected checks is part of finalization below.

Initial raw evidence: `/tmp/pi-m4-persistence-review-20261126/` contains the exact
diff/scope, full prompt, thirteen lossless capture chunks, `inspection.json`
and `initial-cli.log`. The inspector passed with complete capture and no errors
or denials. CLI-log inspection found transient startup authentication/cache
warnings followed by successful silent authentication, an optional `cs` path
warning and a default-directory fallback; none blocked the file-only review.
Raw files and conversation persistence are temporary, not a durable archive.

The Carbon follow-up covered the fifteen-path index hash
`b92fcc49507bd54986b04af0333d3d7a7db97a9f764755d27ba2d707e8104b71`.
During its response the user directed an immediate stop and replacement with a
Codex subagent. SIGINT ended the invocation with exit 1, `status: ERROR`,
`error: interrupted`, and `finished_reason: interrupted`. Its partial favorable
verdict is not a completed review. Raw evidence is retained under
`/tmp/pi-m4-persistence-followup-20261126/`; the last capture preserves the
interruption. No Carbon recovery or further invocation is authorized.

## Completed replacement review

The current reviewer override is recorded in AGENTS, the review procedure and
current prompt. Separate Codex subagent `/root/persistence_review` completed
review of all sixteen paths, including that override, against baseline
`b20e1b34f08e73ce16389637ebcf52700b8f452a`, SHA-256
`1dd0a1067786d4bd18ec801c5dae994296c2f0fd0d168804141cb39348e87ede`.
It independently checked the frozen patch and staged-diff hashes and read all
required instructions and surrounding records. The strategy guide was unchanged;
its hash is `c4a04d75a297c6ec361d31ab11e465e3c3e74a6c89eb590bddb03d95c243ad3b`.
Full returned review, frozen patch and scope are retained in
`/tmp/pi-m4-persistence-subagent-20261126/`; the response is `review.md`.
Subagent elapsed time was not measured. No review retry was needed.

The full returned response was inspected: D none, I none additional, Q none
affecting policy consistency. It verified the I1/I2 implementation and accepted
the explained I3 adaptation, while retaining unmeasured behavioral effectiveness.
Its checks were read-only files, hashes, scope/status and protected-source diffs;
no builds, tests, services, probes or Git mutations were run by the reviewer.
It supplied no additional recommendations outside those categories.

Whole cycle: no defects; three initial improvements addressed (I3 with the
fixed-threshold subproposal declined for the recorded reason); one Carbon
follow-up interrupted at the user's request; replacement review complete with
no further findings or acceptance-blocking questions. This accepts the process
correction after caller checks, not M4 or any visitation theorem.

The 38 process tests passed after I1–I3 edits. Documentation (70 files) and
working/staged whitespace passed again after the reviewer override. A cached
`lake build` also passed (7205 jobs) while preparing resumed M4 research;
it is not evidence of new mathematics. Final factual receipt updates receive
documentation/whitespace checks rather than another substantive review.

## Local commit and necessity inspection

Process correction commit `dacbd3c0ce44313afe405d8efdccdcbbe6dfe2a9` is local
on `feature/m4-universal-visitation`; no push or PR was performed. Post-commit
inspection confirmed the sixteen owned paths and exact working-tree postimages,
with unrelated Obsidian/notes/papers still outside the commit. Policy lives in
the meta-plan, operational rules in the workflow, current scope in the prompt,
and review/history evidence in their existing records. No new tool, proof API
or substantive simplification was warranted. The separate factual receipt
commit is identifiable with `git log -1 --format=%H -- docs/agy-reports/m4-persistence-review.md`.
Final `lake env lean Test.lean` also exited 0. M4 remains open and research
continues under the user's instruction; this local process commit is a checkpoint.
