/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Analysis.SpecificLimits.Basic
import Mathlib.MeasureTheory.Integral.DominatedConvergence
import Mathlib.Tactic

/-!
The Bailey–Borwein–Plouffe series for π, proved by integrating a geometric series on `[0,1]`.
The argument and source references are recorded in `docs/b1-source-proof-review.md`.
These independent proofs establish the series identity, without a disjunctivity assertion.
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

/-- The BBP coefficient series sums to the rational integral, without evaluating it as π. -/
theorem hasSum_bbpCoeff_integral :
    HasSum (fun j : ℕ => bbpCoeff j / (16 : ℝ) ^ j)
      (∫ x in (0 : ℝ)..1,
        (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5) / (1 - x ^ 8 / 16)) := by
  have hsub : Set.uIoc (0 : ℝ) 1 ⊆ Set.Icc 0 1 := by
    rw [Set.uIoc_of_le (by norm_num)]
    exact Set.Ioc_subset_Icc_self
  have hsum :
      HasSum (fun j : ℕ => ∫ x in (0 : ℝ)..1,
        (x ^ 8 / 16) ^ j * (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5))
        (∫ x in (0 : ℝ)..1,
          (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5) / (1 - x ^ 8 / 16)) := by
    apply intervalIntegral.hasSum_integral_of_dominated_convergence
      (fun j (_ : ℝ) => 8 * (1 / (16 : ℝ)) ^ j)
    · intro j
      exact (by fun_prop : Continuous (fun x : ℝ =>
        (x ^ 8 / 16) ^ j * (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5))).aestronglyMeasurable
    · intro j
      exact MeasureTheory.ae_of_all _ fun x hx => norm_bbpTerm_le j x (hsub hx)
    · exact MeasureTheory.ae_of_all _ fun _ _ =>
        (summable_geometric_of_lt_one (by norm_num : 0 ≤ 1 / (16 : ℝ))
          (by norm_num)).mul_left 8
    · exact intervalIntegrable_const
    · exact MeasureTheory.ae_of_all _ fun x hx => hasSum_bbpTerm x (hsub hx)
  simpa only [integral_bbpTerm] using hsum

/-- Partial fractions for the BBP rational kernel on the closed unit interval. -/
theorem bbpKernel_eq_partialFractions (x : ℝ) (hx : x ∈ Set.Icc (0 : ℝ) 1) :
    (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5) / (1 - x ^ 8 / 16) =
      (-4 * x) / (2 - x ^ 2) - 4 * (x - 2) / (x ^ 2 - 2 * x + 2) := by
  have hD : 0 < 2 - x ^ 2 := by
    linarith [pow_le_one₀ hx.1 hx.2 (n := 2)]
  have hQ : 0 < x ^ 2 - 2 * x + 2 := by nlinarith [sq_nonneg (x - 1)]
  have h8 := pow_le_one₀ hx.1 hx.2 (n := 8)
  field_simp (disch := linarith)
  ring

/-- The logarithm/arctangent primitive has the BBP kernel as its derivative, including endpoints. -/
theorem hasDerivAt_bbpPrimitive (x : ℝ) (hx : x ∈ Set.Icc (0 : ℝ) 1) :
    HasDerivAt (fun y : ℝ =>
      2 * Real.log (2 - y ^ 2) - 2 * Real.log (y ^ 2 - 2 * y + 2)
        + 4 * Real.arctan (y - 1))
      ((4 - 2 * x ^ 3 - x ^ 4 - x ^ 5) / (1 - x ^ 8 / 16)) x := by
  have hD : 0 < 2 - x ^ 2 := by
    linarith [pow_le_one₀ hx.1 hx.2 (n := 2)]
  have hQ : 0 < x ^ 2 - 2 * x + 2 := by nlinarith [sq_nonneg (x - 1)]
  have hD' : HasDerivAt (fun y : ℝ => 2 - y ^ 2) (-(2 * x)) x := by
    simpa using (hasDerivAt_pow 2 x).const_sub 2
  have hQ' : HasDerivAt (fun y : ℝ => y ^ 2 - 2 * y + 2) (2 * x - 2) x := by
    simpa using ((hasDerivAt_pow 2 x).sub ((hasDerivAt_id x).const_mul 2)).add_const 2
  have h := ((hD'.log hD.ne').const_mul 2).sub ((hQ'.log hQ.ne').const_mul 2)
    |>.add (((hasDerivAt_id x).sub_const 1).arctan.const_mul 4)
  convert h using 1
  · rfl
  · dsimp only [id_eq]
    rw [bbpKernel_eq_partialFractions x hx]
    have hq : 1 + (x - 1) ^ 2 = x ^ 2 - 2 * x + 2 := by ring
    rw [hq]
    ring

/-- The rational integral obtained from the BBP series equals Mathlib's π. -/
theorem integral_bbpKernel :
    (∫ x in (0 : ℝ)..1,
      (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5) / (1 - x ^ 8 / 16)) = Real.pi := by
  have hcont : ContinuousOn (fun x : ℝ =>
      (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5) / (1 - x ^ 8 / 16)) (Set.Icc 0 1) := by
    refine (by fun_prop : Continuous (fun x : ℝ =>
      4 - 2 * x ^ 3 - x ^ 4 - x ^ 5)).continuousOn.div
      (by fun_prop : Continuous (fun x : ℝ => 1 - x ^ 8 / 16)).continuousOn ?_
    intro x hx
    have := pow_le_one₀ hx.1 hx.2 (n := 8)
    linarith
  have hftc := intervalIntegral.integral_eq_sub_of_hasDerivAt
    (a := (0 : ℝ)) (b := 1)
    (fun x hx => hasDerivAt_bbpPrimitive x
      (by simpa only [Set.uIcc_of_le (by norm_num : (0 : ℝ) ≤ 1)] using hx))
    (hcont.intervalIntegrable_of_Icc (by norm_num))
  convert hftc using 1
  norm_num [Real.arctan_neg, Real.arctan_one]
  ring

/-- The Bailey–Borwein–Plouffe series converges to Mathlib's π. -/
theorem hasSum_bbpCoeff :
    HasSum (fun j : ℕ => bbpCoeff j / (16 : ℝ) ^ j) Real.pi := by
  simpa only [integral_bbpKernel] using hasSum_bbpCoeff_integral

end PiDisjunctivity
