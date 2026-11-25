/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

import PiDisjunctivity.BlockValue
import PiDisjunctivity.Digits
import Mathlib.Algebra.Order.Floor.Semifield
import Mathlib.Tactic

/-! Checks for hexadecimal words and arbitrary-base digit reconstruction and truncation. -/

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

-- Binary digits have exactly the two allowed values, without a sign hypothesis.
example (x : ℝ) (n : ℕ) : baseDigit 2 x n = 0 ∨ baseDigit 2 x n = 1 := by
  have h := baseDigit_lt 2 (by norm_num) x n
  omega

-- The one-digit recurrence retains the integer part: 2.7 in decimal.
example : baseDigit 10 (27 / 10 : ℝ) 0 = 7 := by
  have h := floor_pow_succ 10 (by norm_num) (27 / 10) (by norm_num) 0
  norm_num [Nat.floor_div_ofNat] at h ⊢
  omega

-- Binary 1.101 reconstructs its fractional prefix as 5, with integer part 1.
example : (∑ i : Fin 3, baseDigit 2 (13 / 8 : ℝ) i.val * 2 ^ (2 - i.val)) = 5 := by
  have h := floor_pow_eq_digits 2 (by norm_num) (13 / 8) (by norm_num) 3
  norm_num [Nat.floor_div_ofNat] at h ⊢
  omega

-- Decimal 0.35 exercises a fractional input with integer part zero.
example : (∑ i : Fin 2, baseDigit 10 (7 / 20 : ℝ) i.val * 10 ^ (1 - i.val)) = 35 := by
  have h := floor_pow_eq_digits 10 (by norm_num) (7 / 20) (by norm_num) 2
  norm_num [Nat.floor_div_ofNat] at h ⊢
  omega

-- Hexadecimal reconstruction preserves 00A's leading zeros and 3.A0F's integer part.
example : (∑ i : Fin 3, baseDigit 16 (10 / 4096 : ℝ) i.val * 16 ^ (2 - i.val)) = 10 := by
  have h := floor_pow_eq_digits 16 (by norm_num) (10 / 4096) (by norm_num) 3
  norm_num [Nat.floor_div_ofNat] at h ⊢
  exact h.symm

example : (∑ i : Fin 3, baseDigit 16 (0x3A0F / 16 ^ 3 : ℝ) i.val *
    16 ^ (2 - i.val)) = 0xA0F := by
  have h := floor_pow_eq_digits 16 (by norm_num) (0x3A0F / 16 ^ 3) (by norm_num) 3
  norm_num [Nat.floor_div_ofNat] at h ⊢
  omega

-- Zero reconstructs to an all-zero prefix in every base and at every length.
example (b : ℕ) (hb : 2 ≤ b) (k : ℕ) :
    (∑ i : Fin k, baseDigit b 0 i.val * b ^ (k - 1 - i.val)) = 0 := by
  simpa only [mul_zero, Nat.floor_zero, zero_add] using
    (floor_pow_eq_digits b hb 0 le_rfl k).symm

-- At length zero, the truncation is just the integer part.
example (b : ℕ) (hb : 2 ≤ b) (x : ℝ) (hx : 0 ≤ x) :
    0 ≤ x - Nat.floor x ∧ x - Nat.floor x < 1 := by
  simpa only [pow_zero, one_mul, div_one] using truncation_error b hb x hx 0

-- A nonterminating input satisfies the decimal truncation bound.
example : 0 ≤ (1 / 3 : ℝ) - 33 / 100 ∧
    (1 / 3 : ℝ) - 33 / 100 < 1 / 100 := by
  convert truncation_error 10 (by norm_num) (1 / 3) (by norm_num) 2 using 1 <;>
    norm_num [Nat.floor_div_ofNat]

-- Terminating prefixes select zero for the next digit in each tested base.
example : baseDigit 2 (13 / 8 : ℝ) 3 = 0 ∧
    baseDigit 10 (7 / 20 : ℝ) 2 = 0 ∧
    baseDigit 16 (0x3A0F / 16 ^ 3 : ℝ) 3 = 0 := by
  norm_num [baseDigit, Nat.floor_div_ofNat]

-- The corresponding truncations have exactly zero error at termination.
example : (13 / 8 : ℝ) - Nat.floor ((2 : ℝ) ^ 3 * (13 / 8)) / 2 ^ 3 = 0 ∧
    (7 / 20 : ℝ) - Nat.floor ((10 : ℝ) ^ 2 * (7 / 20)) / 10 ^ 2 = 0 ∧
    (0x3A0F / 16 ^ 3 : ℝ) -
      Nat.floor ((16 : ℝ) ^ 3 * (0x3A0F / 16 ^ 3)) / 16 ^ 3 = 0 := by
  norm_num [Nat.floor_div_ofNat]

end PiDisjunctivity
