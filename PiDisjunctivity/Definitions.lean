/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import Mathlib.Algebra.Order.Archimedean.Real.Basic
public import Mathlib.Topology.Instances.Real.Lemmas

/-! Hexadecimal disjunctivity, with zero-based digits and trailing-zero expansions. -/

@[expose] public section

namespace PiDisjunctivity

/-- The digit at zero-based position `n` after the radix point, for `x ≥ 0` and `b ≥ 2`.
The formula is total, but values outside this domain have no intended positional interpretation:
negative inputs give zero digits, and bases zero and one are degenerate. -/
noncomputable def baseDigit (b : ℕ) (x : ℝ) (n : ℕ) : ℕ :=
  Nat.floor ((b : ℝ) ^ (n + 1) * x) % b

/-- Every finite base-`b` word occurs, including words with leading zeros.
The intended digit interpretation assumes `x ≥ 0` and `b ≥ 2`. Outside that domain,
the predicate is false for negative inputs with `b ≥ 2`, and true for bases zero and one. -/
def IsDisjunctive (b : ℕ) (x : ℝ) : Prop :=
  ∀ (k : ℕ) (s : Fin k → Fin b),
    ∃ n : ℕ, ∀ i : Fin k,
      baseDigit b x (n + i.val) = (s i).val

/-- Fractional parts obtained by repeatedly shifting the hexadecimal point. -/
noncomputable def hexadecimalOrbit (x : ℝ) : Set ℝ :=
  Set.range (fun n : ℕ => Int.fract ((16 : ℝ) ^ n * x))

/-- Big-endian value of a hexadecimal word. Its length is retained separately. -/
def blockValue : (k : ℕ) → (Fin k → Fin 16) → ℕ
  | 0, _ => 0
  | k + 1, s => 16 * blockValue k (fun i => s i.castSucc) + (s (Fin.last k)).val

end PiDisjunctivity
