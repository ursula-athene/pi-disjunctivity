# Problem formulation and validation plan

This document states the problem and outlines how we would validate its
formalization. It does not carry out those proofs or assert the conjecture.

## Problem formulation

> Every finite string of decimal digits occurs contiguously after the decimal
> point in π.

Strings may contain leading zeros, and their lengths matter: `007` and `7` are
different strings. We require an occurrence somewhere, without specifying a
frequency. This property is called **decimal disjunctivity**.

For a nonnegative real number $x$, define its zero-based digit in base $b$ by

$$
d_b(x,n)=\left\lfloor b^{n+1}x\right\rfloor\bmod b,
\qquad b\ge 2,\quad n\in\mathbb N.
$$

Thus $d_{10}(x,0)$ is the first digit after the decimal point. The floor convention
selects the trailing-zero expansion for terminating decimals. In Lean, the floor
in this definition is `Nat.floor`; the restriction $x\ge 0$ ensures that it agrees
with the usual floor.

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
\boxed{\operatorname{Disjunctive}_{10}(\pi).}
$$

The empty string, $k=0$, imposes no condition. In Lean, a length-$k$ word in base
$b$ is represented by a function `Fin k → Fin b`, so its length and digit bounds
are explicit.

## Plan for validating the formulation

“Correctness of the formulation” means establishing that these definitions
capture the intended decimal-digit property. We would validate that through the
following steps. The digit definition remains parameterized by the base; the
word–interval and orbit equivalences below are scoped to base 10 for the first
milestone.

### 1. Validate the digit definition

Show that $d_b(x,n)$ lies between $0$ and $b-1$, and that the digits reconstruct the
usual finite base-$b$ truncations of $x$. This establishes the indexing, treatment
of the integer part, and trailing-zero convention.

### 2. Connect finite words to decimal intervals

For a decimal word $s$ of length $k$, let

$$
m_s=\sum_{i=0}^{k-1}s(i)\,10^{k-1-i}.
$$

The central correctness lemma would state, for $x\ge 0$,

$$
\bigl(\forall i<k,\ d_{10}(x,n+i)=s(i)\bigr)
\iff
\operatorname{fract}(10^n x)
\in
\left[\frac{m_s}{10^k},\frac{m_s+1}{10^k}\right).
$$

We would establish this using floor arithmetic, quotient and remainder, and a
lemma explaining how multiplication by $10^n$ shifts the digits. We would also
show that length-$k$ words encode exactly the integers $0\le m<10^k$, with
leading-zero padding where needed.

Keeping $k$ explicit preserves leading zeros: `007` corresponds to
$[0.007,0.008)$.

### 3. Validate the alternate orbit formulation

Define

$$
O(x)=\{\operatorname{fract}(10^n x):n\in\mathbb N\}.
$$

Then establish, for $x\ge 0$,

$$
\operatorname{Disjunctive}_{10}(x)
\iff
\overline{O(x)}=[0,1],
$$

with closure taken in $\mathbb R$.

The planned argument has two directions:

- From disjunctivity, obtain orbit points in decimal intervals of arbitrarily
  small width, establishing approximation throughout $[0,1]$, including its
  endpoints. Use the bounds on fractional parts and closedness of $[0,1]$ for
  the other closure inclusion.
- From the closure condition, obtain an orbit point in each decimal interval’s
  **open interior**, then apply the word–interval correspondence.

### 4. Audit the Lean formalization

Compare its quantified statement directly against the formulation above;
compile the supporting results; inspect their axiom dependencies for unfinished
proofs or added assumptions; and check exact examples covering indexing, leading
zeros, terminating decimals, and the empty word. Examples provide sanity checks
alongside the general correctness results.

The validation should include a reproducible build using the pinned Lean and
Mathlib versions, and an inspection of `#print axioms` for the equivalence theorem
to ensure that it depends on neither `sorryAx` nor any project-specific axiom.

Completing this validation would establish the correspondence between the digit
and orbit formulations. Whether π satisfies either formulation would remain the
separate research problem.
