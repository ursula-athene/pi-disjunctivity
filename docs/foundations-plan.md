# Foundational theorem statements and proof plan

This plan fills the three gaps identified when comparing the Lean definitions
with the [problem formulation](problem-formulation.md). The earlier equivalence
proof has been removed. Step 1 is now implemented and validated as described
below; Steps 2 and 3 remain planned.

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

**Status: planned.**

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
It must handle `m = 0` and `m = 16 ^ k - 1` as well as interior values.

## 3. Validate digit reconstruction for arbitrary bases

**Status: planned.**

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

## Implementation order and acceptance

1. Put the word-value results in a new `PiDisjunctivity/BlockValue.lean` module.
   Prove the sum formula, the bound, and then coverage.
2. Put the arbitrary-base results in a new `PiDisjunctivity/Digits.lean` module.
   Prove the digit bound, floor recurrence, reconstruction, and error bound.
3. Import both modules from the library root and build them with the pinned
   Lean and Mathlib versions. Add no `sorry`, `admit`, or project-specific axioms.
4. Add an axiom audit for the new results and wire it into CI. Check the transitive
   dependencies, permitting only the standard Lean axioms used by Mathlib.
5. Extend exact examples to cover lengths zero and one, leading zeros, all-zero
   and all-`F` words, and bases 2, 10, and 16 for reconstruction. Include both
   fractional values and values greater than one. Examples supplement the
   universally quantified theorems.
6. Update the implementation-status documentation only after the corresponding
   statements have been compiled and audited.

These foundations are the immediate scope. The word–interval correspondence,
shift lemma, and orbit-closure equivalence require a subsequent proof plan using
the reviewed foundations. Proving hexadecimal disjunctivity of π, and formalizing
the BBP digit-extraction algorithm, are separate research tasks.
