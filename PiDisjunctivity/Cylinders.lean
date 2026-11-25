/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.BlockValue
public import PiDisjunctivity.Digits
import Mathlib.Algebra.Order.Floor.Ring
import Mathlib.Tactic

/-! Hexadecimal digit blocks correspond to half-open intervals of the shifted fractional part. -/

public section

namespace PiDisjunctivity

private theorem baseDigit_fract (x : ℝ) (hx : 0 ≤ x) (i : ℕ) :
    baseDigit 16 (Int.fract x) i = baseDigit 16 x i := by
  have hsplit : Int.fract x + (Nat.floor x : ℝ) = x := by
    rw [natCast_floor_eq_intCast_floor hx, Int.fract_add_floor]
  have hscaled : (16 : ℝ) ^ (i + 1) * x =
      (16 : ℝ) ^ (i + 1) * Int.fract x + ((16 ^ (i + 1) * Nat.floor x : ℕ) : ℝ) := by
    calc
      _ = (16 : ℝ) ^ (i + 1) * (Int.fract x + (Nat.floor x : ℝ)) := by rw [hsplit]
      _ = _ := by push_cast; ring
  simp only [baseDigit, Nat.cast_ofNat]
  rw [hscaled, Nat.floor_add_natCast (mul_nonneg (by positivity) (Int.fract_nonneg x))]
  simp [Nat.add_mod, Nat.mul_mod, pow_succ]

/-- Shifting the hexadecimal point and removing the integer part preserves the later digits. -/
theorem baseDigit_fract_pow (x : ℝ) (hx : 0 ≤ x) (n i : ℕ) :
    baseDigit 16 (Int.fract ((16 : ℝ) ^ n * x)) i =
      baseDigit 16 x (n + i) := by
  rw [baseDigit_fract _ (mul_nonneg (by positivity) hx)]
  simp only [baseDigit, Nat.cast_ofNat]
  rw [← mul_assoc, ← pow_add, show i + 1 + n = n + i + 1 by omega]

/-- A word occurs exactly when the shifted fractional part lies in its half-open interval. -/
theorem block_iff_mem_interval (x : ℝ) (hx : 0 ≤ x)
    (n k : ℕ) (s : Fin k → Fin 16) :
    (∀ i : Fin k, baseDigit 16 x (n + i.val) = (s i).val) ↔
      Int.fract ((16 : ℝ) ^ n * x) ∈
        Set.Ico ((blockValue k s : ℝ) / (16 : ℝ) ^ k)
          (((blockValue k s : ℝ) + 1) / (16 : ℝ) ^ k) := by
  let y := Int.fract ((16 : ℝ) ^ n * x)
  have hy0 : 0 ≤ y := Int.fract_nonneg _
  have hy1 : y < 1 := Int.fract_lt_one _
  let d : Fin k → Fin 16 := fun i => ⟨baseDigit 16 y i.val, baseDigit_lt 16 (by decide) y i.val⟩
  have hd : blockValue k d = Nat.floor ((16 : ℝ) ^ k * y) := by
    simpa only [blockValue_eq_sum, Nat.cast_ofNat, Nat.floor_eq_zero.mpr hy1,
      mul_zero, zero_add] using (floor_pow_eq_digits 16 (by decide) y hy0 k).symm
  have hdigits : (∀ i : Fin k, baseDigit 16 x (n + i.val) = (s i).val) ↔ d = s := by
    constructor
    · intro h
      funext i
      apply Fin.ext
      exact (baseDigit_fract_pow x hx n i.val).trans (h i)
    · intro h i
      calc
        baseDigit 16 x (n + i.val) = baseDigit 16 y i.val :=
          (baseDigit_fract_pow x hx n i.val).symm
        _ = (s i).val := congrArg Fin.val (congrFun h i)
  rw [hdigits, ← (blockValue_injective k).eq_iff, hd]
  have hp : 0 < (16 : ℝ) ^ k := by positivity
  change Nat.floor ((16 : ℝ) ^ k * y) = blockValue k s ↔
    y ∈ Set.Ico ((blockValue k s : ℝ) / (16 : ℝ) ^ k)
      (((blockValue k s : ℝ) + 1) / (16 : ℝ) ^ k)
  rw [Nat.floor_eq_iff (mul_nonneg hp.le hy0), Set.mem_Ico,
    div_le_iff₀ hp, lt_div_iff₀ hp, mul_comm y]

end PiDisjunctivity
