# M4 sine-zero and language auxiliaries

This 2026-11-26 paper assessment tests whether pi's exact sine zero makes
missing-word restrictions usable in a quantitative auxiliary construction.
The tested expressions do not supply the real-phase estimate required by
[V](proof-plan.md#5-prove-the-missing-universal-visitation-theorem).
They are not Lean theorems. Independent review status belongs to the
[review record](agy-reports/m4-continuation-review.md).

## A product detecting a permitted prefix

For the diagnostic language with no hexadecimal F, put q=16^n, M=15^n,
R_n={n-digit integers using 0,...,14}, including leading zeros, and

    A_n={3q+r:r in R_n},
    Q_n(Z)=product_(p in A_n)(1+Z^p),
    F_n(X)=product_(p in A_n)(qX-p).

Hypothetical avoidance from the first fractional digit puts floor(q*pi) in
A_n. Writing rho=max(pi-3,4-pi)<1, this implies

    B_n=|Q_n(exp(i/q))| < q^-1*rho^(M-1).

The actual prefix gives one factor smaller than 1/q. The other factors
are bounded by rho. This hypothesis is not established for pi; the test
seeks a lower bound contradicting its displayed consequence.

For every x in [3,4], with delta=x-pi, the exact identity and elementary
sine bounds give

    |1+exp(i*x)|=2*|sin(delta/2)|,
    (23/24)*|delta| <= |1+exp(i*x)| <= |delta|.

Consequently

    (23/24)^M*q^-M*|F_n(pi)| <= B_n <= q^-M*|F_n(pi)|.

The sine zero changes the node-polynomial product only by exp(O(M)). The
bulk product can be small without avoidance; membership adds just one
specified close node. The exponentials share the single argument i/q:
exp(i*p/q)=exp(i/q)^p. They must not be treated as algebraically independent.

## Exact arithmetic costs survive primitive reduction

The mean permitted digit is 7, so

    D=deg Q_n=M*(52q-7)/15.

Q_n has content 1 and nonnegative integer coefficients summing to 2^M.
Its height H therefore satisfies 2^M/(D+1)<=H<=2^M. Moving all factors to
one algebraic argument costs degree of order qM.

The content of F_n is also explicit. The numbers of permitted digits
divisible by 2,4,8,16 are 8,4,2,1. Counting trailing zero digits gives

    v_2(content F_n)=15*(M-1)/14=:C_n.

There is no odd content. The primitive polynomial has leading coefficient
q^M/2^C_n and height between that number and (5q)^M/2^C_n. Thus its
log-height is M*log q+O(M). Removing content does not erase the denominator
cost in the [earlier node-polynomial test](m4-approximation-interfaces.md).

Eventual avoidance after a fixed N replaces q by Q=q0*16^n, q0=16^N,
and the nodes by (a0*16^n+r)/Q, where a0=floor(q0*pi). The initial cylinder
is fixed. Every nonzero r has the same low-bit valuation as before; r=0
adds min(4N,v_2(a0)) to the content exponent. This fixed factor leaves the
same asymptotic cost. It does not remove the arbitrary-threshold obligation.

## Source bounds and their exact hypotheses

[Roy, Theorem 1.1, printed p.288](https://ems.press/content/serial-article-files/44254)
gives an explicit polynomial-value lower bound at exponentials of algebraic
arguments. For the singleton alpha=i/q, field degree 2, conjugate bound
c=1/q and clearing integer b=q, its parameter is S=12D. All hypotheses hold
uniformly as q varies, and it gives

    B_n >= H^(-72D)*exp(-(12D)^(216D)).

This source guarantee is far below the avoidance upper bound. Even its
height cost has negative logarithm of order q*M^2, whereas the displayed
avoidance consequence gives log q+O(M). The remaining term is larger still.
The theorem is applicable but insufficient; no hidden fixed-alpha constant
is being used uniformly in q. This is not a claim that Roy's bound is optimal.

Separate applications to 1+exp(i*p/q) do not improve this comparison.
With g=gcd(p,q), use b=q/g, c=p/q and D=H=1. The source gives
exp(-(12p/g)^216). At least (7/15)M permitted p are odd, so multiplying
these guarantees has negative-log cost at least (7/15)M*(36q)^216.
This describes the weakness of the guarantee, not the actual product size.

[Fischler--Rivoal, Theorem 1, p.2](https://rivoal.perso.math.cnrs.fr/articles/Eexponent.pdf)
concerns irrational values f(r) of rational-coefficient E-functions at fixed
rational r. Its approximation constant depends on f, r and epsilon. Pi is
the transcendental argument of a sine zero, not a supplied value f(r) at a
rational point. Applying the theorem to sin(p/q) and the approximant 0/1
gives no uniform bound as p/q varies. Applying algebraic-argument value
theorems at pi violates their hypotheses. Arcsin has finite complex
singularities and is not an entire E-function. No broader impossibility
claim about other representations of pi follows.

## Recursive sums and two exact cancellation constructions

Fix N, q0=16^N, a0=floor(q0*pi), Q=q0*q and D=14(q-1)/15. The
positive language sum has a small recursive description and exact height 1:

    A_n(Z)=sum_(r in R_n)Z^r=product_(j<n)(1+Z^(16^j)+...+Z^(14*16^j)).

Yet rotating its summands to the middle of their arc proves
M*cos(D/(2Q))<=|A_n(exp(i/Q))|<=M. The cosine is at least
cos(7/(15q0))>0. This sum averages the allowed paths; it does not select
the path of pi. The infinite language-indicator series does satisfy a
Mahler equation. That is not an equation for pi's digit sequence: recognition
of a regular language gives no rule generating an arbitrary member.

Signed digit weights do produce real cancellation. Put

    W_n(Z)=product_(j<n)(1-Z^(16^j))^14=sum_r c_r Z^r,
    c_r=product_digits((-1)^d*binom(14,d)),
    B=product_(j<n)(2*sin(16^(j-n)/(2q0)))^14,
    c=a0/q0+D/(2Q).

The degree is D, height 3432^n, and zero order at 1 exactly 14n. Direct
factorization gives W_n(exp(i/Q))=(-1)^n*exp(iD/(2Q))*B and

    sum_r c_r*sin((a0*q+r)/Q)=(-1)^n*B*sin(c),
    exp(-7/(1530q0^2))*q0^(-14n)*16^(-7n(n+1))
      <= B <= q0^(-14n)*16^(-7n(n+1)).

For N=0 and n>=1, 1/4<|sin(c)|<1/2, using 3<pi<22/7 and the
elementary sine bounds. For fixed N, c tends to the rational
(a0+7/15)/q0 in [3,4], whose sine is nonzero. Thus the sine factor is
eventually bounded away from zero, with no claimed uniform effective
constant in N. This cancellation is exact but independent of avoidance.

Tensor weights are not optimal for moment cancellation. Set m=M-1 and

    d_r=product_(s in R_n,s!=r)(r-s),
    L=lcm_r |d_r|,
    V_n(Z)=sum_r(L/d_r)*Z^r.

This primitive integer polynomial has degree D, height max_r L/|d_r|,
and zero order exactly m at 1. Lagrange interpolation cancels all moments
below m and gives sum_r (L/d_r)*r^m=L. The Vandermonde matrix shows that
m is the maximum possible order on this support.

[The Genocchi--Hermite formula, Lesch Appendix A, p.218](https://ems.press/content/serial-article-files/30684)
gives, for normalized uniform simplex measure and a convex combination T
of the nodes,

    V_n(exp(i/Q))=L*(i/Q)^m/m!*E(exp(iT/Q)),
    cos(D/(2Q))*L/(m!*Q^m) <= |V_n(exp(i/Q))| <= L/(m!*Q^m).

Apply the real formula to real and imaginary parts. Reflection of the nodes
about D/2 makes E(exp(iT/Q))=exp(iD/(2Q))*R with positive real R.
Since m is even, the shifted sine sum again contains exactly the factor
sin(c). This stronger cancellation also does not select pi's branch.
The arithmetic normalizer is not discarded: m! divides L and L divides D!.
No asymptotic for L is inferred from the finite examples.

## A branch detector retains its poles

Let K be the compact set with all hexadecimal digits in {0,...,14}. For
the irrational actual tail alpha=q0*pi-a0, avoidance would put alpha in K.
Consider

    C_n(z)=(1/M)*sum_r 1/(z-r/q),
    T_n(z)=-C_n'(z)=(1/M)*sum_r 1/(z-r/q)^2.

Their exact recursions are C_(n+1)(z)=(16/15)*sum_(d=0)^14 C_n(16z-d)
and T_(n+1)(z)=(256/15)*sum_(d=0)^14 T_n(16z-d). For irrational alpha
in K its own prefix yields T_n(alpha)>q^2/M=(256/15)^n. Outside K the
positive distance to K bounds all T_n. This expression really detects
membership.

Nevertheless C_n has M uncancelled simple poles and T_n has M uncancelled
double poles. With F(z)=product_r(qz-r),

    C_n=F'/(M*F), T_n=((F')^2-F''*F)/(M*F^2).

At each root the second numerator is (F')^2, which is nonzero. A short
recursive description does not lower the degree of this reduced rational
function. A bound |pi-p/Q|>=c0*Q^-mu only supplies
T_n(alpha)<=c0^-2*q0^(2mu-2)*q^(2mu), compatible with the avoidance
lower bound. A sufficient pi-specific upper estimate is still missing.

Another branch detector can remove repeated cyclotomic factors. Within
the explicit class of nonzero integer polynomials P required to vanish at
exp(i*pi/p) for every p=a0*q+r, irreducibility forces every distinct
Phi_(2p) to divide P. Hence

    deg P >= sum_p phi(2p) >= sum_p sqrt(p) >= M*sqrt(3Q).

The inequality phi(v)>=sqrt(v/2) follows prime by prime. This applies in
particular to the lcm of all 1+Z^p, their product's squarefree part. It makes
no claim that every useful auxiliary must lie in this class, or that taking
an lcm preserves the product's height or small-value bounds.

[Adamczewski--Faverjon, Theorem 1.3, p.4](https://faverjon.perso.math.cnrs.fr/AdamczewskiFaverjon_Mesures_EM_values.pdf)
does not bridge these constructions: its E and M cases require a nonzero
algebraic argument, and the M case requires modulus less than 1. Constants
depend on the functions and argument. Neither evaluation at pi nor at
exp(i/Q) meets the M hypotheses. The language equation supplies no identity
for the selected pi branch.

## An isolated algebraic approximation still has a height cost

A different branch representation uses the regular-polygon approximants
alpha_m=2^m*sin(pi/2^m), m>=3, of degree d=2^(m-1). Define
C_2=X^2-2 and C_(m+1)=C_m^2-2. These polynomials are Eisenstein at 2,
and

    F_m(X)=2^((m-1)*d)*C_m(X/2^(m-1))

is the monic minimal polynomial of alpha_m. Its conjugates are
2^m*cos((2j+1)*pi/2^m), 0<=j<d. The chosen root is the smallest
positive one, lies in (2,4), and has a uniform separation from all other
roots. This isolation is retained rather than replaced by a generic
root-separation bound.

The exact tower relation is
alpha_m^2=alpha_(m+1)^2-alpha_(m+1)^4/2^(2m+2). Elementary sine bounds give

    3*2^(4n-2m)<16^n*(pi-alpha_m)<11*2^(4n-2m).

A fixed-error digit transfer therefore requires m>=2n+O(1), so the
algebraic degree already grows on the scale 4^n. More precisely, on [2,4],
H_m=2^(-(m-1)*d)*F_m has derivative satisfying 1/2<=-H_m'<=2.
For a rational grid point r=p/Q there, irreducibility and integrality give

    |r-alpha_m|>=1/(2*2^((m-1)*d)*Q^d).

At a base-16 boundary c=k+a/16^ell, put r=c/16^n and Q=16^(n+ell).
The resulting guaranteed separation L from 16^n*alpha_m satisfies
L/[16^n*(pi-alpha_m)]<1/24. Thus even this well-conditioned isolated
root does not make bare nonzero-integer evaluation strong enough for the
transfer. This compares guarantees, not the actual root distance.
An estimate of the actual signed integer Q^d*F_m(p/Q) is still missing.

[Bilu, Theorem 1.1, p.465](https://people.math.harvard.edu/~demarco/Math295/Bilu_equidistribution.pdf)
does not supply that estimate. It concerns full Galois orbit measures of
a strict sequence in a multiplicative algebraic torus with height tending
to zero. For zeta_m=exp(i*pi/2^m), those hypotheses hold, but the selected
coherent branch tends to 1 while the full conjugate mean is exactly zero.
The readout 2^m*Im(zeta_m) also varies with unbounded Lipschitz constant.
Directly, h(alpha_m)=(m-1+1/d)*log 2, and scaling by 16^n adds 4n*log 2;
these heights do not tend to zero. No full-orbit conclusion selects this
particular branch or the required moving grid.

The frozen packet `/tmp/pi-m4-fresh-phase-20261127/` has report SHA-256
`6fa18c72e979dddbbe090bc6d0a0d9762a977ab5ab4ddfee053a041731d4d6b8`.
The parent reconstructed the report/checker/critic, visually inspected the
source theorem page, and replayed an unchanged checker copy: exit 0,
identical receipt, originals unchanged. Its 2,060 finite checks cover
polynomials, cyclotomic identities and exponent inequalities, not pi digits
or actual BBP fractional states. Generic Galois averaging and bare polynomial
integrality are suspended for this construction; V remains open.

## Uniform carry polynomials retain an entire avoiding Cantor set

Actual canonical carries are c_n=floor(16*fract(S_n)+A(n+1)); they can
equal 16. Nevertheless a permanent real hole implies omission of some word
over 0,...,15 after a further threshold. Choose its closed ordinary cylinder
[u,u+16^(-l)] strictly inside the hole. Backward expansion of a carry block
gives

    x_n=sum_(j=1)^l c_(n+j-1)/16^j
                      +16^(-l)*x_(n+l)-B_(n,l),
    B_(n,l)=E_n-16^(-l)*E_(n+l), 0<B_(n,l)<E_n.

Occurrence of that word would put x_n between u-E_n and u+16^(-l),
inside the hole once the tail is smaller than the chosen margin. This
does not identify every carry with a hexadecimal digit.

For an omitted word w, let K_(N,h)(w) be the real entries in [0,1) whose
first h canonical carries under the exact future A-forcing avoid w. A
fixed admissible past-language state may also be imposed, including word
occurrences crossing its boundary; the complete earlier trajectory is relaxed.
The proposed polynomial consumer asks for nonzero P in Q[T], degree d.
Choose a positive integer b with bP in Z[T], and seek

    sup_(t in K_(N,h)(w)) |P(t)| < 1/(b*q_N^d).

At the actual reduced-q_N entry this would force P(x_N)=0. Rational-root
divisibility could then exclude the zero only with additional control of
the primitive leading coefficient. The uniform estimate itself is impossible
when N>=3 and q_N>=1024, for every h and d, as follows.

Choose B={5,6} or {9,10} disjoint from the LAST symbol of w, and let C_B
be its infinite base-16 Cantor set. Every shifted tail theta_j of theta in
C_B lies in [1/3,2/3]. Define X_j=theta_j-E_(N+j). The exact tail relation
and B3 bound give

    16*X_j+A(N+j+1)=b_(j+1)+X_(j+1),
    0<E_(N+j)<=8/495<1/48, 0<X_j<1.

Thus the canonical carries are exactly the allowed symbols b_(j+1).
No omitted word can finish in the future, even across a fixed admissible
past boundary. Consequently C_B-E_N is contained in every K_(N,h)(w).
The future forcing is actual; these comparison entries generally lose
zero initialization and need not lie on the actual rational denominator grid.

Give C_B its fair Bernoulli measure. Depth-k cylinders have mass 2^(-k),
diameter 16^(-k)/15 and gaps at least (14/15)*16^(-k). A complex disk
of radius 16^(-k)/4 meets at most one cylinder. The nonnegative layer-cake
integral therefore gives, uniformly in complex z,

    integral log^-|theta-z| <= log4+sum_(k>=0)2^(-k)*log16
                            =log1024.

This proves integrability before logarithmic factors are added. Factoring
P over C, translating by E_N and integrating yields

    sup_(K_(N,h)(w))|P| >=|lead(P)|*1024^(-d)
                         >=1/(b*1024^d).

This contradicts the proposed strict lattice bound at q_N>=1024, including
constant polynomials. Clearing rational coefficients does not help: b occurs
on both sides. The actual denominator asymptotic ensures the condition
eventually, with no claimed effective threshold. The result also permits a
different polynomial for each fixed past-language state. It does not apply
to arbitrary separate future-branch polynomials without a common entry estimate.

The discrete q_N-grid remains outside this barrier. If a strict lattice
bound holds at M distinct reduced-q_N rational points, their primitive linear
factors divide the cleared primitive polynomial. Gauss's lemma forces degree
at least M and leading coefficient divisible by q_N^M. No lower bound on the
actual number of allowed grid points is asserted. A surviving method needs
an estimate for the selected numerator, rather than a real-entry relaxation
or a polynomial vanishing on the allowed grid by construction.

The frozen packet `/tmp/pi-m4-word-carry-20261127/` has report SHA-256
`f1e86b09ae70ac0a1c74c64bdeae03ccb2d1c4251e9b173bfc5b4c110f3fcce7`.
It retains the parent-proposed Cantor argument, worker reconstruction,
superseded finite-cell cost, exact input contract and separate criticism.
Its immutable `correction-v2.md` restricts that superseded Chebyshev formula
to positive degree and gives the separate constant case; frozen v1 is preserved.
Parent full reconstruction and unchanged-copy replay passed; the receipt
differs only in UTC and originals are preserved. Synthetic finite-tail
checks do not evaluate actual A phases or certify the infinite logarithmic
integral. Uniform real-entry polynomial smallness is suspended for this
class; discrete or differently constrained consumers are not ruled out.

## The actual denominator grid still admits many avoiding entries

The preceding continuous-entry obstruction has a quantitative discrete version.
Write the actual reduced raw prefix as S_N=P_N/q_N, its floor as K_N and
its canonical numerator as a_N=P_N-K_N*q_N. Put x_N=a_N/q_N and retain
16^N*pi=S_N+E_N. The established q_N is odd, log q_N=6N+o(N), and
0<E_N<1/15 with 16E_N-E_(N+1)=A(N+1).

Fix a nonempty forbidden word w and let B be {1,...,14} excluding its final
symbol, with m=|B|>=13. Set I=[1/15,14/15]. For each b in B^h, let p_b
be its base-16 code. The m^h closed intervals

    J_b=(p_b+I)/16^h-E_N

are disjoint, lie strictly in (0,1), and have length 13/(15*16^h).
Backward branches theta_j=(b_(j+1)+theta_(j+1))/16 preserve I. Therefore
X_j=theta_j-E_(N+j) stays strictly in (0,1), and the exact tail identity gives
16X_j+A(N+j+1)=b_(j+1)+X_(j+1). Both closed endpoints are safe. Every entry
in J_b consequently has precisely those h future canonical carries under the
unchanged A. Excluding w's last symbol also prevents an occurrence crossing
any fixed admissible past-language boundary. The actual past is not retained.

For odd q>=3, k>=0 and any residue r modulo 2^k, the number R of these entries
a/q with 0<a<q, gcd(a,q)=1 and a=r modulo 2^k satisfies

    R >= m^h*((13/15)*phi(q)/(2^k*16^h)-2^omega(q)).

For each interval, Mobius inversion counts one progression modulo 2^k*d for
each squarefree d|q. A closed progression count differs from length/spacing
by at most one, giving the stated error uniformly in r and the real shift.
The bound may be nonpositive at finite anchors. Since q>=(omega(q)+1)!,
log q_N=6N+o(N) implies omega(q_N)=o(N); also phi(q)>=q/2^omega(q).
For every fixed epsilon>0, if k*log2+h*log16<=(6-epsilon)*N, eventually

    R >= (13/30)*phi(q_N)*2^(-k)*(m/16)^h
      >= exp(epsilon*N+h*log m+o(N)).

This applies even to r=a_N modulo 2^k without identifying a_N. Suppose a
nonzero rational polynomial P of degree d, with bP integral for integer b>0,
has |P(a/q)|<1/(b*q^d) uniformly on these R entries. Integer evaluation then
forces all R roots. The primitive part of bP is divisible by the product of
the distinct primitive factors q*T-a. Gauss's lemma gives d>=R and primitive
leading coefficient, hence height, at least q^R. This excludes only the
stated uniform low-degree/height certificate; additional actual-history
constraints and arbitrary-degree auxiliaries remain outside the result.

### A weaker actual carry question remains open

Let c_n=floor(16*x_n+A(n+1))=K_(n+1)-16*K_n. The precise weaker target
C_odd asks for an odd c_n at arbitrarily late n. V implies it: a visit
x_n in (1/12,3/32), with 0<A(n+1)<4/9, forces c_n=1. The rational
normalization of A gives A(n)=S_n=n+1 modulo 2 in the odd-denominator rationals.
Consequently c_n is odd exactly when a_(n+1) is not n+2 modulo 2. That
canonical-numerator assertion remains unproved; the congruence only relocates it.

Choosing B={2,4,6,8,10,12,14} gives the same count with m=7 and all h
replacement carries even. Choose r=a_N modulo 2^k and the raw replacement
T_0=K_N+a/q_N. Its raw difference from the actual prefix after j steps is
16^j*(a-a_N)/q_N, of two-adic valuation at least k+4j. This survives rational
reduction as a cross-multiplied numerator congruence because the denominators
are odd. It does not preserve future denominator equality or precision of
canonical numerators after subtracting differing floors. Thus finite entry
precision and exact future A cannot force an odd carry within the stated
horizon uniformly over these replacements. No infinite rational avoiding
model, actual zero-initialized counterexample or converse to V follows.

A narrower odd-prime test uses S_1=205826/4095 and
4095=3^2*5*7*13. Its raw numerator has Legendre signs (-1,+1,-1,+1)
at (3,5,7,13). Both reduced replacement numerators 101 and 146 have those
four signs but opposite parity. This rules out determining parity from this
denominator and these characters uniformly over reduced replacements. It
does not refute a rule restricted to the actual initialized sequence, at
every anchor or eventually. Full local residues and their canonical
representative are distinct from character data.

Frozen packet `/tmp/pi-m4-strategy-reset-20261127/` has report SHA-256
`53c1edfe05dcfbfbbd8f4ad0cac42105dbdbc992f362aa98885869ce014686d4`.
The parent reconstructed the argument and replayed a byte-unchanged checker:
575 counts, 7,554 entries, 14,988 exact-A carry steps and the supplementary
endpoint/precision/character checks passed, exit 0, identical receipt, all
four originals preserved. Synthetic rational tails exercise the finite carry
algebra; they do not verify the actual irrational-tail or asymptotic proofs.
No actual canonical numerator or pi digit was evaluated. Independent criticism
found no blocking defect and requested the replacement-only character scope
now stated above. V, C_odd and M4 remain open; this is paper mathematics.

## Relative forcing fields and canonical parity

The actual rational phase z_n=exp(pi*i*S_n) encodes canonical parity:
S_n modulo 2 belongs to [0,1) exactly when K_n is even. This half-open
criterion includes integral boundaries. A proposed norm/trace consumer must
retain that choice of complex phase, not just an abstract root of unity.

Fix N>=0, h>=1, S_N=P/q reduced with q odd, and let
L=lcm{den A(N+j):1<=j<=h}, g=gcd(q,L), d=q/g, Q=lcm(q,L).
In the cyclotomic field of conductor 4Q, automorphisms with exponent
u=1 modulo 4L fix i and every exact future forcing phase. Their complete
image of z_N is

    {exp(pi*i*r/q):0<=r<2q, r=P mod 2g, gcd(r,q)=1}.

For sufficiency, choose k modulo d solving
4*(L/g)*P*k=(r-P)/g and put u=1+4L*k. The coefficient is invertible
modulo d, since gcd(L/g,d)=gcd(P,d)=1; for d=1 take k=0. Then
uP=r modulo 2q and u is a unit modulo 4Q. Counting the permitted residues
gives phi(q)/phi(g); each image keeps order 2q/gcd(P,2).

Every automorphism over Q fixes the rational S_n itself. What need not be
preserved is the analytic relation z_n=exp(pi*i*S_n). The conjugate phase
admits a replacement real lift T_0=r/q, propagated by
T_(j+1)=16*T_j+A(N+j+1). Its phases are the conjugates of the actual phases,
but its raw values are not automorphic images of the rational prefixes and
need not keep the initialized seed. Its canonical unit-cell carries satisfy
c'_j=floor(T_(j+1))-16*floor(T_j), so their parity is read at j+1.

At N=2,h=3, S_2=615863723/765765, L=333072102825, g=3465 and d=221.
The relative image has 192 elements. Among representatives r/q<1, exactly
13 have three even canonical carries and 12 have three odd carries. For
r=29273, the exponent u=142554860009101 yields (0,10,2); for r=63923,
u=201175550106301 yields (1,5,11). Both are units modulo
4Q=294435738897300, equal 1 modulo 4L, and preserve primitive order
1531530. These are alternative phase lifts under exact forcing, not claims
about the original actual carry block.

There is a growing finite family. Use the previously established product

    R_N=product{p prime:p=1 mod4,4N+3<p<=8N+1}.

Each factor occurs once in q_N and divides no forcing denominator through
h<=floor(N/2); log R_N=2N+o(N). The subgroup u=1 modulo 4Q/R_N fixes
the complementary conductor and all these forcing phases. Its images form
S_N+2t/R_N modulo 2, with one forbidden t-class at each p|R_N. On any
interval inside [0,2) of length ell, inclusion-exclusion gives the count
phi(R_N)*ell/2 with error at most 2^omega(R_N). Each lifted divisor residue
class is an arithmetic progression, so counting it in the interval introduces
no extra wraparound error.

Let I=[1/15,14/15] and retain the actual tail E_n with
16E_n-E_(n+1)=A(n+1), 0<E_n<1/15. Both digit alphabets
{2,4,6,8,10,12,14} and {1,3,5,7,9,11,13} preserve I under the inverse
maps theta -> (b+theta)/16. For each length-h word w, the disjoint closed
cell (p_w+I)/16^h-E_N lies strictly in (0,1), has length
13/(15*16^h), and yields those exact canonical carries: intermediate states
are theta_j-E_(N+j) in (0,1). Each parity therefore has at least

    7^h*[13*phi(R_N)/(30*16^h)-2^omega(R_N)]

conjugate branches. Since log phi(R_N)=2N+o(N) and omega(R_N)=o(N),
this is positive uniformly for 1<=h<=floor(N/2) at large N. The exponent
margin is 2-log16/2>0. This family is distinct from the small N2,h3 fixture.

The freedom ends after finitely many future constraints. Put
M_N=max{p^e:p^e exactly divides q_N}, or 1 if q_N=1. Then

    q_N divides lcm{den A(N+j):1<=j<=M_N}, M_N<=8N+5.

For each p^e select 8n+1=0 mod p^e if p>=7, 4n+3=0 if p=3,
or 2n+1=0 if p=5. The numerator of A has residues 30,2,4 respectively;
all other denominator factors are units at that prime. A block of p^e
consecutive indices meets the class. Also q_N divides the odd lcm through
8N+5, by the four-fraction expression and odd-denominator normalization.
This proves both bounds. At h=M_N the relative image is a singleton.
Every odd prime power similarly occurs arbitrarily late, so fixing i and
all future forcing phases forces identity on the union of fields of
conductor 4 times an odd integer. No higher 2-power-root claim is made.

Thus finite norm/trace averages cannot import the actual half-circle condition
to all relative conjugates; enough exact future constraints make that average
trivial. Selecting the actual initialized phase remains the missing estimate.
Neither finite abundance nor finite collapse proves C_odd or V.

Clarified frozen report
`/tmp/pi-m4-canonical-selection-clarification-20261127/report-v2.md`, SHA-256
`f501be5671dc1f7ef543d8cc92e284e3fd3c367d97eac5cb55520b635e358338`,
contains the full proof. Parent unchanged-copy replay passed 8,076 checks,
identical receipt and four preserved originals: full fixture image, exact
phase/carry recurrence, 15 actual denominator-collapse anchors, local poles
and synthetic conductor images. Parent and reviewer inspected the pinned
Mathlib cyclotomic automorphism/power-action declarations and archived
fresh-prime argument. These are paper applications, not new Lean exports.
Independent criticism resolved the rational-prefix versus conjugate-phase
wording; final integration review and a counting-window clarification passed.
A proposed shorter collapse
constant was not adopted or needed for this result.

## Finite canonical escape is an actual-threshold covering question

Fix N>=0, q=q_N=den(S_N), and all canonical starts x_0=r/q,
0<=r<q. Keep the exact future A, with
c_(j-1)=floor(16*x_(j-1)+A(N+j)) and x_j its fractional part.
Let R_h be the seeds whose first h carries are even; R_h^* restricts to
gcd(r,q)=1. A uniform escape bound h<=C(N+1), for every N, would imply
the weaker actual C_odd because fract(S_N) is a reduced seed. It would
not by itself prove V. No such bound is established here.

There is an exact fixed-grid description, despite changing forcing
denominators. Put F_0=0, F_j=16*F_(j-1)+A(N+j), H_j=F_j mod 2 in
[0,2), and w_j=8*16^(j-1)*r mod q. The canonical carry is even exactly
when (2*w_j/q+H_j) mod 2 belongs to [0,1). The allowed integer residues
J_j are the following half-open intervals:

```text
H<1:       [0,ceil(q*(1-H)/2)) union [ceil(q*(2-H)/2),q),
1<=H<2:    [ceil(q*(2-H)/2),ceil(q*(3-H)/2)).
R_h = intersection_(j=1)^h (8*16^(j-1))^(-1) J_j in Z/qZ.
```

The inverse is a permutation inverse since q is odd. A second algorithm
uses Q_j=lcm(Q_(j-1),den(A(N+j))) and exact integer divmod of the canonical
numerators. Both methods compared complete ordered survivor arrays at every
step for these exhaustive grids:

| N | q_N | First empty R_h | First empty R_h^* |
| --- | ---: | ---: | ---: |
| 0 | 15 | 5 | 4 |
| 1 | 4095 | 9 | 9 |
| 2 | 765765 | 15 | 15 |

The reduced nonactual seed 13322/765765 has carries
0,4,12,12,6,14,6,2,4,10,12,0,2,4,1. It rejects C<5 for a bound uniform
in every N, not for an eventual bound allowing small exceptions. C=5 is
unproved. A separate capped N=3 search examined only 5,000,000 of
111,035,925 seeds for 20 even carries and found none; 106,035,925 seeds
were unexamined, so that result is inconclusive. No larger constant was fitted.

With forcing replaced by zero, complete period censuses instead leave
8/4, 512/213 and 2080/0 permanent all/reduced survivors on these grids.
These changed-forcing examples separate expansion from the role of actual A.
The previously recorded exact-A trajectory x_j=2/15-E_(N+j) has carry 2
forever, but its irrational initial entry is outside every rational grid.

New forcing denominators also do not merge states: differences remain
16^j*(r-s)/q modulo integers, so all q states stay distinct and form a
translated q-grid before filtering. This persists after the relative
cyclotomic stabilizer becomes trivial. Field collapse supplies no escape.

For any forcing values in (0,1), each target has eight even-carry inverse
branches, each of slope 1/16. The continuum survivor set has measure 2^-h
and at most m_h=(8^(h+1)-1)/7 half-open interval components. Consequently

```text
abs(#R_h-q/2^h)<=m_h,
abs(#R_h^*-phi(q)/2^h)<=2^omega(q)*m_h.
```

The archived denominator asymptotics give reduced survivors when
h*log16<=(6-epsilon)N for fixed epsilon>0 and large N. The upper error
grows like 8^h and never certifies an empty intersection. The missing input
is an integer-strength upper count using the particular A-generated H_j.

Frozen packet `/tmp/pi-m4-finite-grid-escape-20261127/` has report SHA-256
`33b49c60163ad2a1b3441b332a97d1c23b757d7086e54ffa822f32c6404fd162`.
Parent unchanged-copy replay passed both scripts; complete arrays/counts,
fixtures and the partial receipt matched after excluding elapsed-time fields.
All six original artifacts were preserved. Independent paper criticism found
no defect or required improvement. The general identities and asymptotics
remain paper results; finite computation proves no C_odd or V theorem.

### Source limits for escape and separation

[Schleischitz, arXiv:1812.10689v4](https://arxiv.org/pdf/1812.10689v4),
Theorem 3.4, p.8, assumes a one-dimensional affine rational-preserving monic
IFS with OSC and a rational p/q outside its Cantor set C. Our local usable
contract restricts to positive dimension Delta>0. It gives
dist(C,p/q)>exp(-rho*q^Delta), for sufficiently large rho(C). Theorem 4.9,
pp.13-14, concerns an eventually periodic rational expansion in (0,1),
base b>=3 and 2<=|W|<b (the p.1 definition), and assumes a digit outside
W occurs; its first index is
O(q_0^Delta) for reduced denominator q_0 and Delta=log|W|/log b.
Neither establishes exit. Our application limit is stronger than a scale
mismatch: removing the actual forcing introduces the irrational seed
r/q_N+E_N. The natural translated IFS is no longer rational-preserving.
Even for the standard eight-digit base-16 set, the displayed scale becomes
exp((9/2)N+o(N)), not a linear horizon. Branch/borrow identification is
also required before treating canonical carry avoidance as fixed digit avoidance.

[Shparlinski, Theorem 1.1 and Lemma 2.1, p.23](https://doi.org/10.1017/S0004972720000386),
give different rational restrictions. For base g>=2 and a nonempty proper
digit set D, rational membership r/q in C(D), gcd(gr,q)=1, requires
rad(q)>=c(g)log q and P(q)>=c(g)*sqrt(log q*log log q). For positive
r,q with that coprimality, the full-period count of d in {0,...,g-1}
satisfies abs(N_(r,q)(d)-tau(q)/g)<2*tau_0(q), where tau=ord_q(g)
and tau_0=ord_rad(q)(g). The archived fresh primes of q_N meet the
necessary denominator restrictions. No full-period transfer to actual A,
or sufficient order ratio for q_N, has been established.

The current [Gilson v3 abstract and revision comments](https://arxiv.org/abs/2601.11799v3),
dated 10 September 2026, withdraw the earlier log-square exit/separation
claims and retain conditional reductions. Its quadratic setting also does
not contain the actual tail. No result from it is adopted.

The source screen retains primary PDFs/HTML, hashes and four visually inspected
theorem pages under `/tmp/pi-m4-fractal-separation-screen-20261127/`.
Source SHA-256 values, respectively, are
`1bbac7bd2e4d178682b44ded08cd80c9b23883dcaa63423d0592da704a3467e0`,
`8b3c7a2529c38c6cd0e4db2cffb49353fd5cbaad2d45b29030e1fb1fbe4e7855`,
and `0187a2dc1982489739784930fda4b31ad302425eab5366e142c029e150a2159b`.
Independent criticism found no defect; explicit domain clarifications are
incorporated in report v3, SHA-256
`6b43f19d769c4c1990e3b4d1b0f6f952e19bebcdd8c23ddf2d1ac8cc76c9b047`.
The additional p.1 definition was also rendered and visually inspected.
The positive-dimension restriction excludes singleton attractors without
adjudicating the source's broad IFS conventions.
The denominator claims concern q_N, not every unreduced replacement seed.
It assesses these statements and their application, not the full source proofs
or all available literature. None supplies the missing actual-grid cover.

### Logarithmic values do not yet supply pointwise exclusion

Choose the logarithm L=i*pi of -1. If a hexadecimal word w of length ell>=1
has no occurrence starting at any n>=N, with N natural, block the tail into
ell-digit groups. Then

    theta=fract(16^N*pi)=-i*16^N*L-floor(16^N*pi)

belongs to the base-B deleted-digit set for B=16^ell, with the digit encoding
w removed. This is only the aligned-block implication; membership does not
exclude overlapping occurrences. Irrationality removes terminating ambiguity.
A usable logarithmic theorem would need this specified complex branch,
algebraic multiplier, integer translation and every required base/word/tail.

Bugeaud--Kim, [*On the b-ary expansions of log(1+1/a) and e*](https://journals.sns.it/index.php/annaliscienze/article/download/519/509/738),
published 2017, Theorem 2.2, pp.936--937, states: for b>=2, epsilon>0 and
fixed positive integer s, all sufficiently large integers t satisfy

    liminf p(n,xi,b)/n >= 9/8-epsilon

for xi=log(1+s/t) and xi=sqrt(t^2-s^2)*arcsin(s/t). Here p counts distinct
length-n blocks; enlarge the threshold to ensure t>s. The latter value is
-i*sqrt(t^2-s^2)*Log((sqrt(t^2-s^2)+i*s)/t), with first-quadrant argument.
Thus this does include some algebraic multiples of complex logarithms, but
does not cover arbitrary such values or supply the required pi specialization.
The endpoint t=s has zero multiplier; a fixed ratio is not justified by the
large-t statement for fixed s. Even granting the conclusion for pi would not
give visitation: concatenating all binary words as hexadecimal digits 0,1
gives complexity exactly 2^n while omitting fourteen digits.

Algom--Hochman--Wu, [*New results on embeddings of self-similar sets via renormalization*](https://arxiv.org/pdf/2410.19648v1),
v1 (25 October 2024), assumptions p.1 and Theorem 1.2 p.2, concerns two
nontrivial compact self-similar sets defined by finite families of at least
two nonconstant affine contractions with disjoint images. If all contraction
magnitudes alpha_i,beta_j are algebraic and some log(alpha_i) is outside
the rational span of the log(beta_j), no nonsingular affine map embeds the
first entire set into the second. The same contract was checked in the
[published article](https://londmathsoc.onlinelibrary.wiley.com/doi/full/10.1112/plms.70177),
first published 6 July 2026; no full version or proof comparison is claimed.

A point theta in a deleted-digit set supplies no such nontrivial embedding.
Singletons and constant maps violate the hypotheses. Strong separation needs
checking when digit cylinders share endpoints. Radix-power contractions have
logarithms in Q*log B, and Log(-1)=i*pi is not a real logarithm of a contracting
magnitude. Neither the embedding nor incompatible contractions follow from
BBP initialization. These are missing bridges, not defects in the source.

Even a future ordinary-orbit exclusion argument would need a reverse late
transfer to the recurrence. B2 and the recurrence range give

    bbpRecurrence(n+1)=fract(t_n-R_n),
    t_n=fract(16^n*pi), R_n=bbpTail(n).

For 0<=a<b<=1 take delta=(b-a)/3. B3 supplies |R_n|<delta beyond M. A
hypothetical ordinary visit to (a+delta,b-delta) with n>=max(N,M) puts
t_n-R_n in (a,b), so there is no wraparound. This paper argument preserves
both the threshold and n+1 offset. It is not a direct use of forward B4 or
a newly compiled reverse-transfer theorem, and supplies no ordinary visits.

The bounded screen found no applicable pointwise exclusion theorem; it is
not an exhaustive literature conclusion. Authoritative clarification
`/tmp/pi-m4-logarithmic-fractal-parent-20261127/report-v2.md`, SHA-256
`82e071fd0256c36287d4d1760542731039fc970ebdb371dde0658ddfbd241862`,
retains the exact contracts and application failures. The original 18-artifact
packet is preserved. Parent and independent reviewer visually inspected six
source pages; the retained publisher receipt matches the cited contract.
Independent review and its focused clarification passed, resolving explicit
positive block length/late-start domains and the reverse-transfer margin.
Neither entire external proof was audited, and no source theorem was added
to Lean. Actual C_odd, V and M4 remain open.

## Rational gauges and endpoint-conditioned parity

The shifted-coefficient inquiry first recovered archived telescoping/filter
obstructions, then tested their effect on canonical parity. Define
B_t(x)=sum_(i=1)^t16^(t-i)A(x+i), t>=1. For fixed R in Q(x) and beta in Q,
the exact and rational-gauge comparison endpoints from r/q_N differ by

```text
T=16^t*r/q_N+B_t(N),
T_model=16^t*r/q_N+R(N+t)-16^t*R(N)+beta,
D=B_t(N)+16^t*R(N)-R(N+t)-beta.
```

Each of B_t's 4t pole classes modulo tZ has a nonzero weighted residue.
The same residue vanishes for R(x+t)-16^t R(x), so D, as a rational function
of N, has a nonzero proper rational part. Its polynomial part takes values
in a fixed rational lattice. Thus for some fixed c>0 and integer d>=1,
delta_N=dist(D,2Z)>=c*N^-d at every sufficiently large N. This holds for
fixed t,R,beta; a separately chosen gauge at each N is excluded.

There is more structure than a whole-grid discrepancy bound. Write the exact
raw endpoint as T=K+x_h, with x_h in [0,1), and compare it with T-D.
For d_0=D mod2 in [0,2), the floors have different parity exactly when

```text
x_h in J_D=[0,d_0) if d_0<=1, or [d_0-1,1) if d_0>=1.
```

Both descriptions give the full cell at d_0=1; d_0=0 gives the empty set.
The interval length is delta=dist(D,2Z). For ANY specified carry-parity word
epsilon of length h>=1, its real initial seeds R_epsilon have the exact
terminal-state identity, for measurable J contained in [0,1),

```text
Leb{x_0 in R_epsilon : x_h in J}=2^(-h)*Leb(J).
```

At each step every target has eight inverse branches of either parity,
each of slope 1/16. The even outer branches switch at the actual forcing
value; the half-open endpoints leave exactly one available. Iterating
this identity proves the formula without an assumed probabilistic model.
In particular it retains every intermediate ACTUAL parity constraint.

At the matched endpoint t=h, backward preimages of J_D have at most
m_h=(8^(h+1)-1)/7 interval components. For any odd q>1, a star restricting
the initial r/q seeds to gcd(r,q)=1, interval counting gives

```text
abs(#(R_epsilon(q) intersect Mismatch)-q*delta/2^h)<=m_h,
abs(#(R_epsilon(q)^* intersect Mismatch)-phi(q)*delta/2^h)
  <=2^omega(q)*m_h.
```

For the actual q_N and fixed h=t,R,beta, the preceding residual lower bound
and archived denominator asymptotics imply exp(6N+o(N)) mismatches even
among all-even survivors. These are false odd endpoint labels of the
comparison model: the qualifying ACTUAL last carries are even. They supply
no odd actual carry and do not identify the actual initialized seed.

For the archived truncation R_m(x)=-sum_(i=1)^m16^-i A(x+i), take beta=0,
t=h and m>=h>=1. The exact error is D=16^-m B_h(N+m)>0, and

```text
(5/1638)*16^(h-m)/(N+m+1)^2 <= delta=D
  <=16^(h-m)/(15*(N+m+1)^2)<1.
```

A fixed even beta gives the same parity counts but a different signed error.
For m=O(N), the conditional main/error exponent gap is 6N-m*log16+o(N).
Thus m*log16<=(6-epsilon)N, with fixed epsilon>0, gives exponentially many
conditioned mismatches. The condition concerns m, not m-h; the latter was
the separate whole-grid comparison. It is not uniform over adaptive beta_N.

This particular bound cannot reach a permutation-resonant lag. Indeed for
ANY delta<=1, h>=1 and q>1 with q dividing 16^h-1,

```text
phi(q)*delta/2^h <= q/2^h <8^h <=m_h <=2^omega(q)*m_h.
```

Its displayed lower bound is strictly negative at every such instance.
This says nothing about the true count, which may be positive or zero.
The matched-endpoint identity repairs the earlier broad claim that survivor
correlation was entirely missing. The remaining requirements are stronger
long-horizon arithmetic estimates, actual-seed selection, and control of
intermediate MODEL carries if a full language transfer is attempted.
A varying rational gauge can still cancel one chosen endpoint exactly;
this does not supply coherent control over a whole window.

The original lag report in `/tmp/pi-m4-rational-lag-correlations-20261127/`
has SHA-256
`64a6243355fdecfe31e598c9680b18e06d20188282fe5f86c9ca567935f93344`.
Its authoritative correction/extension is
`/tmp/pi-m4-endpoint-conditioned-clarification-20261127/report-v2.md`,
SHA-256 `606c85e7b81ace8ef89882a46c7769b79198481e76e4bf959849969c874bb604`.
It explicitly repairs the ancillary filter bound's nonzero-W domain,
the beta specialization and the earlier overbroad survivor limitation.
Independent initial and focused paper reviews completed with all three
findings resolved. Parent unchanged-copy replays passed 1,971 initial cases
and two constructions of 1,400 complete synthetic qualifying sets, with
identical receipts and all originals preserved. No actual q_N census or
digit search was used. General identities/asymptotics remain paper results;
C_odd, universal grid escape, V and M4 remain unproved.

## Ordered reciprocity retains an unestimated carry correlation

The completed actual-seed reset and affine-update test examine a specific
compressed-state proposal, not all reciprocity methods. Put B(x)=fract(x)-1/2
off the integers and B(x)=0 at integers. For integer p and integer q>=1 define

```text
s(p,q)=sum_(j=0)^(q-1) B(j/q)*B(p*j/q),
R(p,q)=sum_(j=0)^(q-1) B((2j+1)/(2q))*B(p*(2j+1)/(2q)).
```

The finite sums are defined without coprimality. Residue permutation gives
s(p,q)=s(p^(-1),q) when gcd(p,q)=1. Fix odd q>1 and canonical inverse units
1<=a,b<q of opposite parity. For any k>=1 and raw residue r modulo 2^k,
the unique K_a,K_b in [0,2^k) solving a+qK_a=b+qK_b=r modulo 2^k have
opposite parity. Thus the two positive raw rationals share their denominator,
ordered sum and raw precision, but have opposite floor parity. Canonical a,b are
essential to identify those floors with K_a,K_b.

For example q=4095, a=11, b=2606 give s=752741/24570. The raw numerators
200666=49q+11 and 199166=48q+2606 are both 2 modulo 4 and lie between 0
and 64q. They match the archived actual S_1 numerator 205826 only in that
coarse congruence. Their sums agree **with each other**; no equality with
s(205826,4095) is asserted. They do not retain the actual initialized past.

Even/odd splitting gives R(p,q)=s(p,2q)-s(p,q). For even p, distribution
of B further gives R(p,q)=s(p/2,q)-s(p,q). The half shift distinguishes
some collisions, but a naive sign consumer fails: R(6,11)=-1/11 although
0<6/11<1, and R(4,7)=0. These are limited counterexamples, not a proof
that every function of shifted sums fails to determine parity.

For the actual rational coefficient write P=120n^2+151n+47 and
D=(2n+1)(4n+3)(8n+1)(8n+5), n>=0. Take an abstract integer u>=0 and odd
q>=1 with gcd(u,q)=1. Set N=qD, v=16uD+Pq, g=gcd(v,N), p=v/g, Q=N/g.
Then 16u/q+A(n)=p/Q in lowest terms, Q and g are odd, and p has the parity
of n+1. The unreduced matrix has determinant 16D^2, not 1. Distribution
of B, grouping residues modulo q, proves s(gp,gq)=s(p,q) for every positive
g; the splitting identity gives R(gp,gq)=R(p,q) as well.

With z_j=(2j+1)/(2N), the exact update is

```text
C=sum_(j=0)^(N-1) B(z_j)*floor(fract(16uD*z_j)+fract(Pq*z_j)),
R(p,Q)=R(16u,q)+R(P,D)-C,
abs(C)<=(N^2-1)/(8N).
```

Indeed B(a+b)-B(a)-B(b) is 1/2-floor(fract(a)+fract(b)) plus
(1_(a+b integral)-1_(a integral)-1_(b integral))/2. Each weighted endpoint
sum cancels under j -> N-1-j, as does the constant term. Reduction of the
two remaining sums proves the formula. The bound is the total positive
mass of B(z_j). It gives no sign or actual-history estimate for C.

The scalar update fails even if R(16u,q) is supplied. At n=1, P=318,
D=2457 and A(1)=106/819, the synthetic entries u/q=6/17 and 28/17 have
R(u,q)=R(16u,q)=0, the same even numerator parity, g=3 and Q=13923.
Their reduced outputs are respectively 80426/13923 and 368714/13923,
with R=-6467/5967 and 2659/5967, and floors 5 and 26. Their weighted C
values are 6592/4641 and -506/4641; R(P,D)=827/2457 in both cases.
Thus the listed data determine neither the next scalar nor its floor parity.
The full numerator is not among those compressed data.

For any k>=1 choose t>=0 with 17t=-11 modulo 2^(k-1). Replacing 28 by
28+34t matches 6 modulo 2^k, preserves the old sums, and shifts the next
raw value by the even integer 32t. The output R, denominator reduction and
floor parity are unchanged. No uniform height bound is claimed as k grows.
Raw input floors need not vanish: floor(16(K+x)+A)=16K+floor(16x+A), so
the next raw parity equals the canonical carry parity. None of these inputs
is asserted to be an actual initialized entry.

Classical reciprocity in Hall--Wilson--Zagier,
[*Reciprocity formulae for general Dedekind--Rademacher sums* (1995), p.389](https://people.mpim-bonn.mpg.de/zagier/files/acta/73-4/fulltext.pdf),
applies to positive coprime arguments with the stated integer convention.
Subtracting its two instances gives, for positive coprime p,Q with Q odd,

```text
p=2r: R(2r,Q)=R(Q,r)+[-r/Q+Q/(2r)+1/(2rQ)]/12,
p odd: R(p,Q)=R(2Q,p)+[-p/(2Q)+Q/p-1/(2pQ)]/12.
```

The reciprocal modulus depends on the full updated numerator. Reducing first
to pbar=p-2Q*floor(p/(2Q)) instead retains floor(p/Q) mod 2=floor(pbar/Q),
the unresolved selected half. Neither form supplies the required control of
C at actual initialized entries. The source statement and page were inspected;
its classical proof and general three-variable theorem were not adopted here.

The reset's authoritative report is
`/tmp/pi-m4-reciprocity-clarification-20261127/report-v2.md`, SHA-256
`8c1c0ffd96cc5889f96bc6501ebc515e37d759529455ca3776497d771746bd5a`.
It repairs the sum's domain and canonical-unit hypotheses, and distinguishes
pairwise agreement from agreement with an actual statistic. The affine report is
`/tmp/pi-m4-affine-reciprocity-test-20261127/report-v1.md`, SHA-256
`7c083ca4a3bc6884644b214cd71d1969c65954b2f7e84b02a717ef420d3da2fe`.
Parent unchanged-copy replays passed 160 and 78 exact checks with identical
receipts and all original artifacts preserved. Universal identities remain
paper mathematics; the checks are synthetic diagnostics, not actual phase
computations. Separate paper reviews and the reset's focused repairs passed.
No C_odd, V, global covering or M4 acceptance follows.

## Evidence boundary

The frozen sine-zero report is `/tmp/pi-m4-sine-zero-report-v1.md`, SHA-256
`5e7e557e44d5a126f7350cc894223d7e34d299c96b0e446ac53e775f49eb2b84`.
The parent read and replayed its v2 checker with exit 0 and a matching
receipt: prefix enumeration through depth 4, the exact degree-825
exponential polynomial and all 32,768 subset sums, and the degree-15 node
polynomial with its exact content and roots. No pi digits were computed.
The parent independently reconstructed the product comparison and content
count and visually inspected both source theorem pages.

The parent manifest `/tmp/pi-m4-sine-zero-parent-manifest-v1.json`, SHA-256
`8539c8d0b7103d8a8ed37f8389b4823ba92d9ef36a7151e0d662457d3ccc6946`,
retains the original evidence chain, both source PDFs/pages and replay.

The automaton report `/tmp/pi-m4-automaton-20261126-report.md` has SHA-256
`f053c31968772600efd60af7bcbe044d40707170cf3f9d0f2bcd665e68d85210`.
The parent read its full checker and replayed a copy changing only the
receipt output path, preserving the frozen original. Its matching receipt
checks four tensor polynomials, two maximal-order polynomials and all their
moments, 16 rational recursions, uncancelled double poles, and cyclotomic lcm
degrees through depth 3. All nine original manifest hashes were verified
unchanged. The parent reconstructed the moment, simplex, pole and cyclotomic
arguments and visually inspected the Lesch and measure-theorem pages.

These finite checks do not certify universal analytic arguments. Independent
review found no D/I/Q items. The tested constructions separate cancellation from branch
selection; they do not exclude all possible language auxiliaries. V and M4
remain open. A next estimate must use the actual selected state to obtain
branch-dependent cancellation or bound the resolvent at that state.
