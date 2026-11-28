/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.BBP.DenominatorGrid
import Mathlib.Data.Nat.Log
import Mathlib.Tactic

/-! Actual dyadic anchors retaining a high 17-primary component and complete-period grids. -/
public section
namespace PiDisjunctivity

local instance nearbyPrime17 : Fact (Nat.Prime 17) := ⟨by norm_num⟩

private theorem nearby_not_dvd (k N n a : ℕ) (hk : 0 < k)
    (hhi : 8 * N < 2 * 17 ^ k) (hn : n ≤ N)
    (hlo : 17 ^ k < 8 * n + 1) (ha : a = 1 ∨ a = 4 ∨ a = 5 ∨ a = 6) :
    ¬17 ^ k ∣ 8 * n + a := by
  have hQ : 17 ≤ 17 ^ k := by
    simpa only [pow_one] using pow_le_pow_right₀ (by norm_num : 1 ≤ (17 : ℕ)) hk
  have hmod : 17 ^ k % 8 = 1 := by norm_num [Nat.pow_mod]
  intro hd
  obtain ⟨t, ht⟩ := hd
  have hat : 1 ≤ a ∧ a ≤ 6 := by rcases ha with rfl | rfl | rfl | rfl <;> omega
  have ht2 : t = 2 := by
    have htlo : 1 < t := by nlinarith
    have hthi : t < 3 := by nlinarith
    omega
  rw [ht2] at ht
  have hh := congrArg (fun z : ℕ => z % 8) ht
  norm_num [Nat.add_mod, Nat.mul_mod, hmod] at hh
  rcases ha with rfl | rfl | rfl | rfl <;> omega

private theorem nearby_div_val (k a b : ℕ) (hk : 0 < k) (hb : 0 < b)
    (hnot : ¬17 ^ k ∣ b) : -(k : ℤ) < padicValRat 17 ((a : ℚ) / b) := by
  have hm : multiplicity 17 b < k := by
    by_contra h
    exact hnot ((multiplicity_dvd_iff_le (p := 17) (by omega : b ≠ 0)).mpr (by omega))
  by_cases ha : a = 0
  · simp only [ha, Nat.cast_zero, zero_div, padicValRat.zero]
    omega
  · rw [padicValRat.div (by exact_mod_cast ha) (by exact_mod_cast (Nat.ne_of_gt hb)),
      padicValRat.of_nat, padicValRat.of_nat]
    omega

private theorem nearby_sub_val (k : ℕ) (hk : 0 < k) (a b : ℚ)
    (ha : -(k : ℤ) < padicValRat 17 a) (hb : -(k : ℤ) < padicValRat 17 b) :
    -(k : ℤ) < padicValRat 17 (a - b) := by
  by_cases hz : a - b = 0
  · rw [hz, padicValRat.zero]
    omega
  · rw [sub_eq_add_neg] at hz ⊢
    apply lt_of_lt_of_le (lt_min ha ?_) (padicValRat.min_le_padicValRat_add hz)
    simpa only [padicValRat.neg] using hb

private theorem nearby_coeff_val (k N n : ℕ) (hk : 0 < k)
    (hhi : 8 * N < 2 * 17 ^ k) (hn : n ≤ N) (hlo : 17 ^ k < 8 * n + 1) :
    -(k : ℤ) < padicValRat 17 (bbpCoeffRat n) := by
  have hf (a b : ℕ) (ha : a = 1 ∨ a = 4 ∨ a = 5 ∨ a = 6) :=
    nearby_div_val k b (8 * n + a) hk (by rcases ha with rfl | rfl | rfl | rfl <;> omega)
      (nearby_not_dvd k N n a hk hhi hn hlo ha)
  unfold bbpCoeffRat
  apply nearby_sub_val k hk
  · apply nearby_sub_val k hk
    · apply nearby_sub_val k hk
      · convert hf 1 4 (Or.inl rfl) using 1; norm_cast
      · convert hf 4 2 (Or.inr (Or.inl rfl)) using 1; norm_cast
    · convert hf 5 1 (Or.inr (Or.inr (Or.inl rfl))) using 1; norm_cast
  · convert hf 6 1 (Or.inr (Or.inr (Or.inr rfl))) using 1; norm_cast

private theorem nearby_prefix_succ (n : ℕ) :
    bbpPartialSumRat (n + 1) = 16 * bbpPartialSumRat n + bbpCoeffRat (n + 1) := by
  unfold bbpPartialSumRat
  rw [Finset.sum_range_succ]
  simp only [Nat.sub_self, pow_zero, one_mul]
  rw [Finset.mul_sum]
  congr 1
  apply Finset.sum_congr rfl
  intro j hj
  have hjn : j ≤ n := by simpa only [Finset.mem_range, Nat.lt_succ_iff] using hj
  rw [show n + 1 - j = n - j + 1 by omega, pow_succ]
  ring

/-- The terminal high 17-pole remains unique at every anchor in the indicated bracket. -/
theorem bbpPartialSumRat_val17_nearby (k N : ℕ) (hk : 0 < k)
    (hlo : 17 ^ k ≤ 8 * N) (hhi : 8 * N < 2 * 17 ^ k) :
    padicValRat 17 (bbpPartialSumRat N) = -(k : ℤ) := by
  let n0 := (17 ^ k - 1) / 8
  have hn0 : 8 * n0 + 1 = 17 ^ k := bbpAnchor17_eq k
  have hstart : n0 ≤ N := by omega
  suffices hall : ∀ n, n0 ≤ n → n ≤ N →
      padicValRat 17 (bbpPartialSumRat n) = -(k : ℤ) from hall N hstart le_rfl
  intro n hlow hupper
  induction n, hlow using Nat.le_induction with
  | base => exact bbpPartialSumRat_val17 k n0 hk hn0
  | succ n hn ih =>
    have hp := ih (by omega)
    have hc := nearby_coeff_val k N (n + 1) hk hhi hupper (by omega)
    have h16 : padicValRat 17 (16 : ℚ) = 0 := by
      rw [show (16 : ℚ) = ((16 : ℕ) : ℚ) by norm_num, padicValRat.of_nat,
        multiplicity_eq_zero_of_not_dvd (by norm_num : ¬17 ∣ (16 : ℕ))]
      rfl
    have hs : 16 * bbpPartialSumRat n + bbpCoeffRat (n + 1) ≠ 0 := by
      rw [← nearby_prefix_succ]
      exact ne_of_gt (bbpPartialSumRat_pos (n + 1))
    rw [nearby_prefix_succ]
    rw [padicValRat.add_eq_of_lt hs
      (mul_ne_zero (by norm_num) (ne_of_gt (bbpPartialSumRat_pos n)))
      (ne_of_gt (bbpCoeffRat_pos (n + 1)))]
    · rw [padicValRat.mul (by norm_num) (ne_of_gt (bbpPartialSumRat_pos n)), h16, hp]
      omega
    · rw [padicValRat.mul (by norm_num) (ne_of_gt (bbpPartialSumRat_pos n)), h16, hp]
      omega

/-- The nearby-anchor reduced denominator has the exact high 17-primary valuation. -/
theorem bbpPartialSumRat_den_val17_nearby (k N : ℕ) (hk : 0 < k)
    (hlo : 17 ^ k ≤ 8 * N) (hhi : 8 * N < 2 * 17 ^ k) :
    multiplicity 17 (bbpPartialSumRat N).den = k := by
  have hv := bbpPartialSumRat_val17_nearby k N hk hlo hhi
  have hz := Rat.num_or_den_zero_padicVal (bbpPartialSumRat N) (by norm_num : Nat.Prime 17)
  unfold padicValRat at hv
  rcases hz with hn | hd
  · rw [hn] at hv
    omega
  · rw [hd] at hv
    omega

/-- The nearby denominator decomposes with the complement required by the grid theorem. -/
theorem bbpPartialSumRat_den_decomposition17_nearby (k N : ℕ) (hk : 0 < k)
    (hlo : 17 ^ k ≤ 8 * N) (hhi : 8 * N < 2 * 17 ^ k) :
    ∃ M : ℕ, (bbpPartialSumRat N).den = 17 ^ k * M ∧ M.Coprime 34 ∧ 0 < M := by
  let q := (bbpPartialSumRat N).den
  have hq0 : q ≠ 0 := (Rat.den_pos _).ne'
  have hq2 : q.Coprime 2 := Nat.coprime_two_right.mpr (bbpPartialSumRat_den_odd N)
  have hf : q.factorization 17 = k := by
    rw [Nat.factorization_def _ (by norm_num : Nat.Prime 17)]
    exact bbpPartialSumRat_den_val17_nearby k N hk hlo hhi
  refine ⟨ordCompl[17] q, ?_, ?_, Nat.ordCompl_pos 17 hq0⟩
  · calc
      q = 17 ^ q.factorization 17 * ordCompl[17] q :=
        (Nat.ordProj_mul_ordCompl_eq_self q 17).symm
      _ = 17 ^ k * ordCompl[17] q := by rw [hf]
  · have h2 : (ordCompl[17] q).Coprime 2 :=
      Nat.Coprime.of_dvd_left (Nat.ordCompl_dvd q 17) hq2
    have h17 : (ordCompl[17] q).Coprime 17 :=
      (Nat.coprime_ordCompl (by norm_num : Nat.Prime 17) hq0).symm
    simpa only [show 2 * 17 = (34 : ℕ) by norm_num] using h2.mul_right h17

private theorem nearby_prime_bound (d r N p : ℕ) (hr : 1 < r)
    (hcong : r ≡ 1 [MOD bbpCoverLcm (d + 1)])
    (hhi : 8 * N < 2 * 17 ^ (r + d)) (hp : p.Prime)
    (hpd : p ∣ (bbpPartialSumRat N).den) :
    (p - 1).factorization 17 ≤ r - 1 := by
  apply bbpCover_prime_factorization_le (d + 1) r p (by omega) hr hcong hp
  have hb := bbpPartialSumRat_den_prime_le N p hp hpd
  rw [show r + (d + 1) = (r + d) + 1 by omega, pow_succ]
  omega

private theorem nearby_cast_prefix (N : ℕ) :
    (bbpPartialSumRat N : ℝ) = ((bbpPartialSumRat N).num.natAbs : ℝ) /
      (bbpPartialSumRat N).den := by
  have hnum : 0 ≤ (bbpPartialSumRat N).num := Rat.num_nonneg.mpr (bbpPartialSumRat_pos N).le
  rw [Rat.cast_def]
  congr 1
  have hz := congrArg (fun z : ℤ => (z : ℝ)) (Int.natAbs_of_nonneg hnum)
  simpa only [Int.cast_natCast] using hz.symm

/-- The actual nearby prefix reaches every translate of its fine17 grid. -/
theorem bbpNearby_prefix_grid (d r N j : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hcong : r ≡ 1 [MOD bbpCoverLcm (d + 1)])
    (hlo : 17 ^ (r + d) ≤ 8 * N) (hhi : 8 * N < 2 * 17 ^ (r + d)) :
    ∃ t : ℕ, Int.fract ((16 : ℝ) ^ t * (bbpPartialSumRat N : ℝ)) =
      Int.fract ((bbpPartialSumRat N : ℝ) + j / (17 : ℝ) ^ d) := by
  obtain ⟨M, hq, hM, _⟩ := bbpPartialSumRat_den_decomposition17_nearby
    (r + d) N (by omega) hlo hhi
  have hb (p : ℕ) (hp : p.Prime) (hpd : p ∣ M) :
      (p - 1).factorization 17 ≤ r - 1 := by
    apply nearby_prime_bound d r N p hr hcong hhi hp
    rw [hq]
    exact hpd.trans (dvd_mul_left M (17 ^ (r + d)))
  have ha17 : (bbpPartialSumRat N).num.natAbs.Coprime 17 := by
    apply Nat.Coprime.of_dvd_right _ (bbpPartialSumRat N).reduced
    rw [hq]
    exact (dvd_pow_self 17 (by omega : r + d ≠ 0)).trans (dvd_mul_right _ M)
  rw [nearby_cast_prefix N, hq]
  simpa only [Nat.add_comm r d, Nat.cast_mul, Nat.cast_pow, Nat.cast_ofNat] using
    PrimeGrid17.rationalGrid17 M r d (bbpPartialSumRat N).num.natAbs j hM (by omega) hb ha17

/-- Every nearby-prefix grid translate has a witness inside one complete period. -/
theorem bbpNearby_prefix_grid_in_period (d r N j : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hcong : r ≡ 1 [MOD bbpCoverLcm (d + 1)])
    (hlo : 17 ^ (r + d) ≤ 8 * N) (hhi : 8 * N < 2 * 17 ^ (r + d)) :
    ∃ t < orderOf (16 : ZMod (bbpPartialSumRat N).den),
      Int.fract ((16 : ℝ) ^ t * (bbpPartialSumRat N : ℝ)) =
        Int.fract ((bbpPartialSumRat N : ℝ) + j / (17 : ℝ) ^ d) := by
  obtain ⟨t, ht⟩ := bbpNearby_prefix_grid d r N j hd hr hcong hlo hhi
  refine ⟨t % orderOf (16 : ZMod (bbpPartialSumRat N).den),
    Nat.mod_lt _ (bbpPartialSumRat_period_pos N), ?_⟩
  calc
    Int.fract ((16 : ℝ) ^ (t % orderOf (16 : ZMod (bbpPartialSumRat N).den)) *
        (bbpPartialSumRat N : ℝ)) =
        Int.fract ((16 : ℝ) ^ t * (bbpPartialSumRat N : ℝ)) := by
      rw [nearby_cast_prefix N]
      exact RationalHexOrbit.orbitPoint_mod_period (bbpPartialSumRat N).num.natAbs
        (bbpPartialSumRat N).den t (Rat.den_pos _)
    _ = _ := ht

/-- Nearby actual prefixes inherit the strict complete-period discrepancy bound. -/
theorem bbpNearby_prefix_discrepancy (d r N : ℕ) (hd : 0 < d) (hr : 1 < r)
    (hcong : r ≡ 1 [MOD bbpCoverLcm (d + 1)])
    (hlo : 17 ^ (r + d) ≤ 8 * N) (hhi : 8 * N < 2 * 17 ^ (r + d))
    (u v : ℝ) (hu : 0 ≤ u) (huv : u ≤ v) (hv : v ≤ 1) :
    |(hexadecimalPrefixIcoCount (bbpPartialSumRat N : ℝ)
        (orderOf (16 : ZMod (bbpPartialSumRat N).den)) u v : ℝ) /
      (orderOf (16 : ZMod (bbpPartialSumRat N).den) : ℝ) - (v - u)| <
      1 / (17 : ℝ) ^ d := by
  obtain ⟨M, hq, hM, _⟩ := bbpPartialSumRat_den_decomposition17_nearby
    (r + d) N (by omega) hlo hhi
  have hb (p : ℕ) (hp : p.Prime) (hpd : p ∣ M) :
      (p - 1).factorization 17 ≤ r - 1 := by
    apply nearby_prime_bound d r N p hr hcong hhi hp
    rw [hq]
    exact hpd.trans (dvd_mul_left M (17 ^ (r + d)))
  have ha := (bbpPartialSumRat N).reduced
  rw [hq, Nat.add_comm r d] at ha
  have h := (RationalHexOrbit.rational_period_grid_contract M r d
    (bbpPartialSumRat N).num.natAbs hM (by omega) hb ha u v hu huv hv).2
  have hq' : (bbpPartialSumRat N).den = 17 ^ (d + r) * M := by
    simpa only [Nat.add_comm r d] using hq
  rw [nearby_cast_prefix N, hq']
  simpa only [hexadecimalPrefixIcoCount] using h

/-- A dyadic anchor always lies in the required nearby-pole bracket. -/
theorem exists_dyadic_nearby_anchor (k : ℕ) (hk : 0 < k) :
    ∃ s : ℕ, 17 ^ k ≤ 8 * 2 ^ s ∧ 8 * 2 ^ s < 2 * 17 ^ k := by
  let c := Nat.clog 2 (17 ^ k)
  have hQ : 17 ≤ 17 ^ k := by
    simpa only [pow_one] using pow_le_pow_right₀ (by norm_num : 1 ≤ (17 : ℕ)) hk
  have hc : 3 < c := (Nat.lt_clog_iff_pow_lt (by norm_num : 1 < (2 : ℕ))).mpr (by norm_num; omega)
  have hlo : 17 ^ k ≤ 2 ^ c := Nat.le_pow_clog (by norm_num) _
  have hpred : 2 ^ (c - 1) < 17 ^ k := Nat.pow_pred_clog_lt_self 2 (by omega)
  have heq : 8 * 2 ^ (c - 3) = 2 ^ c := by
    conv_rhs => rw [show c = (c - 3) + 3 by omega, pow_add]
    norm_num
    omega
  refine ⟨c - 3, ?_, ?_⟩
  · rw [heq]
    exact hlo
  · rw [heq, show c = (c - 1) + 1 by omega, pow_succ]
    omega

/-- Arbitrarily large dyadic exponents satisfy the enlarged sieve and nearby bracket. -/
theorem bbpNearby_exists_dyadic_anchor (d B : ℕ) (hd : 0 < d) :
    ∃ s r : ℕ, B < s ∧ 1 < r ∧ r ≡ 1 [MOD bbpCoverLcm (d + 1)] ∧
      17 ^ (r + d) ≤ 8 * 2 ^ s ∧ 8 * 2 ^ s < 2 * 17 ^ (r + d) := by
  obtain ⟨r, hrB, hr, hcong⟩ := bbpCover_admissible_exponent_gt (d + 1) (2 ^ (B + 3))
  obtain ⟨s, hlo, hhi⟩ := exists_dyadic_nearby_anchor (r + d) (by omega)
  refine ⟨s, r, ?_, hr, hcong, hlo, hhi⟩
  have hQ : r + d < 17 ^ (r + d) := Nat.lt_pow_self (by norm_num)
  by_contra hnot
  have hs : s ≤ B := by omega
  have hpow : 2 ^ s ≤ 2 ^ B := pow_le_pow_right₀ (by norm_num) hs
  have hexp : 2 ^ (B + 3) = 8 * 2 ^ B := by rw [pow_add]; norm_num; omega
  rw [hexp] at hrB
  omega

/-- Fine actual-prefix grids occur at arbitrarily large dyadic exponents. -/
theorem bbpNearby_arbitrarily_large_dyadic_grids (d B : ℕ) (hd : 0 < d) :
    ∃ s : ℕ, B < s ∧ ∀ j : ℕ, ∃ t : ℕ,
      Int.fract ((16 : ℝ) ^ t * (bbpPartialSumRat (2 ^ s) : ℝ)) =
        Int.fract ((bbpPartialSumRat (2 ^ s) : ℝ) + j / (17 : ℝ) ^ d) := by
  obtain ⟨s, r, hs, hr, hcong, hlo, hhi⟩ := bbpNearby_exists_dyadic_anchor d B hd
  exact ⟨s, hs, fun j => bbpNearby_prefix_grid d r (2 ^ s) j hd hr hcong hlo hhi⟩

/-- At arbitrarily large dyadic exponents, the actual prefix has complete-period discrepancy. -/
theorem bbpNearby_arbitrarily_large_dyadic_discrepancy (d B : ℕ) (hd : 0 < d) :
    ∃ s : ℕ, B < s ∧ ∀ u v : ℝ, 0 ≤ u → u ≤ v → v ≤ 1 →
      |(hexadecimalPrefixIcoCount (bbpPartialSumRat (2 ^ s) : ℝ)
          (orderOf (16 : ZMod (bbpPartialSumRat (2 ^ s)).den)) u v : ℝ) /
        (orderOf (16 : ZMod (bbpPartialSumRat (2 ^ s)).den) : ℝ) - (v - u)| <
        1 / (17 : ℝ) ^ d := by
  obtain ⟨s, r, hs, hr, hcong, hlo, hhi⟩ := bbpNearby_exists_dyadic_anchor d B hd
  exact ⟨s, hs, fun u v hu huv hv =>
    bbpNearby_prefix_discrepancy d r (2 ^ s) hd hr hcong hlo hhi u v hu huv hv⟩

/-- Every fixed finite word occurs in complete periods at arbitrarily large dyadic anchors. -/
theorem bbpNearby_arbitrarily_large_dyadic_words (w B : ℕ) :
    ∃ s : ℕ, B < s ∧ ∀ word : Fin w → Fin 16,
      ∃ t < orderOf (16 : ZMod (bbpPartialSumRat (2 ^ s)).den),
        ∀ i : Fin w, baseDigit 16 (bbpPartialSumRat (2 ^ s) : ℝ)
          (t + i.val) = (word i).val := by
  obtain ⟨s, hs, hdisc⟩ := bbpNearby_arbitrarily_large_dyadic_discrepancy (w + 1) B (by omega)
  refine ⟨s, hs, fun word => ?_⟩
  apply word_occurs_before_of_grid17_discrepancy _ _ _
    (bbpPartialSumRat_period_pos _) w _ word
  · exact_mod_cast (bbpPartialSumRat_pos (2 ^ s)).le
  · intro u v hu huv hv
    exact (hdisc u v hu huv.le hv).le

end PiDisjunctivity
