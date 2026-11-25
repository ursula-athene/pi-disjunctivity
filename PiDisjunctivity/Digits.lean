/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.Definitions
public import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Order.Floor.Semiring
import Mathlib.Tactic

/-! Digit bounds, finite-prefix reconstruction, and truncation error in arbitrary bases. -/

public section

namespace PiDisjunctivity

/-- Every digit lies below the base, even without a nonnegativity assumption on `x`. -/
theorem baseDigit_lt (b : ℕ) (hb : 2 ≤ b) (x : ℝ) (n : ℕ) :
    baseDigit b x n < b := by
  exact Nat.mod_lt _ (by omega)

/-- Scaling once more appends the next digit to the previous scaled floor. -/
theorem floor_pow_succ (b : ℕ) (hb : 2 ≤ b)
    (x : ℝ) (hx : 0 ≤ x) (n : ℕ) :
    Nat.floor ((b : ℝ) ^ (n + 1) * x) =
      b * Nat.floor ((b : ℝ) ^ n * x) + baseDigit b x n := by
  have hbpos : 0 < (b : ℝ) := by exact_mod_cast (show 0 < b by omega)
  have hscaled : 0 ≤ (b : ℝ) ^ n * x :=
    mul_nonneg (pow_nonneg hbpos.le n) hx
  have hq : Nat.floor ((b : ℝ) ^ (n + 1) * x) / b =
      Nat.floor ((b : ℝ) ^ n * x) := by
    rw [pow_succ, mul_right_comm]
    apply Nat.div_eq_of_lt_le
    · apply Nat.le_floor
      push_cast
      exact mul_le_mul_of_nonneg_right (Nat.floor_le hscaled) hbpos.le
    · apply (Nat.floor_lt (mul_nonneg hscaled hbpos.le)).2
      push_cast
      exact mul_lt_mul_of_pos_right (Nat.lt_floor_add_one _) hbpos
  rw [baseDigit, ← hq]
  exact (Nat.div_add_mod _ _).symm

/-- The integer part and the first `k` digits reconstruct the scaled natural floor. -/
theorem floor_pow_eq_digits (b : ℕ) (hb : 2 ≤ b)
    (x : ℝ) (hx : 0 ≤ x) (k : ℕ) :
    Nat.floor ((b : ℝ) ^ k * x) =
      b ^ k * Nat.floor x +
        ∑ i : Fin k, baseDigit b x i.val * b ^ (k - 1 - i.val) := by
  induction k with
  | zero => simp
  | succ k ih =>
    have hsum : b * (∑ i : Fin k, baseDigit b x i.val * b ^ (k - 1 - i.val)) =
        ∑ i : Fin k, baseDigit b x i.val * b ^ (k - i.val) := by
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro i _
      have hi : k - i.val = k - 1 - i.val + 1 := by
        have := i.isLt
        omega
      rw [hi, pow_succ]
      ac_rfl
    rw [floor_pow_succ b hb x hx, ih, mul_add, hsum, Fin.sum_univ_castSucc]
    simp only [Fin.val_castSucc, Fin.val_last, Nat.add_sub_cancel,
      Nat.sub_self, pow_zero, mul_one]
    rw [pow_succ]
    ring

/-- Truncating after `k` digits has nonnegative error strictly below `1 / b ^ k`. -/
theorem truncation_error (b : ℕ) (hb : 2 ≤ b)
    (x : ℝ) (hx : 0 ≤ x) (k : ℕ) :
    let t : ℝ := (Nat.floor ((b : ℝ) ^ k * x) : ℝ) / (b : ℝ) ^ k
    0 ≤ x - t ∧ x - t < 1 / (b : ℝ) ^ k := by
  dsimp
  have hbpos : 0 < (b : ℝ) := by exact_mod_cast (show 0 < b by omega)
  have hp : 0 < (b : ℝ) ^ k := pow_pos hbpos k
  have hscaled : 0 ≤ (b : ℝ) ^ k * x := mul_nonneg hp.le hx
  constructor
  · apply sub_nonneg.mpr
    apply (div_le_iff₀ hp).2
    simpa only [mul_comm] using Nat.floor_le hscaled
  · apply (lt_div_iff₀ hp).2
    rw [sub_mul, div_mul_cancel₀ _ hp.ne']
    linarith [Nat.lt_floor_add_one ((b : ℝ) ^ k * x)]

end PiDisjunctivity
