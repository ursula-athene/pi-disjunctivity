/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Analysis.SpecificLimits.Basic
import Mathlib.Tactic

/-!
The BBP coefficient, single-term integral, pointwise series, and domination on `[0,1]`.
The argument and source references are recorded in `docs/b1-source-proof-review.md`.
This independent proof does not establish the infinite series identity for π.
-/

public section

namespace PiDisjunctivity

/-- The real coefficient of `16⁻ʲ` in the Bailey–Borwein–Plouffe series. -/
@[expose] noncomputable def bbpCoeff (j : ℕ) : ℝ :=
  4 / (8 * (j : ℝ) + 1) - 2 / (8 * (j : ℝ) + 4)
    - 1 / (8 * (j : ℝ) + 5) - 1 / (8 * (j : ℝ) + 6)

/-- Integrating one scaled BBP term gives the corresponding series coefficient.
This holds for every natural index, including zero, without a convergence hypothesis. -/
theorem integral_bbpTerm (j : ℕ) :
    (∫ x in (0 : ℝ)..1,
      (x ^ 8 / 16) ^ j * (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5)) =
      bbpCoeff j / (16 : ℝ) ^ j := by
  have hp (n : ℕ) : IntervalIntegrable (fun x : ℝ => x ^ n) MeasureTheory.volume 0 1 :=
    (continuous_id.pow n).intervalIntegrable 0 1
  have hexpand (x : ℝ) :
      (x ^ 8 / 16) ^ j * (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5) =
        (4 * x ^ (8 * j) - 2 * x ^ (8 * j + 3) - x ^ (8 * j + 4)
          - x ^ (8 * j + 5)) / (16 : ℝ) ^ j := by
    rw [div_pow, ← pow_mul]
    simp only [pow_add]
    ring
  simp_rw [hexpand]
  rw [intervalIntegral.integral_div,
    intervalIntegral.integral_sub
      (((hp _).const_mul 4).sub ((hp _).const_mul 2) |>.sub (hp _)) (hp _),
    intervalIntegral.integral_sub
      (((hp _).const_mul 4).sub ((hp _).const_mul 2)) (hp _),
    intervalIntegral.integral_sub ((hp _).const_mul 4) ((hp _).const_mul 2)]
  simp only [intervalIntegral.integral_const_mul, integral_pow, one_pow,
    zero_pow (Nat.succ_ne_zero _), sub_zero, Nat.cast_add, Nat.cast_mul, Nat.cast_ofNat]
  dsimp [bbpCoeff]
  ring

/-- The scaled BBP terms sum pointwise to the rational kernel on the closed unit interval. -/
theorem hasSum_bbpTerm (x : ℝ) (hx : x ∈ Set.Icc (0 : ℝ) 1) :
    HasSum (fun j : ℕ => (x ^ 8 / 16) ^ j * (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5))
      ((4 - 2 * x ^ 3 - x ^ 4 - x ^ 5) / (1 - x ^ 8 / 16)) := by
  have hq0 : 0 ≤ x ^ 8 / 16 := div_nonneg (pow_nonneg hx.1 _) (by norm_num)
  have hqle : x ^ 8 / 16 ≤ 1 / (16 : ℝ) :=
    div_le_div_of_nonneg_right (pow_le_one₀ hx.1 hx.2) (by norm_num)
  have hden : 0 < 1 - x ^ 8 / 16 := by linarith
  convert
    (hasSum_geometric_of_lt_one hq0 (sub_pos.mp hden)).mul_right
      (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5) using 1
  ring

/-- A uniform geometric bound for the scaled BBP terms, including the zero index. -/
theorem norm_bbpTerm_le (j : ℕ) (x : ℝ) (hx : x ∈ Set.Icc (0 : ℝ) 1) :
    ‖(x ^ 8 / 16) ^ j * (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5)‖ ≤
      8 * (1 / (16 : ℝ)) ^ j := by
  have hq0 : 0 ≤ x ^ 8 / 16 := div_nonneg (pow_nonneg hx.1 _) (by norm_num)
  have hqle : x ^ 8 / 16 ≤ 1 / (16 : ℝ) :=
    div_le_div_of_nonneg_right (pow_le_one₀ hx.1 hx.2) (by norm_num)
  have hp : ‖4 - 2 * x ^ 3 - x ^ 4 - x ^ 5‖ ≤ 8 := by
    rw [Real.norm_eq_abs, abs_le]
    constructor
    · linarith [pow_le_one₀ hx.1 hx.2 (n := 3), pow_le_one₀ hx.1 hx.2 (n := 4),
        pow_le_one₀ hx.1 hx.2 (n := 5)]
    · linarith [pow_nonneg hx.1 3, pow_nonneg hx.1 4, pow_nonneg hx.1 5]
  rw [norm_mul, Real.norm_of_nonneg (pow_nonneg hq0 j)]
  calc
    (x ^ 8 / 16) ^ j * ‖4 - 2 * x ^ 3 - x ^ 4 - x ^ 5‖ ≤
        (1 / (16 : ℝ)) ^ j * 8 :=
      mul_le_mul (pow_le_pow_left₀ hq0 hqle j) hp (norm_nonneg _) (by positivity)
    _ = 8 * (1 / (16 : ℝ)) ^ j := mul_comm _ _

end PiDisjunctivity
