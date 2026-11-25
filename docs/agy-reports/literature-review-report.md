# Literature Review & Comparative Analysis: Formalizations of Disjunctivity and Normality of $\pi$

- **Date:** 2026-11-24
- **Scope:** Lean 4 / Mathlib (including direct inspection of [`pi-disjunctivity/`](../../), [`deepmind-formal-conjectures/`](../../../deepmind-formal-conjectures/), and Mathlib `v4.37.0-rc1`) and the broader interactive theorem proving ecosystem (Isabelle/HOL, Coq/Rocq, HOL Light).

---

## Executive Summary

1. **No formal (or informal) proof exists** that $\pi$ is disjunctive (rich) or normal in any integer base $b \ge 2$—including base 16, base 2, and base 10. This remains a major open problem in number theory; even whether every decimal or hexadecimal digit occurs infinitely often in $\pi$ is unproven.
2. **Google DeepMind's `formal-conjectures` repository contains an equivalent Lean 4 formalization of disjunctivity (called *richness*) and its orbit-density equivalence**, plus a formalization of the **stronger** open conjecture that $\pi$ is normal in base 10:
   - `NormalNumber.IsRichInBase b x` (machine-verified during this review to be logically equivalent to `PiDisjunctivity.IsDisjunctive b x` for all $x \ge 0$).
   - `BugeaudNormalAndRich.isRichInBase_iff_dense` (stating the orbit-density equivalence in `AddCircle 1` for arbitrary base $b \ge 2$ and all $\xi \in \mathbb{R}$, with a linked Lean 4 formal proof in Ralf Stephan's `rwst/formal-conjectures` repository).
   - `NormalNumber.pi_normal_base_ten : IsNormalInBase 10 π` (open conjecture; no separate base-16 or disjunctivity-of-$\pi$ conjecture exists there).
3. **Comparing formalizations and proofs with this attempt (`pi-disjunctivity`):**
   - For $\pi$ (and all $x \ge 0$ in base 16), the two formalizations are **provably equivalent** (both the digit-block predicate and the orbit-density/closure characterization).
   - **`pi-disjunctivity`** is stronger as a **self-contained, axiom-audited verification** of the digit-to-interval-to-orbit equivalence (zero `sorry`s in-repo, explicit finite-sum and truncation foundations, guarded `#print axioms`, Mathlib-only dependencies).
   - **`deepmind-formal-conjectures`** is broader in **domain generality and surrounding theory** (arbitrary base $b \ge 2$, sign-free `Int.fract`-based `digitSeq`, quotient-circle `AddCircle 1` topology, normality $\to$ richness, block complexity / entropy characterizations, and Wall's equidistribution theorem), while externalizing the main orbit-equivalence proofs (`isRichInBase_iff_dense`, `isNormalInBase_iff_isEquidistributedModuloOne`) to `rwst/formal-conjectures`.
4. **Mathlib (`v4.37.0-rc1`)** does not yet include normal numbers, disjunctive/rich numbers, fractional base-$b$ expansions of reals, Borel's normal number theorem, Champernowne's constant, or the BBP formula.
5. **Outside Lean 4**, no proof assistant has a proof of $\pi$'s disjunctivity or normality, though **HOL Light** (John Harrison) and **Coq** contain verified formalizations of BBP-type series identities and certified $\pi$ digit computations.

---

## Mathematical Context

For an integer base $b \ge 2$ and a real number $x$, the classical hierarchy of digit-randomness properties is:

$$\text{Absolutely Normal} \implies \text{Normal in base } b \implies \text{Disjunctive (Rich) in base } b \implies \text{Not eventually periodic (hence irrational)}.$$

Key classical characterizations (Wall 1949; Bugeaud, *Distribution Modulo One and Diophantine Approximation*, Cambridge Univ. Press, 2012, Ch. 4 & Ch. 10):

- **Normality in base $b$** $\iff$ $(b^n x)_{n \ge 0}$ is **uniformly distributed (equidistributed) modulo 1** (Wall 1949; Bugeaud 2012, Theorem 4.14).
- **Disjunctivity / richness in base $b$** $\iff$ $(b^n x)_{n \ge 0}$ is **dense modulo 1** (Bugeaud 2012, Section 4.4) $\iff$ the base-$b$ block complexity is maximal, $p(n) = b^n$ for all $n \ge 1$ (which implies maximal base-$b$ entropy $\log b$).
- **BBP connection (base 16):** Bailey, Borwein, and Plouffe (1997) discovered the base-16 digit-extraction formula for $\pi$. Bailey and Crandall (2001, *Experimental Mathematics* 10(2), 175–190) formulated **Hypothesis A** (an equidistribution conjecture for $x_n = \{16 x_{n-1} + r(n)\}$) and showed it implies base-16 normality—and hence base-16 disjunctivity—of $\pi$. Hypothesis A remains open.

---

## Detailed Review of DeepMind's `formal-conjectures`

We inspected the local checkout at [`deepmind-formal-conjectures/`](../../../deepmind-formal-conjectures/) (toolchain `leanprover/lean4:v4.33.1`). It contains a substantial, directly related Lean 4 infrastructure across **six main files**.

### Relevant Files and Declarations

1. **[`FormalConjecturesForMathlib/NumberTheory/NormalNumber.lean`](../../../deepmind-formal-conjectures/FormalConjecturesForMathlib/NumberTheory/NormalNumber.lean)**
   - `NormalNumber.digitSeq (b : ℕ) (x : ℝ) (n : ℕ) : ℕ := ⌊(b : ℝ) ^ (n + 1) * Int.fract x⌋₊ % b`
   - `NormalNumber.IsSimplyNormalInBase (b : ℕ) (x : ℝ) : Prop` (limiting frequency $1/b$ for each single digit $d < b$)
   - `NormalNumber.IsNormalInBase (b : ℕ) (x : ℝ) : Prop` (limiting frequency $1/b^k$ for every length-$k$ word $w : \mathrm{Fin}\ k \to \mathbb{N}$ with $\forall j,\ w\ j < b$)
   - `NormalNumber.IsAbsolutelyNormal (x : ℝ) : Prop := ∀ b ≥ 2, IsNormalInBase b x`
   - `NormalNumber.IsRichInBase (b : ℕ) (x : ℝ) : Prop`:
     ```lean
     def IsRichInBase (b : ℕ) (x : ℝ) : Prop :=
       ∀ (k : ℕ) (w : Fin k → ℕ), (∀ j, w j < b) →
         ∃ i, ∀ j : Fin k, digitSeq b x (i + j) = w j
     ```
     Its docstring explicitly notes: *"A real number `x` is **rich** (or **disjunctive**) in base `b` if every string `w` of `k` digits `< b` occurs at least once in the base-`b` fractional expansion of `x`."*
   - **Proved inline (no `sorry`):** `IsNormalInBase.isSimplyNormalInBase` and `IsNormalInBase.isRichInBase`.

2. **[`FormalConjectures/Wikipedia/NormalityOfPi.lean`](../../../deepmind-formal-conjectures/FormalConjectures/Wikipedia/NormalityOfPi.lean)**
   - States the open conjecture (`@[category research open, AMS 11]`):
     ```lean
     theorem pi_normal_base_ten : IsNormalInBase 10 π := by sorry
     ```
   - There is **no** separate theorem for `IsRichInBase 10 π`, `IsRichInBase 16 π`, or `IsNormalInBase 16 π`. However, `pi_normal_base_ten.isRichInBase` would immediately yield `IsRichInBase 10 π`.

3. **[`FormalConjectures/Books/BugeaudDistributionModuloOne/NormalAndRich.lean`](../../../deepmind-formal-conjectures/FormalConjectures/Books/BugeaudDistributionModuloOne/NormalAndRich.lean)**
   - States both classical equivalences for arbitrary `b ≥ 2` and arbitrary `ξ : ℝ`:
     ```lean
     theorem isNormalInBase_iff_isEquidistributedModuloOne (b : ℕ) (hb : 2 ≤ b) (ξ : ℝ) :
         IsNormalInBase b ξ ↔ IsEquidistributedModuloOne fun n => (b : ℝ) ^ n * ξ := by
       sorry

     theorem isRichInBase_iff_dense (b : ℕ) (hb : 2 ≤ b) (ξ : ℝ) :
         IsRichInBase b ξ ↔
           Dense (Set.range fun n => (↑((b : ℝ) ^ n * ξ) : AddCircle (1 : ℝ))) := by
       sorry
     ```
   - Per `formal-conjectures` repository policy, proofs of solved/textbook theorems are not stored inline in the main repository; instead, both theorems carry `@[formal_proof using formal_conjectures at ...]` metadata pointing to Ralf Stephan's verified Lean 4 proofs at:
     `https://github.com/rwst/formal-conjectures/blob/a522a5352dd28df0b5ef08c213c368b5f6a5df6e/FormalConjectures/Books/BugeaudDistributionModuloOne/NormalAndRich.lean` (lines 459 and 466).

4. **[`FormalConjecturesForMathlib/NumberTheory/ExpansionEntropy.lean`](../../../deepmind-formal-conjectures/FormalConjecturesForMathlib/NumberTheory/ExpansionEntropy.lean)** & **[`BlockComplexity.lean`](../../../deepmind-formal-conjectures/FormalConjecturesForMathlib/Dynamics/SymbolicDynamics/BlockComplexity.lean)**
   - **Proved inline (no `sorry`):**
     - `NormalNumber.isRichInBase_iff_blockComplexity`: `IsRichInBase b ξ ↔ ∀ n, blockComplexity (digitSeq b ξ) n = (b : ℝ≥0∞) ^ n` (for `b ≥ 1`).
     - `NormalNumber.IsRichInBase.baseEntropy_eq`: rich numbers have base-$b$ entropy `log b`.
     - `NormalNumber.IsRichInBase.not_isEventuallyPeriodic`: the base-$b$ expansion of a rich number (`b ≥ 2`) is not eventually periodic.

5. **[`FormalConjecturesForMathlib/Analysis/Equidistribution/ModOne.lean`](../../../deepmind-formal-conjectures/FormalConjecturesForMathlib/Analysis/Equidistribution/ModOne.lean)**
   - Defines `IsEquidistributed` and `IsEquidistributedModuloOne`, and **proves inline** `IsEquidistributedModuloOne.dense_range` (uniform distribution mod 1 implies density in `AddCircle 1`).

6. **[`FormalConjectures/Wikipedia/AlgebraicNormality.lean`](../../../deepmind-formal-conjectures/FormalConjectures/Wikipedia/AlgebraicNormality.lean)** & **[`Problem10_53.lean`](../../../deepmind-formal-conjectures/FormalConjectures/Books/BugeaudDistributionModuloOne/Problem10_53.lean)**
   - Formalize Borel's conjecture on normality of irrational algebraic numbers (citing Bailey–Crandall 2001) and Bugeaud Problem 10.53 (Temur 2026) on irrational numbers with simultaneously small continued-fraction and base-$b$ entropies.

### Notable Historical Lesson from `deepmind-formal-conjectures` Git History

Inspecting the Git log of `deepmind-formal-conjectures` reveals a concrete cautionary tale about formulation verification:

- **2026-05-08 (`a5e109fa`, PR #3926, closes #2255):** Silvère Gangloff and Paul Lezeau added `NormalityOfPi.lean` and `NormalNumber.lean`. Their original `IsNormalInBase` only checked **single-digit** frequency (`1/b`)—which is *simple normality* (satisfied, e.g., by rational $1/3 = 0.010101\ldots_2$ in base 2!), not full normality.
- **2026-09-12 (`bdc88821`, PR #5752, fixes #5700, #5710):** Salvatore Mercuri caught the bug four months later, renamed the single-digit predicate to `IsSimplyNormalInBase`, and redefined `IsNormalInBase` over all finite digit blocks of length `k`.
- **2026-10-25 (`c9197749`, PR #6790):** Ralf Stephan (`rwst`) introduced `IsRichInBase`, `NormalAndRich.lean`, block complexity, and entropy characterizations.

This history underscores why `pi-disjunctivity`'s dedicated formulation-verification phase is genuinely valuable.

---

## Detailed Comparison: Formalizations and Proofs vs. This Attempt (`pi-disjunctivity`)

### 1. Comparing the Formalizations (Definitions & Statements)

| Dimension | This Attempt (`pi-disjunctivity`) | DeepMind `formal-conjectures` | Assessment / Tradeoff |
| --- | --- | --- | --- |
| **Target conjecture** | `PiHexadecimalDisjunctivity := IsDisjunctive 16 Real.pi` and `PiHexadecimalOrbitClosure` (`def ... : Prop`) | `pi_normal_base_ten : IsNormalInBase 10 π := by sorry` | DeepMind states a strictly stronger property (normality vs. disjunctivity) in base 10; `pi-disjunctivity` targets base-16 disjunctivity to align with BBP digit extraction. Neither base implies the other (`10` and `16` are multiplicatively independent). Naming conjectures as `def ... : Prop` (rather than `theorem ... := by sorry`) avoids `sorry` warnings and lets `pi-disjunctivity` keep a 100% sorry-free build. |
| **Digit extraction** | `baseDigit b x n := Nat.floor ((b : ℝ) ^ (n + 1) * x) % b` | `digitSeq b x n := ⌊(b : ℝ) ^ (n + 1) * Int.fract x⌋₊ % b` | **Identical on $x \ge 0$** (proved in `verify_audit.lean`). On $x < 0$, `baseDigit` degenerates to constant `0` (requiring `hx : 0 ≤ x` in theorems), whereas `digitSeq` applies `Int.fract x ∈ [0, 1)` first, so it remains well-behaved for all `x : ℝ` (extracting digits of `1 - Int.fract (-x)` for negative irrationals). |
| **Word representation** | `s : Fin k → Fin b` (digit bounds baked into the type) | `w : Fin k → ℕ` plus separate hypothesis `∀ j, w j < b` | **Logically equivalent** (`isDisjunctive_iff_dmIsRichInBase`). `pi-disjunctivity`'s `Fin k → Fin b` prevents out-of-range digits by construction and makes `blockValue : (k : ℕ) → (Fin k → Fin 16) → ℕ` total without extra proof arguments; DeepMind's `Fin k → ℕ` avoids `.val` coercions when matching `digitSeq : ℕ → ℕ` and simplifies `SymbolicDynamics.blockComplexity` set comprehensions. |
| **Degenerate bases (`b = 0, 1`)** | `IsDisjunctive 0 x` and `IsDisjunctive 1 x` are vacuously/trivially `True` | Same for `IsRichInBase 0 x` and `IsRichInBase 1 x` | Identical behavior; both libraries guard arbitrary-base theorems with `2 ≤ b` (or `1 ≤ b` for block complexity). |
| **Dynamical / topological statement** | `closure (Set.range (fun n => Int.fract ((16 : ℝ) ^ n * x))) = Set.Icc (0 : ℝ) 1` in `ℝ` | `Dense (Set.range fun n => (↑((b : ℝ) ^ n * ξ) : AddCircle (1 : ℝ)))` in `ℝ/ℤ` | **Strictly equivalent for all `x : ℝ`** (`orbitClosure_iff_dense_addCircle` in `verify_audit.lean`). Working in `ℝ` with `Set.Icc 0 1` is more elementary and self-evident to read, but requires handling the endpoint `1` separately (since `1 ∉ range Int.fract`). Working in `AddCircle 1` identifies `0` and `1` cleanly and lets `Dense` be used directly, at the cost of quotient-group topology boilerplate. |
| **Alternative characterizations** | Word–interval correspondence (`Set.Ico`) + orbit closure in `[0, 1]` | `AddCircle 1` density + `blockComplexity = b^n` + `baseEntropy = log b` + `¬ IsEventuallyPeriodic` | DeepMind embeds disjunctivity into a wider symbolic-dynamics and equidistribution API; `pi-disjunctivity` focuses tightly on the cylinder/orbit equivalence needed for BBP-style dynamical analysis. |
| **Base generality** | `baseDigit`, `IsDisjunctive`, `Digits.lean` are arbitrary-base; `BlockValue.lean`, `Cylinders.lean`, `OrbitEquivalence.lean` are hardcoded to base `16` | Fully parameterized by arbitrary `b : ℕ` (`2 ≤ b`) throughout | DeepMind's formulation is immediately reusable for bases 2, 10, 16, etc.; `pi-disjunctivity`'s base-16 proofs use no property special to `16` beyond `2 ≤ 16` and could easily be generalized. |

### Machine-Verified Equivalence Between the Two Formalizations

During this review, we directly proved in Lean 4 (in the local verification script `verify_audit.lean`, using only `[propext, Classical.choice, Quot.sound]`):

1. **`isDisjunctive_iff_dmIsRichInBase`**: For every `b : ℕ` and `x : ℝ` with `0 ≤ x`, `PiDisjunctivity.IsDisjunctive b x ↔ NormalNumber.IsRichInBase b x`.
2. **`orbitClosure_iff_dense_addCircle`**: For every `x : ℝ`, `closure (PiDisjunctivity.hexadecimalOrbit x) = Set.Icc (0 : ℝ) 1 ↔ Dense (Set.range fun n : ℕ => (((16 : ℝ) ^ n * x : ℝ) : AddCircle (1 : ℝ)))`.

---

### 2. Comparing the Proofs (Architecture, Techniques, Coverage, and Trust)

#### A. What `pi-disjunctivity` proves (all self-contained, in-repo, zero `sorry`)

`pi-disjunctivity` builds a clean, four-layer bottom-up proof stack (totaling ~400 lines of proof code across 5 modules plus 284 lines of concrete examples and 168 lines of axiom/signature guards):

1. **Positional word arithmetic ([`BlockValue.lean`](../../PiDisjunctivity/BlockValue.lean), 96 lines):**
   - Proves `blockValue_eq_sum`, `blockValue_lt`, `exists_blockValue_eq`, and `blockValue_injective` by elementary induction on word length `k` using `Fin.sum_univ_castSucc`, `Fin.snoc`, `Nat.div_add_mod`, and `Fin.lastCases`.
   - This explicitly justifies big-endian ordering, leading-zero preservation, and bijectivity between `Fin k → Fin 16` and `{m : ℕ | m < 16^k}`.
2. **Arbitrary-base digit foundations ([`Digits.lean`](../../PiDisjunctivity/Digits.lean), 99 lines):**
   - Proves `baseDigit_lt`, the scaled-floor recurrence `floor_pow_succ` (bounding `Nat.floor (b^(n+1) * x)` via `Nat.div_eq_of_lt_le`), prefix reconstruction `floor_pow_eq_digits` (explicitly retaining `b^k * Nat.floor x`), truncation error `truncation_error` in `[0, 1/b^k)`, and trailing zeros for terminating expansions `baseDigit_div_pow_eq_zero`.
3. **Cylinder-interval bridge ([`Cylinders.lean`](../../PiDisjunctivity/Cylinders.lean), 73 lines):**
   - Proves integer-part invariance (`baseDigit_fract`), digit shifting (`baseDigit_fract_pow`), and the central word–interval equivalence `block_iff_mem_interval`:
     - Sets `y = Int.fract (16^n * x)`, builds the actual digit word `d : Fin k → Fin 16`, equates `blockValue k d = Nat.floor (16^k * y)` via `floor_pow_eq_digits` + `blockValue_eq_sum`, applies `blockValue_injective` for the reverse direction, and finishes with `Nat.floor_eq_iff` to obtain the exact half-open interval `Set.Ico`.
4. **Orbit-closure equivalence ([`OrbitEquivalence.lean`](../../PiDisjunctivity/OrbitEquivalence.lean), 96 lines):**
   - **Forward (`IsDisjunctive 16 x → closure (hexadecimalOrbit x) = Set.Icc 0 1`):** Uses `closure_minimal` + `isClosed_Icc` for `⊆`, and `Metric.mem_closure_iff` + `exists_pow_lt_of_lt_one` + `exists_hexadecimal_cell` (special-casing `t = 1` with `16^k - 1` and using `Nat.floor (16^k * t)` for `t < 1`) + `exists_blockValue_eq` + `block_iff_mem_interval` for `⊇`.
   - **Reverse (`closure ... = Set.Icc 0 1 → IsDisjunctive 16 x`):** Evaluates the cylinder midpoint `(lower + upper) / 2`, notes it lies in the **open** interior `Set.Ioo lower upper`, extracts an orbit point inside `Set.Ioo lower upper ⊆ Set.Ico lower upper` via `mem_closure_iff`, and converts it back to a word occurrence via `block_iff_mem_interval`.
   - **Specialization:** `piHexadecimalDisjunctivity_iff_orbitClosure` applies `Real.pi_pos.le`.
5. **Audit & testing discipline ([`Examples.lean`](../../PiDisjunctivity/Examples.lean), [`Test.lean`](../../Test.lean)):**
   - Every one of the 13 exported theorems has a `#guard_msgs` exact axiom check (`[propext, Classical.choice, Quot.sound]`), and both named $\pi$ propositions have `Iff.rfl` definitional-expansion checks.

#### B. What DeepMind `formal-conjectures` proves (inline vs. externally linked)

DeepMind's repository splits its proofs across two tiers:

1. **Inline verified proofs in `FormalConjecturesForMathlib/` (zero `sorry`):**
   - **`NormalNumber.IsNormalInBase.isRichInBase`** ([`NormalNumber.lean`](../../../deepmind-formal-conjectures/FormalConjecturesForMathlib/NumberTheory/NormalNumber.lean#L106-L118), 13 lines): Proves normality implies disjunctivity purely combinatorially/analytically by contradiction—if a block `w` never occurs, the filtered count is `0` for all `n`, so its limiting frequency is `0`, contradicting `tendsto_nhds_unique` against `1 / b^k ≠ 0`. Notably, this proof requires *zero* digit-reconstruction or cylinder-interval machinery.
   - **`NormalNumber.isRichInBase_iff_blockComplexity`**, **`baseEntropy_eq`**, and **`not_isEventuallyPeriodic`** ([`ExpansionEntropy.lean`](../../../deepmind-formal-conjectures/FormalConjecturesForMathlib/NumberTheory/ExpansionEntropy.lean#L101-L161) + [`BlockComplexity.lean`](../../../deepmind-formal-conjectures/FormalConjecturesForMathlib/Dynamics/SymbolicDynamics/BlockComplexity.lean#L108-L155)): Uses `Set.encard` against `Fintype.piFinset (fun _ : Fin n => Finset.range b)` (size `b^n`) to prove disjunctivity $\iff$ maximal block complexity `b^n`, deduces maximal entropy `log b`, and combines with the easy direction of Morse–Hedlund (`IsEventuallyPeriodic.blockComplexity_le`) to prove rich/normal numbers cannot be eventually periodic.
   - **`IsEquidistributedModuloOne.dense_range`** ([`ModOne.lean`](../../../deepmind-formal-conjectures/FormalConjecturesForMathlib/Analysis/Equidistribution/ModOne.lean#L44-L69), 25 lines): Pulls an open set `U ⊆ AddCircle 1` back along `AddCircle.continuous_mk' 1` to `ℝ`, finds a ball around `t = Int.fract q`, shrinks to the closed interval `[t, min (t + ε/2) 1] ⊆ [0, 1]`, and uses positive limiting frequency to extract an orbit hit in `U`. Notice how `AddCircle 1` avoids the `t = 1` boundary case-split required in `pi-disjunctivity`'s `exists_hexadecimal_cell`!
2. **Externalized proofs (`NormalAndRich.lean` $\to$ `rwst/formal-conjectures`):**
   - In the local `deepmind-formal-conjectures` checkout itself, `isNormalInBase_iff_isEquidistributedModuloOne` and `isRichInBase_iff_dense` are **stated with `by sorry`** (per benchmark policy separating conjectures/statements from proofs) and annotated with `@[formal_proof using formal_conjectures at "https://github.com/rwst/formal-conjectures/blob/a522a5352dd28df0b5ef08c213c368b5f6a5df6e/FormalConjectures/Books/BugeaudDistributionModuloOne/NormalAndRich.lean#L459"]` (and `#L466`).
   - Because `rwst/formal-conjectures` is an external GitHub repository not checked out locally, its proof internals were not directly kernel-checked during this audit (unlike `pi-disjunctivity`, which was fully compiled and axiom-audited locally). From the line numbers (`#L459`, `#L466`), Ralf Stephan's file proves both Wall's equidistribution theorem and the richness–density equivalence together in ~470 lines, sharing base-$b$ cylinder/digit machinery for arbitrary `b ≥ 2` and all `ξ : ℝ`.

#### C. Proof-Coverage Matrix: Who Proves What?

| Result | `pi-disjunctivity` (local, verified) | DeepMind `formal-conjectures` (local) | `rwst/formal-conjectures` (linked external) |
| --- | --- | --- | --- |
| Big-endian word value = finite sum, `< b^k`, surjectivity, injectivity | **Proved** (base 16, `BlockValue.lean`) | Not exported | — |
| Arbitrary-base digit bound, floor recurrence, prefix reconstruction, truncation error | **Proved** (all `b ≥ 2, x ≥ 0`, `Digits.lean`) | Not exported | — |
| Terminating expansion has all trailing zeros | **Proved** (all `b ≥ 2`, `Digits.lean`) | Not exported | — |
| Word occurrence $\iff$ shifted fractional part in `[m/b^k, (m+1)/b^k)` | **Proved** (base 16, `Cylinders.lean`) | Not exported | Internal helper (likely) |
| Disjunctive/Rich $\iff$ orbit dense / closure `[0, 1]` | **Proved** (base 16, `x ≥ 0`, `OrbitEquivalence.lean`) | Stated (`sorry`, all `b ≥ 2, ξ : ℝ`) | **Proved** (`#L466`) |
| Normal $\iff$ equidistributed mod 1 (Wall 1949) | Not included | Stated (`sorry`, all `b ≥ 2, ξ : ℝ`) | **Proved** (`#L459`) |
| Normal $\implies$ Disjunctive/Rich | Not included | **Proved inline** (`NormalNumber.lean`) | Inherited |
| Equidistributed mod 1 $\implies$ Dense mod 1 | Not included | **Proved inline** (`ModOne.lean`) | Inherited |
| Disjunctive/Rich $\iff$ maximal block complexity `b^n` | Not included | **Proved inline** (`ExpansionEntropy.lean`) | Inherited |
| Disjunctive/Rich $\implies$ entropy `log b` & not eventually periodic | Not included | **Proved inline** (`ExpansionEntropy.lean`) | Inherited |
| Disjunctivity / Normality of $\pi$ | **Open** (`def : Prop`, unproved) | **Open** (`pi_normal_base_ten`, `sorry`) | **Open** |
| Automated `#print axioms` guards & concrete digit examples | **Yes** (13 guarded theorems + 284-line `Examples.lean`) | No `#print axioms` guards; no `NormalNumber` test file | — |

---

## Broader Lean 4 / Mathlib and Proof-Assistant Ecosystem

### Lean 4 and Mathlib
- **Mathlib (`v4.37.0-rc1`):** Direct inspection of `Mathlib/NumberTheory` and `Mathlib/Analysis` confirms that Mathlib currently lacks definitions for base-$b$ fractional expansions of real numbers, disjunctive/rich numbers, normal numbers, Borel's normal number theorem, Champernowne's constant, or the BBP formula. Mathlib provides the underlying building blocks (`Real.pi` and numerical bounds, `Nat.floor`, `Int.fract`, `AddCircle`, measure theory, and probability/ergodic infrastructure).
- **Ralf Stephan (`rwst/formal-conjectures`):** Contains the Lean 4 formal proofs of both Wall's theorem (`isNormalInBase_iff_isEquidistributedModuloOne`) and the disjunctivity/density equivalence (`isRichInBase_iff_dense`) linked from `google-deepmind/formal-conjectures`, along with Bugeaud distribution-modulo-one developments.
- **Other Lean 4 / Palomar ecosystem projects:** Recent Lean 4 work around the Palomar registry and `FormalConjectures` explores related questions in digital expansions, block complexity, automatic sequences, and normality constraints (e.g., Bugeaud's problems and prefix properties of normal numbers), though none prove disjunctivity or normality of $\pi$ or formalize a BBP-based proof attempt.

### Other Proof Assistants (Isabelle/HOL, Coq/Rocq, HOL Light)
- **Disjunctivity / normality of $\pi$:** No formalization of a proof exists in Isabelle/HOL, Coq/Rocq, HOL Light, Mizar, or Metamath, because the theorem is open in mathematics.
- **General normal-number theory:** Formalizations of Borel's normal number theorem or normality of Champernowne's constant remain largely absent from mainstream standard libraries (Mathlib, Isabelle AFP, Coq/MathComp).
- **BBP formula and certified $\pi$ digit computation (compared to `pi-disjunctivity`):**
  - **HOL Light** (John Harrison) formalizes polylogarithmic series evaluations and BBP-related identities for $\pi$.
  - **Coq** (e.g., INRIA work on certified $\pi$ computation) formalizes verified executable algorithms for computing specific digits of $\pi$.
  - **Comparison with this attempt:** Those formalizations prove *analytic series identities and digit-computation correctness* for $\pi$, whereas `pi-disjunctivity` formalizes and validates the *combinatorial/dynamical disjunctivity conjecture itself*. Combining both—formalizing the BBP identity in Lean 4 on top of `pi-disjunctivity`'s validated digit/orbit framework—would be a genuinely novel Lean 4 contribution (even though proving disjunctivity or Bailey–Crandall's Hypothesis A remains an open research problem).

---

## Takeaways for `pi-disjunctivity`

1. **Independent cross-validation:** `pi-disjunctivity`'s formulation agrees—down to machine-checked logical equivalence—with DeepMind's independent formalization (`NormalNumber.IsRichInBase` and `BugeaudNormalAndRich.isRichInBase_iff_dense`).
2. **Distinctive strengths of this attempt:** Compared to `google-deepmind/formal-conjectures`, `pi-disjunctivity` stands out for having **complete, self-contained, zero-`sorry`, axiom-audited proofs** of the foundational digit reconstruction, cylinder correspondence, and orbit-closure equivalence directly inside the repository, relying solely on Mathlib.
3. **Concrete ideas worth adopting from DeepMind's formalization (if extending `pi-disjunctivity`):**
   - Generalizing `BlockValue.lean`, `Cylinders.lean`, and `OrbitEquivalence.lean` from `16` to arbitrary `b ≥ 2` would align cleanly with Bugeaud's general theory.
   - Adding the `AddCircle 1` density equivalence, block-complexity (`p(n) = 16^n`) characterization, and `IsDisjunctive → ¬ IsEventuallyPeriodic` (or infinitely-often occurrence) would enrich the API at very low proof cost.
   - Using `Int.fract x` inside `baseDigit` (as in DeepMind's `digitSeq`) would remove the `0 ≤ x` side condition if negative reals ever enter scope (though not needed for $\pi$).
4. **Next-step perspective:** Proving `PiHexadecimalDisjunctivity` (or Bailey–Crandall's Hypothesis A) is a deep unsolved problem in mathematics. As a concrete, achievable next milestone in Lean 4, formalizing the **BBP formula for $\pi$** and connecting it to `PiDisjunctivity.hexadecimalOrbit Real.pi` would fill a genuine gap in the Lean 4 / Mathlib ecosystem.
