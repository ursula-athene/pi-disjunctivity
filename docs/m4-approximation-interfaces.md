# M4 continuation: approximation costs and source interfaces

Research record, 2026-11-26. These are paper arguments and source-application
tests, not Lean exports or a proof of V. The related
[logarithmic assessment](m4-logarithmic-constraints.md) records the pole-space
invariants. Here the question is whether a precise neighboring theorem or
auxiliary construction turns actual interval avoidance into a contradiction.
Independent review and its focused clarification follow-up are complete in the
[continuation review record](agy-reports/m4-continuation-review.md).

## Quantitative polynomial values at pi

Waldschmidt, [*Transcendence measures for exponentials and logarithms*](https://webusers.imj-prg.fr/~michel.waldschmidt/articles/pdf/JAustralMS25-1978-445-465.pdf),
1978, defines a transcendence measure on printed p.445 and gives the pi
specialization in Corollary 3.2 on p.452. With natural logarithms, for nonzero
integer Q, degree at most d>=2 and coefficient height at most H_0>=16, it gives

```text
log abs(Q(pi)) >= -2^40*d*(log H_0+d*log d)*(1+log d).
```

The definition uses a non-strict lower bound. Parent inspection of the original
page corrected a worker's initial strict inequality; the contradiction below
therefore requires a strict upper bound. This correction leaves the subsequent
cost comparisons unchanged. The parent visually checked the definition and
corollary; this is not a claim of the best available transcendence measure.

For `lambda=pi/4`, an integer P with degree at most d and height at most H>=1
gives `Q(X)=4^d*P(X/4)` of height at most `4^d*H`. Thus

```text
log abs(P(lambda)) >= -B(d,H),
B(d,H)=d*log 4
  +2^40*d*(log H+d*log 4+d*log d)*(1+log d).
```

A polynomial contradiction would require a nonzero P with the proved degree
and height bounds and `abs(P(pi/4))<exp(-B(d,H))`. At H=1 the exponent has
order d^2*(log d)^2. This is the concrete arithmetic threshold used here.

### A whole allowed-prefix tree cannot supply that uniform bound

Test the single forbidden digit F. Let K consist of real base-16 expansions
using digits 0,...,14, and let `K_lambda=3/4+K/4`, contained in `[3/4,59/60]`.
Hypothetical avoidance from index zero by pi would put pi/4 in this set;
no such membership is asserted. At depth L, q=16^L, there are M=15^L prefix
integers p. The nodes `x_p=3/4+p/(4q)` lie in K_lambda, have mutual spacing
at least 1/(4q), and approximate their infinite continuations within 1/(4q).

For an integer polynomial P of exact degree d>=1, choose L minimal with
15^L>=d+1, and select d+1 ordered nodes x_0<...<x_d. Lagrange interpolation
of the leading coefficient a_d gives

```text
1 <= abs(a_d)
  <= sup_(K_lambda) abs(P) * (4q)^d * sum_(i=0)^d 1/(i!*(d-i)!),
sup_(K_lambda) abs(P) >= d!/(8q)^d.
```

The spacing bound in each product is `i!*(d-i)!/(4q)^d`. For a polynomial
of smaller actual degree, apply the same argument to that degree, or select
only the needed nodes. Since `q<=16*(d+1)^(log16/log15)<16*(d+1)^2`, every
nonzero integer polynomial of degree at most d satisfies the weaker bound

```text
sup_(K_lambda) abs(P) >= [128*(d+1)^2]^(-d).
```

For d>=2,H>=1, B(d,H) exceeds `d*log128+2*d*log(d+1)`. Hence no such
polynomial can meet the contradiction threshold uniformly on K_lambda,
regardless of its height. This excludes a whole-tree uniform construction,
not a polynomial that is small at the actual pi branch and large elsewhere.

A concrete simultaneous pigeonhole construction exposes the same cost.
Use `(H+1)^(d+1)` coefficient vectors in {0,...,H}. Their values at every
node lie in [0,60H]. Partition that interval into J bins at each of the M
nodes. If `(H+1)^(d+1)>J^M`, two vectors have the same bin pattern, producing
a nonzero difference polynomial of height at most H. Its derivative is at
most `3600H` on `[3/4,59/60]`, so its guaranteed uniform bound is

```text
U=60H/J+900H/q.
```

If U<1 then J>60H>=H+1, whence d+1>M. As q=M^(log16/log15)<M^2, this
guarantee satisfies `U>900H/(d+1)^2`, far above the needed threshold. This
is a bound on the guarantee, not on the polynomial's accidental actual value.
Indeed X^d already gives a better uniform exponential upper bound; the
interpolation argument, rather than this particular construction, handles
all uniform integer polynomials.

Even the favorable one-point count is too weak: coefficients chosen from
the 15^L allowed L-digit integers have height H=16^L-1. At lambda=pi/4<4/5,
pigeonhole gives a difference value at most `5H/(15^(L*(d+1))-1)`.
Because 15^L<=H, this guarantee exceeds `5H^(-d)`, providing only the
d*log H scale rather than B(d,H). No independent-sign concentration or
branch-dependent cancellation has been obtained.

For eventual avoidance after N, retain the affine cost explicitly. With
`q_0=16^N`, `p_N=floor(q_0*pi)`, the allowed tail is
`alpha=4*q_0*lambda-p_N` in K. A polynomial Q in alpha becomes
`P(X)=Q(4*q_0*X-p_N)` with

```text
height(P) <= height(Q)*(d+1)*(8*q_0)^d.
```

For polynomials directly on `(p_N+K)/(4q_0)`, the interpolation bound is
`d!/(8*q_0*q)^d`. The threshold and localized-set factors must not be mixed.
None of these arguments rules out a polynomial tailored to the actual branch;
its coefficients, affine height cost and extra cancellation would still need
to be supplied. The test does not exclude even the digit F for actual pi.

## Arithmetic holonomy: continuation and arithmetic must belong to one object

Calegari–Dimitrov–Tang, [*Arithmetic Holonomy Bounds and Effective Diophantine Approximation*](https://math.uchicago.edu/~fcale/papers/ICM.pdf),
2026 author-hosted SIAM version, Theorem 2.1, PDF pp.3–4, gives the following
contract. Write D(t)=lcm(1,...,floor(t)). Each column of nonnegative b_ij has
initial zeros followed by a constant value. Put sigma_i=sum_j b_ij and
`tau=m^(-2)*sum_i(2i-1)*sigma_i`. Assume phi is holomorphic near the closed
unit disk, phi(0)=0, and log abs(phi'(0))>tau. Assume Q(x)-independent
holonomic germs f_i in Q[[x]], with nth coefficient in
`Z/product_j D(b_ij*n)`, whose pullbacks by phi are meromorphic on the open
disk. Then, for normalized circle Haar measure,

```text
m <= integral_(T*T) log abs(phi(z)-phi(w)) / (log abs(phi'(0))-tau).
```

The parent visually checked the full statement. Meromorphic continuation,
the two disk conventions, independence and denominator type are all material.
Source section 3.3 assumes pi lies in a number field for its transcendence
contradiction; digit avoidance supplies no such premise.

For the actual forcing series H(x)=sum A(n)x^n, set

```text
U(x)=x/(1-16x),  V(x)=x*H(x)/(1-16x),
F(x)=V(x)-pi*U(x)=-x*sum_(n>=0) E(n)*x^n.
```

The coefficients of U and V at n>=1 are 16^(n-1) and S_(n-1). B1 cancels
F's pole at x=1/16; B2 proves the displayed tail identity. But U and V were
already meromorphic there. All three continue meromorphically on the same
canonical slit `Omega=C minus [1,infinity)`. Every rational approximation
remainder `q_N*V-p_N*U` remains in
`span_(Q(x)){U,V}=span_(Q(x)){1,H}`, of dimension two. H is nonrational by
its rational coefficients and irrational value at 1/16. Counting different
prefixes does not increase this functional rank. F itself fails the rational
coefficient premise: its x coefficient is 47/15-pi.

The direct pair also has an exact denominator obstruction. D(8n) clears the
nth coefficient of V. If a fixed finite product of D(b_j*n) clears every
coefficient, its maximum slope must be at least 8. Otherwise take arbitrarily
large primes p congruent to 5 modulo 8 and n=(p+3)/8. In S_(n-1), p occurs
only in the term -1/p with index n-1: all denominators are at most p+1<2p,
and the other residue classes cannot equal p. Thus the p-adic valuation is -1,
but no clearing factor with b_j<8 contains p for sufficiently large p.
Dirichlet supplies those primes; the existing scratch specialization is
checked, while this valuation argument remains paper mathematics.

For maps into Omega, `J(w)=4w/(1+w)^2` and Schwarz's lemma give
abs(phi'(0))<=4. The direct one-row denominator cost is at least 8; even
the two-row type for U,V has tau>=6. Hence the required log derivative
inequality fails on this domain. This excludes that basis/slit-map
instantiation, not multivalent pullbacks or other rational bases.

A different object really does detect a missing interval. Take uniform finite
empirical measures of the actual rational samples `bbpRecurrence(n+1)` in
[0,1]. Their rationality follows inductively from the rational coefficient
formula, initialization zero and subtraction of an integer in `Int.fract`.
An empirical-limit measure nu supported outside (a,b) has Cauchy transform
`C_nu(w)=integral (w-t)^(-1) dnu(t)` analytic across the gap. Its moment
series `M_nu(z)=integral (1-z*t)^(-1) dnu(t)` converges for abs(z)<1.
However neither rational moments, holonomicity, denominator type nor enough
independent germs follows from avoidance.

Even rational moments do not repair this: for independent fair 0/1 digits
in base 16 the Cantor law has

```text
m_0=1,
m_n=sum_(k<n) binomial(n,k)*m_k / (2*(16^n-1)).
```

Its moments are rational, but its Cauchy transform has a nonremovable singularity
at every point of the perfect support. To see this, a hypothetical extension
on a disk would agree on its connected complement of the Cantor set. A smaller
rectangle with real endpoints in gaps and positive mass inside then has
boundary integral 2*pi*i times that mass, contradicting holomorphy. A D-finite
germ has only finitely many possible finite singularities, so this transform
is not holonomic. The finite empirical transforms of the specified BBP samples
have rational support and rational weights, hence belong to Q(z) and have
rank one over Q(z). This claim does not apply to arbitrary empirical samples,
and closeness on the circle does not identify their real Cauchy transforms.
The required arithmetic and continuation gains have
not been obtained for one common family.

### A concrete dihedral pullback and its primitive denominator

The same source's equation (3.13), PDF p.13, gives
`A(z)=(1-4z^2)^(-1/2)` and `B(z)=-2*A(z)*arcsin(2z)`. Substitute first
z=-t/(1+t^2), then t=x/(1-x). For the analytic germs normalized at zero,
set P(x)=1-2x+2x^2 and obtain

```text
Atilde=P(x)/(1-2x),
Q(x)=arctan(x/(1-x)),  Btilde=4*Atilde*Q,
Q(x)=[Log(1-(1-i)x)-Log(1-(1+i)x)]/(2i).
```

The square-root branch equals one at zero; arcsin(-2t/(1+t^2))=-2arctan(t)
there and along 0<=t<1. The logarithm arguments remain in the right
half-plane up to x=1/2, where Q=pi/4 and Q'=2. Thus Btilde-pi*Atilde
has a removable pole at 1/2, with value -2. This fixes the signs and branches.

Let u_n=Im((1+i)^n), including u_0=0. Then
u_(n+8)=16u_n and `(u_1,...,u_8)=(1,2,2,0,-4,-8,-8,0)`. Writing a_n,b_n
for the coefficients gives

```text
a_0=1, a_1=0, a_n=2^(n-1) for n>=2,
b_n=4*u_n/n+2^(n+1)*sum_(1<=k<=n-2) u_k/(k*2^k), n>=1.
```

An empty sum is zero. For n>=2, r_n=b_n/a_n tends to pi. The exact error,
with w=(1+i)/2, is
`r_n-pi=4*Im(2*w^n/n-sum_(k>=n-1)w^k/k)`. Expanding each reciprocal
through cubic order gives a uniform remainder bounded by a constant times
`abs(w)^(n-1)/n^4`: the remaining sum is dominated by
`sum_(j>=0)abs(w)^j*2*abs(j-1)^3`. The geometric moments are
sum w^j=2w, sum(j-1)w^j=-2, sum(j-1)^2 w^j=-2i. Consequently

```text
r_n-pi=-8*Im(w^(n-1))/n^2+8*Re(w^(n-1))/n^3
          +O(abs(w)^(n-1)/n^4),
r_(8m)-pi=16^(-m)*(1/(8m^2)+1/(64m^3)+O(m^(-4))).
```

The geometric approximation rate alone omits the arithmetic cost. Write
b_n=N_n/D_n in lowest terms with D_n>0. Each u_k/k has odd denominator,
so D_n divides the odd part of lcm(1,...,n). For even n>=2,
`v_2(b_n)=n/2+1`: if n=2 mod4, the first term uniquely has that valuation;
if n=0 mod4, the k=n-2 summand uniquely has it. Every other nonzero term
has strictly higher valuation. Clearing and canceling the common power of
two therefore gives the primitive denominator

```text
Q_n=D_n*2^(n/2-2), n even and n>=4,
Q_(8m)=D_(8m)*16^m/4.
```

For every prime n/2<p<=n-2, only the k=p summand has denominator divisible
by p; its numerator is a signed power of two. Thus v_p(b_n)=-1 and the
product of those primes divides D_n. The missing k=n-1 term explains the
upper endpoint n-2. The previously inspected PNT, theta(x)~x, yields
`log D_n>=n/2+o(n)`. Hence the primitive integer linear form satisfies

```text
P_(8m)-Q_(8m)*pi
  =D_(8m)/(32m^2)*(1+1/(8m)+O(m^(-2))) -> positive infinity.
```

The dyadic coefficient a_n cannot be treated as the reduced denominator.
No claim about all odd-index valuations is needed for this aligned test.

There is also an exact identification with the earlier representation. Set
d=(2,2,1,0,-1/2,-1/2,-1/4,0) and D(j)=sum_r d_r/(8j+r). Grouping the
absolutely convergent arctangent series by residues modulo eight gives
`pi=sum_(j>=0)D(j)/16^j` and d=A-2C, with C the earlier null vector. More
precisely,

```text
r_(8m)=sum_(j<m)D(j)/16^j+16^(-m)*4/(8m-1), m>=1.
```

Thus the improved polynomial error comes from a fixed rational endpoint
correction. The increment forcing
`W(m)=D(m)+R(m+1)/16-R(m)`, R(m)=4/(8m-1), has coefficient sum zero but
an extra pole at 8m-1. It is outside the fixed eight-pole window of the
uniqueness theorem; moving its pole by a shift retains the boundary term.
This calculation supplies neither a new independent representation nor a
visitation estimate. It rules out discarding the odd denominator in this
specified pullback, without excluding other uses of the source family.

The immutable report `/tmp/pi-m4-dihedral-pullback-report-v1.md` has SHA-256
`8523b34bdb231c8540c933ad817c7897a3cd869a1e7c0fce29799b72b279da24`.
The parent inspected and reran `/tmp/pi-m4-dihedral-pullback-check-v1.py`,
exit 0: independent formal compositions through degree 48, valuations through
240, 2,795 prime cases and 30 exact block identities. Branches, infinite
series, asymptotics and PNT are paper arguments, not certified by finite checks.

## A second radix action and the finite-blocking test

Let `K=closure{16^n*pi mod Z : n>=0}` in the circle. Furstenberg,
[*Disjointness in Ergodic Theory, Minimal Sets, and a Problem in Diophantine Approximation*](https://mathweb.ucsd.edu/~asalehig/F_Disjointness.pdf),
1967, Definition IV.1 p.47 and Theorem IV.1 p.48, gives density of an
irrational point's orbit under a multiplicative integer semigroup not
contained in powers of one integer. The parent visually checked both pages.
Applying it to {16^n*3^k} would prove K is the whole circle if `3K subset K`
were known. This inclusion is missing, and under the source theorem it is
equivalent here to full orbit closure; renaming it is not progress toward V.

The tested finite identity is, for m>=1,

```text
B_m(n)=sum_(j<m)16^(m-1-j)*A(m*n+j),  b=16^m,
y_(m*(n+1))=fract(b*y_(m*n)+B_m(n)),
sum_(n>=0) B_m(n)/b^(n+1)=pi/16.
```

The new multiplier is still a power of 16. For every m>=2, B_m cannot even
return to the original four-pole rational span modulo a rational coboundary
`b*T(n)-T(n+1)`. Its 4m poles `-(8j+r)/(8m)` are distinct in (-1,0).
The pole beta=-1/(8m) has nonzero residue 16^(m-1)/(2m), and its integer
shift class contains none of the original four poles. The finite invariant

```text
rho_beta(f)=sum_(k in Z) b^(-k)*Res_(beta+k) f
```

annihilates every such coboundary by reindexing the residues `b*t_k-t_(k+1)`.
It is nonzero on B_m minus any original four-pole combination. This proves
the obstruction for arbitrary rational T, not just a finite list of examples.
For m=1 the identity closes trivially; that case is expressly excluded.

Scaling A to 3A gives a different recurrence `z_n=fract(3*y_n)` and closure
3K; it does not put 3K inside K. The actual BBP vector cancels the log(3)
and log(5) endpoint components, so those primes supply no extra radix action.
There is also no fixed lag s with `dist(3*16^n*pi,16^(n+s)*pi) ->0` on the
circle. If dist(16^n*xi,Z)->0, centered representatives eventually have size
less than 1/17; their successive difference from 16 times the preceding one
is an integer of magnitude less than 1. They therefore scale exactly by 16,
and boundedness forces eventual zero. Taking xi=(3-16^s)*pi contradicts
irrationality. Variable subsequences remain unexcluded.

The missing action would require, for every n and epsilon>0, some j with
`dist(16^j*pi,3*16^n*pi)<epsilon`. Neither blocking nor scalar multiplication
proves it. If supplied, full circle closure gives all late visits by continuity
and surjectivity of multiplication by 16; B2/B3 transfer them to V using a
strict inner interval. This reverse transfer is a paper argument, not an
assertion that the existing B4 theorem already has that direction as its type.

## Evidence, corrections and continuation

Immutable worker reports are `/tmp/pi-m4-prefix-polynomial-report-v2.md`,
`/tmp/pi-m4-holonomy-applicability-report-v1.md`, and
`/tmp/pi-m4-four-pole-multibase-report-v1.md`. The polynomial v1 remains
preserved alongside `/tmp/pi-m4-prefix-polynomial-strictness-erratum-v1.md`.
The parent read and reran all three exact rational checkers, exit 0. Their
finite counts/identities are sanity checks; source theorems and universal
arguments above are paper mathematics requiring independent review.

Source PDFs and rendered pages are retained in the matching `/tmp/pi-m4-*`
artifacts. The parent inspected the relevant theorem/definition images, using
existing PDFKit without installing software or changing trust settings.
The holonomy source hash is
`1b3fe13a89d04c3bc570b78c1130e5a03e33d4c2915ab4b065c3dc248b3eb98f`;
the Waldschmidt source hash is
`3cd49ac0f068c5a414ffefb98d5327229d8785c771dc7df23c1ec8819d5e41b3`.

The order-uniform tail analysis is retained in the
[Fourier assessment](m4-fourier-windows.md#growing-order-corrections-a-uniform-obstruction),
and the specified dihedral test is resolved above. Subsequent inquiries seek
a pi-specific coupling of prefixes and a usable exact transform beyond natural
tail truncations. A failure changes the next inquiry; it does not end M4.

## Two arctangent series retain an integer-carry obstruction

The exact identity u+v=pi, with u=4 arctan(1/2) and v=4 arctan(1/3),
allows two series scales without supplying another invariant action. The
unscaled positive angles sum to pi/4 by tangent addition on its principal
branch. Set

    P_q(m)=(4/q)*sum_(j<m)(-1)^j/[q^(2j)(2j+1)], q=2,3.

The finite geometric remainder is exactly
(4/q)(-1)^m*q^(-2m)*integral_0^1 t^(2m)/(1+t^2/q^2) dt.
Thus the native zero-initialized states q^(2m)*P_q(m) have multipliers 4
and 9 and vanishing signed errors from the corresponding pure period orbits.
Blocking two terms gives U_n=16^n*P_2(2n), B_n=81^n*P_3(2n), with

    U_(n+1)=16U_n+a_n, a_n=32/(4n+1)-8/(4n+3),
    B_(n+1)=81B_n+b_n, b_n=108/(4n+1)-12/(4n+3),
    U_0=B_0=0.

The positive errors r_n=16^n*u-U_n and s_n=81^n*v-B_n satisfy
8/[5(4n+1)]<=r_n<=2/(4n+1) and
6/[5(4n+1)]<=s_n<=4/[3(4n+1)]. In particular they tend to zero.
For lambda_n=(16/81)^n, V_n=lambda_n*B_n obeys
V_(n+1)=16V_n+lambda_(n+1)*b_n. Consequently

    16^n*pi=U_n+V_n+r_n+lambda_n*s_n.

This identifies a different forced recurrence's circle omega set with the
same pi omega set; it does not identify finite states with the BBP recurrence.
The joint base-16 omega set J of (u,v) projects under circle addition onto
the pi omega set K. Continuity gives one inclusion and subsequence compactness
the other. This scalar projection supplies no action by 9 on J or K.

The exact information loss in a native-circle shortcut is visible by writing
M_n=floor(B_n), z_n=fract(B_n):

    V_n=lambda_n*M_n+lambda_n*z_n,
    dist_circle(V_n,lambda_n*M_n)<=lambda_n ->0.

The asymptotic base-16 phase therefore depends on the native integer carry.
It is fixed, not freely chosen: d_n=floor(81z_n+b_n) gives
M_(n+1)=81M_n+d_n and z_(n+1)=81z_n+b_n-d_n, with M_0=z_0=0.
The full ordered native trajectory plus this forcing reconstructs M_n.
Its density or omega set alone does not retain that ordered information.
Nor are all d_n ordinary base-81 digits: b_0=104.

At a single fixed n and native fractional coordinate z, varying an integer
lift M gives exactly a translate of the grid {j/81^n:0<=j<81^n} after
applying fract(lambda_n*(M+z)), since 16^n is invertible modulo 81^n.
This pointwise ambiguity does not produce alternative actual initialized
trajectories. It identifies the missing residue M_n modulo 81^n and its
correlation with U_n. Choosing balanced truncations
m_n=floor(n log16/log9) instead only changes the scale to
tau_n=16^n/9^(m_n) in [1,9); the remainder still tends to zero and the
native integer part modulo 9^(m_n) remains necessary.

Dense marginals and rational independence do not suffice either. Fix an
irrational nondense gamma with digits 0/1. The points visiting every arc
arbitrarily late under multiplication by 16 form a dense G_delta, since
preimages of each target arc at arbitrarily late times are open and dense.
Intersect that set with its reflection about gamma, and remove the countably
many solutions of a*u+b*(gamma-u)+c=0 with a!=b. The a=b nontrivial cases
are impossible by irrationality of gamma. Baire's theorem gives u,v=gamma-u
with both marginal orbits dense and 1,u,v rationally independent, while
their sum is nondense. These are other periods; the actual arctangent
coefficient formulas are not retained. The countertest rejects only the
abstract additive inference.

Frozen packet `/tmp/pi-m4-two-series-coupling-20261127/` has report SHA-256
`14e025400de4719d4fbeb66604fb1d069c3fd97188bd955700c01bbe757d066e`
and manifest SHA-256
`7b77071f5011aad7f418ebd328b1928870700135826fdf52ac4872e07070c828`.
Parent reconstruction and unchanged-copy replay passed 2,078 exact coefficient,
integrand and synthetic-carry checks, exit 0, UTC-only receipt difference and
preserved originals. No actual arctangent/pi fractional prefix was computed.
The topology and infinite arguments remain paper results. A useful new step
would need a constraint on the actual native integer residues from the fixed
forcing or Gaussian identity; the period split alone supplies no visit.
