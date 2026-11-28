/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module
public import PiDisjunctivity.Cylinders
import Mathlib.Tactic

/-! Finite hexadecimal interval discrepancy forces occurrence of every word of a fixed length. -/

public section
namespace PiDisjunctivity

/-- The interval count among the first P shifts of the existing hexadecimal orbit. -/
@[expose] noncomputable def hexadecimalPrefixIcoCount (x : ℝ) (P : ℕ) (u v : ℝ) : ℕ := by
  classical
  exact ((Finset.range P).filter
    (fun t : ℕ => Int.fract ((16 : ℝ) ^ t * x) ∈ Set.Ico u v)).card

/-- A fixed word occurs before P when the finite-window discrepancy is smaller than its cylinder. -/
theorem word_occurs_before_of_discrepancy (x : ℝ) (hx : 0 ≤ x)
    (P : ℕ) (hP : 0 < P) (w : ℕ) (epsilon : ℝ)
    (hepsilon : epsilon < 1 / (16 : ℝ) ^ w)
    (hdisc : ∀ u v : ℝ, 0 ≤ u → u < v → v ≤ 1 →
      |(hexadecimalPrefixIcoCount x P u v : ℝ) / (P : ℝ) - (v - u)| ≤ epsilon)
    (s : Fin w → Fin 16) :
    ∃ t < P, ∀ i : Fin w, baseDigit 16 x (t + i.val) = (s i).val := by
  classical
  let lower : ℝ := (blockValue w s : ℝ) / (16 : ℝ) ^ w
  let upper : ℝ := ((blockValue w s : ℝ) + 1) / (16 : ℝ) ^ w
  have hpow : 0 < (16 : ℝ) ^ w := by positivity
  have hlower : 0 ≤ lower := div_nonneg (Nat.cast_nonneg _) hpow.le
  have hlt : lower < upper := by
    apply (div_lt_div_iff_of_pos_right hpow).mpr
    linarith
  have hupper : upper ≤ 1 := by
    apply (div_le_iff₀ hpow).mpr
    rw [one_mul]
    exact_mod_cast Nat.succ_le_of_lt (blockValue_lt w s)
  have hwidth : upper - lower = 1 / (16 : ℝ) ^ w := by
    dsimp [upper, lower]
    ring
  have hd := (abs_le.mp (hdisc lower upper hlower hlt hupper)).1
  have hcdiv : 0 < (hexadecimalPrefixIcoCount x P lower upper : ℝ) / (P : ℝ) := by
    linarith
  have hPR : 0 < (P : ℝ) := by exact_mod_cast hP
  have hcR : 0 < (hexadecimalPrefixIcoCount x P lower upper : ℝ) := by
    have h := mul_pos hcdiv hPR
    rw [div_mul_cancel₀ _ hPR.ne'] at h
    exact h
  have hc : 0 < hexadecimalPrefixIcoCount x P lower upper := by exact_mod_cast hcR
  unfold hexadecimalPrefixIcoCount at hc
  obtain ⟨t, ht⟩ := Finset.card_pos.mp hc
  obtain ⟨htP, htI⟩ := Finset.mem_filter.mp ht
  exact ⟨t, Finset.mem_range.mp htP, (block_iff_mem_interval x hx t w s).mpr htI⟩

/-- Taking d=w+1 makes the 17-adic grid mesh strictly smaller than a hexadecimal w-cylinder. -/
theorem grid17_mesh_lt_cylinder (w : ℕ) :
    1 / (17 : ℝ) ^ (w + 1) < 1 / (16 : ℝ) ^ w := by
  apply one_div_lt_one_div_of_lt (by positivity)
  calc
    (16 : ℝ) ^ w ≤ (17 : ℝ) ^ w := pow_le_pow_left₀ (by norm_num) (by norm_num) w
    _ < (17 : ℝ) ^ (w + 1) := pow_lt_pow_right₀ (by norm_num) (by omega)

/-- The positive grid parameter can be selected after fixing the word length. -/
theorem exists_grid17_mesh_lt_cylinder (w : ℕ) :
    ∃ d : ℕ, 0 < d ∧ 1 / (17 : ℝ) ^ d < 1 / (16 : ℝ) ^ w := by
  exact ⟨w + 1, by omega, grid17_mesh_lt_cylinder w⟩

/-- Fixed-length word consumer for the explicit mesh d=w+1. -/
theorem word_occurs_before_of_grid17_discrepancy (x : ℝ) (hx : 0 ≤ x)
    (P : ℕ) (hP : 0 < P) (w : ℕ)
    (hdisc : ∀ u v : ℝ, 0 ≤ u → u < v → v ≤ 1 →
      |(hexadecimalPrefixIcoCount x P u v : ℝ) / (P : ℝ) - (v - u)| ≤ 1 / (17 : ℝ) ^ (w + 1))
    (s : Fin w → Fin 16) :
    ∃ t < P, ∀ i : Fin w, baseDigit 16 x (t + i.val) = (s i).val := by
  exact word_occurs_before_of_discrepancy x hx P hP w _ (grid17_mesh_lt_cylinder w) hdisc s


/-- Boundary instantiation through the consumer: the length-zero word is included. -/
theorem empty_word_occurs_before_of_discrepancy (x : ℝ) (hx : 0 ≤ x)
    (P : ℕ) (hP : 0 < P) (epsilon : ℝ) (hepsilon : epsilon < 1)
    (hdisc : ∀ u v : ℝ, 0 ≤ u → u < v → v ≤ 1 →
      |(hexadecimalPrefixIcoCount x P u v : ℝ) / (P : ℝ) - (v - u)| ≤ epsilon)
    (s : Fin 0 → Fin 16) :
    ∃ t < P, ∀ i : Fin 0, baseDigit 16 x (t + i.val) = (s i).val := by
  exact word_occurs_before_of_discrepancy x hx P hP 0 epsilon
    (by simpa only [pow_zero, div_one] using hepsilon) hdisc s

/-- Boundary instantiation through the consumer: a word of zeros retains its full length. -/
theorem zero_word_occurs_before_of_discrepancy (x : ℝ) (hx : 0 ≤ x)
    (P : ℕ) (hP : 0 < P) (w : ℕ) (epsilon : ℝ)
    (hepsilon : epsilon < 1 / (16 : ℝ) ^ w)
    (hdisc : ∀ u v : ℝ, 0 ≤ u → u < v → v ≤ 1 →
      |(hexadecimalPrefixIcoCount x P u v : ℝ) / (P : ℝ) - (v - u)| ≤ epsilon) :
    ∃ t < P, ∀ i : Fin w, baseDigit 16 x (t + i.val) = 0 := by
  simpa only [Fin.val_zero] using
    word_occurs_before_of_discrepancy x hx P hP w epsilon hepsilon hdisc (fun _ => 0)

end PiDisjunctivity
