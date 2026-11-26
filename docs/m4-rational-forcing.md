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

**Application gaps:** the source's threshold is not verified at `a=1,b=16`
for H. Increasing s changes the value; replacing H by a rescaled function
changes the constants and does not automatically repair the gap. The second
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
