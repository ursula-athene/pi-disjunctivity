# Actual BBP reflected zero and coherent 2-adic prefix invariant

Research checkpoint, 2026-11-26. The reflected invariant and local/global extension passed independent review. This cycle proves on paper that the actual reflected BBP series vanishes in Q_2. Consequently every initialized weighted rational prefix is the value of one analytic isometry of Z_2, with exact pairwise valuations and no initial transient. This is an actual infinite cross-anchor identity, not a finite residue prescription. It does not prove real interval visitation. V and M4 remain open, and the parent continues the authorized research.

All universal statements here are paper arguments, not Lean exports. The parent read and reran the exact checker successfully. No pi digits were searched. The companion [avoiding models](m4-two-adic-models.md) test which of these properties alone can constrain the real orbit.

## 1. Exact coefficient domain and local isometry

Let Z_(2) denote the rationals with odd reduced denominator, embedded in Q_2, and normalize v_2(2)=1. The actual BBP coefficient has the rational identity

A(x)=4/(8x+1)−2/(8x+4)−1/(8x+5)−1/(8x+6)
    =P(x)/D(x),
P(x)=120x^2+151x+47,
D(x)=(2x+1)(4x+3)(8x+1)(8x+5).             (1)

The second expression defines A on all Z_2: every denominator factor is a unit. In particular A(n) belongs to Z_(2) for every integer n, positive or negative. The original fractions and (1) agree at every such integer.

There is more than mere compatibility modulo powers of 2. The polynomial D has odd constant term15 and all its other coefficients even. For x,y in Z_2,

[P(x)−P(y)]/(x−y)=120(x+y)+151

is odd, while [D(x)−D(y)]/(x−y) is even. These quotients are polynomial divided differences, also defined when x=y. Therefore the divided difference of A is a 2-adic unit. For x≠y,

v_2(A(x)−A(y))=v_2(x−y).                    (2)

Thus A is a 2-adic isometry. In particular A(n+2^k)≡A(n) modulo2^k, and their difference has valuation exactly k.

## 2. Analytic graph and the initially unresolved anchor

Define, for x in Z_2,

B(x)=Σ_(j≥0)16^j A(x−j).                    (3)

Every A(x−j) is integral, so this series converges uniformly: its j-th summand has valuation at least4j. It also defines an analytic function on Z_2. To see this directly, expand the four reciprocal linear factors of D(x−j) around x=0. Their constant terms are odd and their slopes divisible by2. The coefficient of degree d in A(x−j) has valuation at least max(0,d−2), uniformly in j. Multiplication by16^j and summation gives convergent power-series coefficients with the same bound, tending to zero as d increases. The joint bound justifies the required coefficient summations.

Reindexing the convergent series gives

B(x)=A(x)+16B(x−1).                         (4)

Moreover, after dividing B(x)−B(y) by x−y, its first summand is the unit supplied by (2), and every remaining summand is divisible by16. Hence

v_2(B(x)−B(y))=v_2(x−y)  for x≠y.           (5)

For the actual weighted prefix, set S_(−1)=0 and

S_n=Σ_(j=0)^n16^(n−j) A(j),  n≥0.

From (4), before knowing the anchor, one only obtains

S_n=B(n)−16^(n+1)B(−1).                     (6)

A generic forcing with odd denominators has an eventual local graph of this kind. The new actual identity is B(−1)=0, proved next; it removes the transient term exactly.

## 3. Rigorous reflected-zero identity

The claim is

C := Σ_(j≥0)16^j A(−1−j)=0 in Q_2.          (7)

Work in the complete quadratic extension K=Q_2(t), with t^2=2 and v_2(t)=1/2. Define the formal series

L(z)=Σ_(m≥1)(−1)^(m+1) z^m/m,
T(z)=Σ_(m≥0)(−1)^m z^(2m+1)/(2m+1).

They are the zero-constant formal logarithm log(1+z) and arctangent. At every argument used below, valuation is at least1, so the series converge. For L this follows from m v_2(z)−v_2(m)→∞; for T, the odd denominators have valuation0. No complex logarithm or arctangent branch is being chosen.

Write H_r(u)=Σ_(j≥0)u^(8j+r)/(8j+r). Direct substitution into the original four terms gives

A(−1−j)=−4/(8j+7)+2/(8j+4)+1/(8j+3)+1/(8j+2),
C=[H_2(t)+H_4(t)]/2 + t[H_3(t)−H_7(t)]/4.  (8)

Here t^8=16. The right side is the value at u=t of the zero-constant formal primitive of

R(u)=[(u+u^3)/2+t(u^2−u^6)/4]/(1−u^8)
    =u/[2(1−u^2)(1+u^4)] + t u^2/[4(1+u^4)].

An explicit zero-constant primitive is

Ψ(u)=−L(−u^2)/8 + L(u^4)/16
     +[L(u^2−tu)−L(u^2+tu)]/16
     +[T(u^2)+T(tu/(1−u^2))]/8.             (9)

This is a formal power-series identity over K. To verify the derivative, put Q_±=1±tu+u^2. Then Q_−Q_+=1+u^4 and

(2u−t)/Q_− − (2u+t)/Q_+
    =2t(u^2−1)/(1+u^4),
[d/du] T(tu/(1−u^2))=t(1+u^2)/(1+u^4).

Together with L'(z)=1/(1+z) and T'(z)=1/(1+z^2), these give Ψ'(u)=R(u). Both primitives have constant0, so equality of their derivatives in characteristic0 proves their formal equality.

**Specialization and convergence.** On the closed disk v_2(u)≥1/2, one has v_2(u^2)≥1, v_2(tu)≥1, v_2(u^4)≥2, and 1−u^2 is a unit. Thus every argument of L and T in (9) has valuation at least1. All displayed compositions and the primitive in (8) converge there, including u=t. The primitive notation is formal; it is not a real path integral through the real pole at u=1, and no real convergence of the reflected series is asserted.

At u=t, the four logarithm arguments are −2,4,0,4, and the two arctangent arguments are2 and−2. Therefore

C=Ψ(t)=−L(−2)/8.                            (10)

Finally the formal logarithm identity

L(X)+L(Y)=L(X+Y+XY)

can be specialized at X=Y=−2, since all the series converge there. It gives 2L(−2)=L(0)=0, hence L(−2)=0. Equations (8)–(10) prove (7).

There is an independent primary-source verification of this final cancellation: Henri Cohen, *On the 2-adic Valuations of the Truncated Polylogarithm Series*, Fibonacci Quarterly37 (1999), printed p.117, Lemma2, proves Σ_(m≥1)2^m/m=0 in Q_2 using the corresponding Li_1 functional identity. [Primary PDF](https://www.fq.math.ca/Scanned/37-2/cohen.pdf). Its printed convergence condition is v_2(z)≥1, so z=2 is included; web OCR incorrectly renders some ≥ signs as >. Locally `/tmp/pi-m4-cohen-polylog-source.pdf`, SHA-256 `70e56e27e1ed2b6ccc74fc1ad7ea8c49172c1682af5520238c07964b942f3335`; the page was visually checked at `/tmp/pi-m4-cohen-reflection-page-1.png`. Cohen's lemma supports the final logarithm value, not the full BBP reflection identity or visitation.

## 4. Exact initialized-prefix consequences

Combining (6)–(7),

S_n=B(n) for every n≥0.                     (11)

These are equalities in Q_2 of the actual rational prefixes, not approximations. From (5), for distinct m,n≥0,

v_2(S_m−S_n)=v_2(m−n).                      (12)

Since B(−1)=0, one also obtains the exact valuation

v_2(S_n)=v_2(n+1),  n≥0.                    (13)

For every k≥0 and n≥0,

v_2(S_(n+2^k)−S_n)=k.                       (14)

In particular the residue sequence S_n modulo2^k has least period2^k from the first index, with no transient. Each block of2^k consecutive indices represents every residue exactly once. Injectivity of a residue block follows from (12), and its cardinality is2^k. The compatible inverse residue permutations also show that B maps Z_2 onto itself.

A second exact rational consequence concerns the finite reflected sum

R_M=Σ_(j=0)^(M−1)16^j A(−1−j),  M≥1.

Splitting the convergent series (7) gives

R_M=−16^M B(−M−1),
v_2(R_M)=4M+v_2(M).                         (15)

These conclusions retain dependence across all indices and all powers of2 simultaneously. No real normality or digit frequency is inferred from the complete local residue cycles.

## 5. A separating model calculation and the real-word consumer

The parent supplied a rational diagnostic with

r(x)=(x+c)/[(2x+1)(4x+1)(8x+1)],  c=424/2159,
g(x)=16r(x)−r(x+1).

For this comparison only, its exact relevant facts are g(0)=47/15, integrality on Z_2, and a unit divided difference. The latter follows because c is even in Z_2, the numerator has slope1, and the denominator has odd constant and even remaining coefficients. The term −r(x+1) dominates16r(x) in the divided difference of g. Thus the compatibility/isometry property alone does not select the actual coefficient function.

But direct 2-adic telescoping gives

B_g(x)=Σ_(j≥0)16^j g(x−j)=−r(x+1),
B_g(−1)=−424/2159≠0.                        (16)

The companion [model assessment](m4-two-adic-models.md#rational-isometry-model-with-a-nonzero-anchor) supplies its real avoidance and complete-monotonicity analysis. Equation (16) is proved here from its displayed rational formula; it shows exactly which new actual identity the model lacks. This is not a claim that reflected zero alone implies visitation, nor a full countermodel to all the new lemmas.

The actual real consumer remains

y_(n+1)=fract(S_n),
∀0≤a<b≤1, ∀N, ∃n≥N, a<fract(S_n)<b.

Equations (11)–(15) constrain the Q_2 images of the same rational S_n. A real forbidden word constrains their real fractional parts. The floor operation separating S_n into its integer part and its fractional part has not been related to the analytic graph (3). In particular no continuity, finite-state rule, or automaticity of the carries follows from the present argument.

There is no pointwise incompatibility between these two kinds of data. Given any real open interval I and any residue a modulo2^k, choose an odd positive q with q·length(I)>2^k and an integer p≡aq modulo2^k inside qI. Then p/q lies in I∩Z_(2) with the required residue. This elementary observation only identifies the missing pointwise bridge; it is not an infinite model preserving the actual A or its analytic graph.

No solenoid, adelic equidistribution, or automatic-sequence theorem is invoked without a verified hypothesis connecting the real floor/carry process to this graph. The output of this cycle is the proved positive invariant, with the real-word implication still unsupported. The separately constructed [analytic model](m4-two-adic-models.md) now preserves the coherent zero anchor, irrationality and exponential prefix heights while avoiding an interval. It drops the exact rational forcing, polynomial height of the individual coefficient and rationality at negative integers. Thus this positive invariant alone is insufficient; those lost restrictions identify the remaining opening.

## 6. Exact checks and status

`/tmp/pi-m4-two-adic-reflection-check-v1.py` exited0, SHA-256 `b329a79e2f0c956a41037a26df18dac3dc0d454b11220d8e2741ebe929be7f33`. It checks the derivative and endpoint algebra in Q[t]/(t^2−2), 513 coefficient identities, 256 prefix valuations, 2016 pair valuations, 128 reflected-sum valuations, complete residue tables through12 bits, reflected zero through512 bits, and the distinct nonzero reflected constant in (16). All computations use exact integers and fractions. They do not prove convergence or the infinite identity; those are the paper arguments in Sections2–3. No pi digits or real orbit searches were performed.

The exact V statement and initialization are unchanged. The checked B1–B3 results and conditional B4/P3 remain the Lean frontier; none of B4's visitation hypotheses is discharged. Independent review is complete; any selected implementation still requires ordinary kernel-checked proofs under the existing trust policy.

The positive-lemma endpoint is complete; M4 continues. The next inquiry asks whether the actual rational forcing controls odd-denominator characters well enough to transfer local residue information to real fractional parts.

## 7. Exact real characters and the missing odd correction

Write e(t)=exp(2*pi*i*t), x=P/q in lowest terms with odd q>0, and M=2^k>=2.
Let a=P*q^(-1) mod M, 0<=a<M, and b=(P-q*a)/M. Then

    x/M=a/M+b/q, gcd(b,q)=1,
    e(h*x/M)=chi_M(x)^h*C_M(x)^h,
    chi_M(x)=e(a/M), C_M(x)=e(b/q).

The correction C_M(x)^h has exact order q/gcd(q,h), unchanged in its odd
part when the dyadic scale grows. At integer real frequency h,

    e(h*S_n)=C_M(S_n)^(h*M).

The 2-adic character is trivial there. At frequency h/M, its cancellation
over a complete M-index block still has the odd correction as a weight.

The actual rational formula supplies explicit local factors. For p^v exactly
dividing q, set c_p=P*(q/p^v)^(-1) mod p^v. CRT gives
e(h*x)=product_(p|q)e(h*c_p/p^v). For any prime p=1 mod4 in (4N+3,8N+1],
its factor for 0<=n<=N is 1 before index j_p, and afterwards is

    e(h*kappa_p*16^(n-j_p)/p),
    (j_p,kappa_p)=((p-1)/8,4) for p=1 mod8,
                  ((p-5)/8,-1) for p=5 mod8.

There is exactly one pole divisible by p through N, since 2p>8N+6.
For C_M insert M^(-1) modulo p. Thus these factors use the exact four poles
and polynomial individual coefficient height, which the analytic model lacks.
Their cofactor is still coupled to them; independent cancellation is not proved.

The positive reduced prefix denominator q_N satisfies

    2N+o(N)<=log q_N<=8N+o(N).

The lower bound uses the displayed surviving primes. For the upper bound,
q_N divides the odd part of lcm(1,...,8N+6). The ordinary and fixed-progression
PNT on [Sutherland's slide 3](https://math.mit.edu/~drew/PrimeGapsOberwolfach1.pdf#page=3)
give these estimates; higher prime powers contribute o(N).

A precise near-frequency consumer keeps the floor explicitly. Put f_n=fract(S_n),
ell=h*M+1 and W_n=e(-floor(S_n)/M)*C_M(S_n)^ell. Then

    e(h*S_n)=e(-f_n/M)*chi_M(S_n)*W_n.

On a complete M-index block I, for every complex c,

    abs(M^(-1)*sum_(n in I)e(h*S_n))
      <=2*pi/M+M^(-1)*sum_(n in I)abs(W_n-c).      (16)

The constant part cancels by the exact local permutation. No useful small
variation bound for W_n is established. Its exact odd order is
q_n/gcd(q_n,ell)>=q_n/abs(ell), exponential for indices in the latter half
of a long block and fixed h. This prevents a bounded-conductor simplification;
large order alone proves neither variation nor cancellation. Using raw S_n
instead of f_n only gives a sufficient error bound 2*pi*abs(S_n)/M, useless
on a length-M positive block since S_n>=(47/15)*16^n. This is a failure of
that bound, not a lower bound on the actual phase difference.

## 8. The actual negative branch separates local and real cancellation

There is a countertest with the same four-pole function and rational values.
The reflected identity gives, for m>=1,

    X_m:=B(-m-1)
      =-sum_(l=1)^m16^(-l)*A(-(m+1-l)).

These are rational with odd reduced denominator, by the reflected valuation.
For every integer r>=1,

    0<A(-r)=(120r^2-151r+47)/
       [(2r-1)(4r-3)(8r-1)(8r-5)]<=6/r^2.

The numerator is positive and at most 120r^2; the denominator is at least
21r^4. Splitting the sum at floor(m/2) bounds the two pieces by
24/(15m^2) and (6/15)*16^(-floor(m/2)). Since m^2<=16^floor(m/2),

    -2/m^2<=X_m<0.

For m=T,...,T+M-1, these are M consecutive negative inputs of the same
isometry, hence a complete local residue cycle. Yet for every integer h,

    abs(M^(-1)*sum e(h*X_m)-1)<=4*pi*abs(h)/T^2,
    abs(C_M(X_m)^h-chi_M(X_m)^(-h))
        <=4*pi*abs(h)/(M*T^2).                  (17)

The inequalities follow from abs(e(t)-1)<=2*pi*abs(t). If M does not divide h,
the two local factor averages vanish or approach zero separately, while their
product average approaches one. Their dependence cannot be discarded.
For T>=2 all real fractional parts lie in [1-2/T^2,1), so these complete
local cycles can avoid any fixed interior interval as T grows.

This branch retains growing odd conductors as well. Each prime p=3 mod4 in
(4m,8m-1] occurs exactly once in the negative coefficient denominators: at
r=(p+1)/8 with coefficient -4/p when p=7 mod8, or at r=(p+5)/8 with coefficient
1/p when p=3 mod8. Dyadic weights cannot cancel the unique pole. Thus
v_p(X_m)=-1, and its reduced odd denominator q_m^- satisfies

    2m+o(m)<=log q_m^-<=8m+o(m).

The same PNT and odd-lcm bound apply. This excludes a local/global transfer
that ignores direction even with actual rational forcing, polynomial
coefficient heights and fresh primes. It does not refute positive-time V:
X_(m+1)=(X_m-A(-m-1))/16 is a stable backward recursion, whereas the target
uses forward multiplication by 16 and nonnegative indices. The remaining
input must use that forward evolution to control the joint correction in
(16), or the full odd-prime product by another estimate.

Frozen report/checker: `/tmp/pi-m4-local-global-character-report-v1.md` and
`/tmp/pi-m4-local-global-character-check-v1.py`. Parent inspection and execution
passed: 3,870 exact CRT/carry/conductor cases, 258 principal-part decompositions,
12,819 fresh-prime factors, 36 residue blocks and 256 negative real bounds.
Characters are checked as rational phases modulo integers, with no floating
exponential evidence or pi digit search. The universal arguments remain paper;
the complete hashes and caller evidence are in the review packet.

## 9. The full negative carry history cancels at the zero anchor

This continuation uses the same actual analytic graph B, not a changed forcing
or entry. Put K_n=floor(B(n)), f_n=B(n)-K_n and
c_n=K_(n+1)-16K_n for every integer n. For n>=0,
f_n=bbpRecurrence(n+1); the weaker open target C_odd asks for an odd c_n
at arbitrarily late n. The raw anchor B(-1)=0 precedes f_0=2/15.

Exact A and B(-1)=0 already determine every rational B(n), forward and
backward. Negative rationality is therefore not an extra independent boundary
condition. The stronger reflection result is compatibility of those values
with one bounded analytic Q_2 graph and its isometry.

The preceding backward formula and 0<A(-r)<=6 give
-2/5<B(n)<0 for n<=-2. Hence the actual canonical history is

    K_n=-1 (n<=-2), K_(-1)=0, K_0=3,
    c_n=15 (n<=-3), c_(-2)=16, c_(-1)=3.

The boundary is exact: B(-2)=-1/21, A(-1)=16/21 and
16*f_(-2)+A(-1)=16. For fixed integer n, integrality of K implies
16^M*K_(n-M) tends to zero in Q_2. Telescoping therefore gives

    K_n=sum_(j>=0)16^j*c_(n-1-j).

For n>=0 the whole portion with carry index at most -2 is

    16^(n+1)*16+15*sum_(r>=n+2)16^r
      =16^(n+2)+15*16^(n+2)/(1-16)=0 in Q_2.

Only K_n=3*16^n+sum_(j=0)^(n-1)16^(n-1-j)*c_j remains. This is the
original initialized forward recurrence, with no new positive parity relation.
At the anchor, finite reflected sums satisfy

    R_M=sum_(j<M)16^j*A(-1-j)=-16^M*B(-M-1),
    C_M=sum_(j<M)16^j*c_(-2-j)=16^M,
    R_M-C_M=-16^M*f_(-M-1).

Both sums tend to zero in Q_2; C_M grows in the real embedding. No real
zero or real convergence is inferred from this identity.

### Bounded even carries on the unchanged actual raw graph

Retain L_n=K_n for n<=0 and set L_n=2*floor(B(n)/2) for n>=1. Then
Z_n=B(n)-L_n is rational, 0<=Z_n<2 at every integer index, and

    Z_(n+1)=16*Z_n+A(n+1)-d_n,
    d_n=L_(n+1)-16*L_n.

The negative canonical history, zero anchor and initial canonical state are
unchanged. Every future d_n, n>=0, is even; indeed
d_n=2*floor((16*Z_n+A(n+1))/2) lies in {0,2,...,32}, using 0<A(n+1)<1.
At the initial transition, 16*f_0+A(1)=9266/4095 lies in (2,3), so
L_1=50, d_0=2 and Z_1=1076/4095 lies in (0,1).

Alternatively, use L_n^c=2*floor((B(n)+1)/2) for n>=1 and retain K_n
for n<=0. Then -1<=Z_n^c<1 at positive indices and |Z_n^c|<=1 everywhere.
Its future carries are even, in {-16,-14,...,16} for n>=1, with d_0=2.
No strict absolute bound is assumed at a possible odd-integer B(n).

These are decompositions of the actual raw sequence. They are not the
canonical recurrence: the first relaxes the remainder cell to [0,2), and
the second permits negative remainders. They show that the exact graph,
initialization, negative history, integrality and these boundedness conditions
alone cannot force an odd carry. The precise positive unit cell is essential.
For n>=1, Z_n=f_n if K_n is even and Z_n=1+f_n otherwise; the centered
values are f_n and f_n-1 respectively. Thus C_odd is equivalent to arbitrarily
late Z_n>=1, or Z_n^c<0. These are reformulations, not new estimates.

### A concrete continuity failure and the remaining consumer

The negative inputs n_k=-1-2^k tend to -1 in Z_2, but
f_(n_k)=B(n_k)+1 tends to 1 whereas f_(-1)=0. Likewise
c_(-2-2^k)=15 and c_(-2)=16. Since negative integers <=-2 are dense,
their fractional samples force any continuous extension to be B+1, already
inconsistent with the anchor. This failure occurs before positive avoidance
is assumed. It does not exclude regularity of a different observable under
additional proved hypotheses.

The direct reflected-carry consumer is suspended: it cancels its known input.
A new consumer must control the selected positive unit cell, or prove suitable
regularity for another observable. Generic bounded remainders and continuity
inherited from B repeat the demonstrated failure. Actual C_odd and V remain
open, with no changed Lean theorem or discharged B4/P3 premise.

The clarified frozen report is
`/tmp/pi-m4-negative-anchor-contract-20261127/report-v2.md`, SHA-256
`38b3aacd3c3f32d12c7c5c741d13c7cc5dada53dba441ae9dfd0b2b8b3a13c33`.
Parent reconstruction and unchanged-copy replay passed: initial transition,
256 negative values, 258 carries, 256 reflected partial sums, 65 geometric
cancellations, eight discontinuity witnesses and the synthetic rounding tests.
Receipt identity and all five originals were preserved. The only nonnegative
actual states tested were initialization and its first transition; synthetic
samples are not actual future prefixes. Independent criticism found no defect
and requested the explicit offset/C_odd clarification retained above. Universal
arguments and the reflected-graph input remain paper mathematics. Final
production integration review completed with no defect or new recommendation;
the continuation review record retains the exact scope and evidence limits.
