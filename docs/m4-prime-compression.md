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
