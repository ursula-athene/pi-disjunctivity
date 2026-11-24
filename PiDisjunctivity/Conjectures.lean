module

public import PiDisjunctivity.Definitions
public import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

/-! Names for the open conjecture about π. These definitions assert no theorem. -/

@[expose] public section

namespace PiDisjunctivity

/-- Open conjecture: every finite decimal word occurs in π. -/
def PiDecimalDisjunctivity : Prop := IsDisjunctive 10 Real.pi

/-- The equivalent orbit-closure formulation of the open conjecture. -/
def PiDecimalOrbitClosure : Prop :=
  closure (decimalOrbit Real.pi) = Set.Icc (0 : ℝ) 1

end PiDisjunctivity
