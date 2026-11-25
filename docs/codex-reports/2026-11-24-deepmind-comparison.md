# Detailed comparison with DeepMind Formal Conjectures

**Review date:** 2026-11-24. This compares the completed formulation in
`ursula-athene/pi-disjunctivity` at
`ae2ba3ffdd391bb9c5312de1a54668facdf09653` with the local
`deepmind-formal-conjectures/` checkout at
`9097e2f90e66d2f6244209cb1c07f7120d17ec53` and the exact external proof it cites.
The [broader literature report](2026-11-24-lean-literature-review.md) covers
other repositories and the search limitations.

## What is actually present

DeepMind's
[`NormalNumber.lean`](https://github.com/google-deepmind/formal-conjectures/blob/9097e2f90e66d2f6244209cb1c07f7120d17ec53/FormalConjecturesForMathlib/NumberTheory/NormalNumber.lean)
defines fractional digits, simple normality, normality, absolute normality,
and richness. Its `IsNormalInBase.isRichInBase` has a proof body: positive
limiting frequency forces an occurrence of each word.

The pi-specific
[`pi_normal_base_ten`](https://github.com/google-deepmind/formal-conjectures/blob/9097e2f90e66d2f6244209cb1c07f7120d17ec53/FormalConjectures/Wikipedia/NormalityOfPi.lean)
is marked `research open` and has body `by sorry`. It is a formalized conjecture,
not a proof. Its normality predicate quantifies over words of every length,
not just individual digits. Its base is 10, while our target uses 16.

The Bugeaud
[`NormalAndRich.lean`](https://github.com/google-deepmind/formal-conjectures/blob/9097e2f90e66d2f6244209cb1c07f7120d17ec53/FormalConjectures/Books/BugeaudDistributionModuloOne/NormalAndRich.lean)
states both normality iff equidistribution and richness iff density of the
radix orbit in `AddCircle (1 : ℝ)`. Both bodies also contain `sorry`. Their
`formal_proof` annotations link to
[`rwst/formal-conjectures` at `a522a535…`](https://github.com/rwst/formal-conjectures/blob/a522a5352dd28df0b5ef08c213c368b5f6a5df6e/FormalConjectures/Books/BugeaudDistributionModuloOne/NormalAndRich.lean),
whose file contains proof bodies for the two equivalences. The linked source
was inspected rather than inferring proof completion from the annotations.

The `NormalNumber.lean` definition file in that fork has the same Git blob
hash as the local DeepMind file:
`03a1665cca562e2736338387338264eb7502773e`. Thus the linked theorem is not
silently proving a different definition of richness at this snapshot.

## Definitions and semantic correspondence

| Feature | This project | DeepMind / linked rwst development | Assessment |
| --- | --- | --- | --- |
| Digit formula | `floorNat (b^(n+1) * x) % b` | `floorNat (b^(n+1) * fract x) % b` | Same digits for nonnegative inputs and ordinary integer bases; definitions differ on negative inputs. |
| Position zero | First digit after the radix point | Same | No offset correction is needed here. |
| Word | `s : Fin k → Fin b` | `w : Fin k → ℕ` with `∀ j, w j < b` | Equivalent bounded alphabets; conversion needs explicit coercions/proofs. |
| Occurrence | One `n` with equality at every `n+i` | One `i` with equality at every `i+j` | Same contiguous-word quantifiers; no independent position for each digit. |
| Leading zeros | Length retained in the word type | Length retained in `Fin k` | Both include zero-padded words. |
| Empty word | Included, occurrence vacuous | Included, occurrence vacuous | No positive-length restriction is missing. |
| Terminating expansions | Natural floor selects trailing zeros; universal termination theorem proved | Fractional-part floor selects trailing zeros | Same canonical choice on the shared domain. |
| Orbit equivalence | Base 16, `x ≥ 0`; real closure equals `[0,1]` | Every `b ≥ 2`, every real `x`; density in the unit circle | Mathematically corresponding statements, not definitionally identical Lean types. |
| Pi result | Equivalence between two proposition definitions | Base-ten normality stated with `sorry` | Neither is a proof of our pi conjecture. |

Sources: this project's
[Definitions.lean](../../PiDisjunctivity/Definitions.lean),
[Digits.lean](../../PiDisjunctivity/Digits.lean), and
[OrbitEquivalence.lean](../../PiDisjunctivity/OrbitEquivalence.lean), and the
DeepMind/rwst files linked above.

For the precise hexadecimal bridge, our
[`baseDigit_fract_pow`](../../PiDisjunctivity/Cylinders.lean), specialized to
shift zero, identifies `baseDigit 16 (fract x) j` with `baseDigit 16 x j`
when `x ≥ 0`. Expanding DeepMind's `digitSeq` gives the first of these.
Converting between `Fin 16` and natural digits with a bound then establishes
the mathematical equivalence of `IsDisjunctive 16 x` and `IsRichInBase 16 x`.
This describes a bridge justified by the inspected statements; no cross-project
Lean bridge was added or compiled in this review.

The sign restriction is substantive. For example, at `x = -1/16`, our natural
floor formula gives first digit zero, whereas applying the formula to
`fract x = 15/16` gives 15. Our digit interpretation is intentionally limited
to nonnegative reals. DeepMind first takes a fractional part and therefore
uses the latter interpretation on every real. Pi satisfies our restriction.

Normality additionally requires each length-`k` word to have limiting frequency
`1/b^k`, counting all starts below the cutoff, including overlapping starts.
Disjunctivity requires only one start. DeepMind proves the implication at the
**same base**. Its decimal pi statement therefore is neither the same
conjecture nor an available proof of hexadecimal richness.

## Comparison of the equivalence proofs

The following names in the middle column refer to the exact
[linked rwst proof file](https://github.com/rwst/formal-conjectures/blob/a522a5352dd28df0b5ef08c213c368b5f6a5df6e/FormalConjectures/Books/BugeaudDistributionModuloOne/NormalAndRich.lean).

| Proof stage | Linked rwst declarations | Corresponding project declarations |
| --- | --- | --- |
| Scaled floors and next digit | `digitPrefix`, `digitPrefix_succ`, `digitPrefix_add` | `floor_pow_succ`, `floor_pow_eq_digits` |
| Encode and cover finite words | `ofBlock`, `ofBlock_lt`, `exists_ofBlock_eq`, `exists_extend` | `blockValue`, `blockValue_lt`, `exists_blockValue_eq` |
| Recover a word from its value | `mul_add_eq_mul_add_iff`, `forall_digitSeq_eq_iff` | `blockValue_injective`, reconstruction |
| Shift digit positions | `digitSeq_add` | `baseDigit_fract_pow` |
| Word iff half-open radix cell | `digitPrefix_eq_iff`, `block_iff` | `block_iff_mem_interval` |
| Every word iff all cells visited | `isRichInBase_iff_exists` | Cell selection and word coverage inside `isDisjunctive_iff_orbitClosure` |
| Cell visitation iff density | `exists_Ico_iff_dense` | Real-closure argument in `isDisjunctive_iff_orbitClosure` |
| Final equivalence | `isRichInBase_iff_dense` | `isDisjunctive_iff_orbitClosure` |

Our implementation is split across
[Digits](../../PiDisjunctivity/Digits.lean),
[BlockValue](../../PiDisjunctivity/BlockValue.lean),
[Cylinders](../../PiDisjunctivity/Cylinders.lean), and
[OrbitEquivalence](../../PiDisjunctivity/OrbitEquivalence.lean).
The rwst implementation uses an infinite natural-valued word with an explicit
bound internally, then extends each finite word by zero. Only its first `k`
digits enter `ofBlock`. Both implementations keep length separately from value,
so equal integers such as the values of `A` and `00A` do not collapse their
different cylinders.

Both word–interval theorems use the cell
`[m/b^k, (m+1)/b^k)`. The left endpoint belongs to the word; the right endpoint
belongs to the next cell, or resets to fractional part zero at 1. This is the
same boundary choice as the project's audited formulation.

The topology differs in presentation. Our orbit is a subset of the real line,
always contained in `[0,1)`, with claimed closure `[0,1]`. The proof explicitly
approximates endpoint 1 using the final cell and recovers each word through
the open interior of its cell. The rwst result concerns residues modulo one,
where 0 and 1 represent the same point. Its density argument uses the quotient
map, open intervals, and equality of fractional parts for equal residues.

The two targets are mathematically equivalent: full real closure maps onto a
dense circle orbit; conversely, density on the circle supplies visits inside
every interval strictly between 0 and 1, and their limits supply both real
endpoints. This converse needs the interior-interval argument; continuity of
the quotient alone does not recover the real closure. No formal conversion
between the two topological statements was implemented here.

The linked development also proves normality iff equidistribution by comparing
cell-visit frequencies with arbitrary intervals. That frequency theory is
additional scope, not something missing from an existence-only disjunctivity
formulation. It proves no special distribution statement for pi.

## Further equivalent and weaker formulations in the checkout

DeepMind's
[`ExpansionEntropy.lean`](https://github.com/google-deepmind/formal-conjectures/blob/9097e2f90e66d2f6244209cb1c07f7120d17ec53/FormalConjecturesForMathlib/NumberTheory/ExpansionEntropy.lean)
contains proof bodies for `isRichInBase_iff_blockComplexity`: every length-`n`
block count is `b^n`. It also derives expansion entropy `log b` from richness,
and rules out eventual periodicity when `b ≥ 2`. The finite block-complexity
equivalence is another direct description of the same word property. The
entropy and nonperiodicity results are implications; this review does not
claim their converses. In particular, irrationality or nonperiodicity alone
does not establish richness of pi.

The supporting
[`ModOne.lean`](https://github.com/google-deepmind/formal-conjectures/blob/9097e2f90e66d2f6244209cb1c07f7120d17ec53/FormalConjecturesForMathlib/Analysis/Equidistribution/ModOne.lean)
contains `IsEquidistributedModuloOne.dense_range` with a proof body. This
corroborates the division between distribution frequencies and topological
density, but supplies no equidistribution hypothesis for pi.

## Trust, compatibility, and review conclusion

The local DeepMind statements and the linked proof snapshot use Lean/Mathlib
`v4.33.1`; this project uses `v4.37.0-rc1`, with Mathlib locked to
`31ce06eaadf4a200c0e1407c5f10953cf606b8f8`. The external proofs use
`FormalConjecturesUtil` and supporting modules in that repository. They are
not available merely because this project imports Mathlib, nor are they
automatically source-compatible across the version difference.

The local statement files contain explicit `sorry` terms. Such a declaration
would involve `sorryAx`; it cannot pass our permitted-axiom policy. The linked
471-line proof file was read and scanned for `sorry`, `admit`, `axiom`,
`native_decide`, and `unsafe`, finding none. Its imports and resulting
transitive axiom dependencies were **not independently rebuilt and audited**
in this review. A hole-free file alone is insufficient evidence of a clean
transitive proof. The same limitation applies to the inspected supporting
normality and entropy proofs.

Our existing thirteen theorem-type and exact axiom guards remain the
independently checked evidence for this repository, as recorded in the
[milestone C review](../formulation-review.md). The external comparison supports
the intended meanings of the definitions and exposes no required correction.
It also establishes substantial prior formalization of the general
equivalence, so the result should be presented as a focused, audited
hexadecimal development rather than a new equivalence theorem.

No external code was copied or added as a dependency, no version was changed,
and no Lean declaration or audit was modified. Potential future work is a
Mathlib-only bridge or an arbitrary-base generalization, with its own theorem
and axiom checks. Proving pi disjunctivity remains a separate, unresolved task.
