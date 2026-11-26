# Analytic 2-adic coherence can coexist with real avoidance

Research checkpoint, 2026-11-26. The initial construction passed independent
review, as has the all-jets extension below. This paper construction tests the newly
proved BBP reflected-zero/isometry invariants. It preserves those abstract
invariants, an irrational real weighted sum, the initial coefficient, leading
decay and exponential rational heights. It drops the actual rational forcing
function and does not refute M4 or the rational-forcing dichotomy conjecture.
The [actual BBP invariant](m4-two-adic-reflection.md) remains valid. The complete construction below is a model with a different forcing, not a contradiction to that invariant.

## 1. A fixed irrational avoiding value

Let t_j in {0,1} be the parity of the binary digit sum of j, with t_0=0,t_1=1.
Put

    zeta=sum_(k>=1)t_(k-1)/16^k,
    xi=47/15+zeta=3+sum_(k>=1)(2+t_(k-1))/16^k.

Thus 1/256<=zeta<=1/15 and every fractional orbit value fract(16^n*xi)
belongs to [2/15,1/5]. The sequence t is not eventually periodic: if p were an
eventual period, then for every sufficiently large r,
t_(2^r-p)=t_(2^r)=1. But the binary complement identity gives
t_(2^r-p) equal to the parity of r-s_2(p-1), which alternates with r.
Consequently xi is irrational: a rational base-16 expansion is eventually
periodic, and these digits 2,3 have no ambiguous terminating expansion.

## 2. Stable rational interpolation

For n>=1 let

    C_n(x)=binom(x+1,n+1)=(x+1)*x*...*(x-n+1)/(n+1)!,
    e_n=1/[64(n+1)^2], s_n=2^(2n+1)/3^(4n+12),
    epsilon_n=s_n/2=3^(-12)*(4/81)^n.

Recursively choose an integer p_n and a_n=s_n*p_n so that

    B_n(x)=(47/15)*(x+1)+sum_(j=1)^n a_j*C_j(x),
    abs(B_n(n)-(16^n*xi-e_n))<=epsilon_n.       (1)

This is always possible by nearest-integer rounding, since C_n(n)=1 and all
earlier coefficients are fixed. The target for p_n is irrational, so it is
never exactly at a half-integer; its choice is unique with the usual nearest
rounding rule. For integers 0<=k<n, C_n(k)=0. Thus later choices never change
earlier nonnegative integer values. Also C_n(-1)=0.

The elementary bounds needed below are

    epsilon_n<16^(-n), epsilon_n<e_n/100.        (2)

The first follows from 64/81<1. For the second, the sequence
(n+1)^2*(4/81)^n decreases for n>=1, since successive ratios are at most
(3/2)^2*(4/81)=1/9. Its maximum is 16/81; multiplication by 6400/3^12
is less than one. These estimates are uniform, not finite observations.

## 3. One analytic isometry with zero reflected anchor

The infinite series

    B(x)=(47/15)*(x+1)+sum_(n>=1)a_n*C_n(x)     (3)

defines a 2-adic analytic function on the open disk abs(x)_2<2, including Z_2.
Indeed v_2(a_n)>=2n+1. The numerator polynomial of C_n has integer coefficients,
and v_2((n+1)!)<=n, so every coefficient of a_n*C_n has valuation at least n+1.
On any smaller closed disk of radius R with 1<=R<2, its polynomial norm is at
most 2^(-n-1)*R^(n+1), a summable geometric bound. This justifies the power-series
sum and its analyticity. No real convergence of (3) for arbitrary real x is used.

For x,y in Z_2, the polynomial divided difference of C_n has coefficients in
2^(-n) Z_2. Hence each a_n correction to the divided difference is in
2^(n+1) Z_2. The leading slope 47/15 is odd. Uniform convergence yields

    v_2(B(x)-B(y))=v_2(x-y) for x!=y,
    B(-1)=0.                                  (4)

As usual, injective finite residue maps are permutations, and their compatible
inverses make B onto Z_2. At a nonnegative integer n the infinite sum is the
finite rational value B_n(n); write that value as b_n. Set b_(-1)=0 and

    g(x)=B(x)-16*B(x-1), g_n=b_n-16*b_(n-1).   (5)

Then g is analytic and an isometry on Z_2 as well: its divided difference is
one unit minus 16 times another. Both b_n and g_n are rational with odd
denominator, and g_0=b_0=47/15. From (4),

    v_2(b_m-b_n)=v_2(m-n),
    v_2(b_n)=v_2(n+1),                         (6)

for the indicated distinct nonnegative indices. All residue cycles have the
same complete-period property as the actual BBP prefix invariant.

The actual backward sum for this g satisfies

    sum_(j>=0)16^j g(x-j)=B(x),
    sum_(j>=0)16^j g(-1-j)=0.                  (7)

These follow by telescoping and boundedness of B on Z_2. The finite reflected
sum therefore has valuation 4M+v_2(M), just as in the BBP calculation. Negative
integer B and g values here need not be rational; this is an explicit property
lost compared with the actual rational recurrence.

## 4. Real positivity, matched decay and permanent avoidance

In the real embedding define E_0=xi-47/15=zeta and
E_n=16^n*xi-b_n for n>=1. Equations (1)-(2) give

    abs(E_n-e_n)<=epsilon_n<e_n/100,
    g_n=16*E_(n-1)-E_n for n>=1.              (8)

For n=1, 16E_0>=1/16 and E_1<101/(100*256), giving g_1>0.
For n>=2, e_(n-1)>e_n and (8) gives
g_n>16*(99/100)*e_(n-1)-(101/100)*e_n>0. Also

    g_n=1/(4n^2)-1/[64(n+1)^2]+O(16^(-n))
       =15/(64n^2)+O(n^-3).                  (9)

The weighted real sum telescopes:

    sum_(j=0)^n g_j/16^j=b_n/16^n=xi-E_n/16^n -> xi.

The initialized recurrence y0=0, y_(n+1)=fract(16*y_n+g_n) has
y_(n+1)=fract(b_n). For n>=1 its uncorrected phase lies in [2/15,1/5],
while 0<E_n<101/25600<2/15. Therefore subtraction crosses no integer and

    0<y_(n+1)=fract(16^n*xi)-E_n<1/5.

For n=0, y1=2/15. Every iterate thus avoids (4/5,9/10), despite the irrational
weighted sum and all the coherent 2-adic statements (4)-(7).

## 5. Exponential heights and the exact lost hypotheses

At each nonnegative integer input, binomial values are integers. Denominators
of b_n and g_n therefore divide 5*3^(4n+12), since denominators of all earlier
a_j divide this quantity and 15 does also. Their real size is bounded by a
constant times 16^n (and g_n itself is bounded). Reduced numerators and
denominators consequently have height exp(O(n)). The construction has not
hidden superexponential denominator growth in the prefix values.

It does not retain the actual four-pole rational function, a fixed rational
function representation for the forcing, polynomial height of each g_n,
or real complete monotonicity. Its negative integer values need not be rational.
The actual A(1)=106/819 already has denominator primes 7 and 13, whereas this
model's g_1 denominator uses only 3 and 5, so the functions are certainly
different. No theorem about the actual BBP forcing is contradicted.

Thus the new coherent residue cycles, reflected zero, irrationality, leading
decay and exponential prefix height are still insufficient on their own.
The next genuine input must use the global rational forcing structure or a
constraint this interpolation drops, and prove a bridge to real fractional
parts. This is a discriminating countertest, not a reason to end M4.

## Exact finite validation of the analytic model

Parent checker `/tmp/pi-m4-analytic-avoidance-check-v1.py`, SHA-256
`897918a283461eb92ec0eb5ec9f2cf02f62a37df74e732e3fb76753f3ae662a9`,
exited 0. It verifies 64 interpolation choices using certified rational bounds
on the explicit Thue-Morse constant, positivity/denominators/avoiding prefixes,
2,080 pairwise valuations for both prefixes and forcing, full residue tables
through 12 bits, and 32 reflected polynomial-truncation valuations. Those last
checks concern finite polynomials, not rationality of negative values of B.
No pi digits or numerical pi routines are used. The infinite construction and
analytic arguments are paper proofs, not consequences of these finite cases.

## Rational isometry model with a nonzero anchor

This simpler comparison retains real complete monotonicity and a rational
forcing, but has a rational weighted sum and loses the zero reflected anchor.

Put c=424/2159 and

    r(x)=(x+c)/[(2x+1)(4x+1)(8x+1)],
    g(x)=16*r(x)-r(x+1).

For real x>=0, r and g are strictly completely monotone and positive. To see
this, write

    r(x)=1/[8*(2x+1)*(4x+1)]
           +(c-1/8)/[(2x+1)*(4x+1)*(8x+1)],

where c>1/8. Products of these reciprocal linear factors are Laplace transforms
of positive measures; replacing r(x) by 16*r(x)-r(x+1) multiplies the positive
Laplace density by 16-exp(-t)>0. Differentiation under these exponentially
decaying integrals proves all strict alternating derivative inequalities.

The rational formula gives exactly g(0)=47/15 and
g(n)=15/(64*n^2)+O(n^-3). Its poles are simple, negative and on the eighth-grid,
but they are not the exact four BBP poles. Its denominators, including the
constant c, are odd at every integer input.

Let D(x)=(2x+1)(4x+1)(8x+1). Since D=1 mod2 and every nonconstant coefficient
of D is even, for x!=y in Z_2 the divided difference of r is a 2-adic unit:

    [r(x)-r(y)]/(x-y)
       =[D(y)+(y+c)*(D(y)-D(x))/(x-y)]/[D(x)*D(y)].

The numerator is odd. The divided difference of g is 16 times one such unit
minus another, and remains a unit. Thus r and g are 2-adic isometries. Reduction
modulo 2^k is an injection on a finite set of size 2^k, hence a permutation
for every k. Moreover c=0 mod2, so g(n)=n+1 mod2, matching the actual BBP parity.

The real weighted sum telescopes to 16c=6784/2159. With zero initialization,
the resulting recurrence has

    y_(n+1)=fract(16^n*6784/2159-r(n+1)).

The orbit of the first rational term has period 14, with numerators over 2159:

    307,594,868,934,1990,1614,2075,
    815,86,1376,426,339,1106,424.

Multiplication by 16 modulo 2159 verifies each step and the return. The minimum
phase is 86/2159, greater than r(1)=287/32385; hence no correction crosses zero.
All phases are at most 1614/2159<4/5 or at least 1990/2159. In the latter case
subtracting at most r(1) still leaves 1739/1905>9/10. Consequently every y_(n+1)
avoids (4/5,9/10), including the initial matched y1=2/15.

This model does not preserve the newly found actual reflected identity. Its
2-adically convergent backward sum is

    B_g(x)=sum_(j>=0)16^j*g(x-j)=-r(x+1),
    B_g(-1)=-c!=0.

The telescoping tail tends to zero because r is bounded on Z_2. Thus generic
2-adic isometry, odd denominators, initial forcing, positive moments and the
leading BBP decay can coexist with permanent avoidance. The actual identity
B_A(-1)=0 is a further property lost by this rational model; the analytic
construction above retains it while dropping other hypotheses. The model
also loses irrationality and the exact BBP rational function.

Exact checker `/tmp/pi-m4-isometry-model-check-v1.py`, SHA-256
`c2fdb23ba3ef0864fa206c791a7673e7e74a34d882853b5bdb7b6ca93636fb54`,
exited 0: 14 phase bounds; 20 full residue permutations and periods; 256 exact
recurrences; 64 reflected-anchor congruences. The integral and 2-adic statements
above remain paper proofs, not Lean exports. No pi digits were computed.

## One analytic model matching every algebraic BBP tail term

The preceding analytic construction can retain the actual tail to exponential
accuracy, while still avoiding an interval. Keep xi, C_n, s_n and epsilon_n,
but replace the rounding target e_n by

    E_n=sum_(j>=1)A(n+j)/16^j,
    A(n+1)/16<E_n<A(n+1)/15,
    16E_(n-1)-E_n=A(n).

These follow from the positive decreasing BBP coefficients. Choose the same
rational mesh coefficient a_n=s_n*p_n using

    p_n=floor([16^n*xi-E_n-B_(n-1)(n)]/s_n+1/2).

The fixed convention includes ties. The earlier irrational-target assertion
does not carry over: the unscaled target 16^n*xi-E_n equals
16^n*(xi-pi) plus a rational number,
and irrationality of xi-pi has not been proved. Existence and the error bound
do not need that claim. For n>=1,

    b_n=16^n*xi-E_n+delta_n, abs(delta_n)<=epsilon_n,
    T_n:=16^n*xi-b_n=E_n-delta_n.

The binomial stability is only at 0<=k<n, with -1 treated separately. Every
2-adic argument above still applies because it used only the mesh valuation
v_2(a_n)>=2n+1, regardless of the chosen integer p_n. The height argument also
uses the unchanged rational mesh denominators and the real bounds on b_n and
g_n established below.

For n>=1, the rational formula gives A(n)>=40/(819n^2): its numerator is at
least 120n^2 and its denominator at most (3n)(7n)(9n)(13n)=2457n^4.
Writing r=4/81, the decreasing sequences (n+1)^2*r^n and n^2*r^n give

    epsilon_n/E_n<26208/(5*3^16)<1/100,
    (99/100)E_n<T_n<(101/100)E_n
        <(101/100)*A(2)/15<2/15.

For n>=2 the model forcing satisfies the exact bound

    g_n=A(n)+delta_n-16delta_(n-1),
    abs(g_n-A(n))<=325epsilon_n,
    325epsilon_n/A(n)<=47320/387420489<1.        (10)

At n=1 instead, g_1>=1/16-A(2)/15-epsilon_1>0, since zeta>=1/256.
Thus every g_n is positive; g_0=47/15 still agrees exactly, while g_1 is a
finite exceptional coefficient and is not claimed close to A(1). Subtracting
T_n from the phase in [2/15,1/5] crosses no integer, so all recurrence values
still lie in (0,1/5), including y1=2/15. The weighted real sum is xi.
Telescoping also shows T_n=sum_(j>=1)g_(n+j)/16^j: these are the model's actual
tails, not auxiliary corrections.

For every fixed K>=0,

    n^K*(T_n-E_n)->0, n^K*(g_n-A(n))->0.

This is one construction retaining all algebraic asymptotic terms at once;
no convergent asymptotic expansion is assumed. Furthermore

    H_g(z)-H_A(z)=(g_1-A(1))*z
                    +sum_(n>=2)(g_n-A(n))*z^n

extends analytically to |z|<81/4 by (10). The finite linear term is harmless.
The actual local singular behavior is therefore preserved modulo an analytic
summand. Neither D-finiteness of H_g nor its boundary behavior at 81/4 is claimed.

The lost rational-function hypothesis can now be proved, even eventually.
If a rational R represented g_n for all sufficiently large n, exponential
closeness would force R=A identically: a nonzero rational R-A has a nonzero
leading power at infinity and cannot decay exponentially. But for every
positive n=1 mod7, only the original denominator 8n+6 is divisible by 7, so
v_7(A(n))=-v_7(8n+6)<0. Every g_n is 7-integral because its denominator uses
only 3 and 5. This gives arbitrarily large contradictions to R=A.

There is also a quantitative loss of polynomial forcing height. On n=1 mod7,
n>=2, the nonzero difference has size at least 1/(q_g*q_A), while q_A<=2457n^4.
Equation (10) forces

    q_g >=[3^12/(325*2457*n^4)]*(81/4)^n.        (11)

The prior exponential upper bound 5*3^(4n+12) holds at every index. Polynomial
height is therefore genuinely excluded on an infinite progression. Real
complete monotonicity and rationality at negative inputs remain unestablished;
they are not asserted false. These are explicit limits, not a counterexample
to the actual rational-forcing problem.

Frozen enhancement: `/tmp/pi-m4-all-jets-avoidance-report-v2.md`, with exact
checker `/tmp/pi-m4-all-jets-avoidance-check-v1.py`. The parent read both,
reconstructed the arguments and reran the checker, exit 0: 64 actual-tail
choices, positivity/error/denominator checks, 2,080 pairwise valuations,
residue tables through 12 bits and 32 polynomial reflected checks. Rational
BBP tail enclosures certify the finite choices; no pi digits were searched.
The checker bounds its attempts and makes no universal claim about resolving
rounding ties from intervals. The mathematical fixed-tie construction needs
no such termination theorem. Hashes and full caller evidence are in the review
packet; universal conclusions remain paper arguments.
