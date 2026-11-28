/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module
public import PiDisjunctivity.BBP.PrimeDenominator
public import Mathlib.FieldTheory.Finite.Basic
public import Mathlib.Algebra.GCDMonoid.FinsetLemmas
import Mathlib.Tactic

/-! Elementary Euler covering excludes large 17 - parts in prime - order exponents. -/

public section
namespace PiDisjunctivity

/-- The even coefficients used in the elementary 17 - adic Euler covering. -/
@[expose] def bbpCoverIndices (d : ℕ) : Finset ℕ :=
  (Finset.Icc 2 (17 ^ d - 1)).filter Even

/-- The finite least common multiple from the reviewed elementary grid construction. -/
@[expose] def bbpCoverLcm (d : ℕ) : ℕ :=
  (bbpCoverIndices d).lcm (fun a => (17 * a + 1).totient)

theorem bbpCoverLcm_pos (d : ℕ) : 0 < bbpCoverLcm d := by
  apply Nat.pos_of_ne_zero
  rw [bbpCoverLcm, Finset.lcm_ne_zero_iff]
  intro a _
  exact (Nat.totient_pos.mpr (by omega : 0 < 17 * a + 1)).ne'

private theorem bbpCoverLcm_totient_dvd (d a : ℕ) (ha : a ∈ bbpCoverIndices d) :
    (17 * a + 1).totient ∣ bbpCoverLcm d := by
  exact Finset.dvd_lcm ha

private theorem bbpEulerCover (a t : ℕ) :
    17 ^ (1 + (17 * a + 1).totient * t) ≡ 17 [MOD 17 * a + 1] := by
  have hc : Nat.Coprime 17 (17 * a + 1) := by
    exact (Nat.coprime_mul_left_add_right 17 1 a).mpr (Nat.coprime_one_right 17)
  have h := (Nat.ModEq.pow_totient hc).pow t
  simpa only [pow_one, one_pow, pow_mul, pow_add, mul_one] using
    (Nat.ModEq.refl 17).mul h

theorem bbpCover_prime_exclusion (d r ell : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hcong : r ≡ 1 [MOD bbpCoverLcm d]) (hp : ell.Prime)
    (hle : ell ≤ 17 ^ (r + d) + 5) : ¬17 ^ r ∣ ell - 1 := by
  intro hdiv
  have hpr : 17 < (17 : ℕ) ^ r := by
    simpa only [pow_one] using pow_lt_pow_right₀ (by norm_num : (1 : ℕ) < 17) hr
  have hell1 := hp.one_lt
  have hell2 : ell ≠ 2 := by
    intro he
    have := Nat.le_of_dvd (by omega : 0 < ell - 1) hdiv
    omega
  have hellodd : ell % 2 = 1 := hp.eq_two_or_odd.resolve_left hell2
  obtain ⟨a, ha⟩ := hdiv
  have heq : ell = 17 ^ r * a + 1 := by omega
  have hprmod : (17 : ℕ) ^ r % 2 = 1 := by norm_num [Nat.pow_mod]
  have hamod : a % 2 = 0 := by
    have h := congrArg (fun n : ℕ => n % 2) heq
    rw [Nat.add_mod, Nat.mul_mod, hprmod] at h
    norm_num at h
    omega
  have ha0 : 0 < a := by
    by_contra h
    have : a = 0 := by omega
    simp only [this, mul_zero, zero_add] at heq
    omega
  have ha2 : 2 ≤ a := by omega
  have hapow : a ≤ 17 ^ d := by
    by_contra h
    have hm := Nat.mul_le_mul_left (17 ^ r) (show 17 ^ d + 1 ≤ a by omega)
    rw [pow_add] at hle
    nlinarith
  have hdmod : (17 : ℕ) ^ d % 2 = 1 :=
    Nat.odd_iff.mp ((Nat.odd_pow_iff (Nat.ne_of_gt hd)).mpr (by norm_num))
  have halt : a < 17 ^ d := by omega
  have hamem : a ∈ bbpCoverIndices d := by
    simp only [bbpCoverIndices, Finset.mem_filter, Finset.mem_Icc]
    exact ⟨⟨ha2, by omega⟩, Nat.even_iff.mpr hamod⟩
  have htdiv : (17 * a + 1).totient ∣ r - 1 :=
    (bbpCoverLcm_totient_dvd d a hamem).trans hcong.symm.dvd'
  obtain ⟨t, ht⟩ := htdiv
  have hrt : r = 1 + (17 * a + 1).totient * t := by omega
  have hpow : 17 ^ r ≡ 17 [MOD 17 * a + 1] := by
    rw [hrt]
    exact bbpEulerCover a t
  have hmod : ell ≡ 17 * a + 1 [MOD 17 * a + 1] := by
    rw [heq]
    exact (hpow.mul_right a).add_right 1
  have hsmall : 17 * a + 1 ∣ ell :=
    (hmod.dvd_iff (dvd_refl (17 * a + 1))).mpr (dvd_refl _)
  have hproper : 17 * a + 1 < ell := by nlinarith
  rcases (Nat.dvd_prime hp).mp hsmall with hone | hfull
  · omega
  · omega


/-- Factorization form of the exclusion, ready for the Carmichael bound. -/
theorem bbpCover_prime_factorization_le (d r ell : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hcong : r ≡ 1 [MOD bbpCoverLcm d]) (hp : ell.Prime)
    (hle : ell ≤ 17 ^ (r + d) + 5) : (ell - 1).factorization 17 ≤ r - 1 := by
  have hnot := bbpCover_prime_exclusion d r ell hd hr hcong hp hle
  have hell1 := hp.one_lt
  have hlt : (ell - 1).factorization 17 < r := by
    by_contra h
    apply hnot
    exact (Nat.Prime.pow_dvd_iff_le_factorization
      (by norm_num : Nat.Prime 17) (by omega : ell - 1 ≠ 0)).mpr (by omega)
  omega

/-- Admissible Euler - cover exponents exceed every prescribed natural bound. -/
theorem bbpCover_admissible_exponent_gt (d B : ℕ) :
    ∃ r : ℕ, B < r ∧ 1 < r ∧ r ≡ 1 [MOD bbpCoverLcm d] := by
  have hL := bbpCoverLcm_pos d
  refine ⟨1 + bbpCoverLcm d * (B + 2), ?_, ?_, ?_⟩
  · nlinarith
  · nlinarith
  · simpa only [add_zero] using
      (Nat.ModEq.refl 1).add (dvd_mul_right (bbpCoverLcm d) (B + 2)).modEq_zero_nat

/-- Every prime in the actual anchor prefix has the required order - exponent bound. -/
theorem bbpCover_prefix_prime_factorization_le (d r ell : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hcong : r ≡ 1 [MOD bbpCoverLcm d]) (hp : ell.Prime)
    (hdiv : ell ∣ (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den) :
    (ell - 1).factorization 17 ≤ r - 1 := by
  have hle := bbpPartialSumRat_den_prime_le ((17 ^ (r + d) - 1) / 8) ell hp hdiv
  have heq := bbpAnchor17_eq (r + d)
  exact bbpCover_prime_factorization_le d r ell hd hr hcong hp (by omega)

/-- The anchors associated to admissible exponents exceed every natural bound. -/
theorem bbpCover_admissible_anchor_gt (d B : ℕ) :
    ∃ r : ℕ, 1 < r ∧ r ≡ 1 [MOD bbpCoverLcm d] ∧ B < (17 ^ (r + d) - 1) / 8 := by
  obtain ⟨r, hrB, hr, hcong⟩ := bbpCover_admissible_exponent_gt d (8 * (B + 1) + 1)
  refine ⟨r, hr, hcong, ?_⟩
  have hp : r + d < (17 : ℕ) ^ (r + d) := Nat.lt_pow_self (by norm_num)
  have heq := bbpAnchor17_eq (r + d)
  omega

end PiDisjunctivity
