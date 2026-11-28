/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import Mathlib.Topology.Instances.AddCircle.Real
public import Mathlib.Topology.GDelta.Basic
import Mathlib.Tactic

/-! Rational-affine invariance of arbitrarily late hexadecimal interval visits.

Proper closed invariant circle sets are nowhere dense. Finite torsion translates and
nonzero integer multipliers preserve orbit density, giving the exact real interval
contract for every nonzero rational affine map. This supplies no visits for a given
real number and makes no assertion about frequencies or normality.
-/

public section

open Set Function

namespace PiDisjunctivity.AffineOrbit

/-- Any forward-invariant set for multiplication by sixteen that contains an open
arc is the whole additive circle. Closedness is unnecessary for this step. -/
theorem eq_univ_of_mapsTo_sixteen_of_interior_nonempty
    (S : Set (AddCircle (1 : ℝ)))
    (hS : MapsTo (fun z : AddCircle (1 : ℝ) => (16 : ℕ) • z) S S)
    (hI : (interior S).Nonempty) : S = univ := by
  have hpow (k : ℕ) {z : AddCircle (1 : ℝ)} (hz : z ∈ S) :
      (16 ^ k : ℕ) • z ∈ S := by
    induction k with
    | zero => simpa only [pow_zero, one_nsmul] using hz
    | succ k ih => simpa only [pow_succ, mul_nsmul] using hS ih
  let U : Set ℝ := (fun x : ℝ => (x : AddCircle (1 : ℝ))) ⁻¹' interior S
  have hU : IsOpen U := isOpen_interior.preimage (AddCircle.continuous_mk' (1 : ℝ))
  have hUn : U.Nonempty := by
    obtain ⟨z, hz⟩ := hI
    refine ⟨(AddCircle.equivIco (1 : ℝ) 0 z : ℝ), ?_⟩
    change (((AddCircle.equivIco (1 : ℝ) 0 z : ℝ) : AddCircle (1 : ℝ))) ∈ interior S
    simpa only [AddCircle.coe_equivIco] using hz
  obtain ⟨a, b, hab, hsub⟩ := hU.exists_Ioo_subset hUn
  obtain ⟨k, hk⟩ := pow_unbounded_of_one_lt (1 / (b - a)) (show (1 : ℝ) < 16 by norm_num)
  have hp : 0 < (16 : ℝ) ^ k := by positivity
  have hwidth : 1 < (16 : ℝ) ^ k * (b - a) := by
    exact (div_lt_iff₀ (sub_pos.mpr hab)).mp hk
  let c : ℝ := (16 : ℝ) ^ k * a + ((16 : ℝ) ^ k * (b - a) - 1) / 2
  have hca : (16 : ℝ) ^ k * a < c := by dsimp [c]; linarith
  have hcb : c + 1 < (16 : ℝ) ^ k * b := by dsimp [c]; nlinarith
  apply eq_univ_of_forall
  intro z
  have hz : z ∈ (fun y : ℝ => (y : AddCircle (1 : ℝ))) '' Ico c (c + 1) := by
    rw [AddCircle.coe_image_Ico_eq]
    exact mem_univ z
  obtain ⟨y, hy, hyz⟩ := hz
  have hya : a < y / (16 : ℝ) ^ k := by
    apply (lt_div_iff₀ hp).mpr
    nlinarith [hy.1]
  have hyb : y / (16 : ℝ) ^ k < b := by
    apply (div_lt_iff₀ hp).mpr
    nlinarith [hy.2]
  have hx : ((y / (16 : ℝ) ^ k : ℝ) : AddCircle (1 : ℝ)) ∈ S :=
    interior_subset (hsub ⟨hya, hyb⟩)
  have hscaled := hpow k hx
  have hid : (16 ^ k : ℕ) • ((y / (16 : ℝ) ^ k : ℝ) : AddCircle (1 : ℝ)) =
      (y : AddCircle (1 : ℝ)) := by
    rw [← AddCircle.coe_nsmul]
    congr 1
    simp only [nsmul_eq_mul, Nat.cast_pow, Nat.cast_ofNat]
    field_simp
  change (y : AddCircle (1 : ℝ)) = z at hyz
  rw [hid, hyz] at hscaled
  exact hscaled

/-- A proper closed forward-invariant circle set is nowhere dense. -/
theorem isNowhereDense_of_isClosed_mapsTo_sixteen_ne_univ
    (S : Set (AddCircle (1 : ℝ))) (hclosed : IsClosed S)
    (hS : MapsTo (fun z : AddCircle (1 : ℝ) => (16 : ℕ) • z) S S)
    (hproper : S ≠ univ) : IsNowhereDense S := by
  apply hclosed.isNowhereDense_iff.mpr
  apply Set.not_nonempty_iff_eq_empty.mp
  intro hI
  exact hproper (eq_univ_of_mapsTo_sixteen_of_interior_nonempty S hS hI)

/-- The ordinary orbit closure supplies the invariant-set consumer. -/
theorem orbitClosure_isNowhereDense_of_not_denseRange
    (x : AddCircle (1 : ℝ))
    (hx : ¬ DenseRange (fun n : ℕ => (16 ^ n : ℕ) • x)) :
    IsNowhereDense (closure (range (fun n : ℕ => (16 ^ n : ℕ) • x))) := by
  apply isNowhereDense_of_isClosed_mapsTo_sixteen_ne_univ _ isClosed_closure
  · apply Set.MapsTo.closure ?_ (continuous_nsmul 16)
    rintro z ⟨n, rfl⟩
    refine ⟨n + 1, ?_⟩
    simp only [pow_succ, mul_nsmul]
  · intro heq
    exact hx (dense_iff_closure_eq.mpr heq)

/-- Ordinary orbit density implies density of each specified tail. -/
theorem denseRange_sixteen_tail
    (x : AddCircle (1 : ℝ))
    (hx : DenseRange (fun n : ℕ => (16 ^ n : ℕ) • x)) (N : ℕ) :
    DenseRange (fun n : ℕ => (16 ^ (n + N) : ℕ) • x) := by
  have hsur : Surjective (fun z : AddCircle (1 : ℝ) => (16 ^ N : ℕ) • z) :=
    by
      simpa only [natCast_zsmul] using
        (DivisibleBy.surjective_smul (AddCircle (1 : ℝ)) ℤ
          (n := ((16 ^ N : ℕ) : ℤ)) (by positivity))
  have h := hsur.denseRange.comp hx (continuous_nsmul (16 ^ N))
  simpa only [Function.comp_def, pow_add, mul_nsmul] using h

/-- The circle-density interface supplies the exact real arbitrarily-late
open-interval contract, including both boundary-adjacent intervals. -/
theorem hitsOpenIntervals_late_of_denseRange_circle
    (x : ℝ)
    (hx : DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (x : AddCircle (1 : ℝ)))) :
    ∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * x) ∈ Ioo a b := by
  intro a b ha hab hb N
  have htail := denseRange_sixteen_tail (x : AddCircle (1 : ℝ)) hx N
  let U : Set (AddCircle (1 : ℝ)) :=
    (fun y : ℝ => (y : AddCircle (1 : ℝ))) '' Ioo a b
  have hU : IsOpen U := QuotientAddGroup.isOpenMap_coe _ isOpen_Ioo
  have hUne : U.Nonempty := (nonempty_Ioo.mpr hab).image _
  obtain ⟨m, hm⟩ := htail.exists_mem_open hU hUne
  obtain ⟨y, hy, hyeq⟩ := hm
  have hfract : Int.fract ((16 : ℝ) ^ (m + N) * x) = y := by
    apply AddCircle.injOn_coe_Ico (1 : ℝ) 0
    · exact ⟨Int.fract_nonneg _, by simpa only [zero_add] using Int.fract_lt_one _⟩
    · exact ⟨ha.trans hy.1.le, by simpa only [zero_add] using hy.2.trans_le hb⟩
    · rw [AddCircle.coe_fract]
      change (y : AddCircle (1 : ℝ)) = (16 ^ (m + N) : ℕ) • (x : AddCircle (1 : ℝ)) at hyeq
      simpa only [← AddCircle.coe_nsmul, nsmul_eq_mul, Nat.cast_pow, Nat.cast_ofNat]
        using hyeq.symm
  refine ⟨m + N, by omega, ?_⟩
  rw [hfract]
  exact hy

/-- A torsion translation cannot turn a nondense orbit into a dense one. -/
theorem denseRange_of_denseRange_add_torsion
    (x r : AddCircle (1 : ℝ)) (q : ℕ) (hq : 0 < q) (hr : q • r = 0)
    (hxr : DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (x + r))) :
    DenseRange (fun n : ℕ => (16 ^ n : ℕ) • x) := by
  classical
  by_contra hx
  let K := closure (range (fun n : ℕ => (16 ^ n : ℕ) • x))
  have hK : IsNowhereDense K := orbitClosure_isNowhereDense_of_not_denseRange x hx
  let F : Set (AddCircle (1 : ℝ)) := {t | q • t = 0}
  let : Fintype F := (AddCircle.finite_torsion (1 : ℝ) hq).fintype
  let Z : Set (AddCircle (1 : ℝ)) := ⋃ t : F, (fun z => z + t.val) '' K
  have hZnd : IsNowhereDense Z := by
    apply IsNowhereDense.iUnion
    intro t
    exact (Homeomorph.addRight t.val).isInducing.isNowhereDense_image hK
  have hsub : range (fun n : ℕ => (16 ^ n : ℕ) • (x + r)) ⊆ Z := by
    rintro z ⟨n, rfl⟩
    have ht : (16 ^ n : ℕ) • r ∈ F := by
      change q • ((16 ^ n : ℕ) • r) = 0
      rw [smul_comm, hr, smul_zero]
    apply mem_iUnion.mpr
    refine ⟨⟨(16 ^ n : ℕ) • r, ht⟩, ?_⟩
    refine ⟨(16 ^ n : ℕ) • x, subset_closure ⟨n, rfl⟩, ?_⟩
    simp only [nsmul_add]
  have hZd : Dense Z := hxr.mono hsub
  have hZcl : closure Z = univ := dense_iff_closure_eq.mp hZd
  have hbad : (univ : Set (AddCircle (1 : ℝ))) = ∅ := by
    simpa only [IsNowhereDense, hZcl, interior_univ] using hZnd
  exact empty_ne_univ hbad.symm

/-- Full circle density is invariant under a specified finite-order translation. -/
theorem denseRange_add_torsion_iff
    (x r : AddCircle (1 : ℝ)) (q : ℕ) (hq : 0 < q) (hr : q • r = 0) :
    DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (x + r)) ↔
      DenseRange (fun n : ℕ => (16 ^ n : ℕ) • x) := by
  constructor
  · exact denseRange_of_denseRange_add_torsion x r q hq hr
  · intro hx
    have hrneg : q • (-r) = 0 := by rw [smul_neg, hr, neg_zero]
    apply denseRange_of_denseRange_add_torsion (x + r) (-r) q hq hrneg
    simpa only [add_neg_cancel_right] using hx

/-- Rational translations are a direct instance of the finite-order consumer. -/
theorem denseRange_add_rat_iff (x : ℝ) (r : ℚ) :
    DenseRange (fun n : ℕ => (16 ^ n : ℕ) • ((x + (r : ℝ) : ℝ) : AddCircle (1 : ℝ))) ↔
      DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (x : AddCircle (1 : ℝ))) := by
  have hr : r.den • ((r : ℝ) : AddCircle (1 : ℝ)) = 0 := by
    have hord : addOrderOf (((r : ℝ) : AddCircle (1 : ℝ))) = r.den := by
      simpa only [mul_one] using (AddCircle.addOrderOf_coe_rat (p := (1 : ℝ)) (q := r))
    rw [← hord]
    exact addOrderOf_nsmul_eq_zero _
  simpa only [AddCircle.coe_add] using
    denseRange_add_torsion_iff (x : AddCircle (1 : ℝ)) ((r : ℝ) : AddCircle (1 : ℝ))
      r.den r.pos hr

/-- Exact equivalence with the project's interval formulation; no positivity
assumption on the original real lift is needed. -/
theorem denseRange_circle_iff_hitsOpenIntervals_late (x : ℝ) :
    DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (x : AddCircle (1 : ℝ))) ↔
      ∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
        ∀ N : ℕ, ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * x) ∈ Ioo a b := by
  constructor
  · exact hitsOpenIntervals_late_of_denseRange_circle x
  · intro h
    by_contra hx
    let K := closure (range (fun n : ℕ => (16 ^ n : ℕ) • (x : AddCircle (1 : ℝ))))
    have hK : IsNowhereDense K :=
      orbitClosure_isNowhereDense_of_not_denseRange (x : AddCircle (1 : ℝ)) hx
    have hclosed : IsClosed K := isClosed_closure
    have hcomp : Dense Kᶜ := interior_eq_empty_iff_dense_compl.mp
      (hclosed.isNowhereDense_iff.mp hK)
    let V : Set ℝ := (fun y : ℝ => (y : AddCircle (1 : ℝ))) ⁻¹' Kᶜ
    have hVd : Dense V := hcomp.preimage QuotientAddGroup.isOpenMap_coe
    have hVo : IsOpen V := hclosed.isOpen_compl.preimage (AddCircle.continuous_mk' (1 : ℝ))
    obtain ⟨y, hyV, hy01⟩ := hVd.exists_mem_open
      (isOpen_Ioo : IsOpen (Ioo (0 : ℝ) 1)) (nonempty_Ioo.mpr (by norm_num))
    obtain ⟨a, b, hyab, habV⟩ := mem_nhds_iff_exists_Ioo_subset.mp (hVo.mem_nhds hyV)
    have hab : max a 0 < min b 1 :=
      (max_lt hyab.1 hy01.1).trans (lt_min hyab.2 hy01.2)
    obtain ⟨n, _, hn⟩ := h (max a 0) (min b 1) (le_max_right _ _) hab (min_le_right _ _) 0
    have hfracV : Int.fract ((16 : ℝ) ^ n * x) ∈ V := habV
      ⟨(le_max_left _ _).trans_lt hn.1, hn.2.trans_le (min_le_left _ _)⟩
    have hraw : (((16 : ℝ) ^ n * x : ℝ) : AddCircle (1 : ℝ)) ∈ K := by
      have hm : (16 ^ n : ℕ) • (x : AddCircle (1 : ℝ)) ∈ K :=
        subset_closure (mem_range_self n)
      simpa only [← AddCircle.coe_nsmul, nsmul_eq_mul, Nat.cast_pow, Nat.cast_ofNat] using hm
    change ((Int.fract ((16 : ℝ) ^ n * x) : ℝ) : AddCircle (1 : ℝ)) ∉ K at hfracV
    apply hfracV
    rw [AddCircle.coe_fract]
    exact hraw

/-- Rational-translation invariance, in the exact late-hit syntax. -/
theorem hitsOpenIntervals_late_add_rat_iff (x : ℝ) (r : ℚ) :
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * (x + (r : ℝ))) ∈ Ioo a b) ↔
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * x) ∈ Ioo a b) := by
  rw [← denseRange_circle_iff_hitsOpenIntervals_late,
    ← denseRange_circle_iff_hitsOpenIntervals_late]
  exact denseRange_add_rat_iff x r

/-- Nonzero integer multiplication preserves circle orbit density in both directions. -/
theorem denseRange_zsmul_iff (x : AddCircle (1 : ℝ)) (m : ℤ) (hm : m ≠ 0) :
    DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (m • x)) ↔
      DenseRange (fun n : ℕ => (16 ^ n : ℕ) • x) := by
  classical
  constructor
  · intro hmx
    by_contra hx
    let K := closure (range (fun n : ℕ => (16 ^ n : ℕ) • x))
    have hK : IsNowhereDense K := orbitClosure_isNowhereDense_of_not_denseRange x hx
    have hKclosed : IsClosed K := isClosed_closure
    let L : Set (AddCircle (1 : ℝ)) := (fun z => m • z) '' K
    have hLc : IsClosed L := (hKclosed.isCompact.image (continuous_zsmul m)).isClosed
    have hLd : Dense L := hmx.mono (by
      rintro z ⟨n, rfl⟩
      refine ⟨(16 ^ n : ℕ) • x, subset_closure (mem_range_self n), ?_⟩
      exact smul_comm _ _ _)
    have hL : L = univ := hLc.closure_eq.symm.trans (dense_iff_closure_eq.mp hLd)
    let F : Set (AddCircle (1 : ℝ)) := {t | m • t = 0}
    have hF : F.Finite := by
      simpa only [natAbs_nsmul_eq_zero] using
        (AddCircle.finite_torsion (1 : ℝ) (Int.natAbs_pos.mpr hm))
    let : Fintype F := hF.fintype
    let Z : Set (AddCircle (1 : ℝ)) := ⋃ t : F, (fun z => z + t.val) '' K
    have hZnd : IsNowhereDense Z := by
      apply IsNowhereDense.iUnion
      intro t
      exact (Homeomorph.addRight t.val).isInducing.isNowhereDense_image hK
    have hZ : Z = univ := by
      apply eq_univ_of_forall
      intro z
      have hmz : m • z ∈ L := by rw [hL]; exact mem_univ _
      obtain ⟨y, hy, hyz⟩ := hmz
      change m • y = m • z at hyz
      have ht : z - y ∈ F := by
        change m • (z - y) = 0
        rw [smul_sub, hyz, sub_self]
      apply mem_iUnion.mpr
      refine ⟨⟨z - y, ht⟩, y, hy, ?_⟩
      change y + (z - y) = z
      rw [add_comm y (z - y), sub_add_cancel]
    have hbad : (univ : Set (AddCircle (1 : ℝ))) = ∅ := by
      simpa only [IsNowhereDense, hZ, closure_univ, interior_univ] using hZnd
    exact empty_ne_univ hbad.symm
  · intro hx
    have h := (DivisibleBy.surjective_smul (AddCircle (1 : ℝ)) ℤ hm).denseRange.comp
      hx (continuous_zsmul m)
    simpa only [Function.comp_def, smul_comm m] using h

/-- Integer scaling stated on real lifts, including negative scalars. -/
theorem denseRange_int_mul_iff (x : ℝ) (m : ℤ) (hm : m ≠ 0) :
    DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (((m : ℝ) * x : ℝ) : AddCircle (1 : ℝ))) ↔
      DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (x : AddCircle (1 : ℝ))) := by
  simpa only [← AddCircle.coe_zsmul, zsmul_eq_mul] using
    denseRange_zsmul_iff (x : AddCircle (1 : ℝ)) m hm

/-- Rational division is performed on a real lift, never as a circle map. -/
theorem denseRange_rat_mul_iff (x : ℝ) (r : ℚ) (hr : r ≠ 0) :
    DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (((r : ℝ) * x : ℝ) : AddCircle (1 : ℝ))) ↔
      DenseRange (fun n : ℕ => (16 ^ n : ℕ) • (x : AddCircle (1 : ℝ))) := by
  have hd : (r.den : ℝ) ≠ 0 := by exact_mod_cast r.den_ne_zero
  have hvalue : (r.den : ℝ) * ((r : ℝ) * x) = (r.num : ℝ) * x := by
    rw [Rat.cast_def]
    field_simp
  have hden := denseRange_int_mul_iff ((r : ℝ) * x) (r.den : ℤ)
    (by exact_mod_cast r.den_ne_zero)
  simp only [Int.cast_natCast] at hden
  rw [hvalue] at hden
  exact hden.symm.trans (denseRange_int_mul_iff x r.num (Rat.num_ne_zero.mpr hr))

/-- Rational-affine invariance of universal late visitation. -/
theorem hitsOpenIntervals_late_rat_affine_iff (x : ℝ) (r s : ℚ) (hr : r ≠ 0) :
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * ((r : ℝ) * x + (s : ℝ))) ∈ Ioo a b) ↔
    (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, Int.fract ((16 : ℝ) ^ n * x) ∈ Ioo a b) := by
  rw [← denseRange_circle_iff_hitsOpenIntervals_late,
    ← denseRange_circle_iff_hitsOpenIntervals_late]
  exact (denseRange_add_rat_iff ((r : ℝ) * x) s).trans (denseRange_rat_mul_iff x r hr)

end PiDisjunctivity.AffineOrbit
