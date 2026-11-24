# Problem formulation and validation plan

This document states the problem and outlines how to validate its formalization.
The [implementation status](#implementation-status) records the Lean results
completed so far. The conjecture about π remains open.

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
lemma explaining how multiplication by $16^n$ shifts the digits. We would also
show that length-$k$ words encode exactly the integers $0\le m<16^k$, with
leading-zero padding where needed.

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

The library now uses hexadecimal expansions throughout its orbit definitions,
equivalence theorems, conjecture definitions, and examples. The canonical
`baseDigit` and `IsDisjunctive` definitions remain parameterized by the base.

The following declarations are compiled in the default `lake build`, in the
`PiDisjunctivity` namespace:

| Declaration | Verified statement |
| --- | --- |
| `blockValue_lt` | A length-$k$ hexadecimal word has value below $16^k$. |
| `digits_iff_prefix` | A word is the prefix of a point in $[0,1)$ exactly when the scaled natural floor equals its value. |
| `baseDigit_hexadecimal_shift` | Taking the fractional part of $16^n x$ shifts the digits by $n$ places, for $x\ge 0$. |
| `block_iff_mem_cylinder` | Occurrence at offset $n$ is equivalent to membership of the orbit point in the corresponding half-open interval. |
| `hexadecimal_disjunctive_iff_orbit_closure` | Disjunctivity in base 16 is equivalent to orbit closure $[0,1]$, for $x\ge 0$. |
| `pi_hexadecimal_disjunctivity_iff_orbit_closure` | The two named conjectures about π are equivalent. |

`blockValue` implements the big-endian value recursively. A separate theorem
equating this recursive definition to the displayed finite sum, the standalone
coverage theorem for all integers below $16^k$, and the arbitrary-base digit
reconstruction results remain follow-up items from the validation plan. The
proved base-16 orbit equivalence does not assume those pending results.

Exact rational examples check the integer part, zero-based indexing, leading
zeros, all digits `A`–`F`, nonzero offsets, terminating expansions, half-open
interval boundaries, and the empty word.

After `lake build`, run `lake env lean Test.lean` to audit the two equivalence
theorems. The audit checks that their only axioms are `propext`, `Classical.choice`,
and `Quot.sound`; it fails if the printed axiom lists change. Neither theorem
depends on `sorryAx` or a project-specific axiom. These results establish the
equivalence of the two formulations, without proving either conjecture about π.
