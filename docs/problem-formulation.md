# Problem formulation and validation plan

This document states the problem and outlines how to validate its formalization.
The [implementation status](#implementation-status) records the current scope.
The [foundational theorem plan](foundations-plan.md) gives the reviewed statements,
proof methods, and completion status for the foundations. The conjecture about π
remains open.

**Current scope: formalize and validate the problem statement in Lean.** The
conjecture has a Lean statement, and the planned correctness and equivalence
theorems are implemented and audited. The
[final consolidated review](formulation-review.md) is complete: formulation
verification meets the criteria of milestones A, B, and C. Work on proving π's
hexadecimal disjunctivity or formalizing BBP requires separate authorization.
The correctness and equivalence proofs below belong to formulation verification;
they do not assert that π is disjunctive.

**Later bounded research update (2026-11-25):** separately authorized cycles
completed [proof-plan Step 2](proof-plan.md#2-isolate-exactly-what-must-be-proved-about-pi)
and B4/P3, the conditional interior-margin transfer and open-interval-to-cell
conversion. These general results preserve this reviewed formulation and their
explicit visitation hypotheses. [The research log](research-log.md) records the
scope, review, and expanded audit. A later separately authorized B1a cycle
checked the BBP coefficient and single-term integral, with twenty theorem
audits in total; see [the handoff](b1a-handoff.md). The full BBP series and
universal visitation remain unproved.

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

The Lean functions are total, but their intended digit interpretation uses
$x\ge 0$ and $b\ge 2$. For negative inputs the natural floor produces zero
digits, so disjunctivity is false in bases at least two. In bases zero and one,
the predicate is vacuously or trivially true. The relevant theorem hypotheses
exclude these cases, and π is positive.

Write $[k]=\{i\in\mathbb N:i<k\}$, so $[0]=\emptyset$. Define

$$
\operatorname{Disjunctive}_b(x)
\iff
\forall k\in\mathbb N,\;
\forall s:[k]\to[b],\;
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

### Arbitrarily late occurrences and finite prefixes

For every base $b\ge 2$, disjunctivity implies that each word occurs starting
at some $n\ge N$ for every threshold $N$. Prepend $N$ zero digits to the word
and apply disjunctivity to this longer word; its suffix supplies the required
occurrence. This is proved as `isDisjunctive_occurs_ge` in
[`Disjunctivity.lean`](../PiDisjunctivity/Disjunctivity.lean), including the empty
word. Unbounded occurrence positions in $\mathbb N$ are equivalent to infinitely
many positions; conversely, arbitrarily late occurrence implies occurrence by
taking $N=0$. No frequency conclusion follows.

The same padding argument applies to any digit sequence. Consequently adding
or deleting a finite prefix preserves disjunctivity: occurrences survive when
a prefix is added, and arbitrarily late occurrences survive its removal. This
explains why including the finitely many integer-part digits, with the radix
separator omitted, gives the same property as using only fractional digits.
The library formalizes arbitrarily late occurrence for `baseDigit`; this general
finite-prefix explanation is a mathematical argument, not a separate exported
sequence theorem.

## Plan for validating the formulation

“Correctness of the formulation” means establishing that these definitions
capture the intended hexadecimal-digit property. The completed review validates
that comparison through the following steps. The digit definition remains
parameterized by the base; the word–interval and orbit equivalences below are
scoped to base 16.

### 1. Validate the digit definition

The digit bound, scaled-floor recurrence, finite-prefix reconstruction, and
truncation error are now proved for arbitrary bases $b\ge 2$ in
[`Digits.lean`](../PiDisjunctivity/Digits.lean), following Step 3 of the foundations
plan. Reconstruction and error bounds assume $x\ge 0$ and retain the integer
part. Milestone C's supporting `baseDigit_div_pow_eq_zero` theorem explicitly
proves the trailing-zero convention at every position after a terminating
prefix, for all inputs $m/b^k$ with natural $m$ and $b\ge 2$. Exact examples
supplement these general results.

The later `hasSum_baseDigit` theorem additionally proves

$$
\sum_{n=0}^{\infty}\frac{d_b(x,n)}{b^{n+1}}=\operatorname{fract}(x)
\qquad (b\ge 2,\ x\ge 0),
$$

with Lean's `HasSum`, which asserts convergence as well as the value. Its proof
identifies the digits with Mathlib's `Real.digits` on the fractional part and
uses `Real.hasSum_ofDigitsTerm_digits`. No additional library is required.

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

The theorem `isDisjunctive_iff_orbitClosure` in
[`OrbitEquivalence.lean`](../PiDisjunctivity/OrbitEquivalence.lean) now establishes,
for $x\ge 0$,

$$
\operatorname{Disjunctive}_{16}(x)
\iff
\overline{O_{16}(x)}=[0,1],
$$

with closure taken in $\mathbb R$.

The proof has two directions:

- From disjunctivity, obtain orbit points in hexadecimal intervals of arbitrarily
  small width, establishing approximation throughout $[0,1]$, including its
  endpoints. Use the bounds on fractional parts and closedness of $[0,1]$ for
  the other closure inclusion.
- From the closure condition, obtain an orbit point in each hexadecimal interval’s
  **open interior**, then apply the word–interval correspondence.

### 4. Audit the Lean formalization

The [consolidated review](formulation-review.md) compares the quantified statement
directly against the formulation above, reviews the universal proofs, and maps
the exact examples to the requirements. It records a successful build with the
pinned Lean and Mathlib versions, all thirteen actual axiom lists, and a separate
configuration, manifest, and source-import review. The original twelve theorem
types and guards are preserved; the termination theorem has its own type and
axiom guard, and both named π propositions have expanded-definition checks.

This completes formulation verification, including the correspondence between the
digit and orbit statements. Whether π satisfies either formulation remains the
separate research problem.

## Remaining Lean verification roadmap

**Status: milestones A, B, and C complete.**
All three steps of [the foundations plan](foundations-plan.md) are complete. The
completed work is recorded below in dependency order. This roadmap extends the
broader validation plan above; it does not add another foundational step or
change the conjecture. The heading and link are retained for existing references.

The Lean snippets omit proof bodies and use the `PiDisjunctivity` namespace.
The signatures in milestones A and B are implemented and audited. The existing
definitions and reviewed statements have been preserved, and the proofs were
built from the current foundations without restoring the discarded proofs from
history.

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
checks and guarded `#print axioms` results cover the signatures above; these ten
theorems use exactly `propext`, `Classical.choice`, and `Quot.sound`.
The audit rejects unexpected dependencies, and CI runs it after building.

New examples recover `00A` from its length and value, specialize the correspondence
to empty and one-digit words, and check all-zero words at every length and offset.
They also check both boundaries of `00A` and `FF`, the word `0F` at offset one in
`3.A0F`, and the trailing-zero word after the first digit of `0.8000...`.

### B. Establish the orbit-closure equivalence

**Status: implemented and validated.** Both theorems are in
[`OrbitEquivalence.lean`](../PiDisjunctivity/OrbitEquivalence.lean) and exported
through the library root.

```lean
theorem isDisjunctive_iff_orbitClosure (x : ℝ) (hx : 0 ≤ x) :
    IsDisjunctive 16 x ↔
      closure (hexadecimalOrbit x) = Set.Icc (0 : ℝ) 1
```

Both directions hold for arbitrary nonnegative `x`:

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

The module depends on the correspondence and imports `Conjectures.lean` for its
unchanged proposition definitions. The specialization uses `Real.pi_pos.le`:

```lean
theorem piHexadecimalDisjunctivity_iff_orbitClosure :
    PiHexadecimalDisjunctivity ↔ PiHexadecimalOrbitClosure
```

This specialization establishes that the two conjecture statements agree. It
proves neither conjecture.

The private cell-selection helper handles `t = 1` by choosing `16 ^ k - 1`;
for `t < 1`, it uses the natural floor of the scaled point. Thus the forward
proof includes both 0 and 1. `exists_pow_lt_of_lt_one` supplies arbitrarily small
cell widths, and `Metric.mem_closure_iff` turns the resulting approximations into
closure membership. The reverse proof uses `mem_closure_iff` with the open
interval containing the midpoint; it includes `k = 0` without excluding the
empty word.

**Validation:** `lake build`, `lake env lean Test.lean`, and `git diff --check`
pass without warnings on the unchanged Lean and Mathlib `v4.37.0-rc1` pins. The
ten earlier checks remain, and the general equivalence and its π specialization
have exported-type checks and guarded axiom audits. All twelve audited theorems
use exactly `propext`, `Classical.choice`, and `Quot.sound`. CI runs the expanded
audit after building.

New examples derive membership of both endpoints in the closure from
disjunctivity, recover empty and one-digit words, `00A`, and `FF` from full orbit
closure, and use zero's singleton orbit to check that zero is not disjunctive.

### C. Complete the formulation audit and review

**Status: complete.** The [consolidated review](formulation-review.md) maps the
intended problem to the actual definitions, universal theorems, and examples.
It reviews both interval boundaries, both closure endpoints, nonnegativity,
integer parts, and the scope of the π specialization. No definition or original
theorem statement required correction.

The completion criteria, now met, are:

- Compare the exported statements with the intended English formulation: every
  finite hexadecimal word, length retained, zero-based positions, nonnegative
  real inputs where required, and the chosen trailing-zero convention.
- Verify and preserve `Test.lean`'s twelve exported-type checks and guarded
  `#print axioms` results: seven foundational results, three from milestone A,
  and the general orbit equivalence and π specialization from milestone B.
  Record each actual axiom list, allowing only `propext`, `Classical.choice`, and
  `Quot.sound`; a theorem may use fewer. Unexpected dependencies must fail the audit.
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

The review added `baseDigit_div_pow_eq_zero`, proving all digits after a
terminating prefix are zero for every base $b\ge 2$, natural numerator, prefix
length, and later position. New examples cover arbitrary later positions in
bases 2, 10, and 16 and all fractional digits of natural integers. This makes a
consequence of the existing foundations explicit, without changing their meaning.

**Validation:** `lake build`, `lake env lean Test.lean`, and `git diff --check`
pass without final warnings. The twelve original exported types and exact axiom
guards remain; the new theorem brings the total to thirteen, each with actual
dependencies `propext`, `Classical.choice`, and `Quot.sound`. Two additional
checks expand the named π statements to the reviewed digit and orbit formulas.
Configuration, manifest, package checkouts, source imports, and CI were reviewed
separately. Mathlib remains the sole direct external library, with all pins and
inherited dependencies unchanged. The report records the detailed evidence.

Formulation verification is complete. Lean checks the formal proofs relative to
the definitions; the comparison with the intended English statement remains a
mathematical review. The pi disjunctivity conjecture remains unproved. Work on
proving it or formalizing BBP requires separate authorization.

## Implementation status

The earlier cylinder and orbit-equivalence proofs were discarded, including the
specialization to π and their axiom audit. They were written before the formulation
and validation approach were discussed. Milestones A and B now supply new
word–interval and orbit-equivalence proofs, including the specialization to π,
built from the reviewed foundations.

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
word–interval correspondence. Milestone B's `isDisjunctive_iff_orbitClosure` and
`piHexadecimalDisjunctivity_iff_orbitClosure` establish the general orbit equivalence
and its specialization. Milestone C's consolidated review is complete. The
default `lake build` checks the definitions, all three foundational steps,
milestones A and B, the supporting termination theorem, and examples.
Additional word-value examples cover the empty word, any single digit, all-zero
words, leading zeros, `FF`, and positional order (`12` versus `21`). Range examples
exercise the bound at lengths zero and one, coverage of zero at every length,
all single digits, `00A`, `FF`, and the maximum value `16 ^ k - 1` at every length.
Reconstruction examples cover bases 2, 10, and 16, fractional inputs, nonzero
integer parts, leading zeros, zero at every length, and the length-zero error
bound. Terminating inputs have zero error and zero at every later digit; the
nonterminating decimal input `1/3` exercises a nonzero truncation error.
Correspondence examples additionally check empty words, arbitrary single digits,
zero at all lengths and offsets, leading zeros, both interval boundaries, a
nonzero offset in a number with an integer part, and terminating expansions.
Orbit examples additionally check both closure endpoints, word recovery under
the closure hypothesis, and the zero-input counterexample.
The [review follow-up](review-follow-up.md) additionally implements infinite-series
reconstruction and arbitrarily late occurrence. It checks the first four
fractional hexadecimal digits of `Real.pi` as `243F` from Mathlib's proved
rational bounds. These results are included in the default build.
The separate `lake env lean Test.lean` check preserves all thirteen milestone C
theorem types and adds the two new theorem types through the library root.
The later bounded interval pilot adds two more types and the B4/P3 milestone
adds two, then B1a adds the unconditional BBP single-term integral, for twenty
in total, without changing the fifteen formulation/follow-up theorems. B4 assumes
vanishing errors and arbitrarily late open-interval visits;
P3 assumes open-interval visits and yields hexadecimal-cell visits. Both are
general conditional results, with no BBP or global range hypothesis.
Two further checks expand the π proposition definitions; the BBP coefficient
expansion and zero-index value are also checked. Guarded `#print axioms` results
require exactly `propext`, `Classical.choice`, and `Quot.sound` for each theorem. The audit rejects
a changed axiom list, including any introduction of `sorryAx` or a project-specific
axiom. CI runs this check after building. These checks and `git diff --check` pass
with the pinned Lean and Mathlib versions.

The foundations, word–interval correspondence, orbit equivalence, its
specialization to π, and the final formulation review are complete. The
[verification roadmap](#remaining-lean-verification-roadmap) records the proof
sequence, implemented statements, and completed review criteria. The
[review report](formulation-review.md) records findings, actual axiom lists,
dependency checks, commands and results, and limitations. These results make no
claim that every finite word occurs in π.
