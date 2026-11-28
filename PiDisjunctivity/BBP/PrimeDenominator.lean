/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.BBP.RationalPrefix
public import Mathlib.NumberTheory.Padics.PadicVal.Basic
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Tactic

/-!
Exact terminal 17 - power denominator at the actual BBP anchors.
This asserts no complete - period grid, visitation, or normality theorem.
-/

public section
namespace PiDisjunctivity

local instance prime17 : Fact (Nat.Prime 17) := ⟨by norm_num⟩

private theorem val17_add_gtNeg (k : ℕ) (hk : 0 < k) (a b : ℚ)
    (ha : -(k : ℤ) < padicValRat 17 a) (hb : -(k : ℤ) < padicValRat 17 b) :
    -(k : ℤ) < padicValRat 17 (a + b) := by
  by_cases hab : a + b = 0
  · rw [hab, padicValRat.zero]
    omega
  · exact lt_of_lt_of_le (lt_min ha hb) (padicValRat.min_le_padicValRat_add hab)

private theorem val17_sub_gtNeg (k : ℕ) (hk : 0 < k) (a b : ℚ)
    (ha : -(k : ℤ) < padicValRat 17 a) (hb : -(k : ℤ) < padicValRat 17 b) :
    -(k : ℤ) < padicValRat 17 (a - b) := by
  rw [sub_eq_add_neg]
  apply val17_add_gtNeg k hk a (-b) ha
  simpa only [padicValRat.neg] using hb

private theorem val17_nat_div_gtNeg (k a b : ℕ) (hk : 0 < k)
    (hb : 0 < b) (hbk : b < 17 ^ k) :
    -(k : ℤ) < padicValRat 17 ((a : ℚ) / b) := by
  have hm : multiplicity 17 b < k := by
    by_contra h
    have hd : 17 ^ k ∣ b := (multiplicity_dvd_iff_le (p := 17) (by omega : b ≠ 0)).mpr
      (by omega)
    exact (not_le_of_gt hbk) (Nat.le_of_dvd hb hd)
  by_cases ha : a = 0
  · simp only [ha, Nat.cast_zero, zero_div, padicValRat.zero]
    omega
  · rw [padicValRat.div (by exact_mod_cast ha) (by exact_mod_cast (Nat.ne_of_gt hb)),
      padicValRat.of_nat, padicValRat.of_nat]
    omega

private theorem bbpCoeffRat_val17_early (k N j : ℕ) (hk : 0 < k)
    (hN : 8 * N + 1 = 17 ^ k) (hj : j < N) :
    -(k : ℤ) < padicValRat 17 (bbpCoeffRat j) := by
  have hf (a b : ℕ) (hb : 0 < b) (hbk : b < 17 ^ k) :=
    val17_nat_div_gtNeg k a b hk hb hbk
  unfold bbpCoeffRat
  apply val17_sub_gtNeg k hk
  · apply val17_sub_gtNeg k hk
    · apply val17_sub_gtNeg k hk
      · convert hf 4 (8 * j + 1) (by omega) (by omega) using 1; norm_cast
      · convert hf 2 (8 * j + 4) (by omega) (by omega) using 1; norm_cast
    · convert hf 1 (8 * j + 5) (by omega) (by omega) using 1; norm_cast
  · convert hf 1 (8 * j + 6) (by omega) (by omega) using 1; norm_cast


private theorem bbpCoeffRat_val17_terminal (k N : ℕ) (hk : 0 < k)
    (hN : 8 * N + 1 = 17 ^ k) :
    padicValRat 17 (bbpCoeffRat N) = -(k : ℤ) := by
  have hd : 17 ∣ 8 * N + 1 := by
    rw [hN]
    exact dvd_pow_self 17 (Nat.ne_of_gt hk)
  have hmod : N % 17 = 2 := by
    have := Nat.mod_eq_zero_of_dvd hd
    omega
  have hn : ¬17 ∣ 120 * N ^ 2 + 151 * N + 47 := by
    norm_num [Nat.dvd_iff_mod_eq_zero, Nat.add_mod, Nat.mul_mod, Nat.pow_mod, hmod]
  have h2 : multiplicity 17 (2 * N + 1) = 0 := by
    apply multiplicity_eq_zero_of_not_dvd
    norm_num [Nat.dvd_iff_mod_eq_zero, Nat.add_mod, Nat.mul_mod, hmod]
  have h4 : multiplicity 17 (4 * N + 3) = 0 := by
    apply multiplicity_eq_zero_of_not_dvd
    norm_num [Nat.dvd_iff_mod_eq_zero, Nat.add_mod, Nat.mul_mod, hmod]
  have h8 : multiplicity 17 (8 * N + 5) = 0 := by
    apply multiplicity_eq_zero_of_not_dvd
    norm_num [Nat.dvd_iff_mod_eq_zero, Nat.add_mod, Nat.mul_mod, hmod]
  have hden : multiplicity 17 (bbpCoeffCommonDenominator N) = k := by
    unfold bbpCoeffCommonDenominator
    rw [Nat.multiplicity_mul (by positivity) (by positivity),
      Nat.multiplicity_mul (by positivity) (by positivity),
      Nat.multiplicity_mul (by positivity) (by positivity), h2, h4, h8, hN,
      Nat.multiplicity_prime_pow]
    omega
  have heq : bbpCoeffRat N =
      ((120 * N ^ 2 + 151 * N + 47 : ℕ) : ℚ) / (bbpCoeffCommonDenominator N : ℚ) := by
    rw [bbpCoeffRat_eq_positive_fraction]
    norm_num [bbpCoeffCommonDenominator]
  rw [heq, padicValRat.div (by positivity) (by unfold bbpCoeffCommonDenominator; positivity),
    padicValRat.of_nat, padicValRat.of_nat,
    multiplicity_eq_zero_of_not_dvd hn, hden]
  omega


private theorem val17_sum_range_gtNeg (k : ℕ) (hk : 0 < k) (n : ℕ) (f : ℕ → ℚ)
    (hf : ∀ j < n, -(k : ℤ) < padicValRat 17 (f j)) :
    -(k : ℤ) < padicValRat 17 (∑ j ∈ Finset.range n, f j) := by
  induction n with
  | zero =>
      simp only [Finset.range_zero, Finset.sum_empty, padicValRat.zero]
      omega
  | succ n ih =>
      rw [Finset.sum_range_succ]
      exact val17_add_gtNeg k hk _ _
        (ih (fun j hj => hf j (by omega))) (hf n (by omega))

private theorem val17_weighted_coeff (n j : ℕ) :
    padicValRat 17 ((16 : ℚ) ^ (n - j) * bbpCoeffRat j) =
      padicValRat 17 (bbpCoeffRat j) := by
  have h16 : padicValRat 17 (16 : ℚ) = 0 := by
    rw [show (16 : ℚ) = ((16 : ℕ) : ℚ) by norm_num, padicValRat.of_nat,
      multiplicity_eq_zero_of_not_dvd (by norm_num : ¬17 ∣ (16 : ℕ))]
    rfl
  rw [padicValRat.mul (by positivity) (ne_of_gt (bbpCoeffRat_pos j)),
    padicValRat.pow, h16, mul_zero, zero_add]

theorem bbpPartialSumRat_val17 (k N : ℕ) (hk : 0 < k)
    (hN : 8 * N + 1 = 17 ^ k) :
    padicValRat 17 (bbpPartialSumRat N) = -(k : ℤ) := by
  let R : ℚ := ∑ j ∈ Finset.range N, (16 : ℚ) ^ (N - j) * bbpCoeffRat j
  have hR : -(k : ℤ) < padicValRat 17 R := by
    apply val17_sum_range_gtNeg k hk
    intro j hj
    rw [val17_weighted_coeff]
    exact bbpCoeffRat_val17_early k N j hk hN hj
  have ht := bbpCoeffRat_val17_terminal k N hk hN
  have heq : bbpPartialSumRat N = bbpCoeffRat N + R := by
    unfold bbpPartialSumRat
    rw [Finset.sum_range_succ]
    simp only [Nat.sub_self, pow_zero, one_mul]
    exact add_comm _ _
  by_cases hr : R = 0
  · rw [heq, hr, add_zero]
    exact ht
  · have hsum : bbpCoeffRat N + R ≠ 0 := by
      rw [← heq]
      exact ne_of_gt (bbpPartialSumRat_pos N)
    rw [heq, padicValRat.add_eq_of_lt hsum
      (ne_of_gt (bbpCoeffRat_pos N)) hr (by omega)]
    exact ht

theorem bbpPartialSumRat_den_val17 (k N : ℕ) (hk : 0 < k)
    (hN : 8 * N + 1 = 17 ^ k) :
    multiplicity 17 (bbpPartialSumRat N).den = k := by
  have hv := bbpPartialSumRat_val17 k N hk hN
  have hz := Rat.num_or_den_zero_padicVal (bbpPartialSumRat N) (by norm_num : Nat.Prime 17)
  unfold padicValRat at hv
  rcases hz with hn | hd
  · rw [hn] at hv
    omega
  · rw [hd] at hv
    omega


theorem bbpAnchor17_eq (k : ℕ) :
    8 * ((17 ^ k - 1) / 8) + 1 = 17 ^ k := by
  have hm : 17 ^ k % 8 = 1 := by
    norm_num [Nat.pow_mod]
  have hp : 0 < (17 : ℕ) ^ k := by positivity
  have hd := Nat.mod_add_div ((17 : ℕ) ^ k) 8
  omega

theorem bbpPartialSumRat_den_anchor17 (k : ℕ) (hk : 0 < k) :
    multiplicity 17 (bbpPartialSumRat ((17 ^ k - 1) / 8)).den = k := by
  exact bbpPartialSumRat_den_val17 k _ hk (bbpAnchor17_eq k)

end PiDisjunctivity

namespace PiDisjunctivity

/-- Removing the full 17 - primary part of an odd natural leaves a factor prime to 34. -/
private theorem ordCompl17_coprime34 (q : ℕ) (hq2 : q.Coprime 2) :
    (ordCompl[17] q).Coprime 34 := by
  have hq0 : q ≠ 0 := by
    intro hq
    subst q
    norm_num at hq2
  have hM2 : (ordCompl[17] q).Coprime 2 :=
    Nat.Coprime.of_dvd_left (Nat.ordCompl_dvd q 17) hq2
  have hM17 : (ordCompl[17] q).Coprime 17 :=
    (Nat.coprime_ordCompl (by norm_num : Nat.Prime 17) hq0).symm
  simpa only [show 2 * 17 = (34 : ℕ) by norm_num] using hM2.mul_right hM17

/-- The canonical prime - power decomposition, with no restriction on the exponent. -/
private theorem den_decomposition17_of_factorization (q k : ℕ) (hq2 : q.Coprime 2)
    (hfactor : q.factorization 17 = k) :
    ∃ M : ℕ, q = 17 ^ k * M ∧ M.Coprime 34 ∧ 0 < M := by
  have hq0 : q ≠ 0 := by
    intro hq
    subst q
    norm_num at hq2
  refine ⟨ordCompl[17] q, ?_, ordCompl17_coprime34 q hq2,
    Nat.ordCompl_pos 17 hq0⟩
  calc
    q = 17 ^ q.factorization 17 * (ordCompl[17] q) :=
      (Nat.ordProj_mul_ordCompl_eq_self q 17).symm
    _ = 17 ^ k * (ordCompl[17] q) := by rw [hfactor]

/-- The multiplicity interface consumes the terminal - pole valuation directly. -/
private theorem den_decomposition17_of_multiplicity (q k : ℕ) (hq2 : q.Coprime 2)
    (hval : multiplicity 17 q = k) :
    ∃ M : ℕ, q = 17 ^ k * M ∧ M.Coprime 34 ∧ 0 < M := by
  apply den_decomposition17_of_factorization q k hq2
  rw [← Nat.multiplicity_eq_factorization (by norm_num : Nat.Prime 17)]
  exact hval

/-- Actual BBP denominators at a positive terminal 17 - power have the required complement. -/
theorem bbpPartialSumRat_den_decomposition17 (k N : ℕ) (hk : 0 < k)
    (hN : 8 * N + 1 = 17 ^ k) :
    ∃ M : ℕ, (bbpPartialSumRat N).den = 17 ^ k * M ∧ M.Coprime 34 ∧ 0 < M := by
  exact den_decomposition17_of_multiplicity _ k
    (Nat.coprime_two_right.mpr (bbpPartialSumRat_den_odd N))
    (bbpPartialSumRat_den_val17 k N hk hN)

/-- The explicit natural anchor discharges the division identity rather than assuming it. -/
theorem bbpPartialSumRat_den_anchor_decomposition17 (k : ℕ) (hk : 0 < k) :
    ∃ M : ℕ, (bbpPartialSumRat ((17 ^ k - 1) / 8)).den = 17 ^ k * M ∧
      M.Coprime 34 ∧ 0 < M := by
  exact bbpPartialSumRat_den_decomposition17 k _ hk (bbpAnchor17_eq k)

end PiDisjunctivity
