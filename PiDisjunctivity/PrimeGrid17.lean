/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import Mathlib.Algebra.Order.Archimedean.Real.Basic
public import Mathlib.FieldTheory.Finite.Basic
public import Mathlib.NumberTheory.Multiplicity
public import Mathlib.RingTheory.ZMod.UnitsCyclic
public import Mathlib.Algebra.GCDMonoid.FinsetLemmas
public import Mathlib.NumberTheory.ArithmeticFunction.Carmichael

import Mathlib.Tactic

/-! Rational hexadecimal orbits containing every translate of a fine 17-power grid. -/

public section

namespace PiDisjunctivity.PrimeGrid17

private theorem principalOrder17 (r d : ℕ) (hr : 1 ≤ r) (a : ℤ) (ha : ¬ (17 : ℤ) ∣ a) :
    orderOf (1 + (17 : ZMod (17 ^ (d + r))) ^ r * a) = 17 ^ d := by
  exact ZMod.orderOf_one_add_mul_prime_pow (p := 17) (by norm_num) r (by omega) a ha d

private theorem cyclicPower {G : Type*} [Group G] [Finite G] [IsCyclic G]
    (x y : G) (h : orderOf y ∣ orderOf x) : ∃ k : ℕ, x ^ k = y := by
  classical
  have hle : Subgroup.zpowers y ≤ Subgroup.zpowers x :=
    IsCyclic.subgroup_le_iff_card_dvd.mpr (by simpa only [Nat.card_zpowers] using h)
  have hy : y ∈ Subgroup.zpowers x := hle (Subgroup.mem_zpowers y)
  obtain ⟨k, _, hk⟩ := Finset.mem_image.mp (mem_zpowers_iff_mem_range_orderOf.mp hy)
  exact ⟨k, hk⟩


private theorem lcmValBound {ι : Type*} (s : Finset ι) (f : ι → ℕ) (b : ℕ)
    (hf : ∀ i ∈ s, f i ≠ 0) (hb : ∀ i ∈ s, (f i).factorization 17 ≤ b) :
    (s.lcm f).factorization 17 ≤ b := by
  rw [Finset.factorization_lcm hf]
  exact Finset.sup_le hb

private theorem fractOfModEq (a b q : ℕ) (h : a ≡ b [MOD q]) :
    Int.fract ((a : ℝ) / q) = Int.fract ((b : ℝ) / q) := by
  rw [Int.fract_div_natCast_eq_div_natCast_mod,
    Int.fract_div_natCast_eq_div_natCast_mod, h]

private theorem principalPow17 (r d : ℕ) (hr : 1 ≤ r) (a : ℤ) :
    (1 + (17 : ZMod (17 ^ (d + r))) ^ r * a) ^ (17 ^ d) = 1 := by
  obtain ⟨y, hy⟩ := ZMod.exists_one_add_mul_pow_prime_pow_eq
    (R := ZMod (17 ^ (d + r))) (p := 17) (u := 17 ^ r) (v := 17)
    (by norm_num) (dvd_pow_self _ (by omega))
    (by
      norm_num only [Nat.cast_ofNat]
      rw [← pow_succ', ← pow_succ, ← pow_mul, mul_comm]
      exact pow_dvd_pow _ (by omega)) (a : ZMod (17 ^ (d + r))) d
  have hz : (17 : ZMod (17 ^ (d + r))) ^ (d + r) = 0 := by
    simpa only [Nat.cast_pow, Nat.cast_ofNat] using ZMod.natCast_self (17 ^ (d + r))
  norm_num only [Nat.cast_pow, Nat.cast_ofNat] at hy
  simpa only [← pow_add, hz, zero_mul, add_zero] using hy


private theorem principalReach17 (r d : ℕ) (hr : 1 ≤ r) (c a : ℤ)
    (hc : ¬ (17 : ℤ) ∣ c) :
    ∃ t : ℕ, (1 + (17 : ZMod (17 ^ (d + r))) ^ r * c) ^ t =
      1 + (17 : ZMod (17 ^ (d + r))) ^ r * a := by
  let : NeZero (17 ^ (d + r)) := ⟨by positivity⟩
  let : IsCyclic (ZMod (17 ^ (d + r)))ˣ :=
    ZMod.isCyclic_units_of_prime_pow 17 (by norm_num) (by norm_num) (d + r)
  have hx := IsUnit.of_pow_eq_one (principalPow17 r d hr c) (by positivity : 17 ^ d ≠ 0)
  have hy := IsUnit.of_pow_eq_one (principalPow17 r d hr a) (by positivity : 17 ^ d ≠ 0)
  have hox : orderOf hx.unit = 17 ^ d := by
    rw [← orderOf_units, hx.unit_spec]
    exact principalOrder17 r d hr c hc
  have hoy : orderOf hy.unit ∣ 17 ^ d := by
    rw [← orderOf_units, hy.unit_spec]
    exact orderOf_dvd_of_pow_eq_one (principalPow17 r d hr a)
  obtain ⟨t, ht⟩ := cyclicPower hx.unit hy.unit (hox.symm ▸ hoy)
  refine ⟨t, ?_⟩
  have h := congrArg (fun u : (ZMod (17 ^ (d + r)))ˣ => (u : ZMod (17 ^ (d + r)))) ht
  simpa only [Units.val_pow_eq_pow_val, hx.unit_spec, hy.unit_spec] using h


private theorem totientVal17 (p e : ℕ) (hp : p.Prime) (hne : p ≠ 17) :
    ((p ^ (e + 1)).totient).factorization 17 = (p - 1).factorization 17 := by
  rw [Nat.totient_prime_pow_succ hp,
    Nat.factorization_mul (pow_ne_zero e hp.ne_zero) (Nat.sub_ne_zero_of_lt hp.one_lt),
    Finsupp.add_apply, hp.factorization_pow]
  simp only [Finsupp.single_apply, hne, ↓reduceIte, zero_add]


private theorem carmichaelVal17 (M b : ℕ) (hM : M.Coprime 34)
    (hb : ∀ p : ℕ, p.Prime → p ∣ M → (p - 1).factorization 17 ≤ b) :
    (ArithmeticFunction.carmichael M).factorization 17 ≤ b := by
  have hM0 : M ≠ 0 := by
    rintro rfl
    norm_num at hM
  let : NeZero M := ⟨hM0⟩
  have hpr (p : ℕ) (hp_mem : p ∈ M.primeFactors) :
      p.Prime ∧ p ∣ M ∧ p ≠ 2 ∧ p ≠ 17 := by
    obtain ⟨hp, hpd, _⟩ := Nat.mem_primeFactors.mp hp_mem
    have hc := Nat.Coprime.of_dvd_left hpd hM
    refine ⟨hp, hpd, ?_, ?_⟩
    · intro h
      norm_num [h] at hc
    · intro h
      norm_num [h] at hc
  rw [ArithmeticFunction.carmichael_factorization]
  apply lcmValBound
  · intro p hp_mem
    obtain ⟨hp, _, hp2, _⟩ := hpr p hp_mem
    rw [ArithmeticFunction.carmichael_pow_of_prime_ne_two _ hp hp2]
    exact (Nat.totient_pos.mpr (pow_pos hp.pos _)).ne'
  · intro p hp_mem
    obtain ⟨hp, hpd, hp2, hp17⟩ := hpr p hp_mem
    rw [ArithmeticFunction.carmichael_pow_of_prime_ne_two _ hp hp2]
    have he : M.factorization p ≠ 0 := (hp.factorization_pos_of_dvd hM0 hpd).ne'
    obtain ⟨e, he⟩ := Nat.exists_eq_succ_of_ne_zero he
    rw [he, totientVal17 p e hp hp17]
    exact hb p hp hpd


private theorem selectedExponentVal17 (M b : ℕ) (hM : M.Coprime 34)
    (hb : ∀ p : ℕ, p.Prime → p ∣ M → (p - 1).factorization 17 ≤ b) :
    (Nat.lcm (ArithmeticFunction.carmichael M) (2 * 17 ^ b)).factorization 17 = b := by
  have hM0 : M ≠ 0 := by
    rintro rfl
    norm_num at hM
  have hcarm0 : ArithmeticFunction.carmichael M ≠ 0 :=
    ne_zero_of_dvd_ne_zero (Nat.totient_pos.mpr (Nat.pos_of_ne_zero hM0)).ne'
      (ArithmeticFunction.carmichael_dvd_totient M)
  have h17 : (2 * 17 ^ b).factorization 17 = b := by
    rw [Nat.factorization_mul (by norm_num) (by positivity), Finsupp.add_apply]
    norm_num [Nat.factorization_pow, Nat.Prime.factorization (by norm_num : Nat.Prime 2),
      Nat.Prime.factorization (by norm_num : Nat.Prime 17)]
  rw [Nat.factorization_lcm hcarm0 (by positivity), Finsupp.sup_apply, h17]
  exact max_eq_right (carmichaelVal17 M b hM hb)

private theorem selectedExponentKills (M b : ℕ) (h16 : Nat.Coprime 16 M) :
    (16 : ZMod M) ^ (Nat.lcm (ArithmeticFunction.carmichael M) (2 * 17 ^ b)) = 1 := by
  let u := ZMod.unitOfCoprime 16 h16
  have h : u ^ (Nat.lcm (ArithmeticFunction.carmichael M) (2 * 17 ^ b)) = 1 :=
    orderOf_dvd_iff_pow_eq_one.mp ((orderOf_dvd_of_pow_eq_one
      (ArithmeticFunction.pow_carmichael u)).trans (Nat.dvd_lcm_left _ _))
  have hh := congrArg (fun v : (ZMod M)ˣ => (v : ZMod M)) h
  simpa only [Units.val_pow_eq_pow_val, Units.val_one, ZMod.coe_unitOfCoprime,
    Nat.cast_ofNat, u] using hh

local instance : Fact (Nat.Prime 17) := ⟨by norm_num⟩


private theorem lte16 (T : ℕ) (hT : Even T) (hT0 : T ≠ 0) :
    (16 ^ T - 1).factorization 17 = 1 + T.factorization 17 := by
  obtain ⟨s, hs⟩ := (even_iff_two_dvd.mp hT : 2 ∣ T)
  have hs0 : s ≠ 0 := by
    intro h
    rw [h, mul_zero] at hs
    exact hT0 hs
  have h := Nat.multiplicity_pow_sub_pow (p := 17) (x := 256) (y := 1)
    (by norm_num) (by norm_num) (by norm_num) (by norm_num) hs0
  have h255 : multiplicity 17 (255 : ℕ) = 1 :=
    multiplicity_eq_of_dvd_of_not_dvd (by norm_num : 17 ^ 1 ∣ (255 : ℕ))
      (by norm_num : ¬17 ^ (1 + 1) ∣ (255 : ℕ))
  have h2 : multiplicity 17 (2 : ℕ) = 0 :=
    multiplicity_eq_zero_of_not_dvd (by norm_num : ¬17 ∣ (2 : ℕ))
  rw [Nat.factorization_def _ (by norm_num : Nat.Prime 17),
    Nat.factorization_def _ (by norm_num : Nat.Prime 17), hs,
    Nat.multiplicity_mul (by norm_num) hs0, h2, zero_add]
  norm_num only [pow_mul, Nat.reducePow, one_pow, Nat.reduceSub] at h ⊢
  simpa only [h255] using h

private theorem selectedPrincipal17 (M r : ℕ) (hM : M.Coprime 34) (hr : 1 ≤ r)
    (hb : ∀ p : ℕ, p.Prime → p ∣ M → (p - 1).factorization 17 ≤ r - 1) :
    ∃ c : ℕ, 16 ^ (Nat.lcm (ArithmeticFunction.carmichael M) (2 * 17 ^ (r - 1))) =
      1 + 17 ^ r * c ∧ ¬17 ∣ c := by
  let T := Nat.lcm (ArithmeticFunction.carmichael M) (2 * 17 ^ (r - 1))
  have hM0 : M ≠ 0 := by
    rintro rfl
    norm_num at hM
  have hcarm0 : ArithmeticFunction.carmichael M ≠ 0 :=
    ne_zero_of_dvd_ne_zero (Nat.totient_pos.mpr (Nat.pos_of_ne_zero hM0)).ne'
      (ArithmeticFunction.carmichael_dvd_totient M)
  have hT0 : T ≠ 0 := Nat.lcm_ne_zero hcarm0 (by positivity)
  have hTeven : Even T := even_iff_two_dvd.mpr
    ((dvd_mul_right 2 (17 ^ (r - 1))).trans (Nat.dvd_lcm_right _ _))
  have hTv := selectedExponentVal17 M (r - 1) hM hb
  have hv : multiplicity 17 (16 ^ T - 1) = r := by
    rw [← Nat.factorization_def _ (by norm_num : Nat.Prime 17), lte16 T hTeven hT0]
    change 1 + (Nat.lcm (ArithmeticFunction.carmichael M) (2 * 17 ^ (r - 1))).factorization 17 = r
    rw [hTv]
    omega
  have hn : 16 ^ T - 1 ≠ 0 := by
    have hpow : 1 < (16 : ℕ) ^ T := one_lt_pow₀ (by norm_num) hT0
    omega
  have hfin : FiniteMultiplicity (17 : ℕ) (16 ^ T - 1) :=
    Nat.finiteMultiplicity_iff.mpr ⟨by norm_num, Nat.pos_of_ne_zero hn⟩
  obtain ⟨c, hc, hcn⟩ := hfin.exists_eq_pow_mul_and_not_dvd
  rw [hv] at hc
  refine ⟨c, ?_, hcn⟩
  change 16 ^ T = 1 + 17 ^ r * c
  omega

private theorem globalPrincipal17 (M r d u : ℕ) (hM : M.Coprime 34) (hr : 1 ≤ r)
    (hb : ∀ p : ℕ, p.Prime → p ∣ M → (p - 1).factorization 17 ≤ r - 1) :
    ∃ t : ℕ, 16 ^ t ≡ 1 + 17 ^ r * (M * u) [MOD 17 ^ (d + r) * M] := by
  let T := Nat.lcm (ArithmeticFunction.carmichael M) (2 * 17 ^ (r - 1))
  obtain ⟨c, hc, hcn⟩ := selectedPrincipal17 M r hM hr hb
  have h17M : Nat.Coprime 17 M :=
    (Nat.Coprime.of_dvd_right (by norm_num : 17 ∣ (34 : ℕ)) hM).symm
  have h16M : Nat.Coprime 16 M := by
    have h := (Nat.Coprime.of_dvd_right (by norm_num : 2 ∣ (34 : ℕ)) hM).symm.pow_left 4
    norm_num at h
    exact h
  obtain ⟨t, ht⟩ := principalReach17 r d hr (c : ℤ) ((M * u : ℕ) : ℤ)
    (by exact_mod_cast hcn)
  refine ⟨T * t, ?_⟩
  apply (Nat.modEq_and_modEq_iff_modEq_mul (h17M.pow_left (d + r))).mp
  constructor
  · apply (ZMod.natCast_eq_natCast_iff _ _ _).mp
    have hc' : (16 : ZMod (17 ^ (d + r))) ^ T =
        1 + (17 : ZMod (17 ^ (d + r))) ^ r * c := by
      have h := congrArg (fun n : ℕ => (n : ZMod (17 ^ (d + r)))) hc
      simpa only [Nat.cast_pow, Nat.cast_add, Nat.cast_mul, Nat.cast_ofNat, Nat.cast_one] using h
    simp only [Nat.cast_pow, Nat.cast_add, Nat.cast_mul, Nat.cast_ofNat, Nat.cast_one,
      pow_mul, hc']
    simpa only [Int.cast_mul, Int.cast_natCast, Nat.cast_mul] using ht
  · apply (ZMod.natCast_eq_natCast_iff _ _ _).mp
    simp only [Nat.cast_pow, Nat.cast_add, Nat.cast_mul, Nat.cast_ofNat, Nat.cast_one,
      pow_mul, T, selectedExponentKills M (r - 1) h16M, one_pow, ZMod.natCast_self,
      zero_mul, mul_zero, add_zero]

private theorem unitMultiplier (a m j : ℕ) (hm : 0 < m) (ha : a.Coprime m) :
    ∃ u : ℕ, a * u ≡ j [MOD m] := by
  let : NeZero m := ⟨Nat.ne_of_gt hm⟩
  let v := ZMod.unitOfCoprime a ha
  let x : ZMod m := ((v⁻¹ : (ZMod m)ˣ) : ZMod m) * (j : ZMod m)
  refine ⟨x.val, (ZMod.natCast_eq_natCast_iff _ _ _).mp ?_⟩
  rw [Nat.cast_mul, ZMod.natCast_zmod_val]
  change v.val * (v.inv * (j : ZMod m)) = (j : ZMod m)
  rw [← mul_assoc, v.val_inv, one_mul]

theorem rationalGrid17 (M r d a j : ℕ) (hM : M.Coprime 34) (hr : 1 ≤ r)
    (hb : ∀ p : ℕ, p.Prime → p ∣ M → (p - 1).factorization 17 ≤ r - 1)
    (ha : a.Coprime 17) :
    ∃ t : ℕ, Int.fract ((16 : ℝ) ^ t * ((a : ℝ) / (17 ^ (d + r) * M))) =
      Int.fract ((a : ℝ) / (17 ^ (d + r) * M) + j / (17 : ℝ) ^ d) := by
  have hM0 : M ≠ 0 := by
    rintro rfl
    norm_num at hM
  have hMR : (M : ℝ) ≠ 0 := by exact_mod_cast hM0
  obtain ⟨u, hu⟩ := unitMultiplier a (17 ^ d) j (by positivity) (ha.pow_right d)
  obtain ⟨t, ht⟩ := globalPrincipal17 M r d u hM hr hb
  have hbig := fractOfModEq (16 ^ t * a) ((1 + 17 ^ r * (M * u)) * a)
    (17 ^ (d + r) * M) (ht.mul_right a)
  have hsmall := fractOfModEq (a * u) j (17 ^ d) hu
  push_cast at hbig hsmall
  have heq : ((1 + (17 : ℝ) ^ r * (M * u)) * a) / (17 ^ (d + r) * M) =
      (a : ℝ) / (17 ^ (d + r) * M) + (a * u) / (17 : ℝ) ^ d := by
    rw [pow_add]
    field_simp
  rw [heq] at hbig
  refine ⟨t, ?_⟩
  calc
    Int.fract ((16 : ℝ) ^ t * ((a : ℝ) / (17 ^ (d + r) * M))) =
        Int.fract ((a : ℝ) / (17 ^ (d + r) * M) + (a * u) / (17 : ℝ) ^ d) := by
      simpa only [mul_div_assoc] using hbig
    _ = Int.fract ((a : ℝ) / (17 ^ (d + r) * M) + j / (17 : ℝ) ^ d) := by
      rw [← Int.fract_add_fract ((a : ℝ) / (17 ^ (d + r) * M))
        ((a * u) / (17 : ℝ) ^ d), hsmall, Int.fract_add_fract]



end PiDisjunctivity.PrimeGrid17
