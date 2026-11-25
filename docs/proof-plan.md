# Proof plan for hexadecimal disjunctivity of pi

**Planning baseline:** 2026-11-24, commit
`56ca22e1a9776ee7a5d7b4e36103f932d3b45646` on `feature/attempt-01`.

**Latest implementation update: 2026-11-24.** A bounded pilot on
`feature/attempt-02` completed Step 2's interval-hitting reduction. See the
[blueprint](proof-blueprint.md) for dependencies, [research log](research-log.md)
for checks and review, and [workflow](proof-workflow.md) for the executed
meta-plan. The margin transfer lemma and all BBP work remain unimplemented.

The goal is to prove `PiDisjunctivity.PiHexadecimalDisjunctivity`: every finite
hexadecimal word occurs contiguously after the radix point of `Real.pi`,
including words with leading zeros. The repository has completed the
formulation and equivalence proofs. The remaining task is a research problem:
we do not currently have a complete mathematical proof to translate into Lean.

The proposed route is to use the Bailey–Borwein–Plouffe (BBP) series to study
pi's hexadecimal orbit, prove that this particular orbit visits every interval,
and apply the existing equivalence. BBP gives useful arithmetic structure; it
does not by itself establish the required visits. Step 5 below is the unresolved
mathematical step. The other steps prepare, connect, or check that argument.

This document plans the proof attempt requested for this branch. The scope
restrictions in the older formulation documents describe the previous phase;
the formulation review is already complete. The original planning change added
no Lean proofs or assumptions; the later pilot adds only the conditional
reduction recorded below.

## Overview: mathematical status and formalization work

Steps 1–4 involve established mathematics and formalization work. Step 5
requires discovering a mathematical argument. Established mathematics can
still take substantial work to implement and check in Lean.

| Step | Mathematical status | Status in this repository |
| --- | --- | --- |
| **1. Verified foundation** | Solved. | Already proved and checked in Lean, including the digit–interval and orbit equivalences. |
| **2. Isolate interval hitting** | An elementary consequence of the existing equivalences that expresses exactly what remains to prove. | Completed by the bounded pilot in `OrbitCriteria.lean`: a general equivalence and a conditional π reduction, both audited. |
| **3. Prove the BBP identity** | A classical, established theorem with published proofs. | Not implemented here. Formalizing convergence, exchanging sums and integrals, and evaluating the integral could be substantial work. Existing external Lean work may help after checking it and respecting this project's dependency policy. |
| **4. Connect BBP to the orbit** | The identities, tail estimates, and conditional transfer argument have standard proof methods. This plan supplies the mathematical outline. | Not implemented here. Likely moderate formalization work, potentially substantial around series manipulation and fractional-part boundaries. |
| **5. Prove universal visitation** | Open mathematical research; no complete proof method is supplied. | The decisive missing argument about this particular recurrence. |

The qualification for Step 4 is that it proves an implication:

```text
IF the BBP recurrence visits every interval arbitrarily late,
THEN pi's actual orbit visits every interval.
```

The shrinking error lets us transfer visits. It does not produce those visits;
producing them is Step 5.

```text
1       Completed and checked.
2       Completed and checked; the π hitting hypothesis is still open.
3       Known theorem; potentially substantial formalization.
4       Standard arguments; additional formalization required.
5       Open mathematical research; no complete proof method supplied.
```

Steps 2–4 have sound mathematical routes, but their Lean implementations are
not necessarily quick. Completing them supplies useful, verified infrastructure
without necessarily bringing us closer to the discovery needed for Step 5.
Steps 6–7 then assemble and audit the result once that missing argument exists.

## Viewpoint

In proving, try to keep the proof as simple as possible, proving no unneeded lemmas or theorems. When finishing a step or milestone, commit code and documentation, then go through the proof and verify that each piece is needed for the proof. Remove unnecessary pieces that don't matter to the proof's line of reasoning. Commit the results.

Make sure each functional block of Lean code is thoroughly tested. Use Lean and mathematical best practices to do that.


## 1. Start from the verified formulation

**Status: implemented.** Preserve the definitions and reuse these results:

| Existing result | What it supplies |
| --- | --- |
| `blockValue_eq_sum`, `blockValue_lt`, `exists_blockValue_eq`, `blockValue_injective` | Length-`k` words correspond exactly to integers `0 <= m < 16^k`, with length and leading zeros retained. |
| `floor_pow_eq_digits`, `truncation_error`, `hasSum_baseDigit` | The defined digits reconstruct the intended nonnegative real expansion. |
| `baseDigit_fract_pow`, `block_iff_mem_interval` | A word at position `n` is equivalent to a visit of `fract(16^n*x)` to its hexadecimal interval. |
| `isDisjunctive_iff_orbitClosure` | For `x >= 0`, every word occurs if and only if the orbit closure in the real line is `[0,1]`. |
| `piHexadecimalDisjunctivity_iff_orbitClosure` | The preceding equivalence specialized to pi. |
| `isDisjunctive_occurs_ge` | Once disjunctivity is proved, every word occurs arbitrarily late. |

The last result assumes disjunctivity; it cannot supply the missing pi proof.
The checked `243F` example confirms the initial digits, but proves no assertion
about arbitrary words.

The implementation is in [the Lean modules](../PiDisjunctivity.lean), with
seventeen theorem-type and axiom audits in [Test.lean](../Test.lean), including
the two Step 2 additions. The
[formulation review](formulation-review.md) and [follow-up](review-follow-up.md)
record the completed mathematical review. Arbitrary-base generalization and a
normal-number API are not prerequisites for this attempt.

**Deliverable:** retain this foundation and its checks throughout the proof work.

## 2. Isolate exactly what must be proved about pi

**Status: implemented and audited by the bounded pilot.**
[`OrbitCriteria.lean`](../PiDisjunctivity/OrbitCriteria.lean) exports
`isDisjunctive_iff_hitsHexadecimalIntervals` for every nonnegative real and
`piHexadecimalDisjunctivity_of_hitsHexadecimalIntervals` for π. The latter
requires the full interval-hitting assertion below as an explicit hypothesis.
No new proposition definition or unconditional π claim was added.

Write `t_n = fract(16^n*pi)`. For a word of length `k` and integer value `m`,
its interval is

```text
I(k,m) = [m / 16^k, (m+1) / 16^k).
```

It is enough to prove the following statement, with no distribution assumption:

```text
For every k >= 0 and every integer 0 <= m < 16^k,
there exists n >= 0 such that t_n belongs to I(k,m).
```

This is the exact missing assertion in interval language. Naming it or proving
its equivalence to the conjecture does not resolve the research problem.
Alternatively, prove that the orbit visits every nonempty open interval inside
`[0,1]`; the existing closure argument then applies. Density here is relative
to `[0,1]`, not density in the entire real line.

Use interval interiors when transferring approximate values to actual visits.
They provide an error margin and avoid ambiguity at cell boundaries. The empty
word (`k = 0`) is immediate. No limiting frequencies or bound on the first
occurrence is required.

**Deliverable:** a short, proved reduction from an explicit interval-hitting
hypothesis to the existing conjecture, keeping that hypothesis visible until
it has an independent proof.

## 3. Establish the BBP identity in the permitted Lean stack

Define the rational coefficient

```text
A(j) = 4/(8j+1) - 2/(8j+4) - 1/(8j+5) - 1/(8j+6).
```

Prove convergence and the identity

```text
pi = sum over j >= 0 of A(j) / 16^j.
```

Use a `HasSum` theorem so convergence is part of the statement. A classical
proof integrates a geometric series and evaluates the resulting rational
integral. Formalization must justify exchanging the sum and integral, verify
the denominator conditions, and identify the value with Mathlib's `Real.pi`.
See the [original BBP paper, Theorem 1](https://www.davidhbailey.com/dhbpapers/digits.pdf).

Before implementing, inspect the existing BBP proof development identified by
the [repository's later literature review](codex-reports/2026-11-24-lean-literature-review.md#certified-hexadecimal-digits-of-pi-metasecdevmath-proofs).
That report inspected proof bodies but did not independently rebuild their
dependencies or audit their axioms. It supersedes the earlier report's blanket
claim that there is no Lean BBP work. External work can inform our proof;
adding or vendoring another library would violate the Mathlib-only policy.
Any adaptation needs attribution and license review, followed by local checking.

**Deliverable:** a checked BBP series theorem using the existing version pins.
This is substantial, established mathematics to formalize, not a proof of
disjunctivity.

## 4. Connect BBP arithmetic to the actual hexadecimal orbit

Split the scaled series into a finite sum and its remainder:

```text
S_n = sum over 0 <= j <= n of 16^(n-j) * A(j)
R_n = sum over r >= 1 of A(n+r) / 16^r

16^n*pi = S_n + R_n.
```

The finite sums admit a simple recurrence. Define

```text
y_0     = 0
y_(n+1) = fract(16*y_n + A(n)).
```

Prove by induction that `y_(n+1) = fract(S_n)`, hence
`t_n = fract(y_(n+1) + R_n)`. This indexing matters: `y_(n+1)` approximates
the orbit at position `n`.

Next prove an explicit bound on `R_n` tending to zero. For example, triangle
inequalities and a geometric sum give the following candidate bound to
formalize:

```text
|A(j)| <= 8/(8j+1)
|R_n|  <= 8 / (15*(8n+9))  -->  0.
```

For computation, each finite-sum fraction can replace `16^(n-j)` by its
remainder modulo the relevant denominator `8j+d`, for `d = 1,4,5,6`, without
changing the final fractional part. This is the modular reduction used in
[Bailey's BBP algorithm exposition, Section 3](https://www.davidhbailey.com/dhbpapers/bbp-alg.pdf).
Prove the identity for the combined signed sum; the four components cannot be
treated as independent random quantities.

Finally prove a transfer lemma: if `y_(n+1)` visits every interior interval
arbitrarily late and `R_n` tends to zero, then `t_n` visits every such interval.
For a target `(a,b)`, choose a smaller interval inside it and take `n` large
enough that the tail is smaller than the margin. Then the perturbed value
remains inside `(a,b)`, with no wrap across 0 or 1.

Do not infer `|fract(u)-fract(v)| <= |u-v|`: that is false across an integer.
The margin argument suffices here; circle-valued distances are an alternative
if the later proof benefits from them.

**Deliverable:** checked series splitting, recurrence, tail bounds, and a
conditional transfer theorem. These expose the remaining arithmetic question
without assuming its answer.

### Next bounded task: conditional interior-margin transfer

**Status: planned, not implemented.** This is the next bounded cycle after the
completed Step 2 pilot, and corresponds to B4 and P3 in
[the blueprint](proof-blueprint.md#remaining-bbp-route).

For general sequences `u r : ℕ → ℝ`, assume:

1. `Filter.Tendsto r Filter.atTop (nhds 0)`.
2. For every `a b : ℝ` with `0 ≤ a < b ≤ 1` and every `N : ℕ`, there exists
   `n ≥ N` with `u n ∈ Set.Ioo a b`.

No global range assumption on `u` is needed: the selected late visit supplies
the bounds used in the proof. The later BBP instance `u n = y_(n+1)` does lie
in `[0,1)`, but that fact is not a premise of this general transfer.

Prove that for every `a b : ℝ` with `0 ≤ a < b ≤ 1`, there exists `n : ℕ`
such that

```text
Int.fract (u n + r n) ∈ Set.Ioo a b.
```

Choose a smaller interval strictly inside `(a,b)`, use convergence to bound
`|r n|` by its margin for all sufficiently large `n`, and then use a late
visit to that smaller interval. The perturbed value lies in `(a,b) ⊆ (0,1)`,
so taking its fractional part does not change it. Check targets with `a = 0`
or `b = 1`, either sign of `r n`, and all convergence/visitation quantifiers.

Complete the task with the independent elementary conversion P3. For a sequence
`t : ℕ → ℝ`, assume

```text
∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 → ∃ n : ℕ, t n ∈ Set.Ioo a b.
```

Prove

```text
∀ k m : ℕ, m < 16 ^ k → ∃ n : ℕ,
  t n ∈ Set.Ico ((m : ℝ) / (16 : ℝ) ^ k) (((m : ℝ) + 1) / (16 : ℝ) ^ k).
```

Apply open-interval visitation to the cell's interior, including `k = 0`.
This supplies the shape of the premise used by the existing Step 2 criterion;
applying it to π still requires the later orbit identity and independent
visitation proof. Keep the single-visit conclusion and these two modular lemmas;
late-output strengthening and an additional composition theorem are deferred
until needed.

**Endpoint:** checked general transfer and cell-conversion lemmas, exported
from `OrbitCriteria.lean` if that remains the smallest suitable location,
with explicit type checks and guarded axiom audits in `Test.lean`. Run
`lake build`, `lake env lean Test.lean`, and `git diff --check`, then update the
blueprint and research log. If blocked, record the exact obstruction without
weakening the statements. Stop before defining or proving BBP series,
recurrences, or tail estimates, and before attempting Step 5. The late-visitation
hypothesis remains unproved for the particular BBP recurrence.

## 5. Prove the missing universal visitation theorem

**Status: open research; no complete argument is currently supplied.**

For the recurrence defined in Step 4, seek a proof of

```text
For every 0 <= a < b <= 1 and every threshold N,
there exists n >= N with a < y_(n+1) < b.
```

Investigate two concrete approaches, starting with the weaker property needed
for disjunctivity:

1. **Exclude permanent avoidance of an interval.** Assume a fixed interval
   is missed by every sufficiently late iterate. Use the explicit rational
   coefficients, or their modular-sum representation, to derive a
   contradiction. The argument must handle an arbitrary interval, however
   small. A promising intermediate result would be a proved restriction on
   what a permanently avoiding orbit can look like; the contradiction must
   then use the particular BBP coefficients.
2. **Prove a density dichotomy for this particular recurrence.** Show that
   its limit set is either finite or fills the unit interval, and prove that
   the finite case would force pi to be rational. Mathlib's pi irrationality
   could then exclude that case. Lagarias distinguishes such a weak
   dichotomy from the stronger equidistribution hypothesis, and gives
   conditional consequences in Theorem 4.1. The dichotomy itself remains a
   proof obligation, including the precise initialization and indexing.
   See [Lagarias, Sections 3–4](https://arxiv.org/pdf/math/0101055).

Bailey–Crandall's Hypothesis A is another conditional route, aimed at the
stronger conclusion of normality. Their result does not discharge that
hypothesis. A proof assuming it would be a conditional milestone; completing
this project requires proving enough of its pi-specific content or finding
another argument. See [Bailey–Crandall](https://www.davidhbailey.com/dhbpapers/baicran.pdf).

For each candidate, write the mathematical argument and identify its genuinely
new estimate or structural lemma before committing to a large formalization.
Small certified experiments can challenge proposed bounds or suggest lemmas.
Finitely many successful word searches, or an algorithm that keeps searching
without a termination proof, cannot establish the universal claim.

Irrationality, transcendence, and almost-everywhere density alone do not select
pi as a dense-orbit point. In particular, excluding finite limit sets does not
exclude infinite proper limit sets without an additional theorem. The decay
`A(n) -> 0` alone also supplies no density conclusion.

**Deliverable:** an unconditional proof of the visitation statement, or a
precise record of the remaining unproved lemma. This is the decisive research
milestone; no completion date or guaranteed method follows from the plan.

## 6. Assemble the proof of the original conjecture

Once Step 5 succeeds, use Step 4 to obtain visits of the actual pi orbit.
Then use Step 2 and `block_iff_mem_interval` to recover every finite word, or
establish `PiHexadecimalOrbitClosure` and apply
`piHexadecimalDisjunctivity_iff_orbitClosure` in the reverse direction.

The final exported theorem must have conclusion
`PiDisjunctivity.PiHexadecimalDisjunctivity` with no unproved distribution
hypothesis. Preserve the original digit convention, all word lengths, and
leading zeros. The existing `isDisjunctive_occurs_ge` then supplies arbitrarily
late occurrences as a corollary.

**Deliverable:** an unconditional theorem about the existing `Real.pi`
proposition, rather than a theorem about a newly constructed constant.

## 7. Check the full proof and record exactly what was established

Extend [Test.lean](../Test.lean) with exported-type and guarded axiom checks
for each reviewed milestone and the final theorem. Inspect hypotheses as well
as axiom lists: a theorem can pass a standard-axiom audit while still assuming
the desired density as an argument.

Keep Mathlib as the only direct external library, preserve the Lean/Mathlib
`v4.37.0-rc1` pins, and allow only `propext`, `Classical.choice`, and `Quot.sound`.
Use no `sorry`, `admit`, project-specific axiom, `native_decide` bypass, or unsafe
shortcut. Follow [AGENTS.md](../AGENTS.md) and the
[trust policy](dependencies-and-trust.md).

For each Lean milestone, run from the repository root:

```sh
lake build
lake env lean Test.lean
git diff --check
```

Review the mathematical meaning and imports separately, then update the status
documentation. Mark the conjecture proved only when the final unconditional
statement and its complete dependency chain pass these checks.

**Deliverable:** a reproducible, audited proof with a clear distinction between
proved supporting results and any remaining conjectural input.

## Suggested implementation order

`OrbitCriteria.lean` now exists for the interval reduction. The other module
names below remain organizational suggestions, not existing files.

| Milestone   | Order                        | Work                                                                            | Suggested location                                                 |
| ----------- | ---------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| M1          | First small milestone        | Interval-hitting reduction complete; general transfer B4 and cell conversion P3 remain | `PiDisjunctivity/OrbitCriteria.lean`                          |
| M2          | Next established mathematics | BBP convergence and equality with `Real.pi`                                     | `PiDisjunctivity/BBP/Series.lean`                                  |
| M3          | Next bridge                  | Finite sums, recurrence, modular reduction, and tail estimates                  | `PiDisjunctivity/BBP/Orbit.lean`                                   |
| M4          | Research milestone           | Develop and prove Step 5's missing visitation argument                          | Mathematical notes first; a Lean module once the argument is sound |
| M5          | Final assembly               | The unconditional pi theorem and its audit                                      | `PiDisjunctivity/PiProof.lean` and `Test.lean`                     |

The mathematical dependency chain is:

```text
BBP identity -> recurrence and vanishing tail --+
                                              |
NEW: universal visitation of that recurrence --+-> pi orbit visits all cells
                                                   |
existing word/interval and orbit equivalences ------+-> pi disjunctivity
```

The pilot makes the exact missing interval-hitting hypothesis explicit. The
remaining part of the first suggested milestone is B4's conditional transfer
with sufficient error margins and P3's cell conversion. Work on the Step 5 argument can
proceed while the established BBP mathematics is being formalized; completing
more infrastructure is not evidence that the open visitation problem is solved.
