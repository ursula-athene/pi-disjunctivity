/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.BBP.DyadicGrid
public import PiDisjunctivity.BBP.DyadicTailShadow
import Mathlib.Tactic

/-! Common dyadic grid/shadow anchors and the exact conditional finite-hit transfer. -/
public section
namespace PiDisjunctivity.BBPAsymptotics

theorem arbitrarily_large_dyadic_grid_shadows (d B : ℕ) (hd : 0 < d) :
    ∃ s : ℕ, B < s ∧ 128 ≤ s ∧
      0 < orderOf (16 : ZMod (bbpPartialSumRat (2 ^ s)).den) ∧
      (∀ m : ℕ, ∃ t < orderOf (16 : ZMod (bbpPartialSumRat (2 ^ s)).den),
        Int.fract ((16 : ℝ) ^ t * (bbpPartialSumRat (2 ^ s) : ℝ)) =
          Int.fract ((bbpPartialSumRat (2 ^ s) : ℝ) + m / (17 : ℝ) ^ d)) ∧
      (∀ u v : ℝ, 0 ≤ u → u ≤ v → v ≤ 1 →
        |(hexadecimalPrefixIcoCount (bbpPartialSumRat (2 ^ s) : ℝ)
            (orderOf (16 : ZMod (bbpPartialSumRat (2 ^ s)).den)) u v : ℝ) /
          (orderOf (16 : ZMod (bbpPartialSumRat (2 ^ s)).den) : ℝ) - (v - u)| <
          1 / (17 : ℝ) ^ d) ∧
      (∀ h v : ℕ, 1 ≤ h →
        h ≤ ⌊(s : ℝ) / (16 * Real.logb 2 ((s : ℝ) + 2))⌋₊ → v ≤ s / 16 →
        ∃ (z : ℤ) (ε : ℝ),
          (16 : ℝ) ^ (h * (s + 3) + v) * bbpTail (2 ^ s) = (z : ℝ) - ε ∧
          0 < ε ∧ ε < (2 : ℝ) ^ (-(s : ℝ) / 4)) := by
  obtain ⟨s, r, hs, hr, hcong, hlo, hhi⟩ := bbpNearby_exists_dyadic_anchor d (max B 127) hd
  have hsB : B < s := lt_of_le_of_lt (le_max_left B 127) hs
  have hs128 : 128 ≤ s := by have := lt_of_le_of_lt (le_max_right B 127) hs; omega
  refine ⟨s, hsB, hs128, bbpPartialSumRat_period_pos _, ?_, ?_, ?_⟩
  · intro m
    exact bbpNearby_prefix_grid_in_period d r (2 ^ s) m hd hr hcong hlo hhi
  · intro u v hu huv hv
    exact bbpNearby_prefix_discrepancy d r (2 ^ s) hd hr hcong hlo hhi u v hu huv hv
  · intro h v hh hsize hv
    exact dyadic_tail_shadow s h v (by omega) hh hsize hv

/-- Total margin for the modular tail error and the later actual BBP tail. -/
@[expose] noncomputable def dyadicShadowError (s : ℕ) : ℝ :=
  (2 : ℝ) ^ (-(s : ℝ) / 4) + 1 / (64 * (((2 ^ s : ℕ) : ℝ) ^ 2))

theorem dyadic_frozen_prefix_hit_transfer (s h v j : ℕ)
    (hs : 32 ≤ s) (hh : 1 ≤ h)
    (hsize : h ≤ ⌊(s : ℝ) / (16 * Real.logb 2 ((s : ℝ) + 2))⌋₊)
    (hv : v ≤ s / 16) (hj : j = h * (s + 3) + v)
    (a b : ℝ) (ha : 0 ≤ a) (_hab : a < b) (hb : b ≤ 1)
    (hvisit : Int.fract ((16 : ℝ) ^ j * (bbpPartialSumRat (2 ^ s) : ℝ)) ∈
      Set.Ioo (a + dyadicShadowError s) b) :
    bbpRecurrence (2 ^ s + j + 1) ∈ Set.Ioo a b := by
  let N : ℕ := 2 ^ s
  have hN : 0 < N := by dsimp [N]; positivity
  obtain ⟨z, ε, heq, hε, hεb⟩ := dyadic_tail_shadow s h v hs hh hsize hv
  rw [← hj] at heq
  change (16 : ℝ) ^ j * bbpTail N = (z : ℝ) - ε at heq
  have htpos : 0 < bbpTail (N + j) := bbpTail_pos _
  have htb : bbpTail (N + j) ≤ 1 / (64 * (N : ℝ) ^ 2) := by
    apply (bbpTail_le_mass_bound (N + j) (by omega)).trans
    apply div_le_div_of_nonneg_left (by norm_num) (by positivity)
    apply mul_le_mul_of_nonneg_left _ (by norm_num)
    apply pow_le_pow_left₀ (by positivity)
    exact_mod_cast Nat.le_add_right N j
  let η : ℝ := ε + bbpTail (N + j)
  have hηpos : 0 < η := add_pos hε htpos
  have hηb : η < dyadicShadowError s := by
    dsimp [η, dyadicShadowError, N] at *
    linarith
  have hprefix : bbpPartialSum (N + j) =
      (16 : ℝ) ^ j * bbpPartialSum N + (z : ℝ) - η := by
    calc
      bbpPartialSum (N + j) = (16 : ℝ) ^ (N + j) * Real.pi - bbpTail (N + j) := by
        have h := pow_mul_pi_eq_bbpPartialSum_add_bbpTail (N + j)
        linarith
      _ = (16 : ℝ) ^ j * ((16 : ℝ) ^ N * Real.pi) - bbpTail (N + j) := by
        rw [pow_add]
        ring
      _ = _ := by
        rw [pow_mul_pi_eq_bbpPartialSum_add_bbpTail N, mul_add, heq]
        dsimp [η]
        ring
  rw [cast_bbpPartialSumRat] at hvisit
  change Int.fract ((16 : ℝ) ^ j * bbpPartialSum N) ∈ Set.Ioo (a + dyadicShadowError s) b at hvisit
  have hlo : a < Int.fract ((16 : ℝ) ^ j * bbpPartialSum N) - η := by
    have h := hvisit.1
    linarith
  have hhi : Int.fract ((16 : ℝ) ^ j * bbpPartialSum N) - η < b := by
    have h := hvisit.2
    linarith
  have hfract : Int.fract ((16 : ℝ) ^ j * bbpPartialSum N + (z : ℝ) - η) =
      Int.fract ((16 : ℝ) ^ j * bbpPartialSum N) - η := by
    apply Int.fract_eq_iff.mpr
    refine ⟨by linarith, by linarith, ⌊(16 : ℝ) ^ j * bbpPartialSum N⌋ + z, ?_⟩
    rw [Int.fract]
    push_cast
    ring
  change bbpRecurrence (N + j + 1) ∈ Set.Ioo a b
  rw [bbpRecurrence_succ_eq_fract_bbpPartialSum, hprefix, hfract]
  exact ⟨hlo, hhi⟩

end PiDisjunctivity.BBPAsymptotics
