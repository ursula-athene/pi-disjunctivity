/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Tactic

/-!
The BBP coefficient and its single-term integral on `[0,1]`.
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

end PiDisjunctivity
