/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.BBP.Series
import Mathlib.Tactic

/-! The convergent BBP split and exact bridge from its recurrence to the hexadecimal π orbit. -/

public section

namespace PiDisjunctivity

/-- The scaled BBP prefix, including the coefficient at index `n`. -/
@[expose] noncomputable def bbpPartialSum (n : ℕ) : ℝ :=
  ∑ j ∈ Finset.range (n + 1), (16 : ℝ) ^ (n - j) * bbpCoeff j

/-- The scaled BBP tail starts at coefficient `n+1`; its convergence is proved below. -/
@[expose] noncomputable def bbpTail (n : ℕ) : ℝ :=
  ∑' r : ℕ, bbpCoeff (n + r + 1) / (16 : ℝ) ^ (r + 1)

/-- The BBP recurrence starts at zero and uses coefficient `n` in step `n+1`. -/
@[expose] noncomputable def bbpRecurrence : ℕ → ℝ
  | 0 => 0
  | n + 1 => Int.fract (16 * bbpRecurrence n + bbpCoeff n)

/-- The scaled BBP tail converges to the scaled π value minus the inclusive prefix. -/
theorem hasSum_bbpTail_sub (n : ℕ) :
    HasSum (fun r : ℕ => bbpCoeff (n + r + 1) / (16 : ℝ) ^ (r + 1))
      ((16 : ℝ) ^ n * Real.pi -
        ∑ j ∈ Finset.range (n + 1), (16 : ℝ) ^ (n - j) * bbpCoeff j) := by
  have hp : (∑ j ∈ Finset.range (n + 1),
      (16 : ℝ) ^ n * (bbpCoeff j / (16 : ℝ) ^ j)) =
      ∑ j ∈ Finset.range (n + 1), (16 : ℝ) ^ (n - j) * bbpCoeff j := by
    apply Finset.sum_congr rfl
    intro j hj
    have hjn : j ≤ n := Nat.le_of_lt_succ (Finset.mem_range.mp hj)
    rw [pow_sub₀ (16 : ℝ) (by norm_num : (16 : ℝ) ≠ 0) hjn]
    ring
  have h := (hasSum_nat_add_iff' (n + 1)).2
    (hasSum_bbpCoeff.mul_left ((16 : ℝ) ^ n))
  rw [hp] at h
  convert h using 1
  funext r
  have hi : r + (n + 1) = n + (r + 1) := by omega
  rw [hi, pow_add]
  simp only [← Nat.add_assoc]
  field_simp
  simp only [pow_add, pow_one]
  ring

/-- The defined BBP tail is the sum of its specified series, with convergence retained. -/
theorem hasSum_bbpTail (n : ℕ) :
    HasSum (fun r : ℕ => bbpCoeff (n + r + 1) / (16 : ℝ) ^ (r + 1))
      (bbpTail n) :=
  (hasSum_bbpTail_sub n).summable.hasSum

/-- Splitting the BBP series after coefficient `n` gives an exact scaled π identity. -/
theorem pow_mul_pi_eq_bbpPartialSum_add_bbpTail (n : ℕ) :
    (16 : ℝ) ^ n * Real.pi = bbpPartialSum n + bbpTail n := by
  have h : bbpTail n = (16 : ℝ) ^ n * Real.pi - bbpPartialSum n :=
    (hasSum_bbpTail_sub n).tsum_eq
  rw [h]
  ring

private theorem bbpPartialSum_zero : bbpPartialSum 0 = bbpCoeff 0 := by
  simp [bbpPartialSum]

private theorem bbpPartialSum_succ (n : ℕ) :
    bbpPartialSum (n + 1) = 16 * bbpPartialSum n + bbpCoeff (n + 1) := by
  unfold bbpPartialSum
  rw [Finset.sum_range_succ, Finset.mul_sum]
  simp only [Nat.sub_self, pow_zero, one_mul]
  congr 1
  apply Finset.sum_congr rfl
  intro j hj
  have hjn : j ≤ n := Nat.le_of_lt_succ (Finset.mem_range.mp hj)
  rw [Nat.succ_sub hjn, pow_succ]
  ring

/-- Every BBP recurrence value lies in the half-open unit interval, including index zero. -/
theorem bbpRecurrence_mem_Ico (n : ℕ) : bbpRecurrence n ∈ Set.Ico (0 : ℝ) 1 := by
  cases n with
  | zero => norm_num [bbpRecurrence]
  | succ n => exact ⟨Int.fract_nonneg _, Int.fract_lt_one _⟩

/-- Recurrence index `n+1` is the fractional part of the prefix through coefficient `n`. -/
theorem bbpRecurrence_succ_eq_fract_bbpPartialSum (n : ℕ) :
    bbpRecurrence (n + 1) = Int.fract (bbpPartialSum n) := by
  induction n with
  | zero => simp [bbpRecurrence, bbpPartialSum_zero]
  | succ n ih =>
    rw [bbpRecurrence, ih, bbpPartialSum_succ]
    apply Int.fract_eq_fract.mpr
    refine ⟨-16 * ⌊bbpPartialSum n⌋, ?_⟩
    simp only [Int.fract, Int.cast_mul, Int.cast_neg, Int.cast_ofNat]
    ring

/-- The actual hexadecimal π orbit equals the recurrence plus its convergent BBP tail. -/
theorem fract_pow_mul_pi_eq_bbpRecurrence_add_bbpTail (n : ℕ) :
    Int.fract ((16 : ℝ) ^ n * Real.pi) =
      Int.fract (bbpRecurrence (n + 1) + bbpTail n) := by
  rw [pow_mul_pi_eq_bbpPartialSum_add_bbpTail, bbpRecurrence_succ_eq_fract_bbpPartialSum,
    Int.fract_fract_add]

end PiDisjunctivity
