module

public import Mathlib.Algebra.Order.Archimedean.Real.Basic
public import Mathlib.Topology.Instances.Real.Lemmas

/-! Hexadecimal disjunctivity, with zero-based digits and trailing-zero expansions. -/

@[expose] public section

namespace PiDisjunctivity

/-- The digit at zero-based position `n` after the radix point of a nonnegative real. -/
noncomputable def baseDigit (b : ℕ) (x : ℝ) (n : ℕ) : ℕ :=
  Nat.floor ((b : ℝ) ^ (n + 1) * x) % b

/-- Every finite base-`b` word occurs, including words with leading zeros. -/
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
