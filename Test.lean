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


-- B3 coefficient and tail bounds are unconditional and include the first indices.
example (j : ℕ) : |PiDisjunctivity.bbpCoeff j| ≤ 8 / (8 * (j : ℝ) + 1) :=
  PiDisjunctivity.abs_bbpCoeff_le j

example (n : ℕ) : |PiDisjunctivity.bbpTail n| ≤ 8 / (15 * (8 * (n : ℝ) + 9)) :=
  PiDisjunctivity.abs_bbpTail_le n

example : |PiDisjunctivity.bbpCoeff 0| ≤ (8 : ℝ) := by
  simpa only [Nat.cast_zero, mul_zero, zero_add, div_one] using
    PiDisjunctivity.abs_bbpCoeff_le 0

example : |PiDisjunctivity.bbpCoeff 1| ≤ (8 : ℝ) / 9 := by
  convert PiDisjunctivity.abs_bbpCoeff_le 1 using 1
  norm_num

example : |PiDisjunctivity.bbpTail 0| ≤ (8 : ℝ) / 135 := by
  convert PiDisjunctivity.abs_bbpTail_le 0 using 1
  norm_num

example : |PiDisjunctivity.bbpTail 1| ≤ (8 : ℝ) / 255 := by
  convert PiDisjunctivity.abs_bbpTail_le 1 using 1
  norm_num

/--
info: 'PiDisjunctivity.abs_bbpCoeff_le' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.abs_bbpCoeff_le

/--
info: 'PiDisjunctivity.abs_bbpTail_le' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.abs_bbpTail_le


example : Filter.Tendsto PiDisjunctivity.bbpTail Filter.atTop (nhds 0) :=
  PiDisjunctivity.tendsto_bbpTail

-- B1/B2/B3 agree on the zero-index error, stated without project-defined symbols.
example : |Real.pi - 47 / 15| ≤ (8 : ℝ) / 135 := by
  have hs := PiDisjunctivity.pow_mul_pi_eq_bbpPartialSum_add_bbpTail 0
  norm_num [PiDisjunctivity.bbpPartialSum, PiDisjunctivity.bbpCoeff] at hs
  have he : Real.pi - 47 / 15 = PiDisjunctivity.bbpTail 0 := by linarith only [hs]
  rw [he]
  convert PiDisjunctivity.abs_bbpTail_le 0 using 1
  norm_num

-- B3 supplies B4's error premise at the B2 offset; the late-visit premise stays explicit.
-- This is an interface audit, not an unconditional visitation theorem or conjecture assembly.
example
    (hu : ∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, PiDisjunctivity.bbpRecurrence (n + 1) ∈ Set.Ioo a b) :
    ∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∃ n : ℕ, Int.fract ((16 : ℝ) ^ n * Real.pi) ∈ Set.Ioo a b := by
  intro a b ha hab hb
  obtain ⟨n, hn⟩ := PiDisjunctivity.hitsOpenIntervals_fract_add_of_tendsto_zero
    (fun n => PiDisjunctivity.bbpRecurrence (n + 1)) PiDisjunctivity.bbpTail
    PiDisjunctivity.tendsto_bbpTail hu a b ha hab hb
  exact ⟨n, by rwa [PiDisjunctivity.fract_pow_mul_pi_eq_bbpRecurrence_add_bbpTail]⟩

/--
info: 'PiDisjunctivity.tendsto_bbpTail' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.tendsto_bbpTail


-- Rational arithmetic retains the existing coefficient, inclusive prefix and recurrence offset.
example (j : ℕ) : PiDisjunctivity.bbpCoeffRat j =
    4 / (8 * (j : ℚ) + 1) - 2 / (8 * (j : ℚ) + 4)
      - 1 / (8 * (j : ℚ) + 5) - 1 / (8 * (j : ℚ) + 6) := rfl

example (n : ℕ) : PiDisjunctivity.bbpPartialSumRat n =
    ∑ j ∈ Finset.range (n + 1), (16 : ℚ) ^ (n - j) * PiDisjunctivity.bbpCoeffRat j := rfl

example (j : ℕ) : (PiDisjunctivity.bbpCoeffRat j : ℝ) = PiDisjunctivity.bbpCoeff j :=
  PiDisjunctivity.cast_bbpCoeffRat j

example (n : ℕ) : (PiDisjunctivity.bbpPartialSumRat n : ℝ) =
    PiDisjunctivity.bbpPartialSum n := PiDisjunctivity.cast_bbpPartialSumRat n

example (n : ℕ) : PiDisjunctivity.bbpRecurrence (n + 1) =
    Int.fract (PiDisjunctivity.bbpPartialSumRat n : ℝ) :=
  PiDisjunctivity.bbpRecurrence_succ_eq_fract_bbpPartialSumRat n

-- This boundary check consumes the new bridge at the first recurrence step.
example : PiDisjunctivity.bbpRecurrence 1 =
    Int.fract (PiDisjunctivity.bbpPartialSumRat 0 : ℝ) :=
  PiDisjunctivity.bbpRecurrence_succ_eq_fract_bbpPartialSumRat 0

example (j : ℕ) : PiDisjunctivity.bbpCoeffRat j =
    (120 * (j : ℚ) ^ 2 + 151 * j + 47) /
      ((2 * j + 1) * (4 * j + 3) * (8 * j + 1) * (8 * j + 5)) :=
  PiDisjunctivity.bbpCoeffRat_eq_positive_fraction j

example (j : ℕ) : 0 < PiDisjunctivity.bbpCoeffRat j := PiDisjunctivity.bbpCoeffRat_pos j

example (n : ℕ) : 0 < PiDisjunctivity.bbpPartialSumRat n :=
  PiDisjunctivity.bbpPartialSumRat_pos n

example (j : ℕ) : (PiDisjunctivity.bbpCoeffRat j).den ∣
    PiDisjunctivity.bbpCoeffCommonDenominator j := PiDisjunctivity.bbpCoeffRat_den_dvd j

example (j : ℕ) : Odd (PiDisjunctivity.bbpCoeffCommonDenominator j) :=
  PiDisjunctivity.bbpCoeffCommonDenominator_odd j

example (n : ℕ) : (PiDisjunctivity.bbpPartialSumRat n).den ∣
    ∏ j ∈ Finset.range (n + 1), PiDisjunctivity.bbpCoeffCommonDenominator j :=
  PiDisjunctivity.bbpPartialSumRat_den_dvd n

example (n : ℕ) : Odd (PiDisjunctivity.bbpPartialSumRat n).den :=
  PiDisjunctivity.bbpPartialSumRat_den_odd n

example (n : ℕ) : (PiDisjunctivity.bbpPartialSumRat n).den.Coprime 16 :=
  PiDisjunctivity.bbpPartialSumRat_den_coprime n

example (n p : ℕ) (hp : p.Prime) (hpd : p ∣ (PiDisjunctivity.bbpPartialSumRat n).den) :
    p ≤ 8 * n + 5 := PiDisjunctivity.bbpPartialSumRat_den_prime_le n p hp hpd

/--
info: 'PiDisjunctivity.cast_bbpCoeffRat' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.cast_bbpCoeffRat

/--
info: 'PiDisjunctivity.cast_bbpPartialSumRat' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.cast_bbpPartialSumRat

/--
info: 'PiDisjunctivity.bbpRecurrence_succ_eq_fract_bbpPartialSumRat' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpRecurrence_succ_eq_fract_bbpPartialSumRat

/--
info: 'PiDisjunctivity.bbpCoeffRat_eq_positive_fraction' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCoeffRat_eq_positive_fraction

/--
info: 'PiDisjunctivity.bbpCoeffRat_pos' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCoeffRat_pos

/--
info: 'PiDisjunctivity.bbpPartialSumRat_pos' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpPartialSumRat_pos

/--
info: 'PiDisjunctivity.bbpCoeffRat_den_dvd' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCoeffRat_den_dvd

/--
info: 'PiDisjunctivity.bbpCoeffCommonDenominator_odd' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCoeffCommonDenominator_odd

/--
info: 'PiDisjunctivity.bbpPartialSumRat_den_dvd' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpPartialSumRat_den_dvd

/--
info: 'PiDisjunctivity.bbpPartialSumRat_den_odd' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpPartialSumRat_den_odd

/--
info: 'PiDisjunctivity.bbpPartialSumRat_den_coprime' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpPartialSumRat_den_coprime

/--
info: 'PiDisjunctivity.bbpPartialSumRat_den_prime_le' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpPartialSumRat_den_prime_le


-- Elementary actual-denominator grid theorem: exact exported interfaces and trust audits.
section ElementaryGridChecks
open PiDisjunctivity PiDisjunctivity.PrimeGrid17 PiDisjunctivity.RationalHexOrbit

example : ∀ (k N : ℕ) (_hk : 0 < k)
    (_hN : 8 * N + 1 = 17 ^ k),
    padicValRat 17 (bbpPartialSumRat N) = -(k : ℤ) :=
  PiDisjunctivity.bbpPartialSumRat_val17

example : ∀ (k N : ℕ) (_hk : 0 < k)
    (_hN : 8 * N + 1 = 17 ^ k),
    multiplicity 17 (bbpPartialSumRat N).den = k :=
  PiDisjunctivity.bbpPartialSumRat_den_val17

example : ∀ (k : ℕ),
    8 * ((17 ^ k - 1) / 8) + 1 = 17 ^ k :=
  PiDisjunctivity.bbpAnchor17_eq

example : ∀ (k : ℕ) (_hk : 0 < k),
    multiplicity 17 (bbpPartialSumRat ((17 ^ k - 1) / 8)).den = k :=
  PiDisjunctivity.bbpPartialSumRat_den_anchor17

example : ∀ (k N : ℕ) (_hk : 0 < k)
    (_hN : 8 * N + 1 = 17 ^ k),
    ∃ M : ℕ, (bbpPartialSumRat N).den = 17 ^ k * M ∧ M.Coprime 34 ∧ 0 < M :=
  PiDisjunctivity.bbpPartialSumRat_den_decomposition17

example : ∀ (k : ℕ) (_hk : 0 < k),
    ∃ M : ℕ, (bbpPartialSumRat ((17 ^ k - 1) / 8)).den = 17 ^ k * M ∧
      M.Coprime 34 ∧ 0 < M :=
  PiDisjunctivity.bbpPartialSumRat_den_anchor_decomposition17

example : ∀ (d : ℕ),
    0 < bbpCoverLcm d :=
  PiDisjunctivity.bbpCoverLcm_pos

example : ∀ (d r ell : ℕ) (_hd : 0 < d) (_hr : 1 < r)
    (_hcong : r ≡ 1 [MOD bbpCoverLcm d]) (_hp : ell.Prime)
    (_hle : ell ≤ 17 ^ (r + d) + 5),
    ¬17 ^ r ∣ ell - 1 :=
  PiDisjunctivity.bbpCover_prime_exclusion

example : ∀ (d r ell : ℕ) (_hd : 0 < d) (_hr : 1 < r)
    (_hcong : r ≡ 1 [MOD bbpCoverLcm d]) (_hp : ell.Prime)
    (_hle : ell ≤ 17 ^ (r + d) + 5),
    (ell - 1).factorization 17 ≤ r - 1 :=
  PiDisjunctivity.bbpCover_prime_factorization_le

example : ∀ (d B : ℕ),
    ∃ r : ℕ, B < r ∧ 1 < r ∧ r ≡ 1 [MOD bbpCoverLcm d] :=
  PiDisjunctivity.bbpCover_admissible_exponent_gt

example : ∀ (d r ell : ℕ) (_hd : 0 < d) (_hr : 1 < r)
    (_hcong : r ≡ 1 [MOD bbpCoverLcm d]) (_hp : ell.Prime)
    (_hdiv : ell ∣ (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den),
    (ell - 1).factorization 17 ≤ r - 1 :=
  PiDisjunctivity.bbpCover_prefix_prime_factorization_le

example : ∀ (d B : ℕ),
    ∃ r : ℕ, 1 < r ∧ r ≡ 1 [MOD bbpCoverLcm d] ∧ B < (17 ^ (r + d) - 1) / 8 :=
  PiDisjunctivity.bbpCover_admissible_anchor_gt

example : ∀ (M r d a j : ℕ) (_hM : M.Coprime 34) (_hr : 1 ≤ r)
    (_hb : ∀ p : ℕ, p.Prime → p ∣ M → (p - 1).factorization 17 ≤ r - 1)
    (_ha : a.Coprime 17),
    ∃ t : ℕ, Int.fract ((16 : ℝ) ^ t * ((a : ℝ) / (17 ^ (d + r) * M))) =
      Int.fract ((a : ℝ) / (17 ^ (d + r) * M) + j / (17 : ℝ) ^ d) :=
  PiDisjunctivity.PrimeGrid17.rationalGrid17

example : ∀ (m : ℕ) (x u v : ℝ)
    (_hu : 0 ≤ u) (_huv : u ≤ v) (_hv : v ≤ 1),
    (shiftedGridIcoCount m x u v : ℤ) = ⌊(m : ℝ) * (x - u)⌋-⌊(m : ℝ) * (x - v)⌋ :=
  PiDisjunctivity.shiftedGridIcoCount_eq_floor

example : ∀ (m : ℕ) (x u v : ℝ)
    (_hu : 0 ≤ u) (_huv : u ≤ v) (_hv : v ≤ 1),
    |(shiftedGridIcoCount m x u v : ℝ) - (m : ℝ) * (v - u)| < 1 :=
  PiDisjunctivity.shiftedGridIcoCount_discrepancy_lt_one

example : ∀ (m : ℕ) (_hm : 0 < m) (x u v : ℝ)
    (_hu : 0 ≤ u) (_huv : u ≤ v) (_hv : v ≤ 1),
    |(shiftedGridIcoCount m x u v : ℝ) / m - (v - u)| < 1 / (m : ℝ) :=
  PiDisjunctivity.shiftedGridIcoCount_normalized_discrepancy

example : ∀ (m : ℕ) (x : ℝ),
    shiftedGridIcoCount m x 0 1 = m :=
  PiDisjunctivity.shiftedGridIcoCount_full

example : ∀ (m : ℕ) (x u : ℝ) (_hu : 0 ≤ u) (_hu1 : u ≤ 1),
    shiftedGridIcoCount m x u u = 0 :=
  PiDisjunctivity.shiftedGridIcoCount_self

example : ∀ (S : Finset ℝ) (_hSne : S.Nonempty)
    (m : ℕ) (_hm : 0 < m)
    (_hS : ∀ x ∈ S, x ∈ Set.Ico (0 : ℝ) 1)
    (_hinv : ∀ j < m, ∀ x ∈ S, Int.fract (x + (j : ℝ) / m) ∈ S)
    (u v : ℝ) (_hu : 0 ≤ u) (_huv : u ≤ v) (_hv : v ≤ 1),
    |(finiteIcoCount S u v : ℝ) / (S.card : ℝ) - (v - u)| < 1 / (m : ℝ) :=
  PiDisjunctivity.finiteCircle_grid_discrepancy

example : ∀ (a q t : ℕ),
    orbitPoint a q t = Int.fract (((16 ^ t * a : ℕ) : ℝ) / q) :=
  PiDisjunctivity.RationalHexOrbit.orbitPoint_eq_fract_nat

example : ∀ (a b q : ℕ) (_hq : 0 < q),
    Int.fract ((a : ℝ) / q) = Int.fract ((b : ℝ) / q) ↔ a ≡ b [MOD q] :=
  PiDisjunctivity.RationalHexOrbit.fract_nat_div_eq_iff

example : ∀ (q : ℕ) (_hb : Nat.Coprime 16 q),
    0 < orderOf (16 : ZMod q) :=
  PiDisjunctivity.RationalHexOrbit.period_pos

example : ∀ (a q : ℕ) (_hq : 0 < q) (_ha : a.Coprime q),
    Set.InjOn (orbitPoint a q) (Set.Iio (orderOf (16 : ZMod q))) :=
  PiDisjunctivity.RationalHexOrbit.orbitPoint_injOn

example : ∀ (a q t : ℕ) (_hq : 0 < q),
    orbitPoint a q (t % orderOf (16 : ZMod q)) = orbitPoint a q t :=
  PiDisjunctivity.RationalHexOrbit.orbitPoint_mod_period

example : ∀ (a q t : ℕ),
    orbitPoint a q t ∈ Set.Ico (0 : ℝ) 1 :=
  PiDisjunctivity.RationalHexOrbit.orbitPoint_mem_Ico

example : ∀ (a q : ℕ),
    (orbitSet a q : Set ℝ) ⊆ Set.Ico 0 1 :=
  PiDisjunctivity.RationalHexOrbit.orbitSet_subset_Ico

example : ∀ (a q : ℕ) (_hq : 0 < q) (_ha : a.Coprime q),
    (orbitSet a q).card = orderOf (16 : ZMod q) :=
  PiDisjunctivity.RationalHexOrbit.orbitSet_card

example : ∀ (a q t : ℕ) (_hq : 0 < q) (_hb : Nat.Coprime 16 q),
    orbitPoint a q t ∈ orbitSet a q :=
  PiDisjunctivity.RationalHexOrbit.orbitPoint_mem_orbitSet

example : ∀ (a q : ℕ) (_hq : 0 < q) (_hb : Nat.Coprime 16 q) (x : ℝ),
    x ∈ orbitSet a q ↔ ∃ t : ℕ, orbitPoint a q t = x :=
  PiDisjunctivity.RationalHexOrbit.mem_orbitSet_iff

example : ∀ (a q : ℕ) (_hq : 0 < q) (_ha : a.Coprime q)
    (A : ℝ → Prop) [DecidablePred A],
    ((orbitSet a q).filter A).card =
      ((Finset.range (orderOf (16 : ZMod q))).filter (fun t => A (orbitPoint a q t))).card :=
  PiDisjunctivity.RationalHexOrbit.orbitSet_filter_card

example : ∀ (x : ℝ) (_hx : 0 ≤ x)
    (P : ℕ) (_hP : 0 < P) (w : ℕ) (epsilon : ℝ)
    (_hepsilon : epsilon < 1 / (16 : ℝ) ^ w)
    (_hdisc : ∀ u v : ℝ, 0 ≤ u → u < v → v ≤ 1 →
      |(hexadecimalPrefixIcoCount x P u v : ℝ) / (P : ℝ) - (v - u)| ≤ epsilon)
    (s : Fin w → Fin 16),
    ∃ t < P, ∀ i : Fin w, baseDigit 16 x (t + i.val) = (s i).val :=
  PiDisjunctivity.word_occurs_before_of_discrepancy

example : ∀ (w : ℕ),
    1 / (17 : ℝ) ^ (w + 1) < 1 / (16 : ℝ) ^ w :=
  PiDisjunctivity.grid17_mesh_lt_cylinder

example : ∀ (w : ℕ),
    ∃ d : ℕ, 0 < d ∧ 1 / (17 : ℝ) ^ d < 1 / (16 : ℝ) ^ w :=
  PiDisjunctivity.exists_grid17_mesh_lt_cylinder

example : ∀ (x : ℝ) (_hx : 0 ≤ x)
    (P : ℕ) (_hP : 0 < P) (w : ℕ)
    (_hdisc : ∀ u v : ℝ, 0 ≤ u → u < v → v ≤ 1 →
      |(hexadecimalPrefixIcoCount x P u v : ℝ) / (P : ℝ) - (v - u)| ≤ 1 / (17 : ℝ) ^ (w + 1))
    (s : Fin w → Fin 16),
    ∃ t < P, ∀ i : Fin w, baseDigit 16 x (t + i.val) = (s i).val :=
  PiDisjunctivity.word_occurs_before_of_grid17_discrepancy

example : ∀ (x : ℝ) (_hx : 0 ≤ x)
    (P : ℕ) (_hP : 0 < P) (epsilon : ℝ) (_hepsilon : epsilon < 1)
    (_hdisc : ∀ u v : ℝ, 0 ≤ u → u < v → v ≤ 1 →
      |(hexadecimalPrefixIcoCount x P u v : ℝ) / (P : ℝ) - (v - u)| ≤ epsilon)
    (s : Fin 0 → Fin 16),
    ∃ t < P, ∀ i : Fin 0, baseDigit 16 x (t + i.val) = (s i).val :=
  PiDisjunctivity.empty_word_occurs_before_of_discrepancy

example : ∀ (x : ℝ) (_hx : 0 ≤ x)
    (P : ℕ) (_hP : 0 < P) (w : ℕ) (epsilon : ℝ)
    (_hepsilon : epsilon < 1 / (16 : ℝ) ^ w)
    (_hdisc : ∀ u v : ℝ, 0 ≤ u → u < v → v ≤ 1 →
      |(hexadecimalPrefixIcoCount x P u v : ℝ) / (P : ℝ) - (v - u)| ≤ epsilon),
    ∃ t < P, ∀ i : Fin w, baseDigit 16 x (t + i.val) = 0 :=
  PiDisjunctivity.zero_word_occurs_before_of_discrepancy

example : ∀ (M r d a : ℕ) (_hM : M.Coprime 34) (_hr : 1 ≤ r)
    (_hb : ∀ p : ℕ, p.Prime → p ∣ M → (p - 1).factorization 17 ≤ r - 1)
    (_ha : a.Coprime (17 ^ (d + r) * M)) (j : ℕ) (x : ℝ)
    (_hx : x ∈ orbitSet a (17 ^ (d + r) * M)),
    Int.fract (x + (j : ℝ) / (17 : ℝ) ^ d) ∈ orbitSet a (17 ^ (d + r) * M) :=
  PiDisjunctivity.RationalHexOrbit.orbitSet_grid_invariant

example : ∀ (M r d a : ℕ) (_hM : M.Coprime 34) (_hr : 1 ≤ r)
    (_hb : ∀ p : ℕ, p.Prime → p ∣ M → (p - 1).factorization 17 ≤ r - 1)
    (_ha : a.Coprime (17 ^ (d + r) * M))
    (u v : ℝ) (_hu : 0 ≤ u) (_huv : u ≤ v) (_hv : v ≤ 1),
    |(((Finset.range (orderOf (16 : ZMod (17 ^ (d + r) * M)))).filter
        (fun t => orbitPoint a (17 ^ (d + r) * M) t ∈ Set.Ico u v)).card : ℝ) /
      (orderOf (16 : ZMod (17 ^ (d + r) * M)) : ℝ) - (v - u)| < 1 / (17 : ℝ) ^ d :=
  PiDisjunctivity.RationalHexOrbit.rational_period_grid_discrepancy

example : ∀ (M r d a : ℕ) (_hM : M.Coprime 34) (_hr : 1 ≤ r)
    (_hb : ∀ p : ℕ, p.Prime → p ∣ M → (p - 1).factorization 17 ≤ r - 1)
    (_ha : a.Coprime (17 ^ (d + r) * M))
    (u v : ℝ) (_hu : 0 ≤ u) (_huv : u ≤ v) (_hv : v ≤ 1),
    let q : ℕ := 17 ^ (d + r) * M
    let P : ℕ := orderOf (16 : ZMod q)
    0 < P ∧
      |(((Finset.range P).filter
          (fun t => Int.fract ((16 : ℝ) ^ t * ((a : ℝ) / q)) ∈ Set.Ico u v)).card : ℝ) /
        (P : ℝ) - (v - u)| < 1 / (17 : ℝ) ^ d :=
  PiDisjunctivity.RationalHexOrbit.rational_period_grid_contract

example : ∀ (d r a j : ℕ) (_hd : 0 < d) (_hr : 1 < r)
    (_hcong : r ≡ 1 [MOD bbpCoverLcm d])
    (_ha : a.Coprime (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den),
    ∃ t : ℕ,
      Int.fract ((16 : ℝ) ^ t * ((a : ℝ) /
        (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den)) =
      Int.fract ((a : ℝ) / (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den +
        j / (17 : ℝ) ^ d) :=
  PiDisjunctivity.bbpCover_den_grid

example : ∀ (d r j : ℕ) (_hd : 0 < d) (_hr : 1 < r)
    (_hcong : r ≡ 1 [MOD bbpCoverLcm d]),
    ∃ t : ℕ, Int.fract ((16 : ℝ) ^ t *
        (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8) : ℝ)) =
      Int.fract ((bbpPartialSumRat ((17 ^ (r + d) - 1) / 8) : ℝ) + j / (17 : ℝ) ^ d) :=
  PiDisjunctivity.bbpCover_prefix_grid

example : ∀ (n : ℕ),
    0 < orderOf (16 : ZMod (bbpPartialSumRat n).den) :=
  PiDisjunctivity.bbpPartialSumRat_period_pos

example : ∀ (d r a j : ℕ) (_hd : 0 < d) (_hr : 1 < r)
    (_hcong : r ≡ 1 [MOD bbpCoverLcm d])
    (_ha : a.Coprime (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den),
    ∃ t < orderOf (16 : ZMod (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den),
      Int.fract ((16 : ℝ) ^ t * ((a : ℝ) /
        (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den)) =
      Int.fract ((a : ℝ) / (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den +
        j / (17 : ℝ) ^ d) :=
  PiDisjunctivity.bbpCover_den_grid_in_period

example : ∀ (d r j : ℕ) (_hd : 0 < d) (_hr : 1 < r)
    (_hcong : r ≡ 1 [MOD bbpCoverLcm d]),
    ∃ t < orderOf (16 : ZMod (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den),
      Int.fract ((16 : ℝ) ^ t * (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8) : ℝ)) =
      Int.fract ((bbpPartialSumRat ((17 ^ (r + d) - 1) / 8) : ℝ) + j / (17 : ℝ) ^ d) :=
  PiDisjunctivity.bbpCover_prefix_grid_in_period

example : ∀ (d r a : ℕ) (_hd : 0 < d) (_hr : 1 < r)
    (_hcong : r ≡ 1 [MOD bbpCoverLcm d])
    (_ha : a.Coprime (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den)
    (u v : ℝ) (_hu : 0 ≤ u) (_huv : u ≤ v) (_hv : v ≤ 1),
    |(hexadecimalPrefixIcoCount
        ((a : ℝ) / (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den)
        (orderOf (16 : ZMod (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den)) u v : ℝ) /
      (orderOf (16 : ZMod (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den) : ℝ) - (v - u)| <
      1 / (17 : ℝ) ^ d :=
  PiDisjunctivity.bbpCover_den_discrepancy

example : ∀ (d r : ℕ) (_hd : 0 < d) (_hr : 1 < r)
    (_hcong : r ≡ 1 [MOD bbpCoverLcm d])
    (u v : ℝ) (_hu : 0 ≤ u) (_huv : u ≤ v) (_hv : v ≤ 1),
    |(hexadecimalPrefixIcoCount (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8) : ℝ)
        (orderOf (16 : ZMod (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den)) u v : ℝ) /
      (orderOf (16 : ZMod (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den) : ℝ) - (v - u)| <
      1 / (17 : ℝ) ^ d :=
  PiDisjunctivity.bbpCover_prefix_discrepancy

example : ∀ (w r : ℕ) (_hr : 1 < r)
    (_hcong : r ≡ 1 [MOD bbpCoverLcm (w + 1)]) (s : Fin w → Fin 16),
    ∃ t < orderOf (16 : ZMod (bbpPartialSumRat ((17 ^ (r + (w + 1)) - 1) / 8)).den),
      ∀ i : Fin w, baseDigit 16 (bbpPartialSumRat ((17 ^ (r + (w + 1)) - 1) / 8) : ℝ)
        (t + i.val) = (s i).val :=
  PiDisjunctivity.bbpCover_prefix_words

example : ∀ (w B : ℕ),
    ∃ N : ℕ, B < N ∧ ∀ s : Fin w → Fin 16,
      ∃ t < orderOf (16 : ZMod (bbpPartialSumRat N).den),
        ∀ i : Fin w, baseDigit 16 (bbpPartialSumRat N : ℝ) (t + i.val) = (s i).val :=
  PiDisjunctivity.bbpCover_arbitrarily_large_prefix_words

example : ∀ (w : ℕ),
    Set.Infinite {N : ℕ | ∀ s : Fin w → Fin 16,
      ∃ t < orderOf (16 : ZMod (bbpPartialSumRat N).den),
        ∀ i : Fin w, baseDigit 16 (bbpPartialSumRat N : ℝ) (t + i.val) = (s i).val} :=
  PiDisjunctivity.bbpCover_infinitely_many_prefix_words

/--
info: 'PiDisjunctivity.bbpPartialSumRat_val17' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpPartialSumRat_val17

/--
info: 'PiDisjunctivity.bbpPartialSumRat_den_val17' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpPartialSumRat_den_val17

/--
info: 'PiDisjunctivity.bbpAnchor17_eq' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpAnchor17_eq

/--
info: 'PiDisjunctivity.bbpPartialSumRat_den_anchor17' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpPartialSumRat_den_anchor17

/--
info: 'PiDisjunctivity.bbpPartialSumRat_den_decomposition17' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpPartialSumRat_den_decomposition17

/--
info: 'PiDisjunctivity.bbpPartialSumRat_den_anchor_decomposition17' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpPartialSumRat_den_anchor_decomposition17

/--
info: 'PiDisjunctivity.bbpCoverLcm_pos' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCoverLcm_pos

/--
info: 'PiDisjunctivity.bbpCover_prime_exclusion' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCover_prime_exclusion

/--
info: 'PiDisjunctivity.bbpCover_prime_factorization_le' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCover_prime_factorization_le

/--
info: 'PiDisjunctivity.bbpCover_admissible_exponent_gt' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCover_admissible_exponent_gt

/--
info: 'PiDisjunctivity.bbpCover_prefix_prime_factorization_le' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCover_prefix_prime_factorization_le

/--
info: 'PiDisjunctivity.bbpCover_admissible_anchor_gt' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCover_admissible_anchor_gt

/--
info: 'PiDisjunctivity.PrimeGrid17.rationalGrid17' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.PrimeGrid17.rationalGrid17

/--
info: 'PiDisjunctivity.shiftedGridIcoCount_eq_floor' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.shiftedGridIcoCount_eq_floor

/--
info: 'PiDisjunctivity.shiftedGridIcoCount_discrepancy_lt_one' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.shiftedGridIcoCount_discrepancy_lt_one

/--
info: 'PiDisjunctivity.shiftedGridIcoCount_normalized_discrepancy' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.shiftedGridIcoCount_normalized_discrepancy

/--
info: 'PiDisjunctivity.shiftedGridIcoCount_full' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.shiftedGridIcoCount_full

/--
info: 'PiDisjunctivity.shiftedGridIcoCount_self' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.shiftedGridIcoCount_self

/--
info: 'PiDisjunctivity.finiteCircle_grid_discrepancy' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.finiteCircle_grid_discrepancy

/--
info: 'PiDisjunctivity.RationalHexOrbit.orbitPoint_eq_fract_nat' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.RationalHexOrbit.orbitPoint_eq_fract_nat

/--
info: 'PiDisjunctivity.RationalHexOrbit.fract_nat_div_eq_iff' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.RationalHexOrbit.fract_nat_div_eq_iff

/--
info: 'PiDisjunctivity.RationalHexOrbit.period_pos' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.RationalHexOrbit.period_pos

/--
info: 'PiDisjunctivity.RationalHexOrbit.orbitPoint_injOn' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.RationalHexOrbit.orbitPoint_injOn

/--
info: 'PiDisjunctivity.RationalHexOrbit.orbitPoint_mod_period' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.RationalHexOrbit.orbitPoint_mod_period

/--
info: 'PiDisjunctivity.RationalHexOrbit.orbitPoint_mem_Ico' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.RationalHexOrbit.orbitPoint_mem_Ico

/--
info: 'PiDisjunctivity.RationalHexOrbit.orbitSet_subset_Ico' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.RationalHexOrbit.orbitSet_subset_Ico

/--
info: 'PiDisjunctivity.RationalHexOrbit.orbitSet_card' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.RationalHexOrbit.orbitSet_card

/--
info: 'PiDisjunctivity.RationalHexOrbit.orbitPoint_mem_orbitSet' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.RationalHexOrbit.orbitPoint_mem_orbitSet

/--
info: 'PiDisjunctivity.RationalHexOrbit.mem_orbitSet_iff' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.RationalHexOrbit.mem_orbitSet_iff

/--
info: 'PiDisjunctivity.RationalHexOrbit.orbitSet_filter_card' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.RationalHexOrbit.orbitSet_filter_card

/--
info: 'PiDisjunctivity.word_occurs_before_of_discrepancy' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.word_occurs_before_of_discrepancy

/--
info: 'PiDisjunctivity.grid17_mesh_lt_cylinder' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.grid17_mesh_lt_cylinder

/--
info: 'PiDisjunctivity.exists_grid17_mesh_lt_cylinder' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.exists_grid17_mesh_lt_cylinder

/--
info: 'PiDisjunctivity.word_occurs_before_of_grid17_discrepancy' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.word_occurs_before_of_grid17_discrepancy

/--
info: 'PiDisjunctivity.empty_word_occurs_before_of_discrepancy' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.empty_word_occurs_before_of_discrepancy

/--
info: 'PiDisjunctivity.zero_word_occurs_before_of_discrepancy' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.zero_word_occurs_before_of_discrepancy

/--
info: 'PiDisjunctivity.RationalHexOrbit.orbitSet_grid_invariant' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.RationalHexOrbit.orbitSet_grid_invariant

/--
info: 'PiDisjunctivity.RationalHexOrbit.rational_period_grid_discrepancy' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.RationalHexOrbit.rational_period_grid_discrepancy

/--
info: 'PiDisjunctivity.RationalHexOrbit.rational_period_grid_contract' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.RationalHexOrbit.rational_period_grid_contract

/--
info: 'PiDisjunctivity.bbpCover_den_grid' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCover_den_grid

/--
info: 'PiDisjunctivity.bbpCover_prefix_grid' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCover_prefix_grid

/--
info: 'PiDisjunctivity.bbpPartialSumRat_period_pos' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpPartialSumRat_period_pos

/--
info: 'PiDisjunctivity.bbpCover_den_grid_in_period' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCover_den_grid_in_period

/--
info: 'PiDisjunctivity.bbpCover_prefix_grid_in_period' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCover_prefix_grid_in_period

/--
info: 'PiDisjunctivity.bbpCover_den_discrepancy' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCover_den_discrepancy

/--
info: 'PiDisjunctivity.bbpCover_prefix_discrepancy' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCover_prefix_discrepancy

/--
info: 'PiDisjunctivity.bbpCover_prefix_words' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCover_prefix_words

/--
info: 'PiDisjunctivity.bbpCover_arbitrarily_large_prefix_words' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCover_arbitrarily_large_prefix_words

/--
info: 'PiDisjunctivity.bbpCover_infinitely_many_prefix_words' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpCover_infinitely_many_prefix_words


-- Definition checks preserve the exact anchor selection and the three counting conventions.
example (d : ℕ) : bbpCoverIndices d = (Finset.Icc 2 (17 ^ d - 1)).filter Even := rfl

example (d : ℕ) : bbpCoverLcm d = (bbpCoverIndices d).lcm
    (fun a => (17 * a + 1).totient) := rfl

example (m : ℕ) (x u v : ℝ) : shiftedGridIcoCount m x u v =
    ((Finset.range m).filter (fun j : ℕ => Int.fract (x + (j : ℝ) / m) ∈ Set.Ico u v)).card := by
  classical
  rfl

example (S : Finset ℝ) (u v : ℝ) : finiteIcoCount S u v =
    (S.filter (fun x => x ∈ Set.Ico u v)).card := by
  classical
  rfl

example (a q t : ℕ) : orbitPoint a q t = Int.fract ((16 : ℝ) ^ t * ((a : ℝ) / q)) := rfl

example (a q : ℕ) : orbitSet a q =
    (Finset.range (orderOf (16 : ZMod q))).image (orbitPoint a q) := by
  classical
  rfl

example (x : ℝ) (P : ℕ) (u v : ℝ) : hexadecimalPrefixIcoCount x P u v =
    ((Finset.range P).filter (fun t => Int.fract ((16 : ℝ) ^ t * x) ∈ Set.Ico u v)).card := by
  classical
  rfl

-- These boundary checks consume the actual theorems, without evaluating a BBP prefix.
example (d r : ℕ) (hr : 1 ≤ r) :
    ∃ M : ℕ, (bbpPartialSumRat ((17 ^ (d + r) - 1) / 8)).den = 17 ^ (d + r) * M ∧
      M.Coprime 34 ∧ M ≠ 0 := by
  obtain ⟨M, hq, hM, hpos⟩ := bbpPartialSumRat_den_anchor_decomposition17 (d + r) (by omega)
  exact ⟨M, hq, hM, Nat.ne_of_gt hpos⟩

example : (orbitSet 0 1).card = 1 := by
  rw [orbitSet_card 0 1 (by norm_num) (by norm_num)]
  have h : (16 : ZMod 1) = 1 := Subsingleton.elim _ _
  rw [h, orderOf_one]

example (m : ℕ) (x : ℝ) : shiftedGridIcoCount m x 0 1 = m :=
  shiftedGridIcoCount_full m x

example (m : ℕ) (x u : ℝ) (hu : 0 ≤ u) (hu1 : u ≤ 1) :
    shiftedGridIcoCount m x u u = 0 := shiftedGridIcoCount_self m x u hu hu1

example (B : ℕ) : ∃ N : ℕ, B < N ∧ ∀ s : Fin 0 → Fin 16,
    ∃ t < orderOf (16 : ZMod (bbpPartialSumRat N).den),
      ∀ i : Fin 0, baseDigit 16 (bbpPartialSumRat N : ℝ) (t + i.val) = (s i).val :=
  bbpCover_arbitrarily_large_prefix_words 0 B

example (w r : ℕ) (hr : 1 < r) (hc : r ≡ 1 [MOD bbpCoverLcm (w + 1)]) :
    ∃ t < orderOf (16 : ZMod (bbpPartialSumRat ((17 ^ (r + (w + 1)) - 1) / 8)).den),
      ∀ i : Fin w, baseDigit 16 (bbpPartialSumRat ((17 ^ (r + (w + 1)) - 1) / 8) : ℝ)
        (t + i.val) = 0 := by
  simpa only [Fin.val_zero] using bbpCover_prefix_words w r hr hc (fun _ => 0)

end ElementaryGridChecks

-- Rational-affine universal late visitation: exact types, actual axioms, and consumers.
section RationalAffineAudit

open Set Function PiDisjunctivity PiDisjunctivity.AffineOrbit

example : ∀ (S : Set (AddCircle (1 : ℝ)))
    (_hS : MapsTo (fun z : AddCircle (1 : ℝ) => (16 : ℕ) • z) S S)
    (_hI : (interior S).Nonempty),
    S = univ :=
  PiDisjunctivity.AffineOrbit.eq_univ_of_mapsTo_sixteen_of_interior_nonempty

example : ∀ (S : Set (AddCircle (1 : ℝ))) (_hclosed : IsClosed S)
    (_hS : MapsTo (fun z : AddCircle (1 : ℝ) => (16 : ℕ) • z) S S)
    (_hproper : S ≠ univ),
    IsNowhereDense S :=
  PiDisjunctivity.AffineOrbit.isNowhereDense_of_isClosed_mapsTo_sixteen_ne_univ

example : ∀ (x : AddCircle (1 : ℝ))
    (_hx : ¬ DenseRange (fun n : ℕ => (16 ^ n : ℕ) • x)),
    IsNowhereDense (closure (range (fun n : ℕ => (16 ^ n : ℕ) • x))) :=
  PiDisjunctivity.AffineOrbit.orbitClosure_isNowhereDense_of_not_denseRange

example : ∀ (x : AddCircle (1 : ℝ))
    (_hx : DenseRange (fun n : ℕ => (16 ^ n : ℕ) • x)) (N : ℕ),
    DenseRange (fun n : ℕ => (16 ^ (n + N) : ℕ) • x) :=
  PiDisjunctivity.AffineOrbit.denseRange_sixteen_tail

example : ∀ (x : ℝ)
    (_hx : DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (x : AddCircle (1 : ℝ)))),
    ∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * x) ∈ Ioo a b :=
  PiDisjunctivity.AffineOrbit.hitsOpenIntervals_late_of_denseRange_circle

example : ∀ (x r : AddCircle (1 : ℝ)) (q : ℕ) (_hq : 0 < q) (_hr : q • r = 0)
    (_hxr : DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (x + r))),
    DenseRange (fun n : ℕ => (16 ^ n : ℕ) • x) :=
  PiDisjunctivity.AffineOrbit.denseRange_of_denseRange_add_torsion

example : ∀ (x r : AddCircle (1 : ℝ)) (q : ℕ) (_hq : 0 < q) (_hr : q • r = 0),
    DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (x + r)) ↔
      DenseRange (fun n : ℕ => (16 ^ n : ℕ) • x) :=
  PiDisjunctivity.AffineOrbit.denseRange_add_torsion_iff

example : ∀ (x : ℝ) (r : ℚ),
    DenseRange (fun n : ℕ => (16 ^ n : ℕ) • ((x + (r : ℝ) : ℝ) : AddCircle (1 : ℝ))) ↔
      DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (x : AddCircle (1 : ℝ))) :=
  PiDisjunctivity.AffineOrbit.denseRange_add_rat_iff

example : ∀ (x : ℝ),
    DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (x : AddCircle (1 : ℝ))) ↔
      ∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
        ∀ N : ℕ, ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * x) ∈ Ioo a b :=
  PiDisjunctivity.AffineOrbit.denseRange_circle_iff_hitsOpenIntervals_late

example : ∀ (x : ℝ) (r : ℚ),
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * (x + (r : ℝ))) ∈ Ioo a b) ↔
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * x) ∈ Ioo a b) :=
  PiDisjunctivity.AffineOrbit.hitsOpenIntervals_late_add_rat_iff

example : ∀ (x : AddCircle (1 : ℝ)) (m : ℤ) (_hm : m ≠ 0),
    DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (m • x)) ↔
      DenseRange (fun n : ℕ => (16 ^ n : ℕ) • x) :=
  PiDisjunctivity.AffineOrbit.denseRange_zsmul_iff

example : ∀ (x : ℝ) (m : ℤ) (_hm : m ≠ 0),
    DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (((m : ℝ) * x : ℝ) : AddCircle (1 : ℝ))) ↔
      DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (x : AddCircle (1 : ℝ))) :=
  PiDisjunctivity.AffineOrbit.denseRange_int_mul_iff

example : ∀ (x : ℝ) (r : ℚ) (_hr : r ≠ 0),
    DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (((r : ℝ) * x : ℝ) : AddCircle (1 : ℝ))) ↔
      DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (x : AddCircle (1 : ℝ))) :=
  PiDisjunctivity.AffineOrbit.denseRange_rat_mul_iff

example : ∀ (x : ℝ) (r s : ℚ) (_hr : r ≠ 0),
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * ((r : ℝ) * x + (s : ℝ))) ∈ Ioo a b) ↔
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * x) ∈ Ioo a b) :=
  PiDisjunctivity.AffineOrbit.hitsOpenIntervals_late_rat_affine_iff

/--
info: 'PiDisjunctivity.AffineOrbit.eq_univ_of_mapsTo_sixteen_of_interior_nonempty' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.AffineOrbit.eq_univ_of_mapsTo_sixteen_of_interior_nonempty

/--
info: 'PiDisjunctivity.AffineOrbit.isNowhereDense_of_isClosed_mapsTo_sixteen_ne_univ' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.AffineOrbit.isNowhereDense_of_isClosed_mapsTo_sixteen_ne_univ

/--
info: 'PiDisjunctivity.AffineOrbit.orbitClosure_isNowhereDense_of_not_denseRange' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.AffineOrbit.orbitClosure_isNowhereDense_of_not_denseRange

/--
info: 'PiDisjunctivity.AffineOrbit.denseRange_sixteen_tail' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.AffineOrbit.denseRange_sixteen_tail

/--
info: 'PiDisjunctivity.AffineOrbit.hitsOpenIntervals_late_of_denseRange_circle' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.AffineOrbit.hitsOpenIntervals_late_of_denseRange_circle

/--
info: 'PiDisjunctivity.AffineOrbit.denseRange_of_denseRange_add_torsion' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.AffineOrbit.denseRange_of_denseRange_add_torsion

/--
info: 'PiDisjunctivity.AffineOrbit.denseRange_add_torsion_iff' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.AffineOrbit.denseRange_add_torsion_iff

/--
info: 'PiDisjunctivity.AffineOrbit.denseRange_add_rat_iff' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.AffineOrbit.denseRange_add_rat_iff

/--
info: 'PiDisjunctivity.AffineOrbit.denseRange_circle_iff_hitsOpenIntervals_late' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.AffineOrbit.denseRange_circle_iff_hitsOpenIntervals_late

/--
info: 'PiDisjunctivity.AffineOrbit.hitsOpenIntervals_late_add_rat_iff' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.AffineOrbit.hitsOpenIntervals_late_add_rat_iff

/--
info: 'PiDisjunctivity.AffineOrbit.denseRange_zsmul_iff' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.AffineOrbit.denseRange_zsmul_iff

/--
info: 'PiDisjunctivity.AffineOrbit.denseRange_int_mul_iff' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.AffineOrbit.denseRange_int_mul_iff

/--
info: 'PiDisjunctivity.AffineOrbit.denseRange_rat_mul_iff' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.AffineOrbit.denseRange_rat_mul_iff

/--
info: 'PiDisjunctivity.AffineOrbit.hitsOpenIntervals_late_rat_affine_iff' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.AffineOrbit.hitsOpenIntervals_late_rat_affine_iff

/-- A nonempty proper invariant set tests the exact set-level consumer. -/
example : IsNowhereDense ({0} : Set (AddCircle (1 : ℝ))) := by
  have hhalf : ((1 / 2 : ℝ) : AddCircle (1 : ℝ)) ≠ 0 := by
    intro h
    have heq : (1 / 2 : ℝ) = 0 :=
      AddCircle.injOn_coe_Ico (1 : ℝ) 0 (by norm_num) (by norm_num)
        (by simpa only [AddCircle.coe_zero] using h)
    norm_num at heq
  apply isNowhereDense_of_isClosed_mapsTo_sixteen_ne_univ {0} isClosed_singleton
  · intro z hz
    rw [mem_singleton_iff] at hz ⊢
    change (16 : ℕ) • z = 0
    rw [hz, smul_zero]
  · intro hset
    have hm : ((1 / 2 : ℝ) : AddCircle (1 : ℝ)) ∈ ({0} : Set (AddCircle (1 : ℝ))) := by
      rw [hset]
      exact mem_univ _
    exact hhalf (mem_singleton_iff.mp hm)

/-- Negative rational scaling and a nonintegral translation explicitly instantiate
both directions of the full contract through the library root. -/
example (x : ℝ) :
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N,
        Int.fract ((16 : ℝ) ^ n * (((-3 / 2 : ℚ) : ℝ) * x + ((1 / 3 : ℚ) : ℝ))) ∈ Ioo a b) ↔
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * x) ∈ Ioo a b) :=
  hitsOpenIntervals_late_rat_affine_iff x (-3 / 2) (1 / 3) (by norm_num)


/-- The existing inclusive rational BBP prefix is used at the actual entry-phase
consumer. This transfers universal late visitation, not one specified visit. -/
example (N : ℕ) (e : ℚ) :
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ M : ℕ, ∃ n ≥ M,
        Int.fract ((16 : ℝ) ^ n * ((e : ℝ) + bbpTail N)) ∈ Ioo a b) ↔
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ M : ℕ, ∃ n ≥ M, Int.fract ((16 : ℝ) ^ n * Real.pi) ∈ Ioo a b) := by
  have hphase : (((16 : ℚ) ^ N : ℚ) : ℝ) * Real.pi +
      ((e - bbpPartialSumRat N : ℚ) : ℝ) = (e : ℝ) + bbpTail N := by
    rw [Rat.cast_pow, Rat.cast_ofNat, Rat.cast_sub, cast_bbpPartialSumRat]
    linarith only [pow_mul_pi_eq_bbpPartialSum_add_bbpTail N]
  have h := hitsOpenIntervals_late_rat_affine_iff Real.pi ((16 : ℚ) ^ N)
    (e - bbpPartialSumRat N) (pow_ne_zero _ (by norm_num))
  simpa only [hphase] using h

-- First-cell and last-cell interiors retain arbitrary thresholds and the zero boundary.
example (x : ℝ)
    (hx : ∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * x) ∈ Ioo a b) (N : ℕ) :
    ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * (((-3 / 2 : ℚ) : ℝ) * x +
      ((1 / 3 : ℚ) : ℝ))) ∈ Ioo (0 : ℝ) (1 / 16) := by
  exact ((hitsOpenIntervals_late_rat_affine_iff x (-3 / 2) (1 / 3)
    (by norm_num)).mpr hx) 0 (1 / 16) (by norm_num) (by norm_num) (by norm_num) N

example (x : ℝ)
    (hx : ∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * x) ∈ Ioo a b) :
    ∃ n ≥ 0, Int.fract ((16 : ℝ) ^ n * (((-3 / 2 : ℚ) : ℝ) * x +
      ((1 / 3 : ℚ) : ℝ))) ∈ Ioo (15 / 16 : ℝ) 1 := by
  exact ((hitsOpenIntervals_late_rat_affine_iff x (-3 / 2) (1 / 3)
    (by norm_num)).mpr hx) (15 / 16) 1 (by norm_num) (by norm_num) (by norm_num) 0

-- A rational avoiding phase exercises the reverse direction without assuming density.
example : ¬ (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
    ∀ N : ℕ, ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * (1 / 3 : ℝ)) ∈ Ioo a b) := by
  intro h
  have hz := (hitsOpenIntervals_late_rat_affine_iff 0 1 (1 / 3) (by norm_num)).mp
    (by simpa only [Rat.cast_one, one_mul, Rat.cast_div, Rat.cast_ofNat, zero_add] using h)
  obtain ⟨n, _, hn⟩ := hz (1 / 4) (1 / 2) (by norm_num) (by norm_num) (by norm_num) 0
  norm_num at hn

end RationalAffineAudit

namespace ForcedEntryAudit

open PiDisjunctivity
-- Full exported contracts retain the signed-error premise and all visitation quantifiers.
example (u r : ℕ → ℝ)
    (hr : Filter.Tendsto r Filter.atTop (nhds 0))
    (hu : ∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, u n ∈ Set.Ioo a b) :
    ∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, Int.fract (u n + r n) ∈ Set.Ioo a b :=
  hitsOpenIntervals_late_fract_add_of_tendsto_zero u r hr hu

example (u r : ℕ → ℝ)
    (hr : Filter.Tendsto r Filter.atTop (nhds 0)) :
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, Int.fract (u n + r n) ∈ Set.Ioo a b) ↔
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, Int.fract (u n) ∈ Set.Ioo a b) :=
  hitsOpenIntervals_late_fract_add_iff_of_tendsto_zero u r hr

example :
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, bbpRecurrence (n + 1) ∈ Set.Ioo a b) ↔
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * Real.pi) ∈ Set.Ioo a b) :=
  bbpRecurrence_hitsOpenIntervals_late_iff_pi

example (N : ℕ) (e : ℝ) : bbpRawEntry N e 0 = e :=
  bbpRawEntry_zero N e

example (N : ℕ) (e : ℝ) (j : ℕ) :
    bbpRawEntry N e (j + 1) = 16 * bbpRawEntry N e j + bbpCoeff (N + j + 1) :=
  bbpRawEntry_succ N e j

example (N : ℕ) (e : ℝ) (j : ℕ) :
    bbpRawEntry N e j =
      (16 : ℝ) ^ j * (e + bbpTail N) - bbpTail (N + j) :=
  bbpRawEntry_eq_pow_mul_phase_sub_tail N e j

example (N j : ℕ) :
    Int.fract (bbpRawEntry N (bbpPartialSumRat N : ℝ) j) =
      bbpRecurrence (N + j + 1) :=
  fract_bbpRawEntry_partialSumRat N j

example (N : ℕ) (e : ℝ) :
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ M : ℕ, ∃ j ≥ M, Int.fract (bbpRawEntry N e j) ∈ Set.Ioo a b) ↔
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ M : ℕ, ∃ j ≥ M,
        Int.fract ((16 : ℝ) ^ j * (e + bbpTail N)) ∈ Set.Ioo a b) :=
  bbpRawEntry_hitsOpenIntervals_late_iff_phase N e

example (N : ℕ) (e : ℚ) :
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ M : ℕ, ∃ j ≥ M, Int.fract (bbpRawEntry N (e : ℝ) j) ∈ Set.Ioo a b) ↔
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ M : ℕ, ∃ n ≥ M, bbpRecurrence (n + 1) ∈ Set.Ioo a b) :=
  bbpRawEntry_hitsOpenIntervals_late_iff N e

-- The exposed definition denotes the complete future raw evolution.
example (N : ℕ) (e : ℝ) (j : ℕ) :
    bbpRawEntry N e j = (16 : ℝ) ^ j * (e - bbpPartialSum N) + bbpPartialSum (N + j) := rfl

/--
info: 'PiDisjunctivity.hitsOpenIntervals_late_fract_add_of_tendsto_zero' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.hitsOpenIntervals_late_fract_add_of_tendsto_zero

/--
info: 'PiDisjunctivity.hitsOpenIntervals_late_fract_add_iff_of_tendsto_zero' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.hitsOpenIntervals_late_fract_add_iff_of_tendsto_zero

/--
info: 'PiDisjunctivity.bbpRecurrence_hitsOpenIntervals_late_iff_pi' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpRecurrence_hitsOpenIntervals_late_iff_pi

/--
info: 'PiDisjunctivity.bbpRawEntry_zero' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpRawEntry_zero

/--
info: 'PiDisjunctivity.bbpRawEntry_succ' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpRawEntry_succ

/--
info: 'PiDisjunctivity.bbpRawEntry_eq_pow_mul_phase_sub_tail' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpRawEntry_eq_pow_mul_phase_sub_tail

/--
info: 'PiDisjunctivity.fract_bbpRawEntry_partialSumRat' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.fract_bbpRawEntry_partialSumRat

/--
info: 'PiDisjunctivity.bbpRawEntry_hitsOpenIntervals_late_iff_phase' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpRawEntry_hitsOpenIntervals_late_iff_phase

/--
info: 'PiDisjunctivity.bbpRawEntry_hitsOpenIntervals_late_iff' depends on axioms:
[propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.bbpRawEntry_hitsOpenIntervals_late_iff

-- Anchor zero retains an arbitrary rational raw entry, without evaluating it.
example (e : ℚ) :
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ M : ℕ, ∃ j ≥ M, Int.fract (bbpRawEntry 0 (e : ℝ) j) ∈ Set.Ioo a b) ↔
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ M : ℕ, ∃ n ≥ M, bbpRecurrence (n + 1) ∈ Set.Ioo a b) :=
  bbpRawEntry_hitsOpenIntervals_late_iff 0 e

-- The inclusive original prefix tests the `N+j+1` recurrence offset explicitly.
example (N j : ℕ) :
    Int.fract (bbpRawEntry N (bbpPartialSumRat N : ℝ) j) =
      bbpRecurrence (N + j + 1) :=
  fract_bbpRawEntry_partialSumRat N j

example (N : ℕ) :
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ M : ℕ, ∃ j ≥ M, bbpRecurrence (N + j + 1) ∈ Set.Ioo a b) ↔
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ M : ℕ, ∃ n ≥ M, bbpRecurrence (n + 1) ∈ Set.Ioo a b) := by
  have h := bbpRawEntry_hitsOpenIntervals_late_iff N (bbpPartialSumRat N)
  simpa only [fract_bbpRawEntry_partialSumRat] using h

-- Both endpoint-adjacent open cells retain the selected arbitrary threshold.
example (N : ℕ) (e : ℚ) (M : ℕ)
    (hV : ∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ K : ℕ, ∃ n ≥ K, bbpRecurrence (n + 1) ∈ Set.Ioo a b) :
    (∃ j ≥ M, Int.fract (bbpRawEntry N (e : ℝ) j) ∈ Set.Ioo (0 : ℝ) (1 / 16)) ∧
    (∃ j ≥ M, Int.fract (bbpRawEntry N (e : ℝ) j) ∈ Set.Ioo (15 / 16 : ℝ) 1) := by
  have h := (bbpRawEntry_hitsOpenIntervals_late_iff N e).mpr hV
  exact ⟨h 0 (1 / 16) (by norm_num) (by norm_num) (by norm_num) M,
    h (15 / 16) 1 (by norm_num) (by norm_num) (by norm_num) M⟩

end ForcedEntryAudit

namespace DyadicGridAudit

open PiDisjunctivity

-- Complete exported types retain every nearby-anchor and sieve premise.

example (k N : ℕ) (hk : 0 < k)
    (hlo : 17 ^ k ≤ 8 * N) (hhi : 8 * N < 2 * 17 ^ k) :
    padicValRat 17 (bbpPartialSumRat N) = -(k : ℤ) :=
  bbpPartialSumRat_val17_nearby k N hk hlo hhi

example (k N : ℕ) (hk : 0 < k)
    (hlo : 17 ^ k ≤ 8 * N) (hhi : 8 * N < 2 * 17 ^ k) :
    multiplicity 17 (bbpPartialSumRat N).den = k :=
  bbpPartialSumRat_den_val17_nearby k N hk hlo hhi

example (k N : ℕ) (hk : 0 < k)
    (hlo : 17 ^ k ≤ 8 * N) (hhi : 8 * N < 2 * 17 ^ k) :
    ∃ M : ℕ, (bbpPartialSumRat N).den = 17 ^ k * M ∧ M.Coprime 34 ∧ 0 < M :=
  bbpPartialSumRat_den_decomposition17_nearby k N hk hlo hhi

example (d r N j : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hcong : r ≡ 1 [MOD bbpCoverLcm (d + 1)])
    (hlo : 17 ^ (r + d) ≤ 8 * N) (hhi : 8 * N < 2 * 17 ^ (r + d)) :
    ∃ t : ℕ, Int.fract ((16 : ℝ) ^ t * (bbpPartialSumRat N : ℝ)) =
      Int.fract ((bbpPartialSumRat N : ℝ) + j / (17 : ℝ) ^ d) :=
  bbpNearby_prefix_grid d r N j hd hr hcong hlo hhi

example (d r N j : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hcong : r ≡ 1 [MOD bbpCoverLcm (d + 1)])
    (hlo : 17 ^ (r + d) ≤ 8 * N) (hhi : 8 * N < 2 * 17 ^ (r + d)) :
    ∃ t < orderOf (16 : ZMod (bbpPartialSumRat N).den),
      Int.fract ((16 : ℝ) ^ t * (bbpPartialSumRat N : ℝ)) =
        Int.fract ((bbpPartialSumRat N : ℝ) + j / (17 : ℝ) ^ d) :=
  bbpNearby_prefix_grid_in_period d r N j hd hr hcong hlo hhi

example (d r N : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hcong : r ≡ 1 [MOD bbpCoverLcm (d + 1)])
    (hlo : 17 ^ (r + d) ≤ 8 * N) (hhi : 8 * N < 2 * 17 ^ (r + d))
    (u v : ℝ) (hu : 0 ≤ u) (huv : u ≤ v) (hv : v ≤ 1) :
    |(hexadecimalPrefixIcoCount (bbpPartialSumRat N : ℝ)
        (orderOf (16 : ZMod (bbpPartialSumRat N).den)) u v : ℝ) /
      (orderOf (16 : ZMod (bbpPartialSumRat N).den) : ℝ) - (v - u)| <
      1 / (17 : ℝ) ^ d :=
  bbpNearby_prefix_discrepancy d r N hd hr hcong hlo hhi u v hu huv hv

example (k : ℕ) (hk : 0 < k) :
    ∃ s : ℕ, 17 ^ k ≤ 8 * 2 ^ s ∧ 8 * 2 ^ s < 2 * 17 ^ k :=
  exists_dyadic_nearby_anchor k hk

example (d B : ℕ) (hd : 0 < d) :
    ∃ s r : ℕ, B < s ∧ 1 < r ∧ r ≡ 1 [MOD bbpCoverLcm (d + 1)] ∧
      17 ^ (r + d) ≤ 8 * 2 ^ s ∧ 8 * 2 ^ s < 2 * 17 ^ (r + d) :=
  bbpNearby_exists_dyadic_anchor d B hd

example (d B : ℕ) (hd : 0 < d) :
    ∃ s : ℕ, B < s ∧ ∀ j : ℕ, ∃ t : ℕ,
      Int.fract ((16 : ℝ) ^ t * (bbpPartialSumRat (2 ^ s) : ℝ)) =
        Int.fract ((bbpPartialSumRat (2 ^ s) : ℝ) + j / (17 : ℝ) ^ d) :=
  bbpNearby_arbitrarily_large_dyadic_grids d B hd

example (d B : ℕ) (hd : 0 < d) :
    ∃ s : ℕ, B < s ∧ ∀ u v : ℝ, 0 ≤ u → u ≤ v → v ≤ 1 →
      |(hexadecimalPrefixIcoCount (bbpPartialSumRat (2 ^ s) : ℝ)
          (orderOf (16 : ZMod (bbpPartialSumRat (2 ^ s)).den)) u v : ℝ) /
        (orderOf (16 : ZMod (bbpPartialSumRat (2 ^ s)).den) : ℝ) - (v - u)| <
        1 / (17 : ℝ) ^ d :=
  bbpNearby_arbitrarily_large_dyadic_discrepancy d B hd

example (w B : ℕ) :
    ∃ s : ℕ, B < s ∧ ∀ word : Fin w → Fin 16,
      ∃ t < orderOf (16 : ZMod (bbpPartialSumRat (2 ^ s)).den),
        ∀ i : Fin w, baseDigit 16 (bbpPartialSumRat (2 ^ s) : ℝ)
          (t + i.val) = (word i).val :=
  bbpNearby_arbitrarily_large_dyadic_words w B

/-- info: 'PiDisjunctivity.bbpPartialSumRat_val17_nearby' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms bbpPartialSumRat_val17_nearby
/-- info: 'PiDisjunctivity.bbpPartialSumRat_den_val17_nearby' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms bbpPartialSumRat_den_val17_nearby
/-- info: 'PiDisjunctivity.bbpPartialSumRat_den_decomposition17_nearby' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms bbpPartialSumRat_den_decomposition17_nearby
/-- info: 'PiDisjunctivity.bbpNearby_prefix_grid' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms bbpNearby_prefix_grid
/-- info: 'PiDisjunctivity.bbpNearby_prefix_grid_in_period' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms bbpNearby_prefix_grid_in_period
/-- info: 'PiDisjunctivity.bbpNearby_prefix_discrepancy' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms bbpNearby_prefix_discrepancy
/-- info: 'PiDisjunctivity.exists_dyadic_nearby_anchor' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms exists_dyadic_nearby_anchor
/-- info: 'PiDisjunctivity.bbpNearby_exists_dyadic_anchor' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms bbpNearby_exists_dyadic_anchor
/-- info: 'PiDisjunctivity.bbpNearby_arbitrarily_large_dyadic_grids' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms bbpNearby_arbitrarily_large_dyadic_grids
/-- info: 'PiDisjunctivity.bbpNearby_arbitrarily_large_dyadic_discrepancy' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms bbpNearby_arbitrarily_large_dyadic_discrepancy
/-- info: 'PiDisjunctivity.bbpNearby_arbitrarily_large_dyadic_words' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms bbpNearby_arbitrarily_large_dyadic_words

-- Explicitly invoke grid translation at zero; do not discharge by choosing t=0.
example (d r N : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hc : r ≡ 1 [MOD bbpCoverLcm (d + 1)])
    (hlo : 17 ^ (r + d) ≤ 8 * N) (hhi : 8 * N < 2 * 17 ^ (r + d)) :
    ∃ t : ℕ, Int.fract ((16 : ℝ) ^ t * (bbpPartialSumRat N : ℝ)) =
      Int.fract ((bbpPartialSumRat N : ℝ) + 0 / (17 : ℝ) ^ d) :=
by
  simpa only [Nat.cast_zero] using bbpNearby_prefix_grid d r N 0 hd hr hc hlo hhi

-- The full grid length wraps back around, still through the theorem.
example (d r N : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hc : r ≡ 1 [MOD bbpCoverLcm (d + 1)])
    (hlo : 17 ^ (r + d) ≤ 8 * N) (hhi : 8 * N < 2 * 17 ^ (r + d)) :
    ∃ t : ℕ, Int.fract ((16 : ℝ) ^ t * (bbpPartialSumRat N : ℝ)) =
      Int.fract ((bbpPartialSumRat N : ℝ) + (17 ^ d : ℕ) / (17 : ℝ) ^ d) :=
  bbpNearby_prefix_grid d r N (17 ^ d) hd hr hc hlo hhi

-- The first and last grid cells consume the strict complete-period discrepancy.
example (d r N : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hc : r ≡ 1 [MOD bbpCoverLcm (d + 1)])
    (hlo : 17 ^ (r + d) ≤ 8 * N) (hhi : 8 * N < 2 * 17 ^ (r + d)) :
    |(hexadecimalPrefixIcoCount (bbpPartialSumRat N : ℝ)
      (orderOf (16 : ZMod (bbpPartialSumRat N).den)) 0 (1 / (17 : ℝ)^d) : ℝ) /
      (orderOf (16 : ZMod (bbpPartialSumRat N).den) : ℝ) - (1 / (17 : ℝ)^d - 0)| <
      1 / (17 : ℝ)^d := by
  apply bbpNearby_prefix_discrepancy d r N hd hr hc hlo hhi
  · norm_num
  · positivity
  · simpa only [div_one] using (one_div_le_one_div_of_le
      (by norm_num : (0 : ℝ) < 1)
      (show (1 : ℝ) ≤ 17 ^ d from one_le_pow₀ (by norm_num : 1 ≤ (17 : ℝ))))

example (d r N : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hc : r ≡ 1 [MOD bbpCoverLcm (d + 1)])
    (hlo : 17 ^ (r + d) ≤ 8 * N) (hhi : 8 * N < 2 * 17 ^ (r + d)) :
    |(hexadecimalPrefixIcoCount (bbpPartialSumRat N : ℝ)
      (orderOf (16 : ZMod (bbpPartialSumRat N).den)) (1 - 1 / (17 : ℝ)^d) 1 : ℝ) /
      (orderOf (16 : ZMod (bbpPartialSumRat N).den) : ℝ) - (1 - (1 - 1 / (17 : ℝ)^d))| <
      1 / (17 : ℝ)^d := by
  apply bbpNearby_prefix_discrepancy d r N hd hr hc hlo hhi
  · have h : 1 / (17 : ℝ)^d ≤ 1 := by
      simpa only [div_one] using (one_div_le_one_div_of_le
        (by norm_num : (0 : ℝ) < 1)
        (show (1 : ℝ) ≤ 17 ^ d from one_le_pow₀ (by norm_num : 1 ≤ (17 : ℝ))))
    linarith
  · have h : 0 ≤ 1 / (17 : ℝ)^d := by positivity
    linarith
  · norm_num

-- Empty words pass through the new arbitrarily-large dyadic theorem.
example (B : ℕ) : ∃ s : ℕ, B < s ∧ ∀ word : Fin 0 → Fin 16,
    ∃ t < orderOf (16 : ZMod (bbpPartialSumRat (2 ^ s)).den),
      ∀ i : Fin 0, baseDigit 16 (bbpPartialSumRat (2 ^ s) : ℝ) (t + i.val) = (word i).val :=
  bbpNearby_arbitrarily_large_dyadic_words 0 B

-- A symbolic all-last-digit word also retains its arbitrary length.
example (w B : ℕ) : ∃ s : ℕ, B < s ∧
    ∃ t < orderOf (16 : ZMod (bbpPartialSumRat (2 ^ s)).den),
      ∀ i : Fin w, baseDigit 16 (bbpPartialSumRat (2 ^ s) : ℝ) (t + i.val) = 15 := by
  obtain ⟨s, hs, hw⟩ := bbpNearby_arbitrarily_large_dyadic_words w B
  exact ⟨s, hs, hw (fun _ => 15)⟩

end DyadicGridAudit
