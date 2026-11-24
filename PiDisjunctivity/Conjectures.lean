module

public import PiDisjunctivity.Equivalences
public import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

/-! Names for the open conjecture about π, and the equivalence of its two formulations. -/

@[expose] public section

namespace PiDisjunctivity

/-- Open conjecture: every finite hexadecimal word occurs in π. -/
def PiHexadecimalDisjunctivity : Prop := IsDisjunctive 16 Real.pi

/-- The equivalent orbit-closure formulation of the open conjecture. -/
def PiHexadecimalOrbitClosure : Prop :=
  closure (hexadecimalOrbit Real.pi) = Set.Icc (0 : ℝ) 1

/-- The two open statements are equivalent; neither is assumed here. -/
theorem pi_hexadecimal_disjunctivity_iff_orbit_closure :
    PiHexadecimalDisjunctivity ↔ PiHexadecimalOrbitClosure :=
  hexadecimal_disjunctive_iff_orbit_closure Real.pi Real.pi_pos.le

end PiDisjunctivity
