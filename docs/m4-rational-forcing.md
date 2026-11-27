# M4 continuation: rational forcing and digit restrictions

Research record, 2026-11-26. These are mathematical diagnostics, not acceptance
of M4. The exact [V contract](proof-plan.md#m4-research-sequence--2026-11-26)
remains open. No new Lean theorem is claimed here. Paper derivations, exact
rational calculations and source statements are distinguished below.

## Pole structure: a sharper separating example

Write `A(n)=bbpCoeff n`. Its simple poles and residues, as a rational function
of a real or complex variable, are

```text
pole:     -1/8   -1/2   -5/8   -3/4
residue:   1/2   -1/4   -1/8   -1/8.
```

For a fixed integer-shift orbit `beta+Z` and pole order `m`, let `c_k` be the
coefficient of `(x-(beta+k))^-m`. The finite weighted sum
`rho=sum_k 16^(-k)*c_k` vanishes for every rational function of the form
`16*T(x)-T(x+1)`: its coefficients are `16*t_k-t_(k+1)`, and reindexing cancels
the sum. Polynomial parts contribute no poles. This applies separately to
each order, including higher-order poles that might occur in T. A's four
poles lie in different shift orbits, so **A has no rational such T**.

This does not imply visitation. The following explicit model retains simple
poles, positivity, complete monotonicity, the leading term `15/(64*n^2)`,
and the absence of a rational T, while its initialized recurrence avoids an
interval at every positive index. Its weighted constant is rational, so it
does not refute a rational-or-dense dichotomy.

### Construction and positivity

For `0<=z<=1`, put

```text
Q1=2-z^2, Q3=z^2-2*z+2,
D=Q1'/Q1-Q3'/Q3=2*(z^2-4*z+2)/(Q1*Q3),
P=(1-z^8/16)*D
 =1-z-z^2/2-z^3-z^4/4-z^5/4+z^6/8,
C(n)=integral_0^1 z^(8*n)*P(z) dz.
```

Both Q1 and Q3 are at least 1. Their ratio equals 1 at both endpoints.
The uniformly convergent geometric series with ratio `z^8/16<=1/16` gives

```text
sum_(n>=0) C(n)/16^(n+1)
 = (1/16)*integral_0^1 D(z) dz = 0,       C(0)=1/105.
```

The interchange follows from bounded P and a summable geometric majorant.
The integral is the endpoint difference of `log Q1-log Q3`. In particular,
this is a null series caused by an endpoint logarithm identity, without a
rational telescoper. Null BBP formulas are also discussed in the introduction
of Barsky–Muñoz–Pérez-Marco, [*On the genesis of BBP formulas*, v4](https://arxiv.org/html/1906.09629v4)
(13 February 2023); the identity used here is proved explicitly above.

Now set

```text
t(n)=1/((8*n+1)*(8*n+5)),  f(n)=16*t(n)-t(n+1),
G(z)=(16-z^8)*(1-z^4)/4,
F(n)=(f(n)-C(n)+C(n+1))/2
    =integral_0^1 z^(8*n)*K(z) dz,
K=(G-(1-z^8)*P)/2
 =G/2*(1-(1+z^4)*D/4).
```

The inequality `D<=1` follows from
`Q1*Q3-2*(z^2-4*z+2)=z*(4-2*z+z^2*(2-z))>=0`.
Since `1+z^4<=2`, we have `K>=G/4>=0`, strictly positive for `z<1`.
Thus F is positive and decreasing on the natural numbers. In fact

```text
(-1)^j Delta^j F(n)
 =integral_0^1 z^(8*n)*(1-z^8)^j*K(z) dz >=0.
```

The real-variable rational extension on `[0,infinity)` is completely monotone
as well: its j-th signed derivative is the moment with additional factor
`(-8*log z)^j`. Bounded K and integrability of every logarithmic power near
zero justify differentiation; alternatively use the finite polynomial K.

For comparison, the original A has positive moment kernel
`P_A=4-2*z^3-z^4-z^5=(1-z)*(4+4*z+4*z^2+2*z^3+z^4)`.
The simpler telescoping model f already has four simple poles, these positivity
properties and the same leading asymptotic; its initialized recurrence is
exactly `1/5-t(n)`. F tests the additional non-telescoping condition.

### Residues and exact avoidance

The nonzero coefficients in `F(n)=sum_r c_r/(8*n+r)` are

```text
r:   1    2    3    4     5     6      7     9    10    11    12    14     15
c:  3/2  1/2  1/4  1/2 -15/8  1/8  -1/16  3/8 -1/2  -1/4  -1/2  -1/8   1/16.
```

All thirteen poles are simple and negative. The identities `sum c_r=0` and
`sum r*c_r=-15` imply `F(n)=15/(64*n^2)+O(n^-3)`.
At `beta=-1/8`, the weighted residue is
`3/16+16*(3/64)=15/16`, nonzero. Thus F also has no rational T.

Absolute convergence, the null identity, and telescoping f give

```text
q=sum_(n>=0) F(n)/16^(n+1)
 =t(0)/2-C(0)/2=2/21.
```

Let `v(0)=0` and `v(n+1)=fract(16*v(n)+F(n))`. Finite-prefix induction and
the convergent tail split yield, for every `n>=0`,

```text
v(n+1)=fract(16^(n+1)*q-E_n),
E_n=sum_(r>=0) F(n+r+1)/16^(r+1),
0<E_n<=F(1)/15<1/150,
F(1)=6341446/66927861<1/10.
```

The phase `fract(16^(n+1)*q)` cycles through `11/21,8/21,2/21` because
`16^3=1 mod 21`. Subtracting E never crosses zero, including at n=0:
`2/21-1/150=31/350`. Therefore

```text
31/350 < v(n+1) < 11/21 < 3/4       for every n>=0.
```

This disproves the proposed inference from those structural properties to V.
The recurrence tends toward a period-three cycle; it is not claimed to be
exactly periodic. With the project's `16^-n` series normalization, its constant
is `16*q=32/21`, still rational. Adding irrationality excludes this model but
leaves the original infinite proper limit-set question unresolved.

### Representation change that preserves the actual constant

There is an exact identity

```text
P_A-2*P=(4-z^4)*(z^2+2*z+2)/4,
(P_A-2*P)/(1-z^8/16)=4/(z^2-2*z+2).
```

Hence `A-2*C` represents the same pi, with a pure arctangent integral. This is
also visible in the checked primitive in
[Series.lean](../PiDisjunctivity/BBP/Series.lean): the two logarithm terms cancel
at the endpoints. The new positive moment kernel takes value `15/4` at z=1,
so its leading coefficient is `15/(32*n)`, instead of A's order `n^-2`.
More generally `A+lambda*C`, for rational lambda, changes local coefficient
features while retaining the weighted constant. Vanishing tails and interior
margins preserve equivalence of late interval visitation to the same pi orbit.
This is a diagnostic representation change, not an implemented replacement of A.

### Verification and criticism

The worker's immutable report is `/tmp/pi-m4-simple-poles-report-v1.md`.
The standard-library exact-rational checker
`/tmp/pi-m4-simple-poles-check-v1.py` has SHA-256
`170956ba98f054c4830094db1d0231be93e7feef5297ab6b772ac3b7a72a206f`.
Worker and parent runs exited 0. It checks polynomial identities, coefficients,
residues, moment values, phase and tail constants, and twelve finite recurrence
cases. The universal avoidance proof is the preceding tail argument, not those
finite cases. Analytic convergence and the pole obstruction are paper proofs,
not kernel checks. No production Lean or audit was changed.

The scoped `pi-argument-critic` pass identifies the first false inference as
“nonzero weighted shift residue supplies visitation.” F separates the two
claims. This same-session criticism is distinct from independent review.

## G-function connection: exact side conditions and a separating word

Lagarias, [*On the Normality of Arithmetical Constants*, v2, Section 5](https://arxiv.org/html/math/0101055v2),
Theorems 5.1–5.3, supplies the relevant source connection: rational coefficient
functions with rational linear denominator factors yield G-functions; with
distinct factors, the stated rational-point special values are rational or
transcendental. These conclusions classify values, not their orbit support.

For `H(z)=sum_(n>=0) A(n)*z^n`, the local checked
`hasSum_bbpCoeff` is precisely convergence at `z=1/16` to pi. Its four rational
linear factors fit that source class. A G-function API and its arithmetic
growth/denominator hypotheses have not been formalized here; no imported
source theorem is treated as a Lean declaration.
The further premise `H notin Q(z)` follows on paper: a rational function over Q
that is analytic at the rational point `1/16` has a rational value there, whereas
the checked series has value pi, which is irrational. Any removable denominator
zero is canceled before evaluating. Thus this premise is not another open gap.

The `paper-to-lean-contract` extraction of Fischler–Rivoal,
[*Rational approximation to values of G-functions, and their expansions in
integer bases*, v2](https://arxiv.org/html/1512.06534v2), is:

| Source | Exact contract needed here |
| --- | --- |
| Theorem 2 | F is a G-function with rational Taylor coefficients, `F notin Q(z)`, `t>=0`. Effective positive `c1,c2,c3,c4` depend on F, with c3 also depending on t. Integers `a!=0`, `b,B>=1` satisfy `b>(c1*abs(a))^c2`, `B<=b^t`. Then F(a/b) is irrational and, for integer p and `m>=c3*log(b)/log(abs(a)+1)`, the error from `p/(B*b^m)` is at least `1/(B*b^m*(abs(a)+1)^(c4*m))`. |
| Theorem 3 | F as above, `eps>0`, integer `a!=0`, base `b>=2`. For `s>=1` with `b^s` sufficiently large depending on F, eps, a, every block length `t>=1` satisfies `limsup N_b(F(a/b^s),t,n)/n <= eps/t`; N counts consecutive copies of the length-t block starting at position n. |

**Initial application gaps:** the source's threshold was not verified at
`a=1,b=16` for H. The later threshold calculation below proves that its explicit
sufficient constants fail throughout the pure radix-rescaling family. The second
gap is logically separate: even the stronger repetition conclusion below does
not imply V. Both are mathematical applicability issues, not compiler failures.
No claim of an exhaustive literature result about pi is made.

Here is a self-contained separating example. Let the binary Thue–Morse word
be defined by `t_0=0`, `t_(2n)=t_n`, `t_(2n+1)=1-t_n`. It has no cube XXX:

1. No three adjacent symbols agree, since any length-three block contains an
   aligned complementary pair. No alternating length-five block occurs either:
   its three symbols of the starting parity would give three equal consecutive
   symbols at half the indices, contradicting the first observation.
2. An odd-period cube of period p>=3 forces every adjacent pair in its first
   2p symbols to differ. Indeed, equality of such a pair repeats p places later;
   one of the two starts is even, contradicting an aligned complementary pair.
   This gives an alternating length-five block. Period 1 was already excluded.
3. An even-period cube of period 2q gives a cube of period q by reading its
   even-indexed symbols. Repeated halving reduces to an excluded odd period.

Define `xi=sum_(j>=0) (1+t_j)/16^(j+1)`. Every shifted hexadecimal tail lies
in `[1/15,2/15]`, by comparison with the geometric sums with constant digits
1 and 2. There is no expansion ambiguity. The cube-free word is not eventually
periodic, so xi is irrational. For every fixed block length and position,
`N_16(xi,t,n)<=2`; consequently the normalized repetition limsup is zero.
Nevertheless xi's entire orbit avoids `(1/4,3/4)`. Also, for every integer p
and `m>=0`,

```text
abs(xi-p/16^m) >= (1/15)*16^(-m).
```

This follows by scaling and the same fractional-tail interval. It concerns
denominators `16^m` only (B=1), not the source's complete family of B.
The example separates the repetition conclusion and this restricted
approximation bound from visitation; it is not asserted to be a G-function
value or to satisfy the actual BBP forcing. Thus it does not refute the source
theorem. The argument-critic pass retains both application gaps above.

## Next discriminating inquiry

This heading records the earlier inquiry, whose Fourier test is now complete;
read the later sections and current research log for continuation.

The pole test changed the question: a useful mechanism must survive null-BBP
changes or justify why one representative proves a property of the shared
constant. Test a concrete finite-frequency cancellation step for the
pure-arctangent representative against F. For F, frequency 21 gives normalized
exponential sums tending to 1: with
`S_n^(g)=sum_(j=0)^n 16^(n-j)*g(j)` and
`W_M^(g)(h)=(1/M)*sum_(n<M) exp(2*pi*i*h*S_n^(g))`, the phase at h=21
for F equals `exp(-2*pi*i*21*E_n)`, tending to 1, so its Cesaro mean does too.
A positive-kernel argument alone therefore cannot supply the required
cancellation. A separate solved-neighbor comparison is testing the long
fixed-modulus windows used for Stoneham constants against BBP prefix tails.
The intended diagnostic uses finitely many frequencies for one interval;
vanishing of W at every nonzero frequency would seek equidistribution, a
stronger conclusion than V, and is not an added milestone requirement.
Neither next inquiry is an established estimate or an additional premise of V.

## Explicit G-function thresholds and the full fixed-multiplier comparison

The later source check resolves the earlier threshold uncertainty for two
specified representations. In the [Fischler–Rivoal author PDF](https://rivoal.perso.math.cnrs.fr/articles/approxG.pdf),
Theorem 2, p.3, retains the contract above. Sections 2.1–2.2 and 3.2,
pp.6,8,13, construct its constants as follows. N>=1 is the least inhomogeneous
differential order of F; the system includes 1,F,F',...,F^(N-1).
An integer polynomial Dcal clears the system, d bounds its degree and the
cleared matrix degrees, C bounds Taylor coefficients by C^(n+1), and D
bounds positive integer coefficient-clearing factors by D^(n+1). Thus

```text
C,D>=1, height(Dcal)>=1, d>=1,
c1=4*height(Dcal)*(C*D)^(8*N*d+1)*C, c2=3*(N+2),
c1>=4*C^10, c2>=9.
```

If d were zero the cleared system matrix would vanish, forcing F constant;
this is excluded. The parent checked the displayed source theorem, coefficient
bounds and constants in rendered pages, rather than treating unspecified
effective constants as small.

For s>=1 put H_s(z)=H(16^(s-1)z). Then H_s(16^-s)=pi. The actual rational
coefficient has A(n)~15/(64n^2), so every permissible C for H_s satisfies
C>=16^(s-1), by taking nth roots of its Taylor coefficient bound. Therefore

```text
c1^c2 >=4^9*16^(90(s-1))>16^s.
```

The power-of-two exponent margin is 356s-342>0. The sufficient condition
`b>(c1*abs(a))^c2` fails at a=1,b=16^s for every s, independently of the
choice of admissible coefficient/system bounds in this construction. An
unreduced input a=k,b=k*16^s cannot help: k^c2>=k for k>=1.

One different identity was tested jointly, rather than estimating summands
separately. Machin's identity is pi=16*atan(1/5)-4*atan(1/239).
For theta=atan(1/5), phi=atan(1/239), tangent addition gives tan(2theta)=5/12,
tan(4theta)=120/119 and tan(4theta-phi)=1. The bounds
atan(1/5)>5/26, atan(1/239)<1/239 and 4theta<4/5<pi/2 fix the branch.
For Q=16^s let

```text
G_s(z)=16*atan(Q*z/5)-4*atan(Q*z/239), G_s(1/Q)=pi.
```

Its odd Taylor coefficient has root limsup Q/5; the smaller exponential
term cannot cancel that growth. The rational derivative gives N=1, and
nonrationality follows from its irrational value at the analytic rational
point 1/Q. Every permitted C is at least Q/5, so
`c1^c2>=4^9*(Q/5)^90>Q` for Q>=16. This alternative also fails the explicit
sufficient threshold. These failures do not rule out smaller constants proved
by another argument, other representations, or the conclusion at pi itself.

There is also a stronger separating statement for the same cube-free xi
above. For every integer B>=1, m>=0 and p in Z,

```text
abs(xi-p/(B*16^m)) >=16^(-m-3B)/15.
```

To prove it, compare a shifted tail x of xi with j/B. Outside 0<=j<B its
distance is at least 1/15. Inside, long division has at most B remainder
states; a repeated state gives preperiod u and period v>=1 with u+v<=B.
The rational expansion has a cube within its first u+3v<=3B digits,
including terminating rationals with the eventual zero period. It therefore
differs from x at some first position k<=3B. After removal of the common
prefix, 16^k times the difference is a nonzero integer digit difference
plus X-R, where X is in [1/15,2/15] and R in [0,1]. Its magnitude is at
least 1/15. Finally use j=p-B*floor(16^m*xi) and divide by 16^m.

For every fixed finite cutoff M, the bound is uniform over B<=M, with
constant 16^(-3M)/15. It eventually dominates the qualitative bound
`1/(B*16^m*2^(c*m))` for any fixed c>0. Constants deteriorate with M;
no B-independent threshold or the source's particular dependence on t is
asserted. Thus these fixed-multiplier approximation conclusions alone still
do not imply visits. No G-function membership of xi is claimed.

Report `/tmp/pi-m4-gfunction-gap-report-v1.md`, SHA-256
`b645e11065eac9d40063bed0662a669fc8fe5549ce9762d8a4e2f27ad633ab4e`;
checker `/tmp/pi-m4-gfunction-gap-check-v2.py`, SHA-256
`5453713afaf09bd8f0542e6a0cf41bfe29749ccec9b9b4c079ac0e7ddd6479dd`.
The parent read and ran it, exit 0: 256 coefficient identities, 128 cases
of each scaling threshold, exact Machin tangent identities and 33,792
rational-grid interval cases. The universal arguments remain paper proofs.
The primary PDF hash is
`b3bf93c879ff9a13898140b936fb1cf5b6facbe0cc6a0d085f3540ad088d8800`.

## Every finite tail jet permits a rational avoiding model

The quantifiers matter: **for each finite K>=1 there is a separate forcing
g_K**. It is positive, strictly completely monotone, rational with simple
negative eighth-grid poles, has the actual g_K(0)=47/15 and initialization
y_0=0, and satisfies g_K(n)-A(n)=O(n^(-K-2)). Yet its weighted constant is
51/16 and every y_(n+1) misses (1/4,3/4). It does not preserve irrationality,
the exact four-pole function, or every asymptotic order in a single example.

Here is the construction, using the actual BBP kernel
P_A(t)=4-2t^3-t^4-t^5 (rather than the earlier null-series polynomial P). Set

```text
Rstar(t)=P_A(t)/(16-t^8)=(1-t)/[(2-t^2)*(t^2-2t+2)],
z=1-t, Rstar(t)=z*Q(z), Q(z)=1/[(1+2z-z^2)*(1+z^2)].
```

Let q(z) be Q's Taylor polynomial of degree K-1. It has rational
coefficients and q(0)=1. There is a positive rational M with
q(z)+M*z^K>0 on [0,1]. Explicitly let S be the sum of the absolute
coefficients, delta=1/[2(S+1)] and M=(S+1)*delta^(-K). For z<=delta,
q(z)>1/2; for z>=delta, q>=-S and M*z^K>=S+1. Thus
R0(t)=(1-t)*(q(1-t)+M*(1-t)^K) is positive before t=1 and matches
Rstar through endpoint derivative order K.

For m>=1 multiply by the positive polynomial

```text
C_(m,K)(t)=t^m*sum_(j=0)^(K-1) binomial(m+j-1,j)*(1-t)^j.
```

It lies in [0,1], by the full binomial series, and equals
1+O((1-t)^K) near1. It tends to zero at each t<1 as m grows, because its
coefficients grow polynomially in m while t^m decays geometrically.
Consequently R0*C_(m,K) preserves the chosen jet and its two moments
I0=integral R0*C_(m,K) and I8=integral t^8*R0*C_(m,K) tend to zero.
Dominated convergence uses the fixed bounded R0; no uniformity in K is needed.

Prescribe tau=51/256 and tau1=13/240, so rho=tau1/tau=208/765.
For B_J(t)=t^J*(1-t)^(K+1), beta integration gives

```text
mu_J=(integral t^8*B_J)/(integral B_J)
    =product_(i=1)^8 (J+i)/(J+K+2+i).
```

We have mu_0=1/binomial(K+10,8)<=1/165<rho/2 and mu_J tends to1.
Choose J with mu_J>2rho and then m with I0<tau/100 and I8<tau1/100.
The remaining moment ratio (tau1-I8)/(tau-I0) lies strictly between
mu_0 and mu_J. Positive rational a,b therefore solve

```text
a*integral B_0+b*integral B_J=tau-I0,
a*integral t^8*B_0+b*integral t^8*B_J=tau1-I8.
```

Their positivity follows by assigning mass
`[(tau1-I8)-mu_0*(tau-I0)]/(mu_J-mu_0)` to B_J and the remaining mass
to B_0. Divide by the respective positive integrals. The polynomial
R=R0*C_(m,K)+a*B_0+b*B_J is positive on [0,1), matches Rstar's jet
through order K, and has exactly the two prescribed rational moments.

Define

```text
r(x)=integral_0^1 t^(8x)*R(t) dt,
g_K(x)=16*r(x)-r(x+1)=integral_0^1 t^(8x)*(16-t^8)*R(t) dt.
```

Polynomial expansion expresses these functions as finite rational sums of
1/(8x+j+1). Thus every noncanceled pole is simple and negative. Differentiating
under the integral yields (-1)^ell*g_K^(ell)(x)>0 for every ell and x>=0;
all needed logarithmic powers are integrable. Also g_K(0)=16tau-tau1=47/15.
The kernel difference from P_A(t) vanishes to order K+1 at1, so some C_K gives

```text
abs(g_K(n)-A(n))
 <=C_K*(K+1)!/product_(j=1)^(K+2)(8n+j).
```

This beta-integral bound proves the claimed asymptotic matching. Finite
telescoping, with c=51/16, gives

```text
sum_(j=0)^n g_K(j)/16^j=c-r(n+1)/16^n,
y_(n+1)=fract(16^n*c-r(n+1)).
```

At n=0 the state is exactly2/15. For n>=1 the first term inside the
fractional part is integral and 0<r(n+1)<r(1)=tau1, hence
y_(n+1)=1-r(n+1)>227/240>3/4. The weighted constant is c and all states
avoid (1/4,3/4). This strengthens the finite-order diagnostics without
excluding a future argument that also uses exact global arithmetic or
irrationality. In particular it does not refute the weak dichotomy.

Report `/tmp/pi-m4-finite-jet-report-v1.md`, SHA-256
`5291b4e375954e793ddaf0c3f46586360d712a48c4790713fc98bae0ce76576f`;
checker `/tmp/pi-m4-finite-jet-check-v1.py`, SHA-256
`f5f1e648d98440195ff3078abe2af9f52ac001fc10de21aae125a42a5fcaf1d5`.
The parent exact run passed K=1,...,8, with both moments, endpoint jets,
initial coefficient, telescoping and 33 recurrence steps per K. Independent
sketch review found no D/I/Q defect; integration review remains separate.
The combined integration review subsequently resolved one kernel-name collision
by using P_A consistently; no other findings remain. All universal results in
this section remain paper mathematics, not Lean exports.

## Positive filters and uniformly close eight-pole models

The actual positive density P_A(t)=4-2t^3-t^4-t^5 permits a concrete
avoidance-dependent test. Rotate a strict inner missing interval so that
x_n=fract(S_n-c) lies in a closed interval of length L<1, and retain
z_n=floor(S_n-c). For the shift E and integer h>=1, put
W_h(u)=(u-16)*(1-u)^h. The exact recurrence gives

    W_h(E)x_n=mu_(n,h)-C_(n,h),  C_(n,h)=W_h(E)z_n in Z,
    mu_(n,h)=integral_0^1 t^(8(n+1))*(1-t^8)^h*P_A(t) dt>0.

The rotation cancels because W_h(1)=0. Its coefficient norm is 17*2^h,
so interval membership supplies only |W_h(E)x_n|<=17*2^(h-1)*L.
For fixed h, mu tends to zero. If 17*2^(h-1)*L<1 this forces C=0
eventually, making the bounded integer carries z_(n+1)-16*z_n eventually
constant. Then lim 16^(-n)*z_n=pi would be rational. This is only the
generic exclusion of a very short allowed arc, strongest at L<1/17;
it is not an arbitrary-interval visitation proof.

Degree cannot improve this particular range certificate. Every nonzero
integer W with W(1)=W(16)=0 has coefficient norm at least 34. Remove
initial zero coefficients and make the constant positive. It is a nonzero
multiple of 16; balance at 16 requires another positive coefficient, so
the positive mass is at least 17. Balance at 1 gives equal negative mass.
Thus the norm-based bound is always at least 17L. This limits the
certificate, not the actual filtered value. The positive rational toy
c(n)=[16*r(n)-r(n+1)]/2040, r(n)=1/(n+1)-1/(n+2), has actual carries
alternating 0,1 and limiting phases 1/255,16/255, at distance 1/17.
Strict moment positivity does not remove that persistent integer variation.

A quantitative perturbation preserves the whole moment-sign hierarchy.
For each fixed integer H>=1 define

    r_H(n)=sum_(j=0)^(H-1)16^(-j-1)*A(n+j),
    c_H(n)=16*r_H(n)-r_H(n+1)=A(n)-16^(-H)*A(n+H).

Its density is P_H(t)=P_A(t)*(1-16^(-H)*t^(8H)), between
(1-16^(-H))*P_A and P_A everywhere. Consequently every signed finite
difference obeys the same multiplicative bounds, simultaneously in its
order and index. For every Hankel Gram determinant of size m,

    (1-16^(-H))^m*det[A(n+i+j)]
       <=det[c_H(n+i+j)]<=det[A(n+i+j)],

and the determinants are positive. The integral of a squared Vandermonde
against the product of the positive densities proves this directly.

There are exactly eight simple poles, in the same four integer-shift
classes as A: each original pole alpha has its remote partner alpha-H
with residue -16^(-H) times the original residue. Their weighted residues
cancel exactly. An exponentially small remote residue can therefore change
the non-telescoping invariant while preserving every stated positivity bound.
The actual A support, nonzero invariants and irrational period are not retained.

The period Pi_H=sum_(j<H)16^(-j)*A(j)=a_H/b_H is positive rational, and
S_n^(c_H)=16^n*Pi_H-r_H(n+1). Its reduced denominator satisfies
b_H=16^(H-1)*q_(H-1)/2^(v_2(H)), hence
log b_H=(6+log16)*H+o(H). For n>=b_H, the positive tail is less than
1/(3*b_H). The actual floor is floor(16^n*Pi_H)-1 when its homogeneous
fractional part is zero, and floor(16^n*Pi_H) otherwise. Thus the actual
orbit avoids (1/(3*b_H),2/(3*b_H)) eventually, with eventually periodic
integer carries. The interval depends on H. For each fixed H its forward
denominator has logarithm O_H(log(n+2)), rather than A's exponent 6.
Taking H depending on n would not be a single rational-forcing countermodel.
The expanding prefix error is at most
16^(-H)*A(H)*(16^(n+1)-1)/15, so this family does not transfer avoidance to A.

Frozen packet `/tmp/pi-m4-positive-kernel-20261127/`, report SHA-256
`8338a67b831af7dba5201653b4b0ab9cc627ac0720f0dc355a4dfc5769078df3`,
retains the full proof, actual toy carries, checker and separate criticism.
Parent reconstruction and unchanged-copy replay passed; the receipt differs
only in UTC, with originals preserved. The first replay harness expected a
file where the checker prints JSON; corrected capture retained exit 0 on
the single repeated run. This was a harness issue, not a mathematical failure.
The generic positivity route is suspended at its exact carry obstruction.
Combining positivity with the actual denominator rate is a separate question;
no V or new Lean theorem follows from these comparisons.

## Gaussian moment models match an exact BBP prefix

The positive moment representation admits finite models with exact prefix
agreement, a different property from uniform coefficient approximation.
Set P(x)=4-2x^3-x^4-x^5. Under t=x^8 the actual moments are

    A(n)=integral_0^1 t^n dmu(t),
    dmu(t)=P(t^(1/8))/(8*t^(7/8)) dt, mu([0,1])=47/15.

The factorization P(x)=(1-x)(4+4x+4x^2+2x^3+x^4) makes mu positive on
(0,1). Its monic orthogonal polynomial Q_m has rational coefficients, since
its Hankel system has rational entries and is positive definite. Its m roots
t_i are distinct and lie in (0,1). Positive Gaussian weights w_i match moments
through degree 2m-1. This is the applicable classical quadrature statement in
[Allen et al., Theorem 1, printed pp. 65–66](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/133CD9E0E6960B585002005424549ADA/S0004972700043641a.pdf/pade-approximation-and-gaussian-quadrature.pdf).
The source lists denominator degree first; its [m,m-1] convention and inverted
Stieltjes variable are retained. It supplies no visitation estimate.

Define A_m(n)=sum_i w_i*t_i^n. This is positive and completely monotone.
The recurrence given by Q_m and rational initial moments makes every A_m(n)
rational, although the nodes and weights need not be rational individually.
It is not in general a rational function of n. Put

    F(z)=integral dmu(t)/(z-t),
    P_(m-1)(z)=integral (Q_m(z)-Q_m(t))/(z-t) dmu(t).

Then P_(m-1) has rational coefficients and Gaussian exactness gives
F_m(z)=sum_i w_i/(z-t_i)=P_(m-1)(z)/Q_m(z). Orthogonality also proves

    F(z)-F_m(z)=Q_m(z)^(-2)*integral Q_m(t)^2/(z-t) dmu(t).

Consequently the compressed period Pi_m=16*P_(m-1)(16)/Q_m(16) is rational,
and delta_m=pi-Pi_m is strictly positive. Comparing the monic norm with the
shifted Chebyshev polynomial and using Q_m(16)>15^m gives

    0<delta_m<3008/(225*3600^m).

The Laurent expansion of the squared-polynomial identity has positive
coefficients after its first nonzero term: A_m(n)=A(n) for n<2m and
A_m(n)<A(n) for n>=2m. The first error is integral Q_m^2 dmu>0.
For the same zero-initialized inclusive prefixes this yields

    S_n^(m)=S_n                              (0<=n<2m),
    0<S_n-S_n^(m)<16^n*delta_m              (n>=2m).

Thus for n<=floor(11m/4), their circle distance is at most
(3008/225)*(128/225)^m, tending to zero with m. This extends a controlled
comparison beyond the exact prefix but does not supply a visit.

The valid consumer is: for every target and threshold N, find m>=1 and
N<=n<2m with fract(S_n^(m)) in the target. This is equivalent to V by exact
prefix agreement; it requires an independent early-window estimate from the
model's arithmetic. A variant can use the longer comparison window with a
strict inner target and error below its margin. Neither estimate is proved.

For each fixed m, however,

    S_n^(m)=16^n*Pi_m-sum_i w_i*t_i^(n+1)/(16-t_i).

The error tends to zero geometrically and Pi_m is rational, so this model has
a finite omega set. A fixed finite family cannot supply universal late visits.
Its period differs irrationally from pi, so the rational-entry bridge does
not identify the two global visitation problems. This negative result does
not refute the valid growing-order consumer. The model also loses A's n^-2
decay and denominator-exponent-six theorem.

The frozen `/tmp/pi-m4-fresh-mechanism-reset-20261127/` report has SHA-256
`519effa153b074ed464adb4639674a5e787c6fb7946377ae1e870e7a8980fe33`,
and its manifest has SHA-256
`407600f3baa13fe626ef1b10dae825c4b6133d4e821d9a13eb0e1b9efb14995e`.
The parent reconstructed the full argument, inspected both rendered source
pages and replayed the unchanged checker: 444 exact checks, exit 0, identical
JSON receipt, originals preserved. For m=1..8, denominator-only checks exclude
a full rational period within 2m; they imply no general order bound or visit.
No actual initialized fractional state, pi digit or new Lean theorem is used.

## Analytic moment perturbations can have an irrational nondense period

A stronger countertest keeps rational moments, an arbitrary fixed BBP prefix,
positive moment comparisons and the leading tail constants, while allowing
an irrational nondense period. Its missing arithmetic hypotheses are explicit:
it does not retain a rational function of n or a denominator growth bound.

Use the preceding actual measure mu_A and put dnu=(1-t)dmu_A. Its moments
A(n)-A(n+1) are rational. Let R_k be its monic rational orthogonal polynomial,
with R_0=1, and set

    beta_k=16*integral R_k(t)/(16-t) dnu(t)
          =16/R_k(16)*integral R_k(t)^2/(16-t) dnu(t)>0.

The identity follows from orthogonality to a polynomial of degree k-1;
R_k(16)>0 since its roots lie in (0,1). Fix a prefix length L>=0 and rational
0<epsilon<1. For R_k(z)=sum_j r_kj*z^j choose rational budgets

    M_k=3*sum_j |r_kj|*2^j,
    b_k=epsilon*2^(-(k-L+2))/M_k, k>=L.

Any rational choices |c_k|<=b_k give absolute uniform convergence on |z|<=2
of f(z)=sum_(k>=L)c_k*R_k(z). The relative multiplier h(z)=(1-z)f(z) is
holomorphic on |z|<2, real on [0,1], has h(1)=0 and |h|<=epsilon/2.
Thus dmu_tilde=(1+h)dmu_A is positive with the same support. It is the
relative multiplier that is analytic; the Lebesgue density retains its
original t^(-7/8) endpoint singularity.

Orthogonality makes each modified moment a finite rational expression:

    A_tilde(n)=A(n)+sum_(L<=k<=n)c_k*integral t^n R_k(t) dnu(t).

All terms k>n vanish exactly. Hence every moment is rational and the first
L moments match actual A. Pointwise bounds on 1+h give uniform factors
1±epsilon/2 for every nonnegative moment test or polynomial squared norm,
and factors (1±epsilon/2)^d for d-dimensional Gram determinants.

This freedom realizes every period in a nonempty interval around pi. Put
a_k=b_k*beta_k>0; the uniform bounds imply sum a_k<infinity. Given
|delta|<=a_L/2, maintain a residual of magnitude at most a_k/2. Rational
density permits c_k in (-b_k,b_k) with the next residual smaller than
a_(k+1)/2. The residual tends to zero, so sum c_k*beta_k=delta. Uniform
convergence justifies the period interchange, giving exactly pi+delta.
These rational choices encode the prescribed real target. Their denominators
are unrestricted; this is not an effective bounded-height phase estimate.

Choose an irrational nondense target Gamma in that interval by taking the
base-16 Thue--Morse number with digits 1 and 2 and adding a suitable rational.
Its orbit lies in a finite union of translates of the closed nowhere-dense
two-digit set. No pi digit is used to make the existential selection.

The endpoint factor gives more than relative asymptotics. Since
P(x)<=15(1-x), 1-x^8<=8(1-x), and |f|<=epsilon/6,

    |A_tilde(n)-A(n)|
      <=40*epsilon/((8n+1)*(8n+2)*(8n+3)).

Thus n^2*A_tilde(n) tends to 15/64 and the positive scaled tail has limit
n^2*E_tilde(n)->1/64, by dominated convergence in its geometric sum.
The zero-initialized recurrence has the exact split
16^n*Gamma=S_tilde(n)+E_tilde(n), and matches actual S_n for n<L.
Its circle omega set is nevertheless the proper set of Gamma, so an open
interval is eventually avoided.

The infinite construction matters. Here beta_0=752/15-15*pi and
beta_k=R_k(16)*beta_0-16*P_(k-1)^nu(16), with P_(k-1)^nu rational
and P_(-1)^nu=0.
Every finite rational polynomial perturbation has period a+b*pi with rational
a,b and a finite rational-function forcing. If b!=0, its universal density
question is equivalent to V; if b=0, its period is rational. Infinite rational
coefficient sums need not retain this relation, and the separated rational
and pi components need not converge separately. This countertest cannot be
used against an argument retaining the exact finite pole structure or a
proved denominator restriction. It also does not refute the exact-prefix
Gaussian consumer; the missing early-window visit remains.

Frozen packet `/tmp/pi-m4-analytic-moment-model-20261127/`, report SHA-256
`17d1642039d404158141d7f061c119338168ac529d6ff3a87e71b1d5cf4b0e6b`,
manifest SHA-256
`bc8ad1e693a9e133af5eb0939cdf6a732e403301fdfb1afb7b44eaadf2e2ccf7`,
retains the full existential proof and separate criticism. The parent proposed
the construction and reconstructed the worker's completed argument, then
replayed an unchanged checker: 150 exact checks, exit 0, identical JSON,
originals preserved. The infinite choices are not instantiated by those checks.
No V or kernel theorem is claimed; independent review is recorded separately.

## Controlling the denominator of the moment models

The first height refinement uses integer shifted Jacobi polynomials
J_k(t)=P_k^(2,0)(2t-1) and the additive measure perturbation
sum c_k J_k(t)(1-t)^2dt. Rodrigues integration makes its period coefficients
beta_k positive, with beta_(k+1)/beta_k>=9/1024. The official
[DLMF bound 18.14.1](https://dlmf.nist.gov/18.14.E1), at alpha=2,beta=0,
gives polynomial real sup bounds; finite Chebyshev expansion supplies one
fixed complex ellipse. Rational coefficient grids with denominators dividing
3^(ceil(kappa*k)+C), for one fixed C, permit greedy period selection while
keeping the series analytic and uniformly small.

Each moment is still a finite rational sum by orthogonality. Its perturbation
denominator through n divides 3^(ceil(kappa*n)+C)*lcm(1,...,2n+3).
The natural A envelope L_A,n contains every odd integer at most 4n+3, so

    den(S_tilde(n)) divides
      3^(ceil(kappa*n)+C)*2^floor(log_2(2n+3))*L_A,n.

For any eta>0 choose kappa*log3<eta. The resulting irrational nondense model
has denominator limsup exponent below 6+eta. Actual eligible poles p>=7 with p>2n+3
survive because the perturbation is p-integral there, giving liminf at least 4.
This did not establish exact rate 6. Its relative analyticity is in x=t^(1/8),
and finite perturbation periods are pi+a+b*log(16/15), with rational a,b;
the previous rational-affine-pi equivalence does not apply to this basis.

The frozen `/tmp/pi-m4-controlled-moment-model-20261127/` report SHA-256 is
`6f363fb34c4ac00671b1bd00257ef682f4ad7cda1ec64a6b0faaeda448acf2b9`;
manifest SHA-256 is
`7668422dd73a91c11e556ca9e84a07b33e5cd9aeeb0c903da24bd6ea4376b8d2`.
Parent reconstruction, official-source hypothesis inspection and unchanged-copy
replay passed: 42,823 finite checks, exit 0, identical JSON, originals preserved.
The following different construction resolves the exact-rate limitation.

## Exact natural denominators still allow a nondense period

Return to nu=(1-t)mu_A and its monic rational orthogonal R_n. Write
h_n=integral R_n^2 dnu. Since nu>=(1-t)^2dt/16, the exact shifted Jacobi
monic norm and the monic Chebyshev upper comparison give

    16^(-n)/[256*(2n+3)] <= h_n <=16*16^(-n).

Expanding R_n in the Jacobi basis and applying Cauchy--Schwarz gives
sup_[0,1]|R_n|<=32(n+1)^3*4^(-n). The same finite Chebyshev argument yields
sup_(E_rho)|R_n|<=64(n+1)^4*(rho/4)^n. Fix rho=3/2 and rational
0<epsilon<1. With B=epsilon/512, budgets b_n=B*2^n/(n+1)^6 ensure
f=sum c_n R_n is analytic on one fixed ellipse and |(1-t)f(t)|<=epsilon/2.
This relative perturbation is analytic in t, including across its endpoints.

The previous positive period coefficients obey the explicit lower ratio

    beta_(n+1)/beta_n >= lambda_n,
    lambda_n=15*(15/16)^n/[2^24*(2n+5)].

It follows from the norm bounds and 15^n<=R_n(16)<=16^n. If the current
residual is at most beta_n*b_n/2, every coefficient in an interval centered
at residual/beta_n with halfwidth tau_n=lambda_n*b_(n+1)/4 stays within
budget and leaves the next residual below beta_(n+1)*b_(n+1)/4.

The new choice is made on the *moment* grid. Earlier coefficients determine
a rational W_n, and triangular orthogonality gives

    A_tilde(n)=W_n+c_n*h_n=z/L_A,n, z in Z.

All later basis terms vanish in this moment. Since the envelopes are nested,
M_n=16*L_A,n*S_tilde(n-1) is an integer and
S_tilde(n)=(M_n+z)/L_A,n. Its reduced denominator equals L_A,n exactly when
z avoids -M_n modulo every prime dividing L_A,n. Prime avoidance retains
the whole prime power; this does not identify the actual reduced q_n.

The admissible coefficient interval becomes an integer interval of length

    H_n >= (15B/2^32)*L_A,n*(15/128)^n
                 /[(2n+3)*(2n+5)*(n+2)^6].

Its exponential rate is at least 6+log(15/128)>0. If w_n is the number of
envelope primes, then w_n=o(n). Inclusion-exclusion gives at least
H_n*2^(-w_n)-2^w_n acceptable integers, uniformly in the interval center
and earlier choices. Thus one starting K, chosen before the target period
and beyond any prescribed finite prefix, makes every subsequent step possible.

Shrinking residuals realize every period in a nonempty interval around pi.
Selecting the earlier irrational Thue--Morse target with a rational translation
gives a nondense period. The positive analytic relative measure, O(n^-3)
moment perturbation, leading constants 15/64 and 1/64, zero initialization and
vanishing-tail transfer are retained. This proves at paper level

    den(S_tilde(n))=L_A,n for every n>=K,
    log den(S_tilde(n))/n ->6,

while the modified recurrence eventually misses an interval. The exact actual
q_n, finite rational-function forcing and prime-defect identities are absent.
No actual numerator phase or V follows from full natural denominator saturation.

The frozen `/tmp/pi-m4-exact-envelope-model-20261127/` report SHA-256 is
`af1edbea7e86adf4c84386b5c37392072271cfc230868e3b90cf03cd4c4d6593`;
manifest SHA-256 is
`a0b4437904007492eeeb5c762de4427f15a937f2c1eb3075c5a9b06a1b0effa3`.
Parent reconstruction and unchanged-copy replay passed 28,412 exact checks,
exit 0, identical JSON and preserved originals. The checker uses synthetic
sieve offsets, not actual initialized states. Infinite selection, convergence
and asymptotics remain paper arguments. The separate congruence extension and
its analytic-family limit are assessed in the prime-defect note; no new Lean
result or M4 acceptance is claimed.

## Exact coefficient recurrence retains integer rounding cost

A separate paper test uses the exact rational ratio of consecutive BBP
coefficients, which the analytic moment perturbations do not retain. Put

    N(n)=120n^2+151n+47,
    D(n)=(2n+1)(4n+3)(8n+1)(8n+5), A(n)=N(n)/D(n),
    U(n)=N(n)D(n+1), V(n)=N(n+1)D(n), Delta(n)=U(n)-V(n).

Then U(n)A(n+1)=V(n)A(n). Eliminating A from the actual first-order
recurrence, with S_-1=0, gives

    U(n)S_(n+1)-(16U(n)+V(n))S_n+16V(n)S_(n-1)=0.

The operator annihilates the homogeneous 16^n term for every seed. It
alone also permits changing the amplitude of A; the comparisons below
retain that amplitude and the full first-order forcing.

Let p_n=floor(S_n), x_n=fract(S_n), with p_-1=x_-1=0, and define
c_n=p_n-16p_(n-1). Actual p_0=3 follows from A(0)=47/15. For n>=1,
0<A(n)<1 implies c_n in {0,...,16}; the upper carry 16 is included.
The integer rounding defect is exactly

    J_n=U(n)p_(n+1)-(16U(n)+V(n))p_n+16V(n)p_(n-1)
       =U(n)c_(n+1)-V(n)c_n
       =-[U(n)x_(n+1)-(16U(n)+V(n))x_n+16V(n)x_(n-1)].

Bounded fractional parts give an order-n^6 bound, not a bounded integer.
The exact normalized telescoper

    J_n/[N(n)N(n+1)]=c_(n+1)/A(n+1)-c_n/A(n)

only returns endpoint carries when summed; it supplies no smallness of
individual residuals.

### Primitive scale and a sharp carry-pair gap

Here U~61440n^6 and Delta~122880n^5. Primitive content cannot remove this
scale. In ascending coefficient order, the integer polynomials

    B=[-22857085215,-284412609339,-964651132762,
       -1309049214024,-738024501632,-144689303040],
    C=[553387179618,2343220864395,3726673255090,
       2822476287240,1027403107712,144689303040]

satisfy B*U+C*V=M, M=143503234875. Direct polynomial multiplication
checks the certificate. Thus g_n=gcd(U(n),V(n)) divides M at every natural
n; the content of U, -(16U+V), 16V evaluated at n is exactly g_n.
This is a polynomial identity, not an extrapolation from sampled gcds.

All coefficients of Delta are positive. In ascending order the coefficients
of U(n+64)-17Delta(n+64) are

    [2285501904176274,247309497975909,10906379854150,
     252258226792,3239167424,21949952,61440].

Hence U>17Delta for n>=64. For a,b in {0,...,16},
J=Ub-Va=U(b-a)+aDelta vanishes only when a=b=0; otherwise |J|>=Delta.
If b=a>=1 this is immediate, if b>a then J>=U, and if b<a then
J<=-U+16Delta<-Delta. The pair a=b=1 attains Delta. The primitive
carry-pair gap is therefore exactly Delta/g_n, at least Delta/M. It is
not a gap for the unrestricted integer linear form.

Normalized by U, the actual residual satisfies

    J_n/U(n)=c_(n+1)-c_n+[Delta(n)/U(n)]c_n,
    Delta(n)/U(n)~2/n.

Irrationality forces c_n to change infinitely often: telescoping p gives
pi=sum_(n>=0)c_n*16^(-n), whose eventually constant tail would be rational.
At changing indices |J_n|/U(n)>=1-16Delta(n)/U(n), so

    limsup |J_n|/U(n)>=1.

An eventual O(n^5) bound on actual J_n is therefore impossible. Even after
primitive reduction, limsup |J_n/g_n|/n^6>=61440/M. These are irrationality
consequences, not new visits or restrictions on which words occur.

### Exact-forcing comparisons lose the full initialization

Extend the tail by E_-1=pi/16. Positivity and monotonicity give
0<E_n<=E_-1<1/5 for n>=-1, using pi<22/7<16/5. For rational alpha, put

    R_n=alpha*16^n-E_n, n>=-1.

Then R_n=16R_(n-1)+A(n) with exactly the original A. Its initial value
is (alpha-pi)/16, irrational and nonzero, and its raw samples are
irrational. Thus preserving the first integer floors below does not
preserve the actual fractional seed or rational raw samples.

For alpha=16/5, the fractional phase before subtracting E_n is 1/5 at
every n>=-1. Hence floor(R_n)=(16^(n+1)-1)/5 and fract(R_n)=1/5-E_n
lies in (0,1/5). The first floors are p_-1=0 and p_0=3, as for the actual
sequence, but all carries are 3. This trajectory avoids (1/3,1/2) and
has J_n=3Delta(n), J_n/U(n)~6/n->0. Small normalized defect therefore
does not select the actual seed, even with these initial integer floors.

For alpha=832/255=16*(52/255), the pre-tail phases alternate between
52/255 and 67/255, starting at 52/255 when n=-1. The identities
16*(52/255)=3+67/255 and 16*(67/255)=4+52/255 give carries 3,4,3,4,... .
Both phases are between 1/5 and 1/3, so the perturbed fractional states
stay in (0,1/3), again sharing p_-1=0,p_0=3 and avoiding (1/3,1/2).
Here J_n=U+3Delta at even n and -U+4Delta at odd n; J_n/U tends to
+1 and -1 along the two parities. Thus such a hole does not itself
force a small normalized residual. Neither comparison refutes a claim
retaining the full actual initialization and rational raw values.

Suspend this local-annihilator/small-residual consumer. A consequence of
avoidance producing small actual J would need a new argument using the
full seed; the recurrence and its initial integer floors supply none.
The weaker facts established here do not move the visitation frontier.

The authoritative repaired report is
`/tmp/pi-m4-exact-structure-clarification-20261127/report.md`, SHA-256
`9a2d83c8d95ee3a8c3399be211d533f03ce420e416958d71dd25c512b2129c38`.
Parent unchanged-copy replay passed 2,769 exact checks with identical receipt
and all five original plus six repaired packet files preserved. The original
checker had mislabeled a zero-seed actual-floor test as synthetic; the
immutable correction removes that test and records the earlier error.
The corrected checks use nonzero synthetic seeds and exact algebra, not
actual pi orbit sampling. Universal bounds and comparison trajectories
remain paper arguments; no Lean proof or M4 acceptance follows.

### A recurrence source gives no new placement estimate

A bounded source check found no applicable visitation contract. The
[publisher abstract for Luca, Prime divisors of binary holonomic sequences](https://www.sciencedirect.com/science/article/pii/S0196885807000061)
(2008, DOI 10.1016/j.aam.2006.12.001) concerns rational order-two polynomial
recurrences and prime-factor growth. Actual u_n=S_n already has that
rational recurrence form, with coefficients U(n+1), -(16U(n+1)+V(n+1))
and 16V(n+1); no varying denominator clearing is needed. The full theorem,
exceptional-class definition, counting convention and proof were unavailable.
Only publisher abstract/metadata were inspected; no full application is claimed.

Even granting the advertised positive-multiple-of-log-N support conclusion,
the established denominators give more. If q_n is the reduced denominator
of S_n, then q_n divides lcm(1,...,8n+6) and log q_n=6n+o(n). Each
prime power in q_n is at most 8n+6, so

    log q_n<=omega(q_n)*log(8n+6),
    omega(q_n)>=(6+o(1))*n/log n.

Here omega counts distinct primes. If S_n=a_n/q_n is reduced, its
fractional part r_n/q_n remains reduced, with 0<r_n<q_n eventually.
Its logarithmic rational height is exactly log q_n, regardless of whether
it avoids a selected interval. The raw height is
h(S_n)=(6+log16)n+o(n). The small E_n approximates pi*16^n, not an integer;
it supplies no smaller height for the fractional part.

A constant-coefficient rational recurrence would keep denominator primes
in a finite set: normalize the leading coefficient, include denominator
primes of the resulting coefficients and initial values, and induct in
that localization. The support bound above rules this out for actual S.
This observation does not identify the uninspected source's exceptional
class. In every case the missing step is control of the actual numerator's
real position. The source's advertised output does not supply it.

Frozen report `/tmp/pi-m4-recurrence-source-consumer-20261127/report.md`
has SHA-256 `4d0926e7e1703f5cdbbe3e3176df6eb0b2b162e185d6db35f7c8fb7178fbc19b`.
Separate paper review found no D/I item and retained numerator placement as
Q1. No full source-proof audit, numerical census or Lean result is claimed.
Suspend this source consumer; the bounded search failure is not a claim
that no applicable theorem exists elsewhere.

### A discrete holonomic density passage excludes exponential phases

The author-hosted [Fuchsian holonomic sequences](https://www.texmacs.org/joris/fuchsianseq/fuchsianseq.pdf)
was checked at printed pages 19--20. Corollary 6.2 requires largest phase
g_k(x)=x; its rounding argument uses a uniform Lipschitz bound. Theorem 6.3's
displayed algebraic-power/logarithm field excludes exponential growth.
These are applicability limits, not a certification of the printed results
or their earlier dependencies. For our own sequence,
exp(2*pi*i*S_n)=exp(i*2*pi^2*16^n)*exp(-2*pi*i*E_n).
The leading phase has exponentially growing derivative. Normalizing raw S_n
to a convergent sequence discards the modulo-one information. No direct
source application or holonomicity of the character/carry sequence follows.
The full PDF was retained and both relevant pages inspected as text and
images. Independent review found no D/I item; a valid integer-index
exponential-phase theorem or separate transfer remains missing.

## Rational resets require exceptional fine returns to transfer

Write T_N=E_(N-1), N>=1. The exact tail identity and rational coefficient
asymptotic give 16T_N=A(N)+T_(N+1) and N^2*T_N ->1/64. Indeed
N^2*A(N+s)->15/64 for fixed s, with majorant 1 and summable weights
16^(-s-1). Fix rational r in (0,1) with odd denominator q, and tau with
16^tau=1 modulo q. Reset the exact recurrence to r separately at each N.
Its j-step state is

```text
z_j^(N)=fract(16^j*(r+T_N)-T_(N+j)).
```

For j tending to infinity through multiples of tau and N_j/4^j ->c>0,
the circle limit is r+1/(64c^2) modulo 1. Every interior target t is
obtained by choosing an integer k with beta=k+t-r>0 and c=(64beta)^(-1/2).
This proves visitation for a triangular family of separately reset paths,
not for one fixed path or the actual entries y_N.

For r=1/3, the following explicit unproved condition R would suffice for V:
for every c>0 there exist j_l ->infinity and N_l>=1 with

```text
N_l/4^(j_l)->c,  N_l^2*(y_(N_l)-1/3)->0.
```

The amplified entry discrepancy then tends to zero, so the reset limit
transfers to actual recurrence index N_l+j_l, orbit index N_l+j_l-1.
With y_N=a_N/Q_N reduced, the missing estimate is precisely
N_l^2*(3*a_(N_l)-Q_(N_l))/(3*Q_(N_l))->0 along all required scale windows.
Neither the sign/size of the denominator nor the reset calculation supplies it.

R is stronger than generic visitation. In the exact-A comparison family
u_N(alpha)=fract(16^(N-1)*alpha-T_N), alpha in [0,1], the set with
|u_N(alpha)-1/3|<=C/N^2 has measure at most 2C/N^2. Summing tail measures
shows that almost every alpha has only finitely many such returns for each
integer C>0. Independently, disjoint aligned base-16 word blocks prove
almost-everywhere arbitrarily late visitation, which transfers through T_N->0
using interior margins. Thus almost every comparison visits but fails R.
These parameters generally lose zero initialization and rational raw samples;
this does not refute R for pi. No almost-everywhere conclusion is applied to pi.

Moving to the nearest center r=a/(16^j-1) only gives transported error
bound 16^j/[2*(16^j-1)], tending to 1/2, not to zero. This is an upper
bound, not a lower bound on the actual residual. Moreover
r+16^j*(y_N-r)=16^j*y_N modulo 1 exactly. Rounding alone returns the
original phase; a new signed-residual estimate would be needed.

Suspend this transfer without an independently justified actual fine-return
estimate; the condition is not supported merely because it implies V.
Frozen report `/tmp/pi-m4-selected-numerator-discovery-20261127/report.md`
has SHA-256 `f2fb793270b5182fe414d7f7a41e7fc37ba7a7969e8bf46296d8f9f9aaa699b0`.
Parent unchanged-copy replay passed 80 synthetic checks with identical receipt
and five originals preserved. Separate paper review found no D/I item.
Limits and measure arguments remain paper mathematics; R and V remain open.

## A rational-base termination proof loses its fixed integer

Dubickas--Mossinghoff, [Lower bounds for Z-numbers](https://www.researchgate.net/profile/Michael-Mossinghoff/publication/220576840_Lower_bounds_for_Z-numbers/links/544d447d0cf2d6347f45c4fd/Lower-bounds-for-Z-numbers.pdf),
author preprint dated 20 January 2008, Proposition 3.2, printed p.5, proves
termination of g ->ceil(p*g/q) restricted to one residue s modulo q, for
coprime 2<=q<p and positive integer initial g. With t=(-p*s) mod q,
nontermination would make H_n=(p-q)g_n+t=(p/q)^n H_0 integral forever.
The fixed positive integer H_0 cannot be divisible by every q^n.
The adjacent conditional Z-number correspondence starts with g_0=floor(lambda).
This is integral for every positive real lambda and does not select a rational
raw seed; the correspondence still requires its Z-number hypotheses.
The relevant source statement and its elementary proof were read as text;
no local PDF or visual verification of this author preprint was available.

For BBP let L_(-1)=1 and L_n be the lcm of denominators of A(0),...,A(n).
Then P_n=L_n*S_n is integral and

```text
P_n=(16*L_n/L_(n-1))*P_(n-1)+L_n*A(n).
```

The multiplier is integral; canonical reduction additionally subtracts
c_n*L_n. There is no fixed q>1 denominator or fixed branch constant in this
integer recurrence. In the source-shaped variable-branch recurrence,
H_(n+1)-(p/q)*H_n=t_(n+1)-t_n, so its constant-integer argument is lost.
Nor do equal carry words cancel different-time BBP forcing: their state
difference retains sum_r16^(m-1-r)*(A(i+r)-A(j+r)). Rational local entries
zero at times 1 and 2 both have zero carry, but their next values differ by
A(1)-A(2)=66779/765765. These are synthetic local entries, not actual visits.

An omitted word supplies neither one fixed affine branch nor an independent
nonzero integer with growing divisibility. This rejects the tested transfer,
not all rational-base methods. The source's integer-floor initialization also
fails the proposed distinction from irrational changed-seed comparisons.
The bounded source assessment is retained in
`/tmp/pi-m4-rational-base-connection-20261127/report-v1.md`.
No source theorem is applied to the BBP orbit; V/M4 remain open.
