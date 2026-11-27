# M4 positive visit certificates and the remaining numerator estimate

These paper investigations work backward from permanent avoidance of an
interval by the actual zero-initialized BBP sequence. They supply finite
positive certificates and test their arithmetic cost. They do not prove a
lower bound that makes a certificate pass for that sequence. No Lean result
is added; V/M4 remain open. The [review record](agy-reports/m4-continuation-review.md)
owns independent review and validation status.

## Ordinary determinant: a valid certificate with two limitations

Assume fract(S_n) avoids (a,b) for all n>=N. Choose a rational inner
interval (c-d,c+d) with 0<d<1/2. This handles a=0 and b=1 as well.
The canonical rotation x_n=fract(S_n-c) lies in [d,1-d]. Put
L=1-2d and rho=L/4. The monic polynomials

    P_0=1, P_r(x)=2*rho^r*T_r((2x-1)/L), r>=1,

have sup norm at most 2*rho^r on this interval. For any m>=2 selected
indices n_i>=N, changing the Vandermonde basis to P_r and applying
Hadamard gives the positive avoidance bound

    Delta=product_(i<j)(x_(n_j)-x_(n_i))^2
      <=H_m=m^m*4^(m-1)*rho^(m*(m-1)).                (1)

For m=2 the right side is exactly L^2. A strict reverse inequality would
therefore certify a visit. The rotation improves the earlier two-interval
construction, whose capacity factor was sqrt(1-4d^2)/4. Canonical floors
are retained throughout.

If q_i are reduced denominators, V*product_i q_i^(m-1) is an integer,
where V^2=Delta. Distinctness gives only
Delta>=product_i q_i^(-2(m-1)). For consecutive indices the known
log q_n=6n+o(n) makes this generic bound far smaller than (1). More
significantly, much of the cost survives in the actual reduced product.

Take consecutive indices N,...,N+m-1 with m=O(sqrt N). Start with primes
p>2(N+m)+1 in the support p=1 mod4, p<=8N+5 or p=3 mod4, p<=4N+3.
The earlier [prime-survival result](m4-prime-compression.md) gives
v_p(S_N)=-1 for sufficiently large N; their total prime-log mass is
4N+o(N), using the assessed fixed-progression PNT. Remove primes dividing
any new denominator 8(N+s)+r, 1<=s<m, r=1,4,5,6. This costs
O(m log N)=o(N). Also remove primes with ord_p(16)<m. Their product
divides product_(r=1)^(m-1)(16^r-1), so their prime-log mass is less than
(log16)*m*(m-1)/2. No conjectural large-order estimate is used.

For every retained prime, write S_(N+i)=16^i*S_N+B_i with B_i p-integral.
For any fixed rational rotation theta and k_i=floor(S_(N+i)+theta),

    x_j-x_i=(16^j-16^i)*S_N+B_j-B_i-(k_j-k_i).

The first coefficient is a unit and the remaining terms are integral.
Every pair difference therefore has valuation -1, proving distinctness
and v_p(Delta)=-m(m-1). Consequently

    log den(Delta)>=m(m-1)*[4N-(log16)*m(m-1)/2+o(N)]. (2)

For m=o(sqrt N) this is (4+o(1))*N*m(m-1); for m~c*sqrt N it remains
positive when c<sqrt(8/log16). The error is uniform for bounded m/sqrt N.
This is an actual denominator lower bound, not an upper bound on Delta.
It shows why a nonzero numerator alone supplies too weak a guarantee;
a sufficiently large actual numerator is not ruled out.

Longer blocks retain a precise floor-dependent term. If p^2>8(N+m-1)+6,
put u_i=p*S_(N+i) mod p and retain every pole event in
u_(i+1)=16u_i+p*A(N+i+1) mod p. For noncollision pairs u_i!=u_j,
the canonical difference has valuation -1. For collision pairs put

    t_ij=v_p(S_(N+j)-S_(N+i)-(k_j-k_i))>=0.

Unless a difference is zero, the exact identity is

    v_p(Delta)=-2*(number of noncollision pairs)
                         +2*sum_(collision pairs)t_ij. (3)

For N=lambda*p, m=p, fixed positive integer lambda, the fixed-scale
survival theorem gives nonzero u_i eventually. There are at most four
new pole events, hence five geometric segments. With d_p=ord_p(16),
each residue occurs at most p/d_p+5 times. There are at most
p^2/(2d_p)+2p collisions, so almost every pair is a noncollision since
16^d_p>=p+1. But the available individual bound t_ij=O(p/log p)
leaves a possible total O(p^3/(log p)^2), too large to discard in (3).
This describes the insufficient bound, not the size of the actual sum.

An exact-A free-entry countertest illustrates why raw precision does not
control this sum. At entry N=2 choose p=17,
B=16A(3)+A(4) and t=(1-B)/255=231561356/90067217625. Then
256t+B=t+1 and v_17(t)=-1. For any K>=1, perturb t by either
17^K/(256*17^(K+1)+1) or 17^K/(2*17^K+1). Both perturb every raw
state by valuation K. The first preserves the endpoint floors and yields
a canonical endpoint difference of valuation K+1; the second changes the
final floor by an integer between 124 and 128, giving valuation zero.
This loses global initialization and a fixed denominator cap as K grows.
It refutes a local transfer from raw precision, not an estimate using
all actual initialized data. The null state D also has many negative
pair valuations while tending to zero in the real place.

A separate geometric limitation defeats ordinary consecutive determinants
for narrow gaps even in a favorable model. If the empirical measures of
the particular tested blocks tend weakly to uniform measure on [0,1],
truncate log|x-y| below at -T. The resulting continuous kernel gives

    limsup log Delta/m^2<=integral_0^1 integral_0^1 log|x-y| dx dy=-3/2.

By (1), log H_m/m^2 tends to log(L/4). When L>4*exp(-3/2), the strict
certificate fails for all sufficiently large such blocks. Fixed-start
prefixes of an equidistributed sequence meet this empirical hypothesis;
arbitrary moving windows need not. This does not assert pi's distribution,
exclude a fortuitous finite block, or exclude selected subsequences.
It motivates changing the kernel before extending this determinant route.

## A finite circle-product certificate

For canonical rational states x_i, use the rotation-invariant product

    R_m=product_(i<j)[abs(x_j-x_i)*(1-abs(x_j-x_i))]^2.

Coincidences give R_m=0 and are treated separately. Otherwise its logarithm
is the off-diagonal sum of the periodic kernel K(t)=log(t(1-t)), 0<t<1.
Its mean is -2 and its nonzero Fourier coefficient at h is -kappa_h, where

    kappa_h=Si(2*pi*h)/(pi*h)>0, h>=1.

Integration by parts gives the coefficient. Pairing each positive sine
half-wave with the next negative one proves positivity, since the weight
1/u decreases. For 0<r<1, convolution with the Poisson kernel gives the
absolutely convergent series

    K_r(t)=-2-2*sum_(h>=1)kappa_h*r^h*cos(2*pi*h*t).

The singularity requires explicit control. Write
K(t)=log|1-exp(2*pi*i*t)|+g(t). The remainder g extends to a function
on the circle with Lipschitz constant 2 and g(0)=-log(2*pi). One direct
proof bounds its derivative on 0<t<=1/2 using
sin x-x*cos x=integral_0^x u*sin u du<=x^3/3 and sin(pi*t)>=2t;
the pinned bound pi<3.15 gives -2<=g'(t)<2. Symmetry handles the rest.
Poisson smoothing therefore satisfies, off the singular point,

    K(t)<=K_r(t)+epsilon_r,
    eta_r=(1-r^2)/(8r)*log(1+4r/(1-r)^2),
    epsilon_r=eta_r-(log r)/2 ->0,
    -K_r(0)<=D_r=log(2*pi/(1-r))+eta_r.                (4)

The estimate for eta follows by integrating the Lipschitz bound against
the Poisson kernel and using sin(pi*t)>=2t. The logarithmic term follows
from |1-r*e(t)|^2=(1-r)^2+r*|1-e(t)|^2. The convolution identity for
log|1-e(t)| follows first for radius s<1 from a geometric series, then
by L1 convergence as s increases to one. No pointwise Fourier assertion
at the singularity is required.

Use the existing [finite minorant](m4-transform-phases.md) for an inner
interval of the target:

    F(t)=mu0+2*Re sum_(h=1)^H f_h*exp(2*pi*i*h*t), mu0>0,

with F<=0 outside that interval. For the empirical measure nu of m points
avoiding the target, Cauchy–Schwarz gives

    integral integral K_r(x-y) dnu(x)dnu(y)<=-2-delta_r,
    delta_r=mu0^2/(2*sum_(h=1)^H |f_h|^2/(kappa_h*r^h))>0.

In removing the diagonal, its cost must be added, not discarded. Thus

    log R_m/m^2<=-2-delta_r+D_r/m+epsilon_r*(1-1/m).   (5)

Choose r sufficiently close to one that epsilon_r<=delta_r/4; delta_r
has a positive limit. Then fix m0=max(2,ceil(4D_r/delta_r)) and
gamma=delta_r/2. Every avoiding configuration with m>=m0 satisfies

    R_m<=exp(-(2+gamma)*m^2).                         (6)

The strict reverse inequality is a finite visit certificate. Parameters
are chosen in the order target, minorant, fixed r, then m0. Selected
indices must all exceed the requested threshold. This preserves every
interval and threshold and uses the checked recurrence index n+1 directly;
vanishing tail error is not substituted for visits.

Uniform rational grids j/m have the exact product

    R_m=[((m-1)!)^2/m^(2(m-1))]^m,
    -2<log R_m/m^2<=-2+2*(log m+1)/m.

They pass every fixed threshold in (6). This corrects the ordinary
determinant's equilibrium mismatch. But weak equidistribution still does
not supply a product lower bound. For N=m^3, the m distinct points

    {0,16^(-N)} union {j/(m-1):1<=j<=m-2}

approach uniform measure, while their one close pair gives
log R_m/m^2<=-2*m*log16, tending to minus infinity. Their common denominator
divides 16^N*(m-1)<=16^(2N), with logarithm less than 6N. Thus even a
BBP-sized scalar denominator cap does not remove this instability. Fixed
finite character tests eventually pass on these configurations while this
product fails. They are not actual A states; the test shows an additional
anti-clustering requirement, rather than a weaker route to the same estimate.

## The exact circle numerator remains uncontrolled

For largest selected index M, let Q=L_M be the explicit odd clearing lcm,
with log Q=6M+o(M). Set a_i=Q*fract(S_(n_i)), d_ij=abs(a_j-a_i), and
P=product_(i<j)d_ij*(Q-d_ij). Then

    R_m=P^2/Q^(2*m*(m-1)).

For distinct states P is a positive integer. The actual missing estimate is

    log P>m*(m-1)*log Q-(1+gamma/2)*m^2               (7)

for one sufficiently large selected block beyond each requested threshold.
Integrality P>=1 is far too weak. Every a_i retains its canonical floor.
At each prime retained in (2), both a canonical gap and its circle
complement have valuation -1. Thus

    log den(R_m)>=2*m*(m-1)*[4N-(log16)*m*(m-1)/2+o(N)],

and for m=o(sqrt N) the cost is (8+o(1))*N*m*(m-1). Each such p has
valuation one in Q and contributes no factor to P. This is still a
denominator lower bound, not an upper bound on the actual product.

For the actual null state, 0<U_n<1/(16n+18) implies
R_m(D)<=(16N+18)^(-m*(m-1)) for indices at least N. Its strong arithmetic
constraints coexist with that small product. Previously assessed null gauges
can preserve the pi period and zero initialization while making a prescribed
finite block coincide; they change the forcing. Neither comparison supplies
a counterexample to V, but both reject a generic inference to (7).

The next changed test is the bounded rational circle energy t(1-t).
It avoids exceptional-pair instability and has denominator dividing m^2Q^2.
Whether an actual lower bound follows from any new arithmetic input, rather
than merely restating weighted Fourier cancellation, is an open investigation.

## A bounded energy removes the close-pair instability

Put psi(t)=fract(t)*(1-fract(t)) and, for any m>=2 points on the circle,

    E=(1/m^2)*sum_(i,j) psi(x_i-x_j).

This continuous kernel is 1-Lipschitz and has no logarithmic singularity.
For representatives x_i in [0,1), let F(t)=#{i:x_i<=t}/m,
H(t)=F(t)-t, and hbar=integral_0^1 H=1/2-mean(x). Finite indicator
integration gives the exact identity

    E=1/6-2*integral_0^1 (H(t)-hbar)^2 dt.             (8)

If the points avoid (a,b), of length ell, F is constant on that interval.
The integral of any squared affine function of slope -1 over length ell
is at least ell^3/12. Thus

    avoidance implies E<=(1-ell^3)/6.                 (9)

A strict reverse inequality for one actual block beyond every threshold
would prove V, including endpoint intervals. This translation-invariant
certificate is stronger than a visit to one specified interval: it
excludes every hole of that length. Bound (9) is sharp among probability
measures. On the allowed interval [0,1-ell], take Lebesgue density 1
and atoms of mass ell/2 at its endpoints. This statement does not assert
attainment by a finite empirical measure.

For sorted x_0<=...<=x_(m-1), another exact form is

    E=(m^2-1)/(6*m^2)
       -(2/m)*sum_i (x_i-mean(x)-(i-(m-1)/2)/m)^2.

Uniform grids maximize E; weak convergence to uniform measure gives
E->1/6. An exceptional close pair no longer defeats that implication.
For common denominator Q and sorted canonical integers a_i=Q*x_i,

    T=Q*sum_i (2*i-m+1)*a_i-m*sum_i a_i^2+(sum_i a_i)^2,
    E=2*T/(m^2*Q^2).

The missing actual inequality is T>(m^2*Q^2/12)*(1-ell^3). Nonnegative
integrality of T supplies no constant-size lower bound of this strength.

The actual denominator can be bounded without an order hypothesis. At
a surviving prime p>2*(N+m)+1 with no new forcing pole, write
p*x_(N+j)=16^j*c mod p, c a unit. For p not dividing m,

    p^2*E=-2*c^2/m^2 * B_m mod p,
    B_m=m*sum_j 16^(2j)-(sum_j 16^j)^2
       =sum_(i<j)(16^j-16^i)^2>0.

Primes dividing B_m have total log mass O(m+log m). Removing these
and the new forcing poles leaves mass 4N+o(N) for m=o(N/log N).
Therefore log den(E)>=(8+o(1))*N. This is a denominator lower bound,
not an upper bound on the real energy. At a complete multiplicative
order m=ord_p(16)>2 the displayed B_m vanishes mod p instead; the
next term depends on canonical ranks and carries.

Three proposed ways to estimate T retain that missing information.
The exact transfer of psi under multiplication by 16 contains the
integer k=floor(16*delta+A(i+1)-A(j+1)), its square and its correlation
with delta. Energy can either increase or decrease even without forcing.
Complete-seed averaging gives Bernoulli distribution identities, but
averages away the actual initialized seed. Finally, for 0<h<=1/2,

    psi(t+h)+psi(t-h)-2*psi(t)+2*h^2
        =2*max(0,h-dist(t,Z)).

This local tent detects an interval, but its quadratic bulk cancels
exactly; the required estimate again concerns actual branch crossings.
The null state has E<=1/(16*N+18)->0 and supplies no positive lower bound.

The assessed primary source is
[Hall--Wilson--Zagier, pp.389--391](https://people.mpim-bonn.mpg.de/zagier/files/acta/73-4/fulltext.pdf).
Its Bernoulli distribution formula averages a complete positive-integer
residue system; its Dedekind reciprocity uses complete coprime residue sums.
Neither is a theorem about the selected BBP seed. The formulas above have
separate finite-indicator/polynomial derivations in the frozen packet
`/tmp/pi-m4-bernoulli-consumer-20261127/`, report SHA-256
`3ba29023c1cce419778a775336e10db92c29e60af388efd4b4108902171622a3`.
The parent read the full report/checker/critic, inspected the source pages,
and replayed an unchanged checker copy: exit 0, identical receipt and
unchanged originals. Synthetic and principal-part checks do not establish
the actual T inequality or V. Integration review is recorded separately.

## Height retains a local selection weight

For a reduced rational z=p/q, h(z)=log max(|p|,q). The actual period and
denominator asymptotic give

    h(S_n)=(6+log16)*n+o(n),
    h(fract S_n)=6n+o(n).

Canonical reduction removes exactly log S_n once S_n>1. Dividing by
16^n instead moves that contribution into the dyadic denominator:
den(S_n/16^n)=q_n*2^max(4n-v_2(n+1),0). Neither operation gives points
of small absolute height. Normalizing the energy by n would also shrink
the fixed avoidance gap to zero. The
[null-state calculation](m4-prime-compression.md#the-actual-null-state-has-denominator-exponent-eight)
gives h(U_n)=8n+o(n) despite energy tending to zero. Rational positive
coboundaries retain nonzero raw growth but have only polynomial canonical
denominators. These examples do not preserve all actual A data at once.

There is an exact neighboring source connection:
[Baker--Petsche, arXiv v1, Theorem 8, p.13](https://arxiv.org/pdf/math/0507228v1)
bounds global elliptic discrepancy for m distinct algebraic points by
4 times their average canonical height plus
[0.5*log m+h(j_E)/12+16/5]/m. Global discrepancy weights each local
term by [K_v:Q_v]/[K:Q], for a field containing the points and giving
semistable reduction. At a multiplicative place its nonnegative skeleton
term uses the periodic Bernoulli polynomial (pp.9--11).

To map our kernel exactly, fix E over Q with split multiplicative reduction
at p and Tate parameter q_E. Put c=-log|q_E|_p>0. A rational phase x=a/q
can be represented by the torsion point with Tate parameter q_E^(a/q).
Its coordinates are algebraic over Q because it is q-torsion, even though
the Tate parameter is a local analytic object. Its skeleton retraction is
x modulo 1, and the selected points have discrepancy

    D_j=(c/2)*(1/6-Energy).

All these points have canonical height zero. The source theorem supplies
only

    w_v*(c/2)*(1/6-Energy)
       <=[0.5*log m+h(j_E)/12+16/5]/m,
    w_v=[K_v:Q_p]/[K:Q].

No sufficient lower bound on this selected weight has been proved. For
an exact countertest, at one fixed p-adic embedding choose the torsion
points represented by q_E^(j/m^2), 1<=j<=m. They are distinct, their
energy is at most 1/m, and their canonical heights are all zero. Their
containing number fields vary with m. Dropping w_v would contradict this
example; taking a full Galois orbit changes the selected phases. Also a
point with reduced retraction denominator q requires q|e_v*ord_p(q_E),
so its containing field cannot simply be held fixed for BBP denominators.
This degree lower bound is not itself a useful bound on w_v.

The assessed v1's Proposition 9 is not used: its printed arbitrary-subset
statement omits the Galois stability invoked in its proof. The weighted
Theorem 8 is sufficient for the comparison above. A publisher-version fetch
was inaccessible, so no claim about later wording is made. Parent source
inspection covered the exact theorem, kernel, weights and surrounding proof.
The frozen height packet cited in the null-state note retains source pages,
contract, criticism and checker. Its unchanged-copy replay passed with an
identical receipt. This encoding discards integer growth and does not supply
the actual canonical numerator lower bound; an unweighted transfer is suspended.

## Evidence and research boundary

The initial frozen packet `/tmp/pi-m4-direct-avoidance-20261127/` has
report SHA-256
`36956c5cec0bdf26cb99c1faaaaf9e4ce671deca0970a6905e928fef367f9267`.
The improved and longer-block packet is
`/tmp/pi-m4-determinant-long-20261127/`, report SHA-256
`21822b8dd9b0d408329b72703b5c8f3053ddc3fb4c8277680e995930238b960d`.
The parent read both reports/checkers and reconstructed the claims above.
Unchanged-copy checker replays exited 0 with byte-identical receipts,
preserving all original hashes. The first checks polynomial identities,
synthetic bounds, integer scaling and principal parts. The second checks
32 carry perturbations, 96 raw congruences, 2,592 initialized modular
steps, 1,333 A collision pairs, 36,012 D pair valuations, 29 small-order
products and the improved Chebyshev bounds. These do not prove asymptotic
or analytic statements. Actual A fractional states and pi digits were not
searched. The exact null-state checks use its established real bound.

The circle packet `/tmp/pi-m4-circle-energy-20261127/` has report SHA-256
`50d32c23bbc98995a418f01557723983607733e94337a61192bd99ffeb89f26f`.
It retains the full smoothing derivation, a concrete certificate for
(1/6,5/6), exact checker and separate same-session criticism. The parent
read the full report/checker and reconstructed the coefficient, smoothing,
diagonal, parameter-order, grid and clustering arguments. The finite checks
cover 15 grid products, 45 rotations, 63 local factor valuations, 30 product
valuations, 20 modulus identities, seven parameter inequalities and seven
clustered examples. Its unchanged-copy parent replay exited 0 with an identical
receipt and preserved originals. Independent changed-file review found no
D/I/Q items. Synthetic checks and paper review do not supply (7) for actual
A states or a Lean certificate.

The unresolved implication is an A-specific numerator or signed estimate
strong enough to force a finite visit certificate after every threshold.
Large actual denominators and stronger raw congruences do not provide it.
This is missing mathematics, not a compiler problem or an accepted M4 result.
