# M4 continuation: arithmetic windows and rational corrections

Research record, 2026-11-26. This tests one unconditional neighboring method
against the actual BBP sequence. It does not supply V. All universal arguments
below are paper proofs except the explicitly identified Dirichlet interface
probe. The exact [M4 contract](proof-plan.md#m4-research-sequence--2026-11-26)
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

## Normal prime-power columns do not supply a sum estimate

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
later absolute or modular coincidences. Normality of the finite sum T_M is
unproved. Even if proved for every fixed M, it would not place a visit before
this cutoff uniformly as M grows. For V, every target and threshold would
need such an early visit with an interior margin absorbing both approximation
error and the actual E_n, retaining the recurrence n+1 versus orbit n offset.
Individual columns, finite sums, and growing-cutoff visits are distinct claims.

The [review record](agy-reports/m4-continuation-review.md#prime-power-column-source-test--2026-11-27-utc)
retains the immutable report, source, exact synthetic checks, parent replay
and independent review. A possible insertion-valuation test has no proved
real-visitation consumer. Further work on this representation must test a
joint estimate at n of order M, rather than take a fixed-M limit and silently
transfer it to pi. V/M4 and the actual odd-carry question remain open.

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
remain open. No fixed-M normality or new Lean theorem is asserted.

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
