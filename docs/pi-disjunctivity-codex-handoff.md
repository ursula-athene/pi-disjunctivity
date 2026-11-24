# Codex handoff — π disjunctivity in Lean 4

> **Historical handoff.** This document preserves the original base-10 plan and
> its status at the time of handoff. The project now targets hexadecimal (base 16)
> expansions. See [the current formulation](problem-formulation.md) and
> [README](../README.md) for the implemented equivalences, build commands, and
> remaining work. The base-10 snippets and next steps below are historical.

**First deliverable.** Set up or locate a reproducible Lean 4 + Mathlib project, compile the definitions below, and prove that the digit-block statement is equivalent to density of the decimal orbit in the unit interval. The conjecture about π itself remains open and is not a requirement for this milestone.

## Goal and decisions

The research question is whether **every finite block of decimal digits occurs contiguously after the decimal point in π**, including blocks with leading zeros. This also covers any finite list of natural numbers in the sense of concatenating their decimal spellings, not in the sense of a unique parsing. The digit-block property is called *disjunctivity*. It implies that each block occurs arbitrarily far out: a sufficiently long concatenation of copies of a nonempty block forces an occurrence beyond any fixed position. Unlike normality, it imposes no limiting frequency.

Use the **base-parameterized combinatorial predicate** as the canonical statement and derive the **orbit-closure formulation** as a theorem. Start with base 10 for the proof if that keeps the first PR small. Keep the base parameter in the definition and assume `2 ≤ b` in arbitrary-base theorems. The digit convention below is zero-based and uses `Nat.floor`, so the equivalence is scoped to nonnegative reals. The floor convention chooses the trailing-zero representation for terminating expansions. The closure lives in ℝ and should equal `[0,1]`; plain `Dense` in ℝ is incorrect.

An independent Mathlib project was recommended. DeepMind’s Formal Conjectures is a reference, not a dependency or an authorized upstream contribution. Do not assume the repo already contains this weaker statement. If reusing or comparing its normality declarations, inspect the current source or PR first.

## Current progress and files

- Completed in conversation: clarified the target, drafted both Lean statements, sketched the mathematical equivalence, and discussed macOS setup via Elan and Lake.
- Not completed: no Lean code was compiled, no equivalence was proved in Lean, and no project, commit, or push was made here. The handoff workspace showed no project files and neither `lean` nor `lake` on its PATH. The local Mac and any separate checkout were not inspected.
- **Proposed paths**, relative to the project root. Use existing conventions if a checkout is supplied.

| Path | Purpose |
| --- | --- |
| `lean-toolchain`, `lakefile.toml` (or `lakefile.lean`), `lake-manifest.json` | Pin Lean and resolve the Mathlib dependency |
| `PiDisjunctivity.lean` | Root import for verified modules |
| `PiDisjunctivity/Definitions.lean` | Digit, predicate, and orbit definitions |
| `PiDisjunctivity/Equivalences.lean` | Block-to-interval bridge and density equivalence |
| `PiDisjunctivity/Conjectures.lean` | Named open statements as proposition definitions, if useful |
| `README.md` | Build commands, verified results, and open targets |

## Lean starting point — not compiled

```lean
import Mathlib

namespace PiDisjunctivity

noncomputable def baseDigit (b : ℕ) (x : ℝ) (n : ℕ) : ℕ :=
  Nat.floor ((b : ℝ) ^ (n + 1) * x) % b

def IsDisjunctive (b : ℕ) (x : ℝ) : Prop :=
  ∀ (k : ℕ) (s : Fin k → Fin b),
    ∃ n : ℕ, ∀ i : Fin k,
      baseDigit b x (n + i.val) = (s i).val

def decimalOrbit (x : ℝ) : Set ℝ :=
  Set.range (fun n : ℕ => Int.fract ((10 : ℝ) ^ n * x))

def PiDecimalDisjunctivity : Prop := IsDisjunctive 10 Real.pi

def PiDecimalOrbitClosure : Prop :=
  closure (decimalOrbit Real.pi) = Set.Icc (0 : ℝ) 1

end PiDisjunctivity
```

The desired **provable** theorem inside that namespace is:

```lean
theorem decimal_disjunctive_iff_orbit_closure (x : ℝ) (hx : 0 ≤ x) :
    IsDisjunctive 10 x ↔
      closure (decimalOrbit x) = Set.Icc (0 : ℝ) 1
```

A `def ... : Prop` names an open goal without asserting it. Keep any exploratory `sorry` out of verified modules. A successful Lean build with a `sorry` warning is not a proof.

## Proof route

1. Interpret a length-`k` block as its big-endian integer `m < 10^k`. Retain `k` so blocks such as `007` and `7` remain distinct. Show that length-`k` blocks cover every such `m` with leading-zero padding. The empty block is automatic.
2. For `y = fract (10^n x)`, prove that the block occurs at offset `n` iff `floor (10^k y) = m`, equivalently `y ∈ [m/10^k, (m+1)/10^k)`. Factor the proof into shift and digit-reconstruction lemmas. For the shift, write `10^n x = q + y` for integer `q`; after scaling by `10^(i+1)`, the contribution from `q` is divisible by 10. Establish nonnegativity where converting between integer and natural floors.
3. Orbit closure implies each cylinder is hit by using its **nonempty open interior**, which avoids inferring a hit in a half-open set merely from membership in a closure. Conversely, if each cylinder is hit, take finer and finer decimal cells containing any given point of `[0,1)`; for `1` use the last cell at each scale. Each chosen orbit point is within `10^(-k)` of the target. The other closure inclusion follows from closedness of `[0,1]` and the bounds on `fract`.

## Next steps and acceptance

1. **Locate the project or bootstrap it.** Check for a checkout and read its `AGENTS.md` before editing. For a new project, use the [official Lean setup guide](https://lean-lang.org/install/) and the [Mathlib project guide](https://leanprover-community.github.io/install/project.html) to confirm bootstrap commands. The command proposed in chat after installing Elan was `lake +leanprover-community/mathlib4:lean-toolchain new PiDisjunctivity math`. Use the project-pinned toolchain, `lake exe cache get` as needed, then `lake build`. Record actual versions and commands. If setup is blocked, report the exact step and error.
2. **Compile the smallest slice first.** Run `lake env lean PiDisjunctivity/Definitions.lean`, fix imports or API differences against the pinned Mathlib version, and test indexing and floor conventions on exact rational examples, including a leading-zero block. Do not treat the earlier smoke-test theorem names as verified.
3. **Prove and audit the equivalence.** Build the cylinder bridge first, then the two closure inclusions. Run `lake build` and inspect `#print axioms PiDisjunctivity.decimal_disjunctive_iff_orbit_closure` for `sorryAx` or any project-specific axiom. Report any incomplete lemmas separately from verified ones.
4. **Only then expand scope.** Consider arbitrary-base equivalence, recurrence arbitrarily far out, and normality implying disjunctivity. Treat binary or hexadecimal targets and the BBP approach as optional research directions. A result in base 2 or 16 would not by itself establish the decimal statement.

## References from the discussion

- [Mathlib API documentation](https://leanprover-community.github.io/mathlib4_docs/) for the floor, fractional-part, and topology APIs.
- [DeepMind Formal Conjectures](https://github.com/google-deepmind/formal-conjectures) and [issue #2255](https://github.com/google-deepmind/formal-conjectures/issues/2255) as starting points for checking the related normality formalization. Check the exact declaration and current upstream status before citing them in project docs.
- [Bailey and Crandall, *On the Random Character of Fundamental Constant Expansions*](https://doi.org/10.1080/10586458.2001.10504435) for the longer-term BBP and dynamical-systems direction.
