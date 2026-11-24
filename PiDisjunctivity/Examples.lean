module

import PiDisjunctivity.Definitions
import Mathlib.Algebra.Order.Floor.Semifield
import Mathlib.Tactic

/-! Exact rational checks for indexing, leading zeros, and terminating expansions. -/

namespace PiDisjunctivity

example : baseDigit 10 (314159 / 100000 : ℝ) 0 = 1 := by
  norm_num [baseDigit, Nat.floor_div_ofNat]

example : baseDigit 10 (7 / 1000 : ℝ) 0 = 0 ∧
    baseDigit 10 (7 / 1000 : ℝ) 1 = 0 ∧
    baseDigit 10 (7 / 1000 : ℝ) 2 = 7 := by
  norm_num [baseDigit, Nat.floor_div_ofNat]

example : baseDigit 10 (1 / 2 : ℝ) 0 = 5 ∧
    baseDigit 10 (1 / 2 : ℝ) 1 = 0 := by
  norm_num [baseDigit, Nat.floor_div_ofNat]

example (x : ℝ) : ∃ n : ℕ, ∀ i : Fin 0,
    baseDigit 10 x (n + i.val) = (Fin.elim0 i : Fin 10).val := by
  exact ⟨0, fun i => Fin.elim0 i⟩

end PiDisjunctivity
