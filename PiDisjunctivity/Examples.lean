module

import PiDisjunctivity.Equivalences
import Mathlib.Algebra.Order.Floor.Semifield
import Mathlib.Tactic

/-! Exact rational checks for hexadecimal digits, offsets, and interval boundaries. -/

namespace PiDisjunctivity

-- The integer part is ignored: 3.A in hexadecimal begins with fractional digit A.
example : baseDigit 16 (58 / 16 : ℝ) 0 = 10 := by
  norm_num [baseDigit, Nat.floor_div_ofNat]

-- Leading zeros are part of the word: 0.007 in hexadecimal.
example : baseDigit 16 (7 / 4096 : ℝ) 0 = 0 ∧
    baseDigit 16 (7 / 4096 : ℝ) 1 = 0 ∧
    baseDigit 16 (7 / 4096 : ℝ) 2 = 7 := by
  norm_num [baseDigit, Nat.floor_div_ofNat]

-- Check every letter digit, A through F, in 0.ABCDEF.
example (i : Fin 6) : baseDigit 16 (0xABCDEF / 16 ^ 6 : ℝ) i.val =
    (![10, 11, 12, 13, 14, 15] : Fin 6 → ℕ) i := by
  fin_cases i <;> norm_num [baseDigit, Nat.floor_div_ofNat]

-- A nonzero offset in 3.A0F starts the word 0F.
example : baseDigit 16 (0x3A0F / 16 ^ 3 : ℝ) (1 + 0) = 0 ∧
    baseDigit 16 (0x3A0F / 16 ^ 3 : ℝ) (1 + 1) = 15 := by
  norm_num [baseDigit, Nat.floor_div_ofNat]

-- A terminating expansion uses trailing zeros: 1/2 = 0.8000... in hexadecimal.
example : baseDigit 16 (1 / 2 : ℝ) 0 = 8 ∧
    baseDigit 16 (1 / 2 : ℝ) 1 = 0 := by
  norm_num [baseDigit, Nat.floor_div_ofNat]

-- The 00A cylinder includes its left endpoint and excludes its right endpoint.
example : (10 / 4096 : ℝ) ∈ Set.Ico (10 / 16 ^ 3 : ℝ) (11 / 16 ^ 3) ∧
    (11 / 4096 : ℝ) ∉ Set.Ico (10 / 16 ^ 3 : ℝ) (11 / 16 ^ 3) ∧
    baseDigit 16 (10 / 4096 : ℝ) 0 = 0 ∧
    baseDigit 16 (10 / 4096 : ℝ) 1 = 0 ∧
    baseDigit 16 (10 / 4096 : ℝ) 2 = 10 ∧
    baseDigit 16 (11 / 4096 : ℝ) 2 = 11 := by
  norm_num [baseDigit, Nat.floor_div_ofNat]

example : blockValue 3 ![0, 0, (10 : Fin 16)] = 10 := by
  norm_num [blockValue, Fin.last]

example (x : ℝ) : ∃ n : ℕ, ∀ i : Fin 0,
    baseDigit 16 x (n + i.val) = (Fin.elim0 i : Fin 16).val := by
  exact ⟨0, fun i => Fin.elim0 i⟩

end PiDisjunctivity
