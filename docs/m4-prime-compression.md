# M4: prime compression and the exact denominator exponent

Research checkpoint, 2026-11-26; independent review complete. The paper argument
here proves log q_n=6n+o(n), where q_n is the actual reduced denominator of
the weighted BBP prefix. This is stronger than a coefficient-clearing bound.
It also closes a specified primitive-reduction opening in the interval-based
Pade test. Neither result proves V; no new Lean export or M4 acceptance is claimed.

Use natural logarithms and the fixed definitions

    A(j)=4/(8j+1)-2/(8j+4)-1/(8j+5)-1/(8j+6),
    S_n=sum_(j=0)^n 16^(n-j)*A(j),  q_n=denominator(S_n),
    S_(-1)=0.

The [checked bridge](proof-blueprint.md) is y_(n+1)=fract(S_n), with the
original zero initialization. The exact universal interval/threshold contract
in the [proof plan](proof-plan.md#5-prove-the-missing-universal-visitation-theorem)
is unchanged.

## Exact compression of the principal part at a prime

Let p>=7 be prime, p^2>8n+6, and n=p*h+s with 0<=s<p. Rational congruences
are in the localization at p. For (r,c_r)=(1,4),(4,-2),(5,-1),(6,-1), set

    delta_r = least positive residue of p*r modulo 8,
    b_r=(p*delta_r-r)/8,
    chi_p=1 if p=1,7 mod8, and -1 if p=3,5 mod8,
    w_r=c_r*chi_p^(delta_r)*2^((r-delta_r)/2).

The exponent is integral; negative exponents mean reciprocals. Since p^2=1
modulo 8, the original poles divisible by p occur exactly at
j=b_r+p*t, with 0<=b_r<p and 8j+r=p*(delta_r+8t). For j<=n the last factor
is less than p. Multiplication of S_n by p therefore kills all other terms
modulo p and makes every retained term p-integral.

The elementary supplemental law 2^((p-1)/2)=chi_p modulo p follows by taking
the signed representatives of 2,4,...,p-1 in the half residue interval.
Their absolute values permute 1,...,(p-1)/2, and the number of negative signs
is (p-1)/2-floor(p/4). The same permutation product on nonzero residues gives
Fermat's identity. Thus

    c_r*16^(-b_r)=w_r mod p,   16^(-p*t)=16^(-t) mod p.

The full table is:

| p mod8 | (delta_1,w_1) | (delta_4,w_4) | (delta_5,w_5) | (delta_6,w_6) |
| --- | --- | --- | --- | --- |
| 1 | (1,4) | (4,-2) | (5,-1) | (6,-1) |
| 5 | (5,-1) | (4,-2) | (1,4) | (6,-1) |
| 3 | (3,-2) | (4,-2) | (7,1/2) | (2,-4) |
| 7 | (7,1/2) | (4,-2) | (3,-2) | (2,-4) |

Ordering by delta gives two complete coefficient states:

    A^+(t)=A(t),
    A^-(t)=-4/(8t+2)-2/(8t+3)-2/(8t+4)+1/[2(8t+7)],
    S^sigma_m=sum_(t=0)^m 16^(m-t)*A^sigma(t),
    S^sigma_(-1)=0.

Choose sigma=+ if p=1 mod4, and sigma=- if p=3 mod4. Collecting the complete
blocks t<h and the actual incomplete block t=h proves

    p*S_n = 16^s*[16*S^sigma_(h-1)+E_(p,h,s)] mod p,
    E_(p,h,s)=sum_(r:b_r<=s) w_r/(8h+delta_r).                (1)

Here 16^n=16^(h+s) modulo p supplies the factor. Every denominator of a
complete block or included boundary term is prime to p. Omitted boundary
terms need not have that property and have not been inserted into (1).
Since p>=7 and original offsets differ by at most 5, the b_r increase strictly
with delta_r. The actual partial block is therefore an initial segment in
the displayed state's delta order, not an arbitrary subset.

## Fixed-scale survival, with the endpoint cancellation retained

Call p eligible at n when

    p=1 mod8 and p<=8n+1; or
    p=5 mod8 and p<=8n+5; or
    p=3 mod4 and p<=4n+3.                                  (2)

These are precisely the first-pole entry conditions. The first two alternatives
together equal p=1 mod4 and p<=8n+5, by their integer residue classes.

Every nonempty initial partial sum of A^+(h) is positive: the negative terms
have larger denominators than the positive term, and total coefficient
magnitude at most 4. Every such partial sum of A^-(h) is negative: its sole
positive term is last and smaller than the magnitude of the first negative
term. The complete sums and their weighted prefixes have the same signs.

Let E^sigma_(h,ell) be the first ell terms of the ordered state, and put

    C_(h,sigma,ell)=16*S^sigma_(h-1)+E^sigma_(h,ell).

These rational numbers are nonzero for h>=1, 0<=ell<=4, and for h=0, ell>=1.
Eligibility excludes h=0,ell=0. Fix an integer H>=1. The finitely many such
C with h<=H have bounded nonzero numerators and bounded denominators. For
all sufficiently large n, every prime p>n/(H+1) exceeds those bounds and
satisfies p>=7 and p^2>8n+6. Also floor(n/p)<=H. Formula (1) then proves

    for each fixed H, all sufficiently large n, and every eligible
    prime p>n/(H+1), one has v_p(S_n)=-1.                   (3)

The order of quantifiers is essential. No uniform result for H growing with
n, or survival of every prime above the square-root scale, follows.
In fact n=9,p=19=2n+1 is an actual cancellation: its included negative-state
terms sum to -4/2-2/3-2/4=-19/6, so 19 does not divide q_9.

A useful finite-index special case is survival of every eligible p>=7 with
p>2n+1. Only p,2p,3p can then occur as original denominators. In the positive
state there is a unique pole with residue 4 or -1. In the negative state the
first residue is -1/2; if the optional 3p pole enters, the combined residue,
after factoring its nonzero dyadic weight, is 16/3 for p=3 mod8 and -4/3 for
p=7 mod8. The supplemental law above gives these constants. All are nonzero
for p>=7. The equality case p=2n+1 has deliberately not been included.

## The evaluated denominator exponent

Write theta(x;4,a)=sum_(p<=x,p=a mod4) log p. The only external asymptotic
input is theta(x)~x and theta(x;4,a)~x/2 for fixed a=1,3, from the
[prime number theorem in fixed progressions](https://math.mit.edu/~drew/PrimeGapsOberwolfach1.pdf#page=3).
The source's coprimality condition holds. No variable-modulus or short-interval
estimate is used.

For each fixed H, (3) gives

    log q_n >= theta(8n+5;4,1)+theta(4n+3;4,3)
               -theta(n/(H+1))-O(1)
            = (6-1/(H+1))*n+o(n).

Take the limit inferior in n first, then let H grow. The result is at least 6.
For the reverse bound, q_n is odd and divides the odd part of
lcm(1,...,8n+6), using the original four summands. A prime p=1 mod4 in its
support is at most 8n+5. A prime p=3 mod4 is at most 4n+3: in an odd pole
denominator congruent to 1 modulo 4 its odd multiplier is at least 3; the
other two pole denominators reduce to odd factors at most 2n+1 and 4n+3.
Higher prime powers contribute at most sqrt(8n+6)*log(8n+6)=o(n), since their
primes are at most sqrt(8n+6) and each contributes at most log(8n+6). Hence

    log q_n <= theta(8n+5;4,1)+theta(4n+3;4,3)+o(n),
    log q_n = 6n+o(n).                                    (4)

This is the reduced denominator of the actual evaluated prefix. The proof
does not assume that every prime in a coefficient-clearing integer survives.

## Primitive evaluation and the restricted interval obstruction

Use the [degree-two family](m4-pade-residues.md) with L=m+2, m>=2,
Q=u0+u1*z+u2*z^2 integral, H(z)=sum A(j)z^j, and P=trunc_L(QH). Put

    b=A(L), c=A(L-1), D_bc=lcm(den(b),den(c)),
    V=256*u0+16*u1+u2 != 0,
    W=16*b*u1+(16*c+b)*u2.

The exact convolution identity is

    256*16^L*P(1/16)=S_L*V-W.                              (5)

For any positive coefficient-clearing delta for P, let alpha=delta*V and
beta=delta*16^L*P(1/16), and let alpha'=abs(alpha)/gcd(abs(alpha),abs(beta)).
This is the positive reduced denominator of beta/alpha. Multiplying
alpha'*(S_L*V-W)/(256*V), which is an integer, by 256*V*D_bc shows that
alpha'*D_bc*S_L*V is an integer. Thus

    q_L divides alpha'*D_bc*V,
    height(Q)*alpha' >= q_L/(273*D_bc)=exp(6L+o(L)),         (6)

because abs(V)<=273*height(Q) and D_bc<=(8L+8)^8. All evaluated gcd
cancellation is included. The optional Pade equation
A(L+1)*u0+A(L)*u1+A(L-1)*u2=0 is not needed for this divisibility.

Under the explicit additional budget height(Q)<=16^L*L^C for a fixed C,
(6) implies alpha'/16^(L-2) tends to infinity, since 6>2*log 16.
In the [signed identity](m4-signed-evaluation.md), divide the residual by its
gcd and replace the allowed tail tau by a convex hull of fixed width w>0.
The resulting residual interval has width alpha'*w, eventually greater than
M=16^(L-2). Every real interval longer than M contains an integer in each
residue class modulo M. Therefore this interval cannot exclude the residual
using only a nonempty congruence condition modulo M, even after primitive
normalization. The existing modular construction has the stated height budget.

This conclusion retains degree two, the specified L and modulus, V nonzero,
the fixed polynomial height factor, and the fixed positive hull width.
It does not assert that all these integers are actual residuals. A nonconvex
tail set, a dependence estimate for tail and remainder, another family or a
larger height budget is outside this obstruction. The shared-tail question
continues alongside the [joint forward test](m4-forward-polynomials.md).

## Real-character limitation

When (1) is nonzero, it supplies the actual principal coefficient p*S_n modulo
p for the factor exp(2*pi*i*c/p) of the real character of S_n. For primes on
any fixed linear scale it is a dyadic power times one of finitely many explicit
rational states. The real character is a product over all denominator prime
powers, and those factors are coupled. Preventing local cancellation does not
bound the average of their product over forward n. No estimate neutralizing
the complementary factors, or forcing an arbitrary real interval visit, is
proved here.

## The actual backward branch has a different exponent

This extension passed independent review. It tests (4) against the existing
[negative-branch stress test](m4-two-adic-reflection.md#7-exact-real-characters-and-the-missing-odd-correction),
which retains the rational coefficient function but has concentrating real
characters. Put, for m>=1,

    D(t)=A(-t-1)=1/(8t+2)+1/(8t+3)+2/(8t+4)-4/(8t+7),
    R_m=sum_(t=0)^(m-1)16^t*D(t),  X_m=-16^(-m)*R_m.

The previously reviewed reflected identity gives v_2(R_m)=4m+v_2(m).
Thus X_m has odd denominator and den(X_m)=den(R_m); division by 16^m adds
no dyadic denominator cost.

For prime p>=7 with p^2>8m-1, write m-1=p*h+s. The compression now uses
increasing weights: for (r,c_r)=(2,1),(3,1),(4,2),(7,-4), take the same delta
and b as above, but w_r=c_r*chi_p^delta*2^((delta-r)/2). The two states are
D for p=1 mod4 and

    C(t)=-1/[2(8t+1)]+2/(8t+4)+2/(8t+5)+4/(8t+6)

for p=3 mod4. If T^sigma_h=sum_(t<h)16^t*D^sigma(t), then

    p*R_m = T^sigma_h+16^h*E_(p,h,s) mod p.                 (7)

Again E contains exactly b_r<=s and is an initial segment of the state's
ordered offsets, namely (2,3,4,7) or (1,4,5,6). All included denominators
are p-integral. Eligibility is p=1 mod4, p<=4m-3, or p=3 mod4, p<=8m-1;
the latter means p<=8m-5 in class 3 modulo 8 and p<=8m-1 in class 7.

There is now an exact zero state. For h=0 the first two C terms sum to
-1/2+2/4=0. It occurs precisely on the strips

    p=3 mod8: (8m-1)/5 < p <= 2m-1,
    p=7 mod8: (8m-5)/5 < p <= 2m-1.                       (8)

The second term enters at b_4=(p-1)/2; the third enters at (5p-7)/8 or
(5p-3)/8, giving these endpoints. For p>=7 the strips imply h=0 and
8m-1<5p+4<p^2. Thus every such p is wholly absent from den(X_m), not just
reduced in exponent.

All other eligible rational states are nonzero. The D partial sums are
positive. At h=0 the C partial sums are -1/2, 0, 2/5, 16/15. For h>=1 its
smallest nonempty value is Q_h=T^C_h-16^h/[2(8h+1)]. One has Q_1=8/45 and

    Q_(h+1)-Q_h
      =16^h*[2/(8h+4)+2/(8h+5)+4/(8h+6)-8/(8h+9)]>0.

The positive numerators total 8 and their denominators are strictly smaller
than the negative term's denominator. Empty final blocks are positive too.
The fixed-H argument used for (3) therefore proves eventual survival on every
fixed linear scale outside (8). This does not exclude isolated modular
cancellation: m=20,p=13 has compressed value 2496/385, nonzero rationally but
zero modulo 13.

The two strips together have weighted prime mass
theta(2m;4,3)-theta((8/5)m;4,3)+O(log m)=m/5+o(m).
The bounded endpoint differences need no short-interval theorem or modulus-8
asymptotic. Eligible support has total weighted mass 6m+o(m). Lower bounds
follow by deleting the strips and primes <=m/(H+1), then taking limits in
that order; upper bounds use the exact strip absence and the same negligible
higher-power estimate as before. Consequently

    log den(X_m)=(29/5)*m+o(m).                            (9)

Thus the positive exponent 6 distinguishes this actual opposite-direction
example. The difference alone still gives no real-visitation implication.
Even scalar exponent 6 is reproducible by the analytic avoiding model: replace
its mesh denominator by 3^d_n, d_n=ceil(6n/log 3)+12, and choose its mesh
numerator not divisible by 3. Such numerators have gaps at most 2, so the finer
mesh keeps the old error allowance. Earlier interpolation contributions have
strictly smaller powers of 3 in their denominators, whereas the new term is a
3-unit numerator over 3^d_n. The prefix denominator therefore has exact
3-exponent d_n and at most a bounded factor 5, giving log denominator=6n+O(1).
The 2-adic interpolation bounds persist. This model still loses the exact
rational forcing and polynomial coefficient height; it is not a model for
the full principal-part data.

The parent reconstructed and reran the frozen negative-branch checker, exit 0:
40,557 compression comparisons, 32,271 prime-power checks, 1,125 strip absences
and 256 dyadic cancellations. These are finite diagnostics. Evidence:

- `/tmp/pi-m4-negative-denominator-report-v1.md`, SHA-256
  `6d7b05a53c13b22903234fb5ff212a73c69ed10f0ba3dbcf069e56c87f5b2d80`.
- `/tmp/pi-m4-negative-denominator-check-v1.py`, SHA-256
  `b6aa74fd662476dfbf882cb0f171339dcdef795bdc9013d88198d06432b1c694`.
- `/tmp/pi-m4-negative-denominator-receipt-v1.json`, SHA-256
  `6df38b71fe9ab808ce4ddc1edf3dec7d27f6f289e7bf6052cf3d0ef98f0dde72`.

## The alternate state is a reflected real phase

The negative-coefficient state Ahat introduced by the positive compression
has an exact real interpretation. With

    Ahat(n)=-4/(8n+2)-2/(8n+3)-2/(8n+4)+1/[2(8n+7)],
    Shat_n=sum_(j=0)^n16^(n-j)*Ahat(j), U_n=S_n+Shat_n,

its weighted infinite sum is -pi. This is the positive-index alternate state,
not the opposite-direction branch X_m above. Define

    F(z)=log[(2-z^2)/(z^2-2z+2)],
    P_0(z)=1-z-z^2/2-z^3-z^4/4-z^5/4+z^6/8.

The existing [null-kernel identity](m4-rational-forcing.md) gives
P_0=(1-z^8/16)*F', F(0)=F(1)=0, and

    D(n):=A(n)+Ahat(n)=4*integral_0^1 z^(8n)*P_0(z) dz.

Uniform geometric convergence on [0,1] therefore gives sum D(n)/16^n=0.
The actual BBP identity proves the asserted -pi constant. For M=8n+8,
the exact remaining tail and integration by parts give

    U_n=-sum_(k>=1) D(n+k)/16^k
       =-(1/4)*integral_0^1 z^M*F'(z) dz
       =(M/4)*integral_0^1 z^(M-1)*F(z) dz.               (10)

Both logarithm arguments are positive on [0,1]. Since their difference is
2z(1-z), F is positive in the interior. The elementary bounds
z(1-z)<=F(z)<=2(1-z), strict for the upper bound in the interior, imply

    M/[4(M+1)(M+2)] <= U_n < 1/[2(M+1)]=1/(16n+18).

In particular U_n>0. The endpoint derivatives F'(1)=-2, F''(1)=-8 and a
uniform cubic Taylor remainder give

    U_n=1/[2(M+1)]-2/[(M+1)(M+2)]+O(M^(-3))
       =1/(16n)-13/(128n^2)+O(n^(-3)).

This controls the real relation Shat_n=-S_n+U_n, rather than providing an
independent phase. With e(t)=exp(2*pi*i*t), for every integer h,

    abs(e(h*Shat_n)-conjugate(e(h*S_n)))
      <=2*pi*abs(h)/(16n+18).                            (11)

The same bound with n replaced by N holds for the difference of any finite
nonempty averages over indices n>=N. Their pointwise product tends to 1.
Reflection and strict inner intervals transfer late visitation between the
two states, but establish neither visitation theorem.

The arithmetic transform is equally coupled. For an odd residue class s
modulo 8, move offset r to delta=s*r mod8 in {1,...,7}, multiplying its
coefficient by chi_s^delta*2^((r-delta)/2), where chi_s is 1 for s=1,7
and -1 for s=3,5. This rational linear map T_s satisfies T_s^2=identity
and T_s*T_t=T_(st mod8). It fixes A and Ahat separately for s=1,5, swaps
them for s=3,7, and fixes D for every class.

For primes p>=7, p^2>8n+7 and n=p*h+s_0, formula (1)'s compression applies
to each of the three vectors c in {A,Ahat,D}, with transformed prefix T_p c:

    p*S^c_n =16^s_0*(16*S^(T_p c)_(h-1)
                +sum_(r:b_r<=s_0) w_r/(8h+delta_r)) mod p.

Here b_r=(p*delta_r-r)/8 and w_r is the transformed coefficient. The square
bound retains the alternate offset 7. These vectors have dyadic coefficients,
so their coefficient denominators are p-units, as required by pole extraction.
All included compressed denominators are p-units;
the empty prefix at h=0 is zero. In particular the small real null prefix U
reproduces itself under this compression. Its endpoint sum must use its own
offset thresholds; it cannot be replaced by a full D coefficient.

For canonical residues a=p*S_n mod p, ahat=p*Shat_n mod p and u=p*U_n mod p,
write a+ahat=u+p*k, where k is 0 or 1. The p-integral cofactors satisfy

    (S_n-a/p)+(Shat_n-ahat/p)=U_n-u/p-k.                  (12)

The integer quotient and null state's own p-component remain present.
Starting the two actual forced recurrences at S_N+epsilon and Shat_N-epsilon
preserves their sum U_(N+j) at every future step, while their individual
errors are opposite 16^j*epsilon. The existing finite entry construction
therefore also preserves this sum and both corresponding prime/dyadic data.
It does not preserve either global zero initialization or automatically the
alternate reduced denominator. The sum relation alone fails to select the
actual pair. This is a concrete instance of the previously recorded fixed
null-family limit, not a new independence or averaging principle.

The parent reconstructed the integral, endpoint expansion, transform and
cofactor identities and reran the exact checker, exit 0. It checked 33,744
principal-part comparisons, 11,248 cofactor identities and 315 paired-entry
identities, alongside finite polynomial and rational-bound checks. A separate
observed 2-adic valuation pattern is not used as a universal theorem. Frozen
report `/tmp/pi-m4-conjugate-state-report-v1.md`, SHA-256
`bcb9f629c2a7b531c8c63fed6bf5a055f3d4bd6eefa6d0f21d67a7324db51ff9`,
has version1 checker, receipt and manifest siblings. The first missing real
estimate still concerns the actual globally initialized phase; substituting
the alternate state replaces it by its reflected copy.

## The antisymmetric sign does not determine the real CRT phase

Set R=A-Ahat and W_n=S_n-Shat_n, retaining D=A+Ahat and U_n above.
The antisymmetric kernel has a pure arctangent interpretation:

    K_R(z)=4+4z+2z^2-z^4-z^5-z^6/2,
    K_R(z)/(1-z^8/16)=8/[(z-1)^2+1].

Uniform geometric convergence on [0,1] gives sum R(n)/16^n=2*pi by
8[arctan(z-1)]_0^1. The exact rational identity is 2*S_n=U_n+W_n.
The local transform sends R to chi_4(p)*R, with chi_4(p)=1 for p=1 modulo 4
and -1 for p=3 modulo 4. This is the elementary Frobenius action on the
kernel's conjugate roots 1+i and 1-i.

For p>=7, p^2>8n+7 and n=p*h+s, compression retains the actual endpoint set:

    p*W_n=chi_4(p)*16^s*(16*W_(h-1)+J^R_(p,h,s)) mod p.

Here J^R sums R's coefficient at delta_r, divided by 8h+delta_r, over original
offsets r whose threshold b_r=(p*delta_r-r)/8 is at most s. The common chi_4
factor has already been taken outside the sum. The empty prefix is zero. The
corresponding formula for U has its own D endpoint set. These are dyadic
coefficient vectors, so the coefficient-domain condition above holds.

The complete real phase requires every prime power. For rational x=P/q,
define a_p=p^e*x mod p^e when p^e exactly divides q, taking canonical
residues. Then x-sum_p a_p/p^e is integral and

    e(x)=product_p e(a_p/p^e), e(t)=exp(2*pi*i*t).         (13)

The formula also works on a common denominator. The common denominator of
S_n,U_n,W_n is odd: in addition to A's odd denominators,

    Ahat(n)=-2/(4n+1)-2/(8n+3)
             -3(n+1)/[(2n+1)(8n+7)].

For each common prime power, the actual components therefore satisfy

    2*a_S=a_U+a_W mod p^e,
    a_S=2^(-1)*(a_U+a_W) mod p^e.                         (14)

At a large first-power prime in the compression range,
a_W=chi_4(p)*b_(p,n), where b_(p,n) includes 16^s, the compressed prefix
and the endpoint sum. Those weights depend on p and n. Equations (13)--(14)
retain the exact initialized product; a mean of chi_4 over primes is a
different expression. No independence of its factors is supplied.

The inverse of 2 in (14) is modular. Dividing a real CRT expression by 2
can retain a sign from its discarded integer part. For example 4/3 has
principal coefficient 1 modulo 3, but e((4/3)/2)=e(2/3), not e(1/6).
The exact identity 2S=U+W or the full local inverse avoids dropping that sign.

Quadratic Gauss sums do not recover the missing numerator information.
For chi_p the Legendre character and tau_p(a)=sum_x chi_p(x)*e(a*x/p),
change of variables and the elementary norm-square calculation give

    tau_p(a)=chi_p(a)*tau_p(1) for p not dividing a,
    tau_p(1)^2=chi_4(p)*p.

The square explains the eigen-sign, but even tau_p(a) retains only the
quadratic symbol of a. At p=7, numerators 1 and 2 give the same tau yet
distinct additive characters. Substituting such a Gauss phase for a factor
in (13), or inferring cancellation of the whole product from balanced prime
signs, is unsupported.

A same-kernel backward test makes the directional limitation concrete. Put

    B_R(t)=R(-t-1),
    Y_m=-16^(-m)*sum_(t=0)^(m-1)16^t*B_R(t), m>=1.

The increasing-weight transform, whose power of 2 is 2^((delta-r)/2),
again sends B_R to chi_4(p)*B_R. Its compression retains its own endpoints
and requires p^2>8m-1. Nevertheless abs(R(-r))<=25/(2r) for r>=1, and
splitting the geometric sum at floor(m/2) gives

    abs(Y_m)<=5/(3m)+(5/6)*16^(-floor(m/2))<=5/(2m).

Thus e(h*Y_m) tends to 1 for every integer h, with all prime-power factors
retained in its CRT expression. No unproved dyadic cancellation is needed.
The same rational kernel and prime eigen-sign therefore cannot justify an
orientation-blind cancellation argument. Positive-time initialization and
the coupled actual numerators remain essential to any surviving estimate.

The parent reconstructed the kernel, CRT, Gauss and backward arguments and
reran the exact checker, exit 0. It checks 12,118 component relations, 387
CRT reconstructions, 11,248 endpoint/sign/phase comparisons, 129 backward
bounds and CRT reconstructions, 13 Gauss squares and 266 twists, plus the
kernel and eigen-identities. Frozen report
`/tmp/pi-m4-antisymmetric-sign-report-v1.md`, SHA-256
`6d95db5988ad6278cb6de7714a8a0878cfc0a0fea275b07f1936ae8bf41802b9`,
has version1 checker, receipt and manifest siblings. These are paper
diagnostics reviewed with no D/I/Q items, not a bound on the actual
positive-time average.

## The actual null state has denominator exponent eight

Here D=A+Ahat is the positive-index null forcing, not the unrelated
backward coefficient called D earlier. Its ordered vector at r=1,...,7
is (4,-4,-2,-4,-1,-1,1/2), and U_n=S_n^D. The established bounds give
0<U_n<1/(16n+18) and U_n~1/(16n). The apparent half-denominator terms
combine to -2(n+1)/[(4n+3)*(8n+7)], so U_n has odd denominator.

The prime transform fixes D for every odd residue class. To apply the
fixed-scale compression argument, let C_(h,l) be 16*U_(h-1) plus the
first l ordered terms of D(h), with U_(-1)=0. Every eligible partial
state is nonzero. The full state is U_h>0; the penultimate one is
U_h-1/[2*(8h+7)]<0; the preceding one adds 1/(8h+6) and is positive.
Earlier nonempty states are positive by the signs and ordered denominators.
Only the ineligible empty state at h=0 is zero.

For fixed H, compression at n=ph+s and sufficiently large n therefore gives
v_p(U_n)=-1 for every prime n/(H+1)<p<=8n+7, p>=7. The finitely many
partial-state numerators and denominators are independent of n; eventually
none vanish modulo these growing primes, and p^2>8n+7. All four odd
residue classes are eligible because D has a nonzero coefficient at each
odd offset 1,3,5,7. The odd-lcm upper bound and ordinary PNT give

    (8-1/(H+1))*n+o(n)<=log den(U_n)<=8n+o(n).

Taking n to infinity before H proves log den(U_n)=8n+o(n). Moreover,
log num(U_n)=log den(U_n)-log n+O(1). The null state's canonical numerator
is exponentially large, while its circle energy still tends to zero.
This distinguishes its denominator rate from A's rate 6; it does not
bound A's canonical energy, and D also lacks A's nonzero real period.

The frozen report `/tmp/pi-m4-adelic-height-20261127/report-v1.md`, SHA-256
`6674c35892ed1d0ea1d43e77ac023e1d3e1faf19580154044795935c9c97cb7b`,
retains the fixed-H argument, height normalization and source consumer.
The parent reconstructed it and replayed the unchanged checker: exit 0,
identical receipt, originals preserved. Finite partial-state and prime
checks do not prove the asymptotic; the paper proof retains the earlier
compression theorem and assessed PNT. No Lean result is added.

## Evidence for the positive-branch argument

The parent reconstructed the proof, visually checked the PNT source page and
reran the exact standard-library checker, exit 0. Frozen evidence:

- `/tmp/pi-m4-prime-compression-report-v1.md`, SHA-256
  `0a7033d3b6eca57913c07471f627db4633607f05cafcaa2f209e8e2eade5fb09`.
- `/tmp/pi-m4-prime-compression-check-v1.py`, SHA-256
  `7fae2ef215e73c4f4506caca13c845dd44fabdf095cfd0f67c35ce616eefe046`.
- `/tmp/pi-m4-prime-compression-receipt-v1.json`, SHA-256
  `6202b1c0b0a0f68e8064f617916707626bb96d78024fccf2085061770689e69a`.
- `/tmp/pi-m4-prime-compression-manifest-v1.json`, SHA-256
  `d8762f8969c5bad0aa1d0a05693f7d3db9b44740f19472b1a5a9d2207a7376bf`.

The 40,774 compression cases compare direct pole sums, the compressed formula
and fully reduced prefixes through n=256. The checker also covers 19,979
large-prime survival cases, 33,330 denominator prime powers, 2,568 state signs,
307 residue-class tables, 315 primitive divisibilities and seven cancellation
instances. Finite checks do not prove the universal argument, PNT or V.
The [review record](agy-reports/m4-continuation-review.md) owns the independent
criticism. No production Lean, trust policy, dependency or pin changed.

## A qualitative density consumer retains the real matching premise

This reviewed paper argument uses a qualitative density theorem rather than
an exponential-sum estimate. Let T=R/Z, [t] be the quotient map,
X_n=16^n*pi, x_n=[X_n], and

    K=intersection_(M>=0) closure {x_n:n>=M}.

A sufficient, still **unproved**, condition is

    (R7)  7K subset K union (-K).

The source is [Furstenberg, 1967](https://mathweb.ucsd.edu/~asalehig/F_Disjointness.pdf),
Definition IV.1 on printed p.47 and Theorem IV.1 on p.48: a nonlacunary
multiplicative semigroup of integers has dense orbit on T from every
irrational starting point. Here nonlacunary means that its nonnegative
members are not all powers of one integer; the semigroup generated by 16
and 7 qualifies. The retained primary scan has SHA-256
`cd07faa4521080272cf2c303ee4e3a41ee6a3ba9e6aea114604becaca0ba9358`.
Parent and critic read and visually inspected both pages. The earlier
source dependencies, including Proposition IV.1, were not fully audited.
No equidistribution or invariant-measure result is imported.

Irrationality of pi does not imply that K contains an irrational point.
The closed-infinite-set version needed here has the following reconstruction.
The irrational ratio log(16)/log(7) implies that the nonnegative sums
of these logarithms form arbitrarily fine nets sufficiently far out.
Indeed a small nonzero residue obtained by pigeonholing multiples of
log(16) modulo log(7) supplies a finite net of that circle; adding
nonnegative multiples of log(7) covers all sufficiently large targets.
Consequently a closed invariant set C containing nonzero points tending
to zero is T: multiply their signed lifts by semigroup elements to approach
any prescribed magnitude in (0,1]. A fixed-sign subsequence covers the
circle, and successively finer nets give convergence.

For infinite closed C invariant under 16 and 7, an irrational point invokes
the source theorem. If C contains only rationals, choose a rational
accumulation point a/q. Distinct points near it give nonzero points of qC
tending to zero, so qC=T. Thus the q translates C+[r/q], 0<=r<q, cover T.
Finitely many closed sets with empty interior cannot cover an open arc;
hence C has interior. A sufficiently large power of 16 maps that arc onto
T, forcing C=T. This handles the rational-only case explicitly.

Compactness and predecessor subsequences give 16K=K. Also K is infinite:
if finite, 16 permutes it. Sufficiently small neighborhoods give unique
nearest points of K and exact expansion by 16 of the distance to K.
The late orbit stays in those neighborhoods, since its distance to K
tends to zero. Iteration forces a late distance to be zero, making pi
rational. The singleton case uses any fixed small neighborhood. Under
R7, K union (-K) is therefore closed, infinite and invariant under both
generators, so it is T. A proper closed 16-invariant K has empty interior;
K and its reflection cannot cover T. Hence K=T. Strict inner intervals
and E_n->0 then transfer arbitrarily late visits from x_n to
fract(S_n)=y_(n+1), including targets with a=0 or b=1. This proves
**R7 implies V**, not R7 or unconditional V. Conversely V gives K=T
by the same inner-interval and vanishing-tail argument, and hence R7.
Thus R7 is an equivalent reformulation in this setting; its potential use
depends on an independent BBP-specific proof of the inclusion.

### The exact late-index matching obligation

Put N_k=7k-1, k>=1, and let K_6 be the omega-limit set of x_(N_k).
Splitting late indices by residue modulo 7 gives
K=union_(r=0)^6 16^r K_6. Consequently R7 is equivalent to the following
matching condition, also equivalent with S replaced by X:

    For every epsilon>0 and M>=0, there exists L such that for every k>=L,
    there exist m>=M, sigma in {+1,-1} and an integer ell with
        |7*S_(7k-1)-sigma*S_m-ell| < epsilon.

The witness m may depend on k. Compactness gives uniform closeness to each
late orbit closure in one direction; shrinking epsilon and increasing M
put subsequential matches in K in the other. Multiplication by 16^r
extends the inclusion from K_6. Replacing X by S requires increasing both
indices to control 7|E_(7k-1)|+|E_m|. A fixed seed, p-adic congruence or
chosen rational phase does not supply this real estimate.

### The prime-7 block cannot be dropped

Use the actual alternate state Ahat, Shat and U=S+Shat above. With
F_c(k)=sum_(j<k)16^(-j)c(j), the archived
[prime-defect identity](m4-prime-defect-boundary.md#the-raw-defect-and-its-analytic-forcing)
gives v_7(7F_A(7k)-F_Ahat(k))>=2+v_7(k). Set N=7k-1 and q=16^(6k).
The complete real identities are

    G=16^N*(7F_A(7k)-F_Ahat(k))=7S_N-q*Shat_(k-1),
    Bhat=Shat_N-q*Shat_(k-1)
        =sum_(j=k)^(7k-1)16^(7k-1-j)*Ahat(j),
    H=G-Bhat=7S_N-Shat_N=8S_N-U_N.

With z_n=floor(S_n), zhat_n=floor(Shat_n), theta_n=fract(S_n), retain

    G=(7z_N-q*zhat_(k-1))+7theta_N-q*fract(Shat_(k-1)),
    H=(7z_N-zhat_N)+7theta_N-fract(Shat_N).

The raw terms of G need not separately be 7-integral. At the single
initialized fixture k=1, v_7(G)=2 but v_7(Bhat)=v_7(H)=-1. Neither the
block nor these canonical floors can be removed using the defect congruence.
The unscaled defect tends to 8*pi, but its exact scaled form is

    G=8X_N-7E_N-q*(E_(k-1)+U_(k-1)).

Here U_(k-1)>=2k/[(8k+1)(8k+2)] and E_(k-1)>0, so the amplified alternate
tail grows at least exponentially over k. Its large real size does not
itself imply circular separation; the point is that it is not an o(1)
error after scaling.

A stronger specific test rules out the naive same-index substitute:

    limsup_(k->infinity) ||H(k)|| >= 1/(16^7+1),

where ||t||=dist(t,Z). For any integer B>=2 and irrational alpha, a
smaller limsup for ||B^j*alpha|| would give late signed errors |e_j|<=c,
c<1/(B+1). The integer e_(j+1)-B*e_j has absolute value below 1, so is
zero. Boundedness then forces e_j=0, contradicting irrationality. Apply
this with B=16^7 and alpha=8*16^6*pi, and use
H(k)=8X_N-8E_N-U_N with vanishing final errors. This rejects only the
same-index shortcut; arbitrary-index matching and R7 remain open.

The frozen report is `/tmp/pi-m4-higher-rank-consumer-20261127/report-v1.md`,
SHA-256 `3a69216322b811cb8783f2181855679103631fae03e0fc9a5acdc9e70b2f98a8`.
Parent unchanged-copy replay passed 35 exact rational checks with identical
receipt and eleven original packet files preserved. It used one actual
p=7,k=1 structural fixture and no pi approximation or digit census. These
checks do not certify the topological or universal arithmetic arguments.
Separate paper review found no D/I item, retaining the matching estimate
as Q1. The source and archived arithmetic inputs remain paper results;
no Lean declaration, audit or visitation theorem is added.

### Uniform index rules fail; return-conditioned matching remains open

The next paper test distinguishes uniform matching from selecting favorable
returns. Let B=16^7. For a nonempty finite lag set J subset Z, allow d in J
and sigma in {+1,-1} to vary with k. Put a=max(0,-min J) and, at late
indices N_k>=a,

    c_(d,sigma)=7*16^a-sigma*16^(a+d),
    Q=lcm_(d,sigma)|c_(d,sigma)|, c_min=min_(d,sigma)|c_(d,sigma)|.

All c are nonzero integers. The exact error is c_(d,sigma)*16^(N_k-a)*pi.
Multiplication by the integer Q/c gives

    ||Q*16^(N_k-a)*pi||
       <=(Q/c_min)*min_(d,sigma)||7X_(N_k)-sigma*X_(N_k+d)||.

Applying the expansion bound above to the irrational base-B orbit proves

    limsup_k min_(d,sigma)||7X_(N_k)-sigma*X_(N_k+d)||
       >=c_min/[Q*(B+1)]>0.

The same bound holds for S because the finitely many tail errors tend to
zero. Thus no eventual finite-lag selector gives uniformly vanishing error,
including negative lags and adaptive signs. Bounded lags may still succeed
along subsequences; a hypothetical successful selector need not have its
absolute lag tend to infinity.

For the one unbounded rule m=k-1, let

    epsilon_k=min_(sigma=+/-1)||7X_(7k-1)-sigma*X_(k-1)||.

Choose minimizing signs s=sigma_k, t=sigma_(k+1), nearest integers z_k,
and signed errors e_k with |e_k|=epsilon_k. Then

    e_(k+1)-B*e_k=(B*s-16*t)*16^(k-1)*pi+B*z_k-z_(k+1).

Since gcd(B-16,B+16)=16, put W=(B^2-256)/16 and M=16^6+1. Both possible
absolute coefficients divide W, with quotients at most M. Hence

    ||W*16^(k-1)*pi||<=M*(epsilon_(k+1)+B*epsilon_k),
    limsup epsilon_k>=1/[17*(16^6+1)*(16^7+1)]>0.

Again replacing X by S changes the errors by a quantity tending to zero.
The prescribed compressed index cannot give the uniform matching required
at every late k, even with adaptive signs. This is not a liminf bound or
a prohibition on successful sparse returns.

To retain the latter possibility, let C be the joint omega-limit set of
(x_(7k-1),x_(k-1)) in T^2, and let

    L={(u,v):7u=v or 7u=-v}.

The map (u,v) maps to (B*u,16*v) preserves C, whose projections are K_6
and K. Uniform small error would require C subset L; one further iterate
would confine C to finitely many rational points, which is impossible.
But the weaker, still **unproved**, condition

    (P7) projection_1(C intersection L)=K_6

also suffices for R7 and therefore V. It says that for each x in K_6,
every epsilon>0 and threshold M0, there is some k>=M0+1 with

    dist(x_(7k-1),x)<epsilon,
    min_(sigma=+/-1)||7X_(7k-1)-sigma*X_(k-1)||<epsilon.

The existential k may depend on x, epsilon and M0. Compactness proves
this equivalence with P7. C intersection L need not be invariant, so the
uniform-rule obstruction cannot be applied to it. The abstract invariant
set C=T^2 satisfies P7 without being contained in L; this is not a claim
about the actual pi joint orbit. P7 is an extra joint-orbit condition;
no equivalence with arbitrary-index R7 is asserted.

The exact real estimate still missing on those returns retains q=16^(6k),
m=k-1, N=7k-1, and the initialized states:

    R_sigma=7S_N-sigma*S_m
       =(7q-sigma)*S_m+7B_A(k)
       =G(k)-(q+sigma)*S_m+q*U_m,
    B_A(k)=S_N-q*S_m=q*E_m-E_N,
    Bhat(k)=E_N+U_N-q*(E_m+U_m).

Its integer contribution from the canonical floors is
7*floor(S_N)-sigma*floor(S_m). The remaining fractional-part combination
need not lie in [0,1), so this is not asserted to be floor(R_sigma). Here
B_A(k)~q/(64k^2) and Bhat(k)~-q/(16k); neither block is negligible.
One must find an integer ell with |R_sigma-ell|<epsilon while returning
the first coordinate near each x in K_6. The two unamplified tail errors
then transfer this estimate to X. No p-adic precision of G supplies it.

The archived [fixed-prime analytic moment model](m4-prime-defect-boundary.md#fixed-prime-analytic-classes-still-admit-nondense-moment-models)
applies at P={7}: e>8/3 implies log(7)/6<1/3<1<4+log(15/128).
It retains zero initialization, an arbitrary finite actual prefix, unchanged
D=A+Ahat, the stated leading asymptotics, both denominator exponents 6,
all pointwise prime laws and selected-7 Taylor valuation classes, while
admitting an irrational nondense period. Thus those data cannot imply P7.
The exact finite-pole forcing and exact Taylor/defect values are lost.
Indeed paired perturbations A+delta, Ahat-delta with period shift Delta
change the normalized 7-defect by

    7F_delta(7k)+F_delta(k) -> 8Delta.

Choosing a nonzero permitted shift cannot preserve all exact defect values.
Preserving them would recover the same period, which alone proves no visit.
The unresolved return selection must exploit additional exact structure.

Frozen report `/tmp/pi-m4-off-index-matching-20261127/report-v1.md` has
SHA-256 `7f453e32792f2627f0a489e5fc334f9e154540747f34e020eff86ce77b4dcf33`.
Parent replay passed 43 exact sign/scale algebra checks, identical receipt
and five preserved originals, with no pi or BBP-prefix sampling. These
finite checks do not certify the universal bounds or the recorded infinite
countermodel. Independent paper review is recorded separately.

## Explicit actual denominators with fine complete-period grids

This elementary paper result concerns complete frozen rational orbits. For
each fixed d>=1 there are explicit arbitrarily large actual prefix indices N
such that, for every 0<a<q_N with gcd(a,q_N)=1, the base-16 orbit of a/q_N
over one complete period is a union of equally spaced grids of mesh 17^(-d).
Its normalized interval count differs from the interval length by at most
17^(-d). Here q_N is the reduced denominator of the actual S_N.

Define

```text
L_d=lcm {phi(17a+1): a even, 2<=a<=17^d-1},
r>1, r=1 mod L_d,   k=r+d,   N=(17^k-1)/8,   X=8N+6=17^k+5.
```

There are arbitrarily large such r. The coefficient identity
`-2/(8j+4)-1/(8j+6)=-(3j+2)/((2j+1)(4j+3))` makes q_N odd; the original
four denominators make it divide the odd part of lcm(1,...,X). Exactly one
original denominator through N is divisible by 17^k: the terminal 8N+1.
All are below 2*17^k, and only residue 1 modulo 8 can equal 17^k. Its
numerator is 4, so `17^k*S_N=4 mod17` in the 17-localization and v_17(q_N)=k.

Suppose a prime ell<=X had 17^r dividing ell-1. Then ell=a*17^r+1 with
even 2<=a<=17^d-1. Euler's theorem and the definition of L_d give
`17^r=17 mod(17a+1)`, so 17a+1 divides ell. Since r>1 this is a proper
nontrivial divisor, a contradiction. Therefore v_17(ell-1)<=r-1 for every
prime divisor of q_N. No prime distribution premise is used here.

Write q_N=17^k M, gcd(M,17)=1, and T=ord_M(16), with ord_1(16)=1. The
order modulo ell^e divides ell^(e-1)*(ell-1). Hence v_17(T)<=r-1, including
all other prime powers. Put

```text
T'=lcm(T,2*17^(r-1)),       g=16^T' mod q_N.
```

T' is even with v_17(T')=r-1. Since v_17(16^2-1)=1, odd-prime lifting gives
v_17(16^T'-1)=r. Thus g generates all 17^d principal units congruent to 1
modulo 17^r in the 17^k component and fixes the M component. CRT identifies
its subgroup as

```text
H={1+M*17^r*u mod q_N : 0<=u<17^d}.
```

Multiplying by any unit numerator a permutes u modulo 17^d. Dividing the
residues by q_N therefore gives exactly
`{fract(a/q_N+j/17^d): 0<=j<17^d}`. Since H is contained in the subgroup
generated by 16, the complete orbit splits into such grid cosets. Each grid's
interval count differs from 17^d times the length by at most one; averaging
the complete-period counts proves the stated discrepancy bound.

Fix a word length w first, then choose d with 17^d>16^w and construct the
anchors. Every length-w hexadecimal cylinder has an interior orbit point, so
every length-w word occurs in the complete period of fract(S_N) for infinitely
many such N. This is not normality of one rational number, simultaneous coverage
of arbitrary word lengths at one anchor, or occurrence in the future forced
BBP sequence. No Lean proof or originality determination is claimed.

### Source context and the actual timing gap

[Kominers, Proposition 3.3](https://arxiv.org/html/2604.11282v1#S3.SS2), motivated
testing the sharp radical-order quantity instead of only the largest prime.
Its source domain is m>=3, 1<|D|<m and a normalized reduced fraction r/Q with
0<r<Q and gcd(mr,Q)=1 in the deleted-digit set. For a prime p not dividing m,
it bounds v_p(Q) by the valuation of ord_rad(Q)(m), an order-lifting overhead
and log_p(c_(m,D)),
where c=2(m-1)*min(1,|D|/(m-|D|)). The related full-period digit estimate
in [Lin--Wu--Yang, Lemma 2.1](https://arxiv.org/html/2603.24614v2) retains the
coprime, reduced, purely periodic setting. The underlying Korobov input was
not independently audited. The elementary proof above imports neither result.
The limited exact-direction search found no matching BBP construction; it does
not establish originality or an exact Lean match.

The constructed grid times are j*T'. Their step is already at least 17^(r-1),
far beyond the ordinary O(log N) shadow window. Separately, the archived
PNT-dependent log q_N=6N+o(N) gives log M=6N+o(N), while M divides 16^T'-1;
therefore `T'>(6/log16)*N+o(N)`. This is a lower bound for this traversal,
not for the first possible hit anywhere in the full orbit.

The exact actual comparison remains

```text
S_(N+j)-16^j*S_N=16^j*E_N-E_(N+j).
```

No target hit inside its controlled window has been proved. A uniform early-hit
inference from the denominator alone is false: replacing the actual numerator
by 1 preserves q_N and all complete-period grids, but q_N>N^C eventually for
every fixed C, so 1/q_N has at least floor(C*log_16 N) leading zero digits.
This changes the actual numerator and initialization and is not a V counterexample.
Time zero may already hit, other cosets may hit earlier, and later circular
tail coincidences remain unexcluded.

### Natural tail corrections do not make this traversal fit

Let B_N be the product of prime-power factors of q_N at primes greater than N.
The lcm bound gives

```text
sum_(p<=N) v_p(q_N)*log p <=theta(N)+sqrt(8N+6)*log(8N+6).
```

First powers cost at most theta(N); further powers occur only below the square
root, with at most log(8N+6) per prime. The existing ordinary PNT and evaluated
denominator asymptotic therefore give log B_N>=5N+o(N).

For every finite natural correction order K, the archived
[localization and positive remainder](m4-fourier-windows.md#growing-order-corrections-a-uniform-obstruction)
give R_K(N) in Z[1/(30N)]. Hence B_N survives in the odd denominator Q_(N,K)
of S_N+R_K(N), uniformly in K. At the selected anchors 17 does not divide 30N,
so v_17(Q_(N,K))=k; all its prime factors remain at most X. The same grid
construction applies after removing any finite dyadic preperiod. For
M_(N,K)=Q_(N,K)/17^k, the high-prime divisor B_N is retained for large N, so
its constructed step satisfies

```text
T_(N,K)>(5/log16)*N+o(N), uniformly over all finite K.
```

But the positive remainder, uniformly in K, limits absolute shadowing to
`j<=N+2*log_16 N+O(1)` at any fixed tolerance. Since 5/log16>1, that entire
window cannot contain a traversal providing the full-grid covering guarantee.
A dyadic preperiod cannot shorten the step. This excludes only this use of
these natural corrections; other cosets, circular coincidences, other rational
approximants and Padé methods remain possible.

Two discovery tests also retain their limited scope. Even-digit membership is
not multiplicatively closed: 2/15 has only digit 2, while its square has prefix
048D. This concerns ordinary digits, not actual forced-carry parity. On the
circle R/Z, an invariant set K yields moving translates K_n=K-E_n, and the
forced map sends K_n into K_(n+1), with every operation modulo one. This does
not produce additional self-maps of one fixed K or select the zero seed.

The [continuation review](agy-reports/m4-continuation-review.md) retains the
elementary proof, separate PNT-dependent comparison, immutable sources and
unchanged synthetic replays. No actual prefix, denominator, pi digit or carry
census was used. Actual early phase selection, odd-carry infinitude and V remain open.


### The full 17-component still does not select an early visit

At the positive anchors N=(17^k-1)/8, k>=1, write q_N=17^k M. The archived
[full-prime-component sieve](m4-transforms-and-periods.md#matching-the-full-three-component-still-permits-a-zero-prefix)
and [actual-denominator word sieve](m4-generating-functions.md#every-finite-word-can-retain-the-dyadic-entry-precision)
combine directly here. For each fixed 0<c<6/log16 and all sufficiently large
anchors, every prescribed unit numerator residue modulo 17^k admits at least
two reduced fractions a/q_N in (0,1) whose first floor(cN) ordinary hexadecimal
digits are zero. The same denominator and whole additive 17-primary component
are retained, including when the prescribed residue is the actual one. One
can exclude the actual numerator. The complementary coordinate modulo M changes;
individual complementary prime components are not controlled.

More strongly, for all sufficiently large anchors, every unit residue modulo
17^k, every dyadic residue modulo 16^N and every word in {1,...,14}^N admit
at least two reduced fractions with those residues and that next N-letter
canonical carry word under the exact future forcing. Combining the numerator
congruences gives progression step 17^k*16^N. The inverse-word cell has length
(15/16)16^(-N), so the sieve parameter interval has length
`(15/16)q_N/(17^k*16^(2N))`, with positive logarithmic rate 6-2log16. The
additional odd modulus costs only O(log N); the existing sieve errors remain
subexponential. This uses the archived PNT-dependent denominator asymptotic.

Choosing the actual residues and adding the actual floor preserves the stated
raw floor, dyadic precision and full 17-component; exact forcing propagates the
latter congruences. It does not preserve zero initialization or produce one
coherent infinite avoiding history. This is an independently reviewed
specialization of archived arguments, not a new mechanism, V counterexample,
or Lean result. A 17-only early-phase selector is therefore suspended. The
[review record](agy-reports/m4-continuation-review.md#full-17-coordinate-discriminator--2026-11-27-utc)
retains the exact quantifiers, synthetic-only checks and evidence limits.

### Lean formalization of the elementary grid theorem

The [rational prefix module](../PiDisjunctivity/BBP/RationalPrefix.lean) starts
the formalization with the exact cast to the existing real prefix and the
n+1 recurrence bridge. Its unconditional support lemmas prove coefficient and
prefix positivity, an explicit common denominator, oddness, coprimality with16,
and the stronger prime-support bound p<=8n+5. Root-import types, an instantiated
zero-index bridge and axiom guards are in [Test.lean](../Test.lean). This support
layer has passed kernel checks and independent changed-file review.

The complete elementary contract remains the theorem above: natural d,r,k,N,
explicit anchor identity17^k=8N+1, the selected denominator valuation and prime
order bound, grid cosets for every normalized unit numerator, and complete-period
interval discrepancy at most17^(-d). For P=ord_q(16)>0, the count is over
0<=t<P with fract(16^t*a/q) in [u,v), for every real0<=u<v<=1; normalization
and all casts are real. Merely finding one grid subset does not discharge this
counting statement. Arbitrarily large anchors and the fixed-word corollary must
also be proved. No PNT input is needed for this elementary theorem.

The exact selected valuation and general principal-unit/Carmichael components
are being developed separately in scratch Lean; they are not yet production
exports or a composed grid proof. The PNT-dependent timing comparison stays
paper mathematics. Full grid formalization and actual visitation remain open.
