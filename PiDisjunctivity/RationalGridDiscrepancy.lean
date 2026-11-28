/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.PrimeGrid17
public import PiDisjunctivity.RationalHexOrbit
public import PiDisjunctivity.ShiftedGrid
import Mathlib.Tactic

/-! Complete rational hexadecimal periods inherit a fine grid discrepancy bound. -/

public section

namespace PiDisjunctivity.RationalHexOrbit

/-- The generic grid denominator is positive. -/
private theorem grid_den_pos (M r d : ℕ) (hM : M.Coprime 34) : 0 < 17 ^ (d + r) * M := by
  have hM0 : M ≠ 0 := by
    rintro rfl
    norm_num at hM
  exact Nat.mul_pos (by positivity) (Nat.pos_of_ne_zero hM0)

/-- The generic grid denominator is prime to the hexadecimal base. -/
private theorem grid_den_coprime16 (M r d : ℕ) (hM : M.Coprime 34) :
    Nat.Coprime 16 (17 ^ (d + r) * M) := by
  have hM2 : M.Coprime 2 := Nat.Coprime.of_dvd_right (by norm_num : 2 ∣ 34) hM
  have h16M : Nat.Coprime 16 M := by
    simpa only [show (2 : ℕ) ^ 4 = 16 by norm_num] using hM2.symm.pow_left 4
  exact ((by norm_num : Nat.Coprime 16 17).pow_right (d + r)).mul_right h16M

/-- Every grid translate of every complete-period point is still in that complete period. -/
theorem orbitSet_grid_invariant (M r d a : ℕ) (hM : M.Coprime 34) (hr : 1 ≤ r)
    (hb : ∀ p : ℕ, p.Prime → p ∣ M → (p - 1).factorization 17 ≤ r - 1)
    (ha : a.Coprime (17 ^ (d + r) * M)) (j : ℕ) (x : ℝ)
    (hx : x ∈ orbitSet a (17 ^ (d + r) * M)) :
    Int.fract (x + (j : ℝ) / (17 : ℝ) ^ d) ∈ orbitSet a (17 ^ (d + r) * M) := by
  have hq := grid_den_pos M r d hM
  have h16 := grid_den_coprime16 M r d hM
  obtain ⟨s, rfl⟩ := (mem_orbitSet_iff a (17 ^ (d + r) * M) hq h16 x).mp hx
  have h17q : 17 ∣ 17 ^ (d + r) * M :=
    dvd_mul_of_dvd_left (dvd_pow_self 17 (by omega : d + r ≠ 0)) M
  have ha17 : a.Coprime 17 := Nat.Coprime.of_dvd_right h17q ha
  have hs17 : (16 ^ s * a).Coprime 17 :=
    ((by norm_num : Nat.Coprime 16 17).pow_left s).mul_left ha17
  obtain ⟨t, ht⟩ := PiDisjunctivity.PrimeGrid17.rationalGrid17 M r d (16 ^ s * a) j hM hr hb hs17
  apply (mem_orbitSet_iff a (17 ^ (d + r) * M) hq h16 _).mpr
  refine ⟨t + s, ?_⟩
  dsimp only [orbitPoint]
  rw [Int.fract_fract_add]
  push_cast at ht
  simpa only [pow_add, Nat.cast_mul, Nat.cast_pow, Nat.cast_ofNat,
    mul_div_assoc, mul_assoc] using ht

/-- Complete-period exponent counts satisfy the strict grid discrepancy bound. -/
theorem rational_period_grid_discrepancy (M r d a : ℕ) (hM : M.Coprime 34) (hr : 1 ≤ r)
    (hb : ∀ p : ℕ, p.Prime → p ∣ M → (p - 1).factorization 17 ≤ r - 1)
    (ha : a.Coprime (17 ^ (d + r) * M))
    (u v : ℝ) (hu : 0 ≤ u) (huv : u ≤ v) (hv : v ≤ 1) :
    |(((Finset.range (orderOf (16 : ZMod (17 ^ (d + r) * M)))).filter
        (fun t => orbitPoint a (17 ^ (d + r) * M) t ∈ Set.Ico u v)).card : ℝ) /
      (orderOf (16 : ZMod (17 ^ (d + r) * M)) : ℝ) - (v - u)| < 1 / (17 : ℝ) ^ d := by
  have hq := grid_den_pos M r d hM
  have h16 := grid_den_coprime16 M r d hM
  have hSne : (orbitSet a (17 ^ (d + r) * M)).Nonempty :=
    ⟨orbitPoint a (17 ^ (d + r) * M) 0, orbitPoint_mem_orbitSet a (17 ^ (d + r) * M) 0 hq h16⟩
  have hS : ∀ x ∈ orbitSet a (17 ^ (d + r) * M), x ∈ Set.Ico (0 : ℝ) 1 :=
    fun _ hx => orbitSet_subset_Ico a (17 ^ (d + r) * M) hx
  have hinv : ∀ (j : ℕ), j < 17 ^ d → ∀ x ∈ orbitSet a (17 ^ (d + r) * M),
      Int.fract (x + (j : ℝ) / ((17 ^ d : ℕ) : ℝ)) ∈ orbitSet a (17 ^ (d + r) * M) := by
    intro j _ x hx
    simpa only [Nat.cast_pow, Nat.cast_ofNat] using
      orbitSet_grid_invariant M r d a hM hr hb ha j x hx
  have h := PiDisjunctivity.finiteCircle_grid_discrepancy (orbitSet a (17 ^ (d + r) * M)) hSne
    (17 ^ d) (by positivity) hS hinv u v hu huv hv
  unfold PiDisjunctivity.finiteIcoCount at h
  rw [orbitSet_filter_card a (17 ^ (d + r) * M) hq ha,
    orbitSet_card a (17 ^ (d + r) * M) hq ha] at h
  simpa only [Nat.cast_pow, Nat.cast_ofNat] using h


/-- Explicit real complete-period contract, including positivity of its period. -/
theorem rational_period_grid_contract (M r d a : ℕ) (hM : M.Coprime 34) (hr : 1 ≤ r)
    (hb : ∀ p : ℕ, p.Prime → p ∣ M → (p - 1).factorization 17 ≤ r - 1)
    (ha : a.Coprime (17 ^ (d + r) * M))
    (u v : ℝ) (hu : 0 ≤ u) (huv : u ≤ v) (hv : v ≤ 1) :
    let q : ℕ := 17 ^ (d + r) * M
    let P : ℕ := orderOf (16 : ZMod q)
    0 < P ∧
      |(((Finset.range P).filter
          (fun t => Int.fract ((16 : ℝ) ^ t * ((a : ℝ) / q)) ∈ Set.Ico u v)).card : ℝ) /
        (P : ℝ) - (v - u)| < 1 / (17 : ℝ) ^ d := by
  refine ⟨period_pos _ (grid_den_coprime16 M r d hM), ?_⟩
  have hf : ((Finset.range (orderOf (16 : ZMod (17 ^ (d + r) * M)))).filter
        (fun t => Int.fract ((16 : ℝ) ^ t * ((a : ℝ) / (17 ^ (d + r) * M : ℕ))) ∈ Set.Ico u v)) =
      ((Finset.range (orderOf (16 : ZMod (17 ^ (d + r) * M)))).filter
        (fun t => orbitPoint a (17 ^ (d + r) * M) t ∈ Set.Ico u v)) := by
    apply Finset.filter_congr
    intro t _
    rfl
  rw [hf]
  exact rational_period_grid_discrepancy M r d a hM hr hb ha u v hu huv hv

end PiDisjunctivity.RationalHexOrbit
