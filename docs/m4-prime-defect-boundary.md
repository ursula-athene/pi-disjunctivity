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
