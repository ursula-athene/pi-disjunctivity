/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.Definitions
public import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

/-! Names for the digit-block and orbit-closure conjectures about π. -/

@[expose] public section

namespace PiDisjunctivity

/-- Open conjecture: every finite hexadecimal word occurs in π. -/
def PiHexadecimalDisjunctivity : Prop := IsDisjunctive 16 Real.pi

/-- Orbit-closure conjecture to be compared with the digit-block formulation. -/
def PiHexadecimalOrbitClosure : Prop :=
  closure (hexadecimalOrbit Real.pi) = Set.Icc (0 : ℝ) 1

end PiDisjunctivity
