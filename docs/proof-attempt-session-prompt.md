# Session prompt: begin the proof attempt with B4 and P3

Use this prompt to start the next bounded implementation session. The Step 2
interval-hitting pilot is complete. B4 and P3 are the next supporting milestone;
the universal-visitation claim about the BBP recurrence remains open.

## Authorization and endpoint

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

## Inspect the actual checkout first

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

## Required mathematical statements

Choose clear theorem names consistent with the module. The signatures below
specify the hypotheses and conclusions; they are not incomplete Lean source
files to add to the repository.

### B4: conditional interior-margin transfer

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

### P3: open-interval-to-cell conversion

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

## Implementation and verification

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

## Retrospective, plan adjustment, and stopping point

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
Then pause for the user's questions and decision.
