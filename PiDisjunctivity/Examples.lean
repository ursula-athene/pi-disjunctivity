/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

import PiDisjunctivity.BlockValue
import Mathlib.Algebra.Order.Floor.Semifield
import Mathlib.Tactic

/-! Checks for hexadecimal digits, offsets, interval boundaries, and word values. -/

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

-- The sum formula handles the empty word and arbitrary one-digit words.
example (s : Fin 0 → Fin 16) : blockValue 0 s = 0 := by
  simp [blockValue_eq_sum]

example (d : Fin 16) : blockValue 1 ![d] = d.val := by
  simp [blockValue_eq_sum]

-- An all-zero word has value zero at every length.
example (k : ℕ) : blockValue k (fun _ => 0) = 0 := by
  simp [blockValue_eq_sum]

-- Leading zeros and the maximum hexadecimal digit use their positional values.
example : blockValue 3 ![0, 0, (10 : Fin 16)] = 10 := by
  norm_num [blockValue_eq_sum, Fin.sum_univ_succ]

example : blockValue 2 ![15, (15 : Fin 16)] = 0xFF := by
  norm_num [blockValue_eq_sum, Fin.sum_univ_succ]

-- Distinct mixed words check that the first digit is the most significant.
example : blockValue 2 ![1, (2 : Fin 16)] = 0x12 ∧
    blockValue 2 ![2, (1 : Fin 16)] = 0x21 := by
  norm_num [blockValue_eq_sum, Fin.sum_univ_succ]

-- The range bound includes empty and one-digit words.
example (s : Fin 0 → Fin 16) : blockValue 0 s < 1 := by
  simpa using blockValue_lt 0 s

example (d : Fin 16) : blockValue 1 ![d] < 16 := by
  simpa using blockValue_lt 1 ![d]

-- Coverage includes the empty word, each single digit, and zero at every length.
example : ∃ s : Fin 0 → Fin 16, blockValue 0 s = 0 :=
  exists_blockValue_eq 0 0 (by norm_num)

example (d : Fin 16) : ∃ s : Fin 1 → Fin 16, blockValue 1 s = d.val :=
  exists_blockValue_eq 1 d.val d.isLt

example (k : ℕ) : ∃ s : Fin k → Fin 16, blockValue k s = 0 :=
  exists_blockValue_eq k 0 (by positivity)

-- Fixing the length allows 00A's padding and FF's maximum value.
example : ∃ s : Fin 3 → Fin 16, blockValue 3 s = 10 :=
  exists_blockValue_eq 3 10 (by norm_num)

example : ∃ s : Fin 2 → Fin 16, blockValue 2 s = 0xFF :=
  exists_blockValue_eq 2 0xFF (by norm_num)

example (k : ℕ) : ∃ s : Fin k → Fin 16, blockValue k s = 16 ^ k - 1 :=
  exists_blockValue_eq k (16 ^ k - 1) (by
    have : 0 < (16 : ℕ) ^ k := by positivity
    omega)

example (x : ℝ) : ∃ n : ℕ, ∀ i : Fin 0,
    baseDigit 16 x (n + i.val) = (Fin.elim0 i : Fin 16).val := by
  exact ⟨0, fun i => Fin.elim0 i⟩

end PiDisjunctivity
