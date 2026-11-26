# M4 continuation: generating functions and phase information

Research record, 2026-11-26. This continues the authorized investigation after
local checkpoint `052234d` and its factual receipt. V remains open. The new
carry interface below was checked in scratch Lean through the library root;
the complex-analytic conclusions are paper mathematics using an inspected
source theorem. No new production module, export or audit is claimed.

## Exact carries and a checked special value

For the existing recurrence y and coefficient A, define

```text
k_n=floor(16*y_n+A_n),
y_(n+1)=16*y_n+A_n-k_n,
H(z)=sum_(n>=0) A_n*z^n,
Y(z)=sum_(n>=0) y_n*z^n,
K(z)=sum_(n>=0) k_n*z^n.
```

The scratch namespace `M4CarryProbe` defines k from the actual imported BBP
objects. Its unconditional checked declarations are:

| Declaration | Contract |
| --- | --- |
| `carry_eq` | `(carry n : Real)=16*bbpRecurrence n+bbpCoeff n-bbpRecurrence(n+1)` |
| `carry_zero` | `carry 0=3` |
| `carry_bounds` | `-8<=carry n` and `carry n<24` for every natural n |
| `summable_recurrence` | Summability of `bbpRecurrence n/16^n` |
| `hasSum_carry` | `HasSum (fun n => (carry n : Real)/16^n) Real.pi` |

The deliberately loose integer bound gives a finite alphabet without a new
coefficient-positivity proof. It is sufficient for the analytic theorem below.
These carries are not assumed to be ordinary hexadecimal digits. In particular,
an eventual upper bound of 15 has not been established. The paper coefficient
estimate alone permits carry 16 near the upper endpoint of the recurrence range.

All three complex series converge absolutely for `abs(z)<1`, by bounded
coefficients. Summing the recurrence gives the exact identity

```text
(1-16*z)*Y(z)=z*(H(z)-K(z)).
```

The divided form uses the removable value of Y(z)/z at zero. At z=1/16 it gives
`K(1/16)=H(1/16)=pi`. The exponent here is n, not n+1. The scratch proof checks
this special value directly over the reals by summing the carry decomposition:
the two shifted, absolutely convergent recurrence series cancel, and B1 supplies
the remaining coefficient sum.

## Natural boundaries of the actual series

The source is Breuer–Simon, [*Natural Boundaries and Spectral Theory*](https://web.ma.utexas.edu/mp_arc/c/10/10-29.pdf),
26 January 2010 version, Theorem 5.1, printed p.12, with proof on p.13.
For a power series whose coefficients lie in a finite set, it gives either a
strong natural boundary on the unit circle or eventual periodicity of its
coefficients. The periodic case is rational. Only the ordinary natural-boundary
conclusion is needed here: no analytic continuation across any unit-circle point.
Neither missing words nor equidistribution is a premise of the source theorem.

The actual carry word is not eventually periodic. If it had preperiod N and
period T>0, then

```text
K(z)=sum_(n<N) k_n*z^n
    +z^N*(sum_(j<T) k_(N+j)*z^j)/(1-z^T).
```

Its value at the rational point 1/16 would be rational, contradicting the
checked value pi and irrationality of pi. The finite-alphabet theorem therefore
gives K a natural boundary. Its radius is exactly 1: bounded coefficients give
radius at least 1, while infinitely many nonzero integer coefficients give
limsup of their n-th-root absolute values equal to 1.

The forcing H, however, continues across every unit-circle point except 1.
With `P(t)=4-2*t^3-t^4-t^5`, uniform geometric convergence gives

```text
H(z)=integral_0^1 P(t)/(1-z*t^8) dt       for abs(z)<1.
```

For a unit-circle point zeta other than 1, `1-zeta*t^8` is nonzero on `[0,1]`.
Its modulus has a positive minimum delta. For `abs(z-zeta)<delta/2`, expand

```text
1/(1-z*t^8)
 =sum_(j>=0) (z-zeta)^j*t^(8j)/(1-zeta*t^8)^(j+1).
```

On every smaller closed disk this is uniformly absolutely convergent in t,
with a geometric majorant. Bounded P permits termwise integration, supplying
a genuine local analytic continuation, not just a formal integral identity.
The same reasoning gives holomorphy off the slit `[1,infinity)`.

If Y continued across zeta other than 1, the exact generating identity would
continue `K=H-(1-16z)Y/z` there, a contradiction. Continuation of Y near 1 would
also continue it near some adjacent unit-circle point other than 1, again a
contradiction. Thus Y also has radius 1 and the entire unit circle as a natural
boundary. Both conclusions concern the actual BBP recurrence, without V.

In particular neither K nor Y is D-finite. A nonzero linear differential
equation with polynomial coefficients permits local continuation at every
ordinary point; only finitely many points can be zeros of its leading
coefficient. A natural boundary forbids continuation at all unit-circle points.
By contrast H satisfies the exact inhomogeneous equation, for `theta=z*d/dz`,

```text
(8theta+1)(8theta+4)(8theta+5)(8theta+6) H
  =(376+1416*z+128*z^2)/(1-z)^3.
```

This follows termwise from `(8theta+r) sum z^n/(8n+r)=1/(1-z)`.
The rational right side has a polynomial-coefficient differential annihilator,
giving a homogeneous equation for H. Hence analytic or D-finite forcing does
not make the recurrence or carry series D-finite. Their boundary singularities
already cancel in the exact identity; that cancellation cannot be declared
impossible as a proposed contradiction.

## Why a natural boundary does not supply visits

For an explicit discriminator, let `a_n=1` when `n=j!` for some integer j>=2,
and 0 otherwise. Its word is not eventually periodic: it has infinitely many
1s and unbounded gaps. Its finite-alphabet power series therefore has a natural
boundary by the same theorem. Nevertheless
`xi=sum_(n>=0) a_n/16^(n+1)` has every shifted fractional part in `[0,1/15]`,
by the geometric tail bound. Its orbit permanently misses `(1/4,3/4)`.

A missing word does not even force automaticity. If the canonical base-16
representations of factorials formed a regular language, pumping a loop in
a sufficiently long accepted word would give an infinite increasing sequence
of factorials whose digit lengths grow by a fixed increment h. Successive
ratios would then be bounded by `16^(h+1)`. Ratios along any increasing infinite
subsequence of factorials tend to infinity, a contradiction. This separates
a proposed general inference, without asserting anything about automaticity
of the actual carry word.

The discriminator does not retain BBP forcing or its initialization. It shows
that the analytic conclusion alone is insufficient. The missing step would be
an additional, justified consequence of actual BBP interval avoidance that
conflicts with the facts above. Finite alphabet and the linear generating
identity supply no such step; carries cannot silently be substituted for digits.

## Phase corrections and a sharp generic bound

For a nonzero integer h, let `e(x)=exp(2*pi*i*x)` and, for `abs(z)<1`, define

```text
Phi_h(z)=sum_(n>=0) e(h*y_n)*z^n,
G_h(z)=sum_(n>=0) (e(h*A_n)-1)*e(16*h*y_n)*z^n.
(Phi_h(z)-1)/z=Phi_(16h)(z)+G_h(z).
```

The correction G_h is absolutely summable even at z=1 for each fixed h because
`A_n=O(n^-2)`. Splitting `sum_n min(2,2*pi*abs(h*A_n))` at n of order
`sqrt(abs h)` gives `G_h(1)=O(sqrt(abs h))`. This estimate is sharp in the
earlier [rational avoiding model](m4-rational-forcing.md), even with its
positivity, complete monotonicity, simple poles, non-coboundary property and
identical leading coefficient `15/64`. Its thirteen poles and rational weighted
constant remain distinctions from actual BBP; no pi-specific improvement is
refuted.

Write that model's forcing as F, trajectory as v, weighted constant as
`q=sum F_n/16^(n+1)=2/21`, and tail as
`E_n=sum_(r>=0) F_(n+r+1)/16^(r+1)`. Its rational asymptotic gives an all-index
bound `0<E_n<=C/(n+1)^2` and `n^2*E_n -> c=1/64`, by geometric domination.
For positive integers h divisible by 21, finite recurrence summation gives

```text
sum_(n=0..M) (e(h*F_n)-1)*e(16*h*v_n)
 =sum_(n=0..M-1) [e(-h*E_n)-e(-16*h*E_n)]+e(-h*E_M)-1.
G_h(1)=sum_(n>=0) [e(-h*E_n)-e(-16*h*E_n)].
```

The initial term is included; the boundary tends to zero. All difference
series are absolutely convergent. For x>0 the step functions
`f_h(x)=e(-h*E_floor(sqrt(h)*x))-e(-16*h*E_floor(sqrt(h)*x))`
converge to `e(-c/x^2)-e(-16*c/x^2)` and are dominated by the integrable
`min(2,30*pi*C/x^2)`. Their integrals equal `G_h(1)/sqrt(h)`. Thus

```text
G_h(1)/sqrt(h) -> I_c=integral_0^infinity [e(-c/x^2)-e(-16*c/x^2)] dx.
```

This limit is nonzero without evaluating a Fresnel integral. The absolutely
convergent `J_c=integral [e(-c/x^2)-1] dx` satisfies `J_(16c)=4*J_c`, so
`I_c=-3*J_c`. Its integrand has nonpositive real part everywhere and at most
-1 on `[sqrt(2*c),2*sqrt(c)]`. Consequently
`Re I_c >= 3*(2-sqrt(2))*sqrt(c)>0`. Domination controls both improper endpoints;
a finite numerical fit is not being used as an asymptotic proof.

For actual BBP the corresponding exact identity is

```text
T_h=sum_(n>=0) e(h*16^n*pi)*(e(-h*bbpTail(n))-1),
G_h(1)=e(h*pi)-1+T_h-T_(16h).
```

Each T_h is absolutely convergent. B2 and finite reindexing give the formula;
the initial term `e(h*pi)-1` must be retained. An improvement has to use the
actual pi-dependent phases. Even `o(sqrt(h))` alone has no proved consumer
excluding a forbidden cylinder; it is not a replacement for V.

For `M_N(h)=sum_(n<N)e(h*y_n)/N`, the exact finite identity is

```text
N*(M_N(h)-M_N(16h))=sum_(n<N)(e(h*A_n)-1)*e(16*h*y_n)-e(h*y_N)+1.
```

Fixed-h summability only gives `m_h=m_(16h)` for limiting orbit Fourier
coefficients. Iterating does not make the common value zero, and the generic
correction bound grows by `4^k` at frequency `16^k*h`.

Even diffuse invariant measures and averaged frequency decay are insufficient.
Let X have independent fair base-16 digits 0 and 1, with law mu. It is invariant
under multiplication by 16 modulo 1, has no atoms, and is supported in `[0,1/15]`.
Its coefficient at 1 has positive modulus `product_(j>=1) cos(pi/16^j)`, and
invariance gives `muhat(16^k)=muhat(1)`. Nevertheless the mean of
`abs(muhat(h))^2` over `1<=h<=H` tends to zero. Expand it as a double integral
of normalized geometric sums: they are bounded by 1 and tend to zero off the
diagonal, which has product measure zero. Dominated convergence applies. This
separates frequency averaging from decay on the required lacunary cascade;
it is not a claim about an empirical measure of pi.

## Null-series averaging and the order of quantifiers

A changed-representation test keeps the represented constant fixed. Set

```text
t(n)=n/(n+1)^4,  D(n)=t(n+1)-16*t(n),
A_lambda(n)=A(n)+lambda*D(n),
y^lambda_0=0,  y^lambda_(n+1)=fract(16*y^lambda_n+A_lambda(n)).
```

For every fixed real lambda, induction using integer multiplication inside
fractional part gives `y^lambda_n=fract(y_n+lambda*t(n))`. Telescoping gives

```text
sum_(n=0..M) D(n)/16^(n+1)=t(M+1)/16^(M+1),
sum_(n>=0) A_lambda(n)/16^(n+1)=pi/16.
```

Since `D(n)~ -15/n^3`, every fixed member retains the leading BBP term
`15/(64*n^2)` and is eventually positive. Rational coefficient functions over
Q require rational lambda; the original pole pattern and complete monotonicity
are not retained or asserted. Global nonnegativity already forces a bounded
parameter range: the n=0 and n=1 conditions alone give

```text
A_lambda(0)=47/15+lambda/16,
A_lambda(1)=106/819-(79/81)*lambda,
-752/15 <= lambda <= 954/7189.
```

These are necessary conditions only. Circle distance between the trajectories
is at most `abs(lambda)*t(n)`, tending to zero for fixed lambda. Strict inner
intervals transfer full late visitation in both directions, including targets
touching an endpoint. Ordinary differences of representatives need not tend
to zero because fractional part can wrap.

At each n>0, a parameter uniform on `[0,1/t(n)]` makes `y^lambda_n` exactly
uniform on the circle. This does not yield a fixed visiting trajectory: these
laws escape every bounded parameter set, and their offsets are order one at
the sampled horizon. For the base forcing A=0, the same identity gives
`y^lambda_n=fract(lambda*t(n))`. Every fixed nonnegative lambda tends to 0;
every fixed negative lambda tends to 1 as a representative, hence to 0 on the
circle. All fixed trajectories eventually avoid the central hole, although
each horizon marginal assigns it probability 1/2.

Any fixed probability law on real lambda has vanishing offsets almost surely
and in probability, without a moment assumption. Tight horizon-dependent laws
also give vanishing offsets, by uniform smallness on a bounded set carrying
most of their mass. Non-tightness is therefore necessary for this full-circle
randomization. The required joint event combines an inner-interval visit with
a small offset; the uniform marginal supplies no such estimate.

More generally, a perturbation D tending to zero with zero weighted sum has
canonical offset

```text
r_n=16^n*sum_(k<n) D(k)/16^(k+1)
   =-sum_(s>=0) D(n+s)/16^(s+1),
abs(r_n)<=sup_(k>=n) abs(D(k))/15 ->0.
```

This gives the same fixed-law obstruction for broader null families. Bounded
nonvanishing offsets can preserve the constant by telescoping, but the
vanishing-error transfer then requires a separate argument.

## Changed discovery question

The generic frequency improvement and null-family averaging inference are
suspended. A bounded structural calculation now asks whether a nonzero rational
null direction exists within the original four simple poles, with the leading
1/n coefficient cancelled. This could distinguish that shape from the larger
countermodel; it cannot rescue the invalid averaging inference. Exact logarithmic
relations must be proved, not presumed independent. A separate fresh-context
pass tests a pi-specific arithmetic connection against the accumulated failure
record. Neither cycle assumes it will prove V.

## Receipts and remaining limits

The immutable worker report is `/tmp/pi-m4-generating-boundary-report-v1.md`.
Its exact-rational script checks the displayed differential operator, initial
carry and recurrence indexing through n=120. Finite observations do not prove
natural boundaries or an eventual carry range.

The frequency argument is retained in
`/tmp/pi-m4-frequency-sharpness-report-v1.md`; it uses exact identities and
dominated convergence, not a numerical experiment. The null-family report is
`/tmp/pi-m4-null-family-randomization-report-v1.md`; its exact-rational checker
was inspected and rerun by the parent, exit 0. The 240 finite cases and exact
positivity thresholds are sanity checks separate from the universal arguments.

The parent scratch file `/tmp/pi-m4-carry-probe-final.lean` has SHA-256
`97d51eeeb1b3431cc08742ec44738c22c9da1e46a28ebdf73e0124d646d3a386`.
Pinned `lake env lean` exited 0, and all five displayed declarations depend
only on `propext`, `Classical.choice`, `Quot.sound`. Full output is retained in
`/tmp/pi-m4-carry-probe-final-output.txt`. An exploratory check named a nonexistent
`HasSum.congr`; a second compilation exposed an overly broad recurrence rewrite.
Both were repaired before freezing. Failed elaborations are not proof evidence.

The finite bound and weighted value are checked; the complex power-series,
continuation, non-D-finiteness and discriminator arguments remain paper proofs.
No substantial complex-analysis API is being formalized without a surviving V
consumer. The separate [continuation review](agy-reports/m4-continuation-review.md#generating-function-and-phase-checkpoint)
completed with no findings. It covers these diagnostic claims, not V acceptance;
the previous checkpoint's review was not reused for this new file.
