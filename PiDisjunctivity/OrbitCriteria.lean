/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.Cylinders
public import PiDisjunctivity.Conjectures

/-! An explicit interval-hitting criterion, leaving the missing hypothesis about π visible. -/

public section

namespace PiDisjunctivity

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
