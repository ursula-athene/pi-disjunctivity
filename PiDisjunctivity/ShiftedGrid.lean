/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module
public import Mathlib.Algebra.Order.Floor.BigOperators
public import Mathlib.Algebra.Order.Archimedean.Real.Basic
import Mathlib.Tactic

/-! Exact half - open interval counts and discrepancy for shifted finite circle grids. -/

public section
namespace PiDisjunctivity

/-- Number of points of the shifted m - point circle grid in the half - open real interval. -/
@[expose] noncomputable def shiftedGridIcoCount (m : ℕ) (x u v : ℝ) : ℕ := by
  classical
  exact ((Finset.range m).filter
    (fun j : ℕ => Int.fract (x + (j : ℝ) / m) ∈ Set.Ico u v)).card

private theorem floor_sub_of_le_fract (x t : ℝ) (ht0 : 0 ≤ t) (ht : t ≤ Int.fract x) :
    ⌊x - t⌋ = ⌊x⌋ := by
  apply Int.floor_eq_iff.mpr
  have hx := Int.lt_floor_add_one x
  unfold Int.fract at ht
  constructor <;> linarith

private theorem floor_sub_of_fract_lt (x t : ℝ) (ht1 : t ≤ 1) (ht : Int.fract x < t) :
    ⌊x - t⌋ = ⌊x⌋-1 := by
  apply Int.floor_eq_iff.mpr
  have hx := Int.floor_le x
  unfold Int.fract at ht
  simp only [Int.cast_sub, Int.cast_one]
  constructor <;> linarith

/-- The floor - difference indicator includes u and excludes v, including the endpoints 0 and 1. -/
private theorem fract_mem_Ico_indicator (x u v : ℝ) (hu : 0 ≤ u) (huv : u ≤ v) (hv : v ≤ 1) :
    (if Int.fract x ∈ Set.Ico u v then (1 : ℤ) else 0) = ⌊x - u⌋-⌊x - v⌋ := by
  classical
  by_cases hxu : u ≤ Int.fract x
  · by_cases hxv : Int.fract x < v
    · rw [floor_sub_of_le_fract x u hu hxu, floor_sub_of_fract_lt x v hv hxv]
      simp only [Set.mem_Ico, hxu, hxv, and_self, ite_true]
      omega
    · rw [floor_sub_of_le_fract x u hu hxu,
        floor_sub_of_le_fract x v (hu.trans huv) (le_of_not_gt hxv)]
      simp only [Set.mem_Ico, hxu, hxv, and_false, ite_false, sub_self]
  · have hxu' : Int.fract x < u := lt_of_not_ge hxu
    have hxv : Int.fract x < v := hxu'.trans_le huv
    rw [floor_sub_of_fract_lt x u (huv.trans hv) hxu',
      floor_sub_of_fract_lt x v hv hxv]
    simp only [Set.mem_Ico, hxu, false_and, ite_false, sub_self]

/-- Hermite's identity gives an exact floor difference for the shifted grid count. -/
theorem shiftedGridIcoCount_eq_floor (m : ℕ) (x u v : ℝ)
    (hu : 0 ≤ u) (huv : u ≤ v) (hv : v ≤ 1) :
    (shiftedGridIcoCount m x u v : ℤ) = ⌊(m : ℝ) * (x - u)⌋-⌊(m : ℝ) * (x - v)⌋ := by
  classical
  unfold shiftedGridIcoCount
  rw [← Finset.sum_boole]
  simp_rw [fract_mem_Ico_indicator _ u v hu huv hv]
  rw [Finset.sum_sub_distrib]
  have hu' : ∀ j : ℕ, x + (j : ℝ) / m - u = (x - u) + (j : ℝ) / m := by intro j; ring
  have hv' : ∀ j : ℕ, x + (j : ℝ) / m - v = (x - v) + (j : ℝ) / m := by intro j; ring
  simp_rw [hu', hv']
  rw [Int.sum_floor_add_div, Int.sum_floor_add_div]

/-- The unnormalized shifted - grid interval - count error is strictly less than one. -/
theorem shiftedGridIcoCount_discrepancy_lt_one (m : ℕ) (x u v : ℝ)
    (hu : 0 ≤ u) (huv : u ≤ v) (hv : v ≤ 1) :
    |(shiftedGridIcoCount m x u v : ℝ) - (m : ℝ) * (v - u)| < 1 := by
  have hcount := shiftedGridIcoCount_eq_floor m x u v hu huv hv
  have hreal : (shiftedGridIcoCount m x u v : ℝ) =
      (⌊(m : ℝ) * (x - u)⌋ : ℝ) - (⌊(m : ℝ) * (x - v)⌋ : ℝ) := by
    exact_mod_cast hcount
  rw [hreal, abs_lt]
  have hu0 := Int.floor_le ((m : ℝ) * (x - u))
  have hu1 := Int.lt_floor_add_one ((m : ℝ) * (x - u))
  have hv0 := Int.floor_le ((m : ℝ) * (x - v))
  have hv1 := Int.lt_floor_add_one ((m : ℝ) * (x - v))
  constructor <;> nlinarith


/-- For a nonempty grid, the normalized half - open interval discrepancy is less than 1 / m. -/
theorem shiftedGridIcoCount_normalized_discrepancy (m : ℕ) (hm : 0 < m) (x u v : ℝ)
    (hu : 0 ≤ u) (huv : u ≤ v) (hv : v ≤ 1) :
    |(shiftedGridIcoCount m x u v : ℝ) / m - (v - u)| < 1 / (m : ℝ) := by
  have hmR : 0 < (m : ℝ) := by exact_mod_cast hm
  have heq : (shiftedGridIcoCount m x u v : ℝ) / m - (v - u) =
      ((shiftedGridIcoCount m x u v : ℝ) - (m : ℝ) * (v - u)) / m := by
    rw [sub_div, mul_div_cancel_left₀ _ hmR.ne']
  rw [heq, abs_div, abs_of_pos hmR]
  exact (div_lt_div_iff_of_pos_right hmR).mpr
    (shiftedGridIcoCount_discrepancy_lt_one m x u v hu huv hv)

/-- Boundary instantiation: every grid point lies in [0,1). -/
theorem shiftedGridIcoCount_full (m : ℕ) (x : ℝ) :
    shiftedGridIcoCount m x 0 1 = m := by
  have h := shiftedGridIcoCount_eq_floor m x 0 1 (by norm_num) (by norm_num) (by norm_num)
  rw [sub_zero, show (m : ℝ) * (x - 1) = (m : ℝ) * x - (m : ℝ) by ring,
    Int.floor_sub_natCast] at h
  omega

/-- Boundary instantiation: equal half - open endpoints give the empty interval. -/
theorem shiftedGridIcoCount_self (m : ℕ) (x u : ℝ) (hu : 0 ≤ u) (hu1 : u ≤ 1) :
    shiftedGridIcoCount m x u u = 0 := by
  have h := shiftedGridIcoCount_eq_floor m x u u hu le_rfl hu1
  rw [sub_self] at h
  exact_mod_cast h

/-- Number of members of a finite real set in a half-open interval. -/
@[expose] noncomputable def finiteIcoCount (S : Finset ℝ) (u v : ℝ) : ℕ := by
  classical
  exact (S.filter (fun x : ℝ => x ∈ Set.Ico u v)).card

/-- Circle translation is injective on the canonical half-open representative interval. -/
private theorem fract_translate_injOn (a : ℝ) :
    Set.InjOn (fun x : ℝ => Int.fract (x + a)) (Set.Ico 0 1) := by
  intro x hx y hy h
  have ht := congrArg (fun z : ℝ => Int.fract (z - a)) h
  simp only [Int.fract_fract_sub, add_sub_cancel_right] at ht
  rw [Int.fract_eq_self.mpr hx, Int.fract_eq_self.mpr hy] at ht
  exact ht

/-- A circle translation preserving a finite representative set preserves every real finite sum. -/
private theorem finiteCircle_translate_sum (S : Finset ℝ) (a : ℝ)
    (hS : ∀ x ∈ S, x ∈ Set.Ico (0 : ℝ) 1)
    (hinv : ∀ x ∈ S, Int.fract (x + a) ∈ S) (f : ℝ → ℝ) :
    ∑ x ∈ S, f (Int.fract (x + a)) = ∑ x ∈ S, f x := by
  classical
  have hi : Set.InjOn (fun x : ℝ => Int.fract (x + a)) (S : Set ℝ) := by
    intro x hx y hy heq
    exact fract_translate_injOn a (hS x hx) (hS y hy) heq
  have him : S.image (fun x : ℝ => Int.fract (x + a)) = S := by
    apply Finset.eq_of_subset_of_card_le
    · intro y hy
      obtain ⟨x, hx, rfl⟩ := Finset.mem_image.mp hy
      exact hinv x hx
    · rw [Finset.card_image_of_injOn hi]
  calc
    _ = ∑ y ∈ S.image (fun x : ℝ => Int.fract (x + a)), f y :=
      (Finset.sum_image hi).symm
    _ = ∑ y ∈ S, f y := by rw [him]

/-- Double counting all grid translations of a finite invariant circle set. -/
private theorem finiteCircle_grid_double_count (S : Finset ℝ) (m : ℕ) (u v : ℝ)
    (hS : ∀ x ∈ S, x ∈ Set.Ico (0 : ℝ) 1)
    (hinv : ∀ j < m, ∀ x ∈ S, Int.fract (x + (j : ℝ) / m) ∈ S) :
    (∑ x ∈ S, (shiftedGridIcoCount m x u v : ℝ)) =
      (m : ℝ) * (finiteIcoCount S u v : ℝ) := by
  classical
  have hcount (x : ℝ) : (shiftedGridIcoCount m x u v : ℝ) =
      ∑ j ∈ Finset.range m,
        if Int.fract (x + (j : ℝ) / m) ∈ Set.Ico u v then (1 : ℝ) else 0 := by
    unfold shiftedGridIcoCount
    exact Finset.natCast_card_filter _ _
  simp_rw [hcount]
  rw [Finset.sum_comm]
  have ht (j : ℕ) (hj : j ∈ Finset.range m) :
      (∑ x ∈ S, if Int.fract (x + (j : ℝ) / m) ∈ Set.Ico u v then (1 : ℝ) else 0) =
        (finiteIcoCount S u v : ℝ) := by
    rw [finiteCircle_translate_sum S ((j : ℝ) / m) hS
      (hinv j (Finset.mem_range.mp hj)) (fun x => if x ∈ Set.Ico u v then 1 else 0)]
    unfold finiteIcoCount
    exact Finset.sum_boole _ _
  rw [Finset.sum_congr rfl ht]
  simp only [Finset.sum_const, Finset.card_range, nsmul_eq_mul]


/-- Finite translation-invariant circle sets inherit the normalized grid discrepancy bound. -/
theorem finiteCircle_grid_discrepancy (S : Finset ℝ) (hSne : S.Nonempty)
    (m : ℕ) (hm : 0 < m)
    (hS : ∀ x ∈ S, x ∈ Set.Ico (0 : ℝ) 1)
    (hinv : ∀ j < m, ∀ x ∈ S, Int.fract (x + (j : ℝ) / m) ∈ S)
    (u v : ℝ) (hu : 0 ≤ u) (huv : u ≤ v) (hv : v ≤ 1) :
    |(finiteIcoCount S u v : ℝ) / (S.card : ℝ) - (v - u)| < 1 / (m : ℝ) := by
  classical
  have hmR : 0 < (m : ℝ) := by exact_mod_cast hm
  have hnR : 0 < (S.card : ℝ) := by exact_mod_cast Finset.card_pos.mpr hSne
  have hs : |∑ x ∈ S, ((shiftedGridIcoCount m x u v : ℝ) - (m : ℝ) * (v - u))| <
      (S.card : ℝ) := by
    calc
      _ ≤ ∑ x ∈ S, |(shiftedGridIcoCount m x u v : ℝ) - (m : ℝ) * (v - u)| :=
        Finset.abs_sum_le_sum_abs _ _
      _ < ∑ _x ∈ S, (1 : ℝ) :=
        Finset.sum_lt_sum_of_nonempty hSne
          (fun x _ => shiftedGridIcoCount_discrepancy_lt_one m x u v hu huv hv)
      _ = (S.card : ℝ) := by simp only [Finset.sum_const, nsmul_eq_mul, mul_one]
  have heq : (∑ x ∈ S, ((shiftedGridIcoCount m x u v : ℝ) - (m : ℝ) * (v - u))) =
      (m : ℝ) * (finiteIcoCount S u v : ℝ) - (S.card : ℝ) * ((m : ℝ) * (v - u)) := by
    rw [Finset.sum_sub_distrib, finiteCircle_grid_double_count S m u v hS hinv]
    simp only [Finset.sum_const, nsmul_eq_mul]
  rw [heq] at hs
  have hratio : (finiteIcoCount S u v : ℝ) / (S.card : ℝ) - (v - u) =
      ((m : ℝ) * (finiteIcoCount S u v : ℝ) - (S.card : ℝ) * ((m : ℝ) * (v - u))) /
        ((m : ℝ) * (S.card : ℝ)) := by
    field_simp
  have hbound : (S.card : ℝ) / ((m : ℝ) * (S.card : ℝ)) = 1 / (m : ℝ) := by
    field_simp
  rw [hratio, abs_div, abs_of_pos (mul_pos hmR hnR), ← hbound]
  exact (div_lt_div_iff_of_pos_right (mul_pos hmR hnR)).mpr hs


end PiDisjunctivity
