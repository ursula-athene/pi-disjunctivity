# M4 continuation: arithmetic windows and rational corrections

Research record, 2026-11-26. This tests one unconditional neighboring method
against the actual BBP sequence. It does not supply V. Results are paper-level
unless a section explicitly identifies a kernel-checked implementation; the
[full comparison](#lean-formalization-of-the-full-comparison) is formalized.
The exact [M4 contract](proof-plan.md#m4-research-sequence--2026-11-26)
and the checked B1–B3/conditional B4/P3 frontier are unchanged.

## A finite-frequency consumer

Write `e(x)=exp(2*pi*i*x)` and `u_n=bbpRecurrence(n+1)`. For an interval I
strictly inside `(0,1)`, choose a real trigonometric polynomial

```text
P(x)=c_0+sum_(0<abs(h)<=H) c_h*e(h*x),
P(x)<=1_I(x),  c_0>0.
```

Such a minorant follows by uniformly approximating a nonzero continuous
nonnegative bump bounded by `1_I`, then subtracting a sufficiently small
positive constant. If arbitrarily late windows `(M,...,M+J-1)` satisfy

```text
sum_(0<abs(h)<=H) abs(c_h)*abs((1/J)*sum_(j<J) e(h*u_(M+j))) < c_0,
```

then each such window contains a visit to I. Otherwise all its P values are
nonpositive, contradicting the positive average. An interior subinterval
handles targets touching 0 or 1. This sufficient test uses finitely many
frequencies for one interval, without requiring normality or making cancellation
at every frequency a new acceptance condition. No BBP estimate for it is proved.

## The solved-neighbor theorem and failed direct application

Bailey–Crandall, [*Random Generators and Normal Numbers*](https://www.davidhbailey.com/dhbpapers/bcnormal-em.pdf),
Experimental Mathematics 11(4), 2002, Theorem 4.6 (printed p.534), states:
for fixed coprime integers `b,c>1`, constants `A,B,D>0` exist such that, for
`J>=1`, sufficiently large r, and integer h with `gcd(h,c^r)<D*c^r`,

```text
abs(sum_(j<J) e(h*b^j/c^r))
  < B*(A*c^(r/2)+J*c^(-r/2))*log(c^r).
```

Their sparse-forcing construction has long intervals with one unchanged
modulus; Corollary 4.9(i), p.536, applies it to Stoneham constants
`sum_(i>=1) 1/(c^i*b^(c^i))`. This is unconditional, unlike Hypothesis A.
The source PDF text and its theorem hypotheses were inspected; usable visual
screenshots were not returned by the tool. No source theorem was formalized.

Let `S_m=bbpPartialSum m`, `E(m)=bbpTail m`. The checked split gives

```text
16^(m+j)*pi=16^j*S_m+16^j*E(m),
S_(m+j)=16^j*S_m+16^j*E(m)-E(m+j).
```

Thus the phase error in replacing the recurrence by the rational orbit of a
frozen prefix is bounded by
`2*pi*abs(h)*(16^j*abs(E(m))+abs(E(m+j)))`. B3 gives
`abs(E(m))<=8/(15*(8m+9))`; its available bound guarantees a uniformly close
window only at length `J=O(log m)` for fixed accuracy and frequencies.
This describes the guarantee, not an assertion that every longer actual
window has large error.

In contrast, the source estimate at `q=c^r` has normalized right side
`B*(A*sqrt(q)/J+1/sqrt(q))*log q`. Making this small needs windows large
relative to `sqrt(q)*log q`. For a unit numerator a and fixed nonzero h,
`gcd(h*a,q)<=abs(h)`, so its gcd condition eventually holds; that does not
remove the length requirement. BBP prefixes also lack its fixed modulus tower.
The denominator argument below makes that mismatch explicit, even after any
fixed rational correction.

The short-window issue is substantive. At `q=3^r`, seed 1 and
`J=floor(log_16(q)/2)`, every `16^j/q<=q^(-1/2)` for `0<=j<J`. Therefore

```text
abs((1/J)*sum_(j<J) e(16^j/q)-1) <= 2*pi/sqrt(q) -> 0.
```

These unit seeds satisfy the favorable coprimality conditions but do not
cancel on logarithmic windows. This is not a model of the actual BBP seed;
it refutes a seed-independent strengthening of the proposed short-window step.

## Any fixed rational correction: prime denominators survive

Fix `R=P/Q in Q(X)` with integer polynomials P,Q and Q nonzero, defined at
all sufficiently large natural inputs. Its degree and coefficients are fixed,
not chosen anew with m. Let `q'_m` denote the odd part of the reduced denominator
of the rational number `S_m+R(m)`.

First, a purely algebraic argument plus Dirichlet shows unbounded prime support.
Choose `k>=0` with `Q(k-5/8)!=0`, possible among `0,...,deg Q`. For sufficiently
large primes `p=5 mod8`, put `m=(p-5)/8+k`. Exclude primes dividing the fixed
nonzero integer `8^(deg Q)*Q(k-5/8)`. Then `p` does not divide Q(m).
If additionally `p>8k+1`, all coefficient denominators through m are less
than `2p`; exactly one equals p, namely `8*(m-k)+5`. Hence

```text
S_m=-16^k/p+(a p-integral rational),
v_p(S_m+R(m))=-1,       q'_m>=p=8m-8k+5.
```

The choice of k matters: `R_K(X)=sum_(ell=0)^K 16^ell/(8X+5-8ell)` cancels
precisely those offending terms at fixed offsets `0,...,K`. Choosing an offset
outside the finitely many denominator roots repairs the argument. The claim
with k=0 for every R would be false.

The pinned source theorem `Nat.forall_exists_prime_gt_and_modEq` in
`Mathlib/NumberTheory/LSeries/PrimesInAP.lean` specializes at modulus 8 and
residue 5 to

```text
forall N : Nat, exists p>N, p.Prime and p == 5 [MOD 8].
```

That small interface was compiled; the general valuation argument was not.
This alone proves a subsequence result, which would not exclude selecting
different favorable anchors. The next source-dependent step closes that gap.

### All-anchor strengthening using PNT in a fixed progression

Let M_m be the squarefree product of primes `p=1 mod4` in `(4m+3,8m+1]`.
Each is congruent to 1 or 5 modulo 8 and appears exactly once among A's
coefficient denominators through m, as `8j+1` or `8j+5`. The endpoints ensure
`j<=m` and `2p>8m+6`; the corresponding numerator 4 or -1 is not divisible
by p. Therefore `v_p(S_m)=-1`. Every such prime not dividing Q(m) survives:

```text
M_m/gcd(M_m,abs Q(m)) divides q'_m,
q'_m >= M_m/abs Q(m).
```

The prime number theorem in progressions gives `Theta(x;4,1)~x/2`, with
`Theta(x;q,a)=sum_(p<=x, p prime, p=a modq) log p`. See Sutherland,
[*Sieve theory and small gaps between primes: Introduction*](https://math.mit.edu/~drew/PrimeGapsOberwolfach1.pdf#page=3),
Oberwolfach, 6 July 2015, PDF index 2. Only the fixed coprime pair `(4,1)` is
used; no estimate uniform in a growing modulus is assumed. Consequently

```text
log M_m=Theta(8m+1;4,1)-Theta(4m+3;4,1)=2m+o(m),
log(abs Q(m))=O(log m),
liminf_(m->infinity) log(q'_m)/m >= 2.
```

In particular, for every `eps>0`, `q'_m>=exp((2-eps)*m)` at every sufficiently
large m. This strengthening is a paper consequence of the inspected PNT source,
not a kernel result from the Dirichlet probe.

## A fixed rational correction cannot leave an all-orders flat error

For every such R there are `d in Z` and `c in Q`, `c!=0`, with

```text
E(m)-R(m) ~ (c/15)*m^d.
```

To see this, put `D(m)=E(m)-R(m)` and
`G(X)=A(X+1)-16*R(X)+R(X+1)`. The exact tail shift gives
`16*D(m)-D(m+1)=G(m)`. The rational function G is nonzero: otherwise
`A(X+1)=16R(X)-R(X+1)` would contradict the
[weighted-pole obstruction](m4-rational-forcing.md#pole-structure-a-sharper-separating-example).
The four shifted poles lie in distinct integer-shift orbits and have nonzero
weighted residues. Thus G has a nonzero rational leading ratio c and integer
degree difference d, with `G(m)~c*m^d`.

Both R and D have at most polynomial growth on the eventual naturals.
Iterating the difference equation and letting L tend to infinity gives

```text
D(m)=sum_(r=0)^(L-1) G(m+r)/16^(r+1)+D(m+L)/16^L,
D(m)=sum_(r>=0) G(m+r)/16^(r+1).
```

Polynomial growth kills the boundary term and guarantees absolute convergence;
an exponential homogeneous solution cannot survive. To divide by `m^d` and
pass to the limit, use `abs(G(s))<=C*s^d` for large s. If `d>=0`, the normalized
terms are bounded by `C*(1+r)^d/16^(r+1)`; if `d<0`, by `C/16^(r+1)`.
Both are summable. Each fixed-r term tends to `c/16^(r+1)`, whose sum is c/15.
No analyticity or convergent asymptotic expansion of E at infinity was assumed.

For example, `R=0` gives `E(m)~1/(64*m^2)`. For `R(m)=1/(64*m^2)`, exact
Laurent coefficients give `G(m)~-345/(512*m^3)` and therefore
`E(m)-R(m)~-23/(512*m^3)`. This verifies a nonzero leading error, not merely
an upper bound compatible with unexpectedly better approximation.

## What this does and does not rule out

For a fixed rational correction tending to zero, the residual has some fixed
inverse-power order, so its absolute-error guarantee allows only
`J=O(log m)` uniformly close frozen-prefix windows. Meanwhile its corrected
odd denominator grows at least exponentially, by the PNT-dependent argument.
Even granting an analogue of the neighboring bound with uniform constants for
these moduli, its required window scale is incompatible with that guarantee.
The original theorem's fixed-tower requirement also remains unsatisfied.

This rules out that fixed-correction repair of that sufficient comparison.
It does not rule out actual cancellation, later returns to small phase error,
comparisons that exploit cancellation in the errors, approximants of growing
order, or V. Arbitrary rational R also satisfies the residual theorem, but a
large integer-valued polynomial part can disappear in circle phases; a large
raw error must not be mistaken for an actual circle-phase obstruction. The
application above concerns corrections tending to the vanishing tail.

The reassessment is to stop computing more fixed-order corrections for this
comparison. A different estimate would have to exploit the changing BBP moduli,
or establish compatible denominator and residual bounds for a genuinely
different approximation. Those inputs remain open; no such premise is added
to the target.

## Receipts

The worker reports are `/tmp/pi-m4-fourier-window-applicability-final-20261126.md`
and `/tmp/pi-m4-fixed-rational-correction-report-final.md`.
The parent inspected and reran the exact-rational checker
`/tmp/pi-m4-fixed-correction-check-final.py`, SHA-256
`3d8977fff7ce4cc423a5e0928c145bb6ebfb727c65b221078178ec694721e9f4`: exit 0.
It checks finite prime/residue examples, deliberate cancellations, first
asymptotic coefficients and product divisibility. These are sanity checks;
universal claims rely on the paper arguments above.

The scratch `/tmp/pi-m4-dirichlet-probe-v1.lean`, SHA-256
`23b5703ec2a0d2170aaa1fad942a96ac164df418fbd20d616da259edaa824f46`,
instantiates the displayed prime theorem and prints only `propext`,
`Classical.choice`, `Quot.sound`; worker and parent compilations exited 0.
No valuation, PNT, residual-asymptotic or
visitation theorem was added to the project. No dependency or audit changed.

## Growing-order corrections: a uniform obstruction

The preceding fixed-rational result leaves open a different question: can
the truncation order grow with the anchor, making the tail error exponentially
small without increasing its odd denominator? The following paper argument
handles every finite order of the natural inverse-power expansion. It does
not cover Padé approximants or modular coincidences. Independent review of
this extension is complete in the
[continuation review record](agy-reports/m4-continuation-review.md).

Write

```text
w(s)=2*1_[1,4](s)+1_[1,5](s)+1_[1,6](s),
A(m)=integral_1^6 w(s)/(8m+s)^2 ds,
E(n)=(1/64)*sum_(r>=0)16^(-r-1)
                 *integral_1^6 w(s)/(n+r+1+s/8)^2 ds.
```

The reciprocal derivative proves the first identity; the weight has integral
15. Equivalently E(n)=integral (n+u)^(-2) dmu(u), for a positive measure mu
of mass 1/64 supported on [9/8,infinity). All moments mu_j are finite because
geometric decay dominates each polynomial in r. Define

```text
a_j=(-1)^j*(j+1)*mu_j,
R_K(n)=sum_(j<K) a_j/n^(j+2),  D_K(n)=E(n)-R_K(n).
```

For every x>=0 and finite K>=0, a finite algebraic identity gives

```text
(1+x)^(-2)-sum_(j<K)(-1)^j*(j+1)*x^j
  =(-1)^K*x^K*((K+1)+K*x)/(1+x)^2.
```

It is valid outside the Taylor convergence disk. Integration yields

```text
(-1)^K*D_K(n)
  =integral (u/n)^K*((K+1)+K*u/n)/(n+u)^2 dmu(u)
  =d_K(n)>0.
```

For fixed K this positive integrand strictly decreases with n. Dominated
convergence also gives the fixed-order asymptotic
`D_K(n) ~ (-1)^K*(K+1)*mu_K*n^(-K-2)`, confirming these are the natural
coefficients. The following uniform bound does not use that fixed-K limit.
For n>=1 select just the r=n-1 summand, where u=n+s/8>=n. Its remainder
factor `(u/n)^K*((K+1)+K*u/n)` is at least one for every K. Thus

```text
abs(D_K(n)) >=16^(-n)*A(2n)
            >=15*16^(-n)/(16n+6)^2
            >=(15/484)*16^(-n)/n^2.                 (U)
```

This holds for every n>=1 and every finite K>=0, including an arbitrary
choice K=K(n). No convergence of the infinite asymptotic series is asserted.

### Coefficient denominators at arbitrary order

Let c_1=4,c_4=-2,c_5=c_6=-1 and v_(r,a)=r+1+a/8. Integrating the moment
polynomial gives

```text
integral w(s)*(r+1+s/8)^j ds
  =-8/(j+1)*sum_a c_a*v_(r,a)^(j+1),
a_j=(-1)^(j+1)/8 *sum_a c_a*sum_(r>=0)16^(-r-1)*v_(r,a)^(j+1).
```

The division by j+1 cancels; it cannot introduce a new denominator prime.
The geometric moments M_l=sum r^l/16^(r+1) satisfy M_0=1/15 and
`15*M_l=sum_(t<l)binomial(l,t)*M_t` for l>=1. Hence
15^(l+1)*M_l is integral, and the binomial expansion above proves
`120^(j+2)*a_j` integral. Consequently

```text
R_K(n) belongs to Z[1/(30n)]
```

for every finite K and positive integer n. The first three coefficients
are 1/64, -23/512 and 415/4096. Every prime p in the earlier product M_n
exceeds n and 5, so R_K(n) is p-integral while S_n has valuation -1.
Its valuation therefore remains -1 in S_n+R_K(n). Unlike the general
fixed-rational bound, no Q(n) factor is lost:

```text
M_n divides the odd reduced denominator q'_(n,K),
q'_(n,K)>=M_n=exp(2n+o(n)), uniformly in K.
```

Only the previously inspected fixed-progression PNT is used in the last
asymptotic; the prime-divisibility statement is elementary exact arithmetic.

### Three distinct real comparison errors

Fix one anchor n and order K, and freeze P=S_n+R_K(n). The exact BBP split
gives three different comparisons with the rational orbit 16^j*P:

| Compared sequence | Exact real difference |
| --- | --- |
| 16^(n+j)*pi | 16^j*D_K(n) |
| S_(n+j) | 16^j*D_K(n)-E(n+j) |
| S_(n+j)+R_K(n+j) | 16^j*D_K(n)-D_K(n+j) |

The final row keeps K fixed within that window. It is not the raw-prefix
identity, and no smallness of a growing-order R_K(n+j) is assumed.
If the first difference has absolute value at most eta>0, (U) forces

```text
j <= n+2*log_16(n)+log_16(484*eta/15).
```

A window j=0,...,J-1 has length at most one more than this bound. The
raw-prefix row has the same n+O(log n) restriction because
`0<E(n+j)<=1/(64n^2)` and the triangle inequality bounds
16^j*d_K(n) by eta+1/(64n^2). For the corrected-prefix row, constant sign
and monotonicity give absolute difference at least `(16^j-1)*d_K(n)`,
again allowing only n+O(log n). All constants can be independent of K(n).

Even granting the unavailable uniform version of the fixed-tower exponential
sum estimate, its sufficient window scale sqrt(q')*log q' is exponential
in n. Arbitrarily high natural truncation order therefore cannot repair
this absolute-real-shadowing comparison at any subsequence of anchors.
Large real error may still be close to an integer. Actual modular phase
cancellation, circular coincidences and other rational approximants remain
unexcluded, and V remains open.

The immutable report is `/tmp/pi-m4-growing-order-report-v1.md`, SHA-256
`535d0dbf2f78fe57ae91bea5528084f7280f089cdf732eae837044edefc07cd3`.
The parent inspected and reran `/tmp/pi-m4-growing-order-check-v1.py`,
SHA-256 `4e30e84a0b84a103752fe2e2c19bee915daedf5ca42e05c5b4a9fd073f9f999c`:
exit 0. It checks 30 coefficient orders, exact finite remainder identities,
sampled monotonicity and 245 anchor/order denominator pairs. Those finite
checks are sanity evidence; the infinite sums and universal inequalities
above remain paper mathematics. No production Lean declaration changed.

## Rational tail quadrature and exact radix clearing

A separately reviewed paper test uses the same actual positive tail measure,
with moments `mu_l`, to replace the inverse-power polynomial by a Gaussian
rational rule. This gives a uniform analytic bound but fails exact radix
clearing at every fixed order. It does not rule out growing order, small
nonzero modular residues or a corrected-prefix argument.

The source is Allen, Chui, Madych, Narcowich and Smith,
[*Pade approximation and gaussian quadrature*](https://doi.org/10.1017/S0004972700043641),
Theorem 1, printed pp.65–66. Its denominator-degree-first `[m,m-1]` approximant
to the ordinary Stieltjes transform is the m-node Gaussian rule. The actual
measure is positive, has infinite support in `[9/8,infinity)` and finite
rational moments, so these hypotheses hold. The source permits formal moment
series; no convergence of the inverse-power series is assumed. The present
tail approximant comes from differentiating the finite ordinary rule, rather
than applying the source theorem directly to the squared-denominator tail.

Let `q_m` be the monic degree-m orthogonal polynomial, with distinct positive
nodes `xi_i` and positive Gaussian weights `w_i`. The rational moment system
is nonsingular because the integral of a nonzero polynomial's square is
positive. Thus `q_m`, and the following `P_m,Q_m`, have rational coefficients;
the individual nodes and weights need not be rational. For `m>=1`, put

```text
Q_m(X)=(-1)^m*q_m(-X)=product_i(X+xi_i),
G_m(N)=sum_i w_i/(N+xi_i)=P_m(N)/Q_m(N),
R_m(N)=-G_m'(N)=sum_i w_i/(N+xi_i)^2.
```

Here `deg(P_m)=m-1`, `deg(Q_m)=m` and `Q_m(0)>0`. Nonzero residues imply
`P_m(-xi_i)!=0`, so the numerator `P_m*Q_m'-P_m'*Q_m` is nonzero at every
root of `Q_m`. The reduced rational-function denominator of `R_m` therefore
has degree exactly `2m` and nonzero constant term. This assertion does not
preclude integer gcd cancellation after evaluation.

Set `I_k(N)=integral q_m(u)^2/(N+u)^k dmu(u)` and
`kappa_m=integral q_m(u)^2 dmu(u)>0`. Polynomial division and orthogonality
give the ordinary transform error `I_1(N)/Q_m(N)^2`. Differentiation, justified
locally for `N>0` by the finite moments and positive support, yields

```text
E(N)-R_m(N)=I_2(N)/Q_m(N)^2
              +2*Q_m'(N)*I_1(N)/Q_m(N)^3 >0.
```

Orthogonality and monicity also give
`mu_(2m)=kappa_m+integral(u^m-q_m(u))^2 dmu`, hence
`kappa_m<=mu_(2m)<(2m)!`. Since `Q_m(N)>=N^m`,
`Q_m'(N)/Q_m(N)<=m/N` and `I_k(N)<=kappa_m/N^k`, every finite `m>=1,N>0`
satisfies the uniform bound

```text
0<E(N)-R_m(N)<(2m+1)!/N^(2m+2).
```

This incorporates review improvement I1. For fixed m, dominated convergence
also gives `E(N)-R_m(N) ~ (2m+1)*kappa_m/N^(2m+2)`. The uniform inequality
does not depend on substituting a growing m into that fixed-order asymptotic.
The actual first three moments are `1/64,23/1024,415/12288`, so
`R_1(N)=4/(16N+23)^2`, with `kappa_1=73/49152`. For every natural N its
denominator is odd, greater than one and coprime to 4; no power of 16 clears it.

The all-fixed-order obstruction is elementary. For integer polynomials p,q
coprime over the rationals, with `deg(q)=d>=1` and `q(0)!=0`, a cleared Bezout
identity gives `U*p+V*q=D!=0` with integer coefficients. Write `e=v_2(q(0))`.
For `s>e`, `v_2(q(2^s))=e`, and the evaluated gcd divides D. Consequently

```text
oddDen(p(2^s)/q(2^s)) >= abs(q(2^s))/(2^e*abs(D))
                     >= c*2^(d*s) eventually, for some c>0.
```

Apply this to a reduced integer polynomial representation of `R_m`: for every
fixed m, its odd denominator is at least `c_m*2^(2*m*s)>1` for all sufficiently
large s. Factoring a general reduced denominator as `X^k*q_0(X)` gives the
same conclusion when `deg(q_0)>0`. Thus infinitely many exact dyadic clearings
force a fixed rational correction to be a Laurent polynomial over Q. This
necessary condition does not force dyadic coefficients: `(X+1)/(3X^2)` has
dyadic values at `X=2^s` for every odd s.

For growing m, write `R_m=A_m/B_m` as coprime integer polynomials, with a
Bezout constant D_m and `e_m=v_2(B_m(0))`. If `s>e_m`, exact clearing requires
`oddPart(B_m(2^s))` to divide D_m and `abs(B_m(2^s))<=2^e_m*abs(D_m)`.
No uniform arithmetic bound for these order-dependent quantities is proved.
The result bounds neither the odd denominator of `S_N+R_m(N)` nor distance
to a nonzero modular residue. It supplies no actual target hit or V theorem.

Frozen report `/tmp/pi-m4-tail-rational-clearing-20261128-0736/report-v1.md`,
SHA256 `e44140f50e4160ca2bbcad1d9dbf0693f7cb1dfa9540584ed2dfeb3eee2a673a`,
and its formal-coefficient checker were independently reviewed. The parent
rerun passed; it verifies the first moments and one-node polynomial identity,
not the universal analytic or Bezout arguments. Both source pages were visually
inspected. The bounded public Lean search found related resultant machinery,
not an exact Gaussian-tail implementation; no absence or originality claim
follows. This is paper mathematics, without new Lean exports. The continuation
review record owns I1's disposition and production-integration review.

## Dyadic anchors give later modular shadow blocks

The preceding absolute-error obstruction leaves room for cancellation modulo
integers. The actual BBP tail has such cancellation at explicit dyadic anchors.
The paper argument was independently reviewed; its full Lean formalization
and finite consumer are described below. It is not a visitation assertion.
Use the inclusive prefix S_N and tail E_N above, and the
[exact coefficient denominators](m4-transforms-and-periods.md#an-exact-transform-explains-the-dyadic-tail-coefficients).
For integers s>=32 define

```text
N=2^s, H_s=floor(s/(16*log_2(s+2))), V_s=floor(s/16).
```

For every 1<=h<=H_s and 0<=v<=V_s, set j=h(s+3)+v. There is an integer z
and a real epsilon satisfying

```text
16^j*E_N=z-epsilon,  0<epsilon<2^(-s/4).                 (DS)
```

At v=0 the bound improves to2^(-s/2). Thus the fractional part is1-epsilon,
not epsilon; the estimate concerns circular distance to an integer. The h-range
is nonempty for s>=128, and can be empty at smaller s. Its blocks are disjoint,
each has floor(s/16)+1 shifts, and their maximum shift is asymptotic to
s^2/(16*log_2(s)). This extends the ordinary O(s) uncorrected comparison at
selected times, not throughout a continuous window or beyond the earlier
O(N) absolute horizon for corrected rational prefixes.

### Uniform remainder bound and integer cancellation

The positive measure already displayed above has an exponential moment bounded by

```text
integral exp(u) dmu(u)
 <=(15/1024)*exp(7/4)/(1-exp(1)/16)
 <(15/1024)*9/(1-3/16)=135/832<1.
```

Here u<=r+7/4 in its r-th summand, integral w=15, exp(1)<3 and exp(7/4)<9.
Positivity justifies the geometric estimate and proves integrability. Since
u^K<=K!*exp(u), every moment satisfies mu_K<K!. Also
`((K+1)+K*x)/(1+x)^2<=K+1` for x>=0: the numerator of the difference is
`(K+2)*x+(K+1)*x^2`. The finite remainder identity therefore gives, for
every finite K>=0 and N>0,

```text
0<d_K(N)<(K+1)!/N^(K+2).
```

No convergence of the infinite asymptotic series is used. Write
a_l=B_l/8^(l+2), B_l an integer. For K>=1,

```text
(8N)^(K+1)*R_K(N)=sum_(l<K)B_l*(8N)^(K-l-1) is integral.
```

Take K=4h-1, which is odd. Then16^[h(s+3)]=(8N)^(K+1), so

```text
16^[h(s+3)]*E_N=integer-delta,
0<delta<8^(4h)*(4h)!/2^s <=(32h)^(4h)/2^s.
```

The permitted h and s>=32 imply h<=s and
`4h*log_2(32h)<=8h*log_2(s+2)<=s/2`. Hence delta<2^(-s/2).
Multiplying by16^v preserves integrality and gives
`epsilon=16^v*delta<2^(4v-s/2)<=2^(-s/4)`, proving (DS).
For nonvacuity, log_2(130)<8 and s/16-log_2(s+2) is increasing for s>=128.

### Exact target-placement obligation

The actual split, including the original initialization, yields

```text
16^(N+j)*pi-16^j*S_N=z-epsilon,
S_(N+j)-16^j*S_N=z-epsilon-E_(N+j).
```

The measure's mass1/64 gives0<E_(N+j)<=1/(64*N^2). Thus with
`e_s=2^(-s/4)+1/(64*2^(2s))`, any selected j satisfying

```text
fract(16^j*S_N) in (a+e_s,b),  0<=a<b<=1,
```

gives bbpRecurrence(N+j+1) in(a,b), with no wrap. Taking s arbitrarily large
would also ensure N+j>=M for any prescribed orbit threshold M. The checked
weaker B3 estimate can replace the stronger paper mass bound and still tends
to zero. **The selected-time target hits themselves remain unproved.**
The estimate supplies no normality, disjunctivity or V conclusion, and these
restricted hits are not asserted to follow from V either.

The original exact grid anchors N=(17^k-1)/8 coincide with2^s only at k=s=1:
odd k>1 leaves an odd factor in(17^k-1)/16; even k would force two powers of
two differing by2 around17^(k/2)>=17. This does not exclude extending that
grid argument to nearby anchors. Independently, complete-period coverage has
no bound placing a hit in these blocks: the archived denominator estimate
and q_N dividing16^T-1 give T=Omega(N), whereas their maximum shift is o(N).
That is a period comparison, not a lower bound on actual first-hit times.

### Compatible fine grids at nearby dyadic anchors

The original anchor formulas differ, but the grid argument extends to a nearby
dyadic anchor. This separate paper extension is independently reviewed. Fix
d>0 and choose arbitrarily large r>1 with
`r=1 mod bbpCoverLcm(d+1)`. Set k=r+d and Q=17^k. Let8N be the least power
of two greater than Q, so

```text
N=2^s, Q<8N<2Q, s=ceil(k*log_2(17))-3.
```

The existing admissible-exponent theorem gives unbounded r; hence s is
unbounded and can exceed128 and any prescribed threshold. The new denominator
argument uses only Q<=8N<2Q. Since Q=1 mod8 and8N is a multiple of8,

```text
8N<=2Q-2, 8N+6<=2Q+4<3Q.
```

Of the positive multiples of Q in this range, Q occurs exactly once among
the four actual pole families, at8n0+1 with n0=(Q-1)/8. The other possible
multiple2Q has residue2 modulo8, so none of the families1,4,5,6 contains it.
After multiplying S_N by Q, every other pole term is divisible by17 in the
17-localization. The exceptional term contributes4*16^(N-n0), nonzero modulo17.
Therefore

```text
v_17(S_N)=-k, v_17(q_N)=k,
q_N=17^(r+d)*M, gcd(M,34)=1.
```

The last assertion also uses the checked all-N odd-denominator theorem.
For every prime p dividing q_N, the checked cutoff gives
`p<=8N+5<=2Q+3<17^(r+(d+1))+5`. The existing
`bbpCover_prime_factorization_le`, at depth d+1 and the chosen congruence,
gives v_17(p-1)<=r-1. These are precisely the hypotheses of
`PrimeGrid17.rationalGrid17` at grid depth d. Its generic interface requires
no terminal-anchor equality. Every unit numerator modulo q_N therefore has
the full17^(-d) translated grid in its hexadecimal orbit. The actual reduced
numerator is a unit, so `RationalHexOrbit.rational_period_grid_contract` also
gives positive period and strict half-open interval discrepancy<17^(-d).

Thus for every fixed d there are arbitrarily large actual dyadic anchors
with both the fine complete-period grid and (DS). **Anchor compatibility is
established; target-time intersection remains open.** The constructed
principal-unit traversal has step at least2*17^(r-1), eventually larger than
the selected block range for fixed d. This limits that traversal argument;
it does not rule out earlier actual target hits.

The failed direct-clearing question explains the change of anchor. For
N=2^s*m with m odd, put `P_K(N)=sum_(l<K)B_l*(8N)^(K-l-1)`, which is odd.
Once4j>=(s+3)(K+1),
`16^j*R_K(N)=2^[4j-(s+3)(K+1)]*P_K(N)/m^(K+1)`.
It is integral exactly when m^(K+1) divides P_K(N), implying m divides
B_(K-1). Before that threshold, its dyadic denominator cannot clear either.
Moving forward while preserving the high17 pole permits m=1 and avoids this
extra divisibility obligation. This is an exact-clearing condition, not an
obstruction to other small circular residues.

Frozen extension `/tmp/pi-m4-dyadic-grid-compatibility-20261128-0622/report-v1.md`,
hash `57134a94c5a024ba5d6608fd534980f43e0077d19e8d0da643931c466d334ef6`,
passed separate review with no D/I/Q items. Parent checker e79413 passed
130,816 abstract cutoff pairs and288 rational identities using synthetic
coefficients, with no actual prefix/denominator computation. The existing
generic Lean theorems are checked; the new arithmetic bridge is formalized
below. The full comparison formalization is described after the analytic core.

### Lean formalization of the nearby dyadic grid

[DyadicGrid.lean](../PiDisjunctivity/BBP/DyadicGrid.lean) implements the reviewed
arithmetic component in eleven public theorems. The valuation theorem retains
both bounds17^k<=8N<2*17^k and proves the actual prefix's17-adic valuation is-k.
Its denominator multiplicity and decomposition are derived, not assumed.
The grid and strict discrepancy theorems retain r>1, d>0 and the enlarged
cover congruence at d+1; they use the actual reduced numerator throughout.

`exists_dyadic_nearby_anchor` discharges the power-of-two bracket.
`bbpNearby_exists_dyadic_anchor` supplies s>B for every prescribed B,
together with an admissible r and both inequalities. The ensuing grid,
discrepancy and word theorems use that same actual prefix at2^s. In particular,
`bbpNearby_arbitrarily_large_dyadic_words` states that for each fixed length w
and bound B, some s>B has every length-w word with a start below its positive
complete rational period. Words may cross the period boundary. This asserts
neither all lengths for one fixed rational prefix nor a word in pi.

The unchanged candidate imports only the existing denominator-grid module and
Mathlib. No new definition, parameter-selected numerator, visitation premise
or axiom is introduced. Root export, eleven complete-type audits, eleven
exact axiom guards and six explicit boundary consumers are in
[Test.lean](../Test.lean). They exercise zero and full-grid translations,
the first and last grid cells, the empty word and a symbolic all15 word.
All axiom lists are exactly propext, Classical.choice and Quot.sound.

The parent root-only probe, full build, Test audit and native diagnostics
passed. The worker packet is
`/tmp/pi-m4-nearby-anchor-lean-20261128-0632/`; its candidate hash is
`8917e301b35c7d90e4a96367ce9a2f6c368365f3a059c2a7475ed51d31fc32cc`.
Independent production review is complete. This formalization verifies
the arithmetic/complete-period half of the compatible-anchor result. The
full modular-shadow estimate is implemented in the comparison component below.
The selected target-time intersection remains unproved; V/M4 is open.

Early prior-work searches found a related radix-cancellation mechanism in
Borwein--Borwein--Dilcher, [*Pi, Euler Numbers, and Asymptotic Expansions*](https://www.cecm.sfu.ca/~pborwein/PAPERS/P45.pdf).
Borwein--Choi--Pigulla's [*Continued Fractions of Tails of Hypergeometric Series*](https://carmamaths.org/resources/jon/cftail.pdf),
Theorem1 and pp1--2, restates the Gregory-tail Euler expansion and explains
digit agreement at decimal-power truncations. These are contextual analogues,
not imported proof inputs. Bounded public Lean searches found no exact candidate;
no absence, originality or external proof audit is claimed.

Frozen report `/tmp/pi-m4-modular-shadow-20261128-0609/report-v1.md`, SHA-256
`99e7056e00299d572eb4f91fdd62c30bb16e2b8c0acc7c683a47093222f54a89`,
was independently reviewed with no D/I/Q items. The parent reran check-v1.py,
hash `270009360e8b52664fc0d40a3d234f56a9636fa52aaafb81940499741793f44a`:
exit0,32 remainder identities,32 moment/coefficient checks and797 parameter
bounds. These are finite symbolic diagnostics, not actual-state or digit
observations and not a proof of the universal result. Full review evidence is
in the [continuation record](agy-reports/m4-continuation-review.md).

### Lean formalization of the actual tail expansion

[TailAsymptotics.lean](../PiDisjunctivity/BBP/TailAsymptotics.lean) proves the
analytic core in `PiDisjunctivity.BBPAsymptotics`. Its concrete `stieltjesTerm`
is the weighted sum of the three fixed interval integrals above; `moment`,
`coefficient` and `correction` are their actual moments, signed coefficients
and first K inverse-power terms. They are exposed definitions, not parameters
standing for assumed estimates.

The nineteen public theorems include strict coefficient/tail positivity,
`bbpTail N <= 1/(8*N+9)^2` including N=0, the actual tail's convergent integral
sum, and a finite integer recurrence for the numerator moments. The recurrence
comes from convolution with D(X)=4-4X+2X^3-X^4 and telescoping geometric sums;
D(1)=1 gives integer moments by strong induction. Polynomial integration
identifies the actual coefficient and proves, for every k,

```text
coefficient k = B/8^(k+2) for some integer B,
0 < moment k < k!.
```

The moment bound uses the summable majorant
`k!*(135/1024)*(3/16)^r`, with sum `k!*135/832 < k!`.
The finite kernel identity, positivity and checked interval integrability give
the exact actual-tail conclusion for every natural K and every N>0:

```text
0 < (-1)^K*(bbpTail N - correction K N) < (K+1)!/N^(K+2).
```

K=0 is included. No condition u/N<1, infinite asymptotic-series convergence,
fixed-order limit or visitation premise is used. Coefficient integrality,
moment convergence and remainder estimates are proved from the actual BBP
coefficients. Exact numerator oddness is not part of this formalization.

The root export and [Test.lean](../Test.lean) check nineteen complete theorem
types, nineteen guarded axiom lists, thirteen explicit theorem consumers and
three exposed definition bodies. All axiom sets are exactly propext,
Classical.choice and Quot.sound. The N=0 tail, k=0/1 moments and coefficients,
N=1 with K=0/1, and finite inverse-square identity at x=2 are exercised.
Twenty-six internal proof helpers remain private. The worker packet
`/tmp/pi-m4-shadow-core-20261128T0703Z/` is immutable; production changes
rename its namespace, restrict helper visibility, move audits out of the
library and satisfy enabled linters without changing the mathematics.

Root-interface and full production checks passed; independent code review
is complete with no D/I/Q items. The following component consumes this core
to check integer clearing and the logarithmic estimates proving (DS).
Selected-time target hits and V remain open.

### Lean formalization of the full comparison

[DyadicTailShadow.lean](../PiDisjunctivity/BBP/DyadicTailShadow.lean) proves
finite integer clearing, signed cancellation at every dyadic anchor, the
stronger v=0 bound2^(-s/2), and the full original (DS) bound2^(-s/4).
Its h limit is the natural floor of the real logarithmic expression; v<=s/16
uses natural division. Negative error exponents are real powers. Three
numerical helpers remain private. The general nonvacuity theorem proves
that h=1 is admissible for every s>=128, and its first-block consumer applies
the full shadow result at j=s+3+v. Six public theorems have exact root audits.

[DyadicComparison.lean](../PiDisjunctivity/BBP/DyadicComparison.lean) imports
this result and the checked grid component. Its theorem
`arbitrarily_large_dyadic_grid_shadows` chooses one nearby anchor above
max(B,127). That single s>B, s>=128 carries a positive actual rational period,
every depth-d grid translate at a time below that period, strict complete-period
discrepancy, and the original bound at every admissible h,v. It does not combine
different existential anchors or identify a grid time with a shadow time.

The exposed numerical definition `dyadicShadowError s` is exactly
`2^(-s/4)+1/(64*(2^s)^2)`. The second theorem,
`dyadic_frozen_prefix_hit_transfer`, retains s>=32, every h/v bound,
j=h(s+3)+v,0<=a<b<=1, and the explicit hypothesis

```text
fract(16^j*(bbpPartialSumRat (2^s):real)) in (a+dyadicShadowError s,b).
```

It concludes membership of the original bbpRecurrence(2^s+j+1) in(a,b).
The proof derives the signed prefix identity from the actual pi/prefix/tail
split, bounds the later positive tail, and removes the integer only after
the interior margin rules out wrap. It proves no instance of that hit premise.

Both modules pass the full build, root probes and Test audits. Separate
production review is complete and found no blocking defect. The eight public
theorems have complete types and guarded allowed-three axiom lists in
[Test.lean](../Test.lean).
Nine explicit theorem consumers cover empty correction, smallest pre-log s,
nonempty s=128/h=1 blocks including v=8, a common grid/discrepancy/shadow
witness, and conditional target transfer including endpoint target(0,1).
One additional check unfolds the numerical error. No actual state is evaluated.

The immutable v3, v3a and v4 packets are in the0733 integration evidence.
The full compatibility and finite transfer statements are now implemented;
the missing selected-time visits are still missing mathematics. Neither
complete periods nor modular error bounds imply V/M4 on their own.

### Prior work and originality of the compatibility statement

The exact common-anchor statement was developed in this session. A targeted
literature and public-Lean search found no earlier exact statement or stronger
result shown to imply it. **Originality remains unestablished.** Neither the
kernel checks nor agent review settles priority, and the ingredients have
substantial precedents.

Chen and Zhang, [*Error estimates of BBP- and Ramanujan-type series*](https://fs.unm.edu/ScientiaMagna17no1.pdf),
Scientia Magna 17(1) (2022), pp.22–35, Theorem 2.1 on p.24 already gives the
actual inclusive BBP tail expansion with the same coefficients, including
`1/64,-23/512,415/4096`, and an all-order recurrence. Theorem 2.2 on p.25
gives finite strict lower/upper bounds. The expansion is therefore prior work.
The inspected BBP section does not supply the present uniform growing-order
factorial bound, modular block theorem, 17-adic grid or their common anchor.
A fixed-order asymptotic does not by itself justify growing-order estimates.

The public repository `eldernos/MathematicsResearch`, inspected at commit
`062e66cfa698de194f8276a67e43133c560ced4f` dated 2026-11-26, contains related
[corrected-shadow bounds](https://github.com/eldernos/MathematicsResearch/blob/062e66cfa698de194f8276a67e43133c560ced4f/NormalityChecker/BBPShadow.lean)
and [large-prime denominator survival](https://github.com/eldernos/MathematicsResearch/blob/062e66cfa698de194f8276a67e43133c560ced4f/NormalityChecker/BBPDenominator.lean).
The former adds rational finite-difference corrections to the actual prefix;
the latter does not establish high fixed-17-power period coverage. Both files
last changed at `8bf9f042706fa1d928dc88114460b2ee35098002`, dated 2026-11-24.
Their complete signatures and proofs were inspected, without rebuilding or
replaying axiom audits. No identity is inferred from the repository handle.
No equivalent conjunction was located in the inspected public Lean sources.

Borwein–Borwein–Dilcher's [Gregory-tail expansion](https://www.cecm.sfu.ca/~pborwein/PAPERS/P45.pdf)
(1989), Theorem 1, is a precedent for integer asymptotic coefficients and
separated radix-aligned digit agreement. Stoneham's
[Wallis-product approximants](https://matwbn.icm.edu.pl/ksiazki/aa/aa42/aa4233.pdf)
(1983), Theorem 5 on p.276 and discussion on p.277, provide a rational-period
distribution precedent and explicitly retain the stable-window placement
problem. Neither inspected result states the present BBP conjunction.

The search inspected these primary pages and the closest public theorem
contracts, not all indexed code, unpublished work or every equivalent proof.
Its detailed comparison is `/tmp/pi-compatibility-originality-20261128-0805/report.md`,
hash `7f161bc00bd2c922811aadecd1cf2dbbf786dfa8e58db6ac46f4cf71b236e243`.
The defensible description is: developed here; exact combination not found
in this targeted search; originality and first-formalization priority unknown.

### Both resources alone do not supply selected target hits

The existing [13-pole comparison forcing F](m4-rational-forcing.md) retains
the original shadow blocks (DS) and arbitrarily fine complete-period grids
at the same nearby dyadic anchors, while every selected frozen-prefix phase
misses (3/4,7/8). This independently reviewed paper result refutes an inference
from those two resources alone. Its constant is C=32/21; pi's irrationality
excludes this model. It does not refute the actual-A statement, a rational-or-dense
dichotomy, or the resources together with additional actual-BBP arithmetic.

Keep the original F, seed zero and inclusive prefix
`W_N=sum_(n<=N)16^(N-n)*F(n)`. Its tail is
`E_F(N)=16^N*C-W_N`. No recurrence or prefix values are sampled below.

Write F(n)=sum c_r/(8n+r), with the coefficients in the linked owner, and
let w(t)=sum_(r<=t)c_r on [1,15], zero elsewhere. The fourteen unit-interval
values of 16w are

```text
24,32,36,44,14,16,15,15,21,13,9,1,1,-1.
```

Thus individual layers are signed. Define the finite signed measure by
`integral f dmu_F=(1/64)sum_(r>=0)16^(-r-1) integral_1^15 w(t)f(r+1+t/8)dt`.
Collect overlapping layers at u=R+1+t/8, 1<=t<9. The initial layer is positive;
for R>=1 the density is `(1/8)*16^(-R-1)*(w(t)+16w(t+8))`.
The eight values of 16 times the bracket are

```text
360,240,180,60,30,0,15,15.
```

Consequently the assembled measure is positive, nonzero, supported in
[9/8,infinity), and has mass1/64. The total variation integral of w is121/8,
so its exponential moment is at most
`(121/8192)*exp(23/8)/(1-exp(1)/16)<3267/6656<1`.
Absolute convergence justifies the representation
`E_F(N)=integral (N+u)^(-2)dmu_F` and its moments. The finite signed remainder
therefore has exactly the same strict bound
`0<d_K(N)<(K+1)!/N^(K+2)` for every finite K and N>0.

All-order integer clearing also holds. In the archived
[Borel formula](m4-transforms-and-periods.md), set H_F=8B_F,
`D(x)=(2-x^2)(x^2-2x+2)` and
`L0=(2-x^2)'/(2-x^2)-(x^2-2x+2)'/(x^2-2x+2)`. Then

```text
32H_F=4x^9(1-x^4)-x^9(1-x^8)L0 in Z[x,D(x)^(-1)], D(1)=1.
```

Every Taylor coefficient of 32H_F(1+y) is integral. The ordinary derivatives
of H_F at1 through order7 are
`0,-1,-27,-546,-9966,-176250,-3150810,-58837590`, all integers.
For every order i>=8,32 divides i!, proving integrality at all higher orders.
The integer Stirling change of basis proves every Euler derivative integral.
Hence the actual coefficients of this model satisfy
`a_l=(-1)^(l+1)*[(x*d/dx)^(l+1)H_F](1)/8^(l+2)` with integer numerator.
No oddness is asserted. Taking K=4h-1 repeats the finite remainder argument
above and gives precisely (DS), with its original h,v ranges and error bound.

Odd prefix denominators follow from the universal rational identity

```text
F(n)=(96n^2+260n+157)/[(8n+1)(8n+7)(8n+15)]
     -3(4n+5)/[(8n+5)(8n+9)] +1/[(4n+1)(4n+5)]
     +2/[(8n+3)(8n+11)]
     +(5n^2+12n+6)/[(2n+1)(2n+3)(4n+3)(4n+7)].
```

Every denominator prime is at most8N+15. At the same anchors
Q=17^(r+d)<8N<2Q, N=2^s, the Q-pole pair contributes
`(15/2)*16^(N-n0)` to QW_N, where n0=(Q-1)/8. The possible2Q pair is at
n2=(Q-1)/4 and n2-1. Both N and n2 are even and N<=n2, so either neither
term or both terms are included. In the latter case their contribution is
`(-15/4)*16^(N-n2)`. All other terms vanish modulo17. The exponents are even,
so QW_N is15/2 or15/4 modulo17, both nonzero. Thus its odd reduced denominator
has exact17-valuation r+d. The cutoff
`8N+15<2Q+15<=17Q+5` fits the existing depth-(d+1) Euler cover.
The generic grid theorem applies to this model's actual reduced numerator
and coprime complement, giving all fixed depths at arbitrarily large anchors.

Nevertheless, (DS) gives the exact sign

```text
fract(16^j*W_N)=fract(16^(N+j)*C+epsilon).
```

The rational part has one of the three phases2/21,8/21,11/21. For s>=64,
adding epsilon<2^(-s/4) leaves it below3/4 without wrap. Every selected time
therefore misses (3/4,7/8), despite fine complete-period grids. The original
recurrence consumer still has index N+j+1. F differs from A in its pole
coefficients, complex residues, exact coefficient parity and rational constant.
The next actual-phase argument must use an additional distinguishing input;
this comparison does not identify a sufficient one. V/M4 remains open.

Frozen report `/tmp/pi-m4-combined-resource-test-20261128-0645/report-v1.md`,
hash `c5be0b1372c287d7189d1df6de96487213863a7c2020fff024ec5c79dc6592f0`,
and its symbolic checker were independently reviewed with no D/I/Q items.
The parent rerun passed: density tables, universal rational identity, finite
all-order integrality certificate and noncancelling pole coefficients.
These checks are not actual-state observations or universal analytic proofs.
No Lean theorem or originality claim is made for this comparison. The existing
source map suffices for this extension of the same recorded model.

### Translated tail comparisons before the blocks

The actual odd coefficient numerators give a further paper result, separately
reviewed. It supplies a fine grid of tail corrections, while retaining the
dependence on the actual prefix's integer branch. It is not a target-hit or
Lean result. Use the actual B_l from the exact coefficient formula above.
For s>=32, N=2^s, 1<=h<=H_s, put K=4h-1, J=h(s+3), and

```text
I_(h,s)=(8N)^(4h)*R_(4h-1)(N)
       =sum_(q=0)^(4h-2) B_(4h-2-q)*2^(q(s+3)).
16^J*E_N=I_(h,s)-delta, 0<delta<2^(-s/2).
```

For fixed t>=1 with J>=t, let Q=16^t, j=J-t and r be the least residue
of I_(h,s) modulo Q. Every lower term with q(s+3)<4t must be retained:

```text
r=[sum_(q=0)^min(4h-2,floor((4t-1)/(s+3)))
     B_(4h-2-q)*2^(q(s+3))] mod Q.
```

Oddness makes r nonzero and `fract(16^j*E_N)=r/Q-delta/Q`, without wrap.
If s+3>=4t, this simplifies to r=B_(4h-2) mod Q. For every fixed t and
satisfying also H_s>=t+16^(t-1), its exact image over all admissible h is

```text
{415 mod16^t} union {r:0<=r<16^t and r=7 mod16}.         (PB)
```

The main set has mesh16^(-(t-1)); the h=1 extra point is disjoint. These
conditions hold at every sufficiently large dyadic anchor, including along
the compatible-anchor family. This is a grid of the tail corrections at
different times, not a freely chosen translation of one prefix phase.

Here is the all-order argument behind (PB). Write
`H(1+y)=sum u_i*y^i`, where H=x^9(1-x)/D and D(1)=1; all u_i are integers.
Let c(t) be the least positive integer with16^t dividing c(t)!, and set
`w_j=sum_(j<=i<c(t))(-1)^(i-j)*choose(i,j)*u_i`. The Euler/Stirling identity
gives `B_(4h-2)=-sum_(j<c(t))w_j*j^(4h-1) mod16^t`. This reduction is
universal in h: derivatives above the factorial threshold vanish modulo16^t.
For h>=t+1 the even j terms vanish. For odd j, expand
`j^(4h-1)=j^(-1)*(1+16*((j^4-1)/16))^h` modulo16^t to obtain

```text
B_(4h-2)=P_t(h) mod16^t,
P_t(h)=sum_(a=0)^(t-1)16^a*C_(a,t)*choose(h,a).
```

The finite Taylor certificates give B_2=415, every h>=2 giving7 modulo16,
and `P_2(h)=39+80h mod256` for h>=3. Comparing at two consecutive large h
proves C_(0,t)=39 modulo256 and C_(1,t)=5 modulo16 for every t>=2.
Thus P_t(h)=7+16*f_t(h), with odd linear coefficient in f_t and higher terms
`16^(a-1)*C_(a,t)*choose(h,a)`. Vandermonde and
`j*choose(2^k,j)=2^k*choose(2^k-1,j-1)` bound each higher-term difference
at h+2^k by valuation at least `4(a-1)+k-v_2(j)>=k+3`.
Consequently `f_t(h+2^k)-f_t(h)=2^k mod2^(k+1)`. Binary lifting proves
periodicity and bijectivity modulo every relevant power of2. The consecutive
values h=t+1,...,t+16^(t-1) supply the main set in (PB); all earlier h>=2
add no new mod16 class. The case t=1 is the constant7 calculation.

The exact consumer uses `Z_h=fract(16^j*S_N+r/Q)` and
`eta=2^(-s/2)/Q+1/(64*N^2)`. A hit Z_h in(a+eta,b), with0<=a<b<=1,
gives bbpRecurrence(N+j+1) in(a,b). But writing
`16^J*S_N=U_h+phi_h`, with U_h its floor and0<=phi_h<1, gives

```text
Z_h=(beta_h+phi_h)/Q,
beta_h=(U_h+r_h) mod Q.
```

The proved permutation controls r_h, not beta_h. Changing h also changes
U_h and phi_h along the same actual rational orbit. No estimate controlling
that dependence was obtained. Arbitrarily late interior hits of these corrected
phases for every target remain the explicit missing premise; the grid cannot
replace it. Review Q1 is retained unresolved and blocks V/M4, not this result.

Frozen report `/tmp/pi-m4-preblock-parity-20261128-0712/report-v1.md`, hash
`cb47ad179f9373c41c275819a59fdc6be17cfd43515d2da909f9cbcf2994d26d`,
was independently reviewed with no defects or improvement recommendations.
The symbolic Taylor/Stirling checker passed in caller06f777; inventoryd28567
matched. It checks finite certificates, not actual states or the universal
lifting proof. An initial coefficient-representative checker assertion was
corrected without changing that proof. This refines the existing asymptotic
source map; no new source theorem, originality claim or formalization is added.

A supplemental prior-work check found related p-adic dynamics in Anashin's
[*Ergodic Transformations of the Space of p-adic Integers*](https://arxiv.org/abs/math/0602083)
(2006; abstract inspected), and the pinned Mathlib
[Mahler-basis development](https://leanprover-community.github.io/mathlib4_docs/Mathlib/NumberTheory/Padics/MahlerBasis.html).
Local source inspection confirms `mahler`, `mahler_apply` and
`mahler_natCast_eq`, extending binomial coefficients continuously to p-adic
integers. These are contextual connections, not an imported proof of (PB)
or a result controlling the real floor branch. No exhaustive novelty or Lean
absence claim follows from this small search.

### Moving the first block to five times a dyadic anchor

A separately reviewed paper extension moves one accurate block to
`N=5*2^s`, where `s>=32` and `s=5 mod100`. It has no Lean implementation
and does not supply the full original all-h family or a target hit.

The actual first three coefficients and signed finite remainder give

```text
R_3(N)=P(N)/(4096*N^4), P(X)=64X^2-184X+415,
0<R_3(N)-E_N<24/N^5.
P(5*(32+125Y))=625*(2575+20296Y+40000Y^2).
```

Since `2^100=1 mod125`, the exponent progression implies `2^s=32 mod125`.
At `J=s+3`, it follows that `16^J*R_3(N)=P(N)/625` is an integer. Thus
`16^J*E_N=z-delta`, with `0<delta<98304/(3125*2^s)`. For every natural
`v<=floor(s/16)` and `j=s+3+v`, multiplication by `16^v` gives

```text
16^j*E_N=z_v-epsilon, 0<epsilon<32*2^(-3s/4)<=2^(-s/4).
```

The strict inequality uses `98304/3125<32`; the last bound uses `s>=32`.
This is compatible with the rational-clearing obstruction above: `R_3(5X)`
is a Laurent polynomial, whose odd coefficient denominators can cancel upon
evaluation along a subsequence.

The nearby-anchor grid declarations accept arbitrary N. To select a common
anchor here, fix `d>0`, put `L=bbpCoverLcm(d+1)>0` and `s=5+100t`, and set

```text
x_t=(log40+(5+100t)*log2-(d+1)*log17)/(L*log17).
```

The increment `100*log2/(L*log17)` is irrational, since a rational ratio would
equate a positive power of 2 with a positive power of 17. Classical irrational
rotation density supplies arbitrarily late natural t with
`fract(x_t)` in `(0,log2/(L*log17))`. The natural-time assertion follows from
positive near-returns converting dense integer multiples to dense nonnegative
multiples; every tail is a translate of that dense orbit. For large t take
`q=floor(x_t)>0` and `r=1+L*q`. Then
`L*log17*fract(x_t)=log(8N)-(r+d)*log17`, so
`17^(r+d)<8N<2*17^(r+d)`. The existing nearby-grid argument gives arbitrarily
fine complete-period grids at arbitrarily large anchors in this same family.
This density bridge is paper mathematics; the inspected local AddCircle
declaration concerns integer multiples, not an already implemented late
natural-time consumer.

The exact prefix identity remains
`S_(N+j)=16^j*S_N+z_v-epsilon-E_(N+j)`. Consequently the explicit premise
`fract(16^j*S_N)` in `(a+2^(-s/4)+1/(64*N^2),b)`, with `0<=a<b<=1`,
transfers to `bbpRecurrence(N+j+1)` in `(a,b)`. That premise is unproved.
More anchor flexibility supplies neither an improved time scale nor the
required intersection with target-hit times.

Frozen report `/tmp/pi-m4-five-dyadic-anchors-20261128T0803Z/report-v1.md`,
hash `1f2db990324b5cb245bc6824d451d73da2df416ba9b938fc1b95bf70c9c08667`,
was independently reviewed with no D/I/Q findings. Symbolic checker `bb37b9`
passed; it verifies polynomial and constant congruence certificates, not
actual states or the universal analytic/density proof. No novelty claim or
new Lean framework is made. The existing tail/grid source map supplies the
inputs; a bounded Hensel search was motivational, and the explicit certificate
does not require Hensel's lemma.

<a id="normal-prime-power-columns-do-not-supply-a-sum-estimate"></a>

## Normal prime-power columns require a joint estimate

A different use of the same Bailey–Crandall source decomposes the infinite
BBP series rather than freezing one rational prefix. Put
`(r,c_r)=(1,4),(4,-2),(5,-1),(6,-1)`. Every denominator `8n+r` uniquely has
the form `m*17^k`, with `17` not dividing m and `m=r mod 8`. Absolute
convergence permits the exact partition

```text
C_(r,m)=(c_r/m)*sum_(k>=0)17^(-k)*16^(-(m*17^k-r)/8),
pi=sum_r sum_(m>=1, 17 not dividing m, m=r mod8) C_(r,m).
```

Each column is 16-normal by a direct application of Definition 4.1 and
Theorem 4.8 (printed pp.533,535), followed by rational-affine invariance
in Theorem 2.2(7), p.530. For the k>=1 sum choose integer bases b=16,c=17,
denominator exponents n_k=k and numerator exponents m_k=(m*17^k-r)/8;
set m_0=n_0=0 separately as required by the source. Both sequences strictly
increase. For k>=2 the gap is mu_k=2m*17^(k-1), while nu_k=1. With
gamma=3/4 the source's normalized gap grows by 17^(1/4)>1. The k=0 term
is rational and c_r/m is nonzero rational. This avoids an invalid appeal to
integer-base Stoneham normality after an irrational rescaling.

The text and rendered source pages, including the displayed proof of
Theorem 4.8, were inspected. The earlier dependency chain was not fully
audited. This is a paper source application, not a Lean theorem, and it
does not assert normality of any sum of distinct columns.

### An exact cancellation test

Let t_n=1/[(8n+1)(8n+5)] and use the positive forcing

```text
F(n)=16*t_n-t_(n+1)
    =4/(8n+1)-4/(8n+5)-1/[4(8n+9)]+1/[4(8n+13)].
```

Its leading asymptotic is the same 15/(64n^2), but its zero-initialized raw
sum is U_n=(16/5)16^n-t_(n+1). Thus fract(U_n)=1/5-t_(n+1) lies in
(0,1/5) and permanently avoids (1/4,3/4). Its weighted period is 16/5.
It loses the exact A, actual pole classes, A(0), and irrational period;
it is not a counterexample to V or to a rational-or-dense conjecture.

Every individual nonzero 17-power column of these four poles is still
normal. For r=9,13 delete the inadmissible k=0 term when necessary; all
k>=1 exponents remain positive. At paired poles r,r+8 with coefficients
16d,-d, the common terms cancel exactly: the second exponent is one less
than the first. Only the unpaired terms 4 and -4/5 survive. Consequently
individual normality, rational coefficients, absolute convergence, positive
four-pole forcing, zero initialization and the matched leading decay do not
justify a sum transfer. The actual classes lack this particular pairing,
but that alone supplies no theorem controlling their correlations.

### The growing cutoff has a separate quantifier problem

For integer M>=6, let T_M retain in full the actual columns with m<=M.
Set L=floor((M-6)/8)+1. An omitted monomial has 8n+r>M and therefore n>=L.
The sum of absolute pole coefficients at n is at most 8/(8n+1), giving

```text
|pi-T_M| <= [128/(15*(8L+1))]*16^(-L).
```

For a fixed tolerance delta>0 this guarantees 16^n*|pi-T_M|<=delta when

```text
n <= L+log_16(15*delta*(8L+1)/128)
   = M/8+log_16 M+O_delta(1).
```

This is a sufficient window from an upper bound. It is not necessary or
optimal, does not lower-bound the signed omitted sum, and does not exclude
later absolute or modular coincidences. The [fixed-M argument below](#every-fixed-finite-column-sum-is-normal)
now proves normality of T_M at paper level. It does not place a visit before
this cutoff uniformly as M grows. For V, every target and threshold would
need such an early visit with an interior margin absorbing both approximation
error and the actual E_n, retaining the recurrence n+1 versus orbit n offset.
Individual columns, finite sums, and growing-cutoff visits are distinct claims.

The [review record](agy-reports/m4-continuation-review.md#prime-power-column-source-test--2026-11-27-utc)
retains the immutable report, source, exact synthetic checks, parent replay
and independent review. The insertion-valuation test below supplies a
fixed-M consumer. Further work toward V still needs a joint unscaled estimate
at n of order M; the fixed-M limit cannot silently transfer to pi.
V/M4 and the actual odd-carry question remain open.

### The unit test succeeds but the available orbit pieces stay short

Let S_M be the included 17-free cofactors m<=M above, and set

```text
D_M=lcm_(m in S_M) den(c_(m mod8)/m),
B_M(j)=sum_(r in {1,4,5,6}, sf17(8j+r)<=M) c_r/(8j+r),
S_(M,n)=sum_(j<=n)16^(n-j)*B_M(j),  X_(M,n)=D_M*S_(M,n).
```

Here sf17 removes all factors 17. D_M is prime to 17 and each
w_m=D_M*c_r/m is an integral 17-adic unit. For M>=6,n>=2, put
K=floor(log_17(8n+6)). Then the reduced denominator of X_(M,n) is
**exactly 17^K**. After multiplication by 17^K, lower levels vanish modulo
17. The possible top cofactors are 1,4,5,6,9,12,13,14; the time and cutoff
conditions select a nonempty initial segment. Since (17^K-1)/8 is even,
their cumulative residues, after removing the unit D_M*(-1)^n, are
4,12,5,2,11,14,1,12. None vanishes. This proves the proposed unit test
with the actual coefficient vector and zero raw initialization retained.

Nevertheless, through n<=floor((17M-6)/8), D_M*B_M(n) is nonintegral
exactly at n=2,8,10,12 modulo17. At such an index exactly one pole is
17-divisible and its cofactor is included; its unit numerator cannot cancel
against the other integral terms. The gaps are 6,2,2,7. Thus maximal
homogeneous orbit pieces have at most seven terms throughout the sufficient
transfer window, for large M. The unscaled forcing even agrees with actual
A through n<=floor((M-6)/8).

For full interval discrepancy, any J-point sequence has discrepancy at
least 1/J, by shrinking an interval around an atom. Consequently the
triangle estimate D_total<=sum_i(J_i/N)D_(J_i), with all J_i<=7, has its
**right-hand side at least 1/7**. This is no lower bound on actual total
discrepancy. It shows that this partition estimate cannot certify arbitrarily
small discrepancy; it discards the needed correlations between pieces.
The source's square-root-modulus estimate likewise gives no vanishing bound
on bounded-length pieces. Earlier dependencies remain unaudited; the parent
and reviewer inspected Definition 2.1(3), p.529, and the displayed bound p.534.

Clearing denominators also costs interval information. The exact odd-prime
support of D_M is p!=17 with either p=1 mod4,p<=M or p=3 mod4,2p<=M;
its 2-part is exactly two. Higher powers contribute o(M) to its logarithm.
The previously assessed fixed-progression PNT therefore gives

```text
log D_M=3M/4+o(M),
D_M/16^W_M(delta) -> infinity,
W_M(delta)=M/8+log_16 M+O_delta(1).
```

For one fixed 16-normal beta in (0,1), alpha_M=beta/D_M has the same
normal scaled orbit for every M, while all unscaled phases up to W_M tend
uniformly to zero. Each alpha_M is normal, but the numbers vary with M and
lose the actual period and forcing history. This refutes only a uniform
inverse transfer based on the scaled information. It does not give a fixed
avoiding number or a counterexample to V. No order-of-16 lower bound follows
merely from D_M's size.

The k=0 rational prefix can be removed after scaling by shifting past its
largest exponent, between floor((M-6)/8) and floor((M-1)/8). That sufficient
procedure uses order M/8 shifts and leaves only O(log M) in the guaranteed
window; it is not a necessary bound excluding earlier cancellation.
The [review record](agy-reports/m4-continuation-review.md#column-unit-survival-and-profile-rigidity--2026-11-27-utc)
retains the full paper proof and checks. Unit survival is now established at
paper level; the unscaled interval branch and a joint early-visit estimate
remain open. The following argument uses this unit survival to settle the
fixed-M paper claim, while leaving the growing-M gap and Lean frontier intact.

### Every fixed finite column sum is normal

For **every fixed integer M>=6**, T_M is 16-normal. This is a paper proof
using the cited classical results, reviewed by a separate Codex subagent;
no Lean declaration, external human peer review, originality determination
or full source-dependency audit is claimed. It treats the actual signed sum
jointly, without assuming that sums of normal numbers are normal.

Set s_M=|S_M|, z_n=fract(X_(M,n)), and a_K=(17^K-1)/8. The exact conductor
level I_K={a_K,...,a_(K+1)-1} has 2*17^K indices. A nonintegral scaled
insertion occurs precisely at e(m,k)=(m*17^k-r(m))/8 with k>=1; only one
pole can be 17-divisible at any index, so its unit contribution cannot cancel.
Every level starts with the m=1 kick. Also

```text
K(e(m,k))=k+floor(log_17 m),  k>=1.
```

Indeed 8e+6=m*17^k+(6-r(m)), with 0<=6-r(m)<=5<17^k. Each retained
cofactor therefore contributes at most one kick per level. The level, or its
final partial prefix, consists of at most s_M homogeneous pieces. Late k=0
insertions are scaled integers and do not interrupt z. The universal unit
theorem gives a unit numerator A for each piece's orbit modulo q=17^K.

The Bailey--Crandall pure-orbit estimate on p.534 gives, for every J>=1,

```text
D_J({16^j*A/q}) <= C*(sqrt(q)/J+1/sqrt(q))*log^2(q).
```

Constants depend only on bases 16,17. Explicitly, Lemmas 4.3 and 4.5 give
c_1(q)=17 and ord_q(16)=2q/17. For K>=2, the Erdős--Turán cutoff
H=floor(sqrt(q)/2) ensures gcd(hA,q)<=h<q/17. Splitting arbitrary lengths
into full periods and a remainder bounds each exponential sum by
`(sqrt(q)+(17/2)*J/sqrt(q))*(1+log q)`. The source's Theorem 2.2(9) then
allows C=52*C_ET, with C_ET an unevaluated absolute constant. There is no
minimum piece length and no M-dependence in this estimate.

Multiplying by J cancels the 1/J term. Summing at most s_M pieces of total
length at most 2q costs at most C*(s_M+2)*sqrt(q)*log^2(q) per level.
Discarding n<36 and summing the geometric levels gives, for every N>=1,

```text
D_N(z) <= 36/N+C_*(s_M+2)*log^2(8N)/sqrt(N),
C_*=sqrt(8)*52*C_ET/(1-17^(-1/2)).
```

This tends to zero for each fixed M. To recover the actual static period,
absolute convergence gives the real identity

```text
16^n*D_M*T_M=X_(M,n)+R_(M,n),
R_(M,n)=D_M*sum_(j>n)16^(n-j)*B_M(j),
|R_(M,n)|<=8*D_M/[15*(8n+9)] -> 0  (M fixed).
```

Theorem 2.2(10) transfers equidistribution to the scaled static orbit;
Theorem 2.2(5) gives normality of D_M*T_M. Apply Theorem 2.2(7) to that
one fixed number with rational multiplier 1/D_M to obtain normality of T_M.
This does not divide fractional states or choose an inverse branch.
The unscaled driven prefixes fract(S_(M,n)) are also equidistributed by
their vanishing difference R_(M,n)/D_M from the static orbit.

Parameter dependence remains visible. Put W_M^abs=sum_(m in S_M)|c_r|/m,
which is at most 4*(1+log M). Summing absolute tails in the other order gives
`sum_n|R_(M,n)|<=L_M^tail=17*D_M*W_M^abs/240`. For
w_n=fract(16^n*D_M*T_M) and 0<epsilon<1/4, circular interval enlargement,
shrinkage and the number of exceptional errors give

```text
D_N(w)<=D_N(z)+2epsilon+L_M^tail/(N*epsilon).
```

Wrapping arcs are complements of ordinary intervals; endpoint coincidences
are handled by a limiting margin. For N>8L_M^tail the additional error can
be 2*sqrt(2L_M^tail/N). This is a scaled estimate; rational-affine preservation
above supplies only qualitative unscaled normality for each fixed M.

All m=136j+1<=M are included, so ceil(M/136)<=s_M<=M. When N is comparable
to M, the displayed driven bound's right side grows like sqrt(M)*log^2 M.
This is a statement about the bound, not a lower bound on true discrepancy.
The available shadowing window remains M/8+log_16 M+O(1); its short-piece
and inverse-branch obstructions are unchanged. Fixed-M normality cannot
interchange the quantifiers to put a visit inside that growing-M window.

The [review record](agy-reports/m4-continuation-review.md#fixed-finite-column-normality--2026-11-27-utc)
retains the complete proof, source identities and unchanged 103,494-check
structural replay. Source pages 529,530,533,534 were inspected visually;
Korobov/Niederreiter, Erdős--Turán and rational-affine preservation were not
audited through their full proofs. Neither PNT nor the asymptotic for D_M
is needed for this normality proof. Uniform early unscaled visits, V/M4 and
infinitely many odd actual carries remain open.

### Prior work and existing Lean machinery for the fixed-column result

The argument above was developed in this session using established normality
methods. A subsequent targeted search found no exact earlier T_M statement or
Lean specialization; this does not establish originality. The closed gap was
in this project's argument, not a certified open problem in the literature.
Bailey--Crandall supply the classical orbit estimates and transfer results.

Christopher Anderson's [Arithmetic Certificates for Normality and Mathematical Limitations](https://github.com/eldernos/MathematicsResearch/blob/062e66cfa698de194f8276a67e43133c560ced4f/papers/04-arithmetic-certificates-v2/paper.pdf),
v2.0, Theorem 1.1, pp.1--2, gives another qualitative proof once our specific
denominator theorem is supplied. Set x=D_M*T_M, P_n=X_(M,n), b=16, c=17,
L=B=2 and d=3. At scale A=4^k, blocks have length T=2^k and starts
n=u*A+l*T, u=1,2,3 and 0<=l<2^k. After all finitely many k=0 insertions,
each column has at most one insertion in [A,4A), because consecutive insertion
times satisfy e_(j+1)=17*e_j+2r. Discarding the affected blocks costs at most
s_M blocks. On the others the raw rational prefix follows the exact power
orbit, with zero model error. Its reduced denominator satisfies
`(8n+6)/17<Q<=8n+6<32*A<=T^3` for k>=5. Thus denominators grow beyond
every fixed floor while the exceptional proportion tends to zero. The real
tail and integer dilation finish the application, for fixed M only.

The inspected revision contains Lean proof bodies for
[`normal_of_arithmetic_certificate`](https://github.com/eldernos/MathematicsResearch/blob/062e66cfa698de194f8276a67e43133c560ced4f/NormalityChecker/ArithmeticCertificate.lean#L94),
[`fixed_support_orbit_estimate`](https://github.com/eldernos/MathematicsResearch/blob/062e66cfa698de194f8276a67e43133c560ced4f/NormalityChecker/SmoothOrbit.lean#L207)
and [`normal_mul_nat_iff`](https://github.com/eldernos/MathematicsResearch/blob/062e66cfa698de194f8276a67e43133c560ced4f/NormalityChecker/FourierTest.lean#L119).
Its `NormalIn` definition counts every overlapping word through all prefix
lengths. These are generic results, not a located Lean proof about T_M.
External sources and audit guards were read; no external build, transitive
axiom audit, CI verification, import or adaptation was performed. The source's
reported replay is at e4809cf, distinct from the inspected 062e66cf revision.

Anderson's [signed same-prime criterion](https://github.com/eldernos/MathematicsResearch/blob/062e66cfa698de194f8276a67e43133c560ced4f/papers/03-signed-resonance-v1.2/paper.pdf),
Theorem 3, p.3, is close prior work, but the immediate rewrite of our exponents
requires base sqrt(2) and irrational odd-residue weights, outside its integer
base/rational weight hypotheses. His [finite BBP ray argument](https://github.com/eldernos/MathematicsResearch/blob/062e66cfa698de194f8276a67e43133c560ced4f/notes/phase18/summation.md)
instead requires a distinct prime on each ray; all our columns use 17.
[Kano's 1993 Theorem 1](https://ir.library.osaka-u.ac.jp/repo/ouka/all/10356/ojm30_04_15.pdf)
assumes coprime integers a,b>1 and strictly increasing
denominator and radix exponents with growth/nondivisibility conditions; no
direct application to our interlaced insertions was established. These are
comparisons of hypotheses, not impossibility claims about further adaptations.
The [search/review record](agy-reports/m4-continuation-review.md#fixed-column-provenance-and-lean-search--2026-11-27-utc)
retains source identities and bounded-search limits. No formalization date is
assigned to the exact T_M result; the missing early-visit consumer remains the
next mathematical obligation before substantial downstream formalization.

### An actual column pair is not jointly equidistributed

The actual columns need not be jointly equidistributed, even though every
complete fixed truncation T_M above is normal. This is an elementary paper
argument, independently reviewed; no Lean theorem or originality claim follows.
Use the r=1 columns with cofactors1 and9, including their k=0 terms:

```text
a_k=(17^k-1)/8, b_k=(9*17^k-1)/8=a_k+17^k,
C_1=4*sum_(k>=0)17^(-k)*16^(-a_k),
C_9=(4/9)*sum_(k>=0)17^(-k)*16^(-b_k),
X=C_1+9*C_9.
```

For every k>=0, 17^(k+1) divides 16^(17^k)+1. Starting from16+1=17,
raise -1+17^(k+1)u to its seventeenth power: the linear term has factor
17^(k+2), and higher terms have at least17^(2k+2). Thus for
b_K<=n<a_(K+1), the complete paired prefix

```text
P_(K,n)=4*sum_(k=0)^K 16^(n-b_k)*(16^(17^k)+1)/17^k
```

is an integer. The omitted positive tail satisfies

```text
0 < 16^n*X-P_(K,n)
  <=8*16^(n-a_(K+1))*sum_(k>K)17^(-k)
  <=17^(-K)/32 < 1.
```

Consequently all17^K indices in this block have fractional parts in[0,1/16).
At prefix length a_(K+1), their proportion alone tends to8/17, exceeding1/16.
So X is not16-normal. A jointly equidistributed pair (C_1,C_9) would instead
make X equidistributed under the integer map (x,y)->x+9y modulo1: its first-cell
preimage has Haar measure1/16 and boundary of measure zero. That is impossible.

This does not assert nondensity or failure of disjunctivity for X, and it
does not concern the frequencies of pi. The weighted pair differs from T_M;
its proof needs neither individual-column nor fixed-truncation normality.
It rules out full joint equidistribution as a shortcut for these actual
columns. A weaker useful correlation estimate would still need an actual
infinite-sum consumer. The nearby signed cyclotomic criterion cited above is
related prior work; its integer-base statement is not used in this direct
eighth-grid argument. The [review record](agy-reports/m4-continuation-review.md#actual-column-resonance--2026-11-28-utc)
retains the exact sketch and review limits. No actual phase or digit census
was used; the block count is symbolic for every K. V/M4 remains open.

### Column resonance does not supply a small-entropy remainder

For base16 dynamics, let Hlow/Hup be the infimum/supremum of entropy over
all empirical limit measures, normalized by4 bits. They lie in[0,1].
[Bergelson–Downarowicz](https://arxiv.org/html/2506.12929v1), Definitions3.2/4.4,
Propositions4.7,4.9(a,d),4.25 and negation invariance give

```text
Hlow(x+y)>=Hlow(x)-Hup(y), Hup(x+y)<=Hup(x)+Hup(y),
Hlow(q*x)=Hlow(x), Hup(q*x)=Hup(x) for nonzero rational q.
```

Normality means Hlow=Hup=1. Thus normal cores x_j with
Hup(pi-x_j)->0 would prove pi normal. This source consumer retains an
unproved remainder hypothesis; small absolute error does not imply it.
The source proofs retain factor/joining entropy, finite-to-one preservation
and the maximal-entropy characterization; no full transitive audit or Lean
formalization is claimed.

The actual cutoffs cannot satisfy that hypothesis at every M. Write
beta_M=pi-T_M. For each eligible cofactor m>=7, individual-column normality
and beta_(m-1)-beta_m=C_m imply

```text
1<=Hup(beta_(m-1))+Hup(beta_m),
limsup_(M->infinity) Hup(beta_M)>=1/2.
```

This inequality alone excludes convergence to zero along all cutoffs, not a
sparse subsequence. The stronger argument below also excludes sparse cutoffs.
Neither uses an entropy value or normality assertion for pi.

Resonant pairs also require care. Fix r in{1,4,5,6}, and extend
U_l=sum_(k>=0)17^(-k)*16^(-(l*17^k-r)/8) to all positive l congruent to r
mod8, including17-divisible auxiliary indices. Put V_l=U_l+U_(l+8).
For eligible m and rational q_m=16^(-(m-r)/8), exact reindexing gives
U_(17m)=17*(U_m-q_m), whence

```text
sum_(i=0)^(2m-1) (-1)^i*V_(m+8i)=-16*U_m+17*q_m.
```

This finite aggregate is normal by individual-column normality and rational
affine preservation. It is not the actual weighted tail. No individual V_l
entropy/activity estimate is proved, and an aggregate's entropy cannot be
bounded by the largest individual entropy without further hypotheses.

For the actual weights, set m_j=r+8j and w_j=c_r/m_j when17 does not divide
m_j, zero otherwise. The alternating sum alpha_r=sum_j(-1)^j*w_j equals
(16/17)*L_r, where L_r=c_r*integral_0^1 t^(r-1)/(1+t^8)dt: the excluded
indices are17j+2r, with the same parity as j. In particular alpha_4=-2*pi/17.
With d_j=sum_(i>j)(-1)^(i-j-1)*w_i, the tails d_j tend to zero and

```text
sum_j w_j*U_(m_j)=alpha_r*U_r+sum_j d_j*V_(m_j).
```

The bound U_(r+8j)<=(17/16)*16^(-j) justifies the regrouping. For r=4 the
boundary multiplier and every d_j are irrational, outside rational-affine
preservation. Alternatively the zero-boundary coefficient-matching recurrence
p_0=w_0, p_(j-1)+p_j=w_j uniquely gives rational
p_j=(-1)^j*sum_(i<=j)(-1)^i*w_i, with nonzero parity limits +/-alpha_4.
Neither representation supplies an infinite-sum entropy bound. A controlled
grouped remainder remains open; the sparse-cutoff question is resolved below. The
[separate review](agy-reports/m4-continuation-review.md#resonant-column-entropy--2026-11-28-utc)
accepts these paper diagnostics only; V, C_odd and M4 remain incomplete.

### Separated cutoff differences rule out small-entropy remainders

Let integers 0<=A<B admit a prime p>17 with p=1 mod8 and
max(A,B/2)<p<=B. Then the actual difference T_B-T_A is 16-normal at paper
level. This uses the retained Bailey–Crandall orbit estimate and transfers;
all constants may depend on A,B. It does not cover arbitrary close cutoffs
or give an early visit. The following argument supplies the noncancellation
that normality of the two endpoints alone would not establish.

Let S be the eligible cofactors in (A,B], D clear their c_r/m denominators,
and X_n=D*S_n their scaled zero-initialized driven prefix. Hensel lifting
gives lambda in 1+17Z_17 with lambda^8=-16. Its degree over Q is eight:
eta=lambda^2/2 has order eight; s=eta+eta^(-1) satisfies s^2=2, and
lambda/s is a primitive sixteenth root of unity. Thus the four powers
lambda^r for r in{1,4,5,6} are rationally independent.

For every tuple of nonnegative integers h_m, define

```text
L_h=-(D/16)*sum_(m in S)(c_r/m)*(-1)^((m-r)/8)*lambda^r*17^h_m.
```

Its lambda coefficient before multiplication by -D/16 has a unique term
with p-adic valuation -1, at m=p; all others are p-integral since 2p>B.
Hence L_h is nonzero. Also L_h is 17-adically integral.

On I_K={(17^K-1)/8,...,(17^(K+1)-1)/8-1}, let k_m be the latest included
depth and d_m=floor(log_17 m). Once all columns have started,
h_m=K-k_m belongs to {d_m,d_m+1}. There are finitely many such tuples.
The exact identity

```text
16^(-e(m,k))=(-1)^((m-r)/8)*lambda^r*lambda^(-m*17^k)
```

and lambda^(17^t)=1 mod17^(t+1) give
`17^K*16^(-n)*X_n-L_h in 17^(K+1)Z_17` uniformly on I_K.
Indeed, reversing the depth sum gives terms
17^h*lambda^(-m*17^(K-h)); replacing each power by1 has that error,
as does completing the geometric tail. Put C_S=max_h v_17(L_h).
For sufficiently large K the reduced denominator is exactly
q_n=17^(K-v_17(L_h)), so 17^(K-C_S)<=q_n<=17^K.

Every retained column inserts at most once per level. Partitioning a level
or its final partial prefix therefore gives at most |S|+1 homogeneous pieces.
The retained pure-orbit bound gives piece count error
C*(sqrt(q)+J/sqrt(q))*log^2(q). The denominator bounds make the total
O_S(17^(K/2)*K^2); geometric summation gives whole-prefix discrepancy
O_S(log^2(8N+8)/sqrt(N))+O_S(1/N), tending to zero.
The exact static/driven tail is at most 8D/[15*(8n+9)], also tending to zero.
The existing perturbation and rational-affine transfers prove normality of
T_B-T_A, without selecting an inverse fractional-part branch.

The existing [fixed-progression PNT](https://math.mit.edu/~drew/PrimeGapsOberwolfach1.pdf#page=3)
gives theta(B;8,1)-theta(B/2;8,1)~B/8. Thus the prime hypothesis holds for
every fixed A and all sufficiently large B>2A. For ANY fixed real x, set
f(M)=Hup(x-T_M) and L=liminf_M f(M). Entropy subadditivity gives
1<=f(A)+f(B). First taking liminf in B with A fixed yields f(A)>=1-L;
only then taking liminf in A gives

```text
liminf_(M->infinity) Hup(x-T_M)>=1/2.
```

No unbounded cutoff subsequence can therefore provide upper remainder entropy
tending to zero. This closes that proposed normal-core transfer for these
complete cutoffs, for any x, without computing the entropy of pi. Other core
families, grouped-tail estimates and actual visitation remain open. The
[separate paper review](agy-reports/m4-continuation-review.md#separated-cutoff-entropy--2026-11-28-utc)
retains external discrepancy, transfer, entropy and PNT inputs; no full source
proof audit, Lean theorem or originality determination is claimed.

### Actual-weight packets with small upper entropy

Actual unequal weights can also resonate in selected finite packets. Let
M=34t+1, t>=1, L=M^2+4, and

```text
a=(M-2)L, b=(M+2)L, c=ML, d=M(M^2-4).
```

These are distinct odd integers prime to 17, with a<d<c<b<17a.
For chi4(u)=(-1)^((u-1)/2), the identities
1/a+1/b=1/c+1/d and chi4(a)=chi4(b)=-chi4(c)=-chi4(d) give zero signed
reciprocal sum. Thus
`X_M=-(1/2)*sum_(u in {a,b,c,d}) U_(4u)/u`
uses four actual residue-4 column weights, each once.

Put D=lcm(a,b,c,d), Y_M=2D*X_M, and e(u,k)=(u*17^k-1)/2.
After n>=e(b,k), the completed depth-k contribution to 16^n*Y_M is

```text
-16^(n-e(b,k))*F(16^(17^k))/17^k,
F(Z)=sum_u(D/u)*Z^((b-u)/2), F(-1)=0.
```

The integer factor Z+1 and 17^(k+1) dividing 16^(17^k)+1 make this
contribution integral. Since b<17a, the active intervals [e(a,k),e(b,k))
are separated. Outside them every started depth is complete, and the future
tail has circle distance from zero tending to zero. This is convergence in
R/Z: negative tails can have fractional representatives approaching 1.

The active lengths are (b-a)*17^k/2. Summing them and maximizing the ratio
over all initial segments gives asymptotic upper fraction
rho=17(b-a)/(16b)=17/[4(M+2)]. Every empirical limit measure of Y_M has
an atom at the circle's fixed point zero of mass at least 1-rho. Invariance
and entropy affinity, followed by rational-scaling invariance, therefore give

```text
Hup(X_M)<=17/[4(M+2)] -> 0.
```

Only an entropy upper bound is used here; density of the individual packet
orbits is not settled. The entropy source and its retained dependencies are
the same as above. No orbit discrepancy estimate is needed here.

The whole-tail consumer remains missing. Among eligible residue-4 cofactors,
a zero-charge packet containing 4p, p an odd prime other than 17, cannot
have max/min<2: its p-denominator term would be unique. More generally,
there is no complete partition of the residue-4 cofactor tail into disjoint
finite zero-charge packets with shrinking relative widths. Precisely, the
excluded condition is that for every epsilon>0, all but finitely many packets
P satisfy max(P)/min(P)<=1+epsilon. Here charge is
`sum_(m in P)(-2/m)*(-1)^((m-4)/8)`.

For large cutoff X, after all exceptional packets have completed, unfinished
packets contribute only from [X/(1+epsilon),X]. Disjointness bounds their
absolute harmonic charge by O(log(1+epsilon))+O(1/X); completed charges are
zero. Taking X to infinity and then epsilon to zero would force the entire
tail charge to vanish. Its actual value is -2*pi/17 minus a finite rational
sum, hence nonzero. This argument concerns the stated residue-4 partition.

A residual core is therefore required for that mechanism. No normal residual
or whole-orbit entropy bound for the remaining sum has been supplied. Finite
entropy subadditivity does not pass through arbitrary real limits: even an
absolutely convergent sum of entropy-zero rationals can equal any real number.
The clearing denominators also vary between packets. The
[separate review](agy-reports/m4-continuation-review.md#actual-weight-packet-entropy--2026-11-28-utc)
accepts the finite resource and restricted partition argument at paper level;
no Lean, originality or actual selected-time visitation claim follows.

### The zero branch and what the scaled projection loses

Keep the definitions above and write D=D_M, u_n=fract(S_(M,n)),
z_n=fract(D*u_n), beta_n=floor(D*u_n), with beta_-1=z_-1=0. The exact
integer recurrence is

```text
h_n=floor(16*z_(n-1)+D*B_M(n)),
u_n=(beta_n+z_n)/D,
beta_n=(16*beta_(n-1)+h_n) mod D
      =(sum_(s=0)^n16^(n-s)*h_s) mod D.
```

It follows by subtracting D times the ordinary unscaled carry. A hit in
(a,b) is exactly `D*a-z_n<beta_n<D*b-z_n`. This is an interface, not an
existence argument. The actual zero condition selects one branch. Since
v_2(D)=1, seed increments j/D nevertheless leave D/2 distinct unscaled
branches at every n>=0 while preserving the entire projected trajectory.

This loss persists even when all projected correlations and cutoff forcing
are retained. Choose j nearest D*(1/5-T_M)/16, delta=j/D and
alpha_M=T_M+16*delta. The changed raw history
V_n=S_(M,n)+16^(n+1)*delta has the same B_M and every projected state z_n.
Its raw initial value is delta, not zero. With E_(M,n)=16^n*T_M-S_(M,n),
subtract the integer K_n=(16^n-1)/5 to obtain

```text
V_n-K_n=1/5+16^n*(alpha_M-1/5)-E_(M,n),
|alpha_M-1/5|<=8/D,  |E_(M,n)|<=8/[15*(8n+9)].
```

The earlier PNT-dependent growth of D implies 16^W_M/D->0 for the sufficient
window W_M=M/8+log_16 M+O(1). For all sufficiently large M and
6<=n<=W_M, the centered representative V_n-K_n lies in (.18,.22), so it
equals fract(V_n) and avoids (1/4,3/4). The raw states themselves are not
close to 1/5. Each fixed alpha_M remains normal by rational translation;
this is arbitrarily long early avoidance as M varies, not permanent avoidance
by one normal number. Actual initialization, period and pi approximation
are lost. Reducing j modulo D requires the matching integer adjustment to K_n.

Scaled-integral insertions cannot simply be discarded while retaining zero.
For a 17-step block n=17k,...,17k+16 with M>=136k+134, let

```text
I(k)=sum_(0<=s<17,r in R,17 does not divide 136k+8s+r)
       16^(16-s)*c_r/(136k+8s+r).
```

These 64 contributions are scaled integers. The four other insertions occur
at s=2r. Deleting only the 64 terms preserves every z_n but changes the
unscaled endpoint by I(k). At k=1, the unique pole with denominator divisible
by 137 is s=0,r=1; all others are below 274. Hence
`v_137(I(1))=-1` and `137*I(1)=4*16^16=103 mod137`.
Thus D*I(1) is integral but nonzero modulo D. This refutes that deletion,
not every possible block cancellation; a nonzero residue is not a visit.

Rounding instead sets I_n=floor(D*B_M(n)), P_-1=0 and
P_n=16*P_(n-1)+I_n. Geometric summation gives

```text
0<=S_(M,n)-P_n/D<(16^(n+1)-1)/(15D).
```

This error tends uniformly to zero through W_M as M grows. Raw P_n/D lies
in the infinite lattice (1/D)Z; its fractional part lies in the D-point grid.
No early visit of that grid trajectory has been proved. For fixed M, after
the finite k=0 and large-magnitude insertions, I_n is -1 at negative-column
insertions and 0 elsewhere, with infinitely many -1 terms. Its forcing I_n/D
therefore does not tend to zero. For the static period
alpha_M^floor=(1/D)*sum_(n>=0)I_n*16^(-n), the scaled orbit eventually lies
in [14/15,1), from its negative 0/1 tail digits. Integer dilation then shows
alpha_M^floor is also nondisjunctive. Separately, its static/driven tail at
e-1 before each late negative insertion e is at most -1/(16D), so the
vanishing-tail transfer fails. Although `0<=T_M-alpha_M^floor<16/(15D)`,
this changes exact forcing and period. It is no counterexample to V.

The [review record](agy-reports/m4-continuation-review.md#integer-branch-and-projection-tests--2026-11-27-utc)
retains the centering correction and grid clarification, preserved inputs and
53,682 structural checks. Those checks compute no actual pi phases or initialized
BBP prefixes. A successful next identity must retain the full integer insertion
and zero anchor and actually force the target-cell inequality early enough.
V/M4 and actual odd-carry infinitude remain open.

### Stronger fixed-prime sources retain the transfer gap

The September 2026 [two-Stoneham-sum paper](https://github.com/CaptainSude/Stoneham-sum-normal/blob/f4d3d1f01d00c57425c684409849053e58e42261/paper/stoneham-two-sum-normality.tex)
claims normality of alpha_(b,c)+alpha_(b,d) for integer b,c,d>=2 and
gcd(b,c)=gcd(b,d)=1, where alpha_(b,c)=sum_(k>=1)1/(c^k*b^(c^k)).
Both coefficients are +1. Its proof uses denominators between n^eta and
n^2, fixed prime support, bounded insertion counts on dyadic windows, and
an orbit-sum estimate for length at least q^(17/36). Its statement does
not cover our signed weights, shifted insertions or growing number of columns.
Normality of a two-sum cannot be iterated by treating the sum as another
Stoneham constant.

The related [localized-logarithm paper](https://github.com/CaptainSude/xi-normality/blob/06961817c7f61181ed9a5c73badb8d908d6ccdcc/paper/localized-logarithm-normality.tex)
claims normality of sum_(m in M_P)1/(m*b^m), with M_P the positive integers
supported on a fixed finite nonempty prime set P, if all primes in P are
coprime to b, or if b=2 and 3 belongs to P. It explicitly retains the
nonuniformity preventing passage to its logarithmic limits. Its finite-prime
extension is paper-only, beyond its claimed formalized {2,3} result.

[Vandehey, Corollary 1.2](https://arxiv.org/html/1606.07911v1), states that
for fixed finite prime support P, integer b>=2, q supported on P,
gcd(a,q)=gcd(b,q)=1, and fixed epsilon>0, there are delta(epsilon)>0 and
C(epsilon,b,P)>0 with

```text
|sum_(j=1)^L e(a*b^j/q)| <= C*q^(-delta)*L*(1+log q),  L>=q^epsilon.
```

The primary statement was inspected, not its full proof. Even with P={17},
bounded pieces fail that length condition as q grows. Varying epsilon or P
requires new uniform estimates. The complete two-sum TeX and the localized
finite-prime argument were read, but neither external Lean development was
built, audited or imported. The source screen rejects these direct transfers;
it does not reject all possible adaptations of their methods.


## Growing-prime projections and the unscaled branch

Changing the auxiliary prime removes the short-piece obstacle for a different,
projected array of the actual prefixes. It still does not locate an unscaled
hit: the same primes, horizons and global multipliers give the same distribution
conclusion for the fixed positive avoiding F. This is an independently reviewed
paper argument using an external subgroup estimate, not a new Lean theorem.

Fix a nonempty set I contained in {1,...,8} and fixed nonzero rational c_r.
Set g(n)=sum_(r in I)c_r/(8n+r), S^g_-1=0 and
S^g_n=16*S^g_(n-1)+g(n). Assume every ordered partial

    B_(j,r)=sum_(k<j,s in I)c_s/[16^k*(8k+s)]
              +sum_(s in I,s<=r)c_s/[16^j*(8j+s)]

is nonzero. This premise is proved below for A and the null D, rather than
assumed for arbitrary forcing. Let p tend through primes with p=1 mod8 and
ord_p(16)>=p^(1/4). Put

    t=(p-1)/8, L=floor((log p)^(1/3)), r0=min I,
    H=(8(L+1)+r0)*t+L+1.

For every sufficiently large such p, choose any positive integer K_p prime
to p with p*K_p*g(n) integral for every 0<=n<H. This is one multiplier
for the entire horizon. Then, for every fixed nonzero integer h, eventually

    abs((1/H)*sum_(n<H)e(h*K_p*S^g_n))
      <= r0*t/H+p^(-gamma)+(L+1)/H.                  (1)

Here gamma>0 is fixed. Therefore these changing projected arrays are
equidistributed as p grows. No conclusion about the unscaled fixed orbit
or its normality is asserted.

### Source input, activation clocks and uniform nonvanishing

[Bourgain–Konyagin, Theorem 2.1](https://www.numdam.org/item/10.1016/S1631-073X(03)00281-4.pdf),
printed p.78, states that for a subgroup G of F_p^* of size at least p^delta,
every nonzero additive character has sum of absolute value at most
`|G|*p^(-gamma)`, with `gamma=exp(-C1/delta^C2)>0` for absolute positive
constants. We use delta=1/4. The primary statement was inspected visually;
its proof chain is not audited or formalized.

The supplemental quadratic-residue law gives
`16^t=2^((p-1)/2)=1 mod p`, so ord_p(16) divides t. A denominator 8n+r
is a multiple of p at exactly

    n=e_(j,r)=(8j+r)*t+j,  8n+r=(8j+r)*p.

For large p, 8H+8<p^2, so all poles before H have j<=L and p-valuation
one. In fact H=e_(L+1,r0). With Z_n=p*K_p*S^g_n integral, the exact
initialized modular recurrence gives `16^(-n)*Z_n=K_p*B_(j,r) mod p`
between each activation and the next. Before the first activation Z_n=0
mod p. Congruences are computed in the p-local rationals.

To ensure a unit seed uniformly through j<=L, choose an integer Q clearing
the coefficients and C=(16/15)*sum_r abs(c_r). Every relevant B has
abs(B)<=C, while Q*16^L*(8L+8)!*B is a nonzero integer. Its absolute
value is at most Q*C*16^L*(8L+8)!<p eventually, since its logarithm is
O(L*log(L+2))=o(log p). The clearing factors are also p-adic units.
Thus all these B are nonzero modulo p. This is a uniform growing-depth
bound, not a substitution into a fixed-depth survival assertion.

Within a block, successive activations have gap (s-r)*t; across a boundary
the gap is (8+r0-rmax)*t+1. Every homogeneous piece is a union of complete
coset cycles of <16>, with at most one extra point per block. There are L+1
such possible extras. The initial zero piece has length r0*t. Applying the
source bound to complete cycles and bounding the remaining points trivially
proves (1). The initial mass r0*t/H tends to zero; it was not discarded.
Weyl's criterion for these finite arrays gives the stated interval counts.

The primes required above exist without an order conjecture. Fixed-progression
PNT, in the form [theta(X;8,1)~X/4](https://math.mit.edu/~drew/PrimeGapsOberwolfach1.pdf#page=3),
gives logarithmic prime mass X/4+o(X) in [X,2X]. Every bad prime there
divides the product of 16^k-1 for 1<=k<=floor((2X)^(1/4)). That product
has logarithm O(sqrt(X)), too small to contain the progression's mass.
This uses no primitive-root conjecture or varying-modulus PNT. The cited
fixed-modulus statement was inspected; no external Lean implementation is used.

### Actual A and one common positive avoiding comparison

For A, the first term of each ordered block is positive and the remaining
terms are negative. Its completed initialized state is positive, so every
ordered partial is positive. Q=1 and C=128/15 suffice above. The activation
gaps are 3t,t,t,3t+1 and H=(8L+9)*t+L+1.

Use the existing [null forcing D=A+Ahat](m4-prime-compression.md#the-actual-null-state-has-denominator-exponent-eight),
whose coefficients at offsets 1,...,7 are (4,-4,-2,-4,-1,-1,1/2), with
prefix U_n. Its proved paper bounds give 0<U_n<1/(16n+18). The partial
after offset 6 is U_n-1/[2*(8n+7)]<0. Adding 1/(8n+6) gives the positive
partial after offset 5; all earlier nonempty partials are larger, and the
completed state U_n is positive. Thus every partial is nonzero. Q=2 and
C=88/5 suffice. The same theorem applies, even though unscaled U_n tends to 0.

The [positive thirteen-pole F](m4-rational-forcing.md#residues-and-exact-avoidance)
retains positivity as well. Define

    t0(n)=1/[(8n+1)*(8n+5)], R(n)=t0(n)/2-D(n)/8,
    F(n)=(15/8)*D(n)+16R(n)-R(n+1), R(0)=2/21.

Its zero-initialized prefix W_n satisfies exactly
`W_n=(15/8)*U_n+16^(n+1)*R(0)-R(n+1)`.
Let J_p be the lcm of the reduced denominators of A(n), D(n), F(n),
R(n+1) for n<H, together with R(0), and take
`K_p=8*J_p/p^(v_p(J_p))`. This is a definition, not an evaluated denominator
census. For large p, all possible p-poles are simple and 8H+15<p^2.
The positive integer K_p is a p-adic unit admissible for A; the integer
15*K_p/8 is admissible for D. Both inputs have r0=1, hence the same H.

Except when R(n+1) has a p-denominator, the rational correction and its
initialized homogeneous term become integers after multiplication by K_p.
Thus `fract(K_p*W_n)=fract((15*K_p/8)*U_n)` outside at most
`7*(floor(H/p)+1)` indices. Indeed all possible poles of R(n+1) are among
8n+9,...,8n+15. Character replacement then gives

    abs((1/H)*sum_(n<H)e(h*K_p*W_n))
      <= t/H+p^(-gamma)+(L+1)/H+14/p+14/H.          (2)

Consequently the same p,H,K_p give projected equidistribution for actual A
and fixed positive F. Yet F's initialized unscaled phases always lie in
(31/350,11/21), avoiding (3/4,7/8). It also retains the previously reviewed
dyadic comparison blocks and complete-period grids. Its rational period
32/21 remains a difference from pi; this does not refute a theorem exploiting
actual irrationality and additional structure.

The test resolves a short-piece obstruction for the projected quantity and
rejects a projected-only visitation consumer. K_p grows with p, and dividing
a fractional part by K_p does not recover its integer branch. No unscaled
visit, mixed-character estimate, new Lean theorem or priority claim follows.
The [review record](agy-reports/m4-continuation-review.md#growing-prime-projection-comparison--2026-11-28-utc)
retains the source and check limits. V/M4 remains open.

## Signed cutoff tails and their full-prefix comparison

For the actual aligned cutoffs M=8L+6, L>=1, put
F_L=16^L*(pi-T_M). The following paper refinement retains both original
periods and zero-initialized prefixes. It introduces no new source theorem,
Lean result or originality claim. Let d be17-periodic with
`d_2=4, d_8=-2, d_10=d_12=-1`, zero elsewhere, and define

```text
Gamma_s=(sum_(j=1)^17 d_(s+j)*16^(-j))/(1-16^(-17)),
C_s=-Gamma_s/8,  c0=349/1800.
```

Then, uniformly for every L>=1,

```text
|F_L-C_(L mod17)/L| <= c0/L^2,
|C_s| >= 59/(480*16^7) > 0       (s=0,...,16).
```

Here is the infinite-tail argument. All poles through index L are retained.
For L<n<=17L+12, the retained sum is exactly
`J(n)=sum_(r in R,17 divides8n+r) c_r/(8n+r)`; afterwards it is a sub-sum
of J(n). Thus F_L is the geometrically weighted sum of A(L+j)-J(L+j), j>=1,
up to error at most `16^(-(16L+12))/(15L)`. Since 0<A(n)<1/n^2, its A-part
is at most1/(15L^2). Replacing each reciprocal in J by1/(8L) costs at most
109/(1800L^2); the remaining geometric error is at most1/(15L^2).
The nonzero d terms have cyclic gaps6,2,2,7. The first dominates the entire
subsequent geometric tail, proving the stated nonzero lower bound. The
137 pole at n=17 is retained in both periods for every L>=17; cancellation
in their difference does not delete its nonzero contribution to either period.

Consequently, for any fixed delta>0, the last n with
`16^n*|pi-T_(8L+6)|<=delta` is `L+log_16 L+O_delta(1)` as L tends to infinity.
This is the actual ordinary absolute-error horizon for this aligned family;
it is not a lower bound for distance to an integer.

A later circular window is possible. Fix s, a=|C_s|, sigma=sign(C_s), and choose
L_k congruent to s modulo17 nearest to a*16^k. Then |L_k-a*16^k|<=17/2.
For sufficiently large k, L_k>=17, set M_k=8L_k+6 and n0=L_k+k. For every j>=0,

```text
|16^(n0+j)*(pi-T_(M_k))-sigma*16^j| <= B_s*16^j/L_k,
B_s=17/2+3*c0/(2a).
```

The center sigma*16^j is an explicit integer. For any fixed0<epsilon<1,
all j from0 to J_k=floor((1-epsilon)log_16 L_k) therefore have circular
error at most B_s*L_k^(-epsilon), tending uniformly to zero. The last index
is L_k+(2-epsilon)log_16 L_k+O_s(1). A sufficiently late cutoff visit to
(a0+2eta,b0-2eta), with4eta<b0-a0, transfers to the actual recurrence target
(a0,b0) once this error and E_n are each below eta. This retains every target
0<=a0<b0<=1, threshold and recurrence offset n+1. No such visit is supplied.

### The simpler actual prefix already reaches this window

The established positive-tail representation gives, for every L>=1,

```text
0<E_L=16^L*pi-S_L <=1/(64L^2),
0<=1/(64L^2)-E_L <=23/(512L^3).
```

Therefore the full rational prefix continued homogeneously shadows pi for
h<=(2-epsilon)log_16 L at every anchor. The rational correction
S_L+1/(64L^2) already extends this to (3-epsilon)log_16 L. Higher fixed-order
corrections were assessed above; more approximation accuracy alone gives no visit.
For the selected L=L_k write r_k=16^k F_L-sigma. The exact comparison is

```text
16^(L+k+j)*T_M + sigma*16^j -16^(k+j)*S_L
  =16^(k+j)*E_L-16^j*r_k.
```

Its absolute value is at most `(3/(128a)+B_s)*16^j/L`. The selected cutoff,
frozen full-prefix, pi and actual driven phases thus have the same circle
limit set along these moving windows. Every fixed margined hit transfers
between them, and averages of any fixed finite trigonometric polynomial
differ by o(1). The entire selected window eventually lies within the simpler
prefix window after arbitrarily slightly reducing epsilon. This selected-window
visitation property is not asserted equivalent to V: V could obtain visits
elsewhere. Fixed-M normality has supplied no new estimate for these early
phases. Suspend further window tuning without a distinct real-phase consumer.

### Selected anchors do not yield a small linear recurrence

The explicit C_s have denominators dividing8q, where q=17112760831,
q divides16^17-1 and q=1 modulo17. For k>=1,
`|C_s|*16^k*(16^34-1)` is a multiple of17. Nearest-class rounding then has
an exactly34-periodic offset. Fixing k=k0+34t, k0>=1, gives
`L_k=alpha*Q^t+b`, with Q=16^34, alpha>0 and rational b.

The actual rational phase `x_t=fract(16^k*S_(L_k))` cannot eventually satisfy
any nontrivial fixed-order linear recurrence
`sum_(i=0)^r a_i(Q^t)*x_(t+i)=0`, with a_i in Q(X) and a_r nonzero.
Indeed clear denominators to integer polynomials A_i. A single cumulative
product of the nonzero leading coefficients A_r(Q^u) clears all subsequent
sequence denominators, so their logarithms are O(t^2). The earlier all-anchor
prime-product argument instead supplies an odd denominator divisor with
logarithm2L_k+o(L_k), of order Q^t. Multiplication by16^k and taking fractional
parts cannot cancel it. The contradiction retains that argument's unformalized
PNT-in-a-fixed-progression input; it also covers fixed rational-function
corrections by the existing denominator bound. Nonlinear, floor-dependent or
growing-order recurrences are not excluded.

The [Bostan–Yurkevich q-holonomic paper](https://arxiv.org/abs/2012.08656)
provides bibliographic context for this recurrence class; no algorithm or
external theorem from it is used in the elementary denominator argument.
The [review record](agy-reports/m4-continuation-review.md) owns the exact proof,
comparison, structural replay and review evidence. None supplies actual odd-carry
infinitude or V; M4 remains open.


### A small-grid occupancy proof does not transfer to the growing columns

The [Strong Hot Spot Theorem](https://www.davidhbailey.com/dhbpapers/dhb-mm-hotspot.pdf)
of Bailey–Misiurewicz gives a different mechanism from complete-period coverage.
Its Stoneham application uses unscaled approximants on a Q-point grid with
Q<=N through time N, point multiplicity at most3, and error less than1/(2n).
The source's Theorem1.1 uses a single constant for every interval and a limsup
over all prefix lengths; Theorem3.5 has its stated liminf/limsup order. Neither
permits replacement by an arbitrary good subsequence. The arithmetic pattern
cited by its application is a source input, not a freshly audited proof chain.

Here is a finite consumer. Let b>=2 be an integer, alpha real,
x_n=fract(b^n*alpha), and let w have
positive length ell, with canonical half-open cell I_w. Fix integers
0<=n0<N, r>=1, k=r*ell and Q>=1. Suppose for n0<=n<N that z_n belongs to
G_Q={a/Q:0<=a<Q}, its circular distance from x_n is at most epsilon>=0,
and no grid point is used more than mu>=1 times. Put L=(b^ell-1)^r. Then

```text
(no x_j in I_w for n0<=j<N+k)
    implies N-n0 <= mu*L*[Q*(b^(-k)+2*epsilon)+2].
```

Each x_n has r aligned blocks different from w, giving L half-open k-digit
cylinders. Their closed epsilon-enlargements contain at most
Q*(b^(-k)+2*epsilon)+2 grid points each, including wrap and endpoint cases.
Summing and applying multiplicity proves the bound. Its strict reversal
certifies a word start in [n0,N+k); it uses one fixed orbit throughout.

For the source's binary Stoneham number, choose rho=1-2^(-ell), r with
rho^r<=1/12, k=r*ell, epsilon=1/(4*2^k), n0=max(B,2*2^k), and
N>=max(12*2^k,4*n0). Its Q<=N and mu=3 give the strict certificate, since
[n0+mu*L*(Q*(2^(-k)+2*epsilon)+2)]/N<=1/4+6*rho^r<=3/4.
Thus this mechanism locates a word beyond any threshold B in the solved
neighbor. No such conclusion is inferred for pi.

For M>=6 and our actual unscaled z_n=fract(S_(M,n)), 0<=n<N, one can take
K=floor(log_17(8N-2)), Q=D_M*17^K. All retained denominators divide Q, and
17^(K+1)>8N-2>=6N gives Q/N>=(6/17)*D_M. Scaling by D_M does not remove
this factor from the unscaled grid; the integer branch must still be retained.
The discrepancy between small and large grids is not merely over-clearing:
for M=8L+6, forcing and initialized raw states agree with actual A and S
through index L. Any origin-based common grid must have denominator divisible
by q_L, whose logarithm is6L+o(L). More generally the least common denominator
of a finite zero-initialized recurrence's states equals that of its forcing,
since each family is an integer linear combination of the other. Fractional
parts preserve reduced denominators. Approximate coarse grids are not excluded.

Put a=log15/log16. Every aligned avoidance cover includes all15^k words
omitting one digit occurring in w. Even granting mu=1, epsilon=0 and n0=0,
the displayed counting bound is at least

```text
Q*(15/16)^k+2*15^k >= Q^a.
```

Split into16^k<=Q and16^k>=Q to prove this. Hence THIS certificate requires
N>Q^a, and therefore N>((6/17)*D_M)^(log15/log(16/15)). Using the existing
PNT-dependent log D_M=3M/4+o(M), the logarithm of its required sample count
is at least[3*log15/(4*log(16/15))]*M+o(M), approximately31.4702M.
This is a cost of the stated upper-bound method, not an actual first-hit bound.

The same problem remains with exact grid counting in the known sufficient
window W_M=M/8+O(log M). Define A_k as the union of length-k half-open
cylinders whose finite words avoid w at every start wholly contained in that
prefix, or the larger aligned cover. It contains15^k disjoint cylinders, so
#(G_Q intersect A_k)>=15^k*floor(Q/16^k). Uniformly for1<=N,k<=W_M,
D_M/16^W_M tends to infinity and

```text
#(G_Q intersect A_k)/N >=(3/17)*D_M*(15/16)^W_M -> infinity.
```

Thus counting the entire unscaled grid with a multiplicity bound cannot
certify a visit in this window, even with zero error. This does not count
actual occupancy or exclude other/later approximation windows. A useful
replacement must control which grid subset the actual initialized sequence
occupies. The [review record](agy-reports/m4-continuation-review.md#finite-occupancy-source-test--2026-11-28-utc)
retains source contracts, exact checks and limits. No Lean declaration,
originality claim or V/M4 conclusion follows.


### Exact rescaling equations require growing polynomial degree

The finite columns have a functional structure different from the actual
coefficient series. Fix M>=6. For r in {1,4,5,6}, with c_r=4,-2,-1,-1, set

```text
F_(r,M)(z)=sum_(0<m<=M,17∤m,m=r mod8) (c_r/m)
              *sum_(k>=0)17^(-k)*z^((m*17^k-r)/8),
R_(r,M)(z)=sum_(0<m<=M,17∤m,m=r mod8) (c_r/m)*z^((m-r)/8),
H_M=sum_r F_(r,M).
```

All exponents are nonnegative integers, and

```text
F_(r,M)(z)=R_(r,M)(z)+(z^(2r)/17)*F_(r,M)(z^17).
```

This retains the signs and k=0 insertions. T_M=H_M(1/16), while the
zero-initialized raw-state series is formally H_M(z)/(1-16z); that formal
identity does not evaluate the raw-state series at its pole. Adjoining the
constant1 gives a five-component system with determinant z^32/17^4. Its
invertible matrix shows that H_M(z^(17^j)), j=0,...,5, lie in one
Q(z)-span of dimension at most five. Hence each H_M has a nonzero polynomial-coefficient
base17 Mahler relation of scalar order at most5. A leading-zero relation can
be separated by exponent residues to obtain the usual nonzero first coefficient.
This structure alone is not a normality theorem.

For fixed M the forcing B_M has O_M(log X) possible nonzero positions through
X and infinitely many nonzeros from the m=1 tower. Its arbitrarily long zero
runs rule out any eventual nonzero polynomial-coefficient recurrence: beyond
the last root of its leading coefficient, a sufficiently long zero run would
propagate forever. Thus H_M is not D-finite. This is a recurrence argument,
not a natural-boundary or digit-language argument.

For the actual H(z)=sum_(n>=0) A(n)z^n, put theta=z*d/dz and
D(n)=(8n+1)(8n+4)(8n+5)(8n+6). Direct expansion gives

```text
D(theta)H=(376+1416z+128z^2)/(1-z)^3.
```

It follows that H is D-finite. It is nonrational: an eventual constant-
coefficient recurrence would make sum_j c_j A(x+j) identically zero, whereas
each nonzero c_j contributes its unique pole at x=-j-1/8. The
[Bell–Coons–Rowland statement of Bézivin's theorem](https://cs.uwaterloo.ca/journals/JIS/VOL16/Bell/bell2.pdf),
definition(2) and Theorem1, then excludes H being k-Mahler for any integer
k>=2. This all-base conclusion retains that external paper input; its full
proof chain was not audited. It says nothing about another representation
of pi as a Mahler value.

For base17 an elementary proof removes that source dependency and supplies a
finite bound. Let P_j(z)=sum_(e=0)^h p_(j,e)z^e, j=0,...,d, with complex
coefficients not all zero and integers d,h>=0. Put R=17^d and s=(d+1)(h+1).
Choose the smallest active j0 and an e with p_(j0,e) nonzero; take rho=e modR.
On n congruent to rho modulo R, the coefficient of the proposed relation for
H, at every integer n>h, is the rational function

```text
G_rho(n)=sum_(j,e':e'=rho mod17^j) p_(j,e')*A((n-e')/17^j).
```

The selected term has a pole at n*=e-17^j0/8, with nonzero residue
p_(j0,e)*17^j0/2. Since17=1 mod8, the four pole types have different
fractional parts. A higher-level term could share this pole only at
e_j=e+(17^j-17^j0)/8. But e_j is not congruent to e modulo17^j, so it is
absent from G_rho. Smaller levels are inactive, and at j0 only the chosen
exponent shares the pole. Thus G_rho is nonzero, excluding every nonzero
base17 relation for H, including ones with initial zero polynomials.

Now suppose the same polynomials give a relation for H_M. Its coefficients
agree with H through L=floor((M-6)/8). A common-denominator numerator of
G_rho has degree at most4s-2, since A has numerator degree2 and denominator
degree4 and at most s summands are present. If L>=h+R(4s+1), the selected residue class
supplies4s+1 distinct zeros in h<n<=L, away from all poles because the A
arguments are positive integers. This contradicts nonzero G_rho. Therefore

```text
L < h+17^d*(4(d+1)(h+1)+1),
h > [L-17^d*(4d+5)]/[1+4*17^d*(d+1)].
```

At fixed scalar order the relation degree must grow at least linearly with
M. This bound is elementary and independent of PNT and Bézivin. It is NOT
a word-location or timing bound, and it does not exclude effective estimates
whose constants depend on the growing degree. Avoidance has not supplied a
functional equation for the actual digit path. The
[review record](agy-reports/m4-continuation-review.md#finite-column-functional-structure--2026-11-28-utc)
retains the exact source, supplement and verification limits. These are paper
results, with no Lean declaration or originality claim; V/M4 remains open.


#### A prior differential zero estimate

[Fischler, section3.1, Theorem5, pp.7–8](https://arxiv.org/pdf/1609.09770)
gives a sharper asymptotic coefficient after an explicit system bridge. Put
G_(r,j)(z)=sum_(n>=0)z^(17^j*n)/(8n+r), for r in {1,4,5,6} and0<=j<=d.
Then

```text
G'_(r,j)=-(r*17^j)/(8z)*G_(r,j)+17^j/[8z*(1-z^(17^j))].
```

Adjoining1 yields a fixed rational differential system of dimension Q=4d+5.
For the remainder R=sum_j P_j(z)H(z^(17^j)), all coordinate coefficients have
degree at most h. The elementary pole proof gives R!=0. The singleton family
of remainders at zero is therefore independent, and R is holomorphic there.
The source permits zero to be a system singularity outside a chosen cut plane.
Rational derivative rows supply an annihilator of order at most Q.

The theorem yields C_d>=0, depending only on this fixed system and {0}, with

```text
ord_0 R <=(4d+5)*(h+1)+C_d,
L+1 <=(4d+5)*(h+1)+C_d  for any relation for H_M.
```

The last step uses coefficient agreement through L, even when h>L. The
constant is uniform in h, M and the coefficient tuple, but is not numerically
specified in the inspected source. The coefficient of h is strictly smaller
than in the explicit elementary bound for d>=1; both are5 at d=0. No
finite-M improvement threshold or uniform estimate in d is established.
This separately assessed prior theorem is a source input, not a new proof of
its dependency chain. Neither estimate gives a digit visit or a timing bound;
the explicit elementary estimate remains available without this input.
