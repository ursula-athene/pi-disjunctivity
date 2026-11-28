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

## A local Euclidean matrix factor does not select carry parity

For a reduced canonical r/q, q positive odd, complete (r,q) to
U=[[r,s],[q,t]] in SL(2,Z), with t the inverse of r modulo q in [0,q)
and s=(rt-1)/q. At r=0,q=1 use s=-1,t=0. For the exact coefficient
A(n)=P/D and M=[[16D,P],[0,D]], put v=16Dr+Pq, N=Dq,
c=floor(v/N), g=gcd(v,N), R=(v-cN)/g and Q=N/g. With
T=[[1,1],[0,1]] and U'=U(R,Q), the exact update is

```text
T^(-c)*M*U=U'*B,  B=[[g,lambda],[0,h]],  gh=16D^2.
```

The first column and determinant prove this triangular form over the integers.
Since g is odd, g divides D^2 and h is divisible by 16. If t' is the
lower-right entry of U', lambda=g*t/q-h*t'/Q, hence -h<lambda<g.
The parity equations R=P-c mod2 and lambda=t mod2 retain the unspecified
output numerator; they do not choose the carry.

At n=1, the synthetic inputs 211/819 and 499/819 have completions
[[211,76],[819,295]] and [[499,92],[819,151]], equal modulo 16.
Both give exactly B=[[2457,-30603],[0,39312]], but their carries are
4 and 9 and their next fractions are 206/819 and 719/819. Thus the full
local B, input U modulo 16, q, and canonical positivity do not determine
carry parity. These entries do not retain the actual zero history or its
denominator at n=1. Full U retains the entire numerator and does determine
the next step; no contrary claim is made.

The failed consumer does not exclude higher precision, additional initialized
history or other matrix methods. No such useful additional constraint was
obtained. Report `/tmp/pi-m4-euclidean-history-discovery-20261127/report-v2.md`
retains the full derivation and notation correction. Parent unchanged-copy
replay matched 10,030 synthetic updates and both collision fixtures; no actual
future phases were computed. Separate paper review found no remaining defect
or improvement. Actual-history selection, odd-carry visitation and V remain open.

## Finite algebraic profiles do not follow from a restricted language

The exact rational forcing excludes a finite algebraic description of its
states, but this does not exclude a finite forbidden-word language. More
precisely, for any finite set D of complex constants and any sequence
u_(n+1)=16u_n+A(n)-d_n with d_n in D, there is no finite family of functions
algebraic over C(z), each with a fixed analytic branch on a sufficiently large
positive real ray, whose values cover u_n at every sufficiently large integer
n. This statement needs neither boundedness nor initialization. Actual
canonical carries lie in {0,...,19}, since 0<A(n)<4 and 0<=y_n<1.

A nonzero algebraic function has finitely many zeros on such a branch:
its minimal polynomial has a nonzero rational constant coefficient, which
must vanish at each zero outside finitely many exceptional points. Thus each
infinitely recurring triple (s,t,d) in a proposed finite cover forces the
identity f_t(z+1)=16f_s(z)+A(z)-d. Discard finitely occurring triples.
The remaining infinite path in a finite graph has a directed cycle of length
L>=1, giving

```text
f(z+L)=16^L*f(z)+B_L(z)-C,
B_L(z)=sum_(j=0)^(L-1)16^(L-1-j)*A(z+j),
C=sum_(j=0)^(L-1)16^(L-1-j)*d_j.
```

If algebraic f satisfies f(z+L)=a*f(z)+b(z) with nonzero constant a and
rational b, let its monic minimal polynomial start Y^d+c_1(z)Y^(d-1).
The monic degree-d annihilator a^(-d)M(z+L,aY+b) equals M by minimality.
Its next coefficient gives c_1(z+L)+d*b(z)=a*c_1(z). Therefore the rational
R=-c_1/d satisfies the same affine equation.

This is impossible for the displayed B_L. With q=16^L, a rational R's
principal-part coefficients t_j at beta+jL give coefficients
t_(j+1)-q*t_j for R(z+L)-qR(z). Their finite weighted sum with weights
q^(-j) vanishes, separately at every pole order. In the class
beta=-1/8 modulo L, B_L has just one pole, residue 16^(L-1)/2. The
other three fractional pole classes are distinct modulo integers. The
nonzero weighted residue contradicts the rational equation, proving the claim.

The archived rational-period model F makes the missing language implication
concrete. Its phases 11/21,8/21,2/21 and tail bound 0<E_n<1/150 show that
its canonical carries from index n=1 repeat exactly 8,6,1. Its states need
not be periodic. Yet its L-block weighted residue in the same class is
16^(L-1)*(15/16), so the same proof excludes finite algebraic state profiles.
Thus even a periodic carry language under fixed rational forcing need not
produce algebraic state formulas. F still lacks the actual four-pole forcing
and irrational period; it refutes no rational-or-dense theorem.

### A zero theorem closes the sampled tail-profile gap

For r in {1,4,5,6} define T_r(z)=sum_(j>=0)16^(-j-1)/(8(z+j)+r), with
local uniform convergence off its negative pole ladder. Then
16T_r(z)-T_r(z+1)=1/(8z+r). For any algebraic branch R on an eventual
positive ray and constant complex c_r, the expression R(x)+sum c_r T_r(x)
is nonzero for every sufficiently large positive real x unless R=0 and all
c_r=0. In particular infinitely many integer zeros force those trivial data.
The threshold is neither effective nor uniform over R and c.

Here is the analytic argument. Set N(X)=sum c_r X^r and

```text
F_c(t)=N(exp(-t/8))/(8*(16-exp(-t))),
sum c_r*T_r(x)=integral_0^infinity exp(-xt)*F_c(t) dt,
sum c_r*T_r(x)=sum_(m=0)^(M-1) F_c^(m)(0)*x^(-m-1)
                 +O_M(x^(-M-1)),  for each fixed M>=1.
```

Absolute integrals are bounded by sum |c_r|/[15(8x+r)]. Taylor expansion
on [0,epsilon] gives an O_M(t^M) remainder, whose integral is
O_M(x^(-M-1)); tails beyond epsilon are exponentially small because F_c
decays on the positive ray. If N is nonzero, degree N<=6 prevents it from
canceling all eight roots of 16-X^8. Hence F_c has a genuine complex pole.
Its derivatives at zero cannot have an exponential bound: otherwise their
exponential generating series would be entire and remove that pole.

An algebraic branch at infinity has a convergent Laurent-Puiseux expansion.
The classical branch statement is recorded in Canino--Gimigliano--Ida,
[*The Newton--Puiseux Algorithm and Triple Points for Plane Curves* (2023),
section 1](https://www.mdpi.com/2227-7390/11/10/2324).
Apply it with w=1/x, allowing a finite principal part or inverting a pole.
If the combined asymptotic expansion has a first nonzero term d*x^alpha,
that term makes the expression eventually nonzero, including for complex d.
If all terms cancel, the Puiseux series has only integer negative powers
and its convergent coefficients equal -F_c^(m)(0), an exponential bound
contradicting the pole argument. Therefore N=0; the algebraic zero argument
then forces R=0. This does not discard flat terms by an invalid uniqueness
claim. Source statement/application were inspected, not the full Puiseux proof;
no corresponding Lean declaration is claimed.

Now suppose the actual states eventually have finite profiles
f_s=R_s+sum c_(s,r)T_r, with algebraic R_s on fixed eventual branches and
constant coefficients. On a recurrent sampled triple, apply the zero theorem
to the complete algebraic remainder

```text
E_(s,t,k)=R_t(z+1)-16R_s(z)-A(z)+k-sum_r c_(t,r)/(8z+r),
E_(s,t,k)+16*sum_r(c_(t,r)-c_(s,r))*T_r(z).
```

The second line vanishes at infinitely many integers, so c_t=c_s and
E_(s,t,k)=0 as a germ. The rational correction is essential. Vectors c
therefore agree along the eventual path. A cycle and the four pole classes
force c=-(4,-2,-1,-1). The algebraic remainder on that cycle is constant:
a nonzero algebraic h with h(z+L)=16^L h(z) would make its nonzero rational
minimal-polynomial constant coefficient scale by 16^(Ld) under translation,
whereas its asymptotic ratio must be 1. Integer labels make the cycle's
constants rational. At an actual occurrence of a cycle state this contradicts

```text
T_A=4T_1-2T_4-T_5-T_6,  T_A(0)=pi/16,
y_n+T_A(n)=16^n*(pi/16)-integer.
```

The lift need not lie in [0,1). The result excludes sampled finite profiles
of precisely this form. It supplies no finite-profile cover from word
avoidance: a finite recognizer still retains an arbitrary infinite path.
Further profile classification without that consumer is suspended. C_odd,
V, global covering and M4 remain open; B4/P3 retain their visitation premises.

The original report in `/tmp/pi-m4-exact-function-recovery-20261127/` has
SHA-256 `aaaf45bc62a7f2f22992a223e1f8a99dd3f3efa1e869a8f2b1c9f4fb8abf3699`;
its tail extension explicitly required edge identities. The authoritative
sampled-zero extension is
`/tmp/pi-m4-tail-profile-zero-clarification-20261127/report-v2.md`, SHA-256
`47c47e0caa7e1b0bb7a3206b509cea324e26b79ff71b5c3af279494054644e37`.
Parent replay passed 492 exact synthetic checks with identical receipt and
preserved originals; 136 separate exact coefficient comparisons check the
Laplace normalization. Independent combined paper review and its focused
remainder/source clarification passed. The universal arguments remain paper
proofs, not consequences of those finite checks or kernel certification.

## Polynomial telescopes and exact integer-path cuts

The direct language-consumer inquiry tested an additive polynomial telescope
for q(k)=(1-(-1)^k)/2, the odd-carry indicator. For n>=1 suppose

```text
P_(n+1)(16x+A(n)-k)-P_n(x)=r_n+v_n*q(k)
```

holds throughout every nonempty carry branch. Each branch has an interval
of interior, so the equality extends as a polynomial identity. Subtracting
two branches shows that two distinct translates of P_(n+1) differ by a
constant. A degree d>=2 polynomial would leave a nonzero degree d-1 term;
therefore both polynomials are affine. The values q(0),q(1),q(2)=0,1,0 then
force v_n=0 and the affine slope to vanish. Requiring the identity only on
even branches also removes state dependence. This rules out that uniform
scalar polynomial consumer, not identities sampled only at the actual state,
analytic potentials or automaton-dependent constructions.

For arbitrary finite weights, the exact linear identity is

```text
sum_(n=N)^M w_n*k_n = sum_(n=N)^M w_n*A(n)
  +16*w_N*y_N-w_M*y_(M+1)
  +sum_(n=N+1)^M (16*w_n-w_(n-1))*y_n.
```

Eliminating each interior coefficient requires w_n=c*16^(-n), returning
the existing period sum pi, or y_N+T_A(N) with late normalized weights.
The multiplicative analytic identity
exp(pi*i*y_(n+1))=exp(pi*i*A(n))*exp(pi*i*y_n)^16*(-1)^k_n
escapes the polynomial obstruction: its sign factor equals 1 under even
carries. No estimate for its selected phase follows.

### Single projections of the integer cells

Retain the actual reduced entry y_N=a/q, with N>=1 and odd q>0. Define
F_0=0, F_j=16F_(j-1)+A(N+j-1), and R_j=16^j*a/q+F_j. Choose

```text
Q_j=lcm(3,q,den A(N),...,den A(N+j-1)),  b_j=1-1/Q_j.
```

These odd envelopes are at least 3 and need not be reduced denominators.
For integer L_j, the strict condition 0<=R_j-2L_j<1 is exactly
0<=R_j-2L_j<=b_j. Thus an all-even block is equivalent to an integer point
in the product of closed cells I_j=[(R_j-b_j)/2,R_j/2], j=1,...,h.
With L_0=0, x_0=a/q and x_j=R_j-2L_j,
2(L_j-16L_(j-1))=16x_(j-1)+A(N+j-1)-x_j lies in (-1,17).
Its even integrality supplies the increment bounds 0<=L_j-16L_(j-1)<=8.
Those bounds are redundant for integer feasibility, not for every real
relaxation. Inflating an envelope can weaken the real box while preserving
its integer equivalence.

Writing Q_jR_j=2Q_j*m_j+t_j, 0<=t_j<2Q_j, the coordinate integer hull is
{m_j} when t_j<Q_j and empty otherwise. Direct rounding therefore returns
the unknown parity of floor(R_j); it supplies no new visitation estimate.

The tested cut family projects only these independent unrounded boxes by
a nonzero primitive c in Z^h. Its exact interval for sum c_jL_j has width

```text
W=(1/2)*sum |c_j|*(1-1/Q_j) >= ||c||_1/3.
```

If ||c||_1>=3, the closed interval has length at least 1 and contains an
integer. Only coordinate and two-coordinate projections can separate.
Exact real seed cancellation, sum c_j16^j=0, requires ||c||_1>=17:
the first nonzero coefficient is divisible by 16, and another is nonzero.
The adjacent pair (-16,1) attains this bound. This excludes a single
lattice-free projection interval, not simultaneous rounded cuts, additional
increment constraints, elimination of fixed coordinates or other integer
proof systems. A common coefficient factor must first be divided out.

For i<j, put eps=1/Q_i+1/Q_j. The two remaining pair tests separate exactly
in these OPEN windows, with residues taken in [0,2):

```text
(R_i+R_j) mod2 in (2-eps,2),
(R_i-R_j) mod2 in (1-1/Q_i,1+1/Q_j).
```

Equality at an endpoint leaves an integer in the projection. Because i>=1,
the actual seed contribution disappears modulo the projection lattice iff
q divides 16^(j-i)+1 for the plus pair, or 16^(j-i)-1 for the difference.
These modular cancellations are genuine exceptions to exact cancellation;
q=1 is included. The fixed L_0=0 is not another free cell. At resonance the
same open windows apply to F_i+F_j or F_i-F_j. No actual forcing-residue hit
or uniform separating sign is known. Away from resonance, a/q remains in
the test. Order, denominator growth and complete-period averages do not
supply its selected sign.

In odd-denominator arithmetic A(n)=n+1 modulo 2, so Q_jR_j has parity N+j.
This is not floor parity. With equal envelopes Q_i=Q_j=Q, each window has
one possible grid residue, respectively 2Q-1 and Q, both odd. Equal-parity
i,j therefore cannot separate in that subfamily; opposite parity still
leaves an unknown exact residue. A common envelope may weaken the boxes.

For a discriminator retaining exact future A but changing the entry, take
1/5 at N>=16^h. The bound A(n)<1/(2n) gives 0<F_j<1/30 for 1<=j<=h.
Then floor(R_j)=(16^j-1)/5 is odd and every coordinate cell is empty.
Nevertheless every primitive non-coordinate projection contains an integer:
large coefficient mass was settled by width; for pairs, the sum/difference
of these odd floors is even, and each fractional part lies in [0,b_j].
All difference pairs are resonant since 5 divides 16^d-1. This is a finite
changed-entry countertest, not an actual initialized counterexample or a
refutation of stronger coupled cuts.

The surviving family can work for different forcing: q=3, B_0=1/5 and
B_1=1/45 give F_1=1/5, F_2=29/9, Q_1=15 and Q_2=45. Their difference
residue 44/45 lies strictly in (42/45,46/45), excluding every a/3 entry.
This synthetic positive fixture loses the actual BBP forcing and proves
no C_odd result. Its purpose is to distinguish a missing actual sign from
an algebraically impossible certificate.

The polynomial report's authoritative v2 is
`/tmp/pi-m4-language-consumer-clarification-20261127/report-v2.md`, SHA-256
`e15d546d3ad8203d4c9af55636b90064f78f8bbbb74abd4cc0964eb3511a2b12`.
The integer-cut report is
`/tmp/pi-m4-integer-path-cut-test-20261127/report-v1.md`, SHA-256
`46c21cbe72ebc43ed11de29d9321f03af948337833d7bbd5b17ab088e3a9214a`.
Parent unchanged-copy replays passed 380 and 4,136 exact synthetic checks,
with identical receipts and preserved originals. These finite checks do
not certify the universal paper arguments. Independent review is recorded
in the continuation review report; no Lean result or actual phase census
is added. Coupled resonant constraints are a separate inquiry, with no
unfinished claim adopted. C_odd, V and M4 remain open.

## Coupled resonant cycles retain the actual lattice placement

Single-projection nonseparation does not imply that all rounded pair
constraints are consistent. Keep the preceding actual-entry cells I_j and
write d_j=16^j*a/(2q), I_j^F=[(F_j-b_j)/2,F_j/2], so I_j=I_j^F+d_j.
For a resonant pair use s_ij=1 for a difference and -1 for a sum:
16^i=s_ij*16^j modulo q. Its projection has width (b_i+b_j)/2<1.
If it contains an integer, that integer k_ij is unique and forces

```text
L_i-s_ij*L_j=k_ij,
k_ij=d_i-s_ij*d_j+kappa_ij,
kappa_ij = the unique integer in I_i^F-s_ij*I_j^F.
```

An empty individual projection is already a certificate. For the coupled
case assume q>1 and that the individual projections pass. Multiplying the
resonances around a cycle gives product s_ij=1: otherwise q would divide 2.
Thus choose vertex signs sigma_j, with root sign 1 per component, such that
s_ij=sigma_i*sigma_j. The variables Z_j=sigma_j*L_j satisfy ordinary integer
difference equations. They have integer solutions exactly when all oriented
cycle sums of sigma_i*k_ij vanish, by assigning potentials along a spanning
tree. Seed contributions telescope in these sums. A nonzero circulation
of sigma_i*kappa_ij therefore excludes every entry a/q with this future A;
that is a stronger test than exclusion of the actual selected entry.
The q=1 case permits both signs and is outside this balanced-graph claim.

The full resonance graph is a union of cliques. If all rounds and cycles
pass, choose integer forcing potentials p_j^F satisfying
p_i^F-p_j^F=sigma_i*kappa_ij. After reflecting intervals when sigma_j=-1,
the closed intervals sigma_j*I_j^F-p_j^F intersect pairwise, hence have a
nonempty common real interval H_C. Its length is less than 1/2. A sparse
graph's cycle test alone does not guarantee this common intersection.
For a full component with root r, sigma_j*d_j-d_r is integral, and original
integer feasibility still requires

```text
(d_r+H_C) intersects Z,   d_r=16^r*a/(2q),
```

in every component with the SAME actual a/q. A real common translation is
not automatically an integer one. Equivalently the signed forcing arcs
have a common point modulo 1, but the entry prescribes the particular point
-d_r modulo 1. Coupling can reject all phases; otherwise that placement
remains a selected arithmetic obligation.

There is a positive synthetic test with q=5 and forcing
(4/15,2/3,11/15), all in (0,1). Its three F values are
(4/15,74/15,239/3), and Q_j=15. Every pair passes individually, with
kappa_12=-2, kappa_23=-37, kappa_13=-40; their circulation is 1.
Thus coupling supplies a genuine new certificate in a valid recurrence
model, while losing the exact BBP forcing.

For the actual A, one fixed forcing-only check at recurrence anchor N=1,
q=15, h=5 gives an exact certificate. This is the archived grid table's
raw/orbit anchor 0; its five-step escape was already known. Since 16=1
modulo 15, all difference pairs are resonant. All ten pair projections
pass, but exact endpoint rounding gives

```text
kappa_14=-271,  kappa_45=-4060,  kappa_15=-4330,
kappa_14+kappa_45-kappa_15=-1.
```

The seed contributions obey the corresponding identity with zero right
side. This excludes an all-even block of length five for every a/15 without
evaluating the actual numerator or initialized digits. The full rational
endpoints, F_j and Q_j are retained in the report and fixed-anchor receipt.
This explains an existing finite escape, not arbitrarily-late C_odd or V.

Let D be the least positive d with 16^d=+1 or -1 modulo q>1. Components are
indices modulo D, so a cycle requires h>=2D+1; also 16^D>=q-1. At the
archived q=765765, D=30, so h=15 has no resonant pair at all and a triangle
requires h>=61. The known grid escape there is h=15. Thus this mechanism
does not explain all known finite escapes or supply their uniform bound.

The exact-A changed-entry family 1/5 at N>=16^h also defeats all coupled
resonant equations: only differences resonate, their unique values are
(K_i-K_j)/2 for the odd K_j=(16^j-1)/5, and these have zero circulation.
Integer potentials (K_j-1)/2 leave a common real translate interval contained
strictly in (0,1) and containing 1/2. It misses Z, even though every edge
equation has an integer solution. This illustrates the remaining lattice
placement, not an actual initialized counterexample. More generally that
short horizon gives F_j<1/30<b_j, so zero lies in every forcing box and
the rounded resonant rows are consistent. The actual denominator's lag
bound is already stronger than this short-horizon observation asymptotically.

The existing identity F_j=16^j*T_A(N)-T_A(N+j) exposes the remaining issue:
the forcing arcs still contain the amplified initialized period. No
BBP-specific late spread estimate follows from graph consistency. The frozen
report `/tmp/pi-m4-coupled-resonant-cuts-20261127/report-v1.md` has SHA-256
`55edc6090bf7f02bd39c99273412ae838451da1b31847f4a978850d2d845af60`.
Parent unchanged-copy replay passed 6,889 exact checks, with an identical
receipt and six originals preserved. Universal arguments remain paper
proofs; separate review belongs to the continuation review record. No new
Lean declaration or arbitrary-late visit is claimed.

### The order-scaled triangle fails at the next anchor

One concrete proposed extension takes tau_N=ord_(q_N)(16) and the indices
(1,1+3*tau_N,1+4*tau_N), asking for a failed pair or nonzero circulation
at every actual anchor with q_N>1. Together with eventual q_N>1 from the
archived denominator growth, that would prove C_odd, still not V.
It reproduces the successful (1,4,5) triangle at N=1, q=15, tau=1.

The next actual recurrence anchor N=2 has q=4095=16^3-1 and tau=3.
Its order-scaled indices (1,10,13) retain exact difference resonance, but
each forcing projection contains a unique integer strictly inside its
endpoints, and

```text
kappa_(1,10)=-1496982155,
kappa_(10,13)=-6130141924695,
kappa_(1,13)=-6131638906850,
kappa_(1,10)+kappa_(10,13)-kappa_(1,13)=0.
```

This refutes the stated all-anchor disjunction, not an eventual variant
allowing exceptional anchors. Integer forcing potentials
(0,1496982155,6131638906850) leave a nonempty common interval H strictly
inside (-1,0). With the reduced CHANGED entry 53/4095, the root shift is
d_1=424/4095 and H+d_1 contains 0 strictly. The integers
L_t=p_t+(d_t-d_1), d_t=16^t*53/(2*4095), lie in all three sampled original
cells. Exact endpoints and witnesses are retained in the receipt. This
does not preserve the actual numerator or assert even carries at omitted
indices, so it does not contradict the archived full-grid escape at h=9.

Resonance and a matching repunit denominator do not select a separating
triangle. The countertest rejects this stencil, not other cycles or a
general coupled method. A revised selection rule must distinguish the
explicit common overlap from the N=1 incompatible triple; repeating those
order-scaled offsets or a fixed-index anchor congruence does not address it.
The raw initialized prefixes were used only to return their reduced
denominators; no actual canonical numerator, state or digit was evaluated.

The authoritative report is
`/tmp/pi-m4-actual-cycle-recovery-20261127/report-v2.md`, SHA-256
`aa7a30b30dea7173930dce8b2a046d6a11a687bec19a0a40daee1096fac2510d`.
Parent unchanged-copy replay passed, with an identical exact receipt and
all eight originals preserved. This is a finite paper counterexample to a
specific proposed extension, not a new Lean theorem or M4 acceptance.

## Rational automaton telescopes lose the initialized boundary

Use the actual recurrence y_0=0,
y_(n+1)=16*y_n+A(n)-k_n with canonical k_n. For n>=1, 0<A(n)<1,
so labels 0,...,16 each have a nonempty open phase branch; the overflow
branch has width A(n)/16. An eventual hole yields omission of some ordinary
word w only through the earlier inner-cylinder argument: place a closed
cylinder strictly inside the hole and make the tail smaller than its margin.
This does not identify arbitrary canonical carries with ordinary digits.

Let the proper-prefix automaton for w have states s=0,...,ell-1, and retain
edges that do not complete w. Test rational potentials P_s in Q(n,x) and
rewards R_(s,d) in Q(n), required to satisfy

```text
P_t(n+1,16*x+A(n)-d)-P_s(n,x)=R_(s,d)(n)
```

on a nonempty open subset of each allowed edge's canonical branch, for all
sufficiently large integer n. This uniform premise is essential. It is not
an identity assumed only at the actual initialized points. Rational identity
extension in x and then n permits comparison of different branches without
requiring their original phase intervals to overlap.

State 0 has fifteen ordinary self-loops, all labels except w_0. Subtracting
two gives a nonzero translation difference of P_0 constant in x. Its finite
pole set would have to be invariant under that translation, so there are
no finite poles. Polynomial degree comparison makes P_0 affine in x. Its
slope u(n) obeys u(n)=16*u(n+1), impossible for nonzero rational u since
u(n+1)/u(n) tends to 1. Thus P_0 is phase independent. Reading each proper
prefix from state 0 reaches the corresponding state, with nonzero affine
phase slope; composing the edge identities makes every P_s phase independent.
Consequently P_s=v_s(n) and R_(s,d)=v_t(n+1)-v_s(n). A return-word sum
retains only a state/time boundary, independent of the initial entry.
The freely chosen v_s may themselves contain A; such dependence remains an
arbitrary scalar boundary, not an additional constraint forced by the recurrence.
No overflow reset edge is used or presumed to have an infinite continuation.

The precisely enlarged class
P_s=16^(-n)*Q_s(n,x)+v_s(n), Q_s in Q(n,x), v_s in Q(n), with rewards
in Q(n)+16^(-n)*Q(n), has only the additional common slope C:

```text
P_s(n,x)=C*16^(-n)*x+V_s(n),
V_s(n)=16^(-n)*b_s(n)+v_s(n),  b_s,v_s in Q(n),
R_(s,d)(n)=C*16^(-n-1)*(A(n)-d)+V_t(n+1)-V_s(n).
```

Here the same translation argument makes Q_0 affine; its rational slope
is 1-periodic, hence constant. Ordinary-prefix paths propagate that constant
to every state. For a finite allowed path within the certificate's range,

```text
sum_(n=N)^(M-1) R_(s_n,k_n)(n)
  =C*(16^(-M)*y_M-16^(-N)*y_N)+V_(s_M)(M)-V_(s_N)(N).
```

Subtracting the scalar endpoints and dividing by C is legitimate only if
C!=0; C=0 gives only those endpoints. Independently of any late certificate,
the recurrence telescopes for every 0<=N<M:

```text
sum_(n=N)^(M-1)16^(-n-1)*(A(n)-k_n)
  =16^(-M)*y_M-16^(-N)*y_N.
```

At N=0, boundedness and the actual zero entry recover only the known
sum k_n/16^n=pi, or sum k_n/16^(n+1)=pi/16. General bounded entry y_0
instead gives 16*y_0+pi and y_0+pi/16 respectively. The automaton supplies
no further restriction on the actual path's sum or boundary. Both the exact
forcing and initialization enter the last identity without proving visitation.

Suspend these uniform equality classes as a new initialized arithmetic
consumer. This does not exclude identities only at the actual points,
inequalities, nonrational potentials, or other history-dependent classes.
The authoritative report is
`/tmp/pi-m4-automaton-scalar-boundary-clarification-20261127/report-v3.md`, SHA-256
`30360e8fee4309e126cc39e336d7a55249d409c4d98fd519a36cfe1de5da7bff`.
Parent unchanged-copy replay checked 4,368 short word graphs, 8,448 prefix
edges, 65,520 ordinary self-loops, 96 translation differences, 96 free-entry
steps and twelve telescopes, with identical receipt and five originals
preserved. These are finite algebra fixtures, not an initialized orbit census
or proof of the universal classification. Separate paper review resolved the
endpoint clarification; no Lean result or progress on V is claimed.

## A zero-entry quadratic sign fails on low even carries

One inequality test preserves the actual zero boundary. Extend E_-1=pi/16
and compare with R_n=(49/15)*16^n-E_n, n>=-1. It has exact A forcing,
first raw floors 0,3, carry 3 at n=0 and carry 4 thereafter. Its phases
are r_0=(49/15-pi)/16 and r_n=4/15-E_(n-1) for n>=1. The bound
0<E_n<=E_0=pi-47/15<1/105 verifies all these canonical cells.
This comparison loses the zero fractional seed and rational raw samples.

For any exact-A canonical path set e_n=y_n-r_n, h_n=k_n-4,
a_n=16^(1-n), and Z_n=a_n*e_n, all for n>=1. Then

```text
e_(n+1)=16*e_n-h_n,  Z_(n+1)=Z_n-a_n*h_n/16,
Z_n^2-Z_(n+1)^2=a_n^2*(h_n^2+2*h_n*e_(n+1))/256.
```

Since |e_n|<1, even k_n makes the square nonincreasing: nonzero even
h_n has magnitude at least 2. But a square has no negative initial value.
The tested fixed tilt, beta=2/15 and V_n=Z_n*(Z_n+beta), does:

```text
Z_1=pi-49/15=E_0-2/15,
V_1=E_0*(E_0-2/15)<0                 (actual zero initialization),
D_n:=V_n-V_(n+1)=(a_n*h_n/16)*(beta+Z_n+Z_(n+1)).
```

For n>=2, |Z_n|+|Z_(n+1)|<17/256<beta. Thus D_n has exactly
the sign of k_n-4: low even labels 0 and 2 increase V, label 4 preserves
it, and labels 6,...,16 decrease it. Evenness does not justify nonincrease.

An exact countertrajectory uses alpha=391/120 and R_n*=alpha*16^n-E_n.
It also has first raw floors 0,3, but its carries are 3 at n=0, 4 at n=1
and 2 for every n>=2. Its phases are 31/120-E_0 at n=1 and
2/15-E_(n-1) thereafter. Relative to the reference above,

```text
e_1*=-1/120, e_n*=-2/15 (n>=2),
Z_1*=Z_2*=-1/120, V_1*=V_2*=-1/960,
V_3*=-17/245760, V_3*-V_2*=239/245760>0.
```

It has a nonzero irrational seed and irrational raw samples. The same
negative boundary sign therefore occurs in an even-tail comparison without
contradicting the actual C_odd question. The exact drift itself supplies
no rational-initialization distinction.

The late boundary is a separate obligation. For 1<=N<M,

```text
V_N-V_M=sum_(n=N)^(M-1)D_n,
V_N=V_1-sum_(n=1)^(N-1)D_n,
V_N=sum_(n>=N)D_n.
```

The last sum converges absolutely and Z_n,V_n tend to zero. An even tail
beginning at N retains the unknown finite past; V_1<0 does not imply V_N<0.
For N>=2 its sign is that of the actual comparison y_N-r_N. Proving a
negative late boundary and subsequent nonincrease would contradict the zero
limit, but neither follows here.

The same continuous boundary expression also fails a near-zero-entry test.
Without evaluating the ceiling, set
alpha_m=(ceil(16^m*pi)+2/15)/16^m for m>=1. Its exact-A trajectory starts
at delta_m=(alpha_m-pi)/16, with

```text
2/(15*16^(m+1))<delta_m<17/(15*16^(m+1)),
47/15<pi<alpha_m<22/7+17/240<49/15.
```

These irrational entries approach zero from above, retain first floors 0,3
and the strict negative V_1 sign, and have carry 2 from index m+1 onward.
They lose exact rational initialization; they do not refute a certificate
using that arithmetic property. They do reject separation by this boundary
sign when the eventual-tail threshold can grow.

Suspend this fixed tilt, not inequalities generally. A new estimate must
control the actual low-even-branch contribution and late boundary using
arithmetic absent from these comparisons; changing only the tilt repeats
the failure. C_odd and V remain open. Authoritative report
`/tmp/pi-m4-zero-entry-domain-clarification-20261127/report-v2.md`, SHA-256
`2e2ea7e0b5bb91b711776cd555610a98896f2350636f9236b04a142e35e25532`.
Parent unchanged-copy replay passed 192 synthetic even branches and 384
drift identities, 12 formal tail steps, ten comparison steps, 64 synthetic
period phases and seven boundary assertions, with identical receipt and
five originals preserved. No actual orbit or ceiling was sampled. Universal
arguments remain paper mathematics; no Lean or visitation result is claimed.

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

## Contracted inverses do not yet select the actual history

[Laurent–Nogueira, arXiv:1704.05130v3](https://arxiv.org/pdf/1704.05130v3)
(19 March 2018), Theorem 1 p.2, gives rational rotation number for the fixed
map `f(x)=fract(lambda*x+delta)` on `[0,1)` when both parameters are algebraic
and strictly between zero and one. The lift is
`F(x)=lambda*fract(x)+delta+floor(x)` (§5 p.11). The proof (§2.1 p.4) uses
Hecke–Mahler transcendence; that external input was not independently audited.
Rational rotation is not ordinary periodicity: §5.2 p.13 permits multivalues
at the discontinuity. The retained Warwick PDF is the earlier three-author
17 April 2017 draft; its stronger introductory periodicity wording is unused.

For the actual carry `c_n=floor(16*y_n+A(n))`, the raw inverse is
`y_n=(y_(n+1)+c_n-A(n))/16`. At `n>=1`, `0<A(n)<=106/819<1`, with
`c_n` in `{0,...,16}`. Writing `D(n)=(2n+1)(4n+3)(8n+1)(8n+5)`,
the numerator of `A(n)-A(n+1)` over `D(n)D(n+1)` has ascending coefficients
`[110709,620136,1330440,1360896,662016,122880]`, all positive.
Thus finitely many fixed offsets `x/16+b_i` cannot realize infinitely many
raw inverse steps: `A(n)=c_n-16b_i` would have finite image. The offsets may
even be irrational. A fixed contracted rotation cannot realize two distinct
such indices, since their nonzero coefficient difference would be an integer
of absolute value less than one. Fixed affine coordinate changes and finitely
many bounded induced-return lengths with their natural slopes have the same
obstruction; arbitrary slopes, nonlinear changes and unbounded returns are
not covered.

Exact centering uses `T_n=E_(n-1)` for `n>=1`, **`T_0=pi/16`**, and
`16T_n=A(n)+T_(n+1)`. Then `x_n=fract(y_n+T_n)` obeys
`x_(n+1)=fract(16x_n)`. The checked bridge has the same one-step index shift;
centering does not retain rational-zero initialization or select an inverse.

A useful elementary paper discriminator is stronger than the source's
rational-rotation conclusion. Suppose `G:[0,1)->[0,1)` has finitely many
rational breakpoints, equals `x/16+b_i` between them with rational `b_i`, and
takes rational values at the breakpoints. Every infinite **backward** chain
`x_n=G(x_(n+1))` is rational. Indeed, an irrational point forces the whole
chain irrational. Choose a common denominator `q` for breakpoints and offsets.
For `qx=u+v`, `u` integral and `0<v<1`, the branch depends only on `u`, and
`floor(qG(x))=floor(u/16)+q*b_i`. The cell sequence is an infinite reverse
path of a finite function, hence lies on its cycles. Its offsets are periodic,
say with period `p`; iteration gives
`x_n=16^(-kp)x_(n+kp)+B_n*sum_(j<k)16^(-jp)` with rational `B_n`.
Boundedness then forces `x_n=B_n/(1-16^(-p))`, a contradiction. The grid
argument uses the reciprocal-integer slope, not every rational contraction.

There is a genuine restricted inverse construction. For the half-open circular
arc `J={fract(c+s):0<=s<1/16}`, let `t=fract(16c)` and
`G_J(x)=fract(c+fract(x-t)/16)`. This is the unique inverse into `J`;
conjugating by `x->fract(x-t)` gives `fract(x/16+fract(-15c))`.
Actual eventual confinement to this arc supplies an actual backward chain.
Rational `c` gives the rational-selector contradiction above. Algebraic `c`
with nonzero translation meets the source contract, but needs a separate
backward-chain consequence before use. Arbitrary avoidance supplies neither
confinement to length `1/16` nor a suitable endpoint. Closed or merely limiting
arcs need separate endpoint control: `x/16+15/16` on `[0,1)` has rotation zero
but no periodic point, with iterates of zero `1-16^(-k)`.

The binary base-16 survivor set `K` has two predecessors `x/16` and `(x+1)/16`
for every `x` in `K`. A synthetic sequence containing every binary block
arbitrarily late forces any history-preserving selector to be discontinuous
at every point of `K`; it cannot be continuous outside finitely many
breakpoints. These comparisons lose the actual pi seed. A synthetic positive
rational forcing with zero seed also defeats immediate greedy reversal;
the exact-A test below is the stronger initialization discriminator.

The first missing implication is **actual avoidance -> one fixed rational
finite selector following every sufficiently late centered predecessor**.
The theorem does not construct that selector. An algebraic alternative needs
its own exact autonomous map and backward-chain consumer, with endpoints
retained. Raw finite-branch reversal and generic hole-to-selector inference
are suspended. This is reviewed paper mathematics, not a new Lean result;
V/M4 and the checked frontier are unchanged.

## Full inverse order does not isolate the zero seed

The exact-A two-step fixture strengthens the preceding synthetic greedy test:

```text
actual:          0 -> 2/15 -> 1076/4095,       carries (3,2),
greedy reversal: 1076/4095 -> 1/120 -> 7/128,  forward carries (4,0).
```

At depth m, all unrestricted roots of the actual terminal y_m are exactly
`j/16^m`, `0<=j<16^m`: the composed map is `fract(16^m*x+B_m)`.
Zero is an ambient minimum, but it is also the **unique odd-denominator
root**. The other roots therefore cannot test a proposal retaining that
arithmetic condition. At a single step with odd-denominator target z, exactly
one of the sixteen canonical branches `(z+c-A(n))/16` has odd denominator:
`c=A(n)-z mod 16`, using odd-denominator inverses in the residue ring.
This arithmetic selector is discontinuous in the real topology. Near any
interior target, large odd multiples Q of the denominator of A allow rational
targets r/Q in each required residue class, with mesh 16/Q and distinct
inverse limits. This rules out a uniform finite interval rule on its whole
rational domain, not a special rule along the actual history.

A stronger, conditional paper result retains rational nearby seeds.
**If V fails**, there are nonzero positive rational seeds approaching zero
in the real topology and every fixed Q_p whose exact-A trajectories all
miss one common smaller open interval. Every fixed actual carry prefix
eventually agrees. This does not retain the exact zero seed or necessarily
the original full forbidden cylinder.

Work on the circle R/Z; sums and differences below are modulo one.
The omega-limit set K of the actual y sequence is a proper compact invariant
set for `T(x)=16x mod 1`, since A(n)->0.
An interval expands onto the circle, so K is nowhere dense. The full orbit
closure L is K plus countably many orbit points; it is compact and, by Baire,
nowhere dense. Define

```text
F_p={16^r/(16^p-1):0<=r<p},
H=(union_(p>=1)F_p) union {0} union {16^-r:r>=1}.
```

H is compact and countable: as p grows, each point of F_p differs from
`16^(-(p-r))` by at most `1/(16*(16^p-1))`. The set L+(H-H) is compact
and a countable union of nowhere-dense translates, hence nowhere dense.
Any initially missed open interval contains a smaller open J disjoint from
it. For a seed delta, exact subtraction gives
`z_n=fract(y_n+16^n*delta)`; thus every seed with all offset phases in H-H
has its entire trajectory outside J, including the transient.

For j>=2 set N=j!, P=N^2+1 and
`delta_j=16^j*(16^N-1)/(16^P-1)`. Its offset phases belong to H-H, since
it is a difference of two members of F_P. It has odd reduced denominator,
`0<delta_j<16^(1-j)` and `v_2(delta_j)=4j`. For a fixed odd prime q and
any M>v_q(15), eventually `phi(q^M)` divides j!, giving numerator zero and
denominator 15 modulo q^M. Hence `v_q(delta_j)>=M-v_q(15)`, so delta_j
approaches zero in each fixed Q_q. This is **not adelic convergence**:
the reduced denominators introduce primes outside every fixed finite set.
If `delta<min_(1<=n<=M)(1-y_n)/16^n`, positive perturbation preserves the
first M carries and the state differences equal `16^n*delta`, even when
some y_n=0. It follows that every fixed finite collection of local congruences
on a fixed initial window also agrees eventually. Exact equality at zero
is not one of these finite-precision conditions.

The losses require care. For each **fixed** reduced seed a/d, the actual
and perturbed reduced denominators satisfy `q_n/d<=q'_n<=d*q_n`. Their
unwrapped states differ by `16^n*a/d`; normalized states differ by that
quantity minus an integer. Each denominator therefore divides d times the
other. Fractional parts preserve denominators.
Thus any established exponential denominator-growth rate transfers to each
fixed competitor. What is lost is the exact numerator/denominator history,
uniform seed height and uniform constants/thresholds across the family.
The construction supplies no uniform all-future local matching after carries
diverge, no counterexample to V, and no pole-specific visitation estimate.

Pure inverse-order selection is suspended: avoidance has not supplied a
finite actual-history rule. The exact zero and four-pole arithmetic might
still support a different estimate, but finite-precision initialization and
root minimality do not provide one here. The topology, congruences and
denominator comparison are paper arguments; finite rational fixtures do not
certify them in Lean. V/M4 and the checked frontier remain unchanged.

## Moving-target approximation retains degeneracy or insufficient precision

The 2026-11-28 source test asks whether low-height rational forcing and an
eventual even-carry alphabet contradict a moving-target Subspace Theorem.
It retains the exact recurrence and distinguishes two target families.
Neither proves actual odd-carry infinitude or V.

For g=A, let y_0=0, y_(n+1)=16y_n+g(n)-k_n and
k_n=floor(16y_n+g(n)). For n>=1, 0<A(n)<1, so the full alphabet is
C={0,...,16}; hypothetical eventual even carries use E={0,2,...,16}.
Set X_n=[1:y_n:y_(n+1)] in P^2(Q). Integer subtraction preserves the reduced
denominator, so the existing exponent6 result and
den(y_(n+1)) dividing den(y_n)*den(A(n)) give

```text
h(X_n)=6n+o(n), h([1:y_n])=6n+o(n).
```

At each fixed prime p, the lcm bound gives
`log max(1,|y_n|_p,|y_(n+1)|_p)=O_p(log(n+2))`.
For the fixed positive F the same statements have exponent8; its fixed
coefficient denominators only add bounded local factors.

The primary source is Vojta, [*Nevanlinna Theory and Diophantine Approximation*](https://library.slmath.org/books/Book37/files/vojta.pdf),
MSRI Publications37 (1999), Definition7.4 and Theorems7.6–7.7, pp.552–554,
presenting Ru–Vojta's moving-target theorem. For a fixed finite place set S,
the normalized proximity sum is bounded by `(3+epsilon)*h(X_n)+C0`, outside
finitely many indices, for every epsilon>0 and additive C0. Hypotheses include
negligible target height, general position and coordinate linear independence
over the target coefficient field on **every infinite coherent subset**.
Theorem7.7 allows a maximum over designated independent subsets, retaining
the latter independence requirement. Rational-function coefficients are
coherent on every infinite natural-index subset after deleting poles: a
polynomial in them is either identically zero or has only finitely many roots.
Only these definitions/statements and rendered pages were audited, not the
external proof chain.

First take the forcing-centered forms

```text
H_d(n)=(d-g(n))*X0-16*X1+X2, d in C,
H_d(n)(X_n)=d-k_n.
```

Their heights are O(log n), but all contain [0:1:16], so any three fail
general position. Independent pairs do not repair the other failure.
Some carry c recurs on an infinite coherent subset J, and the coefficient
field of any nonempty target family contains g(n). On J the exact relation
`(c-g(n))*1-16*y_n+y_(n+1)=0` violates coordinate independence. This remains
true if only forbidden odd labels are chosen under an eventual-even hypothesis:
the recurring c need not label a target. Counting zero evaluations as source
approximations is invalid. Recurrence of c does not mean eventual constancy.

For d!=k_n, the actual normalized local proximities are particularly simple.
At infinity the point norm is1 and target norm16. At2 both norms are1,
because A and the actual states have odd denominators. Consequently

```text
lambda_infinity + lambda_2
  =log(16/oddpart(|d-k_n|)) <=log16.
```

Here 1<=|d-k_n|<=16. Even labels do not create a growing approximation gain;
an odd target against an even carry has zero 2-adic contribution. At any
fixed finite S, all nonzero evaluations contribute only O_S(log(n+2)), using
the local-norm bounds. F has that order bound, without asserting the same
exact odd-denominator identity. A growing place set is outside the source.
Fixed block lifts also retain degeneracy: on a recurring length-L carry word,
the L equations `X_(j+2)-16X_(j+1)+(c_j-g(n+j))*X0=0` have a unit triangular
minor in their last L state columns, leaving a moving projective line.

Next remove the forcing from the target coefficients:

```text
L_d=d*X0-16*X1+X2, L_d(X_n)=d-k_n+g(n).
```

The coefficient field is now Q, the target heights are constant, and distinct
pairs are independent. The required coordinate independence holds for A/F.
A fixed rational relation alpha+beta*y_n+gamma*y_(n+1)=0 on an infinite
subset, restricted to a recurring carry c, becomes
`(beta+16gamma)*y_n+alpha-gamma*c+gamma*g(n)=0`.
If beta+16gamma!=0, y_n is a fixed rational function of n with height
O(log n), contradicting its linear logarithmic denominator height.
Otherwise nonzero gamma would make nonconstant g constant at infinitely many
integers, so all coefficients vanish. This works on every infinite subset.
Theorem7.7 therefore applies using independent subsets of at most two labels.

Its conclusion supplies no new restriction. Each evaluation is one of the
finitely many nonzero rational functions g(n)+j, -16<=j<=16, with polynomial
numerator/denominator sizes. Fixed-prime contributions are O(log n); at
infinity the small case j=0 gives 2log n+O(1), since both A and F have leading
term15/(64n^2). Nonzero j gives bounded real proximity. Thus the entire
maximum-of-pairs sum is O_S(log(n+2)), already smaller than the source's
linear-height budget. Eventual even carries do not change this comparison.
F is used only as a same-mechanism comparison, not asserted to have eventually
even carries. Its different rational period and denominator exponent remain.

A separate synthetic boundary fixture has r(n)=2/[15(n+1)^2],
g_syn(n)=16r(n)-r(n+1), and u_n=2/15-r(n). It starts at zero, lies in
[0,2/15), and satisfies `16u_n+g_syn(n)=2+u_(n+1)`, so every canonical carry
is2. It loses the actual forcing, irrational period and exponential
denominator growth; it is not a counterexample to V.

These two target families are suspended. An avoidance consequence must still
give both an admissible representation and precision exceeding its source
threshold. Other observables, nonlinear targets, growing dimension or growing
place sets require new contracts; this test rules out no such general method.
The [review record](agy-reports/m4-continuation-review.md) preserves the exact
source scope and 786 formal/synthetic checks, which certify neither the
asymptotics nor the source theorem. No actual-state census, Lean theorem,
originality determination, odd-carry conclusion or V/M4 acceptance is claimed.
