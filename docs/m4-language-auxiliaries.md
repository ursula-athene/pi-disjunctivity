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
