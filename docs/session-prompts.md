# Session prompts

Milestone C is complete; see the [consolidated review](formulation-review.md).
The prompt below is retained as the record of the authorized review scope, not
as a pending task. Formulation verification is complete, and the pi disjunctivity
conjecture remains unproved. A proof attempt or BBP formalization requires
separate authorization. The older
[Step 2 prompt](step-2-session-prompt.md) is retained as historical context;
that foundational step is already complete.

## Next session: final formulation audit and review (milestone C)

**Completed 2026-11-24. Historical prompt follows.**

Complete **milestone C, "Complete the formulation audit and review,"** in
`docs/problem-formulation.md`. This authorizes the review, necessary corrections,
validation, and documentation within that scope, not merely another plan.

We want to finish verifying that our Lean formulation expresses the intended
problem: every finite hexadecimal word occurs contiguously after the radix point
of pi, including words with leading zeros. We are not yet working on a proof that
pi has this property. Do not begin conjecture-proof research or BBP formalization.

### Read the current project first

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

### Perform the consolidated review

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

### Constraints and validation

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
