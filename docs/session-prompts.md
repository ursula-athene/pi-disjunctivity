# Session prompts

Use only the **Current prompt** below when the user asks to start the next
milestone. Everything under **Old prompts - do not use** is historical, even
where an archived prompt contains imperative instructions or a different policy.
Writing this prompt does not begin the next milestone; invoking it does.

## Current prompt: B1 source and proof review

Locate the pi-disjunctivity repository root and execute this bounded milestone:
**B1 source and proof review**, as specified in
[the proof plan](proof-plan.md#next-bounded-task-b1-source-and-proof-review).
Proceed autonomously within this scope. Deliver the review and a concrete next
implementation slice; this is a request to do the source/argument review, not
merely propose how to review it. Stop after validation, retrospective, local
commits, and a written handoff. Do not begin the implementation slice.

### Current state and authorized endpoint

Step 2, B4, and P3 are checked, completing M1. B4 assumes vanishing errors and
arbitrarily late open-interval visits; P3 assumes open-interval visits. Neither
supplies independent BBP visitation. There are nineteen theorem type/axiom
audits and two expanded-definition checks. B1's series identity, B2's orbit
bridge, B3's tail estimates, and V's universal visitation remain unfinished;
Hπ, T, and the π conjecture remain unproved.

For this review, use the real coefficient

```text
A(j) = 4/(8j+1) - 2/(8j+4) - 1/(8j+5) - 1/(8j+6)
```

and the intended B1 target

```text
HasSum (fun j : ℕ => A(j) / (16 : ℝ) ^ j) Real.pi.
```

Deliver a reviewed mathematical argument, source/license/attribution assessment,
a dependency map to pinned Mathlib, and the smallest B1 implementation slice
with exact proposed statements and acceptance checks. Keep proposed statements
in Markdown. No BBP Lean declarations, external-code adaptation, B2/B3 work, or
Step 5 visitation attempt is authorized in this milestone. Retain the current
B1-before-B3 order; a proposed reorder requires a separate user decision.

### Inspect the checkout and establish a baseline

Locate the directory containing **both `lakefile.toml` and `lean-toolchain`**;
it may be the `pi-disjunctivity/` subdirectory alongside another Lean project.
Run every Lean/Lake command from that root with `$HOME/.elan/bin` on `PATH`.
Require `lean --version` to report **4.37.0-rc1** before building; `lake --dir`
alone does not select the correct Elan toolchain.

At prompt preparation, the branch was `feature/attempt-02`, with B4/P3 commits
`203e16c` and `a8c693e`, and subsequent checkout HEAD `76f6e40`. Inspect current
status/history rather than resetting to those snapshots. Preserve unrelated
changes, especially `docs/.obsidian/` and `docs/notes/`, and stage only task-owned
files. If this review has since been completed, inspect its evidence and report
that status; do not repeat it or automatically advance to implementation.

Read before editing:

- `AGENTS.md` and applicable nested instructions, particularly the `agy` procedure.
- `docs/proof-plan.md`, `docs/meta-proof-plan.md`, `docs/proof-workflow.md`,
  `docs/proof-blueprint.md`, `docs/research-log.md`, and `docs/b4-p3-handoff.md`.
- `docs/codex-reports/2026-11-24-lean-literature-review.md`, especially the
  external BBP development it identifies; treat earlier review claims as leads
  to verify against original sources, not as a substitute for inspection.
- `README.md`, `docs/problem-formulation.md`, `docs/dependencies-and-trust.md`,
  the relevant project Lean declarations, `PiDisjunctivity.lean`, and `Test.lean`.
- `lakefile.toml`, `lean-toolchain`, and `lake-manifest.json`.

Run `lake build`, `lake env lean Test.lean`, and `git diff --check` to establish
the current baseline. Announce the bounded endpoint before starting the review.

### Perform the B1 source and mathematical review

1. Inspect the original BBP identity proof cited in proof-plan Step 3 and the
   actual external Lean development identified in the literature report. Record
   exact URLs, source revisions, relevant theorem names and files, toolchain
   versions, and retrieval limitations. Verify the proposed `A(j)` and `Real.pi`
   target against the sources, including indexing, casts, signs, and denominators.
2. Review the external license and attribution requirements before proposing
   adaptation. Inspect proof bodies, imports, assumptions, and build configuration.
   Distinguish source inspection from rebuilding and kernel/axiom auditing.
   Do not copy external code into the project or change its dependencies. If a
   license requirement conflicts with project attribution policy, record that
   constraint and propose an independently written route or a user decision.
3. Write a self-contained mathematical outline of convergence and equality with
   `Real.pi`. Expose the obligations behind any geometric-series expansion,
   interchange of sum and integral, rational integral evaluation, and resulting
   `HasSum` statement. Identify every nontrivial analytic hypothesis; do not treat
   the published identity alone as a completed local Lean proof.
4. Search the pinned Mathlib and project sources for the needed API. Map each
   obligation to an existing declaration with its complete hypotheses or to a
   precisely stated missing lemma. Use disposable `/tmp` signature probes if
   useful; do not define or prove BBP coefficients, series, recurrences, or tails.
   Do not add Lean dependencies, install tooling, or upgrade the pins.
5. Criticize the argument before recommending substantial formalization. Check
   convergence versus a bare `tsum` expression, admissibility of analytic
   interchanges, endpoint conditions, nonzero denominators, and correspondence
   with the existing `Real.pi`. Identify what the external proof can inform under
   the Mathlib-only policy and what needs an independent proof.
6. Specify the smallest useful B1 implementation slice with exact hypotheses,
   conclusions, prerequisite lemmas, likely file location, validation, and a
   stopping condition. Recommend it without starting it. If source access or
   mathematics blocks the review, document the precise obstacle and the strongest
   verified assessment, retaining every unresolved obligation.

### Required Gemini Carbon High review

Follow [AGENTS.md](../AGENTS.md#gemini-carbon-code-reviews-with-agy) and the
[proof-plan review policy](proof-plan.md#changed-file-reviews-with-gemini-carbon).
Use the existing signed-in `agy` setup with `--model gemini-4-carbon-high` and
`--mode plan`. Request no file changes or mutating commands. Supply the milestone
baseline and explicit task-owned file list, ask the reviewer to read `AGENTS.md`,
and request actionable findings with severity, file/line references, reasoning,
and limitations. Exclude unrelated user changes from its scope.
For this headless review, request read-only file tools only and no shell/Bash
calls. Prepare the exact scoped diff in the calling session and supply it in the
prompt or an accessible review file, together with the baseline and file list.
This lets the reviewer inspect deletions and changed lines without running Git.

Use `--output-format stream-json --print-timeout 20m` for initial reviews and
follow-ups. Follow the [progress and bounded-retry instructions](../AGENTS.md#progress-timeouts-and-bounded-retries):
capture events and timestamps through the execution tool, monitor meaningful
changes, and inspect errors/logs before at most one focused recovery attempt.
Keep the explicit conversation ID, avoid overlapping runs, and record incomplete
coverage if recovery fails. A deadline or silent client alone does not prove a
hang; the longer deadline is not a guarantee. Use the direct approved command
prefix and save output separately, as described in `AGENTS.md`.

Have Gemini review the source assessment, candidate argument, dependency map,
and changed plans before the milestone commit. Request an intermediate review
when an uncertain argument would otherwise guide later work. This milestone
changes documentation; no code implementation is needed to obtain that review.
Record the model, reviewed range, returned `conversation_id`, completion status,
findings, and independent triage. Use the saved explicit conversation for focused
follow-ups on substantive fixes. Inspect result/error fields as well as exit
status: partial text or a timeout is not a completed review. Follow the host's
scoped approval procedure for sandbox restrictions. Do not silently substitute
another model, use permission bypasses, or claim the review passed if unavailable.
An empty `response` remains incomplete even with exit code zero and
`status: SUCCESS`. Require substantive findings or an explicit no-findings
response, and inspect `denied_actions`; resolve any denial that prevents the
requested coverage or record the uncovered scope. Host execution approval does
not grant permissions to the reviewer's internal tools.

This authorizes the specified reviewer, not additional agents, services, tooling
installation, or unrelated delegation. Reviewer feedback supplements mathematical
review and Lean validation; independently assess suggestions before applying them.

### Artifacts, validation, retrospective, and stopping point

Write the review in `docs/b1-source-proof-review.md`, including source evidence,
the argument/dependency map, reviewer findings and dispositions, limitations,
and the proposed implementation slice. Update the research log and blueprint,
review both plans, and make only evidence-based status/process adjustments.
Keep their next-task entries aligned. Do not mark B1 checked until a future
`HasSum ... Real.pi` proof and its audits actually pass.

Preserve Mathlib as the sole direct external Lean library, the `v4.37.0-rc1`
pins, existing definitions, theorem contracts, exports, linters, and all nineteen
audits. Add no placeholders, extra axioms, `native_decide`, or unsafe shortcuts.
Only `propext`, `Classical.choice`, and `Quot.sound` are permitted axiom dependencies.

For this documentation-only milestone, check changed Markdown links/anchors,
`git diff --check`, and preservation against the starting commit of all project
Lean files, `Test.lean`, dependency files, and CI. Record the baseline build/audit
results accurately; rerun affected Lean checks if any Lean-related input changed.
Review the staged diff and ensure it excludes unrelated work.

Retrospect on what was established, remaining gaps, source/library or process
obstacles, and whether the evidence warrants a route or workflow adjustment.
Keep the existing commit cadence: validate and obtain the Gemini review, commit
the scoped report/docs locally, then review the proposed proof pieces for
necessity, simplify where justified, obtain a focused Gemini follow-up for
substantive changes, rerun affected checks, and commit actual follow-up changes.
Do not create an empty second commit, push, or rewrite history.

Write and commit a concise Markdown handoff with results and unresolved
hypotheses, changed files, validation actually run, review status, retrospective,
plan adjustments, commit IDs, and the next task proposed for authorization.
Print the handoff in a readable terminal format. **Then pause for the user's
questions and decision, before adding BBP Lean declarations or beginning any
implementation, B2/B3, or universal-visitation milestone.**

## Old prompts - do not use

The following completed prompts are archived for provenance. They grant no
current authorization and do not override the current prompt or review policy.

### Session prompt: begin the proof attempt with B4 and P3

Use this prompt to start the next bounded implementation session. The Step 2
interval-hitting pilot is complete. B4 and P3 are the next supporting milestone;
the universal-visitation claim about the BBP recurrence remains open.

#### Authorization and endpoint

Implement and validate **B4, the conditional interior-margin transfer, and P3,
the open-interval-to-hexadecimal-cell conversion**, as specified in
[the proof plan](proof-plan.md#next-bounded-task-conditional-interior-margin-transfer).
Proceed autonomously within this scope; this is an implementation request,
not a request for another plan.

Complete the two general lemmas, their exports and audits, then retrospect on
the milestone and recommend the next bounded task. Review both the proof plan
and meta-plan and make evidence-based adjustments within this milestone's scope.
Stop after that handoff; recommending a later task does not authorize starting it.

Follow the existing Viewpoint policy for local milestone commits: validate and
commit the scoped code and documentation, then review whether every proof piece
is needed, simplify where justified, rerun affected checks, and commit any actual
follow-up changes. Do not manufacture an empty second commit. Do not push unless
the user separately requests it. Do not install tooling, use paid services,
launch sub-agents, change dependencies, or rewrite Git history.

#### Inspect the actual checkout first

Locate the repository root containing **both `lakefile.toml` and
`lean-toolchain`**. It may be the `pi-disjunctivity/` subdirectory of the initial
workspace, alongside another Lean project. Run every Lean/Lake command from
that root with `$HOME/.elan/bin` on `PATH`. Require `lean --version` to report
**4.37.0-rc1** before building; `lake --dir` alone does not select the correct
Elan toolchain.

At this prompt's creation, the branch is `feature/attempt-02`, with committed
baseline `64f5b28` in `ursula-athene/pi-disjunctivity`. Inspect current status and
history rather than resetting to that snapshot. Preserve unrelated changes,
particularly `docs/.obsidian/*` and `docs/notes/`, and stage only task-owned files.
If the milestone has since been implemented, inspect its checks and status
instead of duplicating it or automatically advancing to another milestone.

Read before editing:

- `AGENTS.md` and any applicable nested instructions.
- `docs/proof-plan.md`, `docs/meta-proof-plan.md`, `docs/proof-workflow.md`,
  `docs/proof-blueprint.md`, and `docs/research-log.md`.
- `README.md`, `docs/problem-formulation.md`, and `docs/dependencies-and-trust.md`
  for the reviewed formulation, current status, and trust boundary.
- `PiDisjunctivity/OrbitCriteria.lean`, `PiDisjunctivity/OrbitEquivalence.lean`,
  their relevant prerequisites, `PiDisjunctivity.lean`, and `Test.lean`.
- `lakefile.toml`, `lean-toolchain`, and `lake-manifest.json`.

The external review in `docs/agy-reports/meta-proof-plan-review-report.md` is
historical evidence. Its recommendations were independently triaged; use the
accepted specifications and decisions in the current plans and research log.
Do not reinstate its rejected or deferred recommendations.

Establish the baseline with `lake build`, `lake env lean Test.lean`, and
`git diff --check`. Announce the bounded endpoint before implementing.

#### Required mathematical statements

Choose clear theorem names consistent with the module. The signatures below
specify the hypotheses and conclusions; they are not incomplete Lean source
files to add to the repository.

##### B4: conditional interior-margin transfer

For `u r : ℕ → ℝ`, assume exactly:

```text
Filter.Tendsto r Filter.atTop (nhds 0)

∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
  ∀ N : ℕ, ∃ n ≥ N, u n ∈ Set.Ioo a b
```

Prove:

```text
∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
  ∃ n : ℕ, Int.fract (u n + r n) ∈ Set.Ioo a b
```

Do not add the redundant global hypothesis `∀ n, 0 ≤ u n ∧ u n < 1`.
Use the reviewed interior-margin argument: for a target `(a,b)`, take
`δ = (b-a)/4`, obtain a threshold after which `|r n| < δ`, then select a late
visit of `u` to `(a+δ,b-δ)`. The perturbed value lies strictly between `a` and
`b`, so its fractional part equals itself. Verify the quantifier order,
`a = 0`, `b = 1`, and errors of either sign. Do not assume a global Lipschitz
bound for `Int.fract` across integers.

Keep the single-visit conclusion. Arbitrarily late output visits and an extra
composition theorem are deferred until needed.

##### P3: open-interval-to-cell conversion

For arbitrary `t : ℕ → ℝ`, assume:

```text
∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
  ∃ n : ℕ, t n ∈ Set.Ioo a b
```

Prove:

```text
∀ k m : ℕ, m < 16 ^ k → ∃ n : ℕ,
  t n ∈ Set.Ico ((m : ℝ) / (16 : ℝ) ^ k)
    (((m : ℝ) + 1) / (16 : ℝ) ^ k)
```

Apply the hypothesis to the open interior of each cell. Check positive width,
nonnegative lower endpoint, upper endpoint at most one, natural-to-real casts,
and `k = 0`, `m = 0`, and `m = 16^k - 1`. This lemma is independent of B4 and
requires no range hypothesis on `t` or BBP assumption.

#### Implementation and verification

Use `PiDisjunctivity/OrbitCriteria.lean` unless inspection demonstrates a smaller
suitable location. Preserve existing definitions, theorem contracts, public
exports, module/import conventions, headers, and linters. Use only Mathlib,
Lean's core/standard libraries, and permitted project modules; retain the
Lean/Mathlib `v4.37.0-rc1` pins.

Follow the local workflow: search the project and pinned Mathlib first, sketch
and criticize the argument, use disposable `/tmp` scratch files when useful,
then implement incrementally. `#check`, `#print`, `trace_state`, `exact?`,
`apply?`, and `rw?` are available within the existing stack. Remove diagnostics
and replace successful search suggestions with explicit proof steps in the
production proofs. Add only necessary helpers.

Use kernel-checked proofs with no `sorry`, `admit`, project-specific axioms,
`native_decide`, or unsafe shortcuts. The only permitted axiom dependencies
are `propext`, `Classical.choice`, and `Quot.sound`; individual results may use
fewer. Inspect the actual lists before adding guards.

Export both results through the existing library root and extend `Test.lean`
with their explicit complete type checks and guarded `#print axioms` outputs.
Preserve the existing seventeen theorem audits and both expanded conjecture
definition checks. Add `Examples.lean` cases only when they provide useful
semantic or boundary regression coverage beyond the universal proofs and audits.

Validate the integrated result from the repository root:

```sh
lake build
lake env lean Test.lean
git diff --check
git diff HEAD -- lean-toolchain lakefile.toml lake-manifest.json \
  PiDisjunctivity/Definitions.lean PiDisjunctivity/Conjectures.lean
```

Review all other changed theorem signatures, imports, and the staged diff as
well. Preserve pre-existing unrelated work. Resolve compiler/linter problems
without weakening the specifications. If blocked, record the precise obstacle,
commands and diagnostics, and whether it is a mathematical, library, compiler,
or environment issue; keep every unproved claim explicit.

#### Retrospective, plan adjustment, and stopping point

At completion or a documented obstruction, assess:

1. What was actually established, and which hypotheses and mathematical gaps
   remain?
2. What helped or hindered the work: mathematics, library search, formalization,
   or workflow?
3. Does the evidence justify changing the mathematical route, task order, or
   research process?
4. What is the next smallest useful task, with an explicit endpoint and stopping
   condition?

Update the blueprint and research log with actual declarations, statuses,
checks, and outcomes. Review both plans; update the proof plan for mathematical
or status changes and the meta-plan/workflow for process changes that the
evidence warrants. Keep the linked next-task entries aligned in both plans.
Reconcile affected audit-count summaries. Avoid a planning-system rewrite or
edits made only to show that every document was touched.

Keep user-owned policy choices explicit. In particular, changing the existing
commit cadence or the later B1/B3 ordering needs a separate user decision.
You may recommend weighted-series/tail summability and B3 before B1, with reasons;
do not silently reorder or begin that work. Review new mathematical arguments
before committing to substantial formalization.

Mark B4 and P3 checked only when their proofs and audits pass. Hπ, T, and the
π conjecture remain unproved because independent visitation and BBP bridges
are still missing. Stop before defining or proving BBP series, recurrences,
tail estimates, or attempting Step 5's universal visitation.

Finish with a concise handoff: exact results and hypotheses, files changed,
validation actually run, retrospective conclusions, plan adjustments, commit
IDs, remaining obstructions, and the next task proposed for authorization.

Write the handoff to a markdown file, commit it, and print to the user in a
format that is readable on the Codex terminal.

Then pause for the user's questions and decision.

### Session prompts

Milestone C is complete; see the [consolidated review](formulation-review.md).
The prompt below is retained as the record of the authorized review scope, not
as a pending task. Formulation verification is complete, and the pi disjunctivity
conjecture remains unproved. A proof attempt or BBP formalization requires
separate authorization. The older
[Step 2 prompt](step-2-session-prompt.md) is retained as historical context;
that foundational step is already complete.

#### Next session: final formulation audit and review (milestone C)

**Completed 2026-11-24. Historical prompt follows.**

Complete **milestone C, "Complete the formulation audit and review,"** in
`docs/problem-formulation.md`. This authorizes the review, necessary corrections,
validation, and documentation within that scope, not merely another plan.

We want to finish verifying that our Lean formulation expresses the intended
problem: every finite hexadecimal word occurs contiguously after the radix point
of pi, including words with leading zeros. We are not yet working on a proof that
pi has this property. Do not begin conjecture-proof research or BBP formalization.

##### Read the current project first

Locate the repository root containing `lakefile.toml`; it may be the
`pi-disjunctivity/` subdirectory of the initial workspace. The repository is
`ursula-athene/pi-disjunctivity`, on branch `feature/attempt-01` at handoff.
Read applicable `AGENTS.md` instructions, inspect Git status, and preserve
existing changes. Do not switch branches or rewrite history.

Read before editing:

- `README.md`, `docs/problem-formulation.md`, `docs/foundations-plan.md`, and
  `docs/dependencies-and-trust.md`.
- Every project Lean module: `Definitions.lean`, `BlockValue.lean`, `Digits.lean`,
  `Cylinders.lean`, `Conjectures.lean`, `OrbitEquivalence.lean`, and `Examples.lean`
  under `PiDisjunctivity/`, plus `PiDisjunctivity.lean` and `Test.lean`.
- `lakefile.toml`, `lake-manifest.json`, `lean-toolchain`, and
  `.github/workflows/lean_action_ci.yml`.

All three foundational steps and milestones A and B are implemented. Their
twelve reviewed theorem types and guarded axiom checks passed at handoff.
Milestone C remains pending. The old base-10 handoff and Step 2 prompt are
historical; the current formulation and roadmap govern this task. Review the
current proofs rather than restoring previously discarded proofs from history.

##### Perform the consolidated review

1. Compare the actual definitions and exported theorem statements with the
   intended problem. Check the quantifier order (every length and word has an
   occurrence), explicit word length and leading zeros, contiguous digits,
   zero-based positions after the radix point, digit values 0 through 15, and
   the vacuous empty word. Disjunctivity requires existence of occurrences,
   without a frequency condition.
2. Check the nonnegativity hypotheses required by `Nat.floor`, preservation of
   the integer part in reconstruction, and the terminating-expansion convention
   of trailing zeros. Review how the universal proofs justify these conventions;
   examples alone are insufficient.
3. Review both directions of the word–interval correspondence, including fixed
   length, digit shifts, and left-closed/right-open boundaries. Review both
   directions of the orbit-closure equivalence, including approximation of both
   0 and 1 and the use of interval interiors to recover occurrences. Confirm that
   the pi specialization uses Mathlib's `Real.pi` and proves only equivalence
   between the two proposition definitions, without asserting either one.
4. Preserve the twelve exported-type checks and guarded `#print axioms` audits.
   Record each theorem's actual axiom dependencies, allowing only `propext`,
   `Classical.choice`, and `Quot.sound`; a theorem may use fewer. Unexpected
   dependencies must still fail the audit. Check configuration, manifest, and
   source imports separately for compliance with the dependency policy.
5. Review the existing examples for empty and one-digit words, zero, `00A`, `FF`,
   nonzero offsets, integer parts, terminating expansions, and both interval
   boundaries. Add meaningful checks or supporting lemmas where the review
   reveals a gap. Preserve the reviewed definitions and theorem statements;
   explain any necessary correction and its effect on the intended meaning.
   Never weaken a statement or a check merely to make validation pass.
6. Write a consolidated review in `docs/formulation-review.md`, mapping each
   requirement to its definitions, general theorems, and relevant examples.
   Record findings, any corrections, actual axiom lists, commands and results,
   and remaining limitations. Distinguish kernel-checked proofs from the
   mathematical review of their intended meaning. Update `README.md`,
   `docs/foundations-plan.md`, `docs/problem-formulation.md`, and
   `docs/dependencies-and-trust.md` consistently. Mark milestone C complete only
   if its criteria have actually been met; otherwise identify the precise gaps.

##### Constraints and validation

Mathlib must remain the only direct external Lean library. Our own Lean code
depending only on Mathlib, Lean's core/standard libraries, and compliant local
modules is allowed. Keep Mathlib's pinned transitive dependencies; add no other
external libraries, vendored libraries, or direct imports of those packages.
Follow `AGENTS.md` and `docs/dependencies-and-trust.md`.

Keep Lean and Mathlib pinned to `v4.37.0-rc1`. Add no `sorry`, `admit`,
project-specific axioms, `native_decide` proof bypasses, or unsafe shortcuts.
Preserve `module`, import, and public-section conventions, MIT SPDX headers,
enabled linters, and copyright/author attribution only to Ursula Athene.

Run from the repository root:

```sh
lake build
lake env lean Test.lean
git diff --check
```

If needed, first run `export PATH="$HOME/.elan/bin:$PATH"`. Resolve build or
linter warnings without disabling checks. Ensure CI still runs the audit after
the build. Do not mark verification complete solely because the build passes.

Finish with the review findings, changes, validation results, axiom dependencies,
and a clear statement of whether formulation verification is complete. State
explicitly that the pi disjunctivity conjecture remains unproved. Stop at this
phase; work on proving the conjecture requires separate authorization. Leave
this next session's changes uncommitted and ready for review; do not push.
