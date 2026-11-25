# Consolidated formulation review (milestone C)

**Result: formulation verification complete, 2026-11-24.** The definitions and
proved statements faithfully express the intended problem: every finite
hexadecimal word occurs contiguously after the radix point of Mathlib's `Real.pi`,
including leading zeros, with the trailing-zero convention for terminating
expansions. No correction to the six problem definitions or twelve previously
reviewed theorem statements was needed. The pi disjunctivity conjecture remains
unproved.

This review starts from `dbc50442e8a137d91f394c1fd90617d26f4ed319` on
`feature/attempt-01` in `ursula-athene/pi-disjunctivity`. The initial worktree was
clean. The work implements milestone C of the
[validation roadmap](problem-formulation.md#c-complete-the-formulation-audit-and-review)
and the prompt in [session-prompts.md](session-prompts.md). It reviews the current
foundations and milestones A and B; no discarded proof was restored. The review
was initially prepared as uncommitted changes for review.

## Requirements and evidence

All theorem names below are in the `PiDisjunctivity` namespace. Examples are in
[`Examples.lean`](../PiDisjunctivity/Examples.lean); they supplement the universal
proofs rather than establish the conventions by sampling.

| Requirement | Definitions and general evidence | Relevant examples and checks |
| --- | --- | --- |
| Every finite word has an occurrence; no frequency condition | `IsDisjunctive` in [Definitions.lean](../PiDisjunctivity/Definitions.lean) is `∀ k, ∀ s : Fin k → Fin b, ∃ n, ∀ i : Fin k, ...`. The occurrence may depend on the entire word. There is no frequency, density, or normality predicate. | [Test.lean](../Test.lean) now expands the π proposition to the full quantified floor/modulo formula. |
| Contiguous digits at zero-based positions after the radix point | `baseDigit b x n` uses `Nat.floor ((b : ℝ) ^ (n + 1) * x) % b`. A single `n` is shared by all positions `n + i.val`; there is no separate position choice per digit. `floor_pow_succ` and `baseDigit_fract_pow` verify indexing and shifts. | First digit of `3.A`, all six letters of `0.ABCDEF`, `0F` at offset one in `3.A0F`. |
| Alphabet 0–15; explicit length and leading zeros | Words have type `Fin k → Fin 16`. `baseDigit_lt` bounds actual digits. `blockValue_eq_sum`, `blockValue_lt`, `exists_blockValue_eq`, and `blockValue_injective` verify big-endian value, range, coverage, and uniqueness at fixed length. | Empty and arbitrary single-digit words; all-zero words; `007`, `00A`, `FF`; `12` versus `21`; maximum value at every length. |
| Empty word is vacuous | There are no indices in `Fin 0`. Its value is 0 and its cylinder is `[0,1)`. All range, correspondence, and orbit proofs admit `k = 0`. | An empty word occurs at `n = 0` without any hypothesis; empty-cylinder and closure-to-empty-word checks. |
| Nonnegative inputs and preservation of the integer part | `floor_pow_succ`, `floor_pow_eq_digits`, and `truncation_error` require `0 ≤ x`; reconstruction includes `b ^ k * Nat.floor x`. `baseDigit_lt` only bounds a remainder and needs no sign hypothesis. | Binary `1.101`, decimal `2.7` and `0.35`, hexadecimal `3.A0F`, zero at every length, and length-zero truncation. |
| Canonical trailing-zero expansion | New `baseDigit_div_pow_eq_zero` in [Digits.lean](../PiDisjunctivity/Digits.lean) proves that every digit at position `k + n` of `m / b ^ k` is zero, for all natural `m`, `k`, `n` and `b ≥ 2`. Reconstruction and truncation identify the preceding finite expansion. | Existing termination/error checks and `0.8000...`; new arbitrary-tail examples in bases 2, 10, 16 and all fractional digits of natural integers. |
| Word–interval correspondence in both directions, with correct endpoints | `block_iff_mem_interval` in [Cylinders.lean](../PiDisjunctivity/Cylinders.lean) uses `Set.Ico`, explicit length, fixed-length injectivity, and the digit-shift theorem. | Left endpoint of `00A` included; right endpoint `00B` excluded; `FF` at `255/256`; integer 1 has zero digits; offsets and empty/one-digit cylinders. |
| Orbit closure is exactly `[0,1]`, including both endpoints | `isDisjunctive_iff_orbitClosure` in [OrbitEquivalence.lean](../PiDisjunctivity/OrbitEquivalence.lean) handles arbitrary nonnegative reals, selects shrinking cells including the final cell at 1, and recovers words from open interiors. | Both closure endpoints under disjunctivity; recovery of empty/single-digit words, `00A`, `FF`; zero's singleton orbit rules out disjunctivity of zero. |
| π specialization asserts only equivalence | [Conjectures.lean](../PiDisjunctivity/Conjectures.lean) defines two propositions with `Real.pi`. `piHexadecimalDisjunctivity_iff_orbitClosure` applies the general equivalence with `Real.pi_pos.le`. | Original equivalence-type check retained; two new checks expand the named propositions to the explicit digit and orbit formulations. |

## Review of the universal proofs

### Digits, word values, and truncation

The definitions are total Lean functions: they can be applied syntactically to
negative reals and bases 0 or 1. The intended digit interpretation is restricted
to `x ≥ 0` and `b ≥ 2`. Every theorem needing that interpretation supplies these
hypotheses, or uses a fractional part known to lie in `[0,1)`. The unconditional
digit bound alone does not give a signed expansion for negative reals. The π
instance meets the hypotheses using Mathlib's positivity theorem.

For a nonnegative input, the scaled floors are nonnegative and `Nat.floor`
agrees with the usual integer floor. `floor_pow_succ` bounds the next floor
between `b * q` and `b * (q + 1)`, identifies its quotient by `b` with the previous
floor `q`, and uses quotient–remainder decomposition. Thus the remainder is the
next digit, not an integer-part digit. Induction in `floor_pow_eq_digits` retains
the term `b ^ k * Nat.floor x`, including at `k = 0`.

`truncation_error` divides the floor inequalities by the strictly positive
`(b : ℝ) ^ k`. Together with reconstruction it identifies the usual finite digit
truncation with error in `[0, 1 / b ^ k)`. Mathematically these widths tend to
zero for `b ≥ 2`, so the truncations determine the real value. No separate
infinite-series or limit theorem is added in this phase.

In [BlockValue.lean](../PiDisjunctivity/BlockValue.lean), the sum proof and the
reconstruction proof split off the last position. For earlier positions the
`Fin` bound justifies subtraction in the exponent `k - 1 - i.val`; natural-number
subtraction does not reverse positional order. At length zero the sum is empty.
Coverage uses quotient and remainder to construct a word of the specified length,
so small values are padded with zeros. Injectivity recovers the last digit modulo
16 and the prefix by division. It compares words only at the same length:
`A` and `00A` can have equal integer values without being the same word or having
the same cylinder.

The existing results already justify the terminating convention mathematically,
but the exported API and examples did not explicitly check all later positions.
The added theorem makes that consequence kernel-checked for every base and every
terminating input:

```lean
theorem baseDigit_div_pow_eq_zero (b : ℕ) (hb : 2 ≤ b) (m k n : ℕ) :
    baseDigit b ((m : ℝ) / (b : ℝ) ^ k) (k + n) = 0
```

Its proof cancels the nonzero denominator to identify the scaled real with the
natural integer `b ^ (n + 1) * m`. Its natural floor is exactly that integer,
whose remainder modulo `b` is zero. There is no assumption that `m < b ^ k`,
so nonzero integer parts are included. For `k = 0`, all fractional digits of a
natural integer are zero. This excludes the alternative representation with an
infinite tail of maximal digits without changing the digit definition.

### Word–interval correspondence

The private `baseDigit_fract` helper explicitly uses nonnegativity to replace the
integer floor with the natural floor in `fract x + floor x = x`. Scaling the
integer part contributes a multiple of 16 to the digit floor, which vanishes
modulo 16. `baseDigit_fract_pow` then combines powers to shift position `i` to
`n + i`, with no missing or extra initial digit.

For `y = fract (16 ^ n * x)`, the proof has `0 ≤ y < 1` and `Nat.floor y = 0`.
It constructs the actual length-`k` digit word `d : Fin k → Fin 16`, using
`baseDigit_lt`, and identifies its value with `Nat.floor (16 ^ k * y)` via
reconstruction and the sum formula. In the forward direction, the occurrence
condition gives `d = s`, hence the corresponding floor value. In the reverse
direction, equality of floor values implies `d = s` by fixed-length injectivity,
and the shift theorem recovers every original digit.

`Nat.floor_eq_iff` is applied with a nonnegative argument. Dividing its bounds by
a positive power gives precisely the left-closed/right-open interval
`[blockValue k s / 16 ^ k, (blockValue k s + 1) / 16 ^ k)`. It cannot include the
right boundary: at an internal boundary the next cell starts. At the final
boundary 1, the fractional part resets to 0 and the integer has trailing zeros.
For `k = 0` the same argument yields `[0,1)` and the vacuous digit condition.

### Orbit-closure equivalence and π

The forward proof first contains the entire orbit in `[0,1)` using the bounds on
`Int.fract`, then contains its closure in the closed set `[0,1]`. For the other
inclusion, it treats every `t ∈ [0,1]` and every positive error `ε`. The geometric
power lemma supplies a width `1 / 16 ^ k < ε`.

The private cell-selection lemma uses `Nat.floor (16 ^ k * t)` when `t < 1`,
including `t = 0`. At `t = 1` it instead uses `16 ^ k - 1`, checking the natural
subtraction and the upper endpoint. It places `t` in the *closed* cell, while
the occurrence of the word provided by `exists_blockValue_eq` gives an orbit
point in the corresponding half-open cell. Their distance is at most the cell
width, hence strictly less than `ε`. `Metric.mem_closure_iff` supplies closure
membership even at 1, which is never itself an orbit point.

For the reverse implication, `blockValue_lt` and positivity of `16 ^ k` place
the two endpoints in `[0,1]` with positive separation. Their midpoint is in the
assumed closure and in the *open* interval between them. The closure neighborhood
criterion supplies an actual orbit point inside that interval. Its membership
in the half-open cylinder gives the word occurrence. This avoids incorrectly
inferring an orbit point at a specified boundary. The interval for the empty
word has interior `(0,1)`, so this proof also includes `k = 0`.

Finally, the specialization supplies `Real.pi` and `Real.pi_pos.le`. The two
conjecture declarations are `def ... : Prop`, not proofs or axioms. The theorem
has type `PiHexadecimalDisjunctivity ↔ PiHexadecimalOrbitClosure`; neither side
is obtained without assuming the other. The new literal-definition checks in
`Test.lean` also guard against future changes to the named propositions that an
equivalence-type check alone would not detect.

## Axiom audit

All twelve existing exported-type examples and guarded `#print axioms` checks
are preserved. The termination theorem adds one exported-type example and one
exact-output guard, making thirteen audited theorems. Two additional examples
check the expanded conjecture definitions; they assert neither conjecture.

An unguarded print of all thirteen declarations confirmed these actual
transitive dependencies; the final guarded audit passed with the same lists:

| Theorem (namespace omitted) | Actual axioms |
| --- | --- |
| `blockValue_eq_sum` | `propext`, `Classical.choice`, `Quot.sound` |
| `blockValue_lt` | `propext`, `Classical.choice`, `Quot.sound` |
| `exists_blockValue_eq` | `propext`, `Classical.choice`, `Quot.sound` |
| `baseDigit_lt` | `propext`, `Classical.choice`, `Quot.sound` |
| `floor_pow_succ` | `propext`, `Classical.choice`, `Quot.sound` |
| `floor_pow_eq_digits` | `propext`, `Classical.choice`, `Quot.sound` |
| `truncation_error` | `propext`, `Classical.choice`, `Quot.sound` |
| `blockValue_injective` | `propext`, `Classical.choice`, `Quot.sound` |
| `baseDigit_fract_pow` | `propext`, `Classical.choice`, `Quot.sound` |
| `block_iff_mem_interval` | `propext`, `Classical.choice`, `Quot.sound` |
| `isDisjunctive_iff_orbitClosure` | `propext`, `Classical.choice`, `Quot.sound` |
| `piHexadecimalDisjunctivity_iff_orbitClosure` | `propext`, `Classical.choice`, `Quot.sound` |
| `baseDigit_div_pow_eq_zero` | `propext`, `Classical.choice`, `Quot.sound` |

`#guard_msgs` compares each entire reported list, ignoring only whitespace.
An additional dependency, including `sorryAx` or a project-specific axiom, fails
the audit. A future proof may use fewer permitted axioms, but its changed list
must be inspected before updating the expectation. No guard was weakened.

## Dependency, source, and CI review

The axiom audit and the dependency review address different properties. Each of
the following was inspected separately:

- **Configuration:** `lakefile.toml` has exactly one direct `[[require]]`, Mathlib
  at `v4.37.0-rc1`. `lean-toolchain` and Mathlib's own toolchain file both specify
  `leanprover/lean4:v4.37.0-rc1`. The default target imports all seven project
  modules, including examples. Standard linters, the MIT header check, and public
  module/export conventions remain enabled and intact.
- **Manifest:** Mathlib is locked to
  `31ce06eaadf4a200c0e1407c5f10953cf606b8f8`. The eight inherited entries
  (`plausible`, `LeanSearchClient`, `importGraph`, `proofwidgets`, `aesop`, `Qq`,
  `batteries`, `Cli`) match the pinned Mathlib manifest in all fields other than
  their expected inherited flags. All nine local package checkouts match the
  project manifest revisions and have no tracked changes. No dependency or pin
  file was changed.
- **Source:** All nine project `.lean` files (seven modules, library root, audit)
  were read and their explicit imports inspected. Every import is from `Mathlib`
  or `PiDisjunctivity`. There is no added or vendored library, direct import of a
  transitive package, `sorry`, `admit`, axiom declaration, `native_decide`, or
  unsafe shortcut. Headers attribute copyright and authorship only to Ursula
  Athene.
- **CI:** [.github/workflows/lean_action_ci.yml](../.github/workflows/lean_action_ci.yml)
  still places `lake env lean Test.lean` after `leanprover/lean-action@v1` and
  before documentation generation. The upstream
  [action inputs](https://github.com/leanprover/lean-action/blob/v1/action.yml)
  and [configuration script](https://github.com/leanprover/lean-action/blob/v1/scripts/config.sh)
  were checked: the default auto-configuration runs `lake build`. The workflow
  therefore retains the build-then-audit sequence without requiring changes.
  The validation recorded below was performed locally before committing; no
  remote CI result is claimed.

## Validation and changes

Commands were run from the repository root after adding `$HOME/.elan/bin` to
`PATH`:

| Command or inspection | Result |
| --- | --- |
| `lake env lean --version` | Lean `4.37.0-rc1`, `arm64-apple-darwin24.6.0`, commit `0b77e12952ad39077d80d8bd6b66d601f225c321`. |
| `lake build` | Passed, 6627 jobs, no final build or linter warnings. |
| `lake env lean Test.lean` | Passed with no output; all thirteen exported types and exact axiom guards, plus both definition checks. |
| `lake env lean /tmp/pi-disjunctivity-milestone-c-axioms.lean` | Passed; temporary file imported the library root and printed the thirteen axiom lists recorded above. |
| Configuration, manifest, checkout, and source inspection | Passed the separate Mathlib-only and unchanged-pin checks described above. |
| Preservation and documentation inspection | The twelve original type examples and axiom guards are present verbatim; local documentation link targets exist. |
| `git diff --check` | Passed. |

The only Lean additions are the termination theorem, its type and axiom audit,
two direct conjecture-definition checks, and examples covering arbitrary later
positions and integer inputs. Initial style warnings in the additions were
resolved without disabling any linter. Existing definitions, theorem signatures,
proofs, examples, and guarded lists are preserved. The README, foundations plan,
formulation roadmap, dependency/trust document, and session handoff now record
this completed review.

## Scope and remaining limitations

Milestone C has no outstanding formulation requirement. Kernel checking verifies
the formal proofs relative to the definitions and the permitted foundational
axioms; the comparison to the English problem above is mathematical review,
not a theorem that the kernel can establish. The audit does not independently
verify Lean's implementation or rebuild and recheck every imported Mathlib
artifact. The [trust document](dependencies-and-trust.md) records this boundary.

The interval and orbit equivalences are hexadecimal and assume nonnegative
inputs; only the digit foundations and termination theorem are arbitrary-base.
No claim about negative-input expansions, normality, frequencies, occurrence
bounds, or an algorithm for finding occurrences in π is made. No proof of π
disjunctivity or BBP formalization was attempted. The pi disjunctivity conjecture
remains unproved, and work on either research task requires separate
authorization.
