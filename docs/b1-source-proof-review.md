# B1 source and proof review

**Subsequent implementation status (2026-11-25):** this is the completed B1
source-review record. The separately authorized [B1a milestone](b1a-handoff.md)
now checks T1 (`integral_bbpTerm`) and `bbpCoeff`. References below to T1 as
unproved or proposed describe the source-review baseline. T2–T4, the analytic
interchange/evaluation, and the final B1 `HasSum` theorem remain unproved.

Review date: 2026-11-25. Baseline: `a3feb6bf02cea0aafdba29331e551d9e8173477d`
on `feature/attempt-02`. Completion of this documentation-only milestone is
recorded in [the source-review handoff](b1-review-handoff.md).
No BBP Lean declaration or external-code adaptation is included.

**Assessment:** the specified B1 identity has a complete classical analytic
argument compatible with the pinned Mathlib API. Its local Lean proof remains
unfinished. Recommend an independently written termwise-integral slice first;
do not import or translate the external development. B1 precedes B3 as before.
The independent Gemini review record is [below](#gemini-review-and-disposition).

## Sources, revisions, and evidence limits

### Original identity

Inspected Bailey, Borwein, and Plouffe, *On the Rapid Computation of Various
Polylogarithmic Constants*, Mathematics of Computation 66 (1997), 903–913,
[author-hosted PDF](https://www.davidhbailey.com/dhbpapers/digits.pdf), Theorem 1,
equations (1.2)–(1.4), PDF page 3. Retrieved 2026-11-25; the PDF has no Git
revision. Its SHA-256 is
`ee6c1f95f17ba7a7b9dcb09005c4f1d2d6a73d142694ac9af695811fa52ac9a2`.
The displayed page was rendered locally and inspected, in addition to extracted
text. The theorem starts at index zero and has exactly the coefficient in this
review. The proof integrates a geometric expansion on `[0,1/√2]`, substitutes
`y = √2 x`, and leaves the rational integral evaluation to partial fractions.
That abbreviated calculation does not discharge our Lean obligations.

### External Lean development

Inspected the literature report's exact snapshot of
[`metasecdev/math-proofs`](https://github.com/metasecdev/math-proofs/tree/e5376424f932afdbf529c696f985e516836e6601),
commit `e5376424f932afdbf529c696f985e516836e6601`. No claim is made about a newer
default branch. The relevant namespace is `FinitistProved`.

| Inspected file | Relevant content and assessment |
| --- | --- |
| [BBPAlgebra.lean](https://github.com/metasecdev/math-proofs/blob/e5376424f932afdbf529c696f985e516836e6601/Thoughts/Proved/BBPAlgebra.lean#L11) | `bbpCoeff` is precisely `A`; `bbpSummand k = bbpCoeff k / (16 : ℝ)^k`. The cast of natural `k` occurs in real arithmetic. Imports three Mathlib modules only. |
| [BBPPiIdentity.lean](https://github.com/metasecdev/math-proofs/blob/e5376424f932afdbf529c696f985e516836e6601/Thoughts/Proved/BBPPiIdentity.lean#L14) | All 224 substantive lines inspected. `integral_pow_bbp` needs `1 ≤ j`; `term_integral` is unconditional in `k`; `hasSum_kernel` and `hasDerivAt_bbpAntideriv` require `x ∈ Icc 0 1`. `bbpSeries_eq_integral`, `integral_bbpKernel`, and `bbpSeries_eq_pi` have no mathematical assumptions. The last conclusion is literally `bbpSeries = Real.pi`. |
| [BBPSeries.lean](https://github.com/metasecdev/math-proofs/blob/e5376424f932afdbf529c696f985e516836e6601/Thoughts/Proved/BBPSeries.lean#L39) | `bbpSeries` is a `tsum`; `summable_bbpSummand` separately proves convergence. `BBPPiEqualsSeries` is a proposition definition, not an axiom. The identity file proves it as `bbpPiEqualsSeries_proved`; conditional consumers in this file alone must not be confused with that proof. Imports `Mathlib`, `BBPAlgebra`, and `BBPTail`. |
| [BBPTail.lean](https://github.com/metasecdev/math-proofs/blob/e5376424f932afdbf529c696f985e516836e6601/Thoughts/Proved/BBPTail.lean#L28) | Inspected the imports and coefficient/summand-bound proof bodies used by `summable_bbpSummand`: `bbpCoeff_abs_le` and `bbpSummand_abs_le`. Imports `Mathlib` and `BBPAlgebra`. The remaining computational/tail development was not mathematically reviewed. No local B3 work follows from this source inspection. |

The identity file imports Mathlib's `Integrals.Basic`, `Log.Deriv`,
`Trigonometric.ArctanDeriv`, and `Integral.DominatedConvergence`, plus the two
external modules above. Its proof constructs a `HasSum` of the integrated terms
before taking `.tsum_eq` (lines 139–152). Thus the source contains convergence
evidence, although its exported equality alone does not state it. Our endpoint
will retain that stronger `HasSum` result.

The four inspected analytic-layer files were scanned for prohibited proof
constructs; the only textual match was a comment saying there was no `sorry`.
This is **source inspection**, not independent rebuilding, kernel checking, or
a transitive axiom audit of external theorems or their Mathlib imports.
No external Lean code was copied into this repository, compiled, or installed.
Disposable source copies used for inspection are outside the checkout in `/tmp`.

External configuration:

- [lean-toolchain](https://github.com/metasecdev/math-proofs/blob/e5376424f932afdbf529c696f985e516836e6601/lean-toolchain):
  `leanprover/lean4:v4.29.0-rc8`.
- [lakefile.lean](https://github.com/metasecdev/math-proofs/blob/e5376424f932afdbf529c696f985e516836e6601/lakefile.lean)
  and [manifest](https://github.com/metasecdev/math-proofs/blob/e5376424f932afdbf529c696f985e516836e6601/lake-manifest.json):
  sole direct library Mathlib at `816ff4582a01b10567d1d4ecb10be7c4ff92aab4`,
  with its inherited dependencies; default library `Thoughts` and a separate
  non-default heavy-certificate target.
- [Thoughts.lean](https://github.com/metasecdev/math-proofs/blob/e5376424f932afdbf529c696f985e516836e6601/Thoughts.lean)
  imports the identity among a much larger development. Its header records
  upstream provenance from `metasecdev/irrational-gap-mobius` at `ad5468ae...`;
  that upstream history was not independently audited.
- [CI](https://github.com/metasecdev/math-proofs/blob/e5376424f932afdbf529c696f985e516836e6601/.github/workflows/ci.yml)
  runs the build, `Thoughts/Axioms.lean`, and a checking script.
  [The audit source](https://github.com/metasecdev/math-proofs/blob/e5376424f932afdbf529c696f985e516836e6601/Thoughts/Axioms.lean)
  includes `#print axioms FinitistProved.bbpSeries_eq_pi`. We inspected the
  configuration, not a successful run or the resulting axiom output; no CI claim
  is adopted as local validation.

Retrieval limitations: the identity header's `docs/H04_PROOF_PLAN.md` returned
GitHub 404 at this snapshot. Its unavailable planning text is unnecessary to
inspect the actual proof. Web PDF screenshots did not supply a usable image;
the initial shell download failed sandbox DNS resolution, then the scoped
approved download succeeded. Existing macOS PDFKit rendered page 3 because
Poppler/Python PDF packages were unavailable. No tooling was installed.

### License and attribution decision

The external [LICENSE](https://github.com/metasecdev/math-proofs/blob/e5376424f932afdbf529c696f985e516836e6601/LICENSE)
is **Apache License 2.0**. Its
[NOTICE](https://github.com/metasecdev/math-proofs/blob/e5376424f932afdbf529c696f985e516836e6601/NOTICE)
identifies the external copyright holder and applies Apache 2.0 to the Lean code,
scripts, and other files outside `paper/`; the paper's text is **CC BY 4.0**.
The external holder is Brian Bernard Taylor. This is source provenance, not
an authorship credit for any project file.

For redistributed adaptations, Apache 2.0 §4 requires the license, notices of
modified files, retention of applicable source notices, and applicable NOTICE
attribution. Adding an MIT header with only Ursula Athene would not satisfy
those requirements. Apache 2.0 and MIT are not categorically incompatible;
the obstacle is the current project's attribution-only-to-Ursula policy and
the lack of authorization to adapt code. Do not strip or replace notices.

**Decision:** independently write future Lean proofs from the mathematical
argument and pinned Mathlib API, cite the paper and this source assessment,
and do not port tactic scripts or external helper code. A request to adapt
external code would require a separate user decision on applicable notices and
policy; this milestone makes no such change. Merely renaming or rearranging
copied proofs would not be an independent implementation. Mathlib remains the
only direct external library; importing an external project remains prohibited
even if its own direct dependency is also Mathlib.

## Mathematical argument and criticism

All symbols in this section are mathematical abbreviations, not project
declarations. All division is real division, `j : ℕ`, and powers have natural
exponents. Define

\[
A(j)=\frac4{8j+1}-\frac2{8j+4}-\frac1{8j+5}-\frac1{8j+6},\quad
P(x)=4-2x^3-x^4-x^5,\quad q(x)=x^8/16,
\]
\[
f_j(x)=q(x)^jP(x),\qquad K(x)=\frac{P(x)}{1-q(x)}.
\]

The target is `HasSum (fun j : ℕ => A(j) / (16 : ℝ)^j) Real.pi`.
There is no digit-index shift here: this is the series index starting at zero.
`8*(j : ℝ)+d > 0` for `d = 1,4,5,6`, and `16^j > 0` for every `j`, including
zero. Consequently the divisions are valid analytic divisions, not uses of
Lean's totalized value at a zero denominator. As a sign/index check, `A(0)=47/15`.

### 1. Integrate one term

The functions involved are polynomials multiplied by real constants, hence
continuous and interval integrable on `[0,1]`. Natural-power identities give

\[
f_j(x)=16^{-j}(4x^{8j}-2x^{8j+3}-x^{8j+4}-x^{8j+5}).
\]

For every natural `n`, `∫₀¹ x^n dx = 1/(n+1)`. Apply this at the four exponents,
and integral linearity, with integrability supplied for each subtraction:

\[
\int_0^1 f_j(x)\,dx=A(j)/16^j. \tag{T1}
\]

At `j=0` the first monomial is `x^0=1`, including at `x=0`; no negative power
or subtraction of natural exponents is needed. Cast `(8*j+c : ℕ)+1` into the
reals explicitly when matching the four denominators.

### 2. Justify the infinite interchange and convergence

For `0 ≤ x ≤ 1`, `0 ≤ q(x) ≤ 1/16 < 1`, so the geometric series has sum
`(1-q(x))⁻¹`. Multiplying by `P(x)` gives

\[
\operatorname{HasSum}(j\mapsto f_j(x),K(x)). \tag{T2}
\]

Triangle inequality gives `|P(x)| ≤ 4+2+1+1 = 8`, so
`|f_j(x)| ≤ 8(1/16)^j`. The latter sequence is summable, and its sum is the
constant `128/15`, integrable on the finite interval. Each `f_j` is continuous,
hence almost everywhere strongly measurable for volume restricted to `(0,1]`.
These facts satisfy every premise of the interval dominated-convergence theorem
for series, yielding

\[
\operatorname{HasSum}\left(j\mapsto\int_0^1 f_j(x)\,dx,
  \int_0^1 K(x)\,dx\right). \tag{T3}
\]

Use T1 to rewrite the summands. This proves convergence as well as the integral
value, with no preliminary definition of a totalized `tsum` constant and no
separate coefficient/tail theory. The bound also proves uniform absolute
convergence mathematically, but a second uniform-convergence formalization is
unnecessary. Pointwise convergence alone would not justify the interchange.
The almost-everywhere premises use `uIoc 0 1 = Ioc 0 1`, a subset of `Icc 0 1`;
our pointwise bounds cover both endpoints as well.

### 3. Evaluate the rational integral

Write `D(x)=2-x²` and `Q(x)=x²-2x+2=(x-1)²+1`. On `[0,1]`,
`D(x) ≥ 1`, `Q(x) ≥ 1`, and `1-q(x) ≥ 15/16`. Thus the kernel is continuous
there; its interval integrability is an explicit FTC obligation. Elementary
polynomial identities give

\[
P(x)=(1-x)(x^2+2)(x^2+2x+2),
\]
\[
16-x^8=D(x)(x^2+2)(x^2+2x+2)Q(x).
\]

The canceled factors are positive on `[0,1]`; equivalently clear all nonzero
denominators and verify the polynomial identity. It follows that

\[
K(x)=\frac{16(1-x)}{D(x)Q(x)}
    =\frac{-4x}{D(x)}-\frac{4(x-2)}{Q(x)}. \tag{T4}
\]

This also matches the paper's transformed integrand:
`(x²-2)Q(x)=x⁴-2x³+4x-4`. A convenient primitive is

\[
F(x)=2\log D(x)-2\log Q(x)+4\arctan(x-1).
\]

The positive log arguments ensure differentiability at every point of `[0,1]`,
including its endpoints (ordinary derivatives are local). The chain rule gives
`F'(x) = -4x/D(x) - 2(2x-2)/Q(x) + 4/(1+(x-1)²) = K(x)` by T4.
Hence FTC gives `∫₀¹ K = F(1)-F(0)`. At one both logs are `log 1` and the
arctangent is zero, so `F(1)=0`. At zero the two `log 2` terms cancel and
`arctan(-1)=-π/4`, so `F(0)=-π`. Thus the integral equals Mathlib's `Real.pi`,
using its exact theorem `Real.arctan_one`, not a new definition of π. Combining
this with T3 and T1 yields the requested B1 `HasSum`.

This primitive and the scaled-kernel route are also present in the inspected
external proof. The reasoning above checks the algebra, analytic conditions,
and endpoints explicitly; it is not a claim of a novel identity or an
independent origin for that route. Future Lean scripts must be written locally.

### Criticism and retained obligations

The classical argument closes mathematically without a distribution hypothesis.
The following remain **unproved in this project**: T1, T2, the domination and
measurability instances for T3, T4, differentiability of F, integrability of K,
endpoint simplification, and their assembly into the B1 theorem. Library
signature probes check API availability, not any of these application proofs.
No positivity of the combined coefficient is required; the absolute majorant
handles all signs. No improper integral, endpoint limit, square-root change of
variables, special logarithm identity, or branch choice is needed in this route.

Neither this argument nor the external digit certificates produce visits of
the BBP recurrence. B2, B3, V, Hπ, T, and the π disjunctivity conjecture remain
unfinished; B4 still assumes vanishing error and arbitrarily late visits, and
P3 still assumes open-interval visits.

## Pinned Mathlib dependency map

Local Lean and Mathlib remain `v4.37.0-rc1`; the local Mathlib checkout and
manifest both give `31ce06eaadf4a200c0e1407c5f10953cf606b8f8`.
The links below pin that revision. Each entry specializes to real functions,
natural indices, ordinary summation, and volume measure unless stated otherwise;
all relevant nontrivial hypotheses are included. No external helper is available
as a local declaration.

| Obligation | Existing API, complete premises for this specialization, and remaining application work |
| --- | --- |
| T1 monomial evaluation | Root-level [`integral_pow`](https://github.com/leanprover-community/mathlib4/blob/31ce06eaadf4a200c0e1407c5f10953cf606b8f8/Mathlib/Analysis/SpecialFunctions/Integrals/Basic.lean#L173): for any `a b : ℝ`, `n : ℕ`, integral is `(b^(n+1)-a^(n+1))/((n:ℝ)+1)`; no side hypothesis. Normalize at 0 and 1 and cast exponents. |
| T1 linearity | [`intervalIntegral.integral_sub`](https://github.com/leanprover-community/mathlib4/blob/31ce06eaadf4a200c0e1407c5f10953cf606b8f8/Mathlib/MeasureTheory/Integral/IntervalIntegral/Basic.lean#L796) needs `IntervalIntegrable f volume a b` and the same for `g`; [`integral_const_mul`](https://github.com/leanprover-community/mathlib4/blob/31ce06eaadf4a200c0e1407c5f10953cf606b8f8/Mathlib/MeasureTheory/Integral/IntervalIntegral/Basic.lean#L822) has no integrability premise for real scalars/functions. `Continuous.intervalIntegrable` supplies the subtraction premises from continuity, for any real endpoints and locally finite measure (volume qualifies). |
| T2 geometric series | [`hasSum_geometric_of_lt_one`](https://github.com/leanprover-community/mathlib4/blob/31ce06eaadf4a200c0e1407c5f10953cf606b8f8/Mathlib/Analysis/SpecificLimits/Basic.lean#L317): `0 ≤ r` and `r < 1` imply `HasSum (fun n : ℕ => r^n) (1-r)⁻¹`. `HasSum.mul_right` multiplies every term and sum by any fixed real. Prove the ratio bounds from `x ∈ Icc 0 1`. |
| Domination | `pow_le_one₀` needs `0 ≤ x`, `x ≤ 1`; `pow_le_pow_left₀` needs `0 ≤ a`, `a ≤ b`, and natural exponent. Apply to `q(x)` and `1/16`; combine with the polynomial absolute bound. `summable_geometric_of_lt_one` has the same two ratio premises; `Summable.mul_left` accepts any real constant. |
| T3 interchange | [`intervalIntegral.hasSum_integral_of_dominated_convergence`](https://github.com/leanprover-community/mathlib4/blob/31ce06eaadf4a200c0e1407c5f10953cf606b8f8/Mathlib/MeasureTheory/Integral/DominatedConvergence.lean#L218) has exactly the five premises displayed below. The index must be countable (`ℕ` is); the value space is a real normed vector space (`ℝ` qualifies). It directly concludes `HasSum` of the integrals. |
| T3 measurability and majorant integral | `Continuous.aestronglyMeasurable` for real functions and any Borel measure; continuity suffices and all topology/measurability instances for `ℝ` are standard. `intervalIntegrable_const` needs a locally finite measure, with no restriction on the real constant or endpoints. The sum of our bounds is independent of `x`, so its exact value need not be evaluated in Lean. |
| T4 rational algebra | Nonzero denominators established above; `field_simp` and `ring` produce kernel-checked algebraic proofs in a future implementation. There is no located ready-made BBP partial-fraction lemma. |
| F derivative | [`HasDerivAt.log`](https://github.com/leanprover-community/mathlib4/blob/31ce06eaadf4a200c0e1407c5f10953cf606b8f8/Mathlib/Analysis/SpecialFunctions/Log/Deriv.lean#L114) requires `HasDerivAt g g' x` and `g x ≠ 0`, and gives derivative `g'/g x`. [`HasDerivAt.arctan`](https://github.com/leanprover-community/mathlib4/blob/31ce06eaadf4a200c0e1407c5f10953cf606b8f8/Mathlib/Analysis/SpecialFunctions/Trigonometric/ArctanDeriv.lean#L125) needs only that derivative, and gives `(1/(1+(g x)^2))*g'`. `hasDerivAt_pow n x` has no side hypothesis for natural `n`; derivative arithmetic closes the polynomial compositions. |
| K integrability and FTC | [`ContinuousOn.intervalIntegrable`](https://github.com/leanprover-community/mathlib4/blob/31ce06eaadf4a200c0e1407c5f10953cf606b8f8/Mathlib/MeasureTheory/Integral/IntervalIntegral/Basic.lean#L512) needs continuity on `uIcc a b` and a locally finite measure. [`intervalIntegral.integral_eq_sub_of_hasDerivAt`](https://github.com/leanprover-community/mathlib4/blob/31ce06eaadf4a200c0e1407c5f10953cf606b8f8/Mathlib/MeasureTheory/Integral/IntervalIntegral/FundThmCalculus.lean#L1148) needs `∀ x ∈ uIcc a b, HasDerivAt F (K x) x` and `IntervalIntegrable K volume a b`; the value space must be complete (`ℝ` is). It concludes `∫ K = F b-F a`. |
| Endpoints and assembly | [`Real.arctan_one`, `Real.arctan_neg`](https://github.com/leanprover-community/mathlib4/blob/31ce06eaadf4a200c0e1407c5f10953cf606b8f8/Mathlib/Analysis/SpecialFunctions/Trigonometric/Arctan.lean#L203), `Real.arctan_zero`, and `Real.log_one` have no side premises. Rewrite T1 and the integral value in T3; use `HasSum.summable` only if a later consumer needs summability. `HasSum.tsum_eq` is available but must not replace the final convergence assertion. |

Precisely, specialize the interchange theorem with `F j x = f_j(x)`,
`f = K`, `bound j x = 8*(1/16)^j`, `μ = volume`, `a = 0`, `b = 1`. It requires:

```text
∀ j, AEStronglyMeasurable (F j) (volume.restrict (Set.uIoc 0 1))
∀ j, ∀ᵐ x ∂volume, x ∈ Set.uIoc 0 1 → ‖F j x‖ ≤ bound j x
∀ᵐ x ∂volume, x ∈ Set.uIoc 0 1 → Summable (fun j => bound j x)
IntervalIntegrable (fun x => ∑' j, bound j x) volume 0 1
∀ᵐ x ∂volume, x ∈ Set.uIoc 0 1 → HasSum (fun j => F j x) (K x)
```

Local `rg` searches covered project sources and the pinned Mathlib for BBP and
the required analytic names. No existing BBP theorem was found by those searches;
this is not an exhaustive semantic search. A disposable `/tmp/pi-b1-api-probe.lean`
imported the four analytic modules and `Analysis.SpecificLimits.Basic`, and
checked the names above. Initial probes wrongly qualified `integral_pow` under
`intervalIntegral` and tried nonexistent `HasSum.congr`/`hasSum_congr`; these
were API lookup errors, not mathematical failures. The final probe uses the
root `integral_pow`, omits unnecessary congruence helpers (ordinary rewriting
suffices), and passes. It contains imports and `#check` commands only.

## Smallest implementation slice proposed for authorization

**B1a: coefficient and one-term integral.** Suggested new module:
`PiDisjunctivity/BBP/Series.lean`, namespace `PiDisjunctivity`. This is a future
file, not a declaration added by this review. Exact proposed definition:

```lean
noncomputable def bbpCoeff (j : ℕ) : ℝ :=
  4 / (8 * (j : ℝ) + 1) - 2 / (8 * (j : ℝ) + 4)
    - 1 / (8 * (j : ℝ) + 5) - 1 / (8 * (j : ℝ) + 6)
```

Exact sole public theorem proposed for that slice (no hidden hypotheses):

```lean
theorem integral_bbpTerm (j : ℕ) :
    (∫ x in (0 : ℝ)..1,
      (x ^ 8 / 16) ^ j * (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5)) =
      bbpCoeff j / (16 : ℝ) ^ j
```

Prerequisites: root `integral_pow`, polynomial continuity and interval
integrability, subtraction/scalar integral rules, natural-power identities,
and natural-to-real casts. Start with
`Mathlib.Analysis.SpecialFunctions.Integrals.Basic` and ordinary Mathlib tactics
as needed. Prove T1 directly. No public monomial helper, separate summand
definition, kernel definition, coefficient bound, tail API, or general
sum/integral interchange theorem is needed for this slice. A short private
helper is acceptable only if it removes actual duplication in the local proof.

Acceptance checks for that future slice:

1. Preserve `module`, public-section/export conventions, MIT SPDX and Ursula
   Athene headers, enabled linters, and both `v4.37.0-rc1` pins. Independently
   write the proof; retain the bibliographic link to this review.
2. Export through the root, and add the complete theorem type and actual guarded
   axiom list to `Test.lean`. Preserve all nineteen existing audits and both
   expanded-definition checks; the new theorem would bring the count to twenty.
   Permit only `propext`, `Classical.choice`, `Quot.sound`, possibly fewer.
3. Check the expanded coefficient expression and the exact `j=0` value `47/15`
   through the root import to catch signs, real division, and off-by-one errors.
   The universal theorem must cover every `j : ℕ`, not just examples.
4. Run `lake build`, `lake env lean Test.lean`, `git diff --check`, inspect the
   definition/import/pin preservation diff, and obtain the required scoped
   Gemini Carbon High review before committing. Retain Viewpoint's post-commit
   necessity review and committed handoff.
5. **Stop after that single termwise-integral theorem and its audits.** Do not
   mark B1 checked; do not begin the infinite interchange, integral evaluation,
   B2, B3, or V without their own authorization.

For clarity, the later B1 obligations can be stated exactly in this document's
notation (all are proposals, not declarations):

```text
∀ x : ℝ, x ∈ Set.Icc 0 1 → HasSum (fun j : ℕ => q(x)^j * P(x)) K(x)
∀ j : ℕ, ∀ x : ℝ, x ∈ Set.Icc 0 1 → ‖q(x)^j * P(x)‖ ≤ 8*(1/16)^j
HasSum (fun j : ℕ => A(j)/(16 : ℝ)^j) (∫ x in (0 : ℝ)..1, K(x))
∀ x : ℝ, x ∈ Set.Icc 0 1 → HasDerivAt F K(x) x
IntervalIntegrable K volume 0 1
(∫ x in (0 : ℝ)..1, K(x)) = Real.pi
HasSum (fun j : ℕ => A(j)/(16 : ℝ)^j) Real.pi
```

The derivative notation means `HasDerivAt F (K x) x`. These stages clarify
remaining work without mandating seven exported lemmas. B1 is checked only
when the last unconditional `HasSum` theorem and its audits pass.

## Validation and retrospective

Baseline `lean --version` reported `4.37.0-rc1`; `lake build` passed with 6655
jobs and no warnings; `lake env lean Test.lean` passed silently, preserving
nineteen theorem type/axiom guards and two definition checks. Baseline
`git diff --check` passed. Commands ran from the repository root with
`$HOME/.elan/bin` on `PATH`. The signature probe also passes after the lookup
corrections described above. No external rebuild, external axiom audit,
clean-environment rebuild, or remote CI run is claimed.

The report and plans are documentation only. Markdown links/anchors,
whitespace, and byte preservation of every project Lean file,
`Test.lean`, pins/dependency configuration, and CI passed before review (112
local links/anchors, 18 protected files); the final staged scope and expanded
documentation checks are recorded at commit/handoff.
Unrelated Obsidian and notes work is excluded. No Lean-related input changed,
so the baseline build/audit is the relevant validation, not a claimed new B1
proof. Final command outcomes are also recorded in the handoff.

The review establishes a concrete route and library fit, with source-license
constraints made explicit. The external development informs the argument and
API search but brings unnecessary tail/compute infrastructure for B1. Keeping
`HasSum` avoids that dependency and a redundant standalone summability proof.
The next slice tests the exact coefficient/integral match before committing to
the full analytic implementation. No mathematical route change, B1/B3 reorder,
dependency change, new tooling, or expanded research process is warranted.

## Gemini review and disposition

**Completed: explicit no findings**, on the full supplied seven-file diff
against `a3feb6b`, with model `gemini-4-carbon-high` in `plan` mode and
conversation `a8f04fb2-eee8-4285-873b-cfcda7b64149`. The
[review record](agy-reports/b1-source-proof-review.md) preserves both attempts,
progress timestamps, terminal fields, the returned response, and independent
assessment.

The initial invocation ended after a headless file-permission denial, with
exit 0, `SUCCESS`, an empty response, and `denied_actions: read_file`; it was
correctly treated as incomplete. After inspecting the stream/stderr and CLI
shutdown log, one focused recovery supplied the exact diff and source excerpts
inline, requested no tools, and retained the explicit conversation. It exited
0 with `SUCCESS`, a substantive no-findings response, and no error or denial
fields. Both used the twenty-minute deadline; neither timed out. The recovery's
caller observation window was 5 min 47 s, distinct from cumulative counters.

The reviewer checked the argument, source/license assessment, central pinned
API excerpts, proposed slice, and changed plans. It did not independently
retrieve sources, inspect all unchanged/non-excerpted files, run builds, or
compile the proposed BBP statements. Those coverage limits remain explicit;
its approval is a supplied-evidence review, not a kernel check. The caller's
source inspection and successful baseline/probe checks are separate evidence.
No actionable finding required a substantive fix. Finalization adds this record
and validation outcomes without changing the reviewed mathematical proposal.
