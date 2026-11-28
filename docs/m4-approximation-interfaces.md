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

## AGM units, smaller fields and the missing interval estimate

The positive initialized Gauss--Legendre iteration exposes arithmetic absent
from a generic rational approximation. The results below are reviewed paper
mathematics, not Lean declarations or V/M4 acceptance. The analytic input is
[Brent, The Borwein brothers, Pi and the AGM](https://maths-people.anu.edu.au/~brent/pd/rpb269.pdf),
arXiv:1802.07558v1: Algorithm GL on printed page 8, equations (16)--(20)
on page 9, and the expansion on page 10. The additional asymptotics use the
theta formulas (13)--(15) on page 6. These pages were inspected; the complete
analytic dependency proof has not been audited or formalized.

Start a_0=1, b_0=1/sqrt(2), s_0=1/4, and put

    a_(m+1)=(a_m+b_m)/2, b_(m+1)=sqrt(a_m*b_m),
    c_(m+1)=(a_m-b_m)/2, s_(m+1)=s_m-2^m*c_(m+1)^2,
    A_m=2^(m+1)a_m, B_m=2^(m+1)b_m,
    U_m=(A_m+B_m)^2/2, D_m=(A_m-B_m)^2/2,
    S_m=2^(m+2)s_m, alpha_m=U_m/(2^(m+1)S_m).

Thus A_0=2, B_0=sqrt(2), S_0=1, and

    A_(m+1)=A_m+B_m, B_(m+1)^2=4A_m B_m,
    S_(m+1)=2S_m-D_m, U_m D_m=D_(m-1)^2 (m>=1).

For K_(-1)=Q and K_m=Q(b_0,...,b_m), the normalized 2-adic valuations
v(A_m)=1/2 and v(B_m)=(5*2^m-3)/2^(m+1), m>=1, force ramification index
at least 2^(m+1). The quadratic tower gives the reverse degree bound. Hence
[K_m:Q]=2^(m+1), with a unique prime above 2, totally ramified. U_m,D_m,S_m
are algebraic integers and units at 2. The first two have global norm one;
Norm(S_m) is a positive odd integer, a square for m>=1, and is generally not
one. Since alpha_m>2, its rationality would imply
1=(2^(m+1)alpha_m)^[K_m:Q]*Norm(S_m)>1. Thus alpha_m is irrational.

This gives a genuine norm constraint, but its elementary separation bound
has the wrong scale for the intended consumer. For natural m,n, integer p,
Q=16^n, |p|<=4Q and 4n>=m+1, the nonzero integral residual is

    R=2^(4n-m-1)U_m-pS_m=S_m(Q alpha_m-p).

If additionally 4n>m+1 and p is odd, its norm is odd. No parity is asserted
for actual pi prefixes. Bounding all other conjugates gives

    |Q alpha_m-p| >= 1/[2^m*(2^(2m+5)Q)^(2^(m+1)-1)].

Its logarithmic cost is O(n*2^m+m*2^m). At n proportional to 2^m this is
quadratic in n, whereas the available approximation allowance has logarithmic
cost linear in n. This comparison concerns these bounds; it is not a theorem
excluding sharper norm methods, and separation alone does not supply visits.

### Two traces and two distinct Newton corrections

The last conjugation exchanges U_m,D_m and fixes S_m. Its first trace is

    gamma_m=alpha_m+D_m/(2^(m+1)S_m)
           =(a_m^2+b_m^2)/(2s_m) in K_(m-1).

For r=2^m, both alpha_m and gamma_m approximate pi with scaled error tending
uniformly to zero on 0<=n<=2r after multiplication by 16^n. One explicit
allowance for gamma_j is

    eps_j=2^(j+8)*(3/8)^(6*2^j)+64*18^(-2^(j+1)).

The second trace does not retain this absolute precision. For m>=1 put
a=2^(-m), U=U_(m-1), D=D_(m-1), S=S_(m-1), and

    gamma=gamma_m=a(2U-D)/(2S-D),
    gamma'=a(2D-U)/(2S-U), R=gamma+gamma', x=gamma_(m-1).

The corrected initial-ratio comparison is
D/U<=((1-b_0)/(1+b_0))^2<1/32; equality in the first comparison occurs at
m=1. The second trace satisfies
(15/32)a<R-pi<(79/32)a. This failure is specific to the uncorrected trace.

The compensation polynomial F(t)=t^2-(R+a)t+2aR is not the exact polynomial
of gamma. With q=D/U and v=S/U,

    F(gamma)=2a^2 q(1+q-3v)/[(2v-q)(1-2v)] >0.

Its larger root eta satisfies aq/10<pi-eta<9aq for m>=2. The rational
Newton correction X=(x^2-2aR)/(2x-R-a) lies in K_(m-2), and for m>=3
aq/20<pi-X<9aq. Its denominator is greater than one for m>=2. The elementary
bounds give uniform scaled error for n<=r, but growing absolute scaled error
at n=2r. The theta inputs sharpen this to

    pi-X ~16*r^(-1)*exp(-pi*r),
    (pi-X)/(pi-gamma_(m-1)) ~2/(pi^2*r^2).

This is a real precision gain of m/2+O(1) hexadecimal indices at a common
tolerance, despite the same leading exponential rate. X_1=72/23 is only a
boundary fixture, not an instance of the m>=3 signed bound.

Using the exact relative norm instead makes a stronger one-step repair.
Set L=U+D, M=UD, H=4S^2-2SL+M. Then

    P=gamma*gamma'=a^2(9M-2L^2)/H,
    R=2a(SL-L^2+3M)/H,
    Y=(x^2-P)/(2x-R)
     =a[2SL^2-M(L+3S)]/[2S(SL-M)] in K_(m-2).

The cancellation retains the full correction S. On the positive branch
L>4S, M<SL/2 and H<0, so no canceled factor vanishes. The identity
gamma_m-gamma_(m-1)=aD(L-3S)/[S(2S-D)]>0, convergence, and gamma_0=3 give
3<=gamma_j<pi. Also 0<gamma'<2a<=1, hence 2x-R>1. Therefore

    Y-gamma_m=(x-gamma_m)^2/(2x-R)>0 (m>=1).

Uniformly for 0<=n<=2r,

    16^n*|Y-pi| < (2^(2m+17)+2^(m+8))*(729/1024)^r
                   +(2^15+64)*(64/81)^r ->0.

Thus Y recovers the full window while halving gamma_m's field-degree upper
bound. The additional theta inputs give Y-pi~64*pi^3*r^2*exp(-2*pi*r),
positive eventually, not an asserted all-m sign. Relative to gamma_m its
error is larger by ~4*pi*r, costing m/4+O(1) indices at a common tolerance.

Here h is absolute logarithmic Weil height. The respective bounds are
h(X)<=(37m+34)log2 and h(Y)<=(13m+7)log2, with degree at most 2^(m-1).
Minimal-polynomial coefficient bounds retain an additional degree factor.
Writing Nstar=2SL^2-M(L+3S), Dstar=2S(SL-M), the integral residual
J=Q Nstar-2^m p Dstar gives, for integer p, |p|<=4Q, **only if J!=0**,

    |QY-p| >= 1/[2^(7m+3)*(Q*2^(7m+6))^(2^(m-1)-1)].

Y_1=63/20 shows why irrationality and the old denominator/unit contract
cannot be inherited. The direct norm cost remains quadratic when n~2^m.
No iteration of further corrections or optimality claim is made here.

### Selected-root signs do not yet yield a positive visit count

K_m has exactly two real embeddings. Inductively, only the real embedding
with positive last radical extends to real embeddings at the next level;
it has exactly two extensions. They exchange U_m,D_m and agree on S_m.
All nonreal pairs contribute positive squared moduli to the norm of a
nonzero rational-grid residual. This concerns field embeddings, not the
number of real roots of a ratio's norm polynomial.

Put beta_m=D_m/(2^(m+1)S_m)<1. For m>=1, n>=2^m, rational p and Q=16^n,

    sign Norm((Q/2^(m+1))U_m-pS_m)
      =sign[(Q alpha_m-p)(Q beta_m-p)].

For p>Q beta_m this is sign(p-Q alpha_m). The norm is an integer when p
is an integer. Opposite signs occur at the synthetic landmarks 3Q+1 and
4Q+1, despite their norms sharing the full residue Norm(S_m) modulo
2^(4n-m-1). This excludes selecting the sign from that congruence alone.

For I=(A/B,C/B), B=16^k, integer 0<=A<C<=B, define

    H^E_(m,n)(p)=Norm((QB/2^(m+1))U_m-(Bp+E)S_m).

The exact interval indicator is

    1_{fract(Q alpha_m) in I}
      =(1/2) sum_(p=3Q,...,4Q-1)[sign H^C_(m,n)(p)-sign H^A_(m,n)(p)].

There is at most one nonzero summand; irrationality excludes endpoints.
For every such nonempty inner interval, positivity of the sum of these
indicators over 2^m<=n<2^(m+1) for arbitrarily large m would suffice for V.
Uniform approximation, an interior margin and the vanishing BBP tail preserve
every threshold and recurrence index n+1. **That sign-count lower bound is
unproved.** Positive normalized interval mass, previously called AGM-W, is
stronger than necessary; the displayed consumer needs only a visit.

The relative-norm recurrence retains U,D,S jointly:

    Norm_(K_m/Q)(U_m-zS_m)
      =Norm_(K_(m-1)/Q)((2S-D)^2 z^2-(2S-D)(4U-2D)z+D^2).

At fixed m, the digit-polynomial update
P_(n+1,16p+e)(z)=16^[K_m:Q] P_(n,p)((e+z)/16), where
P_(n,p)(z)=Norm((16^n/2^(m+1))U_m-(p+z)S_m), holds for every synthetic
digit e. Integrality of its coefficients does not select the actual word;
the real-root inequalities still do that work.

A finite-window stress test preserves the entire U/D tower. For L>=1,
delta=2^L k D_0^j, j>=0, k>=1, change S_0 to 1+delta. Then
S'_m=S_m+2^m delta remains integral and a unit at 2; for m>=1 its norm
is a positive odd square. The norm polynomials have constant term one and
agree with the originals modulo 2^(m+L). Nevertheless, for each sufficiently
large M and each word of length r=2^M, some 0<delta<epsilon<=1/128 places
that word in positions r+1,...,2r of alpha'_M. The grids of allowed delta
become dense, and their image under alpha'_M=alpha_M/(1+delta/(4s_M)) has
uniform positive length, hence contains a cylinder for the prescribed word.

This is **a different seed for each finite window**, not a fixed nondense
model. Exact S_0=1, its initial norm-one value and identification with pi are
lost. The original conjugate bounds can also fail: delta's other K_0 value
is delta*=2^L k U_0^j, with delta times delta*=2^(2L)k^2. Thus deep local agreement
can cost large archimedean size. The test does not refute the missing estimate
for the original seed and its conjugate bounds.

The [review record](agy-reports/m4-continuation-review.md#agm-approximations-and-selected-root-signs--2026-11-27-utc)
owns exact packets, corrections, checks and source limitations. Further
approximation acceleration is suspended without a visitation consumer. The
remaining question is whether exact initialization and its original conjugate
bounds impose a joint sign restriction across scales; the tested identities
do not provide one. Fresh discovery continues under the meta-plan.

## Arctangent convergents and a partial period obstruction

This separate rational family tests whether the BBP full-period timing
obstruction persists for a different approximation to the same pi. It gives
an exact comparison to investigate, not a new visitation mechanism. The
calculation is paper mathematics; no Lean declaration or originality claim
is made.

Use the Gauss fraction in [DLMF 4.25.4](https://dlmf.nist.gov/4.25.E4):
U_-1=U_0=1, V_-1=0, V_0=1 and

    X_n=(2n+1)X_(n-1)+n^2 X_(n-2), n>=1.

Then 4V_n/U_n tends to pi. Set m=n+1, rho=1+sqrt(2), and let P_m be
the Legendre polynomial normalized by P_m(1)=1. With

    S_m=i^m P_m(-i),
    W_(m-1)(z)=sum_(k=1..m) P_(k-1)(z) P_(m-k)(z)/k,
    R_m=i^(m-1) W_(m-1)(-i),

the recurrences give U_(m-1)=m! S_m and V_(m-1)=m! R_m. The companion
formula is [DLMF 14.7.4](https://dlmf.nist.gov/14.7.E4); the denominator
normalization also appears in [Bala, theorem p.2](https://oeis.org/A003881/a003881.pdf).
Here S_0=S_1=1 and (m+1)S_(m+1)=(2m+1)S_m+mS_(m-1), so S_m>0.

### The real shadow window

For E_m=|pi-4V_(m-1)/U_(m-1)|, orthogonality gives the exact formula

    E_m=(2/S_m^2) integral_(-1)^1 P_m(t)^2/(1+t^2) dt,
    2/((2m+1)S_m^2) <= E_m <= 4/((2m+1)S_m^2).

Indeed, for F(z)=(1/2) integral_(-1)^1 1/(z-t) dt and
Q_m=P_m F-W_(m-1), orthogonality annihilates
(P_m(z)-P_m(t))/(z-t), a polynomial of degree m-1 in t. Consequently
Q_m(z)/P_m(z)=[1/(2P_m(z)^2)] integral P_m(t)^2/(z-t) dt.
At z=-i, F(-i)=i*pi/4 and the odd part of the integrand vanishes.
Taking absolute values and using integral P_m^2=2/(2m+1) proves the bounds.
This integral argument avoids a choice of complex logarithm branch.

The integer-degree Laplace formula gives
S_m=(1/pi) integral_0^pi (1+sqrt(2)cos(theta))^m dtheta.
The positive peak at zero has quadratic decay, while the negative part has
absolute base at most rho^-1. Thus S_m=Theta(rho^m/sqrt(m)) and
E_m=Theta(rho^(-2m)). For fixed margin epsilon>0 the exact endpoint for
absolute error 16^t E_m<=epsilon is floor(log_16(epsilon/E_m)); a sufficient
endpoint replaces E_m by the displayed upper bound. They differ by at most
one, and both equal 2m log_16(rho)+O_epsilon(1). A negative endpoint supplies
no nonnegative exponent. These statements do not exclude later closeness
modulo one and do not supply an interior visit for transfer.

### Reduced arithmetic, transient and period

Put L_m=lcm(1,...,m). Rodrigues' formula and the companion formula give
positive integers

    A_m=2^m S_m
       =sum_(j=0..floor(m/2)) binom(m,j) binom(2m-2j,m),
    C_m=sum_(k=1..m) (L_m/k) A_(k-1) A_(m-k),
    4V_(m-1)/U_(m-1)=8C_m/(L_m A_m).

The full reduced denominator is therefore

    q_m=L_m A_m/gcd(L_m A_m,8C_m).

The continuant determinant is
U_n V_(n-1)-V_n U_(n-1)=(-1)^(n+1)(n!)^2. Hence every **odd** prime p>m
dividing A_m survives in q_m with its full valuation: m!, 2 and L_m are
p-units, and simultaneous divisibility of the two continuants is impossible.
This gives no exponential lower bound on the retained radical.

[Ben David et al., Theorem 5, Appendix D](https://doi.org/10.1007/s40598-024-00250-z)
applies with its exact conventions p_n=U_n, q_n=V_n: the coefficient
polynomials satisfy a_n=-a_(-1-n), b_n=b_(-n), b_0=0. It proves
n!/lcm(1,...,n) divides 2^n gcd(U_n,V_n). This is a lower bound on common
content and an upper bound on primitive height. It does not supply the
opposite inequality needed for a timing obstruction. The source's proposed
exponentially tight content formulas in section 2.5 remain conjectural.

Write q_m=2^nu_m ell_m with ell_m odd. For the circle orbit
t |-> fract(16^t a_m/q_m), where a_m/q_m is reduced, the exact transient is
tau_m=ceil(nu_m/4). Its eventual period is ord_(ell_m)(16) when ell_m>1,
and 1 when ell_m=1. Thus the period is at least log_16(ell_m+1), and at
least log_16(rad(ell_m)+1). Traversing that period uses exponents through
tau_m+period-1. This is a complete-period comparison, not a lower bound on
the first visit to a target interval.

One sufficient asymptotic obstruction to fitting a full period inside the
absolute shadow window would be

    liminf_m [tau_m log16+log rad(ell_m)]/m > 2 log rho.

It has not been established. In particular, factorial growth of U_n and
upper bounds on q_m do not imply it. Let J_m be the product of odd primes
dividing ell_m but not A_m. Those primes come from L_m and are at most m.
The elementary inequalities 4tau_m<=nu_m+3,
nu_m<=v_2(A_m)+v_2(L_m), and v_2(L_m)=floor(log_2 m) give

    tau_m log16+log rad(ell_m)
      <= log A_m+log m+3log2+log J_m.

Since log A_m=m log(2rho)+O(log m) and log(2rho)<2log rho, the entire
possible radical supplied by A_m together with the permitted dyadic
transient is insufficient by itself for that lower-bound method. The method
requires additional surviving lcm support beyond m log(rho/2), with a
positive linear surplus for the strict liminf criterion. This is a necessary
input requirement, not proof that the actual period is too long. The next
argument bypasses this unresolved criterion by using where the primes lie.

### Small-prime support forces long periods on a fixed set of indices

The generating series F(t)=sum A_m t^m=(1-4t-4t^2)^(-1/2) gives a short
symbolic congruence proof. For an odd prime p put g=1-4t-4t^2 and h=(p-1)/2.
In F_p[[t]], F^2=g^-1 and F(t)^p=F(t^p), so F=g^h F(t^p). Since g^h
has degree p-1, its coefficients through that degree are A_0,...,A_(p-1).
Its leading coefficient is (-4)^h=(-1)^h. Comparing degree p+r gives

    A_(p+r)=2A_r mod p, 0<=r<p,
    A_(p-1)=(-1)^((p-1)/2) mod p.

This specializes the classical Legendre Schur congruence, stated in
[Cullinan--Hajir, Theorem 6.1, pp.11–12](https://faculty.bard.edu/cullinan/papers/legendre.pdf).
The displayed proof needs no square root of -1 in F_p and no Galois-group
or irreducibility conjecture from that paper.

For an odd prime m/2<p<=m, put r=m-p. Exactly one denominator index in
C_m is a multiple of p, and v_p(L_m)=1. Therefore

    C_m=(L_m/p) A_(p-1) A_r mod p,
    p divides J_m iff p does not divide A_(m-p).

In the nonvanishing case v_p(q_m)=1. In the vanishing case p divides A_m
and hence is excluded from J_m by definition; no claim about its higher
valuation in q_m is made. Thus no evaluation gcd is discarded.

The scaled recurrence is
(r+1)A_(r+1)=2(2r+1)A_r+4rA_(r-1). For 0<=r<=p-2 two consecutive A's
cannot both vanish modulo p: backward propagation using the units 4r
would reach A_0=0. It does not divide by the possibly vanishing 2r+1.
For every m>=4 this proves the exact inequality

    log J_m+log J_(m+1) >= theta(m)-theta((m+1)/2),

where theta(x)=sum_(p<=x) log p: each prime (m+1)/2<p<=m occurs in at
least one of the two products. Using the classical PNT only at this step,
for every 0<eta<1/4, every sufficiently large pair {m,m+1} contains k with
log J_k>=(1/4-eta)k. In particular the fixed set

    G={k>=4: log J_k>=k/8}

meets every sufficiently large adjacent pair. This is not a bound on J_k
at every individual index.

Now reuse the [previously proved order estimate](m4-crt-phase.md#short-ordinary-differences-retain-an-exponential-denominator):
for integers X>=2 and t>=1,

    log gcd(lcm(1,...,X),16^t-1)
      <=sqrt(X)*[(1+d(t))log X+d(t)log16],

where d(t) counts divisors and d(t)<=C_delta*t^delta for every delta>0.
The proof separates primes at sqrt(X), then separates the orders of16 at
sqrt(X); it assumes no randomness of orders. Let T_k be the eventual
period above, with T_k=1 if ell_k=1. Since J_k is squarefree, supported
on primes at most k, and divides ell_k, it divides gcd(L_k,16^T_k-1).
For any fixed real K>0, if T_k<=k^K, choose delta=1/(4K). The bound gives

    log J_k=O_K(k^(3/4)log k)=o(k).

It follows that **for every K>0, all sufficiently large k in the same fixed
set G satisfy T_k>k^K**. In particular T_k>k^2 eventually on G, while the
absolute shadow endpoint is O_epsilon(k). A complete cycle cannot fit in
that window, even before accounting for the dyadic transient.

This closes a paper-level subsequence full-period comparison. The PNT input
is explicit; no Lean proof or new priority claim is made. It leaves the
complementary indices and the earlier radical-size criterion unresolved.
Most importantly, a long full period does not imply a late first visit:
the prescribed numerator might enter a desired word cell much earlier.
An applicable estimate for that initial orbit segment remains missing.
The [review record](agy-reports/m4-continuation-review.md#arctangent-primitive-timing--2026-11-28-utc)
owns source limits, corrections and verification. V/M4 remain open.
