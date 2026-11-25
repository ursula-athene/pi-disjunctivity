# Formulation review follow-up

**Completed 2026-11-24.**

This follow-up implements the recommendations from the assessment of the
[external verification report](agy-reports/formulation-verification-report.md).
It preserves the milestone C definitions, thirteen reviewed theorem signatures,
proofs, and exact axiom guards. The base-16 interval/orbit scope is unchanged.

## Findings addressed

| Finding | Resolution |
| --- | --- |
| No actual π digit check | `Examples.lean` now proves that fractional hexadecimal positions 0–3 of `Real.pi` are `2, 4, 3, 15`. |
| Out-of-domain behavior | Definition docstrings and the problem statement explicitly describe the intended `b ≥ 2`, `x ≥ 0` domain and the negative-input/degenerate-base behavior. No definition changed. |
| Infinite reconstruction | `hasSum_baseDigit` proves convergence of the positional digit series to `Int.fract x` in every base at least two, for every nonnegative real. |
| Arbitrarily late occurrences | `isDisjunctive_occurs_ge` supplies an occurrence beyond every threshold under disjunctivity. The problem statement explains infinite occurrence and finite-prefix invariance. |
| Empty-word notation | The English specification defines `[k] = {i ∈ ℕ : i < k}`, including `[0] = ∅`. |
| Base-16 scope | Retained intentionally; arbitrary-base interval/orbit generalization remains deferred. |
| Repository hygiene | Removed the unused, tracked, zero-byte `import` file. |

## Proof and statement review

The π example uses Mathlib's `Real.pi_gt_d6` and `Real.pi_lt_d6` to bound the
scaled floors by consecutive integers. The floors at scales 16, 256, 4096,
and 65536 are 50, 804, 12867, and 205887. Their remainders modulo 16 are the
four claimed digits. These are exact inequalities checked by Lean, with no
new digit-extraction algorithm or distribution assumption.

The new reconstruction statement in
[`Digits.lean`](../PiDisjunctivity/Digits.lean) is:

```lean
theorem hasSum_baseDigit (b : ℕ) (hb : 2 ≤ b) (x : ℝ) (hx : 0 ≤ x) :
    HasSum (fun n => (baseDigit b x n : ℝ) / (b : ℝ) ^ (n + 1)) (Int.fract x)
```

For nonnegative `x`, the identity `fract x + Nat.floor x = x` shows that scaling
the integer part contributes a multiple of `b` to the next digit floor. Thus
our digits agree with the values of `Real.digits (Int.fract x) b`. Equality of
the summands transfers Mathlib's `Real.hasSum_ofDigitsTerm_digits` to the stated
series. `HasSum` asserts actual convergence, not only an equality involving
the total `tsum` operation. The sign and base hypotheses are explicit, and the
series sums to the fractional part even when `x` has a nonzero integer part.

The recurrence statement in
[`Disjunctivity.lean`](../PiDisjunctivity/Disjunctivity.lean) is:

```lean
theorem isDisjunctive_occurs_ge (b : ℕ) (hb : 2 ≤ b) (x : ℝ)
    (h : IsDisjunctive b x) (k : ℕ) (s : Fin k → Fin b) (N : ℕ) :
    ∃ n, N ≤ n ∧ ∀ i : Fin k, baseDigit b x (n + i.val) = (s i).val
```

The proof applies disjunctivity to the length-`N + k` word formed by prepending
`N` zeros to `s`. If it occurs at `n`, its suffix occurs at `n + N ≥ N`.
`Fin.append_right` recovers the original word at every suffix position. This
includes `k = 0` and `N = 0`, preserves leading zeros, and requires no sign
hypothesis. It is conditional on disjunctivity and proves no word-occurrence
claim for pi without that hypothesis.

The documented finite-prefix argument works for any digit sequence: inserting
a finite prefix preserves all existing occurrences, and removing one preserves
arbitrarily late occurrences. No general sequence API or integer-digit encoder
was added solely to restate that argument.

The external report now distinguishes its original, untracked verification
script from the checked-in evidence. Its base-comparison note also says that
no hexadecimal-to-decimal implication is established here, rather than inferring
nonimplication for pi solely from multiplicative independence.

## Validation

| Check | Result |
| --- | --- |
| `lake build` | Passed, 6653 jobs, no final build or linter warnings; includes the π digit example and both new lemmas. |
| `lake env lean Test.lean` | Passed with no output: fifteen theorem-type and exact axiom checks, plus both expanded conjecture-definition checks. |
| Independent `#print axioms` for the two additions | Both report exactly `[propext, Classical.choice, Quot.sound]`; the same lists are now guarded in `Test.lean`. |
| Preservation inspection | All thirteen prior axiom guards and all fifteen prior theorem/definition examples remain verbatim. |
| Dependency and source inspection | Pin and dependency files unchanged; all explicit imports are from Mathlib or this project; no forbidden proof shortcuts. |
| Documentation links and `git diff --check` | Passed. |

The fifteen audited theorems are the thirteen listed in the
[milestone C audit](formulation-review.md#axiom-audit), plus
`PiDisjunctivity.hasSum_baseDigit` and `PiDisjunctivity.isDisjunctive_occurs_ge`.
Every current guarded list is exactly `propext`, `Classical.choice`, and
`Quot.sound`. The π example is compiled with the library; it is not an exported
theorem in that count. The original reviewer's nine-theorem temporary script
was not available, and no claim to have reproduced that entire script is made.

The changes use only Mathlib and local project imports. `lakefile.toml`,
`lake-manifest.json`, and `lean-toolchain` remain unchanged, retaining Lean and
Mathlib `v4.37.0-rc1`. No conjecture proof or BBP formalization was attempted.
