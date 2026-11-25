/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.Definitions
import Mathlib.Data.Fin.Tuple.Basic
import Mathlib.Tactic

/-! Every word in a disjunctive digit sequence occurs arbitrarily far out. -/

public section

namespace PiDisjunctivity

/-- Disjunctivity supplies an occurrence of each word beyond every prescribed starting position. -/
theorem isDisjunctive_occurs_ge (b : ℕ) (hb : 2 ≤ b) (x : ℝ)
    (h : IsDisjunctive b x) (k : ℕ) (s : Fin k → Fin b) (N : ℕ) :
    ∃ n, N ≤ n ∧ ∀ i : Fin k, baseDigit b x (n + i.val) = (s i).val := by
  let z : Fin N → Fin b := fun _ => ⟨0, by omega⟩
  obtain ⟨n, hn⟩ := h (N + k) (Fin.append z s)
  refine ⟨n + N, by omega, fun i => ?_⟩
  simpa [Nat.add_assoc] using hn (Fin.natAdd N i)

end PiDisjunctivity
