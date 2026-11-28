/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.OrbitCriteria
public import PiDisjunctivity.AffineOrbit
public import PiDisjunctivity.BBP.Tail
public import PiDisjunctivity.BBP.RationalPrefix
import Mathlib.Tactic

/-! Exact late-visitation equivalences for rational BBP entries; no visitation premise is proved. -/

public section

namespace PiDisjunctivity

/-- The actual BBP late-visitation obligation is equivalent to late visitation of the π orbit.
The recurrence is evaluated at `n+1`, matching the inclusive coefficient prefix. -/
theorem bbpRecurrence_hitsOpenIntervals_late_iff_pi :
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, bbpRecurrence (n + 1) ∈ Set.Ioo a b) ↔
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * Real.pi) ∈ Set.Ioo a b) := by
  have h := hitsOpenIntervals_late_fract_add_iff_of_tendsto_zero
    (fun n => bbpRecurrence (n + 1)) bbpTail tendsto_bbpTail
  have hfract : ∀ n, Int.fract (bbpRecurrence (n + 1)) = bbpRecurrence (n + 1) := by
    intro n
    exact Int.fract_eq_self.mpr (bbpRecurrence_mem_Ico (n + 1))
  simpa only [← fract_pow_mul_pi_eq_bbpRecurrence_add_bbpTail, hfract] using h.symm

/-- The exact raw entry evolution after the coefficient anchor `N`.
Its finite-prefix expression keeps every future coefficient. -/
@[expose] noncomputable def bbpRawEntry (N : ℕ) (e : ℝ) (j : ℕ) : ℝ :=
  (16 : ℝ) ^ j * (e - bbpPartialSum N) + bbpPartialSum (N + j)

/-- The raw entry is the prescribed real value at future time zero. -/
theorem bbpRawEntry_zero (N : ℕ) (e : ℝ) : bbpRawEntry N e 0 = e := by
  simp only [bbpRawEntry, pow_zero, one_mul, Nat.add_zero, sub_add_cancel]

private theorem rawEntry_partialSum_succ (n : ℕ) :
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

/-- Every raw future step uses exactly the next BBP coefficient. -/
theorem bbpRawEntry_succ (N : ℕ) (e : ℝ) (j : ℕ) :
    bbpRawEntry N e (j + 1) = 16 * bbpRawEntry N e j + bbpCoeff (N + j + 1) := by
  simp only [bbpRawEntry, ← Nat.add_assoc, rawEntry_partialSum_succ, pow_succ]
  ring

/-- The exact raw entry identity isolates the unconditionally vanishing tail. -/
theorem bbpRawEntry_eq_pow_mul_phase_sub_tail (N : ℕ) (e : ℝ) (j : ℕ) :
    bbpRawEntry N e j =
      (16 : ℝ) ^ j * (e + bbpTail N) - bbpTail (N + j) := by
  have hN := pow_mul_pi_eq_bbpPartialSum_add_bbpTail N
  have hNj := pow_mul_pi_eq_bbpPartialSum_add_bbpTail (N + j)
  rw [pow_add] at hNj
  unfold bbpRawEntry
  rw [show bbpPartialSum N = (16 : ℝ) ^ N * Real.pi - bbpTail N by linarith only [hN],
    show bbpPartialSum (N + j) =
      (16 : ℝ) ^ N * (16 : ℝ) ^ j * Real.pi - bbpTail (N + j) by linarith only [hNj]]
  ring

/-- The original rational prefix recovers the initialized recurrence with its `+1` offset. -/
theorem fract_bbpRawEntry_partialSumRat (N j : ℕ) :
    Int.fract (bbpRawEntry N (bbpPartialSumRat N : ℝ) j) =
      bbpRecurrence (N + j + 1) := by
  rw [bbpRawEntry, cast_bbpPartialSumRat, sub_self, mul_zero, zero_add,
    bbpRecurrence_succ_eq_fract_bbpPartialSum]

/-- Every real raw entry has the same universal late-visitation property as its pure phase. -/
theorem bbpRawEntry_hitsOpenIntervals_late_iff_phase (N : ℕ) (e : ℝ) :
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ M : ℕ, ∃ j ≥ M, Int.fract (bbpRawEntry N e j) ∈ Set.Ioo a b) ↔
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ M : ℕ, ∃ j ≥ M,
        Int.fract ((16 : ℝ) ^ j * (e + bbpTail N)) ∈ Set.Ioo a b) := by
  have hshift : Filter.Tendsto (fun j => bbpTail (N + j)) Filter.atTop (nhds 0) := by
    simpa only [Function.comp_def, Nat.add_comm N] using
      tendsto_bbpTail.comp (Filter.tendsto_add_atTop_nat N)
  have hneg : Filter.Tendsto (fun j => -bbpTail (N + j)) Filter.atTop (nhds 0) := by
    simpa only [neg_zero] using hshift.neg
  have h := hitsOpenIntervals_late_fract_add_iff_of_tendsto_zero
    (fun j => (16 : ℝ) ^ j * (e + bbpTail N))
    (fun j => -bbpTail (N + j)) hneg
  simpa only [← sub_eq_add_neg, ← bbpRawEntry_eq_pow_mul_phase_sub_tail] using h

/-- Each fixed rational raw entry preserves the full actual BBP late-visitation obligation.
Neither side is established; the statement retains all interval and threshold quantifiers. -/
theorem bbpRawEntry_hitsOpenIntervals_late_iff (N : ℕ) (e : ℚ) :
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ M : ℕ, ∃ j ≥ M, Int.fract (bbpRawEntry N (e : ℝ) j) ∈ Set.Ioo a b) ↔
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ M : ℕ, ∃ n ≥ M, bbpRecurrence (n + 1) ∈ Set.Ioo a b) := by
  have hphase : (((16 : ℚ) ^ N : ℚ) : ℝ) * Real.pi +
      ((e - bbpPartialSumRat N : ℚ) : ℝ) = (e : ℝ) + bbpTail N := by
    rw [Rat.cast_pow, Rat.cast_ofNat, Rat.cast_sub, cast_bbpPartialSumRat]
    linarith only [pow_mul_pi_eq_bbpPartialSum_add_bbpTail N]
  have haffine := AffineOrbit.hitsOpenIntervals_late_rat_affine_iff
    Real.pi ((16 : ℚ) ^ N) (e - bbpPartialSumRat N) (pow_ne_zero _ (by norm_num))
  rw [hphase] at haffine
  exact (bbpRawEntry_hitsOpenIntervals_late_iff_phase N (e : ℝ)).trans
    (haffine.trans bbpRecurrence_hitsOpenIntervals_late_iff_pi.symm)

end PiDisjunctivity
