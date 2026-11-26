# B2 improvement milestone review — 2026-11-25

Baseline `e83580e79923cd6672de8b7e6c6043321d0a26b6`; sole specification:
[the P0–P5 plan](../b2-process-tool-improvement-plan.md). This reviews process and
bounded tool/skill evaluation, not new B2/B3 proofs. Mathematical contracts and
protected files remain unchanged. The [handoff](../b2-improvements-handoff.md)
owns publication/necessity status; [evaluation](../b2-tool-evaluation.md) owns
installation, cases, decisions, and rollback.

## Required guides and scope

P1 uses the full [strategy/tooling guide](../code-reviews/lean-proof-strategy-and-tooling-review.md),
SHA-256 `c4a04d75a297c6ec361d31ab11e465e3c3e74a6c89eb590bddb03d95c243ad3b`.
Final review also uses the [Lean proof guide](../code-reviews/lean-adversarial-review-prompt.md),
SHA-256 `798c3cc974c5296453f510ea9264aa8b5d17c813c8dc217a430de9b68b7d667c`,
for the existing argument/source-contract evaluation. The tooling guide governs
the workflow/software decisions. Both preserve read-only file tools; caller
builds, protocol calls, and hash comparisons are receipts, not reviewer execution.

## P1 intermediate review

Exact eight-file index diff prepared with `tools/prepare_review.py` under
`/tmp/pi-b2-tools-20261125/p1-review/`, SHA-256
`274278551ab91b67650d83b1cca52d5bfb5a96f9bea0b3c015a3d48218435455`.
Scope: Gemini procedure, proof workflow, handoff template, process-tools guide,
active entry point, session prompts, meta-plan, and interim implementation handoff.
The exact diff and baseline/check receipts were supplied inline. New tool/skill
adoption was explicitly not claimed at this checkpoint.

Invocation retained the literal
`agy --model gemini-4-carbon-high --mode plan` prefix,
`--output-format stream-json --print-timeout 20m`, and
`--log-file /tmp/pi-b2-tools-20261125/p1-cli.log`.
Conversation `5ee15d04-06c7-4629-ab13-fa6740da1eef`, model confirmed High.
Caller start/final collection: 2026-11-26 02:52:31.476–03:00:56.934 UTC,
505.458 seconds including collection delay; CLI duration 486.645 seconds.
File-tool events continued through the early portion, then several minutes
of silence before response deltas. Silence was not treated as a proven stall.
Eleven unchanged chunks `p1-capture-000.json` through `-010.json` retain the
full stream; total reported capture tokens 47,027, largest chunk 33,418 against
its 60,000-token budget (initial budget 50,000). No truncation or recovery.

`inspect_review.py --attest-complete` passed: complete capture, exit 0,
nonempty terminal SUCCESS, no structured errors/denials. Optional `error`,
`finished_reason`, and `denied_actions` fields were absent. The caller inspected
the entire result. Carbon explicitly read the required guide and all eight
post-images, verified their agreement with the inline diff, and performed a
semantic status comparison using read-only files. It accepted this checkpoint.

Separately inspected the 364-line CLI log. Initial auth/cache warnings were
followed by successful authentication. Crash, summary, artifact, conversation,
cache, and refreshed-token persistence were denied; environment-path/admin-cache
warnings also occurred. No reviewer file tool was denied. Log separation kept
the terminal JSON intact, verifying inherited I6 on this required run; it did
not solve persistence. Inspector diagnostic count zero describes the chunk
stream, not this separate log. Raw log SHA-256:
`e660cc51d7e3f87df507ca0e99896cb3b42a583c81b6ed023bbdd4846ca91110`.

### P1 items and dispositions

Original categories retained: **zero defects**, four nonblocking improvements,
two nonblocking questions. The complete milestone review below verified all
four implemented improvements; no extra benchmark review was run.

| Item | Original recommendation | Disposition / evidence |
| --- | --- | --- |
| P1-I1 | Prefer inline diff/evidence outside reviewer access; prohibit retrying denied reads through another tool. | **Implemented:** canonical procedure and short process-tools cross-note. Prevents an avoidable denied-file/capture failure; verified by final review. |
| P1-I2 | “Including for scratch files” ambiguously applied production headers/root exports/staged reviews to disposable probes. | **Implemented:** workflow separates scratch trust/pin/import rules from production conventions. Same-session probes remain fully proved; wording verified by final review. |
| P1-I3 | Inspector ignores `--log-file`; approval-check example lacked that option. | **Implemented:** process guide explicitly requires separate inspection; literal approval-check example updated. Actual rule check included the flag and returned allow. This run demonstrates why zero stream diagnostics is insufficient. |
| P1-I4 | Avoid stacked interim status entries/adoption-presupposing wording; include decisions and tested fallback in template. | **Implemented:** rewrite the execution section in place as the evaluation entry, conditionalize skill adoption, extend template decision/fallback field. Future interim status stays in the existing handoff rather than another meta-plan section. Housekeeping with concrete status-maintenance benefit. |
| P1-Q1 | Preserve temporary P0 hashes and pre-LSP/license/semantic receipts through P5. | **Implemented observations:** baseline replay existed before LSP; both clone/license/resource reviews preceded use; interim protected/unrelated/config hash comparisons passed. Durable evaluation records the commands/cases. Final preservation comparison passed before commit; temporary raw retention is explicit. |
| P1-Q2 | Observe useful corrections versus review/reporting cost using actual required reviews. | **Implemented for P1; carried forward:** timings/capture above, usefulness distinctions below, and final-review observations in this report/retrospective. This is one milestone; the active meta-plan retains the next authorized milestone as a second sample. No detection-rate claim. |

Inherited guidance items retain their historical record in the
[Carbon guidance report](carbon-review-improvements-review.md). Its I6 is now
implemented and operationally tested; its Q2 remains an observation program,
not a measured benefit. Other historical items are not relabeled as new findings.

## Complete milestone review

Exact 16-file index diff against the same baseline, prepared under
`/tmp/pi-b2-tools-20261125/final-review/`, SHA-256
`9815a6f7edeed383d82106938fce4741aa3a4c339392d6e639905c03b98225c9`.
Scope is the eight P1 files plus README, the specification's execution/I6 notes,
tool evaluation, this review report, retrospective, research log, and two
original skill sources. The packet includes all caller checks and prior items.

Used the same literal High/plan prefix, stream JSON, 20-minute deadline, and
`--log-file /tmp/pi-b2-tools-20261125/final-cli.log`. The supplied P1 conversation
was unavailable; a complete resupplied packet started conversation
`c3387f92-39d2-4c82-a8df-2d06586a5b2c`, model confirmed High. Caller span:
2026-11-26 03:10:29.757–03:17:46.560 UTC, 436.803 seconds; CLI 435.329 seconds.
Eight unchanged chunks `final-capture-000.json` through `-007.json`, total
reported capture tokens 38,701, maximum 25,245 below the 60,000 poll budget.
File reads were followed by silence and then response deltas; no overlap,
timeout, truncation, recovery, or reviewer tool denial occurred.

Inspector passed with complete capture, exit 0, substantive SUCCESS, and no
structured errors/denials. Optional terminal error/termination/denial fields
were absent. The sole stream diagnostic was the unavailable-conversation
warning. Separately inspected all diagnostic families in the 419-line CLI log:
initial auth/cache warnings followed by successful auth; crash, summary,
artifact, conversation/cache persistence and environment-path warnings remained.
Log SHA-256 `cf88f03f630b26fe5fcd4650d40724a14aa9c0810dd1dad9f85858677dbd93fe`.
No log message established omitted reviewer coverage or failed file access.

Carbon explicitly confirmed both full guides, all sixteen post-images against
the inline diff, and relevant Lean/source contracts. It accepted implementation
and evaluation with explicit deferrals, verified P1-I1–I4, and retained the
caller/reviewer execution distinction. No new proof or actual host adoption
was claimed. The caller inspected the entire response and accepted its coverage.

| Item | Original category / recommendation | Disposition |
| --- | --- | --- |
| Final-I1 | Nonblocking, later host activation: test partial stems from an import-only root probe against `rg`, verify Elan on server PATH, clean snapshot/root probes and verify descendant shutdown. | **Deferred:** current LSP adoption is already deferred. Known-name/index-warming results do not establish unseeded discovery. Perform the suggested import-only `hasSum_nat_add` / `nat_add_iff` comparison, PATH and cleanup checks during the next permitted activation trial; the handoff carries the trigger. No additional benchmark run now. |
| Final-I2 | Nonblocking, before paper-skill catalog installation: make B1 assessment reads conditional and test transfer on one already-cited Step 4/5 source claim with a disposable type check. | **Deferred:** current bounded evaluation used only B1 and has exhausted its single revision/retest; catalog adoption is deferred. Conditional source routing plus a separately authorized, already-cited source case is the reconsideration trigger in the handoff. This recommendation grants no B3/V research scope. |
| Final-Q1 | Open evidence question, acceptance-blocking before commit: fill final receipts, inspect captures/log, rerun affected docs/whitespace/preservation checks, then commit/necessity/push. | **Implemented:** receipts and complete dispositions recorded here and in handoff/retrospective; final affected documentation, working/staged whitespace and preservation checks passed before the standalone commit. Commit and necessity facts are recorded only after they occur. No prospective publication claim. |

Whole cycle: **zero defects**, four P1 improvements implemented and verified,
two final improvements deferred with active restart pointers. P1-Q1/Q2 and
Final-Q1 are addressed by evidence/receipt completion and passing final checks; broader effectiveness and
host/skill activation remain expressly unmeasured or deferred. Receipt updates
and deferral pointers introduce no substantive implementation fix requiring
another review; required validation still gates committing them.

## Cost and usefulness observations

P1 supplied concrete operational corrections (I1–I3), while I4 reduces status
housekeeping. No proof defect was found; this was a process review. The response
was substantially longer than the requested concise format, and capture output
included many small deltas. Time/capture counts are observable cost proxies;
price, detection rate, and total human/agent triage time were not measured.
The final review requested a 700-word target without reducing scope, guides,
effort, or categories. Counting response prose with Markdown links replaced by
labels gives 679 words versus P1's 1,451; the final response met that target.
Transport capture was also smaller (38,701 versus 47,027 tokens). These are
observations from different scopes, not a causal efficiency comparison. No reporting requirement was waived.

## Retention and caller checks

All raw prompts, exact scope JSON/diffs, unchanged capture chunks, CLI logs,
full terminal responses, and inspector reports are under
`/tmp/pi-b2-tools-20261125/`. Temporary files and denied conversation persistence
are not a durable raw archive; this report retains findings and limits.
P1 caller checks passed: baseline Lean build/audits, all 23 offline process tests,
53-file documentation check, and both whitespace checks. Final pre-review checks also passed: `lake build`, `lake env lean Test.lean`,
23 process tests, 58-file doc check, both skill validators, separate working/staged
whitespace checks, and protected/unrelated/config/clone preservation comparison.
Later acceptance receipts belong in the handoff/final section. No remote CI or fresh-host run.
