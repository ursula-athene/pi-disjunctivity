/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.BBP.EulerCover
public import PiDisjunctivity.PrimeGrid17
public import PiDisjunctivity.RationalHexOrbit
public import PiDisjunctivity.RationalGridDiscrepancy
public import PiDisjunctivity.FiniteWordDiscrepancy
import Mathlib.Tactic

/-! Grid translations in rational hexadecimal orbits at actual BBP denominator anchors. -/

public section
namespace PiDisjunctivity

private theorem cast_prefix_eq_natAbs (n : ℕ) :
    (bbpPartialSumRat n : ℝ) = ((bbpPartialSumRat n).num.natAbs : ℝ) /
      (bbpPartialSumRat n).den := by
  have hnum : 0 ≤ (bbpPartialSumRat n).num :=
    Rat.num_nonneg.mpr (bbpPartialSumRat_pos n).le
  rw [Rat.cast_def]
  congr 1
  have hz := congrArg (fun z : ℤ => (z : ℝ)) (Int.natAbs_of_nonneg hnum)
  simpa only [Int.cast_natCast] using hz.symm


/-- Every unit numerator at an admissible actual denominator reaches every grid translate. -/
theorem bbpCover_den_grid (d r a j : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hcong : r ≡ 1 [MOD bbpCoverLcm d])
    (ha : a.Coprime (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den) :
    ∃ t : ℕ,
      Int.fract ((16 : ℝ) ^ t * ((a : ℝ) /
        (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den)) =
      Int.fract ((a : ℝ) / (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den +
        j / (17 : ℝ) ^ d) := by
  obtain ⟨M, hq, hM, _⟩ := bbpPartialSumRat_den_anchor_decomposition17 (r + d) (by omega)
  have hb (p : ℕ) (hp : p.Prime) (hpd : p ∣ M) :
      (p - 1).factorization 17 ≤ r - 1 := by
    apply bbpCover_prefix_prime_factorization_le d r p hd hr hcong hp
    rw [hq]
    exact hpd.trans (dvd_mul_left M (17 ^ (r + d)))
  have ha17 : a.Coprime 17 := by
    apply Nat.Coprime.of_dvd_right _ ha
    rw [hq]
    exact (dvd_pow_self 17 (by omega : r + d ≠ 0)).trans (dvd_mul_right _ M)
  have h := PrimeGrid17.rationalGrid17 M r d a j hM (by omega) hb ha17
  rw [hq]
  simpa only [Nat.cast_mul, Nat.cast_pow, Nat.cast_ofNat, Nat.add_comm r d] using h

/-- The same grid is reached from the actual positive rational BBP prefix. -/
theorem bbpCover_prefix_grid (d r j : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hcong : r ≡ 1 [MOD bbpCoverLcm d]) :
    ∃ t : ℕ, Int.fract ((16 : ℝ) ^ t *
        (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8) : ℝ)) =
      Int.fract ((bbpPartialSumRat ((17 ^ (r + d) - 1) / 8) : ℝ) + j / (17 : ℝ) ^ d) := by
  let S := bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)
  have heq : (S : ℝ) = (S.num.natAbs : ℝ) / S.den := cast_prefix_eq_natAbs _
  rw [show (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8) : ℝ) = (S : ℝ) from rfl, heq]
  exact bbpCover_den_grid d r S.num.natAbs j hd hr hcong S.reduced


theorem bbpPartialSumRat_period_pos (n : ℕ) :
    0 < orderOf (16 : ZMod (bbpPartialSumRat n).den) :=
  RationalHexOrbit.period_pos _ (bbpPartialSumRat_den_coprime n).symm

theorem bbpCover_den_grid_in_period (d r a j : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hcong : r ≡ 1 [MOD bbpCoverLcm d])
    (ha : a.Coprime (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den) :
    ∃ t < orderOf (16 : ZMod (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den),
      Int.fract ((16 : ℝ) ^ t * ((a : ℝ) /
        (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den)) =
      Int.fract ((a : ℝ) / (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den +
        j / (17 : ℝ) ^ d) := by
  obtain ⟨t, ht⟩ := bbpCover_den_grid d r a j hd hr hcong ha
  let q := (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den
  refine ⟨t % orderOf (16 : ZMod q), Nat.mod_lt _ (bbpPartialSumRat_period_pos _), ?_⟩
  exact (RationalHexOrbit.orbitPoint_mod_period a q t (Rat.den_pos _)).trans ht

theorem bbpCover_prefix_grid_in_period (d r j : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hcong : r ≡ 1 [MOD bbpCoverLcm d]) :
    ∃ t < orderOf (16 : ZMod (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den),
      Int.fract ((16 : ℝ) ^ t * (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8) : ℝ)) =
      Int.fract ((bbpPartialSumRat ((17 ^ (r + d) - 1) / 8) : ℝ) + j / (17 : ℝ) ^ d) := by
  let S := bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)
  have heq : (S : ℝ) = (S.num.natAbs : ℝ) / S.den := cast_prefix_eq_natAbs _
  rw [show (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8) : ℝ) = (S : ℝ) from rfl, heq]
  exact bbpCover_den_grid_in_period d r S.num.natAbs j hd hr hcong S.reduced



theorem bbpCover_den_discrepancy (d r a : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hcong : r ≡ 1 [MOD bbpCoverLcm d])
    (ha : a.Coprime (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den)
    (u v : ℝ) (hu : 0 ≤ u) (huv : u ≤ v) (hv : v ≤ 1) :
    |(hexadecimalPrefixIcoCount
        ((a : ℝ) / (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den)
        (orderOf (16 : ZMod (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den)) u v : ℝ) /
      (orderOf (16 : ZMod (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den) : ℝ) - (v - u)| <
      1 / (17 : ℝ) ^ d := by
  obtain ⟨M, hq, hM, _⟩ := bbpPartialSumRat_den_anchor_decomposition17 (r + d) (by omega)
  have hb (p : ℕ) (hp : p.Prime) (hpd : p ∣ M) :
      (p - 1).factorization 17 ≤ r - 1 := by
    apply bbpCover_prefix_prime_factorization_le d r p hd hr hcong hp
    rw [hq]
    exact hpd.trans (dvd_mul_left M (17 ^ (r + d)))
  rw [hq, Nat.add_comm r d] at ha ⊢
  have h := (RationalHexOrbit.rational_period_grid_contract M r d a hM (by omega)
    hb ha u v hu huv hv).2
  simpa only [hexadecimalPrefixIcoCount] using h

theorem bbpCover_prefix_discrepancy (d r : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hcong : r ≡ 1 [MOD bbpCoverLcm d])
    (u v : ℝ) (hu : 0 ≤ u) (huv : u ≤ v) (hv : v ≤ 1) :
    |(hexadecimalPrefixIcoCount (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8) : ℝ)
        (orderOf (16 : ZMod (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den)) u v : ℝ) /
      (orderOf (16 : ZMod (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)).den) : ℝ) - (v - u)| <
      1 / (17 : ℝ) ^ d := by
  let S := bbpPartialSumRat ((17 ^ (r + d) - 1) / 8)
  have heq : (S : ℝ) = (S.num.natAbs : ℝ) / S.den := cast_prefix_eq_natAbs _
  rw [show (bbpPartialSumRat ((17 ^ (r + d) - 1) / 8) : ℝ) = (S : ℝ) from rfl, heq]
  exact bbpCover_den_discrepancy d r S.num.natAbs hd hr hcong S.reduced u v hu huv hv

theorem bbpCover_prefix_words (w r : ℕ) (hr : 1 < r)
    (hcong : r ≡ 1 [MOD bbpCoverLcm (w + 1)]) (s : Fin w → Fin 16) :
    ∃ t < orderOf (16 : ZMod (bbpPartialSumRat ((17 ^ (r + (w + 1)) - 1) / 8)).den),
      ∀ i : Fin w, baseDigit 16 (bbpPartialSumRat ((17 ^ (r + (w + 1)) - 1) / 8) : ℝ)
        (t + i.val) = (s i).val := by
  apply word_occurs_before_of_grid17_discrepancy _ _ _ (bbpPartialSumRat_period_pos _) w _ s
  · exact_mod_cast (bbpPartialSumRat_pos ((17 ^ (r + (w + 1)) - 1) / 8)).le
  · intro u v hu huv hv
    exact (bbpCover_prefix_discrepancy (w + 1) r (by omega) hr hcong u v hu huv.le hv).le

theorem bbpCover_arbitrarily_large_prefix_words (w B : ℕ) :
    ∃ N : ℕ, B < N ∧ ∀ s : Fin w → Fin 16,
      ∃ t < orderOf (16 : ZMod (bbpPartialSumRat N).den),
        ∀ i : Fin w, baseDigit 16 (bbpPartialSumRat N : ℝ) (t + i.val) = (s i).val := by
  obtain ⟨r, hr, hcong, hB⟩ := bbpCover_admissible_anchor_gt (w + 1) B
  exact ⟨(17 ^ (r + (w + 1)) - 1) / 8, hB, fun s => bbpCover_prefix_words w r hr hcong s⟩

theorem bbpCover_infinitely_many_prefix_words (w : ℕ) :
    Set.Infinite {N : ℕ | ∀ s : Fin w → Fin 16,
      ∃ t < orderOf (16 : ZMod (bbpPartialSumRat N).den),
        ∀ i : Fin w, baseDigit 16 (bbpPartialSumRat N : ℝ) (t + i.val) = (s i).val} := by
  apply Set.infinite_of_forall_exists_gt
  intro B
  obtain ⟨N, hB, hN⟩ := bbpCover_arbitrarily_large_prefix_words w B
  exact ⟨N, hN, hB⟩


end PiDisjunctivity
