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
