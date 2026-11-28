/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module
public import PiDisjunctivity.Definitions
public import Mathlib.GroupTheory.OrderOfElement
public import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic

/-! Exact finite-period interfaces for the real base-16 orbit of a rational. -/
public section
namespace PiDisjunctivity.RationalHexOrbit

@[expose] noncomputable def orbitPoint (a q t : ℕ) : ℝ :=
  Int.fract ((16 : ℝ) ^ t * ((a : ℝ) / q))

@[expose] noncomputable def orbitSet (a q : ℕ) : Finset ℝ := by
  classical
  exact (Finset.range (orderOf (16 : ZMod q))).image (orbitPoint a q)

theorem orbitPoint_eq_fract_nat (a q t : ℕ) :
    orbitPoint a q t = Int.fract (((16 ^ t * a : ℕ) : ℝ) / q) := by
  simp only [orbitPoint, Nat.cast_mul, Nat.cast_pow, Nat.cast_ofNat, mul_div_assoc]

theorem fract_nat_div_eq_iff (a b q : ℕ) (hq : 0 < q) :
    Int.fract ((a : ℝ) / q) = Int.fract ((b : ℝ) / q) ↔ a ≡ b [MOD q] := by
  rw [Int.fract_div_natCast_eq_div_natCast_mod,
    Int.fract_div_natCast_eq_div_natCast_mod]
  change ((a % q : ℕ) : ℝ) / q = ((b % q : ℕ) : ℝ) / q ↔ a % q = b % q
  rw [div_left_inj₀ (by exact_mod_cast Nat.ne_of_gt hq : (q : ℝ) ≠ 0), Nat.cast_inj]

theorem period_pos (q : ℕ) (hb : Nat.Coprime 16 q) :
    0 < orderOf (16 : ZMod q) := by
  exact ((ZMod.isUnit_iff_coprime 16 q).mpr hb).isOfFinOrder.orderOf_pos

theorem orbitPoint_injOn (a q : ℕ) (hq : 0 < q) (ha : a.Coprime q) :
    Set.InjOn (orbitPoint a q) (Set.Iio (orderOf (16 : ZMod q))) := by
  intro i hi j hj heq
  rw [orbitPoint_eq_fract_nat, orbitPoint_eq_fract_nat,
    fract_nat_div_eq_iff _ _ _ hq] at heq
  have hpow : 16 ^ i ≡ 16 ^ j [MOD q] := Nat.ModEq.cancel_right_of_coprime ha.symm heq
  have hz := (ZMod.natCast_eq_natCast_iff (16 ^ i) (16 ^ j) q).mpr hpow
  simp only [Nat.cast_pow, Nat.cast_ofNat] at hz
  exact pow_injOn_Iio_orderOf hi hj hz

theorem orbitPoint_mod_period (a q t : ℕ) (hq : 0 < q) :
    orbitPoint a q (t % orderOf (16 : ZMod q)) = orbitPoint a q t := by
  rw [orbitPoint_eq_fract_nat, orbitPoint_eq_fract_nat,
    fract_nat_div_eq_iff _ _ _ hq]
  apply (ZMod.natCast_eq_natCast_iff _ _ q).mp
  simp only [Nat.cast_mul, Nat.cast_pow, Nat.cast_ofNat, pow_mod_orderOf]

theorem orbitPoint_mem_Ico (a q t : ℕ) : orbitPoint a q t ∈ Set.Ico (0 : ℝ) 1 :=
  ⟨Int.fract_nonneg _, Int.fract_lt_one _⟩

theorem orbitSet_subset_Ico (a q : ℕ) : (orbitSet a q : Set ℝ) ⊆ Set.Ico 0 1 := by
  classical
  intro x hx
  obtain ⟨t, _, rfl⟩ := Finset.mem_image.mp hx
  exact orbitPoint_mem_Ico a q t

theorem orbitSet_card (a q : ℕ) (hq : 0 < q) (ha : a.Coprime q) :
    (orbitSet a q).card = orderOf (16 : ZMod q) := by
  classical
  unfold orbitSet
  rw [Finset.card_image_iff.mpr ?_, Finset.card_range]
  intro i hi j hj heq
  exact orbitPoint_injOn a q hq ha (Finset.mem_range.mp hi) (Finset.mem_range.mp hj) heq

theorem orbitPoint_mem_orbitSet (a q t : ℕ) (hq : 0 < q) (hb : Nat.Coprime 16 q) :
    orbitPoint a q t ∈ orbitSet a q := by
  classical
  apply Finset.mem_image.mpr
  exact ⟨t % orderOf (16 : ZMod q),
    Finset.mem_range.mpr (Nat.mod_lt _ (period_pos q hb)), orbitPoint_mod_period a q t hq⟩

theorem mem_orbitSet_iff (a q : ℕ) (hq : 0 < q) (hb : Nat.Coprime 16 q) (x : ℝ) :
    x ∈ orbitSet a q ↔ ∃ t : ℕ, orbitPoint a q t = x := by
  classical
  constructor
  · intro hx
    obtain ⟨t, _, ht⟩ := Finset.mem_image.mp hx
    exact ⟨t, ht⟩
  · rintro ⟨t, rfl⟩
    exact orbitPoint_mem_orbitSet a q t hq hb

theorem orbitSet_filter_card (a q : ℕ) (hq : 0 < q) (ha : a.Coprime q)
    (A : ℝ → Prop) [DecidablePred A] :
    ((orbitSet a q).filter A).card =
      ((Finset.range (orderOf (16 : ZMod q))).filter (fun t => A (orbitPoint a q t))).card := by
  classical
  unfold orbitSet
  rw [Finset.filter_image]
  apply Finset.card_image_iff.mpr
  intro i hi j hj heq
  exact orbitPoint_injOn a q hq ha
    (Finset.mem_range.mp (Finset.mem_filter.mp hi).1)
    (Finset.mem_range.mp (Finset.mem_filter.mp hj).1) heq

end PiDisjunctivity.RationalHexOrbit
