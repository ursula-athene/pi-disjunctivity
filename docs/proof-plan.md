# Proof plan for hexadecimal disjunctivity of pi

**Planning baseline:** 2026-11-24, commit
`56ca22e1a9776ee7a5d7b4e36103f932d3b45646` on `feature/attempt-01`.

This is the mathematical roadmap and the owner of exact milestone contracts.
The [blueprint](proof-blueprint.md) indexes checked declarations, dependencies,
and unproved hypotheses; dated validation and publication evidence live in the
[research log](research-log.md) and linked handoffs. Follow the
[workflow](proof-workflow.md) for execution and the [meta-plan](meta-proof-plan.md)
for how evidence should change this plan and the proving process.

Next session: <!-- current-prompt --> [Current prompt: M4 Universal Visitation](session-prompts.md#current-prompt-m4-universal-visitation)
defines the full Step 5 research and acceptance scope, authorized when invoked.
Saving it starts no research. B1–B3 and the [tooling milestone](b2-improvements-handoff.md)
are complete; [the B3 handoff](b3-handoff.md) records acceptance/publication.
The [M4 handoff](m4-handoff.md) records the initial attempt's evidence and follow-up continuation.
Universal visitation remains open, and B4/P3 retain their hypotheses.

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
no Lean proofs or assumptions; later bounded milestones add the checked
reductions, conditional general lemmas, and unconditional BBP identity below.

## Overview: mathematical status and formalization work

Steps 1–4 involve established mathematics and formalization work. Step 5
requires discovering a mathematical argument. Established mathematics can
still take substantial work to implement and check in Lean.

| Step | Mathematical status | Status in this repository |
| --- | --- | --- |
| **1. Verified foundation** | Solved. | Already proved and checked in Lean, including the digit–interval and orbit equivalences. |
| **2. Isolate interval hitting** | An elementary consequence of the existing equivalences that expresses exactly what remains to prove. | Completed by the bounded pilot in `OrbitCriteria.lean`: a general equivalence and a conditional π reduction, both audited. |
| **3. Prove the BBP identity** | A classical, established theorem with published proofs. | Complete: `hasSum_bbpCoeff` proves the full `HasSum ... Real.pi` identity, using the checked term integral, pointwise series/domination, interchange, rational algebra, derivative, and FTC evaluation. Independent local proofs preserve the external-code attribution boundary. |
| **4. Connect BBP to the orbit** | The identities, tail estimates, and conditional transfer argument have standard proof methods. This plan supplies the mathematical outline. | B4, the general conditional transfer, is checked. B2 split, recurrence/range, and exact orbit identity are checked. B3 coefficient/tail bounds and decay are checked; B3 acceptance evidence is in its handoff. The conditional transfer still requires late visits. |
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
3       Completed and checked: the full BBP HasSum identity.
4       General transfer, B2 orbit bridge and B3 tail control checked; visitation is still required.
5       Open mathematical research; no complete proof method supplied.
```

Steps 2–4 have sound mathematical routes, but their Lean implementations are
not necessarily quick. Completing them supplies useful, verified infrastructure
without necessarily bringing us closer to the discovery needed for Step 5.
Steps 6–7 then assemble and audit the result once that missing argument exists.

## Viewpoint

In proving, try to keep the proof as simple as possible, proving no unneeded lemmas or theorems. When finishing a step or milestone, commit code and documentation, then go through the proof and verify that each piece is needed for the proof. Remove unnecessary pieces that don't matter to the proof's line of reasoning. Commit the results.

Make sure each functional block of Lean code is thoroughly tested. Use Lean and mathematical best practices to do that.

### Changed-file reviews with Gemini Carbon

At each milestone, review the complete task-owned diff before its initial
commit with **Gemini Carbon on High effort** through `agy`. The
[Gemini review procedure](gemini-review.md) is mandatory, including exact scope,
read-only tools, result inspection, capture, and bounded recovery. Include
relevant surrounding code and documentation; for documentation-only milestones,
review changed arguments, plans, and source assessments without inventing proof work.
Supply the [required adversarial background](gemini-review.md#select-the-adversarial-review-background)
for the milestone's subject. Retain separate defects, improvement suggestions,
and open questions with the procedure's per-item dispositions.

Request intermediate reviews when useful, especially after a substantial proof
block, a theorem-contract/dependency change, or before building on an uncertain
argument. Preserve the Viewpoint post-commit necessity review above. Obtain a
focused Gemini follow-up for substantive fixes or simplifications before
committing them. Evaluate findings independently, record fixes or reasons for
declining them, and rerun affected checks. No empty follow-up commit is required.
Record evidence and limitations in the research log or a linked report.

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
full theorem-type and guarded axiom audits in [Test.lean](../Test.lean), the
executable inventory for the foundations and subsequent BBP results. The
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

**Status: implemented and audited, 2026-11-25.** `hasSum_bbpCoeff` proves the
unconditional BBP identity in `BBP/Series.lean`, exported through the root and
guarded in `Test.lean`. The specification below records the route now completed;
see [the handoff](b1-handoff.md) for validation, review, and local commit status.
No disjunctivity or visitation claim follows from this analytic identity alone.

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

The [B1 source and proof review](b1-source-proof-review.md) inspects the original
paper and existing BBP proof development identified by
the [repository's later literature review](codex-reports/2026-11-24-lean-literature-review.md#certified-hexadecimal-digits-of-pi-metasecdevmath-proofs).
Both reviews distinguish source inspection from external rebuilds and axiom
audits, which were not performed. The BBP assessment verifies the coefficients,
analytic conditions, and pinned-library signatures. Use the scaled kernel on
`[0,1]`, retain the `HasSum` produced by dominated convergence, and write the
local proof independently. Do not import, vendor, or translate the external
Apache-2.0 code under the current attribution policy. The report records the
license distinction and the exact remaining local proof obligations.

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

<a id="next-bounded-task-conditional-interior-margin-transfer"></a>

### Completed bounded task: conditional interior-margin transfer

**Status: checked and audited, 2026-11-25.** B4 and P3 in
[the blueprint](proof-blueprint.md#remaining-bbp-route) are implemented as
`hitsOpenIntervals_fract_add_of_tendsto_zero` and
`hitsHexadecimalIntervals_of_hitsOpenIntervals` in `OrbitCriteria.lean`,
exported through the existing root import. The specification below is retained
for review; its earlier next-task anchor preserves the session-prompt link.

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

**Endpoint met:** both general lemmas are in `OrbitCriteria.lean`, with complete
exported-type checks and guarded axiom audits in `Test.lean`. `lake build`,
`lake env lean Test.lean`, and `git diff --check` passed. The two observed axiom
lists are exactly `propext`, `Classical.choice`, and `Quot.sound`. The universal
proofs cover both endpoint targets, errors of either sign, and zero/first/last
cells; no extra helper theorem or example was needed. The late-visitation
hypothesis remains unproved for the particular BBP recurrence. This milestone
stops before BBP definitions, series, recurrences, tails, and Step 5.

<a id="next-bounded-task-b1-source-and-proof-review"></a>

### B1 source and proof review record

The authorized documentation-only assessment is in
[the B1 review](b1-source-proof-review.md): original paper and external revision,
license/attribution decision, a complete classical argument, pinned-Mathlib API
premises, and a minimal implementation slice. Its final section records the
required Gemini Carbon High review and limitations. No BBP declaration or code
adaptation was added, and no external build or axiom audit is claimed.
At that source-review baseline B1 remained **known / unformalized**. See the
[research log](research-log.md) for validation and the final handoff record.

<a id="next-bounded-task-b1a-coefficient-and-one-term-integral"></a>

### Completed bounded task: B1a coefficient and one-term integral

**Checked and audited, 2026-11-25.** The separately authorized
[B1a slice](b1-source-proof-review.md#smallest-implementation-slice-proposed-for-authorization)
adds only `bbpCoeff : ℕ → ℝ` and the unconditional `integral_bbpTerm (j : ℕ)`
in [Series.lean](../PiDisjunctivity/BBP/Series.lean), exported through the root.
The theorem identifies the integral of
`(x^8/16)^j * (4 - 2*x^3 - x^4 - x^5)` on `[0,1]` with
`bbpCoeff j / (16 : ℝ)^j` for every natural `j`, including zero.

The independent proof expands four monomials, supplies their interval
integrability by continuity, applies integral linearity and `integral_pow`,
and normalizes natural casts and real algebra. No public helper, separate
summand definition, coefficient bound, or convergence premise was added.
The coefficient body is exposed for root-import checks. `Test.lean` preserves
all nineteen earlier audits and guards the new theorem's actual axiom list:
`propext`, `Classical.choice`, `Quot.sound`. It checks the coefficient expression
and `bbpCoeff 0 = 47/15` as well as the exact universal theorem type.

`lake build`, `lake env lean Test.lean`, and `git diff --check` pass. Review and
commit/necessity evidence are recorded in [the B1a handoff](b1a-handoff.md) and
[research log](research-log.md). At the B1a endpoint, B1 as a whole was still
**known / unformalized**: no infinite interchange, integral evaluation, or π
series theorem had been proved. This milestone stops before those tasks and B2/B3/V.

<a id="next-bounded-task-b1b-pointwise-series-and-domination"></a>

### Completed bounded task: B1b pointwise series and domination

**Checked and audited, 2026-11-25.** On `x ∈ Set.Icc (0 : ℝ) 1`, write
`q(x) = x^8/16`, `P(x) = 4 - 2*x^3 - x^4 - x^5`, and
`K(x) = P(x)/(1-q(x))` as mathematical abbreviations. The independent proofs in
[Series.lean](../PiDisjunctivity/BBP/Series.lean) establish exactly:

```text
hasSum_bbpTerm: ∀ x ∈ Set.Icc (0 : ℝ) 1,
  HasSum (fun j : ℕ => q(x)^j * P(x)) (K(x))
norm_bbpTerm_le: ∀ j : ℕ, ∀ x ∈ Set.Icc (0 : ℝ) 1,
  ‖q(x)^j * P(x)‖ ≤ 8*(1/16)^j
```

The proofs bound `0 ≤ q(x) ≤ 1/16`, explicitly obtain `0 < 1-q(x)`,
apply Mathlib's geometric `HasSum` and multiplication, and combine power
monotonicity with the polynomial absolute bound. All helper facts are local;
no new definitions or public helper API are introduced. The existing root
import exports both results. `Test.lean` preserves all twenty earlier audits
and adds the complete types, actual guarded axiom lists, both endpoints,
and `j = 0`. Validation and review evidence are in [the handoff](b1b-handoff.md).
This milestone stops before interchange and integral evaluation.

<a id="next-bounded-task-b1c-sumintegral-interchange"></a>

### Completed bounded task: B1c sum/integral interchange

**Checked and audited, 2026-11-25.** `hasSum_bbpCoeff_integral` proves exactly

```text
HasSum (fun j : ℕ => bbpCoeff j / (16 : ℝ)^j)
  (∫ x in (0 : ℝ)..1, (4 - 2*x^3 - x^4 - x^5) / (1 - x^8/16))
```

B1a and B1b supply the term integral, pointwise series, and domination. The
proof uses pinned Mathlib's `intervalIntegral.hasSum_integral_of_dominated_convergence`:
polynomial continuity supplies strong measurability for volume restricted to
`Set.uIoc 0 1`; the explicit inclusion in `Set.Icc 0 1` supplies the bounds and
pointwise sums. The geometric majorant `8*(1/16)^j` is summable, and its sum is
constant in `x`, hence interval integrable. All five premises are discharged
locally, then `integral_bbpTerm` rewrites the summands while retaining `HasSum`.
No extra analytic hypotheses or public helper API are introduced. The root
import and complete type/axiom audit cover the new declaration. See the
[handoff](b1c-handoff.md) for validation, required review, and commit status.

At the B1c endpoint the integral was unevaluated, and no antiderivative/FTC,
full B1, B2/B3, or V work had been begun. The direct `HasSum` route and B1-before-B3 order remain appropriate.

<a id="next-bounded-task-b1d-rational-kernel-decomposition"></a>

### Completed bounded task: B1d and full B1 completion

**Checked and audited, 2026-11-25.** After B1c, the user authorized completing
B1 in one combined cycle. `bbpKernel_eq_partialFractions` establishes T4 from
[the assessed argument](b1-source-proof-review.md#3-evaluate-the-rational-integral):
for `x ∈ Set.Icc (0 : ℝ) 1`,

```text
(4 - 2*x^3 - x^4 - x^5)/(1-x^8/16)
  = (-4*x)/(2-x^2) - 4*(x-2)/(x^2-2*x+2).
```

Denominator conditions are discharged locally from `x^2 ≤ 1`, `x^8 ≤ 1`,
and `(x-1)^2 ≥ 0`. `hasDerivAt_bbpPrimitive` proves, on the entire closed interval,
that `2*log(2-x^2) - 2*log(x^2-2*x+2) + 4*arctan(x-1)` has derivative equal
to the original kernel. Positive log arguments supply the chain-rule premises.
The kernel is continuous on `[0,1]`, hence interval integrable. FTC and exact
log/arctangent endpoint values give `integral_bbpKernel`, the unconditional
integral equality with `Real.pi`. `hasSum_bbpCoeff` rewrites the existing B1c
bridge with that equality, completing B1 and M2 without changing B1c.

All four results have complete root-import type/axiom guards; the prior 23
checks and boundary regressions remain intact. No primitive/kernel definition,
unused factorization lemma, general analytic API, or new import was introduced.
See [the handoff](b1-handoff.md) for the validation and required review evidence.
At that B1 endpoint, B2/B3, V, Hπ, T, and π disjunctivity remained open;
B4/P3 kept every hypothesis.

<a id="next-bounded-task-b2a-finite-prefix-and-tail-split"></a>

<a id="next-bounded-task-b2-complete-orbit-bridge"></a>

### B2 complete orbit bridge

**Complete, checked, reviewed, committed, and pushed, 2026-11-25.**
The user invoked the
[complete B2 prompt](session-prompts.md#current-prompt-b2-complete-orbit-bridge),
superseding its pre-merge branch instructions: PR #5 is verified merged, and
`feature/attempt-07-b2-orbit` starts from updated `main` at `c3b3bd1`.
Existing branches and unrelated work are preserved. This execution sequence
was recorded before implementation. All steps below form one authorized milestone, ending before
B3 or visitation work; push completed commits regularly and open no PR.

1. **B2a: finite-prefix/tail split.** Use the full B1 `HasSum` to establish,
   for every `n : ℕ`, the convergent scaled tail identity below and identify
   the tail `R_n` with its convergent sum, giving `16^n*pi = S_n + R_n`.
2. **Recurrence and range.** Define `y_0 = 0`,
   `y_(n+1) = fract(16*y_n + A(n))`; prove `0 ≤ y_n < 1` and
   `y_(n+1) = fract(S_n)` using the finite-sum recurrence.
3. **Exact orbit bridge.** Prove
   `fract((16 : ℝ)^n * Real.pi) = fract(y_(n+1) + R_n)` unconditionally.
4. **Acceptance and finalization.** Probe definitions/equations and full theorem
   interfaces through the root before dependent layers; preserve prior audits,
   add actual axiom guards and theorem-instantiating boundary checks. Validate
   Lean, offline process/docs checks, preservation, and staged scope. Obtain
   Carbon High review at useful internal checkpoints and of the complete owned
   milestone diff before its commit. Commit and push reviewed work, inspect
   proof necessity after committing, and record a durable B2 handoff. Review
   and validate substantive follow-up fixes; do not make an empty commit.

The B2a contract is unchanged:

```text
HasSum (fun r : ℕ => bbpCoeff (n+r+1) / (16 : ℝ)^(r+1))
  ((16 : ℝ)^n * Real.pi -
    ∑ j ∈ Finset.range (n+1), (16 : ℝ)^(n-j) * bbpCoeff j)
```

Check the inclusive prefix `0..n`, tail starting at `n+1`, natural-exponent
subtraction only under `j ≤ n`, and `n = 0`. Keep convergence in the result;
no tail estimate or visitation hypothesis is a premise. Check the recurrence
initialization, the coefficient `A(n+1)` in `S_(n+1) = 16*S_n + A(n+1)`,
and the orbit/recurrence index offset. Export/audit, validate, review, commit,
perform the necessity review, and hand off all of B2 together. Stop before
B3 tail bounds/decay, optional modular computation support, or V. B2 alone
does not complete M3/Step 4. Use a focused `BBP/Orbit.lean` module with exposed
`bbpPartialSum`, `bbpTail`, and independently recursive `bbpRecurrence`.
Retain both the exact B2a `HasSum` and a `HasSum` identifying the defined tail;
the total `tsum` definition alone is not convergence evidence. Keep finite-sum
helpers local unless a proof or audit consumer requires them. Multiplication
by integer 16 preserves fractional parts modulo integers; do not use linearity
or a global Lipschitz assertion for `Int.fract`.

**Checked endpoint:** [Orbit.lean](../PiDisjunctivity/BBP/Orbit.lean) exports
`hasSum_bbpTail_sub`, `hasSum_bbpTail`,
`pow_mul_pi_eq_bbpPartialSum_add_bbpTail`, `bbpRecurrence_mem_Ico`,
`bbpRecurrence_succ_eq_fract_bbpPartialSum`, and
`fract_pow_mul_pi_eq_bbpRecurrence_add_bbpTail`. Private prefix zero/successor
lemmas support recurrence induction. The integer witness
`-16 * ⌊bbpPartialSum n⌋` explicitly justifies the fractional-part step.
Root equations, full types, actual axiom guards, and zero/first-index checks
are in `Test.lean`. The [handoff](b2-handoff.md) records validation and acceptance;
[review evidence](agy-reports/b2-review.md) includes the reviewed/pushed B2a
checkpoint and the completed full-milestone review. Post-commit necessity
inspection found no justified substantive simplification; final receipt details
are in the handoff. B2 does not discharge B3 or V.

<a id="next-bounded-task-b3-tail-control"></a>

### B3 tail control

**Complete, checked, reviewed, committed, pushed and inspected for necessity, 2026-11-25.** Starting from `ae4a0e3` on
`feature/attempt-08-b3`, preserve unrelated Obsidian, notes and papers.
The invoked B3 prompt authorized this sequence, recorded before implementation:

1. Verify the coefficient estimate using positive denominators and the triangle
   inequality; probe its full root-import interface before tail composition.
2. Reuse `hasSum_bbpTail`, bound each term by the coefficient bound at `n+1`
   times `16^(-(r+1))`, and evaluate the summable geometric majorant as `1/15`.
   Check this substantial estimate block at an intermediate Carbon review.
3. Prove decay by squeezing with the explicit bound; probe the B4 input with
   its arbitrarily-late-visitation premise retained. Extend exact type, actual
   axiom, and theorem-instantiating zero/first-index audits.
4. Complete kernel, offline process/docs, preservation and staged checks; review
   the entire owned diff with Carbon High, resolve findings, write the handoff
   and retrospective, commit, inspect proof necessity, and push/verify the branch.

Acceptance requires all three unconditional results below, no new trust or
analytic premises, and the complete review/validation/publication evidence.
The coefficient denominators are positive for all natural indices; replacing
all four by `8*j+1` gives numerator `4+2+1+1=8`. For the tail,
`n+r+1 ≥ n+1` and `∑ r≥0, 16^(-(r+1)) = 1/15`, giving the stated constant.
The pre-implementation same-session criticism found no missing mathematical
premise. Lean subsequently checked denominator order, casts, summability and
the limit; the criticism was not independent certification.

The checked Step 4 bounds and decay are
`|bbpCoeff j| ≤ 8/(8*(j : ℝ)+1)` and
`|bbpTail n| ≤ 8/(15*(8*(n : ℝ)+9))`, and
`Filter.Tendsto bbpTail Filter.atTop (nhds 0)`. The root-exported
`abs_bbpCoeff_le`, `abs_bbpTail_le`, and `tendsto_bbpTail` in
[Tail.lean](../PiDisjunctivity/BBP/Tail.lean) have no analytic or visitation
hypothesis. Local geometric `HasSum` and norm comparison reuse B2 convergence;
a reciprocal bound and squeeze prove decay. `Test.lean` guards complete types,
actual axioms, zero/first indices and a B4 interface audit at recurrence index
`n+1` with its late-visit premise explicit. The [handoff](b3-handoff.md) and
[review report](agy-reports/b3-review.md) own acceptance evidence. Stop before
modular computation, visitation research or final conjecture assembly.

## 5. Prove the missing universal visitation theorem

**Status: M4 incomplete after bounded research on 2026-11-26.** No unconditional
visitation argument was found. The [argument assessment](m4-visitation-obstruction.md)
records exact countermodels and source/recovery gaps; the
[handoff](m4-handoff.md) owns validation and review evidence.

<a id="m4-research-sequence--2026-11-26"></a>

### Initial M4 research sequence — 2026-11-26 snapshot

The current prompt was invoked at `b7c3bca` on
`feature/attempt-09-b4`; the initial attempt used `feature/m4-universal-visitation`.
The exact acceptance contract is

```text
∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
  ∀ N : ℕ, ∃ n ≥ N, bbpRecurrence (n + 1) ∈ Set.Ioo a b
```

Keep the fixed initialization, every real interval (including endpoints 0 and
1), every natural threshold, and the recurrence/orbit offset. The initial
attempt selected the following finite sequence. Its numerical quotas describe
that attempt, not the continuing authorization or the acceptance contract:

1. **Source and dichotomy audit:** at most two primary source assessments and
   two targeted discovery passes. Extract the precise weak-dichotomy premise,
   its indexing, and the first missing implication for the actual BBP forcing.
   Success means an applicable unconditional mechanism, or a documented gap;
   a conditional theorem does not discharge V.
2. **Permanent-avoidance test:** at most three explicit candidate implications
   using expansion, coefficient structure, or rational approximation. Challenge
   each with an exact nondense model or a quantified estimate. Search the pinned
   library before proposing new supporting theory. Retain only candidates that
   identify genuinely new BBP-specific input.
3. **Bounded recovery:** if the central gap persists, test at most two materially
   different representations/connections (symbolic avoidance, arithmetic, or
   TRIZ separation of scales), with a falsifiable claim and evidence sought.
   Continue only when a result identifies a justified new test; do not silently
   extend the bounds or substitute peripheral formalization for the missing step.
4. **Criticism and acceptance:** submit the strongest candidate/obstruction and
   intended interfaces to Carbon with both guides. Formalize a surviving argument
   only with all premises justified; export and audit unconditional V, instantiate
   boundaries and the B2/B3/B4 consumer, and complete all mandated checks/reviews.
   If bounded recovery leaves no justified next step, record M4 incomplete with
   exact remaining obligations, reviewed evidence, retrospective and handoff.

The invoked scope includes local commits and post-commit necessity inspection;
it excludes M5 export/assembly, push, PR, dependency/tool/permission changes,
and unrelated files. The initial attempt treated a reviewed obstruction as a
stopping outcome, not acceptance of M4. The persistence correction below
supersedes that stopping decision. The existing B4 interface audit still assumes V.

**Cycle outcome:** the source audit, three avoidance candidates and two recovery
candidates reached the same missing BBP-specific implication. Positive rational
forcing with the BBP leading asymptotic can avoid intervals; generic irrationality,
complexity and approximation arguments do not repair the gap. Modular residue
coverage remains a reformulation without a new estimate. These tested generic
routes were suspended; no justified new estimate emerged within this cycle.
The source finite-limit argument and its translation are not new exported Lean
theorems.

### M4 continuation after the persistence correction — 2026-11-26

The user reaffirmed sustained M4 research and requested durable instructions
against premature stopping. Follow the
[persistence protocol](meta-proof-plan.md#persistence-and-stopping-conditions)
and current prompt. The initial quotas are exhausted experiments, not an
exhausted milestone. Keep their valid negative results and generate materially
different questions within the same exact V contract. Discovering a BBP-specific
estimate is authorized work; it need not be available before continuing.

Before each new cycle, record in the research log its question, unused structure
or unresolved bridge, evidence sought and finite reassessment point; revise this
plan when the route or contract changes. Test candidates against
the recorded countermodels; criticize the central argument before downstream
formalization. If none survives, change the discovery question and continue.
Only the exact unconditional theorem, root export, guarded audits, B2/B3/B4
integration and mandated checks/reviews accept M4. An obstruction review or
partial-result commit is an internal checkpoint. Actual interruptions preserve
the next inquiry and leave V/M4 incomplete; M5 remains outside this scope.

The later [positive-transform assessment](m4-catalan-transforms.md) proves
usable exact enclosures but bounds their common-prefix window uniformly even
when cancellation order grows. Further acceleration alone is suspended as a
way to transfer a complete rational-period occurrence guarantee. The
[rational-forcing assessment](m4-rational-forcing.md) also separates every
finite tail jet from visitation and retains the loss of irrationality in
those models. None of these diagnostics discharges the fixed V contract.
The [Pade residual](m4-pade-residues.md) and
[signed-evaluation assessment](m4-signed-evaluation.md) provide an actual modular
gain, exact signed formula and primitive denominator/height tradeoff, but no
compatible selection theorem or visit. The same residue prescription cannot
be repaired solely by retaining the sign and interval hull of its tail.
The [backward 2-adic interpolation](m4-two-adic-reflection.md) proves a zero
reflected anchor and exact residue permutations for the actual prefixes.
An [analytic avoiding model](m4-two-adic-models.md) retains these, irrationality
and exponential prefix heights, but drops the rational forcing and its
polynomial coefficient height. Current discovery asks whether that actual
rational structure can control the odd-denominator factors in a local/global
character comparison. The bridge to real fractional parts remains unproved.
The research log owns each finite bound and outcome; no visitation gain from
the local invariant alone is assumed in the roadmap.

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

**Deliverable:** an unconditional proof of the visitation statement through the
M4 acceptance checks. At an actual interruption under the persistence protocol,
retain an incomplete checkpoint with the remaining unproved obligation and
next inquiry; that record does not complete M4 or authorize stopping early.
No completion date or guaranteed method follows from the plan.

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

`OrbitCriteria.lean`, `BBP/Series.lean`, `BBP/Orbit.lean`, and `BBP/Tail.lean` now exist for
M1/M2 and B2/B3. Future module names are organizational suggestions.

| Milestone   | Order                        | Work                                                                            | Suggested location                                                 |
| ----------- | ---------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| M1          | First small milestone        | Complete: interval-hitting reduction, general transfer B4, and cell conversion P3 | `PiDisjunctivity/OrbitCriteria.lean`                          |
| M2          | Completed supporting theorem | Complete: BBP convergence and equality with `Real.pi`                                     | `PiDisjunctivity/BBP/Series.lean`                                  |
| M3          | Arithmetic bridge checked    | B2 orbit identity and B3 tail control checked; transfer remains conditional on V; modular reduction optional | `PiDisjunctivity/BBP/Orbit.lean`, `PiDisjunctivity/BBP/Tail.lean` |
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

The pilot makes the exact missing interval-hitting hypothesis explicit. B4's
conditional transfer and P3's cell conversion complete M1. The full checked
B1 identity completes M2. B2 supplies the exact orbit bridge and B3 supplies
vanishing error, completing the required M3 arithmetic infrastructure. The B4
transfer still needs V. B3 acceptance is recorded in its handoff. Step 5 research
was authorized by the invoked M4 prompt; its bounded outcome is incomplete.
Completing more infrastructure is not evidence that the open visitation problem
is solved. Use the M4 handoff before proposing a new research cycle.
