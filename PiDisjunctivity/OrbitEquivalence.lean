/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.Cylinders
public import PiDisjunctivity.Conjectures
import Mathlib.Tactic

/-! Equivalence of hexadecimal disjunctivity and the full orbit closure for nonnegative reals. -/

public section

namespace PiDisjunctivity

private theorem exists_hexadecimal_cell (k : ℕ) (t : ℝ) (ht : t ∈ Set.Icc (0 : ℝ) 1) :
    ∃ m : ℕ, m < 16 ^ k ∧
      t ∈ Set.Icc ((m : ℝ) / (16 : ℝ) ^ k) (((m : ℝ) + 1) / (16 : ℝ) ^ k) := by
  have hp : 0 < (16 : ℝ) ^ k := by positivity
  by_cases ht1 : t = 1
  · subst t
    have hn : 0 < (16 : ℕ) ^ k := by positivity
    have hlast : ((16 ^ k - 1 : ℕ) : ℝ) + 1 = (16 : ℝ) ^ k := by
      have hnat : (16 : ℕ) ^ k - 1 + 1 = 16 ^ k := by omega
      exact_mod_cast hnat
    refine ⟨16 ^ k - 1, by omega, ?_, ?_⟩
    · apply (div_le_iff₀ hp).2
      rw [one_mul]
      linarith
    · rw [hlast, div_self hp.ne']
  · have htlt : t < 1 := lt_of_le_of_ne ht.2 ht1
    have hnonneg : 0 ≤ (16 : ℝ) ^ k * t := mul_nonneg hp.le ht.1
    refine ⟨Nat.floor ((16 : ℝ) ^ k * t), ?_, ?_, ?_⟩
    · apply (Nat.floor_lt hnonneg).2
      simpa only [Nat.cast_pow, Nat.cast_ofNat] using mul_lt_of_lt_one_right hp htlt
    · apply (div_le_iff₀ hp).2
      simpa only [mul_comm] using Nat.floor_le hnonneg
    · apply (le_div_iff₀ hp).2
      simpa only [mul_comm] using (Nat.lt_floor_add_one ((16 : ℝ) ^ k * t)).le

/-- Hexadecimal disjunctivity is equivalent to having orbit closure `[0,1]`. -/
theorem isDisjunctive_iff_orbitClosure (x : ℝ) (hx : 0 ≤ x) :
    IsDisjunctive 16 x ↔
      closure (hexadecimalOrbit x) = Set.Icc (0 : ℝ) 1 := by
  constructor
  · intro hdisj
    apply Set.Subset.antisymm
    · apply closure_minimal ?_ isClosed_Icc
      rintro y ⟨n, rfl⟩
      exact ⟨Int.fract_nonneg _, (Int.fract_lt_one _).le⟩
    · intro t ht
      apply Metric.mem_closure_iff.mpr
      intro ε hε
      obtain ⟨k, hk⟩ := exists_pow_lt_of_lt_one hε (by norm_num : (1 / 16 : ℝ) < 1)
      have hwidth : 1 / (16 : ℝ) ^ k < ε := by simpa only [one_div_pow] using hk
      obtain ⟨m, hm, htlo, hthi⟩ := exists_hexadecimal_cell k t ht
      obtain ⟨s, hs⟩ := exists_blockValue_eq k m hm
      obtain ⟨n, hn⟩ := hdisj k s
      have hz : Int.fract ((16 : ℝ) ^ n * x) ∈
          Set.Ico ((m : ℝ) / (16 : ℝ) ^ k) (((m : ℝ) + 1) / (16 : ℝ) ^ k) := by
        simpa only [hs] using (block_iff_mem_interval x hx n k s).mp hn
      refine ⟨Int.fract ((16 : ℝ) ^ n * x), ⟨n, rfl⟩, ?_⟩
      have hcell : ((m : ℝ) + 1) / (16 : ℝ) ^ k - (m : ℝ) / (16 : ℝ) ^ k =
          1 / (16 : ℝ) ^ k := by ring
      rw [Real.dist_eq, abs_lt]
      constructor <;> linarith only [htlo, hthi, hz.1, hz.2, hwidth, hcell]
  · intro hclosure k s
    let lower : ℝ := (blockValue k s : ℝ) / (16 : ℝ) ^ k
    let upper : ℝ := ((blockValue k s : ℝ) + 1) / (16 : ℝ) ^ k
    have hp : 0 < (16 : ℝ) ^ k := by positivity
    have hlower : 0 ≤ lower := div_nonneg (Nat.cast_nonneg _) hp.le
    have hwidth : lower < upper := by
      apply (div_lt_div_iff_of_pos_right hp).2
      linarith
    have hupper : upper ≤ 1 := by
      apply (div_le_iff₀ hp).2
      rw [one_mul]
      exact_mod_cast Nat.succ_le_of_lt (blockValue_lt k s)
    have hmid : (lower + upper) / 2 ∈ closure (hexadecimalOrbit x) := by
      rw [hclosure]
      constructor <;> linarith
    have hinside : (lower + upper) / 2 ∈ Set.Ioo lower upper := by
      constructor <;> linarith
    obtain ⟨y, hy, hyorbit⟩ := mem_closure_iff.mp hmid (Set.Ioo lower upper) isOpen_Ioo hinside
    obtain ⟨n, rfl⟩ := hyorbit
    refine ⟨n, (block_iff_mem_interval x hx n k s).mpr ?_⟩
    exact ⟨hy.1.le, hy.2⟩

/-- The two conjecture statements about π agree; this does not assert either conjecture. -/
theorem piHexadecimalDisjunctivity_iff_orbitClosure :
    PiHexadecimalDisjunctivity ↔ PiHexadecimalOrbitClosure :=
  isDisjunctive_iff_orbitClosure Real.pi Real.pi_pos.le

end PiDisjunctivity
