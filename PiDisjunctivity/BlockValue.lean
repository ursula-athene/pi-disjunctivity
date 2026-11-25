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

/-! Positional values, bounds, coverage, and uniqueness for fixed-length hexadecimal words. -/

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

/-- A hexadecimal word is determined by its value when its length is fixed. -/
theorem blockValue_injective (k : ℕ) :
    Function.Injective (blockValue k) := by
  induction k with
  | zero =>
    intro s t _
    funext i
    exact Fin.elim0 i
  | succ k ih =>
    intro s t h
    change 16 * blockValue k (fun i => s i.castSucc) + (s (Fin.last k)).val =
      16 * blockValue k (fun i => t i.castSucc) + (t (Fin.last k)).val at h
    have hlast : (s (Fin.last k)).val = (t (Fin.last k)).val := by
      have hmod := congrArg (fun m : ℕ => m % 16) h
      simpa only [Nat.add_mod, Nat.mul_mod_right, Nat.zero_add, Nat.mod_mod,
        Nat.mod_eq_of_lt (s (Fin.last k)).isLt,
        Nat.mod_eq_of_lt (t (Fin.last k)).isLt] using hmod
    have hp : blockValue k (fun i => s i.castSucc) =
        blockValue k (fun i => t i.castSucc) := by
      have hdiv := congrArg (fun m : ℕ => m / 16) h
      simpa only [Nat.mul_add_div (by decide : 0 < 16), Nat.add_zero,
        Nat.div_eq_of_lt (s (Fin.last k)).isLt,
        Nat.div_eq_of_lt (t (Fin.last k)).isLt] using hdiv
    have hprefix := ih hp
    funext i
    exact Fin.lastCases (Fin.ext hlast) (fun j => congrFun hprefix j) i

end PiDisjunctivity
