# B4 + P3 milestone handoff

Completed 2026-11-25 on `feature/attempt-02`. Repository root:
`/Users/adam/personal/proj/pi-disjunctivity/pi-disjunctivity`.

**B4 and P3 are checked; M1 is complete. The π conjecture remains unproved.**

## Exact results

Both declarations are public in
[OrbitCriteria.lean](../PiDisjunctivity/OrbitCriteria.lean) and exported by the
existing `PiDisjunctivity.lean` root import.

- **B4 — `hitsOpenIntervals_fract_add_of_tendsto_zero`:** for arbitrary
  `u r : ℕ → ℝ`, assume `Filter.Tendsto r Filter.atTop (nhds 0)` and
  `∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 → ∀ N : ℕ, ∃ n ≥ N, u n ∈ Set.Ioo a b`.
  Then
  `∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 → ∃ n : ℕ, Int.fract (u n + r n) ∈ Set.Ioo a b`.
  The quarter-width margin handles signed errors and targets touching 0 or 1.
- **P3 — `hitsHexadecimalIntervals_of_hitsOpenIntervals`:** for arbitrary
  `t : ℕ → ℝ`, assume
  `∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 → ∃ n : ℕ, t n ∈ Set.Ioo a b`.
  Then, for every `k m : ℕ` with `m < 16 ^ k`, there exists `n : ℕ` with
  `t n ∈ Set.Ico ((m : ℝ) / (16 : ℝ) ^ k) (((m : ℝ) + 1) / (16 : ℝ) ^ k)`.
  This includes `k = 0`, the first cell, and the last cell.

Neither theorem assumes a global range bound. P3 is independent of B4 and BBP;
B4 retains both convergence and arbitrarily late visitation as hypotheses.

## Files and validation

- Lean: [OrbitCriteria.lean](../PiDisjunctivity/OrbitCriteria.lean) and
  [Test.lean](../Test.lean). Existing root exports and earlier proofs are preserved.
- Plans/status: [proof plan](proof-plan.md), [meta-plan](meta-proof-plan.md),
  [blueprint](proof-blueprint.md), [research log](research-log.md),
  [README](../README.md), [formulation](problem-formulation.md),
  [foundations](foundations-plan.md), and [trust record](dependencies-and-trust.md).
- Handoff: this file. User-owned prompt, Obsidian, and notes changes are excluded
  from both commits.

Baseline and final integrated validation passed from the correct root with
`$HOME/.elan/bin` on `PATH`; Lean reported `4.37.0-rc1`:

```text
lake env lean PiDisjunctivity/OrbitCriteria.lean  PASS
lake build                                     PASS (6655 jobs, no warnings)
lake env lean Test.lean                         PASS (19 theorem audits + 2 definition checks)
git diff --check                               PASS
```

The initial scratch proofs also compiled on their first attempt. Actual axiom
lists for both new theorems were inspected before guarding them: exactly
`propext`, `Classical.choice`, and `Quot.sound`. All seventeen earlier audits
remain. The preservation diff for `lean-toolchain`, `lakefile.toml`,
`lake-manifest.json`, `Definitions.lean`, and `Conjectures.lean` is empty against
the initial baseline. Earlier proof bodies, root imports, and Viewpoint policy
are preserved; source scans and relative Markdown links/anchors were checked.
No clean-environment rebuild or remote CI run is claimed.

## Retrospective and plan decisions

The existing local search/scratch/compiler loop sufficed; no mathematical,
library, compiler, or environment obstacle arose. No extra helpers, examples,
tooling, dependencies, or agents were needed. Post-commit review replaced two
B4 arithmetic tactic calls with direct order transitivity and simplified P3's
upper bound with `div_le_one`. The affected checks above passed again.

Both plans now mark B4/P3 complete and point to the same next bounded task.
Current audit totals are nineteen; historical counts remain intact. The route,
B1-before-B3 order, workflow, and Viewpoint commit cadence are unchanged.
This elementary success supplies no evidence for universal visitation.

## Commits and stopping point

- Initial baseline: `04ac826016f51cb190e44f8ba43dd9b4cc9a5a2a`.
- Milestone implementation, audits, and plans:
  `203e16c56c120072dba04301ef975b76ee342300`.
- Post-commit simplification, review record, and handoff: the commit introducing
  this file; retrieve its ID with
  `git log -1 --format=%H -- docs/b4-p3-handoff.md`.
  The terminal handoff reports the resulting ID after commit creation.

Both commits are local; nothing was pushed or rewritten.

Remaining gaps: B1's BBP identity, B2's orbit bridge, and B3's tail control are
unformalized. V, independent arbitrarily late visitation of the fixed BBP
recurrence, remains the open mathematical obstruction. Hπ and T remain unproved.

**Next task proposed for authorization:**
[B1 source and proof review](proof-plan.md#next-bounded-task-b1-source-and-proof-review).
Deliver a reviewed argument, source/license assessment, pinned-Mathlib dependency
map, and the smallest implementation slice with exact statements/checks.
Stop at the written review or a precise obstruction, before adding any BBP Lean
declarations, adapting code, or starting B2/B3/V. Reordering B3 before B1 remains
a separate user decision.

**Paused here. No next-milestone work has begun.**
