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

## Analytic sampling, finite differences and the complementary phase

Extension, 2026-11-26; independent review pending. This fresh-context test
changes from ordinary generating functions to interpolation of the actual
samples. It identifies a precise loss at the floor operation, not a new
visitation theorem. The [shared-residual construction](m4-shared-residuals.md)
and exact V contract remain unchanged.

With the positive moment density w used above, define

    E(z)=integral_0^1 x^(z+1)*w(x)/(16-x) dx,
    S(z)=pi*exp(z*log 16)-E(z),  Re z>-9/8.

Near zero the absolute integrand is O(x^(Re z+1/8)); on compact subsets,
logarithmic factors from differentiation have integrable majorants. This
proves holomorphy. Expanding the geometric denominator gives E(n)=bbpTail(n)
and S(n)=S_n. For x>=0,

    abs(E(x+iy))<=E(0),
    abs(S(x+iy))<=pi*16^x+E(0).                            (1)

There is an exact sampling obstruction. Suppose f is holomorphic on a
neighborhood of the closed right half-plane, its samples f(n) are bounded,
and some C>0, a>=0, 0<=b<pi give

    abs(f(x+iy))<=C*exp(a*x+b*abs(y)) for all x>=0.         (2)

Then sum f(n)*z^n continues across z=-1. To prove this, on the sector
abs(arg(-z))<pi-b use the branch log(-z) and the vertical integral

    I(z)=-(1/(2*pi*i))*integral_(1/2-i infinity)^(1/2+i infinity)
                          pi*f(s)*(-z)^s/sin(pi*s) ds.

On compact subsets away from zero its integrand decays like
exp(-(pi-b-abs(arg(-z)))*abs(Im s)); derivatives in z add only polynomial
factors. Thus I is holomorphic there. For abs(z)<exp(-a), close a clockwise
rectangle to Re s=M+1/2. The horizontal integrals vanish as their imaginary
heights tend to infinity, and the right integral is bounded by a constant
times (exp(a)*abs(z))^(M+1/2). Letting M grow gives
I(z)=sum_(n>=1)f(n)*z^n by residues. The signs from sin(pi*s) and (-z)^s
cancel at integers. Therefore f(0)+I continues the power series across -1.
The real growth rate a is unrestricted; the strict bound concerns b.

Now put p_n=floor S_n and c_n=p_(n+1)-16*p_n. One has
c_n=floor(16*fract S_n+A(n+1)) in {0,...,16}, since
0<A(n+1)<=106/819<1. Telescoping gives

    pi=p_0+sum_(n>=0)c_n/16^(n+1).

Irrationality of pi makes c nonperiodic even after deleting any finite prefix.
The already inspected finite-alphabet theorem therefore gives its generating
series a natural boundary. If P satisfying (2) interpolated p_n, then
P(z+1)-16*P(z) would satisfy the same kind of bound and interpolate c_n,
contradicting continuation across -1. There is also no such interpolator for
fract S_n: subtracting it from (1) would give a prohibited P. The argument
applies to every late tail. An entire interpolator of global exponential type
strictly below pi is a special case of (2).

The source input remains Breuer--Simon, Theorem 5.1, printed pp.12--13,
[finite-alphabet natural boundaries](https://web.ma.utexas.edu/mp_arc/c/10/10-29.pdf#page=12).
Carlson's zero-sample uniqueness theorem is not being applied to nonzero
integer samples; the displayed contour proves the required bridge instead.

An omitted interval does not supply (2). For xi=1/17, the base-16 phases
alternate between 1/17 and 16/17, avoiding (4/5,9/10). Their generating
series (1+16z)/(17*(1-z^2)) has a pole at -1, so no interpolator satisfying
(2) exists. Yet 1/2-(15/34)*cos(pi*z) interpolates them at imaginary type pi.
This example tests the inference from a hole to a growth bound; it does not
retain actual BBP forcing or irrationality. The obstruction for the actual
carries likewise uses only bounded nonperiodicity, not their four-pole
arithmetic. A BBP-specific interpolation construction under avoidance remains
missing. Merely raising the allowed type does not supply phase information,
so that inheritance route is suspended.

The exact finite-difference transformation also does not supply a second
action on the original orbit closure. For n,k>=0,

    T_(n,k)=Delta^k S_n
      =16^n*15^k*pi-(-1)^k*I_(n,k),
    I_(n,k)=integral_0^1 x^(n+1)*(1-x)^k*w(x)/(16-x) dx>0.

For fixed n, I_(n,k) tends to zero by domination. For k>=1,
T_(n,k)-15*T_(n,k-1)=Delta^(k-1)A(n+1), with sign (-1)^(k-1) and an
exact rational beta-integral expression. But finite Newton blocks are an
integer triangular change of the original forward block with diagonal one;
their inverse is S_(n+j)=sum_(k<=j)binomial(j,k)*T_(n,k). Polynomial/carry
arguments therefore return to the already tested affine line, with their
transformed coefficient costs. A base-15 visit also need not transfer: 15/17
lies in the interval missed by every base-16 phase of 1/17. No claim about
density of that rational example is made.

Finally, prime compression leaves an exact complementary dynamics. Let p>=7
be prime and p^2>8(n+1)+6. Let a_n and b_n in {0,...,p-1} be the residues
of p*S_n and p*A(n+1) modulo p, and put

    R_n=S_n-a_n/p, Atilde_n=A(n+1)-b_n/p,
    t_n=floor((16*a_n+b_n)/p).

These complementary rationals have denominators prime to p. Reduction of the
actual recurrence gives a_(n+1)=(16*a_n+b_n) mod p and exactly

    R_(n+1)=16*R_n+Atilde_n+t_n, 0<=t_n<=16.              (3)

If p does not divide the coefficient denominator, b_n=0 and Atilde_n=A(n+1).
Modulo integers the complementary phase then follows the original expanding
forced recurrence. There are at most four original p-pole entries in a block
of p coefficient indices. Between entries the complement is not made constant,
slow or independent of its entry value by removing the prime component.

The next discriminating test must identify a restriction on the actual entry
R_n that a proposed prime-block estimate uses. A theorem uniformly treating
that value as free has not exploited the initialized orbit. Equation (3)
does not select the positive branch or control the complementary character;
the exact prefix entry remains necessary. The research log owns the next bound.

The parent read and reconstructed the report, visually inspected both source
pages, checked all manifest hashes and reran the revised exact checker, exit 0
with a byte-identical receipt. It checks 96 rational recurrence/carry instances,
1,088 Newton/beta/sign instances and 4,503 complementary recurrences. These
are finite diagnostics, not analytic certification or a word search.
Frozen evidence:

- `/tmp/pi-m4-phase-bridge-report-v3.md`, SHA-256
  `1b3467b1fb45773886f99b874ccdfd4b8ecdb50592482f0165698e913e2fc667`.
- `/tmp/pi-m4-phase-bridge-check-v3.py`, SHA-256
  `e225d4a8457a14519368e3c408f56eae71aa814f8699fe13691943350d14a7b5`.
- `/tmp/pi-m4-phase-bridge-receipt-v3.json`, SHA-256
  `bc9d5596c081105af2cddb025c5b1f292cc96d094a7af0a70d50588e89368a02`.
- `/tmp/pi-m4-phase-bridge-manifest-v4.json`, SHA-256
  `174ec5c94ec5b44d5b9a7ffdf4a3aad699acc41099880feab1492211be99f726`.

The retained evidence erratum replaces the earlier checker's floating square
root in trial division by `math.isqrt`; mathematical claims and counts are
unchanged. It also records when the local source rendering was added. No new
Lean proof, export or audit is claimed; V and M4 remain open.

## Finite entry data still allow a different avoiding block

This follow-up is under independent review. It resolves the proposed entry
test while retaining substantially more than a free real starting point.
For every sufficiently large prime N=p there is a rational x!=S_N such that,
under the exact forcing x_(j+1)=16*x_j+A(N+j+1), 0<=j<N:

- den(x)=den(S_N) and floor(x)=floor(S_N);
- p*x_j and p*S_(N+j) have the same residue modulo p for every 0<=j<=N;
- x_j=S_(N+j) modulo 16^(N+j) as rational 2-adic congruences;
- every fract(x_j) lies strictly between 18/100 and 21/100.

All relevant p-poles have order at most one, so the second condition preserves
the complete principal p-component, including at entry events. These statements
do not preserve global zero initialization, every future reduced denominator,
or infinite avoidance. They refute only a block guarantee uniform over entries
with these arithmetic summaries. They say nothing about whether the actual
entry S_N visits this particular block.

Here is the construction. At N=p>=17 the positive compression has h=1,s=0:

    p*S_p = 752/15 mod p if p=1 mod4,
    p*S_p = -1040/21 mod p if p=3 mod4.

Both are nonzero in their applicable classes: the odd numerator factor 47
in the first belongs to the other class, as do 5 and 13 in the second.
Denominators are p-units. Thus S_N=P/q reduced with q=p*Q, Q odd and p not
dividing Q. The reviewed denominator theorem gives log Q=6N+o(N). Its prime
support is at most 8N+6, so omega(Q)=O(N/log N)=o(N), using ordinary PNT.

For an integer t set

    x(t)=S_N+16^N*t/Q=(P+p*16^N*t)/q.                     (4)

Its numerator is always a p-unit. For each prime ell|Q, exactly one residue
class of t makes that numerator divisible by ell. Avoiding those classes
preserves the entire reduced denominator q, including all prime powers.
The propagated difference is exactly

    x_j-S_(N+j)=16^(N+j)*t/Q.                            (5)

This proves the dyadic precision and the principal p-residue equality. The
bound p^2>16p+6 for p>=17 controls the whole block through N+j=2N.

For the real location, use r_n=1/5-E_n. B3 and positivity give
0<E_n<1/100 for n>=17, and the exact tail recurrence yields

    16*r_n+A(n+1)=3+r_(n+1).

Let k=floor(S_N), epsilon=1/100. Every x in the open interval centered at
k+r_N with radius epsilon*16^(-N) has that same integer part. Its j-th
iterate is

    16^j*k+(16^j-1)/5+r_(N+j)+16^j*e,
    abs(e)<epsilon*16^(-N).

The first two terms are integers; the last two lie in (18/100,21/100) for
0<=j<=N. The synthetic target uses the actual tail only existentially; no
actual tail value or digit block has been searched.

Under (4), this target interval has t-length

    L_N=2*epsilon*Q/16^(2N),
    log L_N=(6-2*log16)*N+o(N).

In any open real interval of length L, a residue class modulo d contains
L/d integers with error at most 1, including integer endpoints. CRT and
inclusion-exclusion over the w=omega(Q) forbidden prime classes therefore give

    G >= L*product_(ell|Q)(1-1/ell)-2^w
      >= L*2^(-w)-2^w

admissible integers. Because 6>2*log16 and w=o(N), eventually L_N>2*4^w,
which makes G>1. Excluding t=0 still leaves a choice. Equations (4)-(5) and
the target interval prove all four properties, with x genuinely different
from S_N. Reversing the un-fractional recurrence would change S_(-1)=0 by
t/(16Q); since abs(x-S_N)<1, that change is nonzero and has magnitude below
1, so it does not preserve the original fractional initialization either.

The actual complementary entry cannot therefore be selected by these size,
denominator, single-prime and finite dyadic data alone. A useful global-history
restriction must retain additional coupled information from the initialized
prefix. Naming that information is not a cancellation estimate. The real
visitation bridge remains open.

The parent reconstructed the proof and reran the exact checker, exit 0. It
checks 25 prime-entry constants, 175 denominator equivalences, 11,928
propagated congruences, 80 open-interval sieve cases and 115 synthetic affine
identities. It does not construct an actual-tail target numerically; universal
existence and the real avoidance bounds are paper arguments. Frozen evidence:

- `/tmp/pi-m4-entry-phase-report-v1.md`, SHA-256
  `675d153986e221d916b1240e3f734576679378ea842f6b951f4943a821ffe99f`.
- `/tmp/pi-m4-entry-phase-check-v1.py`, SHA-256
  `774f3357e3ac103e24f82157859a656ef5c132164d52e4e571cb4a67fb746b4c`.
- `/tmp/pi-m4-entry-phase-receipt-v1.json`, SHA-256
  `d58665b3293685aebbdb33bd1dbaad4b53785571cb964da9451817c271fd7801`.

No global counterexample, Lean export or M4 acceptance follows. The independent
review record owns both this extension and the sampling extension's status.

## Rational entries preserve universal late visitation

Changing the rational entry does preserve the *global* visitation question.
This paper bridge does not transfer a visit to an individual interval, and
does not turn the preceding finite avoiding blocks into infinite avoidance.

Let T(x)=16x on R/Z and K_alpha be the omega-limit set of T^n alpha.
Compactness and continuity give T(K_alpha)=K_alpha. If K_alpha contains an
open arc, some iterate of T maps that arc onto the circle, so K_alpha is the
whole circle. Every proper K_alpha is therefore closed and nowhere dense.
For rational r its T-orbit F_r is finite, including any transient part, and

    K_(alpha+r) subset union_(t in F_r) (K_alpha+t).

A finite union of closed nowhere-dense sets is nowhere dense. Applying the
same argument with -r shows that universal late density is invariant under
rational translation. For every nonzero integer m, K_(m alpha)=m K_alpha;
the inverse image of m K_alpha under multiplication by m is the finite union
of K_alpha+j/abs(m). Thus a proper K_alpha still has a proper image. Using
integer multiplication twice with a real lift of alpha/q proves invariance
under every nonzero rational affine map. Division by q is not a circle map.

Fix N and one rational raw entry e. Use the exact future coefficients:

    t_0=e,  t_(j+1)=16*t_j+A(N+j+1),  v_j=fract(t_j).
    t_j=16^j*(e+E_N)-E_(N+j),
    e+E_N=16^N*pi+(e-S_N).

The checked split and tail convergence give these identities and a circle
distance tending to zero between v_j and the pure orbit of e+E_N. Their
omega-limit sets coincide. Since S_N is rational, full late visitation by
this one fixed entry is equivalent to V. At e=S_N the indices are exactly
v_j=bbpRecurrence(N+j+1). Open-circle subintervals give the original real
interval contract, including targets adjacent to 0 or 1.

More generally, ONE fixed finite nonempty family of rational entries (at
possibly different fixed times) whose union visits every target arbitrarily
late suffices for V. Otherwise every member has a proper nowhere-dense omega
set, and their finite union leaves an open arc eventually avoided by all.
The family must be fixed before both target and threshold are chosen. This
consumer is equivalent to V, not an estimate establishing its premise.

Growing rational grids do not supply that premise. For odd q and entries
e_a=e_0+a/q, the states at each time are a translated complete q-grid, with
all future forcing retained. Let mu be a J-state empirical measure from the
base entry and nu the empirical measure of all qJ states. Then

    nu_hat(h)=1_(q divides h)*mu_hat(h),
    Energy(nu)=(1-q^(-2))/6+q^(-2)*Energy((x -> q*x)_*mu).

Here Energy uses psi(x)=fract(x)*(1-fract(x)), probability normalization and
all diagonal pairs. The second identity is the quadratic Bernoulli distribution
identity; at J=1 its value is exactly (1-q^(-2))/6. It tends uniformly to 1/6
as q grows for *every* base phase. For fixed q, the union of omega sets is
exactly the inverse image of K_(q*(e_0+E_N)) under multiplication by q.
The surviving q-harmonics still carry the full V obligation.

Indeed, even `forall target I, exists rational entry e, forall threshold,
exists later visit to I` holds for every phase: choose a fine enough odd grid,
then one of its finitely many seeds hits I infinitely often. The quantifier
swap is false. An explicit irrational test is the base-16 number with digits
1 plus the Thue--Morse parity sequence. Its orbit stays in [1/15,2/15], and
all its rational translates are nondense, while the grid identities still
hold. Its translate by 1/3 always lies in (1/3,1/2), showing why individual
interval behavior does not transfer. This model tests the averaging inference;
it is not claimed to retain A.

The frozen `/tmp/pi-m4-rational-entry-20261127/` report has SHA-256
`36a5e8f2af6347459c619ba67c4c02aa1098f76cb88cdfaf41322bf5cb4f5b1d`;
its manifest has SHA-256
`8d1d86883279e610b0792d74a5f7642f7e80e12c2c08191c03fd8cae985f8e25`.
The parent reconstructed the argument and replayed an unchanged checker copy:
5,369 structural/parity checks passed, exit 0, identical receipt, originals
preserved. These checks do not prove the universal topological statements.
No Lean theorem, actual initialized digit search or V acceptance is claimed.
