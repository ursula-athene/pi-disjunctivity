# Foundational theorem statements and proof plan

This plan fills the three gaps identified when comparing the Lean definitions
with the [problem formulation](problem-formulation.md). The earlier equivalence
proof has been removed. All three foundational steps are now implemented and
validated as described below. The word–interval and orbit-closure equivalences
are also complete in [milestones A and B](problem-formulation.md#remaining-lean-verification-roadmap).
The final consolidated formulation review remains pending.

The Lean snippets below are the reviewed signatures in the `PiDisjunctivity`
namespace. They intentionally have no proof bodies and are not source files to
compile. Existing definitions stay in `PiDisjunctivity/Definitions.lean`.

## 1. Connect the recursive word value to the finite sum

**Status: implemented and validated.** The proof is in
[`PiDisjunctivity/BlockValue.lean`](../PiDisjunctivity/BlockValue.lean).

The current definition builds a hexadecimal word from left to right:

- The empty word has value zero.
- Appending a digit multiplies the prefix value by 16 and adds the new digit.

We need to show that this definition agrees with the mathematical expression in
the formulation, including the order of the digits:

```lean
theorem blockValue_eq_sum (k : ℕ) (s : Fin k → Fin 16) :
    blockValue k s =
      ∑ i : Fin k, (s i).val * 16 ^ (k - 1 - i.val)
```

**Proof method:** Induct on the length `k`, allowing the word `s` to vary. For
length zero, the sum is empty. For length `k + 1`, split the finite sum into the
first `k` positions and the last position. Each earlier position acquires one
additional factor of 16; the last position has exponent zero. Apply the induction
hypothesis to the prefix, then use the recursive definition.

The index bound `i.val < k` justifies the arithmetic involving natural-number
subtraction in the exponents. Keeping `k` explicit preserves leading zeros even
when two words of different lengths have the same integer value.

**Validation:** `lake build` compiles the universally quantified theorem with
exactly the signature above. `lake env lean Test.lean` checks that this statement
is exported through the library root and that the theorem's only axioms are
`propext`, `Classical.choice`, and `Quot.sound`, with no `sorryAx` or project-specific
axiom. CI runs that audit after the build.

The examples exercise the theorem on an empty word, any one-digit word,
all-zero words of any length, `00A`, `FF`, and the distinct words `12` and `21`.
The latter checks the direction of positional weighting. These examples supplement
the general proof. The header style check is enabled in `lakefile.toml` and
configured for the project's `SPDX-License-Identifier: MIT` line. Lean files
include copyright and author headers; the license text is in [LICENSE](../LICENSE).

## 2. Show that words cover exactly the allowed integer values

**Status: implemented and validated.** Both proofs are in
[`PiDisjunctivity/BlockValue.lean`](../PiDisjunctivity/BlockValue.lean) and exported
through `PiDisjunctivity.lean`.

Two results together establish the required coverage:

```lean
theorem blockValue_lt (k : ℕ) (s : Fin k → Fin 16) :
    blockValue k s < 16 ^ k

theorem exists_blockValue_eq (k m : ℕ) (hm : m < 16 ^ k) :
    ∃ s : Fin k → Fin 16, blockValue k s = m
```

The first theorem prevents out-of-range values. The second supplies a word for
every allowed value, with its length fixed in advance. Together they say that
the image of `blockValue k` is precisely the integers below `16 ^ k`.

**Bound proof method:** Induct on `k`. Use the induction bound for the prefix and
the fact that the appended digit is at most 15. The empty word satisfies `0 < 1`.

**Coverage proof method:** Induct on `k`, allowing `m` to vary. At length zero,
`m < 1` forces `m = 0`, represented by the empty word. At length `k + 1`, divide
`m` by 16:

- `q = m / 16` is below `16 ^ k` and supplies the prefix by induction.
- `r = m % 16` is below 16 and supplies the last digit.
- Append `r` to the prefix, then use `m = 16 * q + r`.

The construction naturally pads with zeros when `m` needs fewer than `k` digits.
It handles `m = 0` and `m = 16 ^ k - 1` as well as interior values.

The implementation checks the quotient bound with `Nat.div_lt_iff_lt_mul` and
`pow_succ`, and the remainder bound with `Nat.mod_lt`. It appends the last digit
with `Fin.snoc`: `Fin.snoc_castSucc` recovers every prefix position and
`Fin.snoc_last` recovers the remainder digit. `Nat.div_add_mod` then identifies
the recursive value `16 * (m / 16) + m % 16` with `m`. For the bound, `omega`
combines the prefix and final-digit inequalities after unfolding the successor
case. Both proofs include length zero.

**Validation:** `lake build`, `lake env lean Test.lean`, and `git diff --check`
pass with the pinned Lean and Mathlib versions. The audit checks both exact
signatures through the library root, alongside the unchanged Step 1 check.
Guarded `#print axioms` results require exactly `propext`, `Classical.choice`, and
`Quot.sound` for each of the three theorems, rejecting unexpected dependencies.
CI runs the expanded audit after the build.

New examples exercise the bound at lengths zero and one, coverage of zero at
every length, all single digits, value 10 at length three (`00A`), value 255 at
length two (`FF`), and `16 ^ k - 1` at every length. The existing exact word-value
and Step 1 regression examples remain. These results establish precisely the
range of fixed-length word values. Further formulation verification is tracked
in the [remaining roadmap](problem-formulation.md#remaining-lean-verification-roadmap).

## 3. Validate digit reconstruction for arbitrary bases

**Status: implemented and validated.** All four proofs are in
[`PiDisjunctivity/Digits.lean`](../PiDisjunctivity/Digits.lean) and exported through
`PiDisjunctivity.lean`.

Use the existing `baseDigit b x n` definition. Assume `2 ≤ b` throughout;
reconstruction and approximation additionally require `0 ≤ x` because the
definition uses `Nat.floor`.

First establish the digit bound. Nonnegativity is already guaranteed by its
natural-number type:

```lean
theorem baseDigit_lt (b : ℕ) (hb : 2 ≤ b) (x : ℝ) (n : ℕ) :
    baseDigit b x n < b
```

**Proof method:** Unfold the digit definition and apply the bound on a remainder
modulo a positive natural number. This bound itself does not need `0 ≤ x`.

Next establish the one-digit recurrence:

```lean
theorem floor_pow_succ (b : ℕ) (hb : 2 ≤ b)
    (x : ℝ) (hx : 0 ≤ x) (n : ℕ) :
    Nat.floor ((b : ℝ) ^ (n + 1) * x) =
      b * Nat.floor ((b : ℝ) ^ n * x) + baseDigit b x n
```

**Proof method:** Show that dividing the larger scaled floor by `b` gives the
previous scaled floor. Its remainder modulo `b` is exactly the next digit by
definition. Apply the natural-number quotient–remainder identity. Check the
floor and cast hypotheses explicitly.

Use this recurrence to reconstruct every finite prefix:

```lean
theorem floor_pow_eq_digits (b : ℕ) (hb : 2 ≤ b)
    (x : ℝ) (hx : 0 ≤ x) (k : ℕ) :
    Nat.floor ((b : ℝ) ^ k * x) =
      b ^ k * Nat.floor x +
        ∑ i : Fin k, baseDigit b x i.val * b ^ (k - 1 - i.val)
```

**Proof method:** Induct on `k`. The zero case reduces to `Nat.floor x`.
For the successor case, apply `floor_pow_succ`, substitute the induction
hypothesis, and split and rearrange the finite sum as in the first theorem.
The term `b ^ k * Nat.floor x` is essential: the statement covers all
nonnegative reals, including numbers with a nonzero integer part.

Finally, quantify how closely these digits approximate `x`:

```lean
theorem truncation_error (b : ℕ) (hb : 2 ≤ b)
    (x : ℝ) (hx : 0 ≤ x) (k : ℕ) :
    let t : ℝ := (Nat.floor ((b : ℝ) ^ k * x) : ℝ) / (b : ℝ) ^ k
    0 ≤ x - t ∧ x - t < 1 / (b : ℝ) ^ k
```

**Proof method:** Apply the defining lower and upper bounds on the natural floor
of `(b : ℝ) ^ k * x`, then divide by the positive number `(b : ℝ) ^ k`.
Combined with `floor_pow_eq_digits`, this identifies the digit sum as the usual
finite base-`b` truncation and gives an explicit error bound at every length.
When $x = m / b^k$ for a natural number $m$, the scaled value is an integer;
the recurrence then gives zero subsequent digits, agreeing with the chosen
trailing-zero convention.

The recurrence proof bounds the larger floor between `q * b` and `(q + 1) * b`,
where `q` is the previous scaled floor, and applies `Nat.div_eq_of_lt_le` to
identify its quotient. `Nat.floor_le`, `Nat.floor_lt`, and `Nat.lt_floor_add_one`
provide the bounds; casts and nonnegativity of the scaled input are checked
explicitly. `Nat.div_add_mod` then supplies the recurrence. Reconstruction uses
`Fin.sum_univ_castSucc` and the index bound to justify the exponent subtraction,
preserving the integer-part term `b ^ k * Nat.floor x`.

The error proof checks that `(b : ℝ) ^ k` is positive, applies the two real floor
bounds, and divides by that positive power. It covers `k = 0`, where truncation
retains just the integer part, and `x = 0`.

**Validation:** `lake build`, `lake env lean Test.lean`, and `git diff --check`
pass without warnings with the unchanged Lean and Mathlib `v4.37.0-rc1` pins.
The audit checks the four reviewed types above through the root import and
preserves the three earlier checks. All seven foundational `#print axioms` results
require exactly `propext`, `Classical.choice`, and `Quot.sound`; an unexpected
dependency fails the audit. CI runs the full audit after the build.

Examples exercise binary digit bounds, decimal one-digit reconstruction, binary
`1.101`, decimal `0.35`, hexadecimal `0.00A` and `3.A0F`, zero at every prefix
length, and the length-zero error bound. Exact checks verify trailing zeros and
zero truncation error for terminating inputs in bases 2, 10, and 16, plus the
error bound for the nonterminating decimal input `1/3`. The earlier word-value
and hexadecimal examples remain unchanged.

## Implementation order and acceptance

1. **Complete:** `PiDisjunctivity/BlockValue.lean` proves the sum formula, the
   bound, and coverage.
2. **Complete:** `PiDisjunctivity/Digits.lean` proves the arbitrary-base digit
   bound, floor recurrence, reconstruction, and error bound.
3. **Complete:** both modules are exported from the library root and build with
   the pinned Lean and Mathlib versions, with no `sorry`, `admit`, or
   project-specific axioms.
4. **Complete:** CI runs guarded audits of the seven foundational theorems'
   transitive axiom dependencies after building, alongside the five additional
   theorem checks from milestones A and B.
5. **Complete:** exact examples cover lengths zero and one, leading zeros,
   all-zero and all-`F` words, and bases 2, 10, and 16 for reconstruction,
   including fractional values and values greater than one. Examples supplement the
   universally quantified theorems.
6. **Complete:** implementation-status documentation records the compiled and
   audited results.

These foundations, the word–interval correspondence, the shift lemma, and the
orbit-closure equivalence (including its π specialization) are complete. The final
consolidated review remains pending in the
[remaining Lean verification roadmap](problem-formulation.md#remaining-lean-verification-roadmap),
using the reviewed foundations. Complete and review that formulation verification
before beginning work on proving hexadecimal disjunctivity of π. The conjecture
proof and the BBP digit-extraction algorithm are separate research tasks.
