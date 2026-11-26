/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.BBP.Orbit
import Mathlib.Analysis.Normed.Group.InfiniteSum
import Mathlib.Analysis.SpecificLimits.Basic
import Mathlib.Tactic

/-! Unconditional coefficient and tail bounds for the BBP recurrence error. -/

public section

namespace PiDisjunctivity

/-- The BBP coefficient is bounded in absolute value at every natural index. -/
theorem abs_bbpCoeff_le (j : ℕ) :
    |bbpCoeff j| ≤ 8 / (8 * (j : ℝ) + 1) := by
  have hd : 0 < 8 * (j : ℝ) + 1 := by positivity
  have h2 : 2 / (8 * (j : ℝ) + 4) ≤ 2 / (8 * (j : ℝ) + 1) :=
    div_le_div_of_nonneg_left (by norm_num) hd (by linarith)
  have h5 : 1 / (8 * (j : ℝ) + 5) ≤ 1 / (8 * (j : ℝ) + 1) :=
    div_le_div_of_nonneg_left (by norm_num) hd (by linarith)
  have h6 : 1 / (8 * (j : ℝ) + 6) ≤ 1 / (8 * (j : ℝ) + 1) :=
    div_le_div_of_nonneg_left (by norm_num) hd (by linarith)
  calc
    |bbpCoeff j| ≤ |4 / (8 * (j : ℝ) + 1) - 2 / (8 * (j : ℝ) + 4)
        - 1 / (8 * (j : ℝ) + 5)| + |1 / (8 * (j : ℝ) + 6)| := abs_sub _ _
    _ ≤ (|4 / (8 * (j : ℝ) + 1) - 2 / (8 * (j : ℝ) + 4)|
        + |1 / (8 * (j : ℝ) + 5)|) + |1 / (8 * (j : ℝ) + 6)| :=
      add_le_add (abs_sub _ _) le_rfl
    _ ≤ ((|4 / (8 * (j : ℝ) + 1)| + |2 / (8 * (j : ℝ) + 4)|)
        + |1 / (8 * (j : ℝ) + 5)|) + |1 / (8 * (j : ℝ) + 6)| :=
      add_le_add (add_le_add (abs_sub _ _) le_rfl) le_rfl
    _ = 4 / (8 * (j : ℝ) + 1) + 2 / (8 * (j : ℝ) + 4)
        + 1 / (8 * (j : ℝ) + 5) + 1 / (8 * (j : ℝ) + 6) := by
      rw [abs_of_nonneg (by positivity : 0 ≤ 4 / (8 * (j : ℝ) + 1)),
        abs_of_nonneg (by positivity : 0 ≤ 2 / (8 * (j : ℝ) + 4)),
        abs_of_nonneg (by positivity : 0 ≤ 1 / (8 * (j : ℝ) + 5)),
        abs_of_nonneg (by positivity : 0 ≤ 1 / (8 * (j : ℝ) + 6))]
    _ ≤ 4 / (8 * (j : ℝ) + 1) + 2 / (8 * (j : ℝ) + 1)
        + 1 / (8 * (j : ℝ) + 1) + 1 / (8 * (j : ℝ) + 1) := by
      linarith only [h2, h5, h6]
    _ = 8 / (8 * (j : ℝ) + 1) := by ring

/-- The tail after coefficient `n` is bounded by a geometric majorant starting at `1/16`. -/
theorem abs_bbpTail_le (n : ℕ) :
    |bbpTail n| ≤ 8 / (15 * (8 * (n : ℝ) + 9)) := by
  have hg : HasSum
      (fun r : ℕ => (8 / (8 * (n : ℝ) + 9)) / (16 : ℝ) ^ (r + 1))
      (8 / (15 * (8 * (n : ℝ) + 9))) := by
    have h := (hasSum_geometric_of_lt_one (by norm_num : 0 ≤ (1 / 16 : ℝ))
      (by norm_num : (1 / 16 : ℝ) < 1)).mul_left ((8 / (8 * (n : ℝ) + 9)) / 16)
    convert h using 1
    · funext r
      simp only [div_pow, one_pow, pow_succ]
      ring
    · field_simp
      ring
  have hb : ∀ r : ℕ, ‖bbpCoeff (n + r + 1) / (16 : ℝ) ^ (r + 1)‖ ≤
      (8 / (8 * (n : ℝ) + 9)) / (16 : ℝ) ^ (r + 1) := by
    intro r
    rw [Real.norm_eq_abs, abs_div, abs_of_pos (pow_pos (by norm_num : (0 : ℝ) < 16) _)]
    apply div_le_div_of_nonneg_right _ (by positivity)
    calc
      |bbpCoeff (n + r + 1)| ≤ 8 / (8 * ((n + r + 1 : ℕ) : ℝ) + 1) := abs_bbpCoeff_le _
      _ ≤ 8 / (8 * (n : ℝ) + 9) := by
        apply div_le_div_of_nonneg_left (by norm_num) (by positivity)
        push_cast
        linarith only [Nat.cast_nonneg (α := ℝ) r]
  simpa only [Real.norm_eq_abs] using (hasSum_bbpTail n).norm_le_of_bounded hg hb

/-- The BBP error tends to zero, without any visitation hypothesis. -/
theorem tendsto_bbpTail : Filter.Tendsto bbpTail Filter.atTop (nhds 0) := by
  refine squeeze_zero_norm (f := bbpTail)
    (a := fun n => 8 / (15 * (8 * (n : ℝ) + 9))) (fun n => ?_) ?_
  · simpa only [Real.norm_eq_abs] using abs_bbpTail_le n
  · apply Filter.Tendsto.const_div_atTop _ 8
    apply Filter.tendsto_atTop_mono (fun n : ℕ => ?_) tendsto_natCast_atTop_atTop
    have hn : (0 : ℝ) ≤ n := Nat.cast_nonneg n
    linarith only [hn]

end PiDisjunctivity
