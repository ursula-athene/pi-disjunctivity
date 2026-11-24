module

public import Mathlib.Algebra.Order.Archimedean.Real.Basic
public import Mathlib.Topology.Instances.Real.Lemmas

/-! Decimal disjunctivity, with zero-based digits and trailing-zero expansions. -/

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

/-- Fractional parts obtained by repeatedly shifting the decimal point. -/
noncomputable def decimalOrbit (x : ℝ) : Set ℝ :=
  Set.range (fun n : ℕ => Int.fract ((10 : ℝ) ^ n * x))

end PiDisjunctivity
