# Problem formulation and validation plan

This document states the problem and outlines how to validate its formalization.
The [implementation status](#implementation-status) records the current scope.
The [foundational theorem plan](foundations-plan.md) gives the reviewed statements,
proof methods, and completion status for the foundations. The conjecture about π
remains open.

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

Show that $d_b(x,n)$ lies between $0$ and $b-1$, and that the digits reconstruct the
usual finite base-$b$ truncations of $x$. This establishes the indexing, treatment
of the integer part, and trailing-zero convention.

### 2. Connect finite words to hexadecimal intervals

For a hexadecimal word $s$ of length $k$, let

$$
m_s=\sum_{i=0}^{k-1}s(i)\,16^{k-1-i}.
$$

The central correctness lemma would state, for $x\ge 0$,

$$
\bigl(\forall i<k,\ d_{16}(x,n+i)=s(i)\bigr)
\iff
\operatorname{fract}(16^n x)
\in
\left[\frac{m_s}{16^k},\frac{m_s+1}{16^k}\right).
$$

We would establish this using floor arithmetic, quotient and remainder, and a
lemma explaining how multiplication by $16^n$ shifts the digits. The word-value
part is now proved: length-$k$ words encode exactly the integers $0\le m<16^k$,
with leading-zero padding where needed. The word–interval correspondence itself
remains pending.

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

## Implementation status

The earlier cylinder and orbit-equivalence proofs have been discarded from the
current branch, including the specialization to π and their axiom audit. They
were written before the formulation and validation approach were discussed.

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
3. **Planned:** prove arbitrary-base digit bounds, prefix reconstruction, and
   truncation error.

The default `lake build` checks the definitions, theorems from Steps 1 and 2,
and examples.
Additional word-value examples cover the empty word, any single digit, all-zero
words, leading zeros, `FF`, and positional order (`12` versus `21`). Range examples
exercise the bound at lengths zero and one, coverage of zero at every length,
all single digits, `00A`, `FF`, and the maximum value `16 ^ k - 1` at every length.
The separate `lake env lean Test.lean` check verifies all three reviewed theorem
types through the library root. Guarded `#print axioms` results require exactly
`propext`, `Classical.choice`, and `Quot.sound` for each theorem. The audit rejects
a changed axiom list, including any introduction of `sorryAx` or a project-specific
axiom. CI runs this check after building. These checks and `git diff --check` pass
with the pinned Lean and Mathlib versions.

The cylinder correspondence and orbit equivalence remain unimplemented and will
be addressed after the foundations. Steps 1 and 2 make no claim about the
occurrence of words in π.
