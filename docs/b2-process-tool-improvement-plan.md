# B2 process and tool improvement plan

Proposed replacement plan, 2026-11-25. **Plan-writing only in this session.**
No installation, skill activation, workflow implementation, or proof work is
performed by saving this document. The next implementation milestone is to
implement and evaluate these improvements **before going on to B3**.

**B2 proof development is out of scope.** B2 is already checked and reviewed;
its completed code supplies test cases, not a problem to solve again. B3,
universal visitation V, Hπ, T, and π disjunctivity remain unproved. B4 retains
vanishing-error and arbitrarily-late-visit premises; P3 retains open-interval
visitation. This plan changes none of those contracts or hypotheses.

This is the sole replacement specification for the B2 process/tool milestone.
It supersedes the earlier
[B2 workflow and Lean tooling prompt](session-prompts.md#current-prompt-b2-workflow-and-lean-tooling),
which is archived as history. The
[recommendations](lean-tooling-recommendations.md) remain a source assessment;
the priorities and exclusions below control the proposed implementation.
The [current prompt](session-prompts.md#current-prompt-b2-improvement-plan)
is a short execution entry point and grants scope only when invoked.

## Evidence and decisions

Read the [B2 retrospective](retrospectives/retrospective-2026-11-25-b2.md),
[meta-plan](meta-proof-plan.md), and the earlier
[B1 retrospective](retrospectives/retrospective-2026-11-25-b1.md) together.
Keep the successful small proof/check/review loop and B1/B2/B3 mathematical
ordering. The table distinguishes observed problems from proposed remedies.

| Evidence | Implementation decision | Evaluation |
| --- | --- | --- |
| B1 visibility and ineffective boundary probes; successful B2 root probes | Preserve early root-interface checks and explicit theorem instantiation. | Replay existing B2 interfaces and zero/first-index checks without changing production Lean. |
| B2 generated additive declaration search, guessed API name, natural-subtraction orientation | Trial local LSP discovery and typed, local-first search. | Locate `hasSum_nat_add_iff'`, inspect `pow_sub₀` and index rewrites; compare with shell results. |
| B2a stale status/count prose despite valid links | Add a short manual semantic status pass to review preparation. | Reconcile overview, roadmap, blueprint, and current prompt; test with a disposable stale-but-valid prose example. |
| Large displayed reads, repeated short polls, lost persisted review context | Bound reads; use 30–60-second review polls; supply self-contained review inputs. | Complete scope/capture, concise findings, measured invocation time, no dependence on saved conversation context. |
| Recommendations identify research-argument and source-contract needs | Evaluate small project-specific skills on existing arguments and sources. | Catch seeded reasoning errors and preserve valid conditional contracts without starting V research. |
| No measured elaboration bottleneck or need for a new computer-algebra environment | Defer performance tuning and Sage installation. | Reconsider only against a named later problem, not as prerequisites for B3. |

The sibling clones were inspected read-only during planning: both were clean
at the revisions below. This verifies source availability, not installation,
host activation, compatibility, or performance.

- [lean-lsp-mcp][lsp-source]: `7932203d79db213852db215835bd79c943bb99b0`,
  package version `0.33.0`; its test project uses Lean 4.35.0.
- [LeanAutoformalizationSkills][skills-source]:
  `1837b95b3d5a9fd8d311367603902ad7fe261adf`.
- The [lean4-skills recommendation](lean-tooling-recommendations.md#3-adopt-lean4-skills-guidance-selectively)
  is a complementary reference. Do not install a second overlapping skill
  suite merely because it was recommended.

One change from the old prompt is intentional: **do not install or activate
the unmodified `lean-elaboration` skill.** Its inspected [profiling procedure][elaboration]
explicitly substitutes `sorry` for proof bodies and expects companion skills.
That conflicts with this repository even for scratch work. No measured B2
performance problem warrants an adaptation now. The two focused search/proof
skills still need a complete resource and policy review before installation.

## Scope and acceptance boundary

The future milestone covers workflow documentation, a pinned external LSP
pilot, selective skill evaluation, and a documented adopt/defer/reject decision
for each candidate. It may create small portable probes or evaluation fixtures
only when needed for repeatable evidence. It does not change production Lean
definitions, theorem signatures, proofs, imports, or `Test.lean` guards.

Preserve Mathlib as the sole direct external Lean library, both `v4.37.0-rc1`
pins, module/header/linter conventions, and the allowed axiom set. No `sorry`,
`admit`, extra axioms, `native_decide`, REPL dependency, or unsafe proof shortcut
is permitted. Keep external Python tooling out of this repository's Python lock.
No broad skill installer, remote proof-generation service, paid model service,
new approval framework, semantic documentation checker, dependency graph, or
multi-agent orchestration is part of this milestone.

Preserve existing installations, branches, unrelated work, and user settings.
Use supported user-scoped installation/configuration within host permissions
when the future prompt is invoked. Do not change permissions or infer that a
saved prompt overrides this session's plan-only boundary. Activation requiring
a restart is a pending step, not a passed test.

## P0 — Establish the implementation baseline

1. Re-read `AGENTS.md`, the current prompt, this plan, the workflow, and the
   mandatory Gemini procedure. Verify branch, HEAD, index, remotes, and unrelated
   work. Use a new implementation branch from a verified baseline containing
   completed B2 and this replacement plan; use an isolated worktree if needed.
2. Verify `lean --version` before running `lake build` and
   `lake env lean Test.lean`. Record exact commands, exits, tool versions, and
   baseline hashes of Lean sources, audits, pins, and dependency manifests.
3. Inspect the actual host's supported MCP/skill mechanisms and available
   tools. Verify both sibling clone revisions and working trees again; preserve
   them. Inspect licenses, installers, and all resources needed by selected
   skills. Record any source/version change before using it.
4. Define the replay cases and record the shell baseline before enabling LSP.
   Separate installation/startup, warm queries, compiler work, and review time.
   Missing historical measurements stay "not measured".

**Exit evidence:** a reproducible baseline and exact owned scope. A failing
baseline is an environment/repository issue to report, not an LSP regression
or permission to begin mathematical repairs outside scope.

## P1 — Implement the process improvements first

Update the authoritative [workflow](proof-workflow.md),
[Gemini procedure](gemini-review.md), and handoff guidance only where the
retrospective identifies a gap. Avoid duplicating rules in `AGENTS.md`.

- Require actual signatures and side conditions before composing a proof;
  retain root-import probes and explicit natural-index equalities before
  field/ring normalization.
- Before review, read the active overview, relevant roadmap status, blueprint
  row, and current prompt together. Check completed versus proposed work and
  every remaining hypothesis. Link to `Test.lean` rather than copying live counts.
- Read bounded source sections and display summaries while retaining complete
  review captures. Poll long reviews generally every 30–60 seconds, never beyond
  the mandatory per-wait limit. Distinguish new events from silence/runtime logs.
- Supply the exact scoped diff, baseline/hash, contracts, relevant API locations,
  and prior findings for each review. Prefer the exact diff inline when temporary
  reviewer-file access is unavailable; never retry a denied file through another
  tool or change reviewer permissions. A continuation ID is only an optimization.
- Keep findings and concise coverage notes first. Preserve Carbon High,
  intermediate/final coverage, literal invocation, terminal inspection, and
  bounded recovery. Keep detailed evidence in the handoff/review report.

**Tests:** use a disposable documentation excerpt with valid links but stale
status to exercise the manual pass; leave the automated checker limited to
its existing contract. Inspect a self-contained review packet against its
staged file list/hash. Existing process tests must pass. The actual milestone
review supplies operational evidence; do not launch extra reviews merely to
measure latency. Obtain an intermediate Carbon review after substantive
workflow or skill-policy changes, before relying on them.

## P2 — Install and evaluate local LSP on completed B2

Install `lean-lsp-mcp` from a verified pinned package or source snapshot into
an isolated user-scoped environment, preferably through existing uv tooling.
Avoid editable installs. Record revision, version, resolved dependencies,
launch command, installation location, configuration delta, and removal steps.
Do not modify sibling clones, project Python locks, Lake manifests, or Lean pins.

Configure the actual host, preferably using local stdio and an explicit project
root. Preserve existing MCP entries. Set `LEAN_REPL` false; initially expose
only the local goal, diagnostic, hover, declaration, and search capabilities
needed below. Disable optional remote services and source-mutating tools using
the inspected version's supported controls. Keep machine paths/configuration
out of portable repository files. Verify that the disabled capabilities really
are absent from the exposed tool list.

Track four separate states: **installed**, **configured**, **protocol tested**,
and **available and tested in the actual Codex host**. A successful terminal
launch or protocol client test cannot stand in for the final state.

| Replay case | Required evidence |
| --- | --- |
| Generated declaration discovery | Find `hasSum_nat_add_iff'`; show that the language-server symbol index was consulted; check its full local type and a compiled application. Compare with source search and tracing `@[to_additive]`. |
| Signature and index inspection | Retrieve `pow_sub₀` and the relevant natural-subtraction signature/side conditions. Match local `#check` output; use the exact B2 argument shape without guessing a replacement API. |
| Goals and diagnostics | Inspect a goal inside an already complete scratch proof. In a disposable probe introduce an unresolved identifier or type mismatch, retrieve its diagnostic, fix it, and verify the diagnostic clears. Never insert a placeholder proof. |
| Root contract and boundary checks | Import `PiDisjunctivity`, exercise existing B2 definition equations, and explicitly instantiate the existing recurrence/orbit theorems at zero and one. Preserve `y_(n+1)` versus orbit index `n`. |
| Fallback and preservation | Disable the task-owned server entry and rerun the shell probes; restore only that entry if adopted. Compare protected file hashes and confirm no dependency or production Lean changes. |

Use unique disposable files and local captures, not new production theorems.
Record code, positions, queries, responses, errors, and compiler exits needed
to reproduce each case. Remove diagnostic fixtures after evaluation. Verify
`lake build` and `lake env lean Test.lean` again before acceptance.

Compare the same cases with shell and LSP: one startup observation and three
warm trials per path, alternating order where practical. Record elapsed time,
inspection/tool-call count, repair attempts, and whether the answer was correct
and useful. Replaying known B2 results has learning/cache effects; these small
measurements are a local usability assessment, not a proving benchmark.

Adopt only if all functional/preservation checks pass, actual host access works,
and a named case shows useful additional discovery/diagnostic information or
reduced inspection effort. If benefit is inconclusive, keep the shell default
and label LSP optional/deferred. A compatibility failure must not trigger a
toolchain upgrade. Bound setup to one initial attempt and at most two focused
repairs within 45 minutes of active setup work; then record the obstruction
and continue independent tasks. This bound does not replace Carbon's retry rules.

## P3 — Evaluate focused skills without duplicating the workflow

First inspect complete `lean-search-discovery` and `lean-proof-patterns` folders
and their supporting references at the pinned source. Install only those
selected folders, using a supported selective method and preserving upstream
licenses/attribution outside project-authored Lean code. Resolve cross-skill
references explicitly: a missing companion is not authorization to install
the whole collection. Do not overwrite an existing skill without inspecting it.

Document project-specific overrides before activation: local search failure
does not establish nonexistence; approved conditional B4/P3 reductions remain
valid; frozen-manifest approvals and placeholder workflows are not adopted;
existing headers, complete milestone scope, checks, and Carbon reviews prevail.
An incompatible skill must be adapted lawfully or deferred, never silently
enabled. Record discovery/activation separately from merely copying folders.

Use the P2 cases to assess these skills with and without their guidance. Record
actual signature checks, stable proof steps, failure classification, and any
unnecessary work. Avoid extra scripted tests unless new scripts have meaningful
behavior to verify. Do not refactor completed B2 proofs as a skill demonstration.

Implement small original project skills only where their outputs add a distinct
benefit. References should point to the existing authoritative documents.

| Candidate | Bounded implementation and test | Adoption decision |
| --- | --- | --- |
| `lean-lemma-lab` | A thin entry to the existing specify/search/probe/check loop, using a completed B2 replay. | Prefer the workflow plus selected upstream skills if they already supply the same outputs; do not create a redundant wrapper. |
| `pi-argument-critic` | Read-only criticism using existing reductions and deliberately faulty Markdown arguments, with exact hypotheses and obstruction reports. | Highest-priority original skill if it passes the cases below; no new V argument or proof campaign. |
| `paper-to-lean-contract` | Extract the existing BBP source statement, hypotheses, source locations, Lean contract, and bridge obligations; compare with the B1 source review. | Adopt if it preserves the source and identifies what a theorem does and does not supply; use existing browser/PDF tools. |

The critic must flag almost-everywhere-to-specific-orbit inference, finite-to-
universal visitation, shrinking-error-to-visitation inference, circular use of
disjunctivity, lost recurrence offsets, and accidental strengthening to normality.
Include valid B4/P3 statements as controls: it must retain their premises and
accept them as conditional results. The paper skill must distinguish the BBP
identity from a visitation theorem and preserve analytic side conditions.
Use source statements already assessed in this project, not a new literature
research campaign. Run one evaluation and one focused revision/retest for each
original skill; unresolved failures yield defer/reject, not repeated expansion.

**Exit evidence:** for every candidate, source/version, overrides, complete
resource coverage, evaluation outputs, and adopt/defer/reject with reasons.
No same-session model criticism is described as independent review. Preserve
Carbon's separate changed-file review; a skill cannot satisfy it by itself.

## P4 — Disposition of additional search and experiment tools

Keep these decisions explicit so the broad recommendations do not silently
expand the milestone:

- **Loogle/LeanSearch:** defer remote MCP activation by default. If P2/P3 show
  a specific discovery gap, specify a later bounded trial: at most three public
  theorem-description/type queries, record service/date and results, and verify
  useful hits locally with full types and compiled applications. No repository
  upload, API account, or paid service is implied. Service failure must leave
  local search usable. That optional extension needs its own authorization.
- **SageMath:** no installation now. A later named arithmetic question may
  first use existing exact rational tooling; require explicit finite bounds,
  reproducible parameters, and precision/error enclosures where relevant.
  Compare small cases with checked identities. Any claimed universal lemma
  still needs a Lean proof. No finite visitation experiment advances V by itself.
- **Elaboration skill:** defer until profiling establishes a concrete need
  and a no-placeholder adaptation is reviewed. Do not adopt its unmeasured
  performance claims, companion installs, or statement-changing advice.
- **Full skill/prover frameworks:** not part of the endpoint. Keep the existing
  Markdown blueprint and human-readable research records.

Explicit deferral is a completed evaluation decision, not an unreported missing
installation. A tool claimed as adopted requires all its acceptance evidence.

## P5 — Acceptance, records, and stopping point

The implementation handoff must distinguish completed process changes, evaluated
tools, adopted tools, deferred/rejected candidates, and pending host activation.
Use the existing [handoff template](handoff-template.md),
[review procedure](gemini-review.md), and [process utilities](process-tools.md).
Keep the meta-plan's eventual adoption entry evidence-based; this plan remains
a proposal until execution supplies those outcomes.

Required acceptance:

1. P1 process changes and P2/P3 evaluation results have exact owned scope and
   evidence. Any compatibility or host block is explicit. Do not label pending
   host activation or a failed required check as complete adoption.
2. `lake build`, `lake env lean Test.lean`, offline process unit tests,
   `tools/check_docs.py`, `git diff --check`, and staged whitespace checks pass.
   Use the documented `uv --no-cache` variant if the global cache is inaccessible.
   Protected Lean sources, audit contracts, pins, and manifests are unchanged.
3. All active entry links select the one current prompt. Semantic review retains
   all open mathematical obligations. No fresh status ledger or live audit-count
   duplication is introduced.
4. Required intermediate reviews and the complete task-owned Carbon High review
   finish; findings are assessed, substantive fixes receive focused follow-up,
   and affected checks are rerun. Capture/result and caller coverage review pass.
5. Record environment/configuration changes and precise removal/rollback steps.
   Restore only task-owned settings when rejecting a tool; preserve pre-existing
   user configuration. Complete work through internal checkpoints without
   repeated permission requests within the invoked scope.
6. Commit only reviewed task-owned repository files as standalone Git actions;
   inspect the result for necessity. Inspect HEAD/index immediately before a
   commit and reconcile concurrent commits rather than amending unrelated work.
   Report local/pushed/PR state accurately. This plan does not request a push
   or PR; publication requires the executing user's instruction.

Stop after improvement implementation/evaluation acceptance. If a tool cannot
be adopted, document the tested fallback and disposition; if host activation
remains required for intended adoption, leave an exact continuation step.
**Do not solve or extend B2, begin B3, or start visitation research.** B3 can be
the next separately authorized mathematical milestone after this improvement
milestone has a clear acceptance outcome. The mathematical contracts stay in
[the proof plan](proof-plan.md), not in this tooling plan.

[lsp-source]: https://github.com/oOo0oOo/lean-lsp-mcp/tree/7932203d79db213852db215835bd79c943bb99b0
[skills-source]: https://github.com/scottnarmstrong/LeanAutoformalizationSkills/tree/1837b95b3d5a9fd8d311367603902ad7fe261adf
[elaboration]: https://github.com/scottnarmstrong/LeanAutoformalizationSkills/blob/1837b95b3d5a9fd8d311367603902ad7fe261adf/skills/lean-elaboration/SKILL.md
