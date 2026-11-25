/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

import PiDisjunctivity

/-! Check Step 1's exported statement and axioms after running `lake build`. -/

-- This is the reviewed statement, including its full quantification and digit order.
example (k : ℕ) (s : Fin k → Fin 16) :
    PiDisjunctivity.blockValue k s =
      ∑ i : Fin k, (s i).val * 16 ^ (k - 1 - i.val) :=
  PiDisjunctivity.blockValue_eq_sum k s

/--
info: 'PiDisjunctivity.blockValue_eq_sum' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs (whitespace := lax) in
#print axioms PiDisjunctivity.blockValue_eq_sum
