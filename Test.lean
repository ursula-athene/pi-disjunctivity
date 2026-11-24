module

import PiDisjunctivity

/-! Axiom audit. Run `lake env lean Test.lean` after `lake build`. -/

/--
info: 'PiDisjunctivity.hexadecimal_disjunctive_iff_orbit_closure' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.hexadecimal_disjunctive_iff_orbit_closure

/--
info: 'PiDisjunctivity.pi_hexadecimal_disjunctivity_iff_orbit_closure' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.pi_hexadecimal_disjunctivity_iff_orbit_closure
