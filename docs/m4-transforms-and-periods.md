# M4 continuation: exact tail transforms and Wallis periods

Research record, 2026-11-26, after local checkpoint `b102ab3`.
These are paper arguments and source-application tests, not Lean exports.
They test more specific arithmetic and analytic structure after the earlier
approximation-cost failures. Independent review of this new material is pending;
V and the M4 acceptance boundary remain open.

## An exact transform explains the dyadic tail coefficients

Write Pc(x)=4-2x^3-x^4-x^5 and D(x)=(2-x^2)(x^2-2x+2). Exact factorization
gives

```text
Pc=(1-x)(x^2+2)(x^2+2x+2),
Pc/(16-x^8)=(1-x)/D,
E(n)=integral_0^1 x^(8n+8)*Pc(x)/(16-x^8) dx.
```

The last identity follows from the actual tail's uniformly convergent
geometric series, with ratio at most 1/16. Substituting x=exp(-t/8) gives

```text
H(x)=x^9*(1-x)/D(x),  B(t)=H(exp(-t/8))/8,
E(n)=integral_0^infinity exp(-n*t)*B(t) dt, n>=0.
```

The exponent nine includes the Jacobian. On the positive ray, B>=0,
B(t)~t/64 near zero, and B(t)~exp(-9t/8)/32 at infinity. This is a Laplace
representation and an explicit Borel convention:
`B(t)=sum_(j>=0)a_j*t^(j+1)/(j+1)!` near zero. To identify its coefficients
with the earlier natural tail expansion, the positive measure representation
gives `B(t)=t*integral exp(-ut) dmu(u)`. Its exponential moments exist near
zero, so B^(j+1)(0)=(-1)^j*(j+1)*mu_j=a_j. No convergence of E's infinite
inverse-power series is assumed.

Let L=x*d/dx. Then

```text
N_k=(L^k H)(1),
a_j=(-1)^(j+1)*N_(j+1)/8^(j+2).
```

Because D has integer coefficients and D(1)=1, every N_k is an integer.
Reducing rational functions modulo two is legitimate at x=1, and gives
D=x^4, H=x^5+x^6. For k>=1, L^k H=5^k*x^5+6^k*x^6=x^5 modulo two.
Thus every N_k is odd, and the reduced denominator of a_j is **exactly
8^(j+2)**. Every finite truncation at integer n>=1 belongs to Z[1/(2n)].
This strengthens the earlier denominator support but leaves its order-uniform
real-shadowing obstruction intact.

### Poles, an alternative integral, and the homogeneous mode

B is rational in exp(-t/8), not rational in t. Its poles are exactly
`t=-lambda+2*pi*i*m`, lambda=log16, with these classes and residues:

| m modulo 8 | exp(-t/8) | residue of B |
| --- | --- | --- |
| 0 | sqrt2 | -2 |
| 1 | 1-i | 2-2i |
| 4 | -sqrt2 | -2 |
| 7 | 1+i | 2+2i |

All four roots of D are simple and avoid H's numerator. The residue is
`-16*(1-rho)/D'(rho)=rho*Pc(rho)/8`. The four residues sum to zero per
16*pi*i period. Consequently B's Taylor radius is lambda. Removing the
nearest pole with B_1(t)=B(t)+2/(t+lambda) gives radius
sqrt(lambda^2+4*pi^2), set by the next pair of poles. For n>0 this yields
the exact different representation

```text
E1(z)=integral_z^infinity exp(-u)/u du,
E(n)=-2*exp(lambda*n)*E1(lambda*n)
       +integral_0^infinity exp(-n*t)*B_1(t) dt.
```

The separated integrals require n>0. This introduces lambda and a special
integral, with no rational-seed or modular-error estimate supplied. A larger
Taylor radius for B_1 does not itself give the required arithmetic consumer.

Multiplying B by 16-exp(-t) gives
`(1/8)*sum_a c_a*exp(-(1+a/8)*t)`, with the actual BBP coefficients c_a.
Integration recovers 16E(n)-E(n+1)=A(n+1). On natural indices, solutions
differ by C*16^n, and decay selects one uniquely. A finite closed contour
gamma avoiding the poles gives, by the residue theorem,

```text
integral_gamma exp(-n*t)*B(t) dt
 =16^n * 2*pi*i*sum_m winding(gamma,t_m)*Res(B,t_m), n in N.
```

Only finitely many poles contribute. The equality uses exp(-2*pi*i*m*n)=1;
it requires no contour rotation or discarded large arc. The positive ray has
no poles or lateral ambiguity. These loop changes give a growing homogeneous
mode, not an exponentially small ambiguity or a digit visit. No claim about
all complex-n solutions or all possible constants C is made.

### The avoiding model retains the coarse transform structure

For the recorded 13-pole forcing F, set Q1=2-x^2, Q3=x^2-2x+2 and
L0=Q1'/Q1-Q3'/Q3. Its polynomial kernel K satisfies

```text
K/(16-x^8)=(1-x^4)/8-(1-x^8)*L0/32,
B_F(t)=x^9*(1-x^4)/64-x^9*(1-x^8)*L0/256,
x=exp(-t/8).
```

Its poles have exactly the same four classes. Their residues are -15/2 at
the Q1 roots and +15/2 at the Q3 roots, all nonzero. The denominator D(1)=1
also proves dyadic asymptotic coefficients. Yet its initialized recurrence
avoids an interval, as established in the
[rational-forcing assessment](m4-rational-forcing.md). This refutes an inference
from those coarse properties alone. It does not match BBP's complex residue
pair or exact coefficient parity pattern: F's first coefficients are
1/64,-7/128,157/1024,-1679/4096. A use of the stronger actual data still
needs an argument connecting it to real modular phases.

Immutable report: `/tmp/pi-m4-borel-structure-report-v1.md`, SHA-256
`26bbcf368d0ff123b13dbb510d50652b29bd8c678dcf3a8f77eab237770be500`.
The parent inspected and ran `/tmp/pi-m4-borel-structure-check-v1.py`,
SHA-256 `2d257c4ad5140dcbed200dee6ad8f626e299102e666c1552965024c8767eea68`:
exit 0. Forty coefficient orders, exact kernel cancellations and all residues
are finite algebra checks; the universal parity, integrals and contour argument
remain paper mathematics.

## A rational-period theorem does apply to Wallis approximations

Stoneham, [*On (j, epsilon)-normality in the rational fractions*](https://matwbn.icm.edu.pl/ksiazki/aa/aa16/aa1631.pdf),
1970, Theorems 4–6 and Type A definition, pp.227–233, gives this contract.
For reduced 0<Z/q<1, odd q coprime to g, write q=product p^a_p and set

```text
d_p=ord_p(g), z_p=v_p(g^d_p-1),
h_p=max({v_p(d_l): l>p divides q} union {0}),
t_p=min(a_p,z_p+h_p), D=product p^t_p.
```

If a_p>z_p+h_p for some p and 2<=g<q/D, the complete period has normalized
interval-count discrepancy less than D/q for half-open intervals wider than D/q.
Every j-word occurs if g^j<q/D, allowing a word to cross the period boundary.
This is uniform in the reduced numerator; it supplies no logarithmic bound
on the first occurrence's position. The parent visually checked the source
definition, residue progression theorem and discrepancy statements.

The half-open convention is material. The source writes open endpoints but
uses a floor-difference counting formula appropriate to a half-open interval.
Its strict discrepancy claim cannot be extended to arbitrary open endpoints:
at q=81, Z=1, g=16, D=3 and period 27, the interval (1/81,7/81) contains
only 4/81 and has discrepancy exactly 1/27=D/q. The strict half-open bound
follows from the residue progression count, and width>D/q still forces an
occurrence. Reduced q coprime to g has no orbit point at a nontrivial base-g
cell endpoint: an equality r/q=u/g^j with gcd(r,q)=1 would force q to divide
g^j. Thus the hexadecimal word application is unchanged. Independent review
identified this source-contract correction, recorded separately from the
preserved initial report.

The parent reproduced the counterexample and 3,321 half-open grid checks in
`/tmp/pi-m4-stoneham-endpoint-check-v1.py`, SHA-256
`2c36c685155a89ad5eaf947a2ed08fdf964eaa38f223b6664407017241137fb2`, exit 0.
The finite checks do not prove the universal progression theorem.

The actual approximants are

```text
c=pi/4,
r_n=product_(1<=k<=n)(1-1/(2k+1)^2)
   =16^n*(n!)^3*(n+1)!/((2n+1)!)^2=p_n/q_n.
```

They decrease to c, have odd denominators, and all their denominator primes
are at most 2n+1. Take n=(3^(s+1)-1)/2. Legendre's formula gives
v_3((2n+1)!)=n, v_3((n+1)!)=v_3(n!), and
4v_3(n!)=3^(s+1)-3-2s. Therefore

```text
v_3(q_n)=2s+2.
```

For g=16, d_3=1 and z_3=1. Any larger prime l dividing q_n has
d_l dividing l-1<3^(s+1), so h_3<=s. Consequently q_n/D_n>=3^(s+1).
Every fixed hexadecimal word occurs in a full rational period for large s.
This genuinely uses the Wallis identity and prime valuations. Elementary
lifting gives ord_(3^a)(16)=3^(a-1); hence its period T_n satisfies

```text
3^(2s+1) divides T_n,  T_n>=(2n+1)^2/3.
```

### Why that occurrence does not transfer to pi

The exact product recurrence and convergence imply
`r_n-c=sum_(k>=n) r_k/(2k+3)^2`. Using 3/4<c<r_k<1 and upper/lower
integral comparisons for the decreasing reciprocal square yields

```text
3/[8(2n+3)] < r_n-c < 1/[2(2n+1)].
```

If r_n and c share L fractional base-16 digits, their difference is strictly
less than 16^(-L), so necessarily

```text
16^L<8(2n+3)/3,  L<log_16(8(2n+3)/3).
```

This bounds the actual common prefix from above; it is not just a weak
guarantee from an error bound. No boundary-distance assumption is needed in
this direction. The complete-period occurrence bound lies far beyond this
prefix. It does not show that the actual occurrence must be late, but cannot
guarantee an occurrence among digits shared with pi/4.

Stoneham's [*On a sequence of (j, epsilon)-normal approximations to pi/4 and the Brouwer conjecture*](https://matwbn.icm.edu.pl/ksiazki/aa/aa42/aa4233.pdf),
printed 1983, pp.276–278, explicitly leaves that stable-prefix question open.
The parent visually checked it and the factorial formula on pp.266–267.
The base-16 application above is reconstructed from the 1970 theorem; it
does not assume that the 1983 printed base 2^alpha*p^beta permits beta=0.
No uninspected short-window theorem from its references is imported.

There is a precise denominator-only countertest. For s>=1, let K_n be the
largest nonnegative integer with 16^K_n<C_n=8(2n+3)/3. Every common prefix
length above is at most K_n. The rational 1/q_n has the same reduced
denominator, exact period and Type A data, but

```text
q_n>=3^(2s+2)=(2n+1)^2>C_n>16^K_n.
```

Its first K_n digits are zero, despite the full-period guarantee. Thus the
source's numerator-independent hypotheses cannot supply an early nonzero
digit. This does not refute an argument retaining the actual Wallis numerator.
Multiplication by four would transfer late orbit density from pi/4 to pi;
it cannot supply the missing density premise.

Corrected immutable report: `/tmp/pi-m4-stoneham-period-report-v2.md`, SHA-256
`249face80e5a7e2ab5a78d09b5b51d6c006351407f5b15ba2b06b7626ba32e21`.
The original v1 is preserved. Its endpoint correction is documented in
`/tmp/pi-m4-stoneham-period-endpoint-erratum-v1.md`, SHA-256
`3a946616b6c9f4904ad644ce9388559387312098b1d5b9f4237e481dd6fbfa89`.
The parent inspected and ran `/tmp/pi-m4-stoneham-period-check-v1.py`,
SHA-256 `5bdd7d964506954a6bc66553e48320354be7bfb1e09ec399b4e4c658162a253b`:
exit 0. Exact products, orders, Type A data and B1-based rational enclosures
were checked for s=0,...,6. Those finite checks certify no infinite theorem.
The primary PDF hashes are `cc7f2f9af2ccce3302505f36d68e24f8321ae2509953214acf5bafdde39ef75c`
and `9acc206574c7826dfc901498066bfc9df9763ba21ea737e9b1731a4581ffd095`.

## The actual Wallis numerator and full phase at three

There is a stronger actual identity. The integer
`Cat_n=binomial(2n,n)-binomial(2n,n+1)=binomial(2n,n)/(n+1)` gives

```text
r_n=16^n/[(n+1)(2n+1)^2*Cat_n^2].
```

Therefore the reduced numerator is a pure power of two. If b(m) counts
the binary ones in m, the factorial valuation v_2(m!)=m-b(m) gives exactly

```text
p_n=2^e_n,  e_n=4n+1-b(n)-b(n+1)>=2n.
```

At n_s=(3^(s+1)-1)/2, the full numerator phase modulo
A_s=3^(2s+2)=(2n_s+1)^2 is thus 2^e_n modulo A_s. Since n_(s+1)=3n_s+1,

```text
Delta_s=2+3b(n_s)+3b(n_s+1)-b(3n_s+1)-b(3n_s+2),
e_(n_(s+1))=3e_(n_s)+Delta_s,
p_(n_(s+1))=p_(n_s)^3*2^Delta_s.
```

Binary digit subadditivity makes Delta_s positive. This is an exact integer
identity; reducing it modulo A_s does not recover the two additional base-three
digits of the next residue from the old residue alone.

### Matching the full three-component still permits a zero prefix

For every s>=2 and every unit u modulo A=A_s, there is a reduced numerator

```text
1<=Z<q_n/16^K_n,  gcd(Z,q_n)=1,  Z=u mod A.
```

This can be proved without PNT. The bound 2^b(m)<=2m and r_n<1 imply
q_n>p_n>=16^n/[2(n+1)^2]. Put B=16^K_n and L=floor(q_n/(AB)). Since
A<=4(n+1)^2 and B<8(n+1),

```text
q_n/(AB)>16^n/[64(n+1)^5]>(3/2)*4^n>4^n+1, n>=13.
```

The middle inequality follows from 4^13>96*14^5 and the increasing ratio
4^n/(n+1)^5. Thus L>=4^n. There are at most k<=n-1 distinct prime factors
of q_n other than three: all lie among the n odd integers from 3 to 2n+1.
For each such prime p, the numbers u+At exclude one class of t modulo p.
Inclusion–exclusion for 0<=t<L gives a count of coprime choices at least

```text
L*product_(p|q_n,p!=3)(1-1/p)-(2^k-1)
  >=L*2^(-k)-(2^k-1)>0.
```

Each nonempty squarefree-divisor class has count error of absolute value
less than one; the empty divisor has no error. For the chosen representative
1<=u<A, every resulting Z=u+At is at most AL-1<q_n/B. This proves the strict
digit-cell bound and coprimality, uniformly in u. Since q_n/A is a unit at
three, the normalized local numerator unit is also preserved modulo A.
These replacement fractions have the same denominator and full-period data,
but their first K_n digits are zero. This excludes a phase-only inference;
it does not change the actual Wallis numerator.

### The global power-of-two constraint is not preserved by replacements

In fact the full phase plus the global numerator shape uniquely identifies
p_n. The elementary product bound 1-r_n<1/4 gives p_n<q_n<2p_n. Also
`ord_(A_s)(2)=2*3^(2s+1)>e_n`, by binomial lifting and e_n<2*3^(s+1).
Any pure power 2^f<q_n has f<=e_n; congruence to 2^e_n modulo A_s then
forces f=e_n. For s>=1, K_n>=1 and p_n>q_n/16^K_n, so the small replacement
matching the actual phase necessarily loses the power-of-two property.

Writing e_n=4*ell_n+h_n with 0<=h_n<4 yields the exact ordered shift

```text
r_n=16^ell_n*(2^h_n/q_n),
ell_n=n-ceil((b(n)+b(n+1)-1)/4).
```

The seed has exactly ell_n zero hexadecimal digits, followed by the digits
of r_n. This fixes a position near index n in the rational period; it does
not control words near that position. Retaining both global shape and full
phase recovers the actual rational but supplies no ordered-window theorem.

Immutable report: `/tmp/pi-m4-wallis-full-three-phase-report-v1.md`, SHA-256
`89245fb2743d7bed5213dd0357f7df72ddae856e9889c917c96b69d012187188`.
The parent inspected and ran `/tmp/pi-m4-wallis-full-three-phase-check-v1.py`,
SHA-256 `be22556b9a4645bcb8dfa2a11d1d96cf853a589c67ea17100effd0f8402d8331`:
exit 0. Formula/order tests run through s=6; all unit residues were exhausted
through s=4. The general replacement theorem is the paper count above,
deliberately stated only for s>=2 despite the smaller finite examples.

## Ramanujan reciprocal series: fast convergence and its arithmetic location

Ramanujan, [*Modular equations and approximations to pi*](https://ramanujan.sirinudi.org/Volumes/published/ram06.pdf),
1914, section 13, equations (28)–(29), PDF p.20/collection p.45, gives

```text
F=sum_(k>=0)(a*k+b)*binomial(2k,k)^3/2^(M*k)=c/pi,
(M,a,b,c)=(8,6,1,4) or (12,42,5,16).
```

The parent visually checked the primary-paper transcription. Its rising
factorials convert using (1/2)_k/k!=binomial(2k,k)/4^k. These are fixed
identities at the displayed modular specializations, not a theorem about
variable modular parameters. Put F_n equal to the sum through n,
A_n=2^(Mn)*F_n and x_n=c/(4F_n). For n>=1, pi/4<x_n<1.

The last term of A_n has two-adic valuation 3*b(n), where b is binary
digit sum. The term at n-j has valuation Mj+3b(n-j), exceeding it by at
least (M-3)j, because b(n)<=b(n-j)+b(j) and b(j)<=j. Thus exactly

```text
v_2(A_n)=3b(n),
x_n=p_n/q_n,
p_n=(c/4)*2^(Mn-3b(n)), q_n=A_n/2^(3b(n)) odd,
log q_n=Mn*log2-3b(n)*log2+O(1).
```

No odd factors cancel on inversion. The dyadic denominator of the reciprocal
approximation becomes a dyadic numerator for the approximation to pi/4.
The denominator grows exponentially even after minimal reduction.

Let t_k be the summand and r=2^(-(M-6)). For k>=1, the exact ratio test
reduces to positivity of

```text
4a*k^3+(6a+12b)*k^2+(a+18b)*k+7b-a.
```

This is positive for both specified pairs, including the pair with negative
constant term. Hence t_(n+1)<F-F_n<t_(n+1)/(1-r). From pi>3 and
binomial(2k,k)>=4^k/(2k+1),

```text
x_n-pi/4 > 9*(a(n+1)+b)*2^(-(M-6)(n+1))/[4c(2n+3)^3]=ell_n.
```

Every common hexadecimal prefix of length L therefore satisfies
16^L<G_n=1/ell_n and L<(M-6)n/4+O(log n). But the exact period T_n obeys
q_n dividing 16^T_n-1, so

```text
T_n>log_16(q_n)>=Mn/4-(3/4)b(n)+log_16(b).
```

The possible shared-prefix scale is smaller than this minimum period scale.
An entire-period occurrence bound cannot locate a word in that prefix by
its position bound alone. No full-period discrepancy theorem is asserted
applicable to these q_n. Even granting the earlier square-root Fourier
estimate's other premises, sqrt(q_n) is exponential while the real comparison
window here is linear.

There is a strict finite separation for n>=3:

```text
q_n/G_n >= 9b*(a(n+1)+b)*2^(3n-(M-6))/[4c(2n+3)^3] > 1.
```

The final expression exceeds one at n=3 and increases thereafter. Thus 1/q_n
has a zero prefix through the entire possible common-prefix ceiling, while
preserving every numerator-independent denominator/period hypothesis. This
does not preserve the actual Ramanujan numerator or its series recurrence.

### A denominator congruence controls the end of the seed period

There is finer arithmetic at n=2^s. Put B_n=binomial(2n,n). Removing the last
term and using b(2^s-j)=s-b(j-1), the remaining term valuations are
Mj+3s-3b(j-1)-3. The unique minimum occurs at j=1, proving exactly

```text
v_2(q_n-(an+b)*(B_n/2)^3)=3s+M-3.
```

For an odd q>1 and T=ord_q(16), the period integer of 1/q is
C_q=(16^T-1)/q, so C_q=-q^(-1) modulo 16^k for 1<=k<=T. The congruence
therefore controls the final O(log n) digits of that seed's period. It says
nothing directly about leading digits of x_n.

For the actual n=2^s numerator,

```text
x_n=16^h*(2^u/q_n), h=Mn/4-1,
u=1 for M=8, u=3 for M=12.
```

The seed has exactly h initial zeros. If its T-digit period integer is Z,
the actual period integer is R=16^h Z, with exactly h trailing hexadecimal
zeros. The last k seed positions shift to indices T-h-k+1,...,T-h of R;
indices at most zero mean leading padding, and only the overlap with 1,...,T
is a window in the actual period. No bound k<=T-h or useful relation between
T-h and the common prefix is assumed. The integer identity is equivalently
R/2^(4h+u)=-q_n^(-1) modulo 2^m for m<=4T. The controlled information lies
before the trailing zeros, not in those zeros or automatically at the start.
Even useful alignment would still require a word-coverage argument for the
controlled values. Both implications remain open.

The parent inspected the immutable report and its focused correction,
`/tmp/pi-m4-ramanujan-dyadic-report-v3.md`, SHA-256
`4e3107035a9070fcf60123b4c263e8fa9060fb66fad2428d00d99b50efbfc7cd`, and reran
`/tmp/pi-m4-ramanujan-dyadic-check-v1.py`, SHA-256
`ef2e62eabc925b3e0c41c66964b1b834678c67e29a4bbf26be5cd650e994e3f9`:
exit 0. It checks 514 valuations, 512 rational enclosures against BBP,
18 power-of-two congruences and 39 period-ending examples. The BBP enclosure
uses positivity of the actual coefficients as well as their absolute bound.
Parent inspection added the explicit leading-padding qualification above;
versions 1 and 2 and the short window erratum remain preserved. Independent
review of these claims is still pending.
The source PDF SHA-256 is
`478e2643fd7ca8a2dbbba23b60ae35608845c21d29019bb9d8dd9b0af27710a1`.
Source identities and the universal analytic arguments remain paper mathematics.

## An actual supercongruence and its first consumer

Long, [*Hypergeometric evaluation identities and supercongruences*](https://msp.org/pjm/2011/249-2/pjm-v249-n2-p09-p.pdf),
2011, Theorem 1.4, printed p.407, proves equation (2), p.406. For every
prime p>3, n=(p-1)/2 and chi_p=(-1)^n, it gives exactly

```text
sum_(k=0)^n (6k+1)*((1/2)_k/k!)^3*4^(-k)
  = chi_p*p mod p^4.
```

The rising-factorial normalization on p.407 makes this the M=8 family above.
The parent visually checked the formula, theorem and conversion. Congruences
are in the p-integral rationals; all denominators here are powers of two.
This theorem has no extra restriction modulo four and supplies no p^r
truncation extension. The nearby theorem with r concerns a different series.

Put d_n=3b(n), e_n=8n-d_n, N_n=2^e_n and q_n=A_n/2^d_n, so x_n=N_n/q_n.
Since the powers of two are p-units, the theorem gives

```text
v_p(F_n)=v_p(q_n)=1,
q_n=chi_p*p*N_n mod p^4,
q_n/p=chi_p*N_n mod p^3,
p*x_n=chi_p mod p^3.
```

Dividing by p loses one digit of precision; x_n itself has valuation -1
and cannot be treated as an integral unit. In particular the source's
modulus p^4 is not a claim that p^4 divides q_n.

At this prime, Stoneham's Type A inequality fails: a_p=1 while z_p>=1 and
h_p>=0. The theorem supplies no Type A excess at the controlled prime and
says nothing here about exponents of the other prime factors. At the smallest
legal p=5, x_2=8192/10335 and q_2=3*5*13*53 is entirely squarefree. Its
base-16 period has length 39 and omits digit 1. This is a finite diagnostic,
not an asymptotic noncoverage result. The excluded p=3 matters: F_1+3=135/32
has three-adic valuation three, so the modulus p^4 assertion fails there.

### The extracted local arithmetic still allows a different limit

Retain the exact numerator N=N_n and let Q be the least odd integer at least
3N with Q=q_n modulo p^4. The odd congruence class has spacing 2p^4, so

```text
3N<Q<3N+2p^4,
z_p=N/Q,
0<1/3-z_p<2p^4/(9N).
```

These fractions are reduced, retain v_p(Q)=1 and every normalized congruence
above, and have the same pure-power-of-two numerator. Setting A'_n=2^d_n Q
also preserves its exact two-adic valuation. For sufficiently large p,
Q<4N, so denominator height is comparable to the actual one. Yet z_p tends
to 1/3. More precisely e_n>=5n, and for n>=23,
`2*(2n+1)^4<3*2^n`: check n=23 and the increasing ratio
2^n/(2n+1)^4. Thus for primes p>=47,

```text
2p^4*16^n<3N,
0<1/3-z_p<1/(3*16^n).
```

Since 1/3=0.5555... in base16 and lies 1/(3*16^n) above its n-digit cell's
left boundary, z_p has n initial digits all five. These examples preserve
the extracted local arithmetic and exact primitive numerator, but **do not
preserve the actual hypergeometric denominator/recurrence or the pi limit**.
They reject an inference from those extracted properties alone. They do not
replace the actual approximants or prove an avoidance property of pi.

The immutable report `/tmp/pi-m4-long-supercongruence-report-v1.md` has
SHA-256 `c6fefc0b64861db434d5e7acbb885cd122f9e5263324771d794c5b2bcb701879`.
The parent inspected and ran `/tmp/pi-m4-long-supercongruence-check-v1.py`,
SHA-256 `4ac41198d0e5de2ef0efd15bb1e99e2c7506ab7c71d1170e008dcded604ac26f`:
exit 0. It checks primes 5 through 97, the p=3 exception, the exact p=5 period
and rounding examples. The primary PDF SHA-256 is
`18818633d9831e6a1f4d623c14e83b42ad2b487933cb19026c8db9b3d61a3c47`.
The universal theorem is a source dependency and the screening proof is paper
mathematics; neither is certified by the finite checks.

## Combining an entire prime interval and the known low bits

The actual extra summands extend Long's theorem simultaneously. Fix n>=1 and
a prime p>3 with n<p<=2n+1, and put m=(p-1)/2. For m<k<=n we have
p<=2k<2p and k<p, so v_p(binomial(2k,k))=1. Each added cubic summand is
divisible by p^3 in the p-integral rationals. Consequently

```text
F_n=chi_p*p mod p^3, v_p(q_n)=1,
q_n=chi_p*p*N_n mod p^3,
q_n/p=chi_p*N_n mod p^2, p*x_n=chi_p mod p^2.
```

At a prime endpoint p=2n+1 no terms are added: retain p^4 before division
and p^3 after division. The stronger precision fails elsewhere: n=3,p=5
gives v_p(F_n-5)=3. The n=0 assertion is vacuous. Write

```text
M_n=product_(p>3 prime, n<p<=2n+1) p^3,
epsilon_n=2n+1 if this is prime and >3, and 1 otherwise,
Msharp_n=M_n*epsilon_n.
```

At n=2^s the earlier exact datum is
`v_2(q_n-(6n+1)*(binomial(2n,n)/2)^3)=3s+5`.
Put b_n=3s+6 on this subsequence and b_n=1 elsewhere, and
L_n=2^b_n*Msharp_n. Congruence modulo L_n preserves all precision extracted
here, including the nonzero next bit in that valuation.

For the actual N=N_n and q=q_n, put delta=(q-3N) mod L_n and Q=3N+delta.
Since q is odd, N is even and L_n is even, delta is odd and 0<delta<L_n.
Thus Q is odd, N/Q is reduced, Q=q mod L_n, and

```text
z_n=N/Q, 0<1/3-z_n=delta/(3Q)<L_n/(9N).
G_n=16*(2n+3)^3*2^(2(n+1))/(9*(6(n+1)+1)),
K_n=max {K>=0 : 16^K<G_n}.
```

The latter two quantities are the proved M=8 common-prefix ceiling. If
L_n*G_n<3N_n, z_n has its first K_n hexadecimal digits all five: its
distance below 1/3 is less than 1/(3*16^K_n), the distance to that cell's
left endpoint. This uses the full ceiling without asserting that the actual
approximants achieve it. The exact numerator, simultaneous congruences,
endpoint precision, low-bit information and primitive valuation are retained.

The ordinary prime number theorem `Theta(x)=sum_(p<=x) log p ~ x` gives
log M_n=3n+o(n); see the assessed [Sutherland exposition](https://math.mit.edu/~drew/PrimeGapsOberwolfach1.pdf#page=3),
slide 3. The endpoint and low-bit factors add O(log n), since on powers of
two 2^b_n=64n^3. Also log N_n=8*log(2)*n+O(log n) and
log G_n=2*log(2)*n+O(log n). Therefore

```text
log(L_n*G_n/N_n)=(3-6*log(2))*n+o(n) -> -infinity.
```

The coefficient is negative since log(2)>1/2. The size condition holds for
every sufficiently large n, including powers of two. No explicit universal
threshold is inferred from finite examples. Moreover Q/N_n tends to 3 and
z_n tends to 1/3, with denominator height comparable to the actual q_n.

This strengthens the arithmetic countertest, but **does not preserve the actual
recurrence A_n=256*A_(n-1)+(6n+1)*binomial(2n,n)^3, its positive-tail enclosure,
or its pi/4 limit**. It rejects a consumer of these extracted congruences
alone, not a method retaining those other inputs.

Immutable report: `/tmp/pi-m4-global-prime-window-report-v1.md`, SHA-256
`a3a759308c5fd4811f046ba780be377937428fd844a213a2337f49c2554b29fd`.
The parent inspected and ran `/tmp/pi-m4-global-prime-window-check-v1.py`,
SHA-256 `27c320086b47635f59e3967c1ddef2b5a1292ea70dc1548a3337bf3bd6769472`:
exit 0. Through n=256 it checks 5,903 prime-window pairs, 247,415 added-term
valuations, 95 endpoint p^4 statements, nine combined low-bit cases and
244 all-five prefixes under the sufficient size condition. These are finite
sanity checks; Long's theorem, PNT and the universal argument remain paper
dependencies, not kernel-checked declarations.

## Changed continuation questions

The transform calculation supplies exact finer data but no modular estimate;
coarse pole and dyadic information is suspended as a visitation mechanism.
The Wallis test directs attention to the actual numerator's ordered orbit,
not another full-period denominator estimate. The full-phase screening test
is now complete and retains the actual global numerator shape as a distinction.
The fresh reciprocal-series test supplies genuine arithmetic data but leaves
its useful period location and word coverage open. The single-prime source
test and its full prime-window extension are complete. Even their combined
precision permits all-five prefixes through the possible transfer window.
Further refinements of these extracted congruences are suspended unless a
new consumer explains how they locate real leading digits. A fresh-context
recovery pass seeks a positive intermediate lemma retaining exact dependence
across approximation anchors, with a concrete consumer for V.
Each finite bound requires
reassessment and a changed question when needed, not an end to M4 research.

## Arcsine prefixes retain an odd-division carry

[DLMF 4.24.1](https://dlmf.nist.gov/4.24.E1), at the principal real value
arcsin(1/2)=pi/6, gives pi=3*sum_(j>=0)binom(2j,j)/[(2j+1)*16^j].
For n>=0 let T_n be this series truncated at j=2n and multiplied by16^n.
The elementary induction binom(2j,j)<=4^j/sqrt(j+1) and a geometric sum give

    16^n*pi=T_n+epsilon_n,
    0<epsilon_n<=1/[(4n+3)*sqrt(2n+2)] ->0.

This is a genuine actual-orbit approximation. To expose its exact consumer,
write R_n=bbpTail(n). The checked BBP identity gives

    bbpRecurrence(n+1)=fract(fract(T_n)+epsilon_n-R_n),
    epsilon_n-R_n ->0.

Arbitrarily late visits of fract(T_n) to every open interval would therefore
give V by inner intervals and a threshold exceeding the requested N. No such
visitation theorem, compiled arcsine interface or new Lean export is supplied.

For m>=0 set L_m=lcm{1,3,...,2m+1} and
Z_m=3*sum_(j<=m)16^(m-j)*binom(2j,j)/(2j+1). Legendre's formula gives
v_2 binom(2j,j)=s_2(j). The term r positions before the last has excess
4r+s_2(m-r)-s_2(m)>=3r, so the last term is uniquely minimal and
v_2(Z_m)=s_2(m). For m=2n,n>=1, reduce Z_m/2^s_2(m)=u_m/q_m with
u_m,q_m odd, q_m>0. Then

    T_n=u_m/[2^d*q_m], d=4n-s_2(n)>0.

The odd factor remains: q_m divides L_m, and every prime p>3 in
(m,2m+1] survives in q_m by its unique pole and the binomial unit
binom(p-1,(p-1)/2)=(-1)^((p-1)/2) modulo p.
Modulo 2^h, the normalized Z_m is determined by its last ceil(h/3) terms
(or all terms if fewer), because every omitted normalized term has valuation
at least h. This is a residue formula, not a surjectivity statement.

Let r_m=u_m mod q_m and z_m=u_m*q_m^(-1) mod2^d, with inverses used only
in this congruence and residues chosen nonnegative. Exact Euclidean division
gives

    fract(T_n)=((z_m-r_m*q_m^(-1)) mod2^d)/2^d
                    +r_m/(2^d*q_m).

The last real term is below2^-d, but the modular-inverse contribution of
r_m is uncontrolled. Fixed leading real words also require information near
the high end of this growing d-bit quotient, not just fixed low precision.
For a generic separation, the reduced fractions with q=3 and numerators
3+2^(d+h),3+2^(d+h+1) have normalized odd parts congruent modulo2^(d+h),
yet circular real separation 1/3 after division by2^d. They are synthetic,
not actual arcsine numerators. An actual coupled numerator/remainder identity
could still matter; binomial valuations alone have not provided one.

Frozen report `/tmp/pi-m4-arcsin-prefix-20261127/report-v1.md` has SHA-256
`9465a091cd31eca91041b6f78d3ea044d0f3fbbc9fe381545ba8d2a90ab0363a`.
The parent verified the original DLMF equation/domain, reconstructed the
argument and replayed an unchanged checker: 36,484 coefficient/synthetic
checks, exit 0, identical receipt and six preserved artifacts. No actual
arcsine prefix, pi phase or digit was computed. Independent paper criticism
found no defect; its explicit direct-to-V offset/error clarification appears
above. Universal statements remain paper mathematics, and V remains open.

## Disk-count dissection cancels the area coefficient

A direct geometric test uses r2(m), the number of integer pairs with squared
norm m. For positive integer q, put C(q)=sum_(0<=m<q)r2(m)+r2(q)/2 and
P(q)=C(q)-pi*q. At q=16^n the boundary has four points and the nonzero
interior points occur in rotational sets of four. Thus C(q)=3 mod4 and
fract(-P(16^n))=fract(16^n*pi).

Choose an even smooth probability density eta supported in (-delta,delta),
0<delta<1/16. The function F(x)=integral eta(t)*1_(|x|^2<=q+t)dt is compact
smooth, has lattice sum C(q), and has integral pi*q. Poisson summation for
Schwartz functions, [Elkies, March 2009 draft, Theorem 2, printed p.10](https://people.math.harvard.edu/~elkies/aws09.pdf),
applies to the self-dual lattice Z^2 with covolume one. Radial evenness
reconciles the source's positive Fourier kernel with the negative convention.
[DLMF 10.9.1](https://dlmf.nist.gov/10.9.E1) and
[10.22.1](https://dlmf.nist.gov/10.22.E1) give

    P(q)=sum_(m>=1) A_m(q;eta),
    A_m(q;eta)=r2(m)*integral eta(t)*sqrt((q+t)/m)
                            *J1(2*pi*sqrt(m*(q+t)))dt.

Absolute convergence follows from Schwartz Fourier decay; no unsmoothed
Bessel series is substituted. Set eta16(t)=eta(t/16)/16. Its support remains
within (-1,1), preserving exact integer lattice samples and area. The identity
r2(16m)=r2(m) gives A_m(16q;eta16)=16*A_(16m)(q;eta). Consequently

    H(q)=sum_(m>=1,16 does not divide m) A_m(q;eta),
    -16*H(q)=P(16q)-16*P(q)=C(16q)-16*C(q).

The pi coefficient cancels. At q=16^n this implies H(q) belongs to
1/16+(1/4)*Z; it does not locate P(q) modulo one. For each fixed m,
[DLMF 10.17.3](https://dlmf.nist.gov/10.17.E3), at fixed order one and positive
real arguments tending to infinity, instead gives

    A_m(16^n;eta)=r2(m)*2^n/(pi*m^(3/4))
        *cos(2*pi*4^n*sqrt(m)-3*pi/4)+O_(eta,m)(2^(-n)).

This estimate is not summed over unbounded m. No sufficiently small absolute
tail estimate or control of the selected lacunary phases is supplied.

The extracted recurrence alone admits a nondense irrational comparison:
gamma=3+sum_(j>=0)16^(-2^j), C_gamma(n)=4*floor((gamma*16^n-1)/4)+3,
E_gamma(n)=C_gamma(n)-gamma*16^n. Its phases lie in [0,1/15], yet
-2<E_gamma(n)<=2 and E_gamma(n+1)-16*E_gamma(n) is an integer congruent to
3 modulo4. This comparison loses the actual disk and Bessel coefficients;
it rejects only the proposed use of the extracted identities.

The immutable packet `/tmp/pi-m4-direct-pi-discovery-20261127/` and
parent source/replay packet `/tmp/pi-m4-disk-parent-review-20261127/`
retain the full argument. Parent unchanged-copy replay matched 256 scaling
cases and five dyadic count cases with zero pi evaluations; these finite
checks establish no analytic theorem. Independent paper/source criticism
found no defect and retained uncancelled phase control as open. The specific
dissection consumer is suspended. This is paper mathematics, not a new Lean
result or movement of the visitation frontier.
