/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

import PiDisjunctivity

/-! Check the foundations and word–interval correspondence after running `lake build`. -/

-- This is the reviewed statement, including its full quantification and digit order.
example (k : ℕ) (s : Fin k → Fin 16) :
    PiDisjunctivity.blockValue k s =
      ∑ i : Fin k, (s i).val * 16 ^ (k - 1 - i.val) :=
  PiDisjunctivity.blockValue_eq_sum k s

-- The range statements retain the length, including zero and leading-zero words.
example (k : ℕ) (s : Fin k → Fin 16) :
    PiDisjunctivity.blockValue k s < 16 ^ k :=
  PiDisjunctivity.blockValue_lt k s

example (k m : ℕ) (hm : m < 16 ^ k) :
    ∃ s : Fin k → Fin 16, PiDisjunctivity.blockValue k s = m :=
  PiDisjunctivity.exists_blockValue_eq k m hm

-- Arbitrary-base bounds need no sign hypothesis; reconstruction and error retain it.
example (b : ℕ) (hb : 2 ≤ b) (x : ℝ) (n : ℕ) :
    PiDisjunctivity.baseDigit b x n < b :=
  PiDisjunctivity.baseDigit_lt b hb x n

example (b : ℕ) (hb : 2 ≤ b) (x : ℝ) (hx : 0 ≤ x) (n : ℕ) :
    Nat.floor ((b : ℝ) ^ (n + 1) * x) =
      b * Nat.floor ((b : ℝ) ^ n * x) + PiDisjunctivity.baseDigit b x n :=
  PiDisjunctivity.floor_pow_succ b hb x hx n

example (b : ℕ) (hb : 2 ≤ b) (x : ℝ) (hx : 0 ≤ x) (k : ℕ) :
    Nat.floor ((b : ℝ) ^ k * x) =
      b ^ k * Nat.floor x +
        ∑ i : Fin k, PiDisjunctivity.baseDigit b x i.val * b ^ (k - 1 - i.val) :=
  PiDisjunctivity.floor_pow_eq_digits b hb x hx k

example (b : ℕ) (hb : 2 ≤ b) (x : ℝ) (hx : 0 ≤ x) (k : ℕ) :
    let t : ℝ := (Nat.floor ((b : ℝ) ^ k * x) : ℝ) / (b : ℝ) ^ k
    0 ≤ x - t ∧ x - t < 1 / (b : ℝ) ^ k :=
  PiDisjunctivity.truncation_error b hb x hx k

-- Fixed-length uniqueness and shifting support both directions of the correspondence.
example (k : ℕ) : Function.Injective (PiDisjunctivity.blockValue k) :=
  PiDisjunctivity.blockValue_injective k

example (x : ℝ) (hx : 0 ≤ x) (n i : ℕ) :
    PiDisjunctivity.baseDigit 16 (Int.fract ((16 : ℝ) ^ n * x)) i =
      PiDisjunctivity.baseDigit 16 x (n + i) :=
  PiDisjunctivity.baseDigit_fract_pow x hx n i

example (x : ℝ) (hx : 0 ≤ x) (n k : ℕ) (s : Fin k → Fin 16) :
    (∀ i : Fin k, PiDisjunctivity.baseDigit 16 x (n + i.val) = (s i).val) ↔
      Int.fract ((16 : ℝ) ^ n * x) ∈
        Set.Ico ((PiDisjunctivity.blockValue k s : ℝ) / (16 : ℝ) ^ k)
          (((PiDisjunctivity.blockValue k s : ℝ) + 1) / (16 : ℝ) ^ k) :=
  PiDisjunctivity.block_iff_mem_interval x hx n k s

/--
info: 'PiDisjunctivity.blockValue_eq_sum' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.blockValue_eq_sum

/--
info: 'PiDisjunctivity.blockValue_lt' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.blockValue_lt

/--
info: 'PiDisjunctivity.exists_blockValue_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.exists_blockValue_eq

/--
info: 'PiDisjunctivity.baseDigit_lt' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.baseDigit_lt

/--
info: 'PiDisjunctivity.floor_pow_succ' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.floor_pow_succ

/--
info: 'PiDisjunctivity.floor_pow_eq_digits' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.floor_pow_eq_digits

/--
info: 'PiDisjunctivity.truncation_error' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.truncation_error

/--
info: 'PiDisjunctivity.blockValue_injective' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.blockValue_injective

/--
info: 'PiDisjunctivity.baseDigit_fract_pow' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.baseDigit_fract_pow

/--
info: 'PiDisjunctivity.block_iff_mem_interval' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.block_iff_mem_interval
