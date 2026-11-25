/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.Cylinders
public import PiDisjunctivity.Conjectures
import Mathlib.Tactic

/-! Interval-hitting criteria and conditional transfer, leaving the missing π hypothesis visible. -/

public section

namespace PiDisjunctivity

/-- Vanishing signed errors preserve interval hitting when the original visits occur arbitrarily
late. Only the chosen visit needs to lie in `[0,1)`; no global range hypothesis is required. -/
theorem hitsOpenIntervals_fract_add_of_tendsto_zero (u r : ℕ → ℝ)
    (hr : Filter.Tendsto r Filter.atTop (nhds 0))
    (hu : ∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∀ N : ℕ, ∃ n ≥ N, u n ∈ Set.Ioo a b) :
    ∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∃ n : ℕ, Int.fract (u n + r n) ∈ Set.Ioo a b := by
  intro a b ha hab hb
  let δ := (b - a) / 4
  have hδ : 0 < δ := by dsimp [δ]; linarith
  obtain ⟨N, hN⟩ := Metric.tendsto_atTop.mp hr δ hδ
  obtain ⟨n, hn, hlo, hhi⟩ := hu (a + δ) (b - δ)
    (by linarith) (by dsimp [δ]; linarith) (by linarith) N
  have herr : |r n| < δ := by simpa only [Real.dist_eq, sub_zero] using hN n hn
  obtain ⟨hrlo, hrhi⟩ := abs_lt.mp herr
  have hinside : u n + r n ∈ Set.Ioo a b := ⟨by linarith, by linarith⟩
  refine ⟨n, ?_⟩
  rw [Int.fract_eq_self.mpr ⟨by linarith [hinside.1], by linarith [hinside.2]⟩]
  exact hinside

/-- Hitting every open interval inside `[0,1]` suffices to hit every hexadecimal cell.
This includes length zero and the first and last cells, with no range hypothesis on `t`. -/
theorem hitsHexadecimalIntervals_of_hitsOpenIntervals (t : ℕ → ℝ)
    (ht : ∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
      ∃ n : ℕ, t n ∈ Set.Ioo a b) :
    ∀ k m : ℕ, m < 16 ^ k → ∃ n : ℕ,
      t n ∈ Set.Ico ((m : ℝ) / (16 : ℝ) ^ k)
        (((m : ℝ) + 1) / (16 : ℝ) ^ k) := by
  intro k m hm
  have hp : 0 < (16 : ℝ) ^ k := by positivity
  have hlower : 0 ≤ (m : ℝ) / (16 : ℝ) ^ k := div_nonneg (Nat.cast_nonneg _) hp.le
  have hwidth : (m : ℝ) / (16 : ℝ) ^ k < ((m : ℝ) + 1) / (16 : ℝ) ^ k := by
    apply (div_lt_div_iff_of_pos_right hp).2
    linarith
  have hupper : ((m : ℝ) + 1) / (16 : ℝ) ^ k ≤ 1 := by
    apply (div_le_iff₀ hp).2
    rw [one_mul]
    exact_mod_cast Nat.succ_le_of_lt hm
  obtain ⟨n, hlo, hhi⟩ := ht _ _ hlower hwidth hupper
  exact ⟨n, hlo.le, hhi⟩

/-- Disjunctivity is equivalent to hitting every hexadecimal cell, including the length-zero cell.
The length `k` is retained even when the value `m` has leading-zero padding. -/
theorem isDisjunctive_iff_hitsHexadecimalIntervals (x : ℝ) (hx : 0 ≤ x) :
    IsDisjunctive 16 x ↔
      ∀ (k m : ℕ), m < 16 ^ k → ∃ n : ℕ,
        Int.fract ((16 : ℝ) ^ n * x) ∈
          Set.Ico ((m : ℝ) / (16 : ℝ) ^ k) (((m : ℝ) + 1) / (16 : ℝ) ^ k) := by
  constructor
  · intro h k m hm
    obtain ⟨s, hs⟩ := exists_blockValue_eq k m hm
    obtain ⟨n, hn⟩ := h k s
    refine ⟨n, ?_⟩
    simpa only [hs] using (block_iff_mem_interval x hx n k s).mp hn
  · intro h k s
    obtain ⟨n, hn⟩ := h k (blockValue k s) (blockValue_lt k s)
    exact ⟨n, (block_iff_mem_interval x hx n k s).mpr hn⟩

/-- Interval hitting would imply the conjecture. The hitting hypothesis remains unproved for π. -/
theorem piHexadecimalDisjunctivity_of_hitsHexadecimalIntervals
    (h : ∀ (k m : ℕ), m < 16 ^ k → ∃ n : ℕ,
      Int.fract ((16 : ℝ) ^ n * Real.pi) ∈
        Set.Ico ((m : ℝ) / (16 : ℝ) ^ k) (((m : ℝ) + 1) / (16 : ℝ) ^ k)) :
    PiHexadecimalDisjunctivity :=
  (isDisjunctive_iff_hitsHexadecimalIntervals Real.pi Real.pi_pos.le).mpr h

end PiDisjunctivity
