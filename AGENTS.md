# Repository instructions

## Lean dependency policy

The formulation must rely on Mathlib as its only direct external Lean library.
Our own Lean definitions, lemmas, and proofs are permitted when they depend only
on Mathlib, Lean's core/standard libraries, and other project modules satisfying
the same rule.

- Do not add other external Lean libraries through Lake, vendoring, or imports.
- Mathlib's own pinned transitive dependencies are part of the permitted Mathlib
  stack. Preserve them as supplied by Mathlib; their presence is not permission
  to add independent library dependencies or direct imports of those packages.
- Keep the Lean and Mathlib `v4.37.0-rc1` pins unless the user explicitly requests
  an upgrade.
- Use kernel-checked proofs. Add no project-specific axioms, `sorry`, `admit`,
  `native_decide` proof bypasses, or unsafe proof shortcuts. The only permitted
  axiom dependencies are `propext`, `Classical.choice`, and `Quot.sound`;
  individual theorems may use fewer. Preserve and extend the guarded audits in
  `Test.lean` when adding reviewed theorems.

See [dependencies and trust](docs/dependencies-and-trust.md) for the rationale,
current dependency inventory, and the distinction between proof checking and
review of the intended problem statement.

## Scope and validation

Complete and review the Lean formulation of the problem before beginning work
on proving the pi disjunctivity conjecture. Follow the current status and
milestones in [the problem formulation](docs/problem-formulation.md).

For Lean changes, run `lake build`, `lake env lean Test.lean`, and
`git diff --check` from this directory. If needed, add `$HOME/.elan/bin` to
`PATH`. Preserve the existing `module`, import, and public-section conventions,
MIT SPDX headers, and enabled linters. Copyright and author attribution must
use only Ursula Athene.
