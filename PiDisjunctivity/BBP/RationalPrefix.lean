/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.BBP.Orbit
import Mathlib.Algebra.GCDMonoid.FinsetLemmas
import Mathlib.Algebra.BigOperators.Associated
import Mathlib.Tactic

/-!
Exact rational BBP prefixes and elementary denominator properties.
These definitions agree with the existing real prefix and zero-initialized recurrence.
They support arithmetic orbit arguments and assert no visitation or normality result.
-/

public section

namespace PiDisjunctivity

/-- The rational BBP coefficient, with the same four fractions as `bbpCoeff`. -/
@[expose] def bbpCoeffRat (j : ℕ) : ℚ :=
  4 / (8 * (j : ℚ) + 1) - 2 / (8 * (j : ℚ) + 4)
    - 1 / (8 * (j : ℚ) + 5) - 1 / (8 * (j : ℚ) + 6)

/-- The exact rational scaled BBP prefix through the inclusive index `n`. -/
@[expose] def bbpPartialSumRat (n : ℕ) : ℚ :=
  ∑ j ∈ Finset.range (n + 1), (16 : ℚ) ^ (n - j) * bbpCoeffRat j

/-- Casting the rational coefficient recovers the existing real coefficient. -/
theorem cast_bbpCoeffRat (j : ℕ) :
    (bbpCoeffRat j : ℝ) = bbpCoeff j := by
  simp only [bbpCoeffRat, bbpCoeff, Rat.cast_sub, Rat.cast_div,
    Rat.cast_mul, Rat.cast_add, Rat.cast_ofNat, Rat.cast_natCast, Rat.cast_one]

/-- Casting the rational prefix recovers the existing inclusive real prefix. -/
theorem cast_bbpPartialSumRat (n : ℕ) :
    (bbpPartialSumRat n : ℝ) = bbpPartialSum n := by
  simp only [bbpPartialSumRat, bbpPartialSum, Rat.cast_sum, Rat.cast_mul,
    Rat.cast_pow, Rat.cast_ofNat, cast_bbpCoeffRat]

/-- The initialized recurrence at `n+1` is the fractional part of the rational prefix. -/
theorem bbpRecurrence_succ_eq_fract_bbpPartialSumRat (n : ℕ) :
    bbpRecurrence (n + 1) = Int.fract (bbpPartialSumRat n : ℝ) := by
  rw [cast_bbpPartialSumRat, bbpRecurrence_succ_eq_fract_bbpPartialSum]

/-- Combining the four fractions gives a positive numerator and an odd denominator. -/
theorem bbpCoeffRat_eq_positive_fraction (j : ℕ) :
    bbpCoeffRat j =
      (120 * (j : ℚ) ^ 2 + 151 * j + 47) /
        ((2 * j + 1) * (4 * j + 3) * (8 * j + 1) * (8 * j + 5)) := by
  unfold bbpCoeffRat
  field_simp
  ring

/-- Every rational BBP coefficient is strictly positive. -/
theorem bbpCoeffRat_pos (j : ℕ) : 0 < bbpCoeffRat j := by
  rw [bbpCoeffRat_eq_positive_fraction]
  positivity

/-- Every inclusive rational BBP prefix is strictly positive. -/
theorem bbpPartialSumRat_pos (n : ℕ) : 0 < bbpPartialSumRat n := by
  unfold bbpPartialSumRat
  apply Finset.sum_pos
  · intro j _
    exact mul_pos (pow_pos (by norm_num) _) (bbpCoeffRat_pos j)
  · exact Finset.nonempty_range_iff.mpr (by omega)

/-- An odd common denominator for one BBP coefficient; not necessarily reduced. -/
@[expose] def bbpCoeffCommonDenominator (j : ℕ) : ℕ :=
  (2 * j + 1) * (4 * j + 3) * (8 * j + 1) * (8 * j + 5)

private theorem den_natCast_div_dvd (a b : ℕ) : ((a : ℚ) / b).den ∣ b := by
  apply Int.natCast_dvd_natCast.mp
  simpa only [Rat.divInt_eq_div, Int.cast_natCast] using Rat.den_dvd (a : ℤ) (b : ℤ)

/-- The reduced coefficient denominator divides the explicit common denominator. -/
theorem bbpCoeffRat_den_dvd (j : ℕ) :
    (bbpCoeffRat j).den ∣ bbpCoeffCommonDenominator j := by
  rw [bbpCoeffRat_eq_positive_fraction]
  have h := den_natCast_div_dvd (120 * j ^ 2 + 151 * j + 47) (bbpCoeffCommonDenominator j)
  norm_num [bbpCoeffCommonDenominator] at h ⊢
  exact h

/-- The common denominator is odd at every natural index. -/
theorem bbpCoeffCommonDenominator_odd (j : ℕ) : Odd (bbpCoeffCommonDenominator j) := by
  simp [bbpCoeffCommonDenominator, Nat.odd_iff, Nat.mul_mod, Nat.add_mod]

/-- The reduced prefix denominator divides the product of the coefficient common denominators. -/
theorem bbpPartialSumRat_den_dvd (n : ℕ) :
    (bbpPartialSumRat n).den ∣ ∏ j ∈ Finset.range (n + 1), bbpCoeffCommonDenominator j := by
  refine (Finset.Rat.den_sum_dvd_prod_den _ _).trans ?_
  apply Finset.prod_dvd_prod_of_dvd
  intro j _
  have h := Rat.mul_den_dvd ((16 : ℚ) ^ (n - j)) (bbpCoeffRat j)
  have hpow : ((16 : ℚ) ^ (n - j)).den = 1 := by
    rw [show (16 : ℚ) ^ (n - j) = ((16 ^ (n - j) : ℕ) : ℚ) by norm_cast]
    simp
  rw [hpow, one_mul] at h
  exact h.trans (bbpCoeffRat_den_dvd j)

/-- Every reduced BBP prefix denominator is odd. -/
theorem bbpPartialSumRat_den_odd (n : ℕ) : Odd (bbpPartialSumRat n).den := by
  apply Odd.of_dvd_nat _ (bbpPartialSumRat_den_dvd n)
  apply Finset.prod_induction bbpCoeffCommonDenominator (fun x : ℕ => Odd x)
  · intro a b ha hb
    exact ha.mul hb
  · exact odd_one
  · intro j _
    exact bbpCoeffCommonDenominator_odd j

/-- Every reduced BBP prefix denominator is coprime to the hexadecimal base. -/
theorem bbpPartialSumRat_den_coprime (n : ℕ) :
    (bbpPartialSumRat n).den.Coprime 16 := by
  have h := (Nat.coprime_two_right.mpr (bbpPartialSumRat_den_odd n)).pow_right 4
  norm_num at h
  exact h

/-- Every prime in the reduced prefix denominator is at most the largest odd factor. -/
theorem bbpPartialSumRat_den_prime_le (n p : ℕ) (hp : p.Prime)
    (hpd : p ∣ (bbpPartialSumRat n).den) : p ≤ 8 * n + 5 := by
  obtain ⟨j, hj, hdiv⟩ := (Nat.prime_iff.mp hp).exists_mem_finset_dvd
    (hpd.trans (bbpPartialSumRat_den_dvd n))
  have hjn : j ≤ n := by simpa only [Finset.mem_range, Nat.lt_succ_iff] using hj
  simp only [bbpCoeffCommonDenominator, hp.dvd_mul] at hdiv
  rcases hdiv with ((h | h) | h) | h
  · have := Nat.le_of_dvd (by omega : 0 < 2 * j + 1) h
    omega
  · have := Nat.le_of_dvd (by omega : 0 < 4 * j + 3) h
    omega
  · have := Nat.le_of_dvd (by omega : 0 < 8 * j + 1) h
    omega
  · have := Nat.le_of_dvd (by omega : 0 < 8 * j + 5) h
    omega

end PiDisjunctivity
