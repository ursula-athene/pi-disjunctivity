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
