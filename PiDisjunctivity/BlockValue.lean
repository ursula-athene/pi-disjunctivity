/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.Definitions
public import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Fin.Tuple.Basic
import Mathlib.Tactic

/-! Hexadecimal word values agree with the positional sum and range over `[0, 16 ^ k)`. -/

public section

namespace PiDisjunctivity

/-- The recursive value of a word is its positional, big-endian finite sum. -/
theorem blockValue_eq_sum (k : ℕ) (s : Fin k → Fin 16) :
    blockValue k s =
      ∑ i : Fin k, (s i).val * 16 ^ (k - 1 - i.val) := by
  induction k with
  | zero => simp [blockValue]
  | succ k ih =>
    rw [blockValue, ih, Fin.sum_univ_castSucc]
    simp only [Fin.val_castSucc, Fin.val_last, Nat.add_sub_cancel,
      Nat.sub_self, pow_zero, mul_one]
    rw [Finset.mul_sum]
    congr 1
    apply Finset.sum_congr rfl
    intro i _
    have hi : k - i.val = k - 1 - i.val + 1 := by
      have := i.isLt
      omega
    rw [hi, pow_succ]
    ac_rfl

/-- Every length-`k` hexadecimal word has value below `16 ^ k`. -/
theorem blockValue_lt (k : ℕ) (s : Fin k → Fin 16) :
    blockValue k s < 16 ^ k := by
  induction k with
  | zero => simp [blockValue]
  | succ k ih =>
    have hp := ih (fun i => s i.castSucc)
    have hd := (s (Fin.last k)).isLt
    rw [blockValue, pow_succ]
    omega

/-- Every value below `16 ^ k` has a length-`k` word, including leading-zero padding. -/
theorem exists_blockValue_eq (k m : ℕ) (hm : m < 16 ^ k) :
    ∃ s : Fin k → Fin 16, blockValue k s = m := by
  induction k generalizing m with
  | zero =>
    have hm0 : m = 0 := by simpa using hm
    exact ⟨Fin.elim0, hm0.symm⟩
  | succ k ih =>
    have hq : m / 16 < 16 ^ k := by
      apply (Nat.div_lt_iff_lt_mul (by decide)).2
      simpa only [pow_succ] using hm
    obtain ⟨s, hs⟩ := ih (m / 16) hq
    let d : Fin 16 := ⟨m % 16, Nat.mod_lt _ (by decide)⟩
    refine ⟨Fin.snoc s d, ?_⟩
    rw [blockValue]
    -- The first `k` positions recover `s`; the last position is the remainder digit.
    simp only [Fin.snoc_castSucc, Fin.snoc_last, hs]
    exact Nat.div_add_mod m 16

end PiDisjunctivity
