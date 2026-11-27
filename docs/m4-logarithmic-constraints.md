# M4 continuation: logarithmic arithmetic and polynomial constraints

Research record, 2026-11-26, after local checkpoint `9b6ca1b`.
The results below are paper mathematics with explicit source dependencies,
not new Lean declarations. V remains open. They investigate structure that
the earlier rational-value and random-family countermodels do not retain.
The initial independent review found no defect; its source-notation clarification
was applied. Combined checkpoint review is complete in the
[continuation review record](agy-reports/m4-continuation-review.md).

## The original four-pole space has no rational null direction

For `r in {1,4,5,6}`, set

```text
S_r=sum_(n>=0) 1/(16^(n+1)*(8*n+r)),
S(c)=c_1*S_1+c_4*S_4+c_5*S_5+c_6*S_6,  c in Q^4.
```

These four values are linearly independent over Q. Thus the rational kernel
is zero, even before imposing `sum c_r=0` to retain O(n^-2) coefficient decay.
The full map has Q-rank 4; its restriction to that hyperplane has Q-rank 3.
In particular the representation of `pi/16` in this space is unique. This
excludes rational null changes within the original poles, not changes adding
other poles as in the previous constructions.

The source input is Baker, [*Effective methods in the theory of numbers*](https://www.mathunion.org/fileadmin/ICM/Proceedings/ICM1970.1/ICM1970.1.ocr.pdf),
ICM 1970 volume 1, section 2, printed p.20 (PDF page 58, one-based).
For chosen logarithms of nonzero algebraic numbers that are Q-linearly
independent, Baker gives linear independence of those logarithms together
with 1 over the algebraic numbers. The parent downloaded the official PDF
and visually inspected the statement; its broader theorem is used, not the
weaker special case whose proof is sketched later on that page.

Here is the exact application. Set
`P_c(x)=c_1+c_4*x^3+c_5*x^4+c_6*x^5`. Uniform geometric convergence gives

```text
S(c)=integral_0^1 P_c(x)/(16-x^8) dx.
```

Order the roots of `x^8=16` as
`rho=(sqrt(2),1+i,i*sqrt(2),-1+i,-sqrt(2),-1-i,-i*sqrt(2),1-i)`.
Put `beta_k=1-1/rho_k` and use the principal logarithms `L_k=Log(beta_k)`.
Every path `1-x/rho_k`, `0<=x<=1`, stays in the right half-plane, with real
part at least `1-1/sqrt(2)>0`. Integration of the simple partial fractions
therefore introduces no branch multiple:

```text
S(c)=-(1/128)*sum_(k=0)^7 N_k*L_k,
N_k=c_1*rho_k+c_4*rho_k^4+c_5*rho_k^5+c_6*rho_k^6.
```

The residue is `-P_c(rho_k)/(8*rho_k^7)=-N_k/128`, and
`d Log(1-x/rho_k)/dx=1/(x-rho_k)`. This checks the normalization against
the n+1 weighted series, whose BBP value is pi/16.

Baker justifies separating the coefficients in the Q-basis
`1,sqrt(2),i,i*sqrt(2)` of `Q(sqrt(2),i)`. Explicitly, if Q-independent
algebraic b_j and rational combinations M_j of the L_k satisfy
`sum b_j*M_j=0`, choose a Q-basis of the span of the L_k from the logs
themselves. Baker makes that basis independent over the algebraic numbers;
then Q-independence of the b_j forces each M_j to vanish. This does not
assume all eight logs are independent or apply field automorphisms to logs.

The endpoint identities needed for the calculation are

```text
L_0+L_4=L_1+L_7=-log(2),
L_2+L_6=log(3/2),  L_3+L_5=log(5/2),
L_0-L_4=-2*log(1+sqrt(2)),  L_1-L_7=i*pi/2.
```

For the sums, the endpoint products are respectively `1/2,1/2,3/2,5/2`;
the pairs are positive reals or conjugates in the right half-plane. For the
first difference, `beta_0/beta_4=(1+sqrt(2))^(-2)`. The second pair has arguments
pi/4 and -pi/4. Thus all identities respect the chosen logarithms.

Suppose `S(c)=0`, and put `u=c_1+4*c_5`, `v=c_1-4*c_5`.
The sqrt(2) component gives `u*(L_0-L_4)=0`, hence u=0. The rational component,
after the displayed endpoint sums cancel the log(2) terms, gives

```text
(4*c_4-8*c_6)*log(3)-(4*c_4+v)*log(5)=0.
```

Clearing rational denominators and exponentiating produces `3^m*5^n=1`
with integers m,n. Unique factorization forces both to vanish. Therefore
`c_4=2*c_6`, `v=-8*c_6`, and `c=c_6*(-4,2,1,1)`.
The i component is

```text
(v-8*c_6)*(L_1-L_7)+(v+8*c_6)*(L_3-L_5)=0.
```

Substitution reduces it to `-8*i*pi*c_6=0`, proving c=0. The remaining
i*sqrt(2) component is redundant. No independence involving pi, arctangents
or the real unit logarithm was assumed. For the actual vector `(4,-2,-1,-1)`,
the raw logarithmic sum is
`-16*(L_0+L_4-L_1-L_7)+16*i*(L_1-L_7)=-8*pi`, giving S(c)=pi/16.

Including 1 in Baker's theorem also shows that every nonzero rational c has
transcendental S(c): a nonzero algebraic value would give a forbidden algebraic
linear relation between 1 and a Q-basis of the logs. Thus the rational-value
thirteen-pole avoiding model cannot be reproduced inside this four-pole space.
This is a genuine restriction on representation. It supplies no estimate on
prefixes, shifted fractional parts or hitting times, and does not exclude an
infinite proper limit set for a transcendental value. A Baker formalization
without a surviving visitation consumer is not justified here.

## Extension to all eight poles with the decay condition

The parent tested whether that uniqueness depended on using only four poles.
Define the same S_r for r=1,...,8 and allow c in Q^8. The complete rational
kernel is one-dimensional, generated by

```text
C=(1,-1,-1/2,-1,-1/4,-1/4,1/8,0).
```

This is exactly the earlier zero-series polynomial in the
[rational-forcing assessment](m4-rational-forcing.md). Its coefficient sum is
`-15/8`, so the kernel intersects `sum c_r=0` only at zero. Consequently even
in the full eight-pole space, the O(n^-2) representative of pi/16 is unique.
The decay requirement matters: for fixed c,
`sum_r c_r/(8n+r)=(sum c_r)/(8n)+O(n^-2)`.

The proof uses the same integral, branches, roots and Baker coefficient
separation, now with `N_k=sum_(r=1)^8 c_r*rho_k^r`. Put

```text
U=c_1+2*c_3+4*c_5+8*c_7,  V=c_1-2*c_3+4*c_5-8*c_7,
W=c_1-2*c_3-4*c_5+8*c_7,  Z=c_1+2*c_3-4*c_5-8*c_7,
E_plus=2*c_2+4*c_4+8*c_6+16*c_8,
E_minus=-2*c_2+4*c_4-8*c_6+16*c_8,
E_0=-4*c_4+16*c_8,  E_1=2*c_2-8*c_6.
```

If S(c)=0, the sqrt(2) and i*sqrt(2) components give
`U*(L_0-L_4)=0` and `V*(L_2-L_6)=0`. Both logarithm differences are nonzero:
the first is real with unequal positive endpoints; the second is
`2*i*arctan(1/sqrt(2))`. Thus U=V=0. The rational component gives

```text
E_minus*log(3)+(E_0-W)*log(5)-64*c_8*log(2)=0.
```

Unique prime factorization after clearing denominators implies
`c_8=E_minus=E_0-W=0`. The remaining i component is

```text
(E_1+Z)*(L_1-L_7)+(-E_1+Z)*(L_3-L_5)=0.
```

Here `L_1-L_7=i*pi/2` and `L_3-L_5=2*i*theta`, with theta=arctan(1/3).
These two imaginary logarithm differences are Q-independent. Indeed, an
integer relation exponentiates to `i^m*alpha^n=1`, where
`alpha=(3+i)/(3-i)=(4+3*i)/5`. If n is nonzero, alpha would be a root of
unity. Then `alpha+alpha^(-1)=8/5` would be a rational algebraic integer,
which is impossible. If n=0, the original relation `m*i*pi/2=0` gives m=0.
This argument uses the original zero relation, not just its exponentiation.
It follows that E_1=Z=0.

Solving these seven rational equations gives

```text
c_8=0, c_2=4*c_6, c_4=4*c_6,
c_1=-4*c_6, c_3=2*c_6, c_5=c_6, c_7=-c_6/2,
c=(-4*c_6)*C.
```

Conversely C has raw logarithmic sum `-8*(L_0+L_4-L_1-L_7)=0`, so it
really is in the kernel. This proves equality with the claimed line, not
only a necessary rank bound. Adding `sum c_r=0` forces c_6=0. The full image
has Q-rank 7, and the seven-dimensional decay hyperplane maps injectively.
The actual vector `(4,0,0,-2,-1,-1,0,0)` belongs to that hyperplane and has
value pi/16, proving the asserted uniqueness.

This explains exactly why the known null change to the pure-arctangent
representative alters the decay order. It does not make the represented
constant's orbit dense. No finite-prefix, approximation or visitation estimate
has been obtained from the uniqueness statement.

## Rational periods in every fixed finite eighth-grid pole family

The full eight-pole kernel extends exactly to integer shifts. Fix H>=0
and rational coefficients c_(r,h), and let

    g(x)=sum_(r=1)^8 sum_(h=0)^H c_(r,h)/(8x+r+8h).

Thus g is proper and has only simple negative eighth-grid poles; H and
all coefficients are fixed before taking n to infinity. Put
B R=16R-R(.+1), f_r(x)=1/(8x+r). Finite telescoping gives

    f_r(x+h)=16^h*f_r(x)
                 -B[sum_(j=0)^(h-1)16^(h-1-j)*f_r(x+j)].

Hence g=sum_r d_r*f_r+B R, where d_r=sum_h 16^h*c_(r,h) and R is
an explicit proper rational function with at most 8H simple grid poles.
Its period is Pi_g=16*L(d)+16*R(0), where
L(d)=sum_(n>=0,r=1,...,8) d_r/[16^(n+1)*(8n+r)].
Baker's already assessed theorem includes 1: choosing a
Q-basis of the actual logarithms shows that an algebraic value of L(d)
must be zero. Thus a rational Pi_g forces d=lambda*D, with D=4*C
and rational lambda. Conversely this condition gives Pi_g=16*R(0).

The zero-initialized prefix is exactly

    S_n^g=lambda*U_n+T_n,
    T_n=16^(n+1)*R(0)-R(n+1).

The homogeneous term is required by initialization. A fixed rational
function has log den(T_n)=O_g(log(n+2)). If lambda=a/b is nonzero in
lowest terms, q_n=den(U_n), q'_n=den(S_n^g), and t_n=den(T_n), then

    q'_n<=b*q_n*t_n,  q_n<=|a|*q'_n*t_n.

The [null denominator theorem](m4-prime-compression.md#the-actual-null-state-has-denominator-exponent-eight)
therefore proves that every rational-period g in this entire fixed-pole
family has forward denominator exponent 0 when lambda=0 and 8 otherwise.
Exponent 6 cannot occur. Positivity is unnecessary for the classification.
Both alternatives occur with positive completely monotone forcing: a
rational coboundary has exponent 0; the earlier thirteen-pole model has
F=(15/8)*D+B(t/2-D/8), so its exponent is 8. Its known avoiding orbit
and rational period 32/21 remain unchanged.

This answers a scoped countermodel question, not visitation. The actual A
has exponent 6 and irrational period, consistently with this classification.
A missing word need not imply a rational period or a rational telescoper;
that implication is still absent. Repeated poles, other pole grids and
pole families varying with n are outside the theorem. Further classification
in the same family is suspended without a new actual-phase consequence.

Frozen packet `/tmp/pi-m4-rational-period-classification-20261127/`,
report SHA-256
`1e84ce8b307260f8a6de185b5b963477f05a0b4918e2805dd8f1957f98dd37c9`,
retains the explicit correction R, uniqueness proof, denominator costs,
source-input contract and separate criticism. Parent full reconstruction
and unchanged-copy replay passed, with only the UTC receipt difference
and originals preserved. The parent retained committed source copies of
the pre-existing kernel and F model; new draft sections are not inputs
to their own derivation. Baker and the null denominator asymptotic remain
paper inputs, not conclusions of the finite rational checker.

## A solved dimension problem does not transfer to the fixed orbit

Let nu_lambda be the law of `sum_(j>=0) epsilon_j*lambda^j`, with independent
fair signs. Breuillard–Varjú, [*On the dimension of Bernoulli convolutions*](https://arxiv.org/pdf/1610.09154v3),
13 November 2018 version, Corollary 5 and its following paragraph, printed p.3,
derive dimension one from a lower bound for nonzero polynomials with coefficients
in {-1,0,1}, and explicitly include lambda=pi/4. We explicitly exclude the zero
polynomial, as necessarily intended in that positive lower-bound condition;
the source's displayed notation does not state the exclusion separately.
Varjú's later
[*On the dimension of Bernoulli convolutions for all transcendental parameters*](https://annals.math.princeton.edu/wp-content/uploads/annals-v189-n3-p09-s.pdf),
Theorem 3, printed p.1002, gives dimension one for every transcendental
`1/2<lambda<1`. The dimension is that of this probability measure; neither
statement concerns the base-16 orbit of the parameter. The parent visually
checked both theorem pages.

The proposed transfer from a missing hexadecimal word for x=4*lambda to
dimension drop of nu_lambda is false, including when x is transcendental
with irrationality exponent 2. Let t be the 0/1 Thue–Morse word, with t_0=0,
and set

```text
xi=sum_(k>=0) t_k/16^k,
lambda_*=3/4+xi,  x_*=4*lambda_*=3+4*xi.
```

Bugeaud, [*On the rational approximation to the Thue–Morse–Mahler numbers*](https://www.numdam.org/item/10.5802/aif.2666.pdf),
printed pp.2067–2068, records transcendence of this number and proves
irrationality exponent 2 for every integer base at least 2. The parent
visually checked the definition and theorem. Nonzero rational affine maps
preserve both properties: rational approximants convert in both directions
with denominators changing by at most fixed factors.

Now `0<xi<1/15`, so `1/2<lambda_*<49/60<1`, and Varjú gives
`dim nu_(lambda_*)=1`. On the other hand, the integer-prefix split gives,
for every n>=0,

```text
fract(16^n*x_*)=4*sum_(j>=1) t_(n+j)/16^j <=4/15<1/3.
```

There is no wrap since the bound is below 1. Thus x_* always avoids `(1/3,1)`.
This uses the Thue–Morse example in a different role from the repetition test:
it separates random-series dimension at the number-as-parameter from the
distribution of that number's own positional expansion.

Even the neighboring theorem's polynomial-separation input alone is insufficient.
For lambda=3/4, a nonzero {-1,0,1} polynomial P of degree at most d cannot
vanish: remove powers of X and use the rational-root theorem with constant
coefficient +/-1. The nonzero integer `4^d*P(3/4)` gives
`abs(P(3/4))>=4^(-d)`, although x=4*lambda=3 has zero fractional orbit.
This rational example tests the separation condition; the preceding example
separately retains transcendence and irrationality exponent 2.

The first missing bridge is exact: digit avoidance constrains one expansion
at fixed contraction 1/16, while the source inverse theorem needs crowding of
independent sign-polynomials evaluated at pi/4. Neither the random dimension
conclusion nor pi's exponential relation supplies that operation. In the
Fourier product `nuhat_lambda(t)=product_j cos(2*pi*t*lambda^j)`, setting
t=4*16^n makes the j=1 factor involve the desired pi orbit, but other factors
involve other powers of pi; a small product does not make that factor small.
The direct dimension-to-visitation transfer is suspended.

## Evidence and next test

The immutable four-pole report and checker are
`/tmp/pi-m4-four-pole-nullspace-report-v1.md` and
`/tmp/pi-m4-four-pole-nullspace-check-v1.py`. The parent inspected and reran
the exact Q(sqrt(2),i) algebra, endpoint products, four partial fractions,
coefficient components and rational rank calculation, exit 0. An initial
worker check wrongly expected a raw component to vanish; the final check
retains its actual nonzero coefficient vector and vanishing logarithmic relation.
The script does not prove Baker's theorem or the analytic branch argument.

The parent extension's checker is
`/tmp/pi-m4-eight-pole-nullspace-check-v1.py`, with frozen receipt
`/tmp/pi-m4-eight-pole-nullspace-receipt-v1.json`. It verifies all eight partial
fractions and field components, ranks 7 and 8, the exact generator and its
nonzero coefficient sum, and the angle ratio's trace 8/5. It exited 0 on the
first run. The universal kernel proof above, including the source theorem and
algebraic-integer argument, remains paper mathematics. Its initial independent
review is recorded separately from these finite checks.

The Bernoulli-transfer report and checker are
`/tmp/pi-m4-bernoulli-transfer-report-v1.md` and
`/tmp/pi-m4-bernoulli-transfer-check-v1.py`. Parent execution exited 0 on 129
Thue–Morse terms, orbit indices through 64, 9,832 polynomial tests and finite
sign sums through length 12. These are sanity checks, not universal proofs.

Official source PDFs and inspected page images are retained under
`/tmp/pi-m4-icm1970-primary.pdf`, `/tmp/pi-m4-baker-page-58.png`,
`/tmp/pi-m4-breuillard-varju-page-3.png`, `/tmp/pi-m4-varju-page-2.png`, and
`/tmp/pi-m4-bugeaud-page-4.png`, `-5.png`. Installed macOS PDFKit supplied the
text and rendering after the web viewer's proceedings-size limit; no tool was
installed and no permissions changed.

Two changed inquiries continue within M4: test a concrete allowed-prefix
polynomial construction against the actual degree/height/value bound for pi,
and seek an exact arithmetic or functional identity exploiting the original
pole pattern. Their 30-minute bounds require an explicit cost comparison or
first missing bridge, followed by reassessment. No generic entropy or
irrationality conclusion is being substituted for the unchanged V contract.
