# Problem formulation and validation plan

This document states the problem and outlines how to validate its formalization.
The [implementation status](#implementation-status) records the current scope.
The [foundational theorem plan](foundations-plan.md) gives the reviewed statements,
proof methods, and completion status for the foundations. The conjecture about π
remains open.

**Current scope: formalize and validate the problem statement in Lean.** The
conjecture already has a Lean statement, but the full verification that the
definitions and alternate formulation express the intended problem is still
pending. Complete and review that verification before beginning work on a proof
of π's hexadecimal disjunctivity. The correctness and equivalence proofs below
belong to formulation verification; they do not assert that π is disjunctive.

## Problem formulation

> Every finite string of hexadecimal digits occurs contiguously after the radix
> point in the base-16 expansion of π.

The hexadecimal digit alphabet is `0`–`9`, `A`–`F`, with `A`–`F` representing the
integer values 10–15.

Strings may contain leading zeros, and their lengths matter: `007` and `7` are
different strings. We require an occurrence somewhere, without specifying a
frequency. This property is called **hexadecimal disjunctivity**.

Base 16 aligns the problem with the established Bailey–Borwein–Plouffe (BBP)
method for computing hexadecimal digits of π at a specified position without
computing all preceding digits. The identity and digit-extraction method are
described in Bailey, Borwein, and Plouffe,
[*On the Rapid Computation of Various Polylogarithmic Constants* (1997)](https://plouffe.fr/articles/ON%20THE%20RAPID%20COMPUTATION%20OF%20VARIOUS%20POLYLOGARITHMIC%20CONSTANTS%201997.pdf).
Digit extraction motivates the choice of base; establishing that every finite
word occurs remains a separate problem.

For a nonnegative real number $x$, define its zero-based digit in base $b$ by

$$
d_b(x,n)=\left\lfloor b^{n+1}x\right\rfloor\bmod b,
\qquad b\ge 2,\quad n\in\mathbb N.
$$

Thus $d_{16}(x,0)$ is the first digit after the hexadecimal radix point. For numbers
with a terminating expansion, the floor convention selects trailing zeros. In
Lean, the floor in this definition is `Nat.floor`; the restriction $x\ge 0$
ensures that it agrees with the usual floor.

Define

$$
\operatorname{Disjunctive}_b(x)
\iff
\forall k\in\mathbb N,\;
\forall s:\{0,\ldots,k-1\}\to\{0,\ldots,b-1\},\;
\exists n\in\mathbb N,\;
\forall i<k,\quad d_b(x,n+i)=s(i).
$$

The conjecture we want to formulate is

$$
\boxed{\operatorname{Disjunctive}_{16}(\pi).}
$$

The empty string, $k=0$, imposes no condition. In Lean, a length-$k$ word in base
$b$ is represented by a function `Fin k → Fin b`, so its length and digit bounds
are explicit. The hexadecimal specialization uses `Fin k → Fin 16`.

## Plan for validating the formulation

“Correctness of the formulation” means establishing that these definitions
capture the intended hexadecimal-digit property. We would validate that through
the following steps. The digit definition remains parameterized by the base; the
word–interval and orbit equivalences below are scoped to base 16 for the first
milestone.

### 1. Validate the digit definition

The digit bound, scaled-floor recurrence, finite-prefix reconstruction, and
truncation error are now proved for arbitrary bases $b\ge 2$ in
[`Digits.lean`](../PiDisjunctivity/Digits.lean), following Step 3 of the foundations
plan. Reconstruction and error bounds assume $x\ge 0$ and retain the integer
part. Exact examples also check the trailing-zero convention at termination.

### 2. Connect finite words to hexadecimal intervals

For a hexadecimal word $s$ of length $k$, let

$$
m_s=\sum_{i=0}^{k-1}s(i)\,16^{k-1-i}.
$$

The central correctness lemma, now proved as `block_iff_mem_interval` in
[`Cylinders.lean`](../PiDisjunctivity/Cylinders.lean), states that for $x\ge 0$,

$$
\bigl(\forall i<k,\ d_{16}(x,n+i)=s(i)\bigr)
\iff
\operatorname{fract}(16^n x)
\in
\left[\frac{m_s}{16^k},\frac{m_s+1}{16^k}\right).
$$

The proof uses floor arithmetic, fixed-length word-value injectivity, digit
reconstruction, and `baseDigit_fract_pow`, which identifies the later digits after
multiplication by $16^n$ and removal of the integer part. Length-$k$ words encode
exactly the integers $0\le m<16^k$, with leading-zero padding where needed.
Both directions of the correspondence include the empty word.

Keeping $k$ explicit preserves leading zeros: `007` corresponds to
$[7/16^3,8/16^3)$. The word `00A` similarly corresponds to
$[10/16^3,11/16^3)$, where the numerators are written in decimal notation.

### 3. Validate the alternate orbit formulation

Define

$$
O_{16}(x)=\{\operatorname{fract}(16^n x):n\in\mathbb N\}.
$$

Then establish, for $x\ge 0$,

$$
\operatorname{Disjunctive}_{16}(x)
\iff
\overline{O_{16}(x)}=[0,1],
$$

with closure taken in $\mathbb R$.

The planned argument has two directions:

- From disjunctivity, obtain orbit points in hexadecimal intervals of arbitrarily
  small width, establishing approximation throughout $[0,1]$, including its
  endpoints. Use the bounds on fractional parts and closedness of $[0,1]$ for
  the other closure inclusion.
- From the closure condition, obtain an orbit point in each hexadecimal interval’s
  **open interior**, then apply the word–interval correspondence.

### 4. Audit the Lean formalization

Compare its quantified statement directly against the formulation above;
compile the supporting results; inspect their axiom dependencies for unfinished
proofs or added assumptions; and check exact examples covering indexing, leading
zeros, digits `A`–`F`, terminating hexadecimal expansions, and the empty word.
Examples provide sanity checks alongside the general correctness results.

The validation should include a reproducible build using the pinned Lean and
Mathlib versions, and an inspection of `#print axioms` for the equivalence theorem
to ensure that it depends on neither `sorryAx` nor any project-specific axiom.

Completing this validation would establish the correspondence between the digit
and orbit formulations. Whether π satisfies either formulation would remain the
separate research problem.

## Remaining Lean verification roadmap

**Status: milestone A implemented and validated; milestones B and C pending.**
All three steps of [the foundations plan](foundations-plan.md) are complete. The
work is organized below in dependency order. This roadmap extends the broader
validation plan above; it does not add another foundational step or change the
conjecture.

The Lean snippets omit proof bodies and use the `PiDisjunctivity` namespace.
Milestone A's signatures are implemented and audited; milestone B's remain
proposed interfaces to check during implementation. Preserve the existing
definitions and reviewed statements, and build new proofs from the current
foundations rather than restoring the discarded proofs from history.

### A. Establish the word–interval correspondence

**Status: implemented and validated.** The results are exported through
`PiDisjunctivity.lean`.

A word's value determines the word when its length is fixed:

```lean
theorem blockValue_injective (k : ℕ) :
    Function.Injective (blockValue k)
```

Induct on `k`. For successor length, reduce equal values modulo 16 to recover
the last digit, and divide by 16 to recover the prefix value. The digit bounds
justify both operations. Apply induction to the prefixes and check all positions
with `Fin.castSucc` and `Fin.last`. Length zero uses equality of functions on
`Fin 0`. This is uniqueness at a fixed length; leading-zero words of different
lengths can still have the same value.

The digit-shift theorem includes removal of the integer part:

```lean
theorem baseDigit_fract_pow (x : ℝ) (hx : 0 ≤ x) (n i : ℕ) :
    baseDigit 16 (Int.fract ((16 : ℝ) ^ n * x)) i =
      baseDigit 16 x (n + i)
```

Split the argument into multiplication by `16 ^ n` and invariance of fractional
digits under removal of the integer part. Power arithmetic handles the first
part. For the second, use the decomposition into natural floor plus fractional
part for a nonnegative input: scaling the integer part contributes a multiple of
16 to the next floor, which disappears modulo 16. Check the relationship between
`Nat.floor`, `Int.floor`, and `Int.fract`, including nonnegativity and casts.

The central correspondence is:

```lean
theorem block_iff_mem_interval (x : ℝ) (hx : 0 ≤ x)
    (n k : ℕ) (s : Fin k → Fin 16) :
    (∀ i : Fin k, baseDigit 16 x (n + i.val) = (s i).val) ↔
      Int.fract ((16 : ℝ) ^ n * x) ∈
        Set.Ico ((blockValue k s : ℝ) / (16 : ℝ) ^ k)
          (((blockValue k s : ℝ) + 1) / (16 : ℝ) ^ k)
```

Set `y = Int.fract ((16 : ℝ) ^ n * x)`, so `0 ≤ y < 1` and `Nat.floor y = 0`.
Use `baseDigit_lt` to form its actual length-`k` word with digits in `Fin 16`.
The reconstruction theorem and `blockValue_eq_sum` identify that word's value
with `Nat.floor ((16 : ℝ) ^ k * y)`. The floor equals `blockValue k s` exactly
when `y` belongs to the displayed half-open interval; division is valid because
`(16 : ℝ) ^ k` is positive. Fixed-length injectivity recovers the individual
digits in the reverse direction. The shift lemma transfers them to position `n`
of `x`.

The theorem includes `k = 0`: the digit condition is vacuous and the interval is
`[0,1)`. Examples check nonzero offsets, leading-zero padding, inclusion of the
left endpoint, and exclusion of the right endpoint, including terminating
expansions.

Injectivity is in [`BlockValue.lean`](../PiDisjunctivity/BlockValue.lean). The shift
and correspondence are in [`Cylinders.lean`](../PiDisjunctivity/Cylinders.lean),
with a private helper proving invariance under removal of the integer part.

**Validation:** `lake build`, `lake env lean Test.lean`, and `git diff --check`
pass without warnings on the unchanged Lean and Mathlib `v4.37.0-rc1` pins. The
seven foundational statements and checks are preserved. Three new exported-type
checks and guarded `#print axioms` results cover the signatures above; all ten
audited theorems use exactly `propext`, `Classical.choice`, and `Quot.sound`.
The audit rejects unexpected dependencies, and CI runs it after building.

New examples recover `00A` from its length and value, specialize the correspondence
to empty and one-digit words, and check all-zero words at every length and offset.
They also check both boundaries of `00A` and `FF`, the word `0F` at offset one in
`3.A0F`, and the trailing-zero word after the first digit of `0.8000...`.

### B. Establish the orbit-closure equivalence

**Status: pending. This is the next implementation milestone; its dependency on
milestone A is complete.**

```lean
theorem isDisjunctive_iff_orbitClosure (x : ℝ) (hx : 0 ≤ x) :
    IsDisjunctive 16 x ↔
      closure (hexadecimalOrbit x) = Set.Icc (0 : ℝ) 1
```

Prove both directions for arbitrary nonnegative `x`:

- **Disjunctivity implies full closure.** Every orbit point is in `[0,1)`, so its
  closure is contained in the closed set `[0,1]`. To approximate any `t ∈ [0,1]`,
  choose `k` with `1 / 16 ^ k` smaller than the desired positive error. For
  `t < 1`, take the cell indexed by `Nat.floor ((16 : ℝ) ^ k * t)`; for `t = 1`,
  take the final cell, indexed by `16 ^ k - 1`. Check that each index is below
  `16 ^ k`, use `exists_blockValue_eq` to obtain a word, and use its occurrence
  and milestone A to obtain an orbit point. Its distance from `t` is at most
  the cell width. This also handles `t = 0` and proves the other inclusion.
- **Full closure implies disjunctivity.** Given a word, its interval has positive
  width and endpoints in `[0,1]`, by `blockValue_lt`. Its midpoint lies in the
  orbit closure. The interval's open interior is a neighborhood of that midpoint,
  so it contains an orbit point. Apply milestone A to obtain an occurrence of
  the word. Use the open interior here: closure membership alone does not supply
  an orbit point at a specified boundary. Include the empty word.

Use a new `OrbitEquivalence.lean` module depending on the correspondence. Then
specialize the equivalence using `0 ≤ Real.pi` and the existing proposition names:

```lean
theorem piHexadecimalDisjunctivity_iff_orbitClosure :
    PiHexadecimalDisjunctivity ↔ PiHexadecimalOrbitClosure
```

This specialization establishes that the two conjecture statements agree. It
proves neither conjecture. Import `Conjectures.lean` for the existing names without
changing their definitions.

### C. Complete the formulation audit and review

**Status: pending; depends on milestones A and B.**

Completion requires all of the following:

- Compare the exported statements with the intended English formulation: every
  finite hexadecimal word, length retained, zero-based positions, nonnegative
  real inputs where required, and the chosen trailing-zero convention.
- Preserve the existing ten theorem checks. Extend `Test.lean` with checks of
  all new public theorem types and guarded `#print axioms` results, including the
  general orbit equivalence and the specialization to π. Record each actual
  axiom list, allowing only `propext`, `Classical.choice`, and `Quot.sound`; a
  theorem may use fewer. Unexpected dependencies must fail the audit.
- Extend exact examples for empty and one-digit words, zero, `00A`, `FF`,
  nonzero offsets, numbers with an integer part, terminating expansions, and
  both interval boundaries. Verify the closure argument at both 0 and 1 in the
  universal proof. Examples supplement that proof.
- Run `lake build`, `lake env lean Test.lean`, and `git diff --check`. Keep CI
  running the expanded audit after the build. Resolve warnings with the checks
  enabled; use the pinned Lean and Mathlib `v4.37.0-rc1` versions.
- Add no `sorry`, `admit`, project-specific axioms, `native_decide` proof bypasses,
  or unsafe proof shortcuts. Preserve `module` and public-export conventions,
  MIT SPDX headers, the header linter, and Ursula Athene attribution.
- Update implementation status only after compilation and audit, and review the
  correspondence between the formal statements and the intended problem.

The formulation verification is complete when these criteria are met. Lean
checks the formal proofs relative to the definitions; the comparison with the
intended English statement remains a mathematical review. Work on proving π's
hexadecimal disjunctivity begins only after this phase is complete and reviewed,
as a separately authorized task. BBP formalization is also outside this phase.

## Implementation status

The earlier cylinder and orbit-equivalence proofs were discarded, including the
specialization to π and their axiom audit. They were written before the formulation
and validation approach were discussed. Milestone A now supplies a new
word–interval proof built from the reviewed foundations; the orbit equivalence
and its specialization remain unimplemented.

The library retains the agreed definitions: `baseDigit`, `IsDisjunctive`,
`hexadecimalOrbit`, `blockValue`, `PiHexadecimalDisjunctivity`, and
`PiHexadecimalOrbitClosure`. The first two remain parameterized by the base;
`blockValue` implements the hexadecimal word value recursively in
`Definitions.lean`.

Exact rational examples check the integer part, zero-based indexing, leading
zeros, all digits `A`–`F`, nonzero offsets, terminating expansions, half-open
interval boundaries, and the empty word. They are sanity checks, not general
proofs of the validation requirements.

Progress against [the foundational theorem plan](foundations-plan.md):

1. **Complete:** `blockValue_eq_sum` in
   [`BlockValue.lean`](../PiDisjunctivity/BlockValue.lean) proves that recursive
   `blockValue` equals the displayed finite sum for every length and word.
2. **Complete:** `blockValue_lt` and `exists_blockValue_eq` in the same module
   prove the upper bound and coverage of every natural number below $16^k$,
   including length zero and leading-zero padding.
3. **Complete:** `baseDigit_lt`, `floor_pow_succ`, `floor_pow_eq_digits`, and
   `truncation_error` in [`Digits.lean`](../PiDisjunctivity/Digits.lean) prove
   arbitrary-base digit bounds, the scaled-floor recurrence, prefix reconstruction
   including the integer part, and truncation error in $[0,1/b^k)$.

Milestone A is also complete: `blockValue_injective`, `baseDigit_fract_pow`, and
`block_iff_mem_interval` prove fixed-length uniqueness, digit shifting, and the
word–interval correspondence. The default `lake build` checks the definitions,
all three foundational steps, milestone A, and examples.
Additional word-value examples cover the empty word, any single digit, all-zero
words, leading zeros, `FF`, and positional order (`12` versus `21`). Range examples
exercise the bound at lengths zero and one, coverage of zero at every length,
all single digits, `00A`, `FF`, and the maximum value `16 ^ k - 1` at every length.
Reconstruction examples cover bases 2, 10, and 16, fractional inputs, nonzero
integer parts, leading zeros, zero at every length, and the length-zero error
bound. Terminating inputs have zero error and a zero next digit; the
nonterminating decimal input `1/3` exercises a nonzero truncation error.
Correspondence examples additionally check empty words, arbitrary single digits,
zero at all lengths and offsets, leading zeros, both interval boundaries, a
nonzero offset in a number with an integer part, and terminating expansions.
The separate `lake env lean Test.lean` check verifies all ten reviewed theorem
types through the library root. Guarded `#print axioms` results require exactly
`propext`, `Classical.choice`, and `Quot.sound` for each theorem. The audit rejects
a changed axiom list, including any introduction of `sorryAx` or a project-specific
axiom. CI runs this check after building. These checks and `git diff --check` pass
with the pinned Lean and Mathlib versions.

The foundations and word–interval correspondence are complete. The orbit
equivalence, its specialization to π, and the final formulation review remain
pending. The
[remaining verification roadmap](#remaining-lean-verification-roadmap) records
their implementation order, proposed statements, and completion criteria.
These results make no claim about the occurrence of words in π.
