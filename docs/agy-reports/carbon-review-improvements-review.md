# Carbon review guidance review — 2026-11-25

## Scope and review background

Baseline: `02c89a3b04ebf629d90ccfc5f694c923c6a8edcc`.
This documentation-only task integrates the user-supplied adversarial guides,
separates defects/improvements/questions, records every item's disposition,
and preserves scope, trust, read-only tools, and the mandatory review lifecycle.
No new proof, tool installation, or proof-research result is under review.

Required background: [strategy/tooling guide](../code-reviews/lean-proof-strategy-and-tooling-review.md),
initial SHA-256 `34f6c7d3654b464df0253a7c09c5dd28437cc7847f025e84f15013af49a8a3ca`;
after I1/I3, SHA-256 `c4a04d75a297c6ec361d31ab11e465e3c3e74a6c89eb590bddb03d95c243ad3b`.
The [Lean proof guide](../code-reviews/lean-adversarial-review-prompt.md) is also
a changed document to inspect, SHA-256
`798c3cc974c5296453f510ea9264aa8b5d17c813c8dc217a430de9b68b7d667c`.
These hashes identify the proposed guide contents, not the baseline versions.
Both were supplied in full initially and Carbon explicitly confirmed reading
them with file tools. The strategy guide informs this review-procedure task;
the proof guide is inspected as changed documentation, not a new proof review.

## Initial invocation and capture failure

The exact 13-file staged diff was prepared with `tools/prepare_review.py` under
`/tmp/pi-carbon-guidance-review-20261125/`; SHA-256
`9e0ce06f72a314f6ef0df744d77e6c1dd52798981c469e929cd10328033afd03`.
Scope: `AGENTS.md`, both adversarial guides, `docs/gemini-review.md`,
`docs/b2-process-tool-improvement-plan.md`, `docs/meta-proof-plan.md`,
`docs/proof-plan.md`, `docs/proof-workflow.md`, `docs/process-tools.md`,
`docs/handoff-template.md`, `docs/research-log.md`, this report, and the handoff.

Invoked the literal `agy --model gemini-4-carbon-high --mode plan` prefix with
`--output-format stream-json --print-timeout 20m` and the exact diff inline.
Conversation `25477f63-9b99-4adc-b7b6-780d8bfbb61e`, model confirmed High.
Caller timestamps: 2026-11-26 01:54:44.711–02:05:27.837 UTC (642–643 seconds;
local date 2026-11-25). File-tool events were followed by several minutes
without visible review progress, then response deltas; silence did not establish
a stall. The process exited zero.

All 16 execution chunks were saved unchanged as
`/tmp/pi-carbon-guidance-capture-000.json` through `-015.json`, with 50,000/60,000
token capture budgets. Largest reported chunk: 55,701 tokens; no transport
truncation reported. Prompt: `/tmp/pi-carbon-guidance-review-prompt.txt`.
The raw inspector **failed**: a shutdown stderr line was inserted inside the
terminal JSON response, producing a malformed event despite its visible SUCCESS
status. Inspection: `/tmp/pi-carbon-guidance-inspection.json`. Raw chunks remain
unchanged. `/tmp/pi-carbon-guidance-reconstructed-result.json` removes that one
identified log insertion for triage only; it is not a passed raw-capture check.

Diagnostics also report sandbox-denied log, summary, conversation/cache, and
refreshed-login-token persistence. Authentication and file reads succeeded;
these warnings do not establish a reviewer tool denial or a service stall.
The visible result contains a substantive response and no error, termination,
or denied-action fields. Its five improvements and two questions are retained
below. The valid focused recovery below restores final acceptance coverage;
the original capture failure remains part of the cycle record.

## Items and dispositions

Original Carbon categories are retained: **no defects**, five initial nonblocking
improvements, and two questions; recovery added one improvement, I6.
No severity/category was changed by the caller. Five improvements are implemented
and verified by recovery, I6 and Q2 are deferred, and Q1 is closed by the receipts
and final checks. No acceptance-blocking issue remains.

| Item | Original recommendation / evidence | Disposition and verification |
| --- | --- | --- |
| I1 | Routing summaries omitted proof-strategy wording and left prose mathematical arguments ambiguous. | **Implemented:** `AGENTS.md` and the strategy guide name proof strategy; `gemini-review.md` assigns both guides to prose route/source-proof/M4 argument reviews. Doc checks and focused follow-up cover the clarification. |
| I2 | A later-milestone suggestion recorded only in an old report could become undiscoverable. | **Implemented:** cross-milestone deferrals require an active-plan pointer and trigger, or the next-session restart handoff; the report owns the full record. Q2 exercises this rule. |
| I3 | Unconditional verdict/obligation/tooling sections could force irrelevant or untracked recommendations. | **Implemented:** scope-conditional questions/tables and ID references for recommendations throughout the strategy response; the procedure requests concise evidence without repeating instructions/history. |
| I4 | The follow-up template said “apply” without explicit reads, despite unreliable conversation persistence; closing evidence fields and incomplete-output recovery were implicit. | **Implemented:** explicit guide reads, guides/checks-versus-receipts in both templates, and the same bounded-recovery allowance for missing required guides/categories. |
| I5 | Handoff instructions duplicated report-owned details, and P1's response-order bullet differed from the procedure. | **Implemented:** handoff owns a cycle summary and report link; P1 uses brief verdict, categorized items, then closing coverage. |
| Q1 | Pre-review receipt placeholders must be populated and checked before final commit; acceptance-blocking until then. | **Implemented:** both invocation records, recovery inspection, all dispositions, and caller validation are recorded here. The handoff records publication and the post-commit necessity review when observable; no prospective commit is claimed as already made. |
| Q2 | Detection benefit versus latency, capture budget, and triage overhead is unmeasured; nonblocking for this documentation task. | **Deferred:** actual later milestone observations are needed. The [active evaluation pointer](../meta-proof-plan.md#lightweight-evaluation) schedules review during remaining P1 and its next retrospective, using the next two authorized milestone reviews without extra benchmark runs. Counts/examples describe cost and usefulness, not a detection rate. |
| I6 | Recovery suggested adding the supported per-invocation `--log-file` option to the standard initial/follow-up templates to prevent recurrence of stderr/JSON interleaving. | **Deferred to remaining P1:** this run supplies positive evidence, but persistent templates and log-retention instructions should be changed together. The [P1 pointer](../b2-process-tool-improvement-plan.md#p1--implement-the-process-improvements-first) carries the trigger. Keep the literal prefix, inspect both logs and JSON, and verify on the next authorized run. This run does not prove that all stderr is suppressed; artifact/conversation persistence warnings remained in the separate log. |

## Focused recovery and follow-up

The single recovery ran after the initial process ended, also checking I1–I5
and Q1/Q2. Prepared all 13 final files against the same baseline under
`/tmp/pi-carbon-guidance-recovery-review/`; diff SHA-256
`40b8742a353d769c5e2beb8f26e11443fa70423707f74d544e015281d1e0b6e1`.
The literal High/plan prefix, stream JSON, and 20-minute deadline were retained.
After verifying `agy --help`, added
`--log-file /tmp/pi-carbon-guidance-recovery-cli.log`, with no shell redirection
or permission changes. The supplied prior conversation ID was unavailable;
the CLI started `f20bb2f0-98db-4f07-951b-ae5e5250770e` with complete context
resupplied in `/tmp/pi-carbon-guidance-recovery-prompt.txt`.

Caller timestamps: 2026-11-26 02:09:11.769–02:15:56.313 UTC, about 404.5 seconds.
File reads progressed through roughly 130 seconds; response events arrived by
391 seconds. Model confirmed `gemini-4-carbon-high`. All 11 unchanged chunks
are `/tmp/pi-carbon-guidance-recovery-capture-000.json` through `-010.json`;
largest reported chunk 25,074 tokens, below its 60,000-token budget.

`tools/inspect_review.py --attest-complete` passed with complete capture, exit
zero, nonempty SUCCESS response, no structured errors/denials or capture issues;
report `/tmp/pi-carbon-guidance-recovery-inspection.json`. Optional terminal
`error`, `finished_reason`, and `denied_actions` fields were absent, not fabricated.
The only diagnostic in the captured stream was the unavailable-conversation
warning. Separately inspected the 340-line CLI log: startup auth/cache messages
were followed by successful silent authentication; sandbox-denied crash,
summary, artifact, presence, and conversation/cache persistence remained.
Also observed nonessential environment-path, updater, and admin-cache warnings.
No reviewer read failed or requested shell/write tools. Log separation kept the
terminal JSON intact in this invocation; it did not repair persistence.

Carbon explicitly confirmed reading both complete guides and examining the
whole final diff. It accepted I1–I5 as implemented, Q2's deferral as appropriate,
and identified only expected receipt completion Q1 plus new later-work I6.
The caller inspected the entire response, including closing recommendations,
and accepted its restored coverage with the limits recorded here. No further
review run is required for factual receipts and the I6 deferral pointer.

## Caller validation

- `uv --no-cache run --locked --offline python -m unittest discover -s tests -v`:
  all 23 tests passed before review; no Python/CI changes followed.
- `uv --no-cache run --locked --offline python tools/check_docs.py`:
  52 tracked Markdown files passed before review, after I1–I5/Q2 refinements,
  and for final receipt/deferral updates. A mistyped new P1 anchor was corrected
  during final receipt validation before the passing rerun.
- `git diff --check` and `git diff --cached --check`: passed before review;
  passed again after refinements and final receipt updates before commit.
- Manual routing/status checks distinguish proof, tooling/meta-plan, and mixed
  work; preserve High/read-only/trust rules, future improvement scope, and open
  mathematics. No Lean build, tool installation, or effectiveness claim.

## Evidence and remaining scope

Carbon inspected documents with read-only file tools; its checks of links and
consistency are separate from caller-executed tests, Git state, and hashes.
Raw captures, prompts, and CLI logs are temporary; conversation persistence was
denied. This committed summary retains the findings and limitations, not a
durable raw archive. No remote CI or clean-environment validation is claimed.
The [handoff](../carbon-review-improvements-handoff.md) records the authorized
endpoint, preservation, outstanding mathematical obligations, and publication.
