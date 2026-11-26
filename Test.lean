/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

import PiDisjunctivity

/-! Audit definitions, foundations, orbit criteria, and BBP analytic lemmas after `lake build`. -/

-- Compare the named π statements directly with the reviewed quantified problem and orbit.
example : PiDisjunctivity.PiHexadecimalDisjunctivity ↔
    ∀ (k : ℕ) (s : Fin k → Fin 16), ∃ n : ℕ, ∀ i : Fin k,
      Nat.floor ((16 : ℝ) ^ (n + i.val + 1) * Real.pi) % 16 = (s i).val :=
  Iff.rfl

example : PiDisjunctivity.PiHexadecimalOrbitClosure ↔
    closure (Set.range (fun n : ℕ => Int.fract ((16 : ℝ) ^ n * Real.pi))) =
      Set.Icc (0 : ℝ) 1 :=
  Iff.rfl

-- This is the reviewed statement, including its full quantification and digit order.
example (k : ℕ) (s : Fin k → Fin 16) :
    PiDisjunctivity.blockValue k s =
      ∑ i : Fin k, (s i).val * 16 ^ (k - 1 - i.val) :=
  PiDisjunctivity.blockValue_eq_sum k s

-- The range statements retain the length, including zero and leading-zero words.
example (k : ℕ) (s : Fin k → Fin 16) :
    PiDisjunctivity.blockValue k s < 16 ^ k :=
  PiDisjunctivity.blockValue_lt k s

example (k m : ℕ) (hm : m < 16 ^ k) :
    ∃ s : Fin k → Fin 16, PiDisjunctivity.blockValue k s = m :=
  PiDisjunctivity.exists_blockValue_eq k m hm

-- Arbitrary-base bounds need no sign hypothesis; reconstruction and error retain it.
example (b : ℕ) (hb : 2 ≤ b) (x : ℝ) (n : ℕ) :
    PiDisjunctivity.baseDigit b x n < b :=
  PiDisjunctivity.baseDigit_lt b hb x n

example (b : ℕ) (hb : 2 ≤ b) (x : ℝ) (hx : 0 ≤ x) (n : ℕ) :
    Nat.floor ((b : ℝ) ^ (n + 1) * x) =
      b * Nat.floor ((b : ℝ) ^ n * x) + PiDisjunctivity.baseDigit b x n :=
  PiDisjunctivity.floor_pow_succ b hb x hx n

example (b : ℕ) (hb : 2 ≤ b) (x : ℝ) (hx : 0 ≤ x) (k : ℕ) :
    Nat.floor ((b : ℝ) ^ k * x) =
      b ^ k * Nat.floor x +
        ∑ i : Fin k, PiDisjunctivity.baseDigit b x i.val * b ^ (k - 1 - i.val) :=
  PiDisjunctivity.floor_pow_eq_digits b hb x hx k

example (b : ℕ) (hb : 2 ≤ b) (x : ℝ) (hx : 0 ≤ x) (k : ℕ) :
    let t : ℝ := (Nat.floor ((b : ℝ) ^ k * x) : ℝ) / (b : ℝ) ^ k
    0 ≤ x - t ∧ x - t < 1 / (b : ℝ) ^ k :=
  PiDisjunctivity.truncation_error b hb x hx k

-- Fixed-length uniqueness and shifting support both directions of the correspondence.
example (k : ℕ) : Function.Injective (PiDisjunctivity.blockValue k) :=
  PiDisjunctivity.blockValue_injective k

example (x : ℝ) (hx : 0 ≤ x) (n i : ℕ) :
    PiDisjunctivity.baseDigit 16 (Int.fract ((16 : ℝ) ^ n * x)) i =
      PiDisjunctivity.baseDigit 16 x (n + i) :=
  PiDisjunctivity.baseDigit_fract_pow x hx n i

example (x : ℝ) (hx : 0 ≤ x) (n k : ℕ) (s : Fin k → Fin 16) :
    (∀ i : Fin k, PiDisjunctivity.baseDigit 16 x (n + i.val) = (s i).val) ↔
      Int.fract ((16 : ℝ) ^ n * x) ∈
        Set.Ico ((PiDisjunctivity.blockValue k s : ℝ) / (16 : ℝ) ^ k)
          (((PiDisjunctivity.blockValue k s : ℝ) + 1) / (16 : ℝ) ^ k) :=
  PiDisjunctivity.block_iff_mem_interval x hx n k s

-- The orbit equivalence covers every nonnegative real; its π instance asserts only equivalence.
example (x : ℝ) (hx : 0 ≤ x) :
    PiDisjunctivity.IsDisjunctive 16 x ↔
      closure (PiDisjunctivity.hexadecimalOrbit x) = Set.Icc (0 : ℝ) 1 :=
  PiDisjunctivity.isDisjunctive_iff_orbitClosure x hx

example : PiDisjunctivity.PiHexadecimalDisjunctivity ↔ PiDisjunctivity.PiHexadecimalOrbitClosure :=
  PiDisjunctivity.piHexadecimalDisjunctivity_iff_orbitClosure

-- The final review makes the trailing-zero convention explicit at every later position.
example (b : ℕ) (hb : 2 ≤ b) (m k n : ℕ) :
    PiDisjunctivity.baseDigit b ((m : ℝ) / (b : ℝ) ^ k) (k + n) = 0 :=
  PiDisjunctivity.baseDigit_div_pow_eq_zero b hb m k n

-- Infinite reconstruction and arbitrarily late occurrence retain their complete hypotheses.
example (b : ℕ) (hb : 2 ≤ b) (x : ℝ) (hx : 0 ≤ x) :
    HasSum (fun n => (PiDisjunctivity.baseDigit b x n : ℝ) / (b : ℝ) ^ (n + 1))
      (Int.fract x) :=
  PiDisjunctivity.hasSum_baseDigit b hb x hx

example (b : ℕ) (hb : 2 ≤ b) (x : ℝ) (h : PiDisjunctivity.IsDisjunctive b x)
    (k : ℕ) (s : Fin k → Fin b) (N : ℕ) :
    ∃ n, N ≤ n ∧ ∀ i : Fin k, PiDisjunctivity.baseDigit b x (n + i.val) = (s i).val :=
  PiDisjunctivity.isDisjunctive_occurs_ge b hb x h k s N

-- The pilot exposes interval hitting as a hypothesis, including all lengths and cell values.
example (x : ℝ) (hx : 0 ≤ x) :
    PiDisjunctivity.IsDisjunctive 16 x ↔
      ∀ (k m : ℕ), m < 16 ^ k → ∃ n : ℕ,
        Int.fract ((16 : ℝ) ^ n * x) ∈
          Set.Ico ((m : ℝ) / (16 : ℝ) ^ k) (((m : ℝ) + 1) / (16 : ℝ) ^ k) :=
  PiDisjunctivity.isDisjunctive_iff_hitsHexadecimalIntervals x hx

example
    (h : ∀ (k m : ℕ), m < 16 ^ k → ∃ n : ℕ,
      Int.fract ((16 : ℝ) ^ n * Real.pi) ∈
        Set.Ico ((m : ℝ) / (16 : ℝ) ^ k) (((m : ℝ) + 1) / (16 : ℝ) ^ k)) :
    PiDisjunctivity.PiHexadecimalDisjunctivity :=
  PiDisjunctivity.piHexadecimalDisjunctivity_of_hitsHexadecimalIntervals h

-- Transfer needs both vanishing errors and late visits, but no global range hypothesis.
example (u r : ℕ → ℝ) (hr : Filter.Tendsto r Filter.atTop (nhds 0))
    (hu : ∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, u n ∈ Set.Ioo a b) :
    ∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∃ n : ℕ, Int.fract (u n + r n) ∈ Set.Ioo a b :=
  PiDisjunctivity.hitsOpenIntervals_fract_add_of_tendsto_zero u r hr hu

-- Open-interval visits imply cell visits independently of transfer, BBP, or a range premise.
example (t : ℕ → ℝ)
    (ht : ∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∃ n : ℕ, t n ∈ Set.Ioo a b) :
    ∀ k m : ℕ, m < 16 ^ k → ∃ n : ℕ,
      t n ∈ Set.Ico ((m : ℝ) / (16 : ℝ) ^ k)
        (((m : ℝ) + 1) / (16 : ℝ) ^ k) :=
  PiDisjunctivity.hitsHexadecimalIntervals_of_hitsOpenIntervals t ht

-- The BBP coefficient uses real division, the four reviewed signs, and zero-based indexing.
example (j : ℕ) : PiDisjunctivity.bbpCoeff j =
    4 / (8 * (j : ℝ) + 1) - 2 / (8 * (j : ℝ) + 4)
      - 1 / (8 * (j : ℝ) + 5) - 1 / (8 * (j : ℝ) + 6) := rfl

example : PiDisjunctivity.bbpCoeff 0 = (47 : ℝ) / 15 := by
  norm_num [PiDisjunctivity.bbpCoeff]

-- This is unconditional and includes j = 0; it makes no infinite-sum or π assertion.
example (j : ℕ) :
    (∫ x in (0 : ℝ)..1,
      (x ^ 8 / 16) ^ j * (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5)) =
      PiDisjunctivity.bbpCoeff j / (16 : ℝ) ^ j :=
  PiDisjunctivity.integral_bbpTerm j

-- Pointwise summation and domination retain the closed interval and every natural index.
example (x : ℝ) (hx : x ∈ Set.Icc (0 : ℝ) 1) :
    HasSum (fun j : ℕ => (x ^ 8 / 16) ^ j * (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5))
      ((4 - 2 * x ^ 3 - x ^ 4 - x ^ 5) / (1 - x ^ 8 / 16)) :=
  PiDisjunctivity.hasSum_bbpTerm x hx

example (j : ℕ) (x : ℝ) (hx : x ∈ Set.Icc (0 : ℝ) 1) :
    ‖(x ^ 8 / 16) ^ j * (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5)‖ ≤
      8 * (1 / (16 : ℝ)) ^ j :=
  PiDisjunctivity.norm_bbpTerm_le j x hx

-- At zero the zero-index term is 4; at one the polynomial factor vanishes.
example : HasSum (fun j : ℕ => (0 : ℝ) ^ j * 4) 4 := by
  simpa using PiDisjunctivity.hasSum_bbpTerm 0 (by norm_num)

example : HasSum (fun j : ℕ => (1 / (16 : ℝ)) ^ j * 0) 0 := by
  convert PiDisjunctivity.hasSum_bbpTerm 1 (by norm_num) using 1 <;> norm_num

example (j : ℕ) : ‖(0 : ℝ) ^ j * 4‖ ≤ 8 * (1 / (16 : ℝ)) ^ j := by
  simpa using PiDisjunctivity.norm_bbpTerm_le j 0 (by norm_num)

example (j : ℕ) : ‖(1 / (16 : ℝ)) ^ j * 0‖ ≤ 8 * (1 / (16 : ℝ)) ^ j := by
  convert PiDisjunctivity.norm_bbpTerm_le j 1 (by norm_num) using 1
  norm_num

example (x : ℝ) (hx : x ∈ Set.Icc (0 : ℝ) 1) :
    ‖4 - 2 * x ^ 3 - x ^ 4 - x ^ 5‖ ≤ 8 := by
  simpa using PiDisjunctivity.norm_bbpTerm_le 0 x hx

-- The coefficient series converges to the unevaluated integral without analytic hypotheses.
example :
    HasSum (fun j : ℕ => PiDisjunctivity.bbpCoeff j / (16 : ℝ) ^ j)
      (∫ x in (0 : ℝ)..1,
        (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5) / (1 - x ^ 8 / 16)) :=
  PiDisjunctivity.hasSum_bbpCoeff_integral

-- Rational algebra and the ordinary derivative retain the entire closed unit interval.
example (x : ℝ) (hx : x ∈ Set.Icc (0 : ℝ) 1) :
    (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5) / (1 - x ^ 8 / 16) =
      (-4 * x) / (2 - x ^ 2) - 4 * (x - 2) / (x ^ 2 - 2 * x + 2) :=
  PiDisjunctivity.bbpKernel_eq_partialFractions x hx

example (x : ℝ) (hx : x ∈ Set.Icc (0 : ℝ) 1) :
    HasDerivAt (fun y : ℝ =>
      2 * Real.log (2 - y ^ 2) - 2 * Real.log (y ^ 2 - 2 * y + 2)
        + 4 * Real.arctan (y - 1))
      ((4 - 2 * x ^ 3 - x ^ 4 - x ^ 5) / (1 - x ^ 8 / 16)) x :=
  PiDisjunctivity.hasDerivAt_bbpPrimitive x hx

-- Integral evaluation and the complete BBP series have no unproved analytic hypotheses.
example :
    (∫ x in (0 : ℝ)..1,
      (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5) / (1 - x ^ 8 / 16)) = Real.pi :=
  PiDisjunctivity.integral_bbpKernel

example : HasSum (fun j : ℕ => PiDisjunctivity.bbpCoeff j / (16 : ℝ) ^ j) Real.pi :=
  PiDisjunctivity.hasSum_bbpCoeff

/--
info: 'PiDisjunctivity.blockValue_eq_sum' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.blockValue_eq_sum

/--
info: 'PiDisjunctivity.blockValue_lt' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.blockValue_lt

/--
info: 'PiDisjunctivity.exists_blockValue_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.exists_blockValue_eq

/--
info: 'PiDisjunctivity.baseDigit_lt' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.baseDigit_lt

/--
info: 'PiDisjunctivity.floor_pow_succ' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.floor_pow_succ

/--
info: 'PiDisjunctivity.floor_pow_eq_digits' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.floor_pow_eq_digits

/--
info: 'PiDisjunctivity.truncation_error' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.truncation_error

/--
info: 'PiDisjunctivity.blockValue_injective' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.blockValue_injective

/--
info: 'PiDisjunctivity.baseDigit_fract_pow' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.baseDigit_fract_pow

/--
info: 'PiDisjunctivity.block_iff_mem_interval' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.block_iff_mem_interval

/--
info: 'PiDisjunctivity.isDisjunctive_iff_orbitClosure' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.isDisjunctive_iff_orbitClosure

/--
info: 'PiDisjunctivity.piHexadecimalDisjunctivity_iff_orbitClosure' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.piHexadecimalDisjunctivity_iff_orbitClosure

/--
info: 'PiDisjunctivity.baseDigit_div_pow_eq_zero' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.baseDigit_div_pow_eq_zero

/--
info: 'PiDisjunctivity.hasSum_baseDigit' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.hasSum_baseDigit

/--
info: 'PiDisjunctivity.isDisjunctive_occurs_ge' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.isDisjunctive_occurs_ge

/--
info: 'PiDisjunctivity.isDisjunctive_iff_hitsHexadecimalIntervals' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.isDisjunctive_iff_hitsHexadecimalIntervals

/--
info: 'PiDisjunctivity.piHexadecimalDisjunctivity_of_hitsHexadecimalIntervals' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.piHexadecimalDisjunctivity_of_hitsHexadecimalIntervals

/--
info: 'PiDisjunctivity.hitsOpenIntervals_fract_add_of_tendsto_zero' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.hitsOpenIntervals_fract_add_of_tendsto_zero

/--
info: 'PiDisjunctivity.hitsHexadecimalIntervals_of_hitsOpenIntervals' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.hitsHexadecimalIntervals_of_hitsOpenIntervals

/--
info: 'PiDisjunctivity.integral_bbpTerm' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.integral_bbpTerm

/--
info: 'PiDisjunctivity.hasSum_bbpTerm' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.hasSum_bbpTerm

/--
info: 'PiDisjunctivity.norm_bbpTerm_le' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.norm_bbpTerm_le

/--
info: 'PiDisjunctivity.hasSum_bbpCoeff_integral' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.hasSum_bbpCoeff_integral

/--
info: 'PiDisjunctivity.bbpKernel_eq_partialFractions' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpKernel_eq_partialFractions

/--
info: 'PiDisjunctivity.hasDerivAt_bbpPrimitive' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.hasDerivAt_bbpPrimitive

/--
info: 'PiDisjunctivity.integral_bbpKernel' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.integral_bbpKernel

/--
info: 'PiDisjunctivity.hasSum_bbpCoeff' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.hasSum_bbpCoeff

-- B2 definitions and convergent split retain the inclusive prefix and tail offset.
example (n : ℕ) : PiDisjunctivity.bbpPartialSum n =
    ∑ j ∈ Finset.range (n + 1), (16 : ℝ) ^ (n - j) * PiDisjunctivity.bbpCoeff j := rfl

example (n : ℕ) : PiDisjunctivity.bbpTail n =
    ∑' r : ℕ, PiDisjunctivity.bbpCoeff (n + r + 1) / (16 : ℝ) ^ (r + 1) := rfl

example : PiDisjunctivity.bbpRecurrence 0 = 0 := rfl

example (n : ℕ) : PiDisjunctivity.bbpRecurrence (n + 1) =
    Int.fract (16 * PiDisjunctivity.bbpRecurrence n + PiDisjunctivity.bbpCoeff n) := rfl

example (n : ℕ) :
    HasSum (fun r : ℕ => PiDisjunctivity.bbpCoeff (n + r + 1) / (16 : ℝ) ^ (r + 1))
      ((16 : ℝ) ^ n * Real.pi -
        ∑ j ∈ Finset.range (n + 1), (16 : ℝ) ^ (n - j) * PiDisjunctivity.bbpCoeff j) :=
  PiDisjunctivity.hasSum_bbpTail_sub n

example (n : ℕ) :
    HasSum (fun r : ℕ => PiDisjunctivity.bbpCoeff (n + r + 1) / (16 : ℝ) ^ (r + 1))
      (PiDisjunctivity.bbpTail n) :=
  PiDisjunctivity.hasSum_bbpTail n

example (n : ℕ) :
    (16 : ℝ) ^ n * Real.pi = PiDisjunctivity.bbpPartialSum n + PiDisjunctivity.bbpTail n :=
  PiDisjunctivity.pow_mul_pi_eq_bbpPartialSum_add_bbpTail n

example : HasSum (fun r : ℕ => PiDisjunctivity.bbpCoeff (r + 1) / (16 : ℝ) ^ (r + 1))
    (Real.pi - PiDisjunctivity.bbpCoeff 0) := by
  simpa only [Nat.zero_add, pow_zero, one_mul, Finset.sum_range_one, Nat.sub_self] using
    PiDisjunctivity.hasSum_bbpTail_sub 0

example : Real.pi = PiDisjunctivity.bbpCoeff 0 + PiDisjunctivity.bbpTail 0 := by
  simpa only [PiDisjunctivity.bbpPartialSum, Nat.zero_add, pow_zero, one_mul,
    Finset.sum_range_one, Nat.sub_self] using
    PiDisjunctivity.pow_mul_pi_eq_bbpPartialSum_add_bbpTail 0

/--
info: 'PiDisjunctivity.hasSum_bbpTail_sub' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.hasSum_bbpTail_sub

/--
info: 'PiDisjunctivity.hasSum_bbpTail' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.hasSum_bbpTail

/--
info: 'PiDisjunctivity.pow_mul_pi_eq_bbpPartialSum_add_bbpTail' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.pow_mul_pi_eq_bbpPartialSum_add_bbpTail

-- B2 recurrence and exact orbit identity have no convergence or visitation premises.
example (n : ℕ) : 0 ≤ PiDisjunctivity.bbpRecurrence n ∧ PiDisjunctivity.bbpRecurrence n < 1 :=
  PiDisjunctivity.bbpRecurrence_mem_Ico n

example (n : ℕ) :
    PiDisjunctivity.bbpRecurrence (n + 1) = Int.fract (PiDisjunctivity.bbpPartialSum n) :=
  PiDisjunctivity.bbpRecurrence_succ_eq_fract_bbpPartialSum n

example (n : ℕ) : Int.fract ((16 : ℝ) ^ n * Real.pi) =
    Int.fract (PiDisjunctivity.bbpRecurrence (n + 1) + PiDisjunctivity.bbpTail n) :=
  PiDisjunctivity.fract_pow_mul_pi_eq_bbpRecurrence_add_bbpTail n

example : PiDisjunctivity.bbpRecurrence 1 = Int.fract (PiDisjunctivity.bbpCoeff 0) := by
  simpa only [PiDisjunctivity.bbpPartialSum, Nat.zero_add, Finset.sum_range_one, Nat.sub_self,
    pow_zero, one_mul] using
    PiDisjunctivity.bbpRecurrence_succ_eq_fract_bbpPartialSum 0

example : Int.fract Real.pi =
    Int.fract (PiDisjunctivity.bbpRecurrence 1 + PiDisjunctivity.bbpTail 0) := by
  simpa only [pow_zero, one_mul] using
    PiDisjunctivity.fract_pow_mul_pi_eq_bbpRecurrence_add_bbpTail 0

example : Int.fract (16 * Real.pi) =
    Int.fract (PiDisjunctivity.bbpRecurrence 2 + PiDisjunctivity.bbpTail 1) := by
  simpa only [pow_one] using
    PiDisjunctivity.fract_pow_mul_pi_eq_bbpRecurrence_add_bbpTail 1

-- Definition-level arithmetic checks the first update and the two-term prefix.
example : PiDisjunctivity.bbpRecurrence 1 = (2 : ℝ) / 15 := by
  norm_num [PiDisjunctivity.bbpRecurrence, PiDisjunctivity.bbpCoeff, Int.fract]

example : PiDisjunctivity.bbpPartialSum 1 =
    16 * PiDisjunctivity.bbpCoeff 0 + PiDisjunctivity.bbpCoeff 1 := by
  norm_num [PiDisjunctivity.bbpPartialSum, Finset.sum_range_succ]

/--
info: 'PiDisjunctivity.bbpRecurrence_mem_Ico' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpRecurrence_mem_Ico

/--
info: 'PiDisjunctivity.bbpRecurrence_succ_eq_fract_bbpPartialSum' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpRecurrence_succ_eq_fract_bbpPartialSum

/--
info: 'PiDisjunctivity.fract_pow_mul_pi_eq_bbpRecurrence_add_bbpTail' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.fract_pow_mul_pi_eq_bbpRecurrence_add_bbpTail
