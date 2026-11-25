/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.Definitions
public import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Tactic

/-! The recursive hexadecimal word value agrees with its big-endian finite sum. -/

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

end PiDisjunctivity
