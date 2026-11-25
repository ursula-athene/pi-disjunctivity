# Lean literature review: pi disjunctivity and related formalizations

**Review date:** 2026-11-24. **Project baseline:**
`ursula-athene/pi-disjunctivity` at
`ae2ba3ffdd391bb9c5312de1a54668facdf09653`.

## Findings

There are closely related Lean formalizations, including an external proof
development for the general equivalence between disjunctivity and density of a
radix orbit. The local Google DeepMind checkout contains the corresponding
statements and links to that proof. A separate repository contains a decimal
version of this project's digit/interval/orbit formulation. **No unconditional
Lean proof that pi is disjunctive in base 16, or normal in a base, was found in
the sources inspected.** This is a bounded search result, not a claim that no
such public or private development exists.

This project's current achievement is formulation and equivalence: every finite
hexadecimal word occurs in pi **if and only if** the closure of
`{fract (16^n * pi) | n : ℕ}` is `[0,1]`. Neither side is proved. The two
conjectures are proposition definitions, not axioms or admitted theorems.
See [Conjectures.lean](../../PiDisjunctivity/Conjectures.lean),
[OrbitEquivalence.lean](../../PiDisjunctivity/OrbitEquivalence.lean), and the
[completed formulation audit](../formulation-review.md).

### Evidence labels

- **Statement only:** a declaration with an explicit `sorry` was inspected.
- **Proof body inspected:** the relevant source contains a proof term or tactic
  proof; this review did not independently compile its complete import graph
  or obtain its transitive `#print axioms` output.
- **Conditional:** substantial mathematical assumptions remain arguments of
  the theorem, regardless of whether the proof uses any additional axioms.

Repository descriptions and reported CI checks are not substituted for these
distinctions. In particular, a theorem declaration, a closed GitHub issue, or a
`formal_proof` annotation does not itself establish a checked proof.

## Closest matches

| Development                                   | Inspected result and status                                                                                                           | Relationship to this project                                                                               |
| --------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| Google DeepMind, `NormalNumber.lean`          | Definitions of digit sequences, normality, and `IsRichInBase`; proof body for normality implying richness.                            | Richness is the same finite-word property, after matching digit conventions and word types.                |
| Google DeepMind, `NormalityOfPi.lean`         | `pi_normal_base_ten : IsNormalInBase 10 π`, marked open and proved with `sorry`.                                                      | A decimal frequency conjecture, not a proof of hexadecimal disjunctivity.                                  |
| Google DeepMind, Bugeaud `NormalAndRich.lean` | Richness iff circle-orbit density, and normality iff equidistribution; both local bodies contain `sorry` and link to external proofs. | The first is the closest mathematical counterpart of milestone B.                                          |
| `rwst/formal-conjectures`, linked proof       | Proof bodies for both equivalences, including word–interval correspondence, for every base at least two.                              | Substantial overlap with milestones A and B; broader base/domain coverage and additional frequency theory. |


Primary sources: DeepMind's
[digit and normality API](https://github.com/google-deepmind/formal-conjectures/blob/9097e2f90e66d2f6244209cb1c07f7120d17ec53/FormalConjecturesForMathlib/NumberTheory/NormalNumber.lean),
[pi statement](https://github.com/google-deepmind/formal-conjectures/blob/9097e2f90e66d2f6244209cb1c07f7120d17ec53/FormalConjectures/Wikipedia/NormalityOfPi.lean), and
[Bugeaud statements](https://github.com/google-deepmind/formal-conjectures/blob/9097e2f90e66d2f6244209cb1c07f7120d17ec53/FormalConjectures/Books/BugeaudDistributionModuloOne/NormalAndRich.lean);
the [linked rwst proof](https://github.com/rwst/formal-conjectures/blob/a522a5352dd28df0b5ef08c213c368b5f6a5df6e/FormalConjectures/Books/BugeaudDistributionModuloOne/NormalAndRich.lean);
the decimal repository's
[definitions](https://github.com/adamfeuer/pi-disjunctivity/blob/b536f31e47cc391a16c747d37f22293a04590ce3/PiDisjunctivity/Definitions.lean),
[conjectures](https://github.com/adamfeuer/pi-disjunctivity/blob/b536f31e47cc391a16c747d37f22293a04590ce3/PiDisjunctivity/Conjectures.lean), and
[equivalence proofs](https://github.com/adamfeuer/pi-disjunctivity/blob/b536f31e47cc391a16c747d37f22293a04590ce3/PiDisjunctivity/Equivalences.lean).

The [companion report](2026-11-24-deepmind-comparison.md) compares the closest
match at theorem and definition level. The decimal repository uses the same
floor/modulo digit formula and `Fin k → Fin b` word representation. Its proof
passes through decimal half-open intervals and proves both implications of
the orbit equivalence. Its source relationship to this repository was not
established; it should not be counted as evidence of independent invention.

The underlying mathematical equivalences are established literature.
Bugeaud's *Distribution Modulo One and Diophantine Approximation* (2012),
Theorem 4.14 and Section 4.4, treats normality via uniform distribution and
richness via density modulo one. Normality prescribes frequencies for all
finite words; richness only requires their occurrence. The distinction between
base 10 and base 16 also matters: they are not powers of a common integer base,
so a same-base implication or a change between powers of one base cannot simply
turn the decimal conjecture into this hexadecimal one.
[Book text](https://staff.dc.uba.ar/becher/aa/Bugeaud2012.pdf).

## Related Lean developments

### Mathlib already supplies part of the digit foundation

The project's pinned Mathlib has `Real.digits` and `Real.ofDigits` in
[`Analysis/Real/OfDigits.lean`](https://github.com/leanprover-community/mathlib4/blob/31ce06eaadf4a200c0e1407c5f10953cf606b8f8/Mathlib/Analysis/Real/OfDigits.lean).
`Real.digits` uses a natural floor and a `Fin b` result. Its value agrees
mathematically with `baseDigit` after commuting multiplication and expanding
`Fin.ofNat`, when the nonzero-base instance is available. Mathlib proves
finite-sum reconstruction and `ofDigits_digits` for inputs in `[0,1)` and
bases greater than one. This is relevant existing infrastructure, even though
it does not assert disjunctivity of pi.

This project's reconstruction retains the integer part for nonnegative inputs
and has an explicit universal trailing-zero theorem. Its interval/orbit layer
serves a different purpose from reconstruction alone. A future bridge to the
pinned Mathlib API could obey the Mathlib-only policy; none was needed or added
for this review. A textual search of the pinned Mathlib found no normal/rich
number API under the searched names. That search is not an exhaustive theorem
inventory. Mathlib's
[irrationality theorem for pi](https://github.com/leanprover-community/mathlib4/blob/31ce06eaadf4a200c0e1407c5f10953cf606b8f8/Mathlib/Analysis/Real/Pi/Irrational.lean)
does not imply that every finite word occurs.

### Certified hexadecimal digits of pi: `metasecdev/math-proofs`

At the inspected snapshot, this repository has an all-position certification
theorem `BBPPi.floor_digit_eq_guard570` and related theorems connecting BBP
certificates to actual scaled floors and hexadecimal digits of `Real.pi`.
The headline theorem has no conjectural distribution assumption in its
signature. Its proof body was inspected, but the substantial analytic imports
and reported axiom checks were not independently rebuilt here.
[Certification theorem](https://github.com/metasecdev/math-proofs/blob/e5376424f932afdbf529c696f985e516836e6601/Thoughts/Research/BBPMu570b.lean),
[project account and validation claims](https://github.com/metasecdev/math-proofs/blob/e5376424f932afdbf529c696f985e516836e6601/README.md).

Its `piHexDigit n` uses exponent `n`, with position zero equal to the integer
digit 3. Our first fractional digit uses exponent one: the comparison therefore
requires `piHexDigit (n + 1)`. Its total `piGapSeq` returns zero if a requested
future occurrence does not exist; defining this function does not prove an
occurrence exists. The source explicitly separates these questions.
[Digit and gap definitions](https://github.com/metasecdev/math-proofs/blob/e5376424f932afdbf529c696f985e516836e6601/Thoughts/Proved/BBPDigitDefs.lean).

Correctly computing any requested digit does not supply the existential
position for every requested word. Searching progressively longer prefixes
still needs a termination argument. This development is relevant pi
infrastructure, not a discovered proof of our conjecture. This review only
read existing BBP work; it did not start a BBP formalization.

### Normal numbers with composite prefixes

`slavanaprienko/normal-composite-prefixes` contains
`exists_normal_with_no_prime_prefix`: a real in `[0,1)` with first decimal
digit 4, normal in base ten, and with every nonempty decimal prefix integer
nonprime. The proof assembles construction, digit-bridge, and normality results.
Its `NormalBaseTen` counts occurrences of lists of `Fin 10` digits, including
overlapping starts, with the expected limiting frequencies.
[Main theorem](https://github.com/slavanaprienko/normal-composite-prefixes/blob/3547224f5b1ea214f75427a6b2c3d82b02cf21ed/lean/NormalCompositePrefixes/Main.lean),
[definitions](https://github.com/slavanaprienko/normal-composite-prefixes/blob/3547224f5b1ea214f75427a6b2c3d82b02cf21ed/lean/NormalCompositePrefixes/Basic.lean).

This is a source-level example of proving a stronger distribution property for
a deliberately constructed real. It supplies neither an identity with pi nor
a theorem about its hexadecimal digits. The repository's reported standard
axiom audit was not reproduced here.

### Stoneham sums

`CaptainSude/Stoneham-sum-normal` defines normality by visits of
`fract (b^n*x)` to the same half-open radix cells used in this project, with
limiting frequency `b^(-k)`. Length and integer word value remain separate, so
leading zeros are retained. Its theorem `stoneham_two_sum_normalInBase`
asserts normality of the sum of two specified Stoneham constants under
`b,c,d ≥ 2`, `Coprime b c`, and `Coprime b d`.
[Radix definitions](https://github.com/CaptainSude/Stoneham-sum-normal/blob/f4d3d1f01d00c57425c684409849053e58e42261/StonehamNormality/GeneralRadix.lean),
[main theorem](https://github.com/CaptainSude/Stoneham-sum-normal/blob/f4d3d1f01d00c57425c684409849053e58e42261/StonehamNormality/TwoSumMain.lean).

The proof body discharges intermediate analytic hypotheses through imported
results; this review did not audit their entire dependency graph. It provides
a closely comparable cylinder-frequency API for different constants, with
stronger conclusions than word existence at the same base. It has no proved
connection identifying those constants with pi.

### Prime-gap concatenation: explicitly conditional

`CaptainSude/normality-of-prime-gap-constant` has `primeGap_normal`, but its
signature includes `ExceptionalNumerals` and `UniformPrimePairBound` as
arguments. Its external-inputs document identifies these as unformalized
classical inputs. Thus even a clean standard-axiom audit of that theorem would
only certify the implication from those hypotheses. The resulting real is
built by concatenating prime gaps, not by taking pi's digits.
[Main theorem](https://github.com/CaptainSude/normality-of-prime-gap-constant/blob/ba60f73f8d08b6796a3afa96779290f930fac6de/lean/PrimeGap/Main.lean),
[external-input inventory](https://github.com/CaptainSude/normality-of-prime-gap-constant/blob/ba60f73f8d08b6796a3afa96779290f930fac6de/lean/EXTERNAL-INPUTS.md).

This is a useful comparison for theorem-type review: a theorem's hypotheses
must be read as carefully as its axiom list. Our project's theorem is also an
equivalence, not a proof of either conjectural side.

### Binary symbolic dynamics and reused normality APIs

`WolframInstitute/Rule30PrizeKit` includes proof bodies deriving full shift-orbit
closure and maximal finite-word complexity from disjunctivity of a binary
sequence. Its `problem1_of_disjunctive` assumes every finite binary word occurs
in the distinguished Rule 30 column; it does not establish that assumption.
These are useful symbolic counterparts of our real-orbit argument, but no
identification with pi is provided.
[Shift closure and complexity](https://github.com/WolframInstitute/Rule30PrizeKit/blob/5bda6abfa602abee0500700f4c2d60da44cf8ec5/equivalents/Rule30Equivalents/Typicality.lean),
[conditional Rule 30 theorem](https://github.com/WolframInstitute/Rule30PrizeKit/blob/5bda6abfa602abee0500700f4c2d60da44cf8ec5/equivalents/Rule30Equivalents/StrongerStatements.lean).

The normal-number files in
[`facebookresearch/atlas-lean`](https://github.com/facebookresearch/atlas-lean/blob/9d3846dab74bc6481fe2bb34a8b63a8e24d4b14a/MathlibExt/NumberTheory/NormalNumber.lean)
and [`math-proof/lemma`](https://github.com/math-proof/lemma/blob/5240c336989629ff3bbed77172182700fbb09858/Def/NumberTheory/NormalNumber.lean)
explicitly credit adaptations of the DeepMind API. The inspected files do not
prove normality of pi. They demonstrate reuse of the formulation and are not
counted here as independent proofs or independent origins of the definitions.

## Implications for this attempt

1. The finite-word and orbit formulations agree with established mathematical
   practice and closely related Lean work. There is no basis to claim that
   this general equivalence is mathematically new or first formalized here.
2. The project's useful deliverable is its focused hexadecimal formulation,
   explicit boundary conventions, and preserved theorem-type and axiom audits.
   The external comparison revealed no required correction to that formulation.
3. Generalizing the interval/orbit API to arbitrary bases, or connecting it to
   Mathlib's digit API, would be reasonable separate maintenance tasks. They
   are not prerequisites for the current conjecture and were not implemented.
4. External libraries cannot be imported, vendored, or added to Lake under the
   current Mathlib-only policy. Any future adaptation needs ordinary attribution
   and license review as well as proof and statement review; this report adds
   references only. Lean/Mathlib remain pinned at `v4.37.0-rc1`.

## Search scope, snapshots, and validation limits

The local DeepMind checkout and its remote default branch were both at
`9097e2f90e66d2f6244209cb1c07f7120d17ec53` when checked. That checkout and the
exact proof URL embedded in it were inspected. Other candidates were found
through web searches and GitHub repository/code searches, then read at the
immutable commits linked above. Search terms included `IsRichInBase`,
`IsDisjunctive`, `pi_normal_base_ten`, `isRichInBase_iff_dense`, pi normality,
disjunctivity, Champernowne, Stoneham, and Lean BBP. Local searches also covered
the pinned Mathlib and the target project's definitions and audits.

Searches for “normal” and “disjunctive” produce many unrelated results about
normal subgroups, normal families, and logical disjunction. Those were excluded.
Forks, exported datasets, and catalogue copies were not treated as independent
developments. GitHub indexing demonstrably missed a searched identifier in a
file subsequently fetched directly, so negative search results are especially
weak evidence of absence. Not every repository, branch, history, import, or
possible synonymous formulation was examined.

The linked rwst proof file was inspected and scanned for `sorry`, `admit`,
`axiom`, `native_decide`, and `unsafe`, with none found in that file. This is
not a transitive audit: no external project was rebuilt and no external
`#print axioms` output was independently obtained. DeepMind's statement files
retain their explicit holes. The target project's thirteen successful guarded
axiom checks are documented in the prior
[milestone C audit](../formulation-review.md#axiom-audit); the literature review
does not silently extend that certification to external code.

Only Markdown reports were added for this task. No Lean statements, proofs,
imports, dependency files, or version pins were changed, and no proof of pi
disjunctivity was attempted.
