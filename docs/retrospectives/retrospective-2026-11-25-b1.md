# B1 retrospective — 2026-11-25

This records the assessment and proposed improvements discussed after completing
B1. The user authorized saving and committing this retrospective; implementing
the recommendations remains a separate decision. No policy, meta-plan, workflow,
memory, tooling, prompt, or Lean change is made by this document, and it does
not begin B2.

Preparation baseline: `919f140` on `feature/attempt-05-b2`. This is a dated
assessment; use the [current prompt](../session-prompts.md) and actual checkout
for future work.

## Assessment and evidence

The mathematical decomposition and local Lean feedback loop worked well.
Observed friction concerned export visibility, elaboration and normalization,
review transport/capture, and maintaining consistent status across documents.
The records do not support a quantitative claim about overall productivity or
which activity consumed most of the total session time.

B1/M2 finished with the unconditional theorem

```lean
HasSum (fun j : ℕ => bbpCoeff j / (16 : ℝ) ^ j) Real.pi
```

and 27 guarded theorem audits in total. Lean/Mathlib remained pinned to
`v4.37.0-rc1`, and the Mathlib-only dependency and proof-trust policies were
preserved. B2/B3, universal visitation, and π disjunctivity remained unproved;
the existing B4/P3 results retained their hypotheses.

Evidence comes from the [source assessment](../b1-source-proof-review.md),
[B1a handoff](../b1a-handoff.md), [B1b handoff](../b1b-handoff.md),
[B1c handoff](../b1c-handoff.md), [B1 completion handoff](../b1-handoff.md),
and their linked review records. The PR communication observation below comes
from the retrospective discussion.

## What went well

- **Useful mathematical boundaries.** Term integration, pointwise summation,
  domination, sum/integral interchange, and integral evaluation composed
  cleanly. The completed B1c bridge was reused unchanged in final assembly.
- **Checking actual pinned APIs.** Identifying all five dominated-convergence
  premises before implementation made B1c direct: its first module compilation
  passed without warnings. The proof retained convergence in `HasSum` and
  avoided a premature tail or `tsum` layer.
- **A small proof with explicit consumers.** The final rational decomposition,
  primitive derivative, integral evaluation, and series theorem formed a
  direct chain. Post-commit necessity reviews found no justified simplification
  or unused proof layer. No new dependency, external proof translation, or
  additional orchestration was needed.
- **Integration and semantic checks.** Root-import checks, complete theorem
  types, endpoint/index checks, and actual axiom guards supplemented module
  compilation. They checked visibility and the intended statements, including
  the absence of unproved hypotheses in the final B1 theorem.
- **Controlled scope and preservation.** Earlier proofs and unrelated local
  work were preserved. The user's extension from the proposed B1d slice to
  complete B1 was explicit, and work stopped before B2/B3 or visitation.

## What was difficult or could have gone better

### Lean integration and automation

B1a's term proof compiled immediately, but its first root-import audit found
that the coefficient body was not exposed. Adding `@[expose]` resolved that
module-visibility issue. This supports checking the downstream interface early.

In B1b, broad commutative simplification produced an unsuitable normal form;
targeted conversion and ring normalization worked. Some initial endpoint
checks simplified without using the theorem being tested, so they were changed
to explicit theorem instantiations. A passing example is useful only if it
checks the intended contract.

During B1 completion, denominator normalization needed explicit local bounds,
and an under-specified `ContinuousOn.div` expression caused `fun_prop` to
exhaust the default heartbeat limit. Explicit types resolved it without
increasing resource limits. These were compiler/tactic problems, not missing
mathematics or reasons to weaken the target.

### Review transport, capture, and continuity

The [B1c review](../agy-reports/b1c-review.md) initially could not read a
temporary diff file and returned an empty response despite exit zero and
`SUCCESS`. The authorized recovery supplied the exact diff inline and
completed the full scope. Process success alone was insufficient evidence
of a completed review.

The [B1b review](../agy-reports/b1b-review.md) lost part of the intermediate
event stream when a 24,392-token poll exceeded its 14,000-token return budget.
The complete terminal response survived, so no final finding was lost, but
the capture was not lossless. Later reviews used larger capture budgets.

CLI conversation persistence was sandbox-denied in several runs. During the
[B1 PR follow-up](../agy-reports/b1-review.md#pr-preparation-session-entry-point-follow-up),
the prior conversation could not be found; the complete supplied context
allowed a new conversation to review the correction. A saved conversation ID
does not establish that its server/client context remains available.

Required reviews took several minutes and added operational work. They returned
no actionable proof findings in these implementation cycles, but that is not
evidence that review is unnecessary or a replacement for kernel checking.
Reviewer limitations, including reliance on caller builds and some API checks,
remain part of the evidence.

### Documentation and communication

Small proof slices required status updates across many files. A stale session
entry-point link to archived B1c instructions survived until PR preparation.
Its anchor still existed, so a check for broken links alone could not detect
the semantic error: the link selected the wrong instructions.

The combined completion included B1d, the derivative, integral evaluation,
and final assembly. The initial PR description described the mathematics but
did not explicitly label B1c/B1d; the user subsequently requested that clarity.
Milestone names and the actual publication state should be visible in completion
reports and PR text.

## Proposed improvements

These recommendations are proposals, not newly adopted repository instructions.
Preserve the current trust, validation, review, and authorization requirements
unless the user explicitly approves a policy change.

### Durable guidance in AGENTS.md

Keep dependency pins, permitted axiom dependencies, attribution, required Lean
checks, and required Gemini reviews. Add or clarify a small set of operational
rules:

1. Complete the entire authorized milestone through internal checkpoints;
   seek further authorization for a genuine scope extension.
2. Check new definitions and theorem interfaces through the library root early.
3. Make boundary checks instantiate the theorem they are intended to exercise.
4. Stop finalization on a failed required check; inspect exit codes before
   committing, including checks of newly added/staged files.
5. Report completed milestone/substeps, remaining obligations, and whether
   changes are local, pushed, or included in a verified PR.

The detailed Gemini procedure could move to a dedicated document referenced
as mandatory from `AGENTS.md`. Preserve existing anchors or update their
incoming references, the exact approved command prefix, High effort, scope
and capture requirements, terminal-result inspection, and bounded recovery.
This consolidation must not silently weaken a review requirement.

### Give each document a clear responsibility

| Location | Proposed responsibility |
| --- | --- |
| [Meta-plan](../meta-proof-plan.md) | Evidence-based lessons, proposed process improvements, and their evaluation. |
| [Proof plan](../proof-plan.md) | Mathematical roadmap and the current milestone's exact steps and contracts. |
| [Blueprint](../proof-blueprint.md) | Compact declaration/dependency/status index, retaining every unproved hypothesis. |
| [Proof workflow](../proof-workflow.md) | Inspect, specify, probe interfaces, implement, validate, review, commit, and review necessity. |
| [Research log](../research-log.md) | Chronological outcomes and links to evidence with minimal repetition. |
| Milestone handoffs | Concise restart information and final acceptance evidence. |
| [README](../../README.md) and [prompt entry point](../proof-attempt-session-prompt.md) | Short orientation and links to the current authoritative records. |

Keep historical handoffs as dated snapshots. Put current next-step instructions
in the current prompt and link to them, avoiding repeated mutable next-task
claims. Reduce duplicated prose while retaining mandatory mathematical and
trust information.

### Project memory and handoffs

The inspected repository had no dedicated memory file; its handoffs and
research log already provided durable project context. Standardize handoffs
before adding another status store:

- Milestone and baseline commit.
- Checked theorem contracts and important indexing conventions.
- Validation and review results, including limitations.
- Remaining obligations and known implementation pitfalls.
- Links to the current prompt and supporting evidence.

If agent-managed memory is used, keep stable preferences and pointers there.
Verify branch state, audit counts, and next-task claims from the actual checkout.
Memory must not override explicit user instructions or become another copy of
volatile project status. No global or agent-managed memory is changed here.

### Small tools for observed failures

A documentation checker could verify exactly one current prompt, valid local
links, and that active entry-point links select the current section rather than
the archive. Test it against the stale-but-valid-anchor case; historical links
to archived instructions must remain valid and must not be treated as active
entry points.

Review preparation/result utilities could prepare a scoped diff with its
baseline/hash and inspect saved events for process exit, terminal response,
errors, denials, and capture completeness. Keep the literal approved `agy`
invocation outside these utilities so wrappers do not defeat the command-prefix
approval rule. Their job is to prepare evidence and detect incomplete runs;
the agent must still assess findings and denied coverage.

Reserve adequate capture capacity, save full output separately, and display
concise summaries. Document where captures are retained; temporary files are
not guaranteed archival storage. A small offline documentation check could
later join CI, preserving the existing Lean build and axiom audit. No new
Lean library, model service, permission expansion, or automatic retry framework
is proposed.

### Prompts and milestone size

Use one coherent authorized milestone with internal compilation/review
checkpoints. This does not authorize skipping necessary intermediate reviews,
crossing the endpoint, or assuming that a larger milestone will fit in one
context window.

Each prompt should contain the endpoint and exclusions, exact contracts and
dependencies, ordered checkpoints, acceptance criteria with links to mandatory
procedures, and stopping/handoff requirements. Shorten repeated generic policy
only after establishing its authoritative location.

For B2, retain the user's instruction to update the proof plan before
implementation and preserve its exact index and convergence requirements.
The prompt should continue to authorize all B2 steps together and stop before
B3. No B2 implementation or prompt revision is performed by this retrospective.

## Suggested adoption and evaluation

First agree on the rules and document responsibilities, then consolidate the
guidance. In a second pass, add the small validators and revise prompts to use
the consolidated procedure. Review each actual change under the existing policy.

For later milestones, record a few inexpensive facts: interface failures,
compiler repairs, review invocations and wall time, capture completeness, and
stale-current-link incidents. Separate proof work from review/finalization time
where measurements exist. Do not infer improvement from a single successful
cycle or confuse model usage counters with elapsed time.

B1 supports retaining the mathematical decomposition, pinned-source search,
compiler feedback, exact audits, and necessity review. It does not show that
the open universal-visitation problem will be comparably tractable.

## Record validation

The original 232-line addition was reviewed against
`919f14053c89ac4107d71e46ca321017a37bba1a`; the supplied diff's SHA-256 was
`1fb75e01d3a47e025e50bf188fe1fd97bc44639b77821af428511f19b21a5f9c`.
Gemini Carbon High returned **explicit no findings** for factual support,
policy, scope boundaries, and links. The caller accepted the findings after
checking them against the source records. This appendix records the result
without changing the reviewed assessment or proposals.

One invocation used the literal approved `agy --model gemini-4-carbon-high
--mode plan` prefix, stream JSON, a twenty-minute deadline, and the exact diff
inline. Conversation: `33405913-2027-449c-a183-6fca6845d8ab`; init selected
`gemini-4-carbon-high`. Caller start/completion: `2026-11-25T22:23:58.890Z` /
`2026-11-25T22:26:52.700Z` (173.810 seconds; CLI reported 172.451354 seconds).
Exit 0, terminal `SUCCESS`, nonempty response; `error`, `finished_reason`,
and `denied_actions` were absent. No recovery was needed.

By `22:24:58.993Z`, 29 read-only file calls had completed. The next poll showed
no new review events; by `22:26:52.700Z`, response deltas and the terminal result
arrived. Waits were at most 45 seconds. Only `read_file` tools were observed,
with no tool denials. CLI-owned log/crash/conversation persistence had sandbox
denials and authentication initialization messages; the existing login and
review subsequently succeeded. No permission setting changed.

Complete execution chunks and the terminal response were saved separately
under `/tmp/pi-b1-retrospective-review-*`; no chunk was truncated. These are
local temporary captures, not guaranteed archival storage. The reviewer relied
on caller checks for Git state, hashes, whitespace, and the PR conversation;
it did not run Lean or re-audit B1 proofs. Caller checks passed for 24 protected/
unrelated file hashes, all 16 local links/anchors, and staged whitespace. Final
checks include this appendix. No Lean file changed, so no new build/audit is
claimed; the meta-plan, current prompt, and other operational files are unchanged.
