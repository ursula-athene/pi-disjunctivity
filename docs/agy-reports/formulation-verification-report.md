# Formulation Verification Report: `pi-disjunctivity`

- **Date:** 2026-11-24
- **Repository audited:** [`pi-disjunctivity/`](../../) (branch `feature/attempt-01`, commit `ae2ba3f`)
- **Toolchain verified:** Lean `4.37.0-rc1` (`0b77e12952ad39077d80d8bd6b66d601f225c321`) + Mathlib `v4.37.0-rc1` (`31ce06eaadf4a200c0e1407c5f10953cf606b8f8`)

**Follow-up:** The findings below describe the audited commit above. The
[subsequent improvements](../review-follow-up.md) add checked-in π digit examples,
infinite reconstruction and recurrence proofs, clearer domain/empty-word
documentation, and remove the empty `import` file. Hexadecimal specialization
remains intentional. The original `verify_audit.lean` mentioned below is not
checked into the repository, so its nine-theorem run remains the original
reviewer's reported result. The follow-up records the checks that are now
reproducible from the project itself.

---

## Executive Verdict

**The problem formulation is mathematically sound and faithfully formalized in Lean 4.** Both the English specification and the Lean 4 statements accurately express **hexadecimal (base-16) disjunctivity of $\pi$**—every finite string of hexadecimal digits (with explicit length and leading zeros preserved) occurs contiguously after the radix point in the base-16 expansion of $\pi$—as well as its equivalent dynamical-systems characterization via the closure of the $\times 16 \bmod 1$ orbit in $[0, 1]$.

No logical bugs, misstated quantifiers, off-by-one indexing errors, boundary errors, `sorry`s, custom axioms, or unsound shortcuts were found. All builds, repository audits, and an independent 9-theorem Lean verification script pass cleanly using only the three standard Lean axioms (`propext`, `Classical.choice`, `Quot.sound`).

That said, the audit identified **six minor, non-blocking observations** (missing sanity checks, edge-case behavior outside the intended domain, unproved-but-true prose bridges, scope choices, and one minor repository-hygiene defect). None of them invalidate the conjecture statement or any proved theorem.

For a detailed side-by-side comparison of this attempt's formalizations and proofs against Google DeepMind's `formal-conjectures` and other proof-assistant efforts, see the companion [Literature Review Report](literature-review-report.md).

---

## Summary of Findings

| # | Severity | Area | Summary |
| --- | --- | --- | --- |
| 1 | Minor (Testing gap) | Lean examples | `Examples.lean` tests only rational numbers and never verifies any hexadecimal digit of `Real.pi` itself. |
| 2 | Minor (Domain edge cases) | Lean definitions | `baseDigit` and `IsDisjunctive` are total functions: for `x < 0` (`b ≥ 2`), `IsDisjunctive b x` is always `False` (even when `hexadecimalOrbit x` has closure `[0, 1]`), and for `b ∈ {0, 1}`, `IsDisjunctive b x` is vacuously/trivially `True` for all `x`. Harmless for `b = 16, x = Real.pi`, and properly guarded in theorems. |
| 3 | Minor (Completeness) | Lean / English bridge | Infinite-series convergence ($\operatorname{fract}(x) = \sum_{n=0}^{\infty} d_b(x, n)/b^{n+1}$) and equivalence with including the integer part / occurring infinitely often are only noted informally or omitted, rather than proved in the library. |
| 4 | Minor (Notation) | English spec | In `docs/problem-formulation.md`, $s : \{0,\ldots,k-1\} \to \{0,\ldots,b-1\}$ for $k \in \mathbb{N}$ relies on the implicit convention $\{0,\ldots,-1\} = \emptyset$ when $k = 0$ (though clarified immediately in prose and exact in Lean via `Fin k`). |
| 5 | Minor (Scope) | Lean generality | `blockValue`, `hexadecimalOrbit`, `Cylinders.lean`, and `OrbitEquivalence.lean` are hardcoded to base `16`, whereas `baseDigit`, `IsDisjunctive`, and `Digits.lean` are parameterized by arbitrary `b`. |
| 6 | Minor (Repo hygiene) | Repository | A stray 0-byte file `pi-disjunctivity/import` is tracked in Git (from initial commit `e85a8c85`) and was missed by the Milestone C review. |

---

## Verification Executed in Lean

All checks were run locally against the project's pinned Lean `v4.37.0-rc1` and Mathlib `v4.37.0-rc1`:

1. **Full library build (`lake build`):** Passed cleanly across 6,627 jobs with zero errors and zero linter/compiler warnings (including `PiDisjunctivity.Examples`).
2. **Repository audit (`lake env lean Test.lean`):** Passed with zero errors and zero output, confirming:
   - Definitional equality (`Iff.rfl`) of `PiHexadecimalDisjunctivity` and `PiHexadecimalOrbitClosure` to their fully expanded quantified floor/modulo and orbit-closure formulas.
   - Exact exported signatures of all 13 reviewed theorems.
   - Exact `#guard_msgs` axiom lists for all 13 theorems: `[propext, Classical.choice, Quot.sound]`.
3. **Forbidden-token scan:** `grep` across all 9 project `.lean` files confirmed zero occurrences of `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by`, or `extern`.
4. **Independent Lean verification script (`verify_audit.lean`, run locally during this review):** Compiled cleanly with `lake env lean` (exit code 0, only `[propext, Classical.choice, Quot.sound]`), proving 9 additional theorems directly against `PiDisjunctivity`:
   - `pi_floor_eq_three`: `Nat.floor Real.pi = 3`
   - `pi_hex_digits_0_to_3`: `baseDigit 16 Real.pi 0 = 2 ∧ baseDigit 16 Real.pi 1 = 4 ∧ baseDigit 16 Real.pi 2 = 3 ∧ baseDigit 16 Real.pi 3 = 15` (i.e., $\pi = 3.243\text{F}\ldots_{16}$)
   - `hasSum_baseDigit`: `HasSum (fun n => (baseDigit b x n : ℝ) / (b : ℝ) ^ (n + 1)) (Int.fract x)` for all `b ≥ 2`, `x ≥ 0`
   - `not_isDisjunctive_of_neg`: `∀ b ≥ 2, ∀ x < 0, ¬ IsDisjunctive b x`
   - `isDisjunctive_zero_trivial` and `isDisjunctive_one_trivial`: `IsDisjunctive 0 x` and `IsDisjunctive 1 x` for all `x : ℝ`
   - `isDisjunctive_occurs_ge`: for `b ≥ 2`, `IsDisjunctive b x` implies every word occurs starting at some `n ≥ N` for every `N : ℕ`
   - `isDisjunctive_iff_dmIsRichInBase`: equivalence with DeepMind Formal Conjectures' `NormalNumber.IsRichInBase` for `x ≥ 0`
   - `orbitClosure_iff_dense_addCircle`: equivalence between `closure (hexadecimalOrbit x) = Set.Icc 0 1` and DeepMind Formal Conjectures' `Dense (Set.range fun n => ((16 : ℝ) ^ n * x : AddCircle 1))`

---

## Detailed Analysis of the English Formulation

The primary English specification lives in [`docs/problem-formulation.md`](../problem-formulation.md), summarized in [`README.md`](../../README.md) and audited in [`docs/formulation-review.md`](../formulation-review.md).

### What is verified correct

1. **Intended mathematical property:**
   > "Every finite string of hexadecimal digits occurs contiguously after the radix point in the base-16 expansion of $\pi$."

   This matches the standard mathematical definition of a **disjunctive** (also called **rich** or **lexicon**) number in base 16. The documentation accurately distinguishes disjunctivity (existence of occurrences, no frequency constraint) from **normality** (asymptotic frequency $16^{-k}$ for every length-$k$ block).
2. **Digit alphabet and leading zeros:** Digits are `0`–`9`, `A`–`F` (values $0$–$15$). Fixing word length $k$ explicitly preserves leading zeros (`007` and `7` are distinct words with distinct cylinders $[7/16^3, 8/16^3)$ and $[7/16, 8/16)$).
3. **Digit extraction formula:** For $x \ge 0$, $b \ge 2$, and $n \in \mathbb{N}$,
   $$d_b(x, n) = \lfloor b^{n+1} x \rfloor \bmod b.$$
   At $n = 0$, $d_b(x, 0) = \lfloor b x \rfloor \bmod b$ is the first digit after the radix point (e.g., for $\pi = 3.243\text{F}\ldots_{16}$, $\lfloor 16\pi \rfloor = 50 = 3 \cdot 16 + 2$, giving $d_{16}(\pi, 0) = 2$).
4. **Ambiguity of terminating expansions:** For any $b$-adic rational $m/b^k$, the floor convention selects the canonical representation with trailing zeros rather than trailing $(b-1)$s. Moreover, since $\pi$ is irrational, its base-16 expansion is unique and never hits a dyadic boundary anyway.
5. **Word–interval correspondence and orbit-closure equivalence:**
   - $m_s = \sum_{i=0}^{k-1} s(i) 16^{k-1-i}$ encodes length-$k$ words bijectively onto $\{0, \dots, 16^k - 1\}$.
   - Occurrence of $s$ at position $n$ is equivalent to $\operatorname{fract}(16^n x) \in [m_s / 16^k, (m_s + 1) / 16^k)$ (left-closed, right-open).
   - For $x \ge 0$, $\operatorname{Disjunctive}_{16}(x) \iff \overline{O_{16}(x)} = [0, 1]$ (closure in $\mathbb{R}$), where $O_{16}(x) = \{\operatorname{fract}(16^n x) : n \in \mathbb{N}\}$. Both boundary subtleties—approximating $1 \notin O_{16}(x)$ in the forward direction and using the open interior $(m_s/16^k, (m_s+1)/16^k)$ in the reverse direction—are explained accurately.
6. **BBP motivation and scope discipline:** The documentation clearly explains that the Bailey–Borwein–Plouffe (1997) identity motivates choosing base 16, while explicitly acknowledging that digit extraction does not by itself prove disjunctivity and that the conjecture about $\pi$ remains completely open and unproved.

### Minor English observations

- **Notation for $k = 0$ (Finding #4):** In `docs/problem-formulation.md` (line 56), the quantified statement writes $\forall k \in \mathbb{N},\; \forall s : \{0, \ldots, k-1\} \to \{0, \ldots, b-1\}$. When $k = 0$, $\{0, \dots, k-1\}$ is mildly informal notation for the empty set $\emptyset$. Line 67 immediately clarifies that "$k = 0$ imposes no condition" and corresponds to `Fin 0 → Fin b`, so there is no ambiguity in practice.
- **Integer part vs. fractional part (Finding #3):** Some authors define disjunctivity over *all* digits of $x$ (including the integer part) rather than strictly *after the radix point*. Because any real number has finitely many integer-part digits (just one digit, `3`, for $\pi$) and disjunctivity implies every word occurs starting arbitrarily far out (verified in `isDisjunctive_occurs_ge`), both definitions are strictly equivalent. Mentioning this explicitly in `docs/problem-formulation.md` would strengthen the English justification.

---

## Detailed Analysis of the Lean Formalization

All nine `.lean` files were inspected line by line:
- [`PiDisjunctivity/Definitions.lean`](../../PiDisjunctivity/Definitions.lean)
- [`PiDisjunctivity/BlockValue.lean`](../../PiDisjunctivity/BlockValue.lean)
- [`PiDisjunctivity/Digits.lean`](../../PiDisjunctivity/Digits.lean)
- [`PiDisjunctivity/Cylinders.lean`](../../PiDisjunctivity/Cylinders.lean)
- [`PiDisjunctivity/Conjectures.lean`](../../PiDisjunctivity/Conjectures.lean)
- [`PiDisjunctivity/OrbitEquivalence.lean`](../../PiDisjunctivity/OrbitEquivalence.lean)
- [`PiDisjunctivity/Examples.lean`](../../PiDisjunctivity/Examples.lean)
- [`PiDisjunctivity.lean`](../../PiDisjunctivity.lean)
- [`Test.lean`](../../Test.lean)

### Core definitions and conjecture statements

```lean
noncomputable def baseDigit (b : ℕ) (x : ℝ) (n : ℕ) : ℕ :=
  Nat.floor ((b : ℝ) ^ (n + 1) * x) % b

def IsDisjunctive (b : ℕ) (x : ℝ) : Prop :=
  ∀ (k : ℕ) (s : Fin k → Fin b),
    ∃ n : ℕ, ∀ i : Fin k,
      baseDigit b x (n + i.val) = (s i).val

noncomputable def hexadecimalOrbit (x : ℝ) : Set ℝ :=
  Set.range (fun n : ℕ => Int.fract ((16 : ℝ) ^ n * x))

def PiHexadecimalDisjunctivity : Prop := IsDisjunctive 16 Real.pi

def PiHexadecimalOrbitClosure : Prop :=
  closure (hexadecimalOrbit Real.pi) = Set.Icc (0 : ℝ) 1
```

Every detail of these definitions checks out:
- **Quantifier order:** `∀ (k : ℕ) (s : Fin k → Fin b), ∃ n : ℕ, ∀ i : Fin k, ...` gives one starting index `n` per word `(k, s)`, shared across all `i : Fin k`, guaranteeing contiguous occurrence.
- **Zero-based fractional indexing:** `baseDigit 16 x (n + i.val)` uses exponent `n + i.val + 1`, so `n = 0, i = 0` extracts the first digit after the hexadecimal point.
- **Explicit length and alphabet bounds:** Typing `s : Fin k → Fin 16` forces exact length `k` and digit values `0 ≤ (s i).val < 16`.
- **No hidden assumptions:** `Conjectures.lean` defines both conjectures as `def ... : Prop`, never asserting them. `Test.lean` proves `Iff.rfl` against the fully unfolded floor/modulo and orbit-closure expressions, ruling out hidden definition drift.
- **Theorem proofs:** All 13 exported theorems (`blockValue_eq_sum`, `blockValue_lt`, `exists_blockValue_eq`, `blockValue_injective`, `baseDigit_lt`, `floor_pow_succ`, `floor_pow_eq_digits`, `truncation_error`, `baseDigit_div_pow_eq_zero`, `baseDigit_fract_pow`, `block_iff_mem_interval`, `isDisjunctive_iff_orbitClosure`, `piHexadecimalDisjunctivity_iff_orbitClosure`) are clean, direct, kernel-checked proofs with no shortcuts.

### Detailed explanation of minor findings

#### 1. No sanity check on actual digits of `Real.pi`
`Examples.lean` thoroughly exercises `baseDigit`, `blockValue`, `floor_pow_eq_digits`, `truncation_error`, `baseDigit_div_pow_eq_zero`, `block_iff_mem_interval`, and `isDisjunctive_iff_orbitClosure` on exact rationals (`58/16`, `7/4096`, `0xABCDEF/16^6`, `0x3A0F/16^3`, `1/2`, `1/3`, `0`, `1`). However, neither `Examples.lean` nor `Test.lean` checks a single hexadecimal digit of `Real.pi` itself.

While Mathlib's `Real.pi` is well-established, adding a concrete check of its initial hexadecimal digits using Mathlib's existing `Real.pi_gt_d6` and `Real.pi_lt_d6` ($3.141592 < \pi < 3.141593$) directly verifies end-to-end that `PiDisjunctivity.baseDigit 16 Real.pi` produces `2, 4, 3, 15` (`3.243F...₁₆`). We verified this in `verify_audit.lean` (`pi_floor_eq_three` and `pi_hex_digits_0_to_3`) in ~15 lines with zero extra dependencies beyond Mathlib.

#### 2. Behavior of `baseDigit` and `IsDisjunctive` on out-of-domain inputs (`x < 0` and `b < 2`)
In Lean/Mathlib, total functions often have conventional "junk values" outside their intended mathematical domain, and `docs/formulation-review.md` explicitly documents that `x ≥ 0` and `b ≥ 2` are the intended domain. Still, two subtle consequences are worth recording explicitly:

- **Negative reals (`x < 0`):** Because `baseDigit` calls `Nat.floor ((b : ℝ) ^ (n + 1) * x)` directly without first taking `Int.fract x`, any `x < 0` yields `(b : ℝ) ^ (n + 1) * x ≤ 0`, so `Nat.floor` returns `0` and `baseDigit b x n = 0` for all `n`. Thus `¬ IsDisjunctive b x` holds for *every* `x < 0` and `b ≥ 2` (proved in `verify_audit.lean` as `not_isDisjunctive_of_neg`). By contrast, `hexadecimalOrbit x` uses `Int.fract ((16 : ℝ) ^ n * x)`, which remains nontrivial on negative inputs—for example, `closure (hexadecimalOrbit (-x)) = [0, 1]` whenever `closure (hexadecimalOrbit x) = [0, 1]` for irrational `x`. This asymmetry is the exact reason `isDisjunctive_iff_orbitClosure` requires `hx : 0 ≤ x`. (Compare with DeepMind Formal Conjectures, which defines `digitSeq b x n := ⌊(b : ℝ) ^ (n + 1) * Int.fract x⌋₊ % b` and therefore needs no sign hypothesis in its equivalence theorem.)
- **Degenerate bases (`b = 0` and `b = 1`):** For `b = 0`, `Fin k → Fin 0` is empty whenever `k ≥ 1` and vacuous for `k = 0`, so `IsDisjunctive 0 x` is vacuously `True` for every `x : ℝ`. For `b = 1`, `baseDigit 1 x n = 0` and every `s : Fin k → Fin 1` is constantly `0`, so `IsDisjunctive 1 x` is trivially `True` for every `x : ℝ`. Both were verified in `verify_audit.lean` (`isDisjunctive_zero_trivial`, `isDisjunctive_one_trivial`).

Neither issue affects `PiHexadecimalDisjunctivity` (`b = 16`, `Real.pi > 0`), and every theorem in the library that depends on the intended domain explicitly carries `hb : 2 ≤ b` and/or `hx : 0 ≤ x`.

#### 3. Infinite-series reconstruction and infinitely-often occurrence not formalized in the library
- `Digits.lean` proves `floor_pow_eq_digits` and `truncation_error`, and `docs/formulation-review.md` notes honestly that "No separate infinite-series or limit theorem is added in this phase." Proving `HasSum (fun n => (baseDigit b x n : ℝ) / (b : ℝ) ^ (n + 1)) (Int.fract x)` (as we did in `hasSum_baseDigit` in `verify_audit.lean`) directly confirms in Lean that `baseDigit` is the genuine infinite positional expansion of `Int.fract x`, leaving no gap between the finite truncation inequalities and the infinite base-$b$ expansion.
- Similarly, proving that `IsDisjunctive b x` implies every word occurs at arbitrarily large positions `n ≥ N` (`isDisjunctive_occurs_ge` in `verify_audit.lean`) is a 10-line corollary that formally confirms equivalence between "occurs at least once" and "occurs infinitely often," as well as invariance under dropping the finite integer part.

#### 4. Base-16 specialization vs. arbitrary-base generality
`Definitions.lean` and `Digits.lean` already parameterize `baseDigit` and `IsDisjunctive` by `b : ℕ`, whereas `blockValue`, `hexadecimalOrbit`, `Cylinders.lean`, and `OrbitEquivalence.lean` hardcode `16`. This is a completely valid scoping choice aligned with the project's BBP motivation, and all documentation states this boundary accurately. However, none of the proofs in `BlockValue.lean`, `Cylinders.lean`, or `OrbitEquivalence.lean` use any property specific to `16` other than `2 ≤ 16`; parameterizing them by `(b : ℕ) (hb : 2 ≤ b)` would be a small refactor if future work compares base 2, base 10, and base 16.

*(Note on mathematical scope: hexadecimal disjunctivity of $\pi$ implies base-2 disjunctivity of $\pi$, because any binary word can be extended to a 4-bit-aligned binary word, hence encoded as a hexadecimal word. No hexadecimal-to-decimal implication is established here. Since $16$ and $10$ are multiplicatively independent, the grouping argument for powers of a common base does not supply one; that observation alone is not a proof of nonimplication for the particular number $\pi$.)*

#### 5. Stray tracked file `pi-disjunctivity/import`
At the audited commit, a 0-byte file named `import` existed at the root of `pi-disjunctivity/`, committed in `e85a8c85` ("initial addition"). It did not affect Lean compilation or any proof, and was likely an accidental shell artifact. It was overlooked in `docs/formulation-review.md` and has been removed in the follow-up.

---

## Conclusion

The formulation-verification milestone (Milestone C) of `pi-disjunctivity` achieved its goal. Both the English problem statement and the Lean 4 formalization accurately, cleanly, and without logical loopholes express the open conjecture that $\pi$ is hexadecimal-disjunctive, and the equivalence with full closure of the base-16 fractional-part orbit in $[0, 1]$ is genuinely kernel-verified under standard axioms. Addressing the minor suggestions above (removing the stray `import` file, optionally adding a 4-digit `Real.pi` sanity check and the `HasSum` / infinitely-often lemmas) would polish an already rigorous foundation.
