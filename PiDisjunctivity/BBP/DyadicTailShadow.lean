/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.BBP.TailAsymptotics
public import Mathlib.Analysis.SpecialFunctions.Log.Base
import Mathlib.Tactic

/-! Integer cancellation and small modular errors at explicit dyadic BBP anchors. -/
public section
namespace PiDisjunctivity.BBPAsymptotics

theorem correction_integer (N K : ℕ) (hN : 0 < N) :
    ∃ z : ℤ, (8 * (N : ℝ)) ^ (K + 1) * correction K N = (z : ℝ) := by
  choose B hB using coefficient_dyadic
  refine ⟨∑ k ∈ Finset.range K, B k * (8 * (N : ℤ)) ^ (K + 1 - (k + 2)), ?_⟩
  unfold correction
  rw [Finset.mul_sum]
  push_cast
  apply Finset.sum_congr rfl
  intro k hk
  have hkn : k + 2 ≤ K + 1 := by have := Finset.mem_range.mp hk; omega
  have hn0 : 8 * (N : ℝ) ≠ 0 := by positivity
  have he : K - (k + 1) = K + 1 - (k + 2) := by omega
  rw [hB k, he, pow_sub₀ _ hn0 hkn, mul_pow]
  ring

private theorem dyadic_scale (s h : ℕ) :
    (16 : ℝ) ^ (h * (s + 3)) = (8 * ((2 ^ s : ℕ) : ℝ)) ^ (4 * h) := by
  push_cast
  have h8 : (8 : ℝ) = 2 ^ 3 := by norm_num
  have h16 : (16 : ℝ) = 2 ^ 4 := by norm_num
  rw [h8, h16, ← pow_add, ← pow_mul, ← pow_mul]
  congr 1
  ring

theorem dyadic_tail_cancellation (s h : ℕ) (hh : 1 ≤ h) :
    ∃ (z : ℤ) (δ : ℝ),
      (16 : ℝ) ^ (h * (s + 3)) * bbpTail (2 ^ s) = (z : ℝ) - δ ∧
      0 < δ ∧ δ < (8 : ℝ) ^ (4 * h) * (Nat.factorial (4 * h) : ℝ) / (2 : ℝ) ^ s := by
  let N : ℕ := 2 ^ s
  let K : ℕ := 4 * h - 1
  have hN : 0 < N := by dsimp [N]; positivity
  have hK : K + 1 = 4 * h := by dsimp [K]; omega
  have hodd : (-1 : ℝ) ^ K = -1 := by
    have hp : K = 2 * (2 * h - 1) + 1 := by dsimp [K]; omega
    rw [hp, pow_add, pow_mul]
    norm_num
  obtain ⟨z, hz⟩ := correction_integer N K hN
  let d : ℝ := correction K N - bbpTail N
  have hd : 0 < d := by
    have h := remainder_pos N K hN
    rw [hodd] at h
    dsimp [d]
    linarith
  have hdb : d < (Nat.factorial (4 * h) : ℝ) / (N : ℝ) ^ (4 * h + 1) := by
    have hb := remainder_lt_factorial N K hN
    rw [hodd, show K + 2 = 4 * h + 1 by omega, hK] at hb
    dsimp [d]
    linarith
  refine ⟨z, (16 : ℝ) ^ (h * (s + 3)) * d, ?_, mul_pos (by positivity) hd, ?_⟩
  · have hs := dyadic_scale s h
    change (16 : ℝ) ^ (h * (s + 3)) = (8 * (N : ℝ)) ^ (4 * h) at hs
    rw [hK, ← hs] at hz
    dsimp [d, N] at *
    linarith
  · have hb := mul_lt_mul_of_pos_left hdb (by positivity : (0 : ℝ) < (16 : ℝ) ^ (h * (s + 3)))
    apply hb.trans_eq
    rw [dyadic_scale]
    change (8 * (N : ℝ)) ^ (4 * h) * ((Nat.factorial (4 * h) : ℝ) / (N : ℝ) ^ (4 * h + 1)) = _
    rw [mul_pow, pow_succ]
    have hn0 : (N : ℝ) ≠ 0 := by positivity
    have hn : (N : ℝ) = (2 : ℝ) ^ s := by simp [N]
    rw [← hn]
    field_simp

private theorem dyadic_factorial_bound (s h : ℕ) (hs : 32 ≤ s) (hh : 1 ≤ h)
    (hsize : h ≤ ⌊(s : ℝ) / (16 * Real.logb 2 ((s : ℝ) + 2))⌋₊) :
    (8 : ℝ) ^ (4 * h) * (Nat.factorial (4 * h) : ℝ) / (2 : ℝ) ^ s ≤
      (2 : ℝ) ^ (-(s : ℝ) / 2) := by
  have hsR : (32 : ℝ) ≤ s := by exact_mod_cast hs
  have hhR : (1 : ℝ) ≤ h := by exact_mod_cast hh
  have hL : 0 < Real.logb 2 ((s : ℝ) + 2) := Real.logb_pos (by norm_num) (by linarith)
  have hL1 : 1 ≤ Real.logb 2 ((s : ℝ) + 2) := by
    apply (Real.le_logb_iff_rpow_le (by norm_num : (1 : ℝ) < 2) (by positivity)).mpr
    norm_num
  have hfloor := Nat.floor_le
    (show (0 : ℝ) ≤ (s : ℝ) / (16 * Real.logb 2 ((s : ℝ) + 2)) by positivity)
  have hhfloor : (h : ℝ) ≤ (⌊(s : ℝ) / (16 * Real.logb 2 ((s : ℝ) + 2))⌋₊ : ℝ) := by
    exact_mod_cast hsize
  have hhs : (h : ℝ) * (16 * Real.logb 2 ((s : ℝ) + 2)) ≤ s :=
    (le_div_iff₀ (by positivity)).mp (hhfloor.trans hfloor)
  have hhs' : (h : ℝ) ≤ s := by
    nlinarith [mul_nonneg (sub_nonneg.mpr hL1) (Nat.cast_nonneg (α := ℝ) h)]
  have harg : 32 * (h : ℝ) ≤ ((s : ℝ) + 2) ^ 2 := by
    nlinarith [mul_nonneg (sub_nonneg.mpr hsR) (Nat.cast_nonneg (α := ℝ) s)]
  have hl : Real.logb 2 (32 * (h : ℝ)) ≤ 2 * Real.logb 2 ((s : ℝ) + 2) := by
    have h := Real.logb_le_logb_of_le (by norm_num : (1 : ℝ) < 2)
      (by positivity : (0 : ℝ) < 32 * (h : ℝ)) harg
    simpa only [Real.logb_pow, Nat.cast_ofNat] using h
  have hlpow : Real.logb 2 ((32 * (h : ℝ)) ^ (4 * h)) ≤ (s : ℝ) / 2 := by
    rw [Real.logb_pow]
    push_cast
    have hm := mul_le_mul_of_nonneg_left hl (by positivity : (0 : ℝ) ≤ 4 * (h : ℝ))
    nlinarith
  have hpow : (32 * (h : ℝ)) ^ (4 * h) ≤ (2 : ℝ) ^ ((s : ℝ) / 2) :=
    (Real.logb_le_iff_le_rpow (by norm_num : (1 : ℝ) < 2) (by positivity)).mp hlpow
  have hfac : (Nat.factorial (4 * h) : ℝ) ≤ (4 * (h : ℝ)) ^ (4 * h) := by
    exact_mod_cast Nat.factorial_le_pow (4 * h)
  have hnum : (8 : ℝ) ^ (4 * h) * (Nat.factorial (4 * h) : ℝ) ≤ (2 : ℝ) ^ ((s : ℝ) / 2) := by
    calc
      _ ≤ (8 : ℝ) ^ (4 * h) * (4 * (h : ℝ)) ^ (4 * h) :=
        mul_le_mul_of_nonneg_left hfac (by positivity)
      _ = (32 * (h : ℝ)) ^ (4 * h) := by rw [← mul_pow]; congr 1; ring
      _ ≤ _ := hpow
  calc
    _ ≤ (2 : ℝ) ^ ((s : ℝ) / 2) / (2 : ℝ) ^ s :=
      div_le_div_of_nonneg_right hnum (by positivity)
    _ = (2 : ℝ) ^ (-(s : ℝ) / 2) := by
      rw [← Real.rpow_natCast, ← Real.rpow_sub (by norm_num : (0 : ℝ) < 2)]
      congr 1
      ring

theorem dyadic_tail_shadow_base (s h : ℕ) (hs : 32 ≤ s) (hh : 1 ≤ h)
    (hsize : h ≤ ⌊(s : ℝ) / (16 * Real.logb 2 ((s : ℝ) + 2))⌋₊) :
    ∃ (z : ℤ) (δ : ℝ), (16 : ℝ) ^ (h * (s + 3)) * bbpTail (2 ^ s) = (z : ℝ) - δ ∧
      0 < δ ∧ δ < (2 : ℝ) ^ (-(s : ℝ) / 2) := by
  obtain ⟨z, δ, heq, hpos, hb⟩ := dyadic_tail_cancellation s h hh
  exact ⟨z, δ, heq, hpos, hb.trans_le (dyadic_factorial_bound s h hs hh hsize)⟩

private theorem dyadic_block_growth_bound (s v : ℕ) (hv : v ≤ s / 16) :
    (16 : ℝ) ^ v * (2 : ℝ) ^ (-(s : ℝ) / 2) ≤ (2 : ℝ) ^ (-(s : ℝ) / 4) := by
  have hvn : v * 16 ≤ s := (Nat.le_div_iff_mul_le (by decide : 0 < 16)).mp hv
  have hvr : (v : ℝ) * 16 ≤ s := by exact_mod_cast hvn
  have heq : (16 : ℝ) ^ v = (2 : ℝ) ^ (4 * (v : ℝ)) := by
    rw [show (16 : ℝ) = 2 ^ (4 : ℕ) by norm_num, ← pow_mul, ← Real.rpow_natCast]
    congr 1
    push_cast
    ring
  rw [heq, ← Real.rpow_add (by norm_num : (0 : ℝ) < 2)]
  apply Real.rpow_le_rpow_of_exponent_le (by norm_num : (1 : ℝ) ≤ 2)
  linarith

theorem dyadic_tail_shadow (s h v : ℕ) (hs : 32 ≤ s) (hh : 1 ≤ h)
    (hsize : h ≤ ⌊(s : ℝ) / (16 * Real.logb 2 ((s : ℝ) + 2))⌋₊) (hv : v ≤ s / 16) :
    ∃ (z : ℤ) (ε : ℝ),
      (16 : ℝ) ^ (h * (s + 3) + v) * bbpTail (2 ^ s) = (z : ℝ) - ε ∧
      0 < ε ∧ ε < (2 : ℝ) ^ (-(s : ℝ) / 4) := by
  obtain ⟨z, δ, heq, hpos, hb⟩ := dyadic_tail_shadow_base s h hs hh hsize
  refine ⟨(16 : ℤ) ^ v * z, (16 : ℝ) ^ v * δ, ?_, mul_pos (by positivity) hpos, ?_⟩
  · push_cast
    rw [pow_add]
    calc
      (16 : ℝ) ^ (h * (s + 3)) * (16 : ℝ) ^ v * bbpTail (2 ^ s) =
          (16 : ℝ) ^ v * ((16 : ℝ) ^ (h * (s + 3)) * bbpTail (2 ^ s)) := by ring
      _ = _ := by rw [heq]; ring
  · exact (mul_lt_mul_of_pos_left hb (by positivity)).trans_le (dyadic_block_growth_bound s v hv)

theorem dyadic_shadow_h_one_admissible (s : ℕ) (hs : 128 ≤ s) :
    1 ≤ ⌊(s : ℝ) / (16 * Real.logb 2 ((s : ℝ) + 2))⌋₊ := by
  have hsR : (128 : ℝ) ≤ s := by exact_mod_cast hs
  have hL : 0 < Real.logb 2 ((s : ℝ) + 2) := Real.logb_pos (by norm_num) (by linarith)
  have hlog2 : 0 < Real.log (2 : ℝ) := Real.log_pos (by norm_num)
  have hhalf : (1 / 2 : ℝ) ≤ Real.log 2 := by
    have h := Real.one_sub_inv_le_log_of_pos (by norm_num : (0 : ℝ) < 2)
    norm_num at h
    exact h
  have hbase : Real.logb 2 (130 : ℝ) ≤ 8 := by
    apply (Real.logb_le_iff_le_rpow (by norm_num : (1 : ℝ) < 2) (by norm_num)).mpr
    norm_num
  have hratio : Real.log (((s : ℝ) + 2) / 130) ≤ ((s : ℝ) - 128) / 130 := by
    have h := Real.log_le_sub_one_of_pos (by positivity : (0 : ℝ) < ((s : ℝ) + 2) / 130)
    linarith
  have hdiv : Real.log (((s : ℝ) + 2) / 130) / Real.log 2 ≤ ((s : ℝ) - 128) / 65 := by
    calc
      _ ≤ (((s : ℝ) - 128) / 130) / Real.log 2 := div_le_div_of_nonneg_right hratio hlog2.le
      _ ≤ (((s : ℝ) - 128) / 130) / (1 / 2) :=
        div_le_div_of_nonneg_left (by positivity) (by norm_num) hhalf
      _ = _ := by ring
  have heq : Real.logb 2 ((s : ℝ) + 2) =
      Real.logb 2 (130 : ℝ) + Real.log (((s : ℝ) + 2) / 130) / Real.log 2 := by
    unfold Real.logb
    rw [Real.log_div (by positivity : (s : ℝ) + 2 ≠ 0) (by norm_num : (130 : ℝ) ≠ 0)]
    ring
  have hbound : Real.logb 2 ((s : ℝ) + 2) ≤ (s : ℝ) / 16 := by
    rw [heq]
    linarith
  apply (Nat.le_floor_iff (by positivity)).mpr
  norm_num only [Nat.cast_one]
  apply (le_div_iff₀ (by positivity)).mpr
  linarith

theorem dyadic_tail_shadow_first_block (s v : ℕ) (hs : 128 ≤ s) (hv : v ≤ s / 16) :
    ∃ (z : ℤ) (ε : ℝ),
      (16 : ℝ) ^ (s + 3 + v) * bbpTail (2 ^ s) = (z : ℝ) - ε ∧
      0 < ε ∧ ε < (2 : ℝ) ^ (-(s : ℝ) / 4) := by
  simpa only [one_mul] using
    dyadic_tail_shadow s 1 v (by omega) (by decide) (dyadic_shadow_h_one_admissible s hs) hv

end PiDisjunctivity.BBPAsymptotics
