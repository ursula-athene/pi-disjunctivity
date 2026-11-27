# M4 prime-defect interpolation and its boundary constants

This paper calculation sharpens the arithmetic question left by the
[unrestricted lift](m4-prime-square-lift.md#unrestricted-differences-and-multiplicative-indices).
It constructs a canonical analytic solution, identifies its boundary constants
using Coleman integration, and proves the stronger precision laws below at
paper level. The central comparison passed a separate subagent argument review;
production integration has its own changed-file review. No Lean declaration
or real visitation estimate is supplied. The
[review record](agy-reports/m4-continuation-review.md) owns review status.

## The raw defect and its analytic forcing

Retain the actual states c=A,Ahat,D,R and their transforms T_p. Fix a prime
p>=7 and put lambda=16^p. With F_c(k)=sum_(j<k)16^(-j)c(j), define

    E_p^c(k)=p*F_c(pk)-F_(T_p c)(k),
    G(k)=16^(pk-1)*E_p^c(k), k>=1, G(0)=0.

The preceding uniform bound is v_p(E_p^c(k))>=2. The stronger conclusions are

    v_p(E_p^c(k))>=2+v_p(k), c=A,Ahat,R,
    v_p(E_p^D(k))>=3+2*v_p(k).                         (1)

These conclusions concern every positive k, including arbitrary unit cofactors.
The factor relating G and E is a p-unit, but its dependence on k matters
for interpolation. Direct recurrence algebra gives

    G(k+1)-lambda*G(k)=h(k),
    h(k)=p*sum_(j<p)16^(p-1-j)c(pk+j)
                     -16^((k+1)(p-1))*(T_p c)(k).

Use the established delta_r, b_r and w_r, and set
B=chi_2(p)*2^((p-1)/2), ell=log_p(B). Here B is in 1+p*Z_p, so this
logarithm uses its convergent power series near 1. Define

    J(x)=(exp(x*ell)-1)/x
        =sum_(m>=1)ell^m*x^(m-1)/m!, J(0)=ell.

Matching the pole terms before subtraction gives the analytic expression

    h(x)=16^(p-1)*[
      p*sum_(j<p,r:p does not divide 8j+r)
                 c_r*16^(-j)/(8p*x+8j+r)
      -sum_r w_r*B^(-delta_r)*J(8x+delta_r)].           (2)

Indeed the matched pole is
16^(p-1)*w_r*(B^(-delta_r)-B^(8x))/(8x+delta_r).
Formula (2) supplies its removable value, rather than inverting a possible
zero. Regular denominators are units for all x in Z_p. At natural x this
expression is exactly the rational recurrence forcing above.

## Convergent inverse with explicit coefficient costs

Write h(x)=sum_d a_d*x^d, beta=(p-2)/(p-1), and

    b_d=max(2, ceiling(beta*(d+1))).

Then v_p(a_d)>=b_d. A regular term in (2) has degree-d valuation at least
d+1. For J, v_p(ell^m/m!)>=beta*m; translation by delta_r and scaling by
8 preserve the resulting coefficient bound. At degree zero the established
identity h(0)=G(1) supplies valuation at least 2. Thus all coefficients
lie in p^2*Z_p, and degrees at least two lie in p^3*Z_p. The series
converges on every disk of radius strictly smaller than p^beta.

Let Delta f(x)=f(x+1)-f(x). Since lambda-1 is a p-unit, put

    Phi(x)=-sum_(m>=0) Delta^m h(x)/(lambda-1)^(m+1).   (3)

For each degree d, the coefficient in Delta^m h has valuation at least
b_max(m,d): finite differences have integral coefficients and kill monomials
of degree less than m. This bound proves convergence of (3), retains b_d
for every coefficient of Phi, and permits termwise cancellation. Hence

    Phi(x+1)-lambda*Phi(x)=h(x).

Modulo p^s, one may discard Taylor degrees with b_d>=s and difference
orders with b_m>=s, uniformly on Z_p. The cutoff is O(s/beta), independent
of the natural argument k. These are p-adic precision bounds, not real
height bounds for the rational approximants.

The analytic solution is unique even among continuous solutions on Z_p.
A continuous homogeneous solution q has q(n)=lambda^n*q(0). As p^j tends
to zero, lambda^(p^j)-1 remains 15 modulo p, a unit. Continuity forces
q(0)=0, then density of the naturals forces q=0. Nevertheless the actual
zero-initialized integer sequence satisfies

    G(k)=Phi(k)-lambda^k*Phi(0), every natural k.        (4)

The homogeneous term in (4) is essential. Analytic forcing alone does not
make the initialized sequence analytic.

## Precision is equivalent to exact boundary zeros

For each of A,Ahat,R, the first assertion (1), for every k>=1, is equivalent to

    Phi(0)=0 in Q_p.                                  (5)

If (5) holds, the coefficient bounds give Phi(x) in p^2*x*Z_p[[x]], proving
the estimate. Conversely, if Phi(0) has finite valuation t, then for k=p^j
the difference Phi(k)-Phi(0) has valuation at least j+2, while
(1-lambda^k)*Phi(0) has valuation exactly t. For large j, (4) contradicts
the proposed lower bound j+2.

For D, the second assertion (1) is equivalent to

    Phi_D(0)=Phi_D'(0)=0 in Q_p.                        (6)

The same argument forces the constant term to vanish. Write
Phi_D(x)=u*x+x^2*v(x), with v in p^3*Z_p[[x]]. If u is nonzero, evaluation
at p^j eventually has valuation j+v_p(u), contradicting 3+2j. Conversely
both zeros put Phi_D in p^3*x^2*Z_p[[x]], proving the bound for all k.
The equivalences include p=7; they do not change the separate nonintegrality
of the unscaled Ahat prefix tower at that prime.

Two exact models isolate invalid shortcuts. For h=p^2, the same coefficient
bounds hold, but Phi=-p^2/(lambda-1) and
G(k)=p^2*(lambda^k-1)/(lambda-1) has valuation exactly 2 at k=p^j.
For Phi=p^3*x and h=p^3*(1+(1-lambda)*x), the constant boundary is zero,
but G(p^j) has valuation 3+j. The derivative condition in (6) is independent
of merely imposing the constant zero. These models test generic reasoning;
they do not replace the actual BBP forcing.

## The logarithmic and dilogarithmic periods

For the established null-kernel function
f(t)=log[(2-t^2)/(t^2-2t+2)], let z+=(1+i)/2 and z-=(1-i)/2. Then

    integral_0^1 f(t)/t dt
      =-(1/2)*Li_2(1/2)+Li_2(z+)+Li_2(z-)=pi^2/16.     (7)

The factorization uses principal logarithms with positive real parts along
the segment. Absolute convergence at |z+|=|z-|=1/sqrt(2) permits integration.
[DLMF 25.12.E2 and E6](https://dlmf.nist.gov/25.12) supply the integral and
real reflection formula. To reach z+, differentiate the reflection expression
along 1/2+i*s, 0<=s<=1/2; it is constant and encounters no cut. Thus
Log(z+)*Log(z-)=(log2)^2/4+pi^2/16, while
Li_2(1/2)=pi^2/12-(log2)^2/2, proving (7). E6 is not quoted outside its
stated real domain. Integration by parts also gives
integral_0^1 4*log(t)*f'(t) dt=-pi^2/4, with both boundary terms zero.

For the p-adic counterpart, fix a homomorphic branch of log_p on C_p^*.
De Jeu's [research paper](https://arxiv.org/pdf/2007.11014), v1, printed
pages 6 and 14, defines the modified Coleman dilogarithm
D_p(z)=Li_(p,2)(z)+(1/2)log_p(z)log_p(1-z) and explicitly states
D_p(z)+D_p(1-z)=0 for z outside {0,1}. The defining series is used only
inside |z|_p<1; elsewhere this is the specified Frobenius continuation.

For either square root i of -1 in C_p, z+^2=i/2 and z-^2=-i/2. Since
the logarithm kills roots of unity, both log_p(z+) and log_p(z-) equal
-(1/2)log_p2. All arguments and complements are units and avoid 0,1.
Applying the source identity at z+ and at 1/2 gives exactly

    -(1/2)*Li_(p,2)(1/2)+Li_(p,2)(z+)+Li_(p,2)(z-)=0.  (8)

No value at the branchpoint 1 is needed, and (8) holds for each chosen
logarithm branch. The parent read the primary PDF and visually inspected
both pages. A direct archival link to Coleman's earlier paper returned 404;
that original article was not inspected. The stated de Jeu convention is
the source used here.

The identities alone do not identify the finite-difference boundary. The
following comparison fixes that issue, including continuation and constants.

## Exact comparison with the canonical solution

Use Besser's [Coleman integration using the Tannakian formalism](https://arxiv.org/pdf/math/0011269),
arXiv:math/0011269v1, over the completion of the maximal unramified extension
of Q_p. This is a complete discretely valued field with algebraically closed
residue field. Fix a logarithm branch. The source constructs primitives and
pullbacks on smooth affine curves, includes overconvergent rigid functions,
and proves an identity principle on an ordinary residue disc (Proposition
4.12 and Corollary 4.13). Its Theorem 5.7 constructs the natural logarithmic
fiber functor on each boundary annulus. We need the following consequence,
not merely injectivity into the product of all local components.

For a boundary annulus V, write R=A(V)[L], dL=dt/t. If the complete annular
expression s(y_V) of a Coleman representative [M,s,y] vanishes, construct
the largest horizontal subobject N of ker(s) as in Lemmas 2.1–2.3. On closed
subannuli the successive kernels stabilize: their quotients are torsion free
and a strict decrease drops rank. Restriction and polynomial extension are
flat. The successive kernel maps remain linear after base change because
the extra Leibniz term lies in the preceding kernel and vanishes in the
quotient. Thus the finite construction commutes with this extension;
this is not a claim about arbitrary horizontal invariants commuting with
base change. Repeated differentiation places y_V in the fiber of N.
Natural fiber-functor transport then puts every ordinary-disc vector in N,
and the representative factors through [N,0,y]=0, as in Proposition 4.12.
Passing between closed subannuli proves uniqueness from one complete
annular expression. A value at one point would not suffice.

For g=h or h', define the Newton generating function

    H_g(z)=(1-z)^(-1)*sum_(m>=0) Delta^m g(0)
                                       *(z/(1-z))^m.

The coefficient bounds give convergence for |z/(1-z)|_p<p^beta. On
|z|_p<1 it agrees with sum_(k>=0)g(k)z^k by the binomial identity.
At z*=lambda^(-1), its continued expression gives exactly

    H_h(z*)/lambda=-Phi_c(0),
    H_(h')(z*)/lambda=-Phi_c'(0).                      (9)

Put P_c(t)=sum_r c_r*t^(r-1), K_c=P_c/(1-t^8/16), and let Q_c be its
Coleman primitive with zero Taylor constant at zero. Set Pi_c=Q_c(1)
and L_c=integral_0^1 Q_c(t)dt/t with the same zero normalization.
These are p-adic periods, distinct from the real integral (7).
For a=8j+r, use the zero-normalized primitives

    I_a(t)=integral_0^t v^(a-1)/(1-v^(8p)/lambda) dv,
    J_r(t)=integral_0^t v^(r-1)/(1-v^8/16) dv.

On the zero disc, pulling back by z=t^(8p)/lambda gives

    H_h(z(t))=
      p*sum_(j<p,r)16^(p-1-j)c_r*t^(-8j-r)*I_(8j+r)(t)
      -16^(p-1)*sum_r(T_p c)_r*t^(-pr)*J_r(t^p).

Take X to be the affine line over the residue field with the roots of
t^8=16 removed. All poles of the rational forms above and their pullbacks
reduce into those deleted discs; those roots are simple for p>=7. Both
0 and 1 lie in X, since 16 is not 1 modulo such a p. On its tube the
Newton ratio has norm at most one. The convergence margin supplies a
strict neighborhood, so the Newton side is overconvergent. Multiply the
displayed identity by t^(8p) to remove negative exponents. Both sides
are then Coleman functions on X agreeing on the zero disc. The ordinary
identity principle extends equality to 1. Finite geometric summation gives

    Phi_c(0)=-(p*Pi_c-Pi_(T_p c))/16.                  (10)

For the derivative, differentiate (2), interpreting B^(8x) analytically
but never assuming an analytic extension of lambda^x. At natural k,

    h'(k)=-8p^2*sum_(j<p,r)16^(p-1-j)c_r/(8pk+8j+r)^2
          +8*16^((k+1)(p-1))*sum_r(T_p c)_r/(8k+r)^2
          -8ell*16^((k+1)(p-1))*(T_p c)(k).

Replace I_a and J_r by their second primitives, integrating once more
against dt/t. Work on X with zero additionally removed: analytic
removability of a scalar function does not extend a singular connection.
On the zero boundary annulus choose the primitives' constants so their
complete expressions are the Taylor series with squared denominators
and zero constant. The kernel of derivation on A(V)[L] is the constant
field. The single-annulus principle just proved extends the resulting
generating-function identity to 1. Finite summation and pullback yield

    Phi_c'(0)=(p^2*L_c-L_(T_p c)+ell*Pi_(T_p c))/2.    (11)

Exact rational algebra gives K_R=8/((t-1)^2+1) and
K_D=4*d/dt log((2-t^2)/(t^2-2t+2)). Thus Pi_D=0 from its equal endpoint
ratios, while Pi_R=-4i*log_p(z+)+4i*log_p(z-)=0 by the root-of-unity
calculation above. All four Pi_c vanish, so (10) proves (5).
The normalized primitive Q_D=4f. Coleman pullback and annular uniqueness
identify its second primitive with the same normalized dilogarithm as
in (8), giving L_D=4J_p=0. Hence

    Phi_D'(0)=2*(p^2-1)*J_p=0.                        (12)

Equations (10) and (12), together with the coefficient bounds and retained
initialization (4), prove (1) for every p>=7 and positive k. Neither finite
precision tests nor a shared differential equation replaces this comparison.

## Evidence and downstream limit

Frozen analytic report: `/tmp/pi-m4-kprecision-20261127/report-v1.md`, SHA-256
`3c670fb5e099ac718ecaa5d0cc90e56e49918971017b76abb2c3261afb0cde53`.
The parent reconstructed the forcing, coefficient bounds, inverse,
initialization and equivalences, then replayed an unchanged checker copy.
It exited 0 with an identical receipt: 116 Taylor bounds, 448 forcing
comparisons, 116 inverse coefficient bounds, 448 recurrence comparisons,
128 initialized comparisons, 20 boundary residues and 28 countermodel cases.
The boundaries vanish modulo p^8 in the tested primes 7,11,13,17. Those
finite residues do not prove exact zero. Truncation uses the proved bounds.

The separate source/moment packet is
`/tmp/pi-m4-dilog-boundary-20261127/`, report SHA-256
`7553fd0a6eb2a6b8624c87ac409e013d5827c632248cd9ce11dab90c490ac19c`.
It retains the PDF, inspected page images, DLMF formulas and exact domains;
that predecessor left the comparison open. The subsequent comparison packet
is `/tmp/pi-m4-boundary-comparison-20261127/`, report SHA-256
`eff6c0d8d1e09a86a19524df3ac98d4773f46f2e2ea4bc5cd0da0943c64a2c13`.
The parent read the report, checker and relevant Besser text/page images,
reconstructed the algebra and replayed the checker: 96 derivative identities,
96 Newton/Euler identities, two kernel identities and four scalar checks,
exit 0; the receipt differs only in timestamp. These finite checks do not
certify Coleman continuation. The separate subagent argument review found
no D/I/Q items; its full response and limitations are retained in
`/tmp/pi-m4-boundary-argument-review-20261127/review.md`. These results are
paper mathematics only, with no new library dependencies or Lean exports.

For the twisted normalized tower W_r=p^r*F_(T_p^r c)(p^r), increments now
have valuation at least 2r for A/Ahat/R and 3r for D. Integrality remains
restricted to p>=11; at p=7 this is a Q_7-valued Cauchy tower and the Ahat
initial term can have valuation -1. The mixed four-corner defect gains
v_p>=2+v_p(k) and v_q>=2+v_q(k), or 3+2v_p(k), 3+2v_q(k) for D, with both
middle corners retained. None of this controls the actual real phase:
D receives the strongest precision while its real prefixes tend to zero.
The separate signed visitation or word-separation estimate remains missing.
B4 still needs arbitrarily late visits, P3 still needs interval visits, and
V/Hpi/T/M4 remain open. The following consumer tests retain the actual
canonical floors; direct avoidance work continues separately.

## Precision consumers retain the canonical carry

Write G(k)=Phi(k) and Phi(k)=sum_d gamma_d*k^d after the proved boundary
zeros. The coefficient bounds give, for distinct positive k,l,

    (G(k)/k-G(l)/l)/(k-l) in p^3 Z_p,
    (G_D(k)/k^2-G_D(l)/l^2)/(k-l) in p^4 Z_p.

This is genuine extra precision, but an index-difference gain has cost:
the prime-log mass of factors in a fixed m-index product is at most
sum_(i<j) log|k_j-k_i|. Different primes' expressions cannot be combined
as if they were the same auxiliary.

For p=13 put M=16^(12k), so G(jk)=13*S_(13jk-1)-M^j*S_(jk-1).
For an integer stencil Q(z)=sum_(j=1)^d a_j*z^j, cancellation of a common
real translation is exactly Q(M)=13*Q(1). Every nonzero such stencil has
max|a_j|>=M/d: M divides Q(1), or, if Q(1)=0, the lowest nonzero
coefficient of Q(M)=0 is divisible by M. Primitive normalization cannot
remove this cost. The explicit polynomial Q=z*(z-1)^2*(z-M) also cancels
the first Taylor term and gives v_13(sum a_j*G(jk))>=4+3*v_13(k).
But its full state-coefficient norm is

    B=2*M^2*(M+1)^2+52*(M+1)>=2*M^4.

Writing every S as its integer floor plus its fractional part gives
Z=C+T with C an explicit integer stencil of those floors. The high
valuation transfers to T only when C is divisible by the same prime
power. Even if that additional condition held and clustered states gave
|T|<=epsilon*B, the nonzero-rational/divisibility certificate would need
epsilon<p^(4+3*v_p(k))/(den(T)*B). Interval avoidance does not imply
that clustering or the required floor congruence.

At actual indices n_r=13^r-1, the normalized tower has unit anchor
W_r=13^r*F_A(13^r)=47/15 mod13^2. Thus v_13(S_(n_r))=-r.
For r<s both a canonical gap and its complementary circle gap have
valuation -s, independently of the integer floors or common rotation.
For the circle product in the [positive-certificate note](m4-positive-certificates.md),
v_13(R)=-4*sum_(r<s)s: its reduced numerator is a 13-adic unit.
The null state has the same valuation pattern with anchor 4/105, while
its real product tends rapidly to zero. This tested use of the precision
therefore supplies denominator information, not a numerator lower bound.

## Shared multipliers escape one cost and fail another

For primes 13,17,37 choose respective lower indices 12k,9k,4k. All three
defects have multiplier M=16^(144k). The constant primitive vector
(-5,6,-1) balances both sums sum a_p and sum p*a_p. It escapes the
single-prime coefficient bound above, producing the actual expression

    B_A=-65*S_(156k-1)+102*S_(153k-1)-37*S_(148k-1)
                         +M*(5*S_(12k-1)-6*S_(9k-1)+S_(4k-1)).

The own-prime precision cannot be assigned to the other two defects,
which can have poles there. More strongly, for every k=13^r, r>=0,

    v_13(B_A)=v_13(B_D)=-r-2.                         (8)

Here the tower comparison reduces 13^(r+2)*S_(m*13^r-1) mod13 to
13^2*S_(m-1), for m=4,9,12,148,153,156. Their residues for both A and D
are 0,0,0,4,10,10. Consequently the scaled B residue is
102*10-37*4=1 mod13. This proves an infinite initialized subsequence;
it is not extrapolation from finite tests. Scalar multiplication can
clear the other primes' poles, but its resulting gain is common content
and disappears from the primitive coefficient vector.

If B=C+T separates the six actual floors, (8) also holds for T and T/M.
The normalized coefficients have norm 12+204/M, but C/M is not an
integer and cannot be deleted modulo one. Extra odd linear congruences
alone cannot repair that dyadic carry: if an integer lattice Lambda is
restricted to Lambda' with Q*Lambda subset Lambda' subset Lambda for
odd Q, then C(Lambda') mod M=C(Lambda) mod M. Multiplication by Q is
an automorphism on every subgroup of Z/MZ. This does not equate images
of bounded-height or primitive vectors; those restrictions require their
own estimates. A further four-prime stencil was suspended at this point.

The distinction between A and D remains explicit. The latter obeys
B_D/M=-25/(27648*k^2)+O(k^-3), while B_A/M has a nonzero exponentially
growing pi term. Both still have the pole in (8). Neither the growth
difference nor negative valuations bound the actual canonical numerator.

Frozen reports `/tmp/pi-m4-precision-consumer-20261127/report-v1.md`
(SHA-256 `214ff17cda22365fc99e2ecdd4e0345e1eb4fed36b48e6911af6c59fe4a39cf5`)
and `/tmp/pi-m4-balanced-multiprime-20261127/report-v1.md`
(`831019b307dae734f1c61b0e8a670de11e6e0728538a5dcf45170c0783ff459b`)
retain the proofs, denominators, carry examples and modular checkers.
The latter's append-only `reassessment-v1.md` gives the lattice argument;
`manifest-v2.json` is authoritative. Parent full reconstruction and
unchanged-copy replays exited 0, matching receipts apart from UTC timestamps
and preserving originals. The checks use modular A data, not an actual
fractional-state search. Integration review is recorded separately.

## Rational entries change raw precision but may preserve every orbit value

The [rational-entry bridge](m4-generating-functions.md#rational-entries-preserve-universal-late-visitation)
permits a fixed rational entry under the exact future forcing. At entry time
N_c write r_c=16^(-N_c)*(e_c-S_(N_c)^c), so the future raw prefix is
S_n^(c,r)=S_n^c+16^n*r_c. For A,H assign one fixed shift r,s respectively;
D/R inherit r+s,r-s. Substitution into the initialized defect gives

    G_p^(c,r)(k)-G_p^c(k)=16^(pk-1)*delta_p^c,
    delta_p^c=p*r_c-r_(T_p c),
    (delta_A,delta_H)=((p-1)r,(p-1)s), p=1 mod4,
    (delta_A,delta_H)=(pr-s,ps-r),     p=3 mod4.

Both sampled indices must lie after the corresponding entry times. At any
precision level b supplied by the existing theorem, the shifted defect lies
in p^b Z_p exactly when delta does. The matrix pI-T_p is invertible over Z_p,
so simultaneous A/H precision b is equivalent to r,s in p^b Z_p. This
criterion retains primes dividing shift denominators and does not separately
reduce nonintegral raw summands.

For r=a/d nonzero and s=b/d with fixed positive common denominator d, A's
level-2 criteria are v_p(a)>=2+v_p(d) in the fixed class, and
v_p(pa-b)>=2+v_p(d) in the swapping class. Away from the finitely many
denominator primes, these can hold at only finitely many primes: the fixed
class requires p|a; the swapping class requires p|b when b!=0 and p|a when
b=0. A fixed finite family with nonzero A shifts has the same limitation,
regardless of the chosen k. At a single swapping prime, s=pr preserves A
alone, so simultaneous A/H hypotheses cannot be omitted. Full simultaneous
precision 2+v_p(k) for all sufficiently large admissible k forces both shifts
to zero: v_p(k) is then unbounded. Antisymmetric
shifts still preserve D; common shifts preserve R.

This is a result about raw representatives, not a density obstruction. The
common shift r=s=1 leaves every canonical A/H state identical but changes
each raw defect by a p-unit. More generally, replacing r by r-b/16^h preserves
every canonical value after index h. For a finite set of odd primes not
dividing the reduced denominator q of r=a/q, let M be their prescribed
precision modulus. CRT chooses b with a*16^h-b*q divisible by M. A centered
choice has

    |r-b/16^h| <= M/(2*16^h),
    r-b/16^h != 0 implies |r-b/16^h| >= M/(q*16^h).

Finite compatible precision can thus coexist with arbitrarily small real
representatives if the matching threshold h is allowed to grow. Keeping
h<=N and a fixed normalized-height budget |r-b/16^h|<=B instead forces
M<=B*q*16^N for every nonzero representative. For example, level 2 at all
7<=p<=2N outside q gives log M=4N+o(N) by ordinary PNT. With a common A/H
shift, or simultaneous A/H precision, this eventually excludes every such
repair of a fixed non-dyadic r. A dyadic r can be repaired to zero, recovering
the original late orbit. This modulus is not silently identified with the
different selected CRT modulus in the phase note. The height/threshold
conditions are essential; no general obstruction to rational-entry methods
is claimed.

For the actual canonical phase theta_n=fract(S_n), the remaining carry is
explicit but uncontrolled. Put b_n=floor(16^n*r), rho_n=fract(16^n*r), and
epsilon_n=floor(theta_n+rho_n) in {0,1}. Then

    floor(S_n+16^n*r)-floor(S_n)=b_n+epsilon_n,
    fract(S_n+16^n*r)=theta_n+rho_n-epsilon_n.

The rational offset orbit rho_n is known; epsilon_n asks whether the actual
phase crosses its threshold. The shifted leading residue does not estimate
that crossing. This canonical discussion uses A/H; signed raw identities are
linear, but floors and fractional parts require their own decomposition.

Frozen evidence is `/tmp/pi-m4-entry-precision-20261127/`, report SHA-256
`d4eee68ad8b558a7f5bdbf9c96cb4f8a52981c61aafc7a97d3c79f8d09340fe3`.
The append-only `correction-v2.md` clarifies signed floors and normalized
entry bounds; `budget-supplement-v3.md` proves the height/threshold corollary.
Authoritative manifest v3 SHA-256 is
`2ede3fcc8df0d22121db0752f250e2f6469a21be04ee2ffa9d562b926102895e`.
Parent reconstruction and an unchanged-copy replay passed: 1,507 exact checks,
exit 0, identical receipt, originals preserved. Universal claims remain paper
proofs; no canonical numerator estimate, new Lean theorem or V is supplied.

## Moment models can retain the pointwise prime-defect laws

The [direct moment intervals](m4-rational-forcing.md#exact-natural-denominators-still-allow-a-nondense-period)
also admit a more constrained arithmetic selection. Change A by delta and H
by -delta, leaving D fixed, and let V_n=sum_(j<=n)16^(n-j)*delta(j), V_-1=0.
The exact additional target is only

    v_p[p*V_(pk-1)-chi_4(p)*16^(k*(p-1))*V_(k-1)]
       >=2+v_p(k), p>=7 prime, k>=1.

This retains the displayed pointwise laws for A/H/R and the unchanged D law.
It does not assert the normalized divided-difference, Taylor/Newton or original
incomplete-block compression families. The fix/swap action on the modified
pair is specified by p modulo 4, not derived from a new finite-pole formula.

Besides L_A,n, define L_H,n=lcm{2j+1,4j+1,8j+3,8j+7:0<=j<=n}.
The exact common envelope is

    L_n=gcd(L_A,n,L_H,n)=lcm{odd m<=4n+3}.

Both contain those odd integers. A prime power beyond 4n+3 cannot divide
both: its opposite residue class would require an odd cofactor at least 3,
beyond the larger factor cutoff. The envelopes clear the actual coefficients;
H's reduced product term -3(j+1)/[(2j+1)(8j+7)] has gcd at most 3, canceled
by its numerator. Their logarithms have rates 6, 6 and 4 respectively.

Choose perturbation moments delta(n)=z_n/L_n, so V_n=a_n/L_n with integral
a_n=16*L_n*V_(n-1)+z_n. At n=pk-1, d=v_p L_(k-1), the exact endpoint
identity v_p L_n=d+1 makes the required condition equivalent to

    a_n = chi_4(p)*16^(k*(p-1))*[L_n/(p*L_(k-1))]*a_(k-1)
          modulo p^(d+2+v_p(k)).

Only p>=7 dividing n+1 impose new conditions, all on earlier known indices.
Their coprime product M_n has log M_n=O(log^2(n+2)). There is no cyclic
compatibility requirement: later appearances of n constrain future values.

At each nonactive odd envelope prime with matching exponent, retain full
denominator powers for both companions by excluding at most two residues of
a_n. On the CRT progression, the exclusions remain at most two per prime.
For s such primes, inclusion-exclusion on T consecutive progression parameters
gives at least T*3^(-s)-3^s acceptable values. Consequently every open interval
of length greater than M_n*(9^s+2) contains an admissible integer. This costs
exp(o(n)), uniformly in its center and the entire earlier history.

Use the analytic interval estimate with the perturbation-only moment offset
and denominator L_n. Its rate 4+log(15/128)>0 beats that cost, so one fixed
starting index K permits all choices and the same residual induction.
The two reports together therefore yield a positive analytic rational-moment
model with any prescribed finite actual prefix, the leading constants,
zero initialization, an irrational nondense period, and these pointwise laws.
This assembly uses the universal-history interval contract; isolated large
intervals would not suffice.

Both modified prefix denominator rates are exactly 6. Shared primes between
sqrt(8n+7) and 4n+3, excluding active primes dividing n+1, contribute 4n+o(n)
to both by the two-residue sieve. Untouched outer primes contribute 2n+o(n):
class 1 modulo 4 for A through 8n+5, and class 3 for H through 8n+7. Each
has one original basic denominator equal to p with nonzero coefficient, while
the perturbation is p-integral there. Natural envelopes supply the upper bounds.
No original H denominator-survival theorem is needed. Exact actual reduced
denominators and rational-function forcing are not retained.

Frozen arithmetic packet `/tmp/pi-m4-congruence-moment-model-20261127/` has
report SHA-256 `f807f1ce49a216f7dee2051d2897449980c1d973a89ebedb8a2f8a7494c59230`
and manifest SHA-256
`5d4bf14fe0faff5cde642c32a3e92144ea4fbf4e513434f1e028cfa4601e4e3f`.
The parent reconstructed its combination with the exact-envelope analytic
packet and replayed 10,757 checks: exit 0, UTC-only receipt difference,
originals preserved. Synthetic perturbations do not instantiate the infinite
model. The unchanged actual forcing and its full analytic family remain
distinctions; this is not a counterexample to actual V or a Lean theorem.

## Full analytic constraints exceed the uniform moment-grid budget

Pointwise valuation laws must be distinguished from the common analytic
interpolants proved above. For fixed p>=7, write G_p=Phi_p with coefficients
gamma_d satisfying v_p(gamma_d)>=b_p(d), gamma_0=0. Since
Delta^k x^d at zero is k! times the integer Stirling number S(d,k),

    v_p(Delta^k G_p(0)) >= B_p(k),
    B_p(k)=b_p(k)+v_p(k!), k>=1.

The power series converges on Z_p, and b_p(d) is nondecreasing, so this
finite difference may be taken termwise. Legendre's factorial identity gives
B_p(k)=k+ceil((p-2-s_p(k))/(p-1)), where s_p(k) is the base-p digit sum.
Consequently k-floor(log_p k)<=B_p(k)<=k+1. These are necessary Newton
congruences; no sufficiency for the original Taylor bounds is claimed.
The function G(1)=p^2, G(k)=0 at other nonnegative integers satisfies every
pointwise 2+v_p(k) bound but fails the second Newton bound. It is a separating
function, not a comparison model of the recurrence.

For opposite A/H perturbations let delta S_n=a_n/L_n with
L_n=lcm{odd m<=4n+3}. At n=pk-1, put e=v_p L_(k-1). The exact identity
v_p L_n=e+1 and the integer p-unit L_n/(p L_(k-1)) show that the new Newton
condition, with earlier values fixed, is precisely

    a_n = chi_4(p)*16^(k*(p-1))*a_(k-1)*L_n/(p*L_(k-1))
          -(L_n/p)*sum_(j<k)(-1)^(k-j)*binom(k,j)*delta G_p(j)
          modulo p^(B_p(k)+e).

Every displayed cleared earlier term is integral. Different primes dividing
n+1 constrain the same integer a_n, so the combined modulus is

    M_n^an=product_(p>=7,p|n+1) p^(B_p((n+1)/p)+v_p L_((n+1)/p-1)).

Take m_Y=product_(7<=p<=Y)p and n_Y=m_Y-1. The bounds on B_p and the
envelope exponents give

    log(M_(n_Y)^an)/n_Y
      =(m_Y/n_Y)*sum_(7<=p<=Y)log(p)/p
          +O(pi(Y)*log(4m_Y)/n_Y)
      =(1+o(1))*log Y -> infinity.

Here the same prime number theorem used for the clearing envelopes supplies
log m_Y~Y and the elementary partial-summation estimate. This is an explicit
subsequence statement, not an all-n lower bound.

The [direct moment construction](m4-rational-forcing.md#exact-natural-denominators-still-allow-a-nondense-period)
uses |c_n|<=B*2^n/(n+1)^6 and h_n<=C*16^(-n). Its entire allowed integer
interval has length at most 2BC*L_n*8^(-n)/(n+1)^6, of exponential rate
4-log8 for the common envelope, or 6-log8 for the larger A envelope.
Eventually that length is less than one analytic CRT residue spacing along
the displayed subsequence. The uniform guarantee for every interval center
and earlier history therefore does not extend by the same counting argument.

This is a limitation of that construction, not nonexistence of models retaining
the full family. A shorter interval can contain its prescribed residue, and
earlier choices might be correlated. The Newton subset is not a full
analyticity characterization. Nor does the large modulus itself force a visit:
its residue depends on earlier raw prefixes, and the canonical floors remain
uncontrolled. An actual consumer or a new rigidity theorem is still required.

Frozen parent packet `/tmp/pi-m4-analytic-congruence-cost-20261127/` has report
SHA-256 `75b096f0aedfc0785692c50657589f886417b36f7817aa119480fa727363578f`
and manifest SHA-256
`c92266dbdb6dcbb6460d806e2718a0c49423a6f459c77bfae8833998f76ffa80`.
Two unchanged checker runs passed 24,118 checks with identical receipts and
exit 0. They test finite algebra and exact rational logarithm enclosures,
not BBP prefixes, pi values or orbit states. Analytic necessity and asymptotic
cost remain paper arguments; separate self-criticism is not independent review.

## Fixed-prime analytic classes still admit nondense moment models

The preceding method obstruction concerns an unbounded set of primes. For a
fixed finite set P of primes at least 7, the analytic moment construction can
retain the actual Taylor valuation classes whenever

    rho_P=sum_(p in P) log(p)/(p-1) < eta=4+log(15/128).

In particular P={17} and P={13,17} qualify. The model retains all the earlier
pointwise laws, unchanged D, both denominator exponents 6, any prescribed
finite actual prefix, small positive analytic relative perturbation and the
leading coefficient/tail constants, but has an irrational nondense period.
It retains valuation classes, not exact Taylor coefficients or finite-pole
forcing. The one-prime finite-pole classification does not cover these
infinite moment perturbations.

For the perturbation defect G_p and alpha_(p,k)=Delta^k G_p(0), impose the
stronger sufficient conditions

    alpha_(p,0)=0, v_p(alpha_(p,k))>=k+2+v_p(k!), k>=1.

Then alpha_(p,k)/k! has valuation at least k+2. The integer coefficients of
the falling factorial (x)_k give a uniformly convergent Newton series on
every closed disk of radius less than p. Its Taylor coefficients eta_(p,d)
have constant zero and v_p(eta_(p,d))>=d+2. Finite binomial inversion gives
the exact natural values G_p(k); in particular v_p G_p(k)>=3+v_p(k).
Adding the actual interpolant retains its Taylor class on the common disk
|x|_p<p^((p-2)/(p-1)). Only the perturbation is guaranteed the larger disk p.

At n=pk-1, put e=v_p L_(k-1). The same integer clearing above, now with
modulus p^(k+2+v_p(k!)+e), gives one affine residue for a_n. Earlier cleared
terms are integral by nesting of the envelopes, without assuming that their
raw defects are integral. Selected-prime Newton conditions replace that
prime's pointwise condition; the latter follows from the resulting series.
Other active primes retain their pointwise moduli. Legendre's bound yields

    log M_n <= rho_P*n+O_P(log^2(n+2)).

The uniform analytic moment interval has logarithmic rate eta, and the
two-residue denominator sieve costs exp(o(n)). The strict gap therefore
permits every successive choice after a fixed starting index, uniformly in
all allowed histories and residual centers. Orthogonality fixes all earlier
moments, each of which is a finite rational sum. The existing period-residual
induction realizes one chosen irrational nondense period; it does not merely
produce unrelated finite models. Enlarging powers of active primes leaves
the denominator-survival argument and both rates 6 unchanged.

For each selected prime, replacing 2 by any fixed q_p>=2 gives
v_p(eta_(p,d))>=d+q_p at the same leading cost. The starting index and
realizable period interval may depend on that precision. Neither exact
coefficient equality nor a limit over all primes/precisions follows.

Frozen packet `/tmp/pi-m4-fixed-prime-analytic-model-20261127/` has report
SHA-256 `452d9e75af35dac63d83e357161262e4ca6b897d8b409c6ed16f03deb5098798`
and manifest SHA-256
`63255bc1d62408d0c74f15eb2ea1247a177ec2623a9fefa2c44812e0b85db080`.
Parent reconstruction and unchanged-copy replay passed, including 1,202
synthetic CRT stages, 116 Newton clearings and 16 nonintegral raw-side cases;
exit 0, UTC-only receipt difference, originals preserved. These finite tests
do not instantiate the infinite model. The result remains paper mathematics
using the explicit earlier analytic/arithmetic contracts, not a Lean theorem
or a counterexample to the actual A recurrence.

## The global analytic lattice has volume but no proved period covering

Impose the stronger sufficient Newton conditions of the preceding section at
every p>=7 through pk<=N, with coordinates a_0,...,a_(N-1). Each cleared row
has newest coefficient 1 and exponent

    E_p(k)=k+2+v_p(k!)+floor(log_p(4k-1)).

CRT and the triangular integer parametrization give the exact lattice index
I_N=product_(n<N) product_(p>=7,p|n+1) p^E_p((n+1)/p). Reindexing by p,k
and using Legendre's identity with uniform errors yields

    log I_N=(C/2)*N^2+O(N log^2 N),
    C=sum_(p>=7 prime) log(p)/[p(p-1)] < 7/(3sqrt6) < 1.

The last bound follows from log x<=sqrt x and a decreasing-series integral.
This averaged cost is compatible with the earlier excessive cost at rare
individual stages; the two statements concern different quantities.

In the actual orthogonal coordinates c_n, moment formation has diagonal h_n,
prefix formation is unipotent, and envelope scaling has diagonal L_n.
Consequently the coordinate determinant is exactly product_(n<N)L_n*h_n.
For the budgets |c_n|<=B*2^n/(n+1)^6 and log h_n=-n log16+O(log(n+2)),

    log(volume/covolume)=[4-log8-C]*N^2/2+o(N^2).

The coefficient is positive. The symmetric-box lattice argument therefore
supplies nonzero finite rational perturbations for all sufficiently large
cutoffs, also after any fixed zero prefix. It does not include a denominator
noncancellation sieve, a prescribed period or compatible infinite nonzero
choices.

The distinction is necessary. In a separate triangular toy, take integral
|a_n|<=2^n, n>=1, and impose at n=2j

    a_(2j)=M_j*a_j modulo Q_j,
    M_j=2^(2j+2), Q_j=2*M_j*2^j+2*2^(2j)+1.

The bounded congruence forces equality and then a_j=a_(2j)=0. At cutoff N,
only odd coordinates greater than N/2 are free; the only infinite bounded
solution is zero. Nevertheless its log volume/index surplus is
(log2/8)*N^2+O(N)>0. Every finite projection sum a_n/16^n is bounded by
8^(-floor(N/2))/7 and tends to zero. Thus large finite volume can coexist
with collapse of every fixed nonzero target. This toy proves no such collapse
for the actual BBP lattice.

For that actual lattice Gamma_N in c coordinates, let P_N be the set of
sum_(k<N) beta_k*c_k within the budgets and desired zero prefix, and let
r_N=sum_(k>=N) beta_k*b_k. A sufficient missing estimate is
dist(delta,P_N)<=r_N for every sufficiently large N, for one fixed target
pi+delta known to be irrational and nondense. Uniform tail convergence and
compactness would then give an infinite rational-moment realization: each
finite point can be completed to the exact period inside the remaining real
budgets, and the resulting closed constraint sets are nested. Volume alone
does not prove this covering estimate. Denominator noncancellation would
still require its own argument.

Frozen packet `/tmp/pi-m4-global-analytic-lattice-20261127/` has report
SHA-256 `cb4fd03043455b8db38c839790c46254156f4693cdb7463a629b0a75b18b5eb9`
and manifest SHA-256
`5aee5cf940a686205153b35d5a61aa2a155bdd765d0afa0aaa177ced2edfa047`.
Parent reconstruction and unchanged-copy replay passed 12,890 exact finite
checks, exit 0, identical receipt and preserved originals. The index
asymptotic, finite existence and compactness discussion are paper arguments.
No infinite all-prime countermodel or actual visitation theorem follows.

## Two actual lattice duals fail even after period alignment

A discriminating follow-up retains the off-diagonal moments rather than
using volume. Fix a zero coefficient prefix K>=1 and budgets b_j as above.
For an integer dual functional w on Gamma_N, define

    E_N(w,theta)=sum_(K<=j<N)b_j*abs(w_j-theta*beta_j).

Every permitted lattice point satisfies
dist(theta*sum beta_j*c_j,Z)<=E_N(w,theta). An infinite continuation adds
the tail error abs(theta)*r_N. This box certificate can exclude a period
only when its right side is less than 1/2. Its norm is over the entire real
coefficient box, not the smaller feasible lattice subset.

The second-kind polynomials Q_j(z)=integral(R_j(z)-R_j(t))/(z-t) dnu obey

    beta_j=R_j(16)*beta_0-16*Q_j(16), beta_0=752/15-15*pi,
    Q_(j+1)*R_j-Q_j*R_(j+1)=h_j.

The Wronskian identity follows by the monic three-term recurrence, starting
with Q_1=h_0. The determinant of consecutive beta coefficient pairs in the
irrational basis (beta_0,1) is -16h_j. Thus consecutive periods are rationally
independent, and D_K=beta_K*R_(K+1)(1)-beta_(K+1)*R_K(1) is nonzero.
The endpoint values R_j(1) are positive rationals. Independence makes the
unbounded period image dense; it provides no bounded covering conclusion.

Let T_(n,j)=integral t^(n+1)*R_j(t)/(16-t) dnu. The exact prefix relation is
V_n=16^n*sum beta_j*c_j-sum T_(n,j)*c_j. In x=t^(1/8) coordinates,
P(x)=(1-x)(4+4x+4x^2+2x^3+x^4) and elementary beta integrals give

    n^3*T_(n,j) -> R_j(1)/32,
    n^4*(T_(n,j)-T_(n+1,j)) -> 3*R_j(1)/32.

The corresponding absolute bounds are U_j/32 and 3U_j/32 after multiplying
by n^3 and n^4, with U_j=32(j+1)^3*4^(-j). Since sum b_j*U_j converges,
these limits pass to the weighted absolute sums with growing cutoffs.

At cutoff N=p, the first Newton condition and V_0=0 make
w_p=a_(p-1)/p^3 an integer dual. Its natural period multiple is
theta_p=L_(p-1)*16^(p-1)/p^3, with residual -L_(p-1)*T_(p-1,j)/p^3.
Writing S_K=sum_(j>=K)b_j*R_j(1)>0 gives error asymptotic
(S_K/32)*L_(p-1)/p^6. This scale persists even after optimizing theta:
the determinant beta_(K+1)*w_K-beta_K*w_(K+1) eliminates theta, and its
nonzero endpoint constant is D_K. The two-coordinate triangle inequality
therefore supplies a matching lower bound. In particular

    inf_theta E_p(w_p,theta)=Theta_(K,B)(L_(p-1)/p^6).

One adjacent-prefix stencil W_n=L_(n+1)*(V_(n+1)-V_n) is also integral.
It cancels one endpoint power, but the same determinant proves
inf_theta E_(n+2)(W_n,theta)=Theta_(K,B)(L_(n+1)/n^4).
Both errors grow with logarithmic rate 4, so these two certificates fail
eventually. The first row is primitive on the full lattice; the adjacent row
is primitive along n+2=2^s, as witnessed by a sole nonzero newest integer
prefix. These witnesses need not meet the analytic budgets. Hidden integer
content therefore cannot rescue the first family or that stencil subsequence.

Suspend these two estimates. Growing-support row combinations and norms on
the actual feasible subset remain untested; neither full covering nor its
failure follows. Frozen packet `/tmp/pi-m4-actual-period-projection-20261127/`
has report SHA-256
`83c8ad422e65c6d9fad38ae0615f5a24a0788eaf1ba76a307c4b569e57a7d2a9`
and manifest SHA-256
`de4450f0342ebfe392591b748c1837b070da983ba20a0abe170333ae9f26f56f`.
Parent reconstruction and unchanged-copy replay passed 613 rational/symbolic
checks, exit 0, identical receipt and preserved originals. Pi was an unevaluated
symbol; no actual phase was computed. The asymptotics and their limits remain
paper arguments, with no Lean theorem or visitation conclusion.

## Growing binomial stencils cannot overcome the clearing cost

Increasing the cancellation order requires a uniform argument. Fix K>=1 and
the same budgets b_i, put m=n+d, and consider

    W_(n,d)=L_m*sum_(j<=d)(-1)^(d-j)*binom(d,j)*V_(n+j).

For d>=1 and m-1>=K, its actual integer content g on the full finite
zero-prefix Newton lattice divides d. Indeed the newest-coordinate vector
a_m=M_m, all older coordinates zero, shows g|M_m. For each p|M_m,
the coordinate a_(m-1) is absent from every p-row: their indices are p*l-1
or l-1, and p|m+1. Multiplying its unit vector by a p-unit clearing all
other primes' row moduli gives a global lattice witness. Its W-value is
-d*Q*L_m/L_(m-1). The lcm ratio is a p-unit, since its only new factors
4m+1 and 4m+3 are -3 and -1 modulo p. Hence v_p(g)<=v_p(d).
This accounts for older off-diagonal rows and genuine nonprimitive cases;
for K=3,n=6,d=7 the exact finite content is 7. It does not apply to d=0.

The exact residual after removing the natural period multiple
L_m*16^n*15^d is, up to sign, L_m times the vector

    J_i=integral t^(n+1)(1-t)^d*R_i(t)/(16-t) dnu(t).

Let Z be the mass of this positive kernel. The optimized raw box error is
uniformly comparable to L_m*Z. For the lower bound, three consecutive
coordinates suffice. Their monic recurrence at t and the corresponding
beta recurrence at 16 show that proportionality
(R_K(t),R_(K+1)(t),R_(K+2)(t))=lambda*(beta_K,beta_(K+1),beta_(K+2))
would imply lambda*(16-t)*beta_(K+1)=0. On [0,1] this forces lambda=0,
contradicting the absence of a common root of consecutive R polynomials.
Their weighted distance from the beta line therefore has a positive minimum
delta_K on that compact interval. This handles interior concentration points
where the earlier two-coordinate endpoint argument would not suffice.

With Q(x)=4+4x+4x^2+2x^3+x^4, the kernel density in t coordinates is

    F(t)*t^(n+1/8)*(1-t)^(d+2),
    F(t)=Q(t^(1/8))/[8*(1+t^(1/8)+...+t^(7/8))*(16-t)],
    1/256<=F(t)<=1/8.

The reference beta distribution has parameters n+9/8,d+3. Its variance
bound, multiplied by at most 32, gives concentration uniformly at its mean
with squared deviation at most 8/(m+41/8), including endpoint regimes.
Normalized integrals of the three fixed polynomials consequently approach
their values at that mean uniformly. Their distance from the beta line is
eventually at least delta_K/2. The summable bound sum b_i*sup|R_i| gives
the matching upper estimate, so the optimized raw error is Theta_(K,B)(L_m Z).

Elementary beta integrals bound Z between

    (n+1)(d+1)(d+2)/[256*(m+1)(m+2)(m+3)(m+4)*binom(m,n)]
    and 1/[8*(m+1)*binom(m,n)].

The binomial-mode bounds give log Z=-m H(n/m)+O(log(m+2)) uniformly,
where H(q)=-q log q-(1-q)log(1-q), with H(0)=H(1)=0. Dividing by the
actual content g<=d<=m therefore yields

    log(inf_theta E_(m+1)(W_(n,d)/g,theta))
      =log L_m-m H(n/m)+O_(K,B)(log(m+2)).

Its exponential rate is uniformly at least 4-log2>0. Thus every positive
order, including orders growing with the cutoff, fails this box certificate
eventually. Suspend that entire binomial family. This says nothing about
arbitrary Newton-row combinations or errors measured on the feasible lattice
subset; it proves neither coverage nor collapse of the period set.

Frozen packet `/tmp/pi-m4-growing-stencil-test-20261127/` has report SHA-256
`e8af1d372c4f56273e228e79a683c7cf603c9c263a6aeae772b009dc032dbbda`
and manifest SHA-256
`6d73338440bd23c2b0a912ae7eb31e26840b5f7867f4090b6cf0d8d84c0c4b0d`.
Parent reconstruction and unchanged-copy replay passed 16,660 exact checks,
exit 0, identical receipt and preserved originals. They include the actual
finite off-diagonal lattice and nonprimitive examples. Uniform concentration,
asymptotics and the content theorem remain paper proofs, not consequences of
those finite checks. No actual pi phase or new Lean theorem is supplied.

## Single-prefix content remains subexponential on the full finite lattice

The omitted d=0 case has a different content argument. Fix K>=1, m>=K,
and let g_(K,m)>0 generate the ideal of possible a_m over the finite strong
Newton lattice with a_n=0 for n<K. Then

    log g_(K,m)=O_K(log^2(m+2)).

This allows all earlier free coordinates to vary. It does not bound the
last-coordinate spacing after those coordinates are fixed, or the real size
of any witness. The newest-coordinate vector a_m=M_m shows g|M_m, so its
prime support consists only of p>=7 dividing m+1.

For each such p, write m+1=p^a*u with p not dividing u, and set

    s=ceil((K+1)/p), ell=min{b>=0:p^b>s-1}, b0=min(ell,a-1), D=s+b0,
    P(k)=(k)_s*product_(r<b0)(k-p^r*u), G(k)=p^(D+2)*P(k).

The integral polynomial P has degree D and zero constant. Since j! divides
Delta^j P(0), G satisfies every strong Newton condition; differences above
degree D vanish. Define V_n=0 off the p-endpoints and recursively
p*V_(pk-1)=chi_4(p)*16^(k(p-1))*V_(k-1)+G(k). This realizes G exactly,
preserves the zero prefix, and gives only p-power denominators of depth at
most v_p(n+1). Thus a_n=L_n*V_n is an integer at every index.

The extra roots kill low nodes in the target p-chain. If a-1>=ell, put
F=v_p((s-1)!)+ell(ell-1)/2. The remaining terms, indexed by b>=ell, have
valuations D+2-a+2b+F in V_m. Their unique minimum prevents cancellation,
giving v_p(a_m)=v_p L_m+D+2-a+2ell+F. If a-1<ell, only the newest term remains;
its argument k=p^(a-1)*u is at least s because m>=K, so it is nonzero.
Its valuation is O_K(log_p(m+2)). For p>K the simpler exact witness value is
v_p L_m+3-a, since s=1 and ell=0.

Every other q-row is q-integral, because these local states have only
p-power denominators. Multiplying the whole vector by the p-unit
product_(q!=p,7<=q<=m+1) q^J_q(floor((m+1)/q)) clears all other finite
rows and preserves the p-valuation at the target. These are therefore genuine
full-lattice witnesses. Summing their content upper bounds gives

    log g_(K,m) <= O_K(log(m+2))
      +log(m+1)*log(4m+3)/log7+3*log(m+1).

No prime number theorem is needed for this bound. Witnesses may have very
large real coordinates, and a finite clearing multiplier is not an infinite
realization.

A proposed matching lower bound was false: an arbitrary vector can have a
nonzero bottom p-chain state, unlike the constructed witnesses. For K=1,m=13,
take V_1=1/7, V_13=-16^12/49 and all other states zero. Every available
prime-defect row vanishes, but v_7(a_13)=0 rather than the proposed lower
bound 4. Only the proved upper bound is retained.

The earlier exact prefix-tail identity and two-coordinate determinant apply
also to the raw functional a_m at arbitrary cutoffs, giving optimized box
error Theta_(K,B)(L_m/m^3). Dividing by g_(K,m) therefore leaves logarithmic
rate 4. This supplies the primitive zero-order conclusion separately from
the positive-order theorem above. It is a combination of those paper
interfaces, not a consequence of small content alone. General dual
combinations and norms on the actual feasible subset remain open.

Frozen packet `/tmp/pi-m4-prefix-content-test-20261127/` has report SHA-256
`ec12c66da3d475a3ef241274ae888d4848ed09e61958f3ef04d42b1c23b7d046`
and manifest SHA-256
`324b53efccbf1f8549b93f0ccfb5d99f4f12ecf04c00316a0e735565e269b1a2`.
Parent reconstruction and unchanged-copy replay passed 134 synthetic cases
with 32,679 checks, exit 0, UTC-only receipt difference and preserved originals.
Both chain regimes, finite other-prime clearing and the withdrawn lower-bound
counterexample are included. No bounded positive model, actual pi phase,
Lean theorem or visitation conclusion follows from these witnesses.

## A finite bounded covering certificate

The general-dual investigation now has one positive finite result. It concerns
the perturbation lattice, not the exact BBP forcing or visitation. Fix K=31,
N=50, B=1/4096 and b_j=B*2^j/(j+1)^6. Let Gamma_(K,N) be the rational
coefficient vectors with c_j=0 for j<K whose moment prefixes a_n=L_n*V_n
are integers and satisfy every strong Newton condition through cutoff N:

    G_p(k)=p*V_(pk-1)-chi_4(p)*16^(k(p-1))*V_(k-1), G_p(0)=0,
    v_p(Delta^j G_p(0)) >= j+2+v_p(j!), p>=7 prime, pj<=N.

Use the preceding R_j,Q_j,h_j,beta_j and write e_j=R_j(16), p_j=-16Q_j(16).
With m=49, put

    eta=p_31-e_31*p_49/e_49>0, delta0=eta*b_31/4>0,
    r_lower=B/[256*(2N+3)*(N+1)^6*128^N].

An exact rational basis certifies that **for every real |delta|<=delta0**
there is c in Gamma_(31,50), with every |c_j|<=b_j, such that

    abs(sum_(j<50) beta_j*c_j-delta) <= r_lower
        <= sum_(j>=50) beta_j*b_j.

The rational radius has numerator/denominator lengths 27,863/28,126 bits.
It is small but positive and independent of delta. This is a finite
all-target statement, not a collection of numerical target tests.

For the certificate, define lambda(c)=sum e_j*c_j and sigma(c)=sum p_j*c_j.
Then the exact period is beta_0*lambda(c)+sigma(c), with 0<beta_0<6. A center
for target delta has c*_31=delta/eta, c*_49=-e_31*delta/(e_49*eta), and all
other coordinates zero. Its lambda is zero and sigma is delta. Rounding its
coordinates in the certified full lattice basis changes each basis coordinate
by at most 1/2. The resulting rational lattice vector meets all budgets:
the sum of center size and cell halfwidth is less than b_31/2 at index 31,
less than b_49/512 at index 49, and at most b_j at intermediate indices.
The cell's period error is less than r_lower/8. The lower tail bound follows
from beta_N>=h_N/e_N, h_N>=16^(-N)/[256*(2N+3)] and e_N<=16^N.

The search used approximate Gram--Schmidt decisions only to choose an integer
transformation. Independent exact reconstruction checked det(U)=+/-1, all
1,225 original moment orthogonality equations through degree 49, and 494
original uncleared Newton conditions on each of the old and new bases.
It also checked the actual moment maps, full triangular lattice index,
symbolic center identities and rational cell widths. Approximate reduction
properties are not assumptions of the certificate. No pi value was evaluated.

The verification packet is
`/tmp/pi-m4-n50-certificate-verification-20261127/`, report SHA-256
`588d67f478dc657e5b81c89f082f8d76bdafee7ca2e638107f35eca73dc0d66d`.
The parent replay passed 2,680 exact checks, exit 0, with identical JSON and
exact-certificate artifacts and all 11 frozen verification files preserved.
Only the replay script's output directory was changed, as recorded in
`/tmp/pi-m4-n50-parent-replay-20261127/adaptation.json`; the frozen report's
phrase "unchanged-copy replay" is corrected here to this precise description.
The heuristic search was not rerun. These are paper and exact-arithmetic
results, not Lean declarations.

Two earlier diagnostics clarify the scope. Unrestricted two-dimensional period
projections can cover while their preimages violate coefficient budgets.
Conversely, a full-basis box certificate starting at K=1 is impossible even
though feasible points may occupy a lower-rank section: integrality gives
a_1=105*h_1*c_1, and 105*h_1*b_1<1/2 for B<=1. Thus every full basis has
c_1 halfwidth at least 1/(210*h_1)>b_1, whereas bounded feasible points have
c_1=0. Neither fact decides period covering. An initial exact-rational
reduction trial at N=48 hit its 180-second cap during Gram--Schmidt; that
algorithmic outcome was not a mathematical obstruction. The N50 certificate
addresses actual bounded preimages at one later cutoff only.

## A single rational functional suffices for future covering certificates

A paper reduction removes the need to control lambda and sigma separately.
Keep fixed K>=1, rational B>0, and the zero-prefix lattice Gamma_(K,N).
For N>K define

    rho_N=b_N*h_N/e_N <= r_tail(N)=sum_(j>=N) beta_j*b_j,
    theta_N=16*Q_N(16)/e_N,
    u_(j,N)=p_j+theta_N*e_j, mu_N(c)=sum_(K<=j<N)u_(j,N)*c_j.

All these coefficients and rho_N are rational. The exact error is

    sum_(j<N) beta_j*c_j-mu_N(c)
        =(beta_N/e_N)*sum_(j<N)e_j*c_j.

Interlacing gives 15<e_(j+1)/e_j<16. Monic minimization with competitor
(t-1/2)*R_j gives h_(j+1)<=h_j/4. The positive integral identity gives
h_j/e_j<=beta_j<=(16/15)*h_j/e_j. Consequently

    beta_(j+1)/beta_j <= 4/225,
    (beta_(j+1)/e_(j+1))/(beta_j/e_j) <= 4/3375,
    beta_(j+1)*b_(j+1)/(beta_j*b_j) <= 8/225.

In particular (3371/3375)*beta_j<=u_(j,N)<beta_j for j<N. The Wronskian
makes u_(j,N) increase with N. For every finite vector within the budgets,
the absolute error is at most (16/15)*rho_N*T_N, where

    T_N=sum_(k=1)^N 30^(-k)*((N+1)/(N-k+1))^6.

Here T_4=9637175/53747712<1/5 and
T_(N+1)=((N+2)/(N+1))^6*(T_N+1)/30. For N>=4 its multiplier is at most
(6/5)^6/30, whose product with 6/5 is less than 1/5. Induction therefore
gives an absolute period error at most (16/75)*rho_N for all N>=4.
This uses finite polynomials only, never an infinite evaluation at 16.

Fix N0>=max(K+1,4) and the positive rational radius delta0=u_(K,N0)*b_K/2.
For any N>=N0, suppose a full basis of Gamma_(K,N) has cell halfwidths

    w_j<=b_j for K<j<N, and w_mu<=rho_N/4

in coordinates (c_(K+1),...,c_(N-1),mu_N). The frame determinant has
absolute value u_(K,N)>0. Rounding the center (0,...,0,delta) for
|delta|<=delta0 gives those bounds and abs(mu_N(c)-delta)<=rho_N/4.
The inverse coordinate c_K stays within budget because

    sum_(K<j<N)u_(j,N)*b_j < u_(K,N)*b_K/27,
    rho_N/[4*u_(K,N)] <= (30/3371)*b_K,
    delta0/u_(K,N) <= b_K/2.

The first follows by summing the geometric ratio 8/225 and using
(8/217)*(3375/3371)=27000/731507<1/27; the second uses N>=K+1 and the
same ratios. Hence |c_K|/b_K<=1/2+1/27+30/3371<3/5. All budgets now hold,
and the actual period is within (139/300)*rho_N<r_tail(N)/2 of delta.
The same delta0 applies to every qualifying cutoff.

The independently criticized sketch is
`/tmp/pi-m4-one-functional-consumer-20261127.md`, SHA-256
`c7544104acd0e64ab6dc2c77e70f238f645b3c3bf97cb80f4f9fedb47805f45d`.
Its original rationality and determinant-sign ambiguities were corrected;
the zero-prefix section is explicit. This proves a sufficient consumer only.
No qualifying basis family for arbitrarily large N is supplied, and the N50
basis above was not tested in this new frame. Positive volume, primitive
prefix content and small projected cells do not furnish the missing bound.
Rare stages with many active primes still defeat uniform one-stage greedy
estimates. Uniform covering would need a compatible infinite-model argument;
denominator noncancellation is separate. Even such a model would discard exact
A, so neither this reduction nor the finite certificate proves actual V.

## Exceptional blocks and polynomial witness degree

The uniform-dual test gives an ordinary-stage lower bound, including the
unused tail. For an integer-valued dual w on Gamma_(K,N), let j be its
largest nonzero c-coordinate and put

    E_total=sum_(K<=i<N)b_i*abs(w_i-theta*beta_i)+abs(theta)*r_tail(N).

The triangular prefix projection gives w_j in (L_j*h_j/M_j)*Z. Minimizing
b_j*abs(w_j-theta*beta_j)+abs(theta)*r_tail(j+1), using
r_tail(j+1)<beta_j*b_j, proves

    E_total >= (L_j*h_j/M_j)*r_tail(j+1)/beta_j
            > (15/256)*L_j*h_(j+1)*b_(j+1)/M_j.

If the final lower bound exceeds 1/2, top support at j is impossible for a
short dual. Its exponential rate is 4-log8-log(M_j)/j. Primitive prefix
content cannot replace M_j while the older dual coordinates vary.

For every fixed integer H>=1 and real R>0 there are arbitrarily late blocks
j=n,...,n+H-1 with log M_j>=R*(j+1) everywhere. Choose disjoint finite prime
sets P_t, all primes exceeding max(H,7), with sum log(p)/p>R in each set,
then impose p|(n+t+1) by CRT. Prime reciprocal divergence permits the sets.
The selected rows yield genuine duals whose newest integer-prefix coefficient
is 1/M_selected and whose other integer-prefix coefficients lie before n.
Their weighted c-coordinates in the fixed window have upper exponential rate
4+log8-R. Older coordinates remain uncontrolled. These are not globally
short duals or counterexamples to covering; H is fixed, not growing with n.

A new simultaneous family has controlled exponential real height. Put
D=K+1, H_p=floor(N/p), q_p=1 for H_p<D and otherwise
q_p=D+2+v_p((H_p-D)!), C_N=product_(7<=p<=N)p^q_p over primes, and
V_n=C_N*(n+1)_D, V_-1=0. These prefixes satisfy all strong Newton rows.
Indeed for lambda=16^(p-1), the j-th difference of lambda^k*(k)_D is
zero for j<D and (j)_D*lambda^D*(lambda-1)^(j-D) otherwise; the first
term `Delta^j[p*(pk)_D](0)` is divisible by p^(j+1)*j!.
The orthogonal coefficients reproducing these moments have budget norm at most

    (4352/B)*C_N*N^(D+6)*(2N+1)*16^(N-1).

The roots of R_i give monomial coefficient sum at most 2^i; the existing
norm lower bound then gives this estimate. Chebyshev and Legendre bounds make
its logarithm at most [(3+1/D)*log16+C_star]*N+O_(K,B)(log(N+2)), where
C_star=sum_(p>=7)log(p)/[p*(p-1)]<1. It is not a bounded perturbation.

More strongly, every nonzero rational raw-prefix polynomial P of degree d,
with P(0)=0, V_n=P(n+1) and the fixed coefficient budgets, must eventually
have d>N/200 if it satisfies all rows through N. Set H=floor(N/7).
For H>2d, the rows j=H-d,...,H and v_7(16^6-1)=1 imply

    v_7(Delta^d P(0)) >= d+2+v_7((H-d)!).

Write the j>d defect as -chi_4(7)*(lambda-1)^j*Q(j), with
Q(j)=sum_(r<=d)binom(j,r)*(lambda/(lambda-1))^r*Delta^r P(0).
Taking the d-th difference of Q proves the valuation bound. Meanwhile
L_(d-1)*Delta^d P(0) is a nonzero integer, and the budgets give
abs(Delta^d P(0))<=(256B/15)*17^d. With L_(d-1)<=C*exp(5d), this requires

    (log7/42)*N <= [5+log17-(5/6)*log7]*d+O_B(log(N+2)).

The error constant is independent of P,d,N. If d<=N/200, then H>2d
eventually and log7>3/2, log17<3 imply 11N/5600<=O_B(log(N+2)), a
contradiction. Thus arbitrary rational coefficients varying with N do not
evade the obstruction. The full lattice can have interpolation degree growing
with N and is not excluded.

Frozen report `/tmp/pi-m4-uniform-dual-20261127/report-v1.md`, SHA-256
`97670b183d440f48620924057d97cd391a8af790980af57f608e3467f4fce592`,
contains the full derivations. Parent unchanged-copy replay passed 1,477
exact checks at K=31,N=497,B=1/4096, exit 0, identical receipt and six
preserved artifacts. The last seven-adic row is sharp: removing one factor
7 changes valuation 84 to 83. Independent paper criticism found no defect;
its uniform-constant clarification is included above. Universal bounds are
paper proofs, not finite-test consequences or Lean theorems. A witness v
only gives abs(w(v)-theta*beta.v)<=E_N(w,theta)*norm_b(v); exponential
height cannot force an integer to vanish from E_N<1/2. A useful full-coordinate
norm/value bound, uniform covering and actual V remain open.

## Logarithmic windows contain good stages but cannot repair a frozen history

An adaptive window improves the ordinary-stage observation. Write
F(m)=sum_(p>=7,p|m)log(p)/(p-1). Legendre gives
log M_(m-1)<=m*F(m)+log^2(m)+4log(m). Counting prime multiples in an
interval of length H gives sum F<=H*C_star+4+3log(X+H), using the
elementary Chebyshev bound. Consequently for integer X>=2^16 and
H=ceil(64log(X+2)), some j in [X,X+H) satisfies

    log M_j/j<9/8<4-log8-1/2.

Also the contribution of p>H to F(m) is at most log(m)/(H-1). Thus nearby
ordinary stages exist and most excessive modulus mass comes from smaller
primes. This does not provide a small full basis for the window.

The exact local content supplies a countertest. Freeze all integer prefixes
before J, with floor(N/7)<=J<=N-1, and consider homogeneous differences
of extensions. Put j=N-1, h=j-J, t_p=floor(h/p). The ideal of possible
last integers a_j in this local all-prime lattice has positive generator

    g_(J,N)=M_j/product_(p>=7,p|N)p^[t_p+v_p(t_p!)].

The hypothesis on J makes every available lower-chain index k-1 less than
J, so its contribution actually vanishes. For p|N, set k=N/p and
s=ceil((J+1)/p)=k-t_p. Earlier Newton coefficients vanish. Binomial
inversion gives minimum valuation s+2+v_p(k!)-v_p((k-s)!) for G_p(k),
attained at the first allowed Newton order s. Multiplying by L_j/p gives
the stated exponent for a_j. A single Newton coefficient at s attains it;
clearing other prime rows by a multiplier coprime to p preserves that
valuation. The newest-only vector a_j=M_j bounds the prime support. These
two directions prove the exact content formula on the entire local lattice.
The earlier K=1,N=14 counterexample still guards the essential J hypothesis.

The savings are at most h*F(N), so
log g_(J,N)>=(N-h)*F(N)-log^2(N)/log7. Along primorial endpoints
N=product_(7<=p<=Y)p, any h=o(N) therefore has log(g_(J,N))/N tending
to infinity. In contrast the analytic budgets imply

    abs(a_j(c)) <= A_N*norm_b(c),
    A_N=(4096B/15)*L_j*16^j, log A_N=O_B(N).

Every budgeted local point consequently has a_j=0 at those sufficiently
late endpoints. Every full local basis has a vector of norm at least g/A_N,
and its all-center covering radius is at least g/(2A_N). Both lower bounds
are superexponential. This refutes subexponential full-basis repairs with
any sublinear frozen-history window, not just a particular reduction method.

For windows of length ell=ceil(64log N), the same actual lattice nevertheless
has log(volume/covolume)>=[4-log8-17/16+o(1)]*N*ell>0. Thus large volume
and poor covering coexist in the actual arithmetic blocks. Bounded points
may lie in the proper hyperplane a_j=0; their periods might still cover a
target line. Neither global fixed-K covering nor that period-line possibility
is excluded. The local dual a_j/g is not asserted to be a global dual.

Frozen report `/tmp/pi-m4-adaptive-window-20261127/report-v1.md`, SHA-256
`5bd44ddc97062434cc6ca1e25a1c3918ab91fca6d15ed9a00cffb4050a7f8d33`,
contains the explicit constants and proofs. Parent unchanged-copy replay
passed 3,288 original prime/order checks at N=1001,J=900, exit 0, identical
receipt and six preserved artifacts. Independent paper criticism found no
defect. Its nonblocking integer-square-root cleanup was made in a new checker
under `/tmp/pi-m4-adaptive-window-isqrt-20261127/`; the same receipt passed
and originals remain intact. No finite basis search, actual phase or Lean
proof was used. Further local full-basis enlargement is suspended; global
older-coordinate control and period-specific fibers remain open.

## Global support vanishing and exceptional combinations

Fix K>=1 and rational B>0. For an integer-valued dual of Gamma_(K,N), write
w=sum q_i*a_i and retain the complete error

    E_N(w,theta)=sum_(K<=j<N)b_j*|w_j-theta*beta_j|+|theta|tail_N.

The q_i are rational integer-prefix coefficients; w_j are orthogonal-coordinate
coefficients. For max(K,floor(N/7))<=i<N, set V_i=D/L_i and every other
prefix zero. The lower-chain occurrence would require 7(i+1)<=N, so is absent.
For each p>=7 dividing i+1 put k=(i+1)/p, H=floor(N/p), t=H-k. The original
Newton rows have values (-1)^(r-k)*binom(r,k)*pD/L_i for k<=r<=H. Their
required valuation increases with r, giving the exact minimal positive scale

    D_(i,N)=product_(p>=7,p|i+1)
      p^[H+1+v_p(L_i)+v_p(k!)+v_p(t!)]
      =M_i*product_(p>=7,p|i+1)p^[t+v_p(t!)].

This is a full global lattice witness. Its inverse moment coordinates are
c_j=(D/L_i)*([t^i]R_j-16[t^(i+1)]R_j)/h_j for j>=i, and zero earlier.
Roots of R_j in (0,1) bound the coefficient difference by
binom(j,i)+16binom(j,i+1). For fixed C>0 and N-C*log N<=i<N, uniformly

    log ||c||_b <= [F(i+1)+log8-4]*N+o(N),
    tail_i/tail_N <= exp(log(16/15)*N+o(N)).

Here log D<=N*F(i+1)+O(log^2 N); all constants retain fixed K,B,C.
If E_N<1/2, integrality and the complete tail give
|q_i*D|<=||c||_b*(1/2+tail_i/(2tail_N)). Consequently, for every fixed
epsilon>0, eventually

    F(i+1)<=tau-epsilon ==> q_i=0,
    tau=4-log(128/15),  N-C*log N<=i<N.

In particular F<=9/8 has a fixed positive margin. Applying the same real
estimate to the unit-a_i inverse vector, without claiming its lattice
membership, gives |q_i|<=exp(-tau*N+o(N)) at every such index of a short
dual, including exceptional ones. If j is its largest nonzero q index,
triangularity makes j its largest w index too. CRT surjectivity of the
prefix projection lets w descend to cutoff j+1; the omitted zero w terms
combine with the tail to give E_N=E_(j+1). This shortening is valid only
at the actual support horizon, not at an arbitrary interior index.

### Exceptional support does not bound the top denominator

Fix Q with F(Q)>2 and p>=7 not dividing Q. Put N=pQh, n=N-1,
e=v_p(L_n), J_p(h)=h+2+v_p(h!) and E=J_p(h)+e-1. The functional

    W_(p,Q,h)=L_n/p^[J_p(h)+e] * Delta_Q^h G_p(0)

is a global integer dual. Finite binomial expansion gives integer coefficients
Delta_Q^h binom(k,r), zero for r<h, so the original Newton conditions imply
the required p-divisibility; L_n clears all other denominators. Its support
lies at pQr-1 and Qr-1 for 1<=r<=h, all exceptional, and its top coefficient
is exactly p^(-E).

For h>=ceil((K+1)/p) and N/r^v_r(N)>=K+1 for every prime r!=p dividing N,
the dual is primitive. The newest-only witness restricts content primes to
p>=7 dividing N. At p, prescribe G_p(k)=p^J_p(h)*binom(k,h), take free
chain roots zero and clear other primes by a p-unit; the resulting W value
is a p-unit because Delta_Q^h binom(k,h)=Q^h. At each other possible
content prime r>=7, use the homogeneous r-chain rooted at N/r^v_r(N), with
the root normalized by its envelope r-power. Its top a_n is an r-unit;
earlier chain contributions acquire an r-factor through L_n/L_i. Clearing
other primes by an r-unit preserves this. These witnesses need not be small.

A fixed squarefree Q is the product of primes from 7 through 59,
64092011671807087969; positive rational logarithm bounds certify F(Q)>2.
Let m>1 be squarefree with every prime factor at least 7 and not dividing Q.
Put N=Qm, h_p=m/p and E_p=J_p(h_p)+v_p(L_(N-1))-1.
For D=product_(p|m)p^E_p, choose integer coefficients A_p with
sum A_p*D/p^E_p=1. Then W=sum A_p*W_(p,Q,h_p) has top coefficient 1/D,
exceptional support and primitive content under the preceding prefix conditions.
The p-forcing witness makes its own summand a unit and the others divisible
by p; a prime in Q sees the top value a_(N-1)/D modulo that prime.
Along products of all primes p>=7 outside Q up to a growing bound,

    log D/N=(1/Q)*sum_(p|m)log p/(p-1)+O(log^2 N/N) -> infinity.

Nevertheless this family cannot be short. Keep its smallest prime p0 fixed.
At i=N-p0*Q-1, only W_p0 has a primary endpoint; no secondary endpoint
reaches i for sufficiently large m. Thus

    q_i=-A_p0*h_p0*L_(N-1)/(p0^E_p0*L_i),
    |q_i|>=p0^(-E_p0),
    log(p0^E_p0)/N -> log p0/[Q*(p0-1)] < tau.

The coefficient is a fixed distance from the top and violates the necessary
near-top real bound. Primitivity prevents normalization from removing this
obstruction. This excludes only the constructed family; further combinations
might cancel the exposed coefficient. No global covering conclusion follows.

Corrected report `/tmp/pi-m4-global-support-domain-fix-20261127/report-v3.md`
has SHA-256 `f0142ebe08cd59fc4d5809f9a3afb772d5cfe5a6e7b8deb0bddd6cdda3ce5277`.
Independent criticism resolved a missing i>=K singleton hypothesis and narrowed
the homogeneous-chain step to possible content primes. The original packet
`/tmp/pi-m4-global-support-20261127/` remains intact. Parent unchanged-copy
replay passed 7,047 exact checks with an identical receipt and eight preserved
files. A separate integer-square-root checker cleanup also passed identically.
N28 tests singleton minimality and moment inversion; N1001,Q11 tests primitive
single/CRT duals against original rows. Q11 is not exceptional: its algebraic
fixture is distinct from the symbolic large-Q asymptotics. All universal
arguments remain paper mathematics; no actual pi phase or Lean proof is used.

## Sharp local conductors exclude globally sparse duals

Fix a prime p, 1<=s0<=H and a nonempty S subset {s0,...,H}. Put
d=s0+|S|-1 and H_i(x)=(x)_(s0)*product_(k in S,k!=i)(x-k). On the whole
module G(0)=...=G(s0-1)=0 with Delta^j G(0) in p^(j+2)*j!*Z_p,
an integral functional sum_(i in S)c_i*G(i) necessarily satisfies

    v_p(c_i)>=-d-2-v_p(H_i(i)).

These bounds are simultaneously attained. Integer Stirling changes of basis
identify the interpolating polynomial module with G(x)=p^2*F(px),
F in Z_p[x], degree<=H and the required zeros. Monic division shows that
the isolated-value ideal at i is exactly p^(d+2)*H_i(i)*Z_p, attained by
G=p^(d+2)*H_i. The functional

    p^(-d-2)*sum_(i in S)G(i)/H_i(i)

is the order-d divided difference of F on the integral nodes
p*({0,...,s0-1} union S), and is integral. Reducing higher columns by the
monic node polynomial shows that the restricted module is generated by
(p^(j+2)*(i)_j)_(i in S), s0<=j<=d. The corresponding coupled conditions
characterize its dual; separate coordinate bounds do not. For example,
S={1,2},s0=1,c=(p^-4,0) satisfies the separate bounds but fails on p^3*x.
Factorial and clustering costs are already present in H_i(i), so no general
individual-coordinate improvement is possible. Polynomial witnesses and
finite restrictions give the same conductors for the infinite Newton class.

### Keep the free roots when returning to the global lattice

For fixed p>=7 let R_t=V_(t-1) for p-free t and gamma_m=q_(m-1)*L_(m-1),
zero off the original support. Unwinding every p-chain gives

    w=sum_(p-free t)D_t*R_t+sum_k B_k*G_p(k),
    D_t=sum_(r>=0) gamma_(p^r*t)*chi_p^r*16^(p^r*t-t)/p^r,
    B_k=sum_(r>=1) gamma_(p^r*k)*chi_p^(r-1)*16^(p^r*k-p*k)/p^r.

All sums stop at the cutoff. In particular D_t=gamma_t+chi_p*16^[t(p-1)]*B_t.
Writing l_n=v_p(L_n), the exact envelope identity
l_(p^r*t-1)=r+l_(t-1) makes the local root ranges p^(-l_(t-1))*Z_p.
The zero prefix sets R_t=0 for t<=K and G_p(k)=0 for k<s0=floor(K/p)+1.
Root variables and strong-Newton variables are otherwise independent. Global
duals must therefore satisfy v_p(D_t)>=l_(t-1) for p-free t>K as well as
the full coupled G-functional conditions. Rational basis witnesses have
integer a-coordinates; a p-unit clears other primes, proving this localization.
It supplies no bound on the real size of that clearing multiplier.

Local conductor attainment need not preserve a specified global a-support.
The earlier K1,N14 root witness has G_7=0, V_1=1/7 and
V_13=-16^12/49, with a_13 a 7-unit. It violates a_13/7^4 integrality
despite the G-only allowance. This guard is why roots cannot be omitted.

### A complete-norm consequence for arbitrary sparse support

Let A be the nonzero a-support, r=|A|, j=max A, m=j+1. For each p>=7
dividing m put k=m/p, s0=floor(K/p)+1 and

    U_p={(n+1)/p^u>=s0 : n in A, 1<=u<=v_p(n+1)},
    d_p=s0+|U_p|-1,
    H_(p,k)=(k)_(s0)*product_(t in U_p,t!=k)(k-t),
    e_p=v_p(L_j)+d_p+1+v_p(H_(p,k)),
    D_j(A)=product_(p>=7,p|m)p^e_p.

The ambient ancestor set permits cancellations among B coefficients, but
its top B_k=q_j*L_j/p cannot cancel. The local bound applies. At p not
dividing m, the free root t=m instead forces q_j to be p-integral. At
2,3,5 the lattice index is prime to that prime, giving the same conclusion.
Hence D_j(A)*q_j is a nonzero integer. Since U_p subset {s0,...,k},
d_p<=k and H_(p,k) divides k!, this D_j(A) divides the older bound M_j.
Attainment for a prescribed global support is not asserted.

The weighted ancestor count sum_(p|m)|U_p|*log p<=r*log m and
v_p(H_(p,k))*log p<=d_p*log m give the explicit bound

    log D_j(A)<=(r+K/7+1)*[(log m)^2/log7+log m]
                                  +(log4/log7)*log m.

The full-tail top-coordinate minimization, using |q_j|>=1/D_j(A), yields

    E_N(w,theta) > (15/256)*L_j*h_(j+1)*b_(j+1)/D_j(A).

Its numerator has logarithm (4-log8)*j+o(j). Therefore for fixed K,B and
j tending to infinity, r=o(j/log^2(j+2)) forces the infimum over theta to
grow exponentially, with lower exponential rate at least 4-log8. More
quantitatively, every sequence of short global duals E_N<1/2 must satisfy

    liminf r*log^2(j+2)/j >= (4-log8)*log7.

On a hypothetically violating subsequence, r=O(j/log^2 j), so the linear-log
remainder is o(j) and the norm lower bound gives the contradiction. These
are a-support sizes, not c-support sizes. No uniform finite threshold follows.

Ordinary-index deletion does not imply this sparsity. F(m)>9/8 includes
every multiple of 7436429=7*11*13*17*19*23, a positive-density progression.
Its count eventually exceeds j/log^2 j. Nor has deletion at every interior
index been proved. Larger supports and cancellation of their entire real
norm remain open, as do global period covering and actual V.

Frozen report `/tmp/pi-m4-sparse-newton-support-20261127/report-v1.md`,
SHA-256 `b8cfc2ab8c4dd6ae20c63c7c79b39ba6aadd50ef4fd21c9985b72462f84f7631`,
contains the full arguments. Parent reconstruction and byte-unchanged replay
passed: 154 independent minor-based conductor checks, 101 global-dual
denominator checks, and the full column/root/globalization/support/norm
checks, exit 0, identical receipt, four preserved originals. The universal
module, localization and asymptotic arguments are paper proofs, not finite
test conclusions or Lean exports. Independent criticism completed with no
defect; the review record retains the dense-support, global-attainment and
actual-visitation gaps. Final integration review and its focused domain/notation
repairs passed; the review record owns the full dispositions.

## Descendant witnesses require nonzero defects to stay bounded

Fix K>=1, B>0 and the preceding budgets b_j. Choose r>=K+1, i=r-1 and
N>=r. Let D be the product over primes p>=7 dividing r of

    p^[H_p+1+v_p(H_p!)+v_p(L_i)], H_p=floor(N/p).

For positive d with no prime factor 2,3,5, including d=1, prescribe

    V_(rd-1)=D*chi_4(d)*16^[r(d-1)]/(d*L_i), rd<=N,
    V_n=0 at every other n<N.

This is a global lattice witness. For every odd d, L_i*d divides L_(rd-1):
each constituent prime power is at most (4r-1)*d<=4rd-1. Its first integer
prefix is a_i=D. For p not dividing r, both descendant terms cancel exactly
in every imposed G_p. For p dividing r, only k=(r/p)*d with p not dividing d
has an uncancelled source, of value p*D*chi_4(d)*16^[r(d-1)]/(d*L_i).
Its valuation is at least J_p(H_p); integer finite differences then satisfy
every original row through H_p. This D is sufficient, not claimed minimal.
If r has only prime factors 2,3,5, D=1 and all defects vanish; the earliest
integer coordinate makes the witness primitive. For general r the boundary
sources cannot all be zero with that first nonzero root.

At N=11r the only multipliers are 1,7,11, and G_7(r)=G_11(r)=0.
This completion is expensive for a reason independent of its sparse raw
support. For any finite coefficient vector define

    F(t)=sum_(K<=j<N)c_j*R_j(t), M(c)=max_j |c_j|/b_j,
    sigma(c)=sum_j beta_j*c_j,
    H_n(c)=integral t^(n+1)*F(t)/(16-t) dnu,
    V_n=16^n*sigma(c)-H_n(c).

The original polynomial bounds give sup|F|<=64B*M(c). Since
nu([0,1])=A(0)-A(1)=12301/4095<4, uniformly in n,N,

    |H_n(c)|<=C_B*M(c), C_B=256B/15.

For ANY completion with N>=11r, root v=V_(r-1) and G_7(r)=G_11(r)=0,
the normalized descendant values are -v/[7*16^(r-1)] and
-v/[11*16^(r-1)]. Each differs from the same sigma by its residual. Hence

    M(c)>=(4/77)*|v|*16^(6r)/[C_B*(1+16^(-4r))].

If a_(r-1) is a nonzero integer, |v|>=1/L_(r-1), and this becomes
15*16^(6r)/[4928*B*L_(r-1)*(1+16^(-4r))]. Its lower exponential rate
per r is 6log16-4>0 for fixed B. All intervening and later coefficients
may vary; only the two exact zero defects and the integral root are imposed.

Repeated cancellation at one prime also fails. If the 7-chain vanishes
through 7^(a+1)*r<=N, consecutive normalized descendants give

    M(c)>=[8*|v|/7^(a+1)]*16^[(7^a-1)*r]
                       /[C_B*(1+16^(-6*7^a*r))].

Thus a fixed nonzero integral root cannot persist in bounded completions with
an arbitrarily long zero-defect chain. More generally, if all imposed defects
at a fixed p>=7 vanish, then for every pk<=N,

    |sigma(c)|<=C_B*M(c)/(p-chi_4(p))
                      *[p*16^(1-pk)+16^(1-k)].

Within the budgets this added subspace's period tends to zero as N grows;
adding any budgeted analytic tail only adds tail_N, also tending to zero.
For an infinite budgeted series, uniform convergence on [0,1] extends these
identities. The last bound forces sigma=0, so all V_n are bounded. But the
homogeneous p-chain has magnitude 16^[(p^a-1)r]*|V_(r-1)|/p^a, forcing
each root to vanish. All moments and coefficients vanish by orthogonality.
This does not evaluate an infinite series at 16.

The dual consumer retains the entire tail. For a nonzero witness z and
E_N(w,theta)<1/2,

    |w(z)|<(1/2)*max{M(z),|sigma(z)|/tail_N}.

A certificate at most 1 forces the integer w(z) to vanish; once M(z)>2
this particular bound cannot do so from E_N<1/2 alone. It does not prove
w(z) nonzero or exclude a sharper tailored estimate. Thin raw support does
not give a small orthogonal norm.

Allowing nonzero defects changes the identity to

    G_7(r)/(7*16^(6r))-G_11(r)/(11*16^(10r))
      =(4/77)*V_(r-1)-H_(7r-1)/16^(6r)+H_(11r-1)/16^(10r).

For M(c)<=1 and an integral nonzero root, the absolute normalized difference
must eventually be at least 2/[77*L_(r-1)]. Whether admissible nonzero Newton
values realize this difference within all budgets remains open. Exact
zero-defect repair is suspended; no collapse of the full strong-Newton lattice,
global covering or actual V follows.

Corrected frozen report
`/tmp/pi-m4-descendant-domain-fix-20261127/report-v3.md`, SHA-256
`deaec85f92fdfbd3ce6cc5d08fe1973f5793b4009beeb3b69e5424c7eaadf182`,
retains the full proof. Parent reconstruction and unchanged-copy replay passed
1,144 checks, identical receipt and six preserved originals. Original rows
were tested at roots 2,4,6,7,11,14,21; N22 reconstructs the orthogonal basis
and prefixes. For r2,N22,B=1/4096 its norm lies in [2^174,2^175), while the
completion-independent lower bound lies in [2^44,2^45). No actual period was
evaluated. Independent criticism resolved the zero-witness endpoint and strict
integer threshold wording. Universal claims remain paper mathematics; final
integration review passed with those scopes and dispositions retained.

## Progression support gives a rescaled conductor

Fix K>=1, Q>=1 and rational B>0 before taking a limit. Keep the original
strong-Newton comparison lattice, orthogonal data and complete error E_N.
Suppose a nonzero global integer dual w=sum q_i*a_i has support only where
Q divides i+1. Write its actual top j=Q*ell-1 and assume ell>K. The dual
descends to cutoff j+1 with its full tail, as above. These restrictions are
on the dual; the p-local witnesses below may have other nonzero prefixes.

For p>=7 write Q=p^e*q0, with p not dividing q0, and W_a=V_(Qa-1).
The original recurrence gives

    p*W_(pa)-chi_4(p)*16^[Qa(p-1)]*W_a=G_p(Qa).

If p does not divide ell, the original p-free root q0*ell>K has only its
top descendant on this progression. Taking G_p=0 and that root at its
allowed envelope value makes a_j a p-unit and all earlier progression
prefixes zero. A p-unit clears every other prime condition. Thus q_j is
p-integral even when p divides Q. The existing index argument supplies
integrality at 2,3,5. Only primes p>=7 dividing ell can divide its denominator.

For such a prime put H=ell/p, k=QH, lambda_p=v_p(L_j), and define the finite
sets

    Z_p={0,...,floor(K/p)} union
        {q0*p^v*t : 1<=t<=floor(K/q0), p does not divide t, 0<=v<e},
    A_H={0,Q,...,(H-1)Q}, Z_extra=Z_p minus A_H,
    d=H+|Z_extra|,
    P(x)=product_(a=0)^(H-1)(x-Qa)*product_(z in Z_extra)(x-z).

Every root is a distinct integer below k, so d<=k. The polynomial
G_p(x)=p^(d+2)*P(x) satisfies the original Newton conditions and prefix
zeros. The restricted p-free roots W_a can all be zeroed: when q0*a<=K,
Z_p zeros the intervening forcing nodes; otherwise choose the free original
root to cancel them. The required adjustment is

    R_(q0*a)=-sum_(u=0)^(e-1)
      p^u*chi_4(p)^(u+1)*16^[-(p^(u+1)-1)*q0*a]*G_p(p^u*q0*a).

It is p-integral and lies in the allowed root range. Other roots can be
zero. Clearing non-p denominators and the other original prime rows by a
p-unit preserves the resulting top valuation; no real-size bound on this
multiplier is claimed. The sampled defects vanish below H, giving
W_a=0 for a<ell and W_ell=G_p(k)/p. Define

    E_minus(p)=lambda_p+(e+1)H+v_p(H!)+1,
    E_plus(p)=E_minus(p)+sum_(z in Z_extra)[1+v_p(k-z)],
    D_minus=product_(p>=7,p|ell)p^E_minus(p),
    D_plus=product_(p>=7,p|ell)p^E_plus(p).

Since P(k)=Q^H*H!*product_(z in Z_extra)(k-z), the isolated top a_j has
valuation E_plus(p). Consequently D_plus*q_j is a nonzero integer.
The roots lie in [0,k), so E_plus(p)<=lambda_p+k+1+v_p(k!): this improves
the old bound without contradicting it.

There is also genuine global attainment of the lower conductor. Set
J=2+(e+1)H+v_p(H!). The functional

    U_p=[L_j/p^(J+lambda_p)]*Delta_Q^H G_p(0)

is integer-valued on the original lattice. Indeed G_p(x)=p^2*F(px) with
p-integral polynomial coefficients; its step-Q difference has valuation at
least J, including when p divides Q. L_j clears every other denominator.
Its support lies at pQa-1 and Qa-1, and its top coefficient is
p^(-E_minus(p)). Integer Bezout combinations therefore attain top 1/D_minus.
For an empty product use a_j. No independence of sampled defects is assumed.

If every Z_extra is empty, the image of all progression-supported duals
under w -> q_j is exactly (1/D_minus)Z. This includes K=1 and Q not a pure
positive power of a prime >=7, as well as Q=1. A dual attaining 1/D_minus
in this exact case is primitive. In the general case only the conductor
sandwich is asserted; dividing the constructed dual by its integer content g
forces g*D_minus to divide D_plus.

For fixed K,Q, Legendre's formula gives

    log D_±=ell*[F(ell)+sum_(p>=7,p|gcd(Q,ell))v_p(Q)*log(p)/p]
               +O_(K,Q)(log^2(ell+2)),
    0<=log(D_plus/D_minus)=O_(K,Q)(log(ell+2)),
    C_Q(ell)=[F(ell)+sum_(p>=7,p|gcd(Q,ell))v_p(Q)*log(p)/p]/Q.

Only the fixed primes p<=K or p|Q can contribute extra prefix zeros.
The full-tail estimate remains

    E_N(w,theta)>(15/256)*L_j*h_(j+1)*b_(j+1)/D_plus.

Its logarithmic lower bound is
[4-log8-C_Q(ell)]*Q*ell+o_(K,Q,B)(ell). Thus any sequence of such short
duals E_N<1/2, with fixed K,Q,B and actual tops ell tending to infinity,
must have liminf C_Q(ell)>=4-log8. This covers potentially
dense progression support beyond the earlier sparse theorem. For example,
fix the archived odd Q with F(Q)>2 and take ell=2^a. Then D_plus=1 and
C_Q=0, although every top Q*ell remains exceptional for the old F(Q*ell)
test. The permitted support has order j/Q, not o(j/log^2 j).

This is not a uniform exclusion. Along primorial products ell outside Q,
F(ell)/Q diverges, and the explicit global rows attain that leading scale.
Their familiar exposed coefficient at i=Q*ell-p0*Q-1, for fixed smallest
active prime p0, is

    q_i=-A_p0*(ell/p0)*L_j/[p0^E_minus(p0)*L_i],
    |q_i|>=p0^(-E_minus(p0)).

The polynomial content bound above leaves its exponential rate unchanged
after primitive normalization. That rate is
[v_p0(Q)/p0+1/(p0-1)]*log(p0)/Q < 8/7 < tau, so these particular CRT
combinations fail the archived near-top necessary bound for shortness.
Arbitrary further combinations might cancel their exposed coefficients;
the required complete-norm estimate remains open. Neither global period
covering nor actual C_odd/V follows from this comparison-lattice result.

Frozen report `/tmp/pi-m4-progression-dual-support-20261127/report-v1.md`,
SHA-256 `81f529634d63eb7650a2a0daa58f83c65ff6b1857ba63399c49e0a2dd45b4166`,
contains the complete argument. Parent unchanged-copy replay passed 8,430
exact checks, including 2,968 original uncleared Newton rows, with an identical
receipt and six preserved artifacts. Original-row fixtures have cutoff at
most 539; scalar conductor checks reach 3080. No basis search, actual phase
evaluation, real-norm experiment or Lean proof was used. Universal and
asymptotic assertions remain paper mathematics. Independent paper review found
no defect. Exact conductors with nonempty extra-zero sets are deferred; the
complete-norm and actual-trajectory gaps remain open. The continuation review
record owns the full findings and production-integration gate.

## A quadratic test retains the complete dual error

Keep fixed K>=1, rational B>0, N>K and the same comparison lattice, nu,
orthogonal polynomials, budgets and complete tail. For w=sum q_n*a_n put

    gamma_n=q_n*L_n,
    Q_w(t)=sum_(K<=n<N)gamma_n*t^(n+1),
    P_w(t)=[Q_w(16)-Q_w(t)]/(16-t).

The prefix kernel is [16^(n+1)-t^(n+1)]/(16-t). Consequently

    w_r=integral P_w*R_r dnu,
    E_N(w,theta)=sum_(r>=K)b_r*|integral [P_w-16theta/(16-t)]*R_r dnu|.

For r>=N the polynomial moment vanishes; the remaining terms are exactly
|theta|tail_N. The sum converges by the existing tail bounds. If j is the
actual top, deg P_w=j, deg Q_w=j+1 and both leading coefficients are gamma_j.
Writing P_w=sum p_r*t^r gives gamma_n=p_n-16p_(n+1) and
Q_w=(t-16)P_w+16P_w(0). Polynomials of degree below K do not change the
functional on the zero-prefix space. The canonical numerator fixes that
ambiguity. Values at 16 here are of finite polynomials only.

The original undilated row alpha*Delta^h G_p(0), h>=1, has untruncated
numerator, with chi=chi_4(p),

    Q_row(z)=alpha*[p(z^p-1)^h-chi(16^(p-1)z-1)^h-(p-chi)(-1)^h].

The constant correction is required by G_p(0)=V_(-1)=0. Its kernel is

    alpha*[(p-chi)(16^p-1)^h-p(z^p-1)^h
                    +chi(16^(p-1)z-1)^h]/(16-z).

Removing prefixes n<K changes only the invisible low-degree part. For a
retained normalized row require K<=ph-1<N. Set j=ph-1, e=v_p(L_j),
J=h+2+v_p(h!) and alpha=L_j/p^(J+e). Original p-divisibility and integral
coefficients at every other prime make this a global dual with top
q_j=p^(-(J+e-1)). A row ending below K vanishes after prefix removal.

For nonzero w project Q_w onto orthogonal degrees K+1 through j+1:

    H=sum_(r=K+1)^(j+1)(integral Q_w*R_r dnu / h_r)*R_r,
    S=(16-t)H=sum s_r*R_r, M=max_(r>=K)|s_r|/b_r.

H retains the nonzero leading coefficient, so M>0. Orthogonality gives
s_r=0 for r<K, sum s_r*beta_r=16 integral H dnu=0, and
integral P_w*S dnu=-integral H^2 dnu. Pairing the full error with this
finite vector and applying the weighted triangle inequality yields

    E_N(w,theta) >= (integral H^2 dnu) / ||(16-t)H||_b,
    ||S||_b=max_(r>=K)|s_r|/b_r.                         (quadratic test)

This holds for every real theta. S is a real test, not an asserted lattice
point. Its degree is j+2, potentially using coordinates N and N+1; the full
tail supplies those terms. The quotient is rational and uses all high-degree
coefficients. Scaling S does not change its pairing ratio. Scaling w and
theta together scales the bound by the absolute factor, but rational division
can destroy dual membership and distance to integers does not scale linearly.

A homogeneous leading-only estimate cannot improve the existing analytic
exponential scale. Start with P=R_j, K<=j<N, recover its rational q_n by the
displayed coefficient formula, omit n<K and clear denominators by C>0.
The q_n are now integers, hence define a global dual. Its canonical P differs
from C*R_j only below degree K. Thus w_j=C*h_j is its only nonzero orthogonal
coefficient and E_N(w,0)=|lead P|*h_j*b_j. Every universal bound
inf_theta E_N>=A_j*|lead P| therefore requires A_j<=h_j*b_j, whose exponential
rate is 8^(-j). This restricts homogeneous leading-only bounds, not every
arithmetic function of the leading rational number. The actual CRT examples
can have superexponentially small gamma_j=L_j/D_j while other coefficients
make them large. Those other coefficients cannot be discarded.

Interval sup-norm capacity bounds concern a different norm and do not supply
a lower bound on the displayed weighted moments modulo low polynomials and
the resolvent line. Clearing denominators rescales both sides. An adelic
argument would need proved local conditions on the same polynomial retaining
the complete mixed-prime dual module; the moment constraints do not already
give such disk bounds. No general impossibility of richer methods is claimed.

The target comparison also remains essential. For K=1, B=1/4096 and w=a_1,
E_N(w,0)=604487760733/39854391266426880<1/2 for every N>=2, and remains
small for sufficiently small nonzero theta. Thus excluding all nonzero short
duals is false. For a feasible point of period delta, a separating certificate
would need dist(theta*delta,Z)>E_N(w,theta). A small E alone does not suffice,
nor does absence of this certificate prove covering. After shortening at
actual top j, E_N>=|theta|tail_(j+1); if |delta|<=tail_(j+1), the certificate
cannot separate that target. This keeps fixed small-top examples distinct
from genuinely separating duals.

Authoritative report
`/tmp/pi-m4-dual-polynomial-clarification-20261127/report-v2.md`, SHA-256
`5b06f6a56ffb7827ece1b301ce0d490829dea2fb5d30ac737b05315666290c66`,
retains the full proofs and row-domain clarification. Parent unchanged-copy
replay passed 353 exact checks with an identical receipt and six preserved
original artifacts. The actual moments A(n)-A(n+1) were used. A three-prime
integer combination cancels its first two orthogonal moments exactly, and
the quadratic bound exceeds the top-only bound on that fixture. Its large
combination coefficients supply no primitivity, optimality or uniformity
claim. Period cancellation was checked symbolically without evaluating pi.
Independent paper review found no defect in the inequality; the retained-row
domain clarification passed focused review. A useful arithmetic lower bound
on the complete quotient remains missing, as do covering and actual V.
