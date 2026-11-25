/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.Definitions
public import Mathlib.Algebra.BigOperators.Fin
public import Mathlib.Analysis.Real.OfDigits
import Mathlib.Algebra.Order.Floor.Semiring
import Mathlib.Tactic

/-! Digit bounds, reconstruction, truncation, and termination in arbitrary bases. -/

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

/-- A terminating base-`b` expansion has zero at every position after its length-`k` prefix. -/
theorem baseDigit_div_pow_eq_zero (b : ℕ) (hb : 2 ≤ b) (m k n : ℕ) :
    baseDigit b ((m : ℝ) / (b : ℝ) ^ k) (k + n) = 0 := by
  have hb0 : (b : ℝ) ≠ 0 := by exact_mod_cast (show b ≠ 0 by omega)
  have hscaled : (b : ℝ) ^ (k + n + 1) * ((m : ℝ) / (b : ℝ) ^ k) =
      ((b ^ (n + 1) * m : ℕ) : ℝ) := by
    push_cast
    rw [show k + n + 1 = k + (n + 1) by omega, pow_add]
    field_simp
  rw [baseDigit, hscaled, Nat.floor_natCast]
  simp [pow_succ, Nat.mul_mod]

/-- The base-`b` fractional digits sum to the fractional part of every nonnegative input. -/
theorem hasSum_baseDigit (b : ℕ) (hb : 2 ≤ b) (x : ℝ) (hx : 0 ≤ x) :
    HasSum (fun n => (baseDigit b x n : ℝ) / (b : ℝ) ^ (n + 1)) (Int.fract x) := by
  let : NeZero b := ⟨by omega⟩
  have hdigits (n : ℕ) : (Real.digits (Int.fract x) b n).val = baseDigit b x n := by
    have hsplit : Int.fract x + (Nat.floor x : ℝ) = x := by
      rw [natCast_floor_eq_intCast_floor hx, Int.fract_add_floor]
    have hscaled : (b : ℝ) ^ (n + 1) * x =
        (b : ℝ) ^ (n + 1) * Int.fract x + ((b ^ (n + 1) * Nat.floor x : ℕ) : ℝ) := by
      calc
        _ = (b : ℝ) ^ (n + 1) * (Int.fract x + (Nat.floor x : ℝ)) := by rw [hsplit]
        _ = _ := by push_cast; ring
    simp only [Real.digits, Fin.val_ofNat, baseDigit]
    rw [mul_comm (Int.fract x), hscaled,
      Nat.floor_add_natCast (mul_nonneg (by positivity) (Int.fract_nonneg x))]
    simp [Nat.add_mod, Nat.mul_mod, pow_succ]
  have hterms : Real.ofDigitsTerm (Real.digits (Int.fract x) b) =
      fun n => (baseDigit b x n : ℝ) / (b : ℝ) ^ (n + 1) := by
    funext n
    simp only [Real.ofDigitsTerm, hdigits, div_eq_mul_inv]
  rw [← hterms]
  exact Real.hasSum_ofDigitsTerm_digits (Int.fract x) (by omega)
    ⟨Int.fract_nonneg x, Int.fract_lt_one x⟩

end PiDisjunctivity
