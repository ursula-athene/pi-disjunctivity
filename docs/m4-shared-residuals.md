# M4: shared tails, primitive lattices and a conditioned triple

Research checkpoint, 2026-11-26; independent review complete. The positive result
constructs three actual degree-two Pade vectors with safe slopes, coefficient
heights exp(2L+o(L)) and primitive evaluated denominator gcd one. This removes
a specific obstruction that every pair retains at the larger budget
16^L times a fixed polynomial. The remaining real separation from a forbidden
tail set is unproved. All results here are paper mathematics, not Lean exports
or M4 acceptance; the exact [V contract](proof-plan.md#5-prove-the-missing-universal-visitation-theorem)
is unchanged.

The explicit diagnostic is the closed omitted-F set

    C={sum_(j>=1) d_j/16^j : d_j in {0,...,14}}.

Its hull is [0,14/15]; c*=1/15 is an allowed point strictly inside that hull.
An enclosure of 16^s*pi disjoint from Z+C would certify a later F occurrence.
This is only a test case for the arbitrary-word target. An actual recurrence
visit also needs the checked B3 error bound and a suitable interior margin.

## Correlated moment bounds contain one exact scalar

Use the [signed-evaluation notation](m4-signed-evaluation.md) at L>=2: local
moments c=A(L-1), b=A(L), a=A(L+1), Delta=ca-b^2>0, monic orthogonal
p1(t)=t-mu and p2(t)=t^2-s0*t+t0, and

    h1=Delta/c, C0=p2(16), D0=p1(16),
    K_j=integral p_j(t)^2/(16-t) d rho_L,
    d rho_L=t^(L-1)*w(t)dt.

The constants satisfy 225<C0<256 and 15<D0<16. Orthogonality gives the
three-term identity p2(t)=(t-(s0-mu))*p1(t)-h1/c. Writing
I0=integral 1/(16-t) d rho_L, one obtains

    K1/D0=D0*I0-c,
    K2/C0=(16-s0+mu)*K1/D0-(h1/c)*I0,
    C0=(16-s0+mu)*D0-h1/c.

Eliminating I0 proves

    C0^2*K1-D0^2*K2=C0*D0*h1.                             (1)

Thus, with Z=K2/C0^2 and kappa(eta)=h1*eta/[C0*(C0-eta*D0)],

    F_L(eta)=Z-kappa(eta),
    rho(eta)=rho(0)+kappa(eta),
    x=16^(L-2)*pi=rho(0)+Z.                              (2)

Two slopes do not give independent remainder variables. Bounds l_j<K_j<u_j
instead give their correlated scalar intersection

    I_L=[l2/C0^2,u2/C0^2]
       intersect [(l1-(D0/C0)*h1)/D0^2,
                  (u1-(D0/C0)*h1)/D0^2].                 (3)

Using the correlation can improve the enclosure. Scalar dependence is not a
theorem against useful simultaneous approximation or improved precision/cost.

## The pair lattice and its necessary common factor

For actual integer Pade vectors Q_i, write V_i=256u_i0+16u_i1+u_i2!=0,
W_i=16b*u_i1+(16c+b)*u_i2 and

    rho_i=(S_L-W_i/V_i)/256=b_i/a_i reduced, a_i>0,
    R_i=a_i*x-b_i.

A common integer part k gives J_i=a_i*k-b_i and R_i-J_i=a_i*tau. With
g=gcd(a1,a2), the integer solutions of the cross-relation are exactly

    a2*J1-a1*J2=a1*b2-a2*b1,
    (J1,J2)=(-b1,-b2)+t*(a1/g,a2/g), t in Z.              (4)

They correspond to k=t/g. The full lattice also retains
J_i=-b_i modulo a_i, equivalent to t=0 modulo g. Dropping this condition
introduces false fractional candidates for the integer part. With it and the
same tau in C retained, the residual condition is exactly x in Z+C. Any
additional finite-prefix condition on k must also be retained.

Put q=den(S_L) and D=lcm(den(A(L)),den(A(L-1))). The
[actual evaluated divisibility](m4-prime-compression.md) q | D*V_i*a_i gives

    q/gcd(q,D*lcm(abs V1,abs V2)) divides g,
    g >= q/[273^2*D*height(Q_1)*height(Q_2)].               (5)

This follows prime by prime, then uses abs(V_i)<=273*height(Q_i).
Since log q=6L+o(L), the budget height(Q_i)<=16^L*poly(L) forces
log g>=(6-2*log 16)*L+o(L), with positive coefficient. This is a joint
constraint, not just a large individual denominator.

Every open interval of width greater than 1/g contains a point c*+t/g.
Such a point in rho(0)+interior(I_L) satisfies the same correlated moment
bounds and both integer residual equations with the single allowed tail c*.
It need not satisfy the omitted common-integer congruence. Every fixed order
of the existing moment bounds eventually has this issue: its endpoints are
rational functions of L, their intersection has strict interior containing
the actual scalar, and their eventual ordering is fixed. The positive
intersection width therefore decays at most polynomially, whereas 1/g
decays exponentially. The exact individual bound width at moment order r is

    integral p_j(t)^2*(1-t)^r d rho_L / (240*15^r).

Increasing r can give arbitrarily small widths; widths below 1/g are not
excluded. Their cost and actual separation from Z+C remain missing. This
obstruction applies only to the relaxed lattice in (4). The full nonconvex
set has genuine gaps, for example (7/120,1/16), that its hull loses.

Products of these residuals add no bound by themselves: the quadratic identity

    R1*R2-J1*J2=tau*(a1*J2+a2*J1)+a1*a2*tau^2

holds automatically at every relaxed witness. The earlier Hankel expressions
are affine in their common initial value. A new integral inequality or separate
pi-squared approximation could still improve a costed scalar enclosure; that
possibility is not ruled out by these algebraic observations.

## Three conditioned actual vectors with gcd one

The pair obstruction can be removed constructively. Write S_L=P/q reduced;
q is odd, and every whole prime-power factor of q is at most B=8L+6 because
q divides the odd part of lcm(1,...,8L+6).

First obtain quantitative safe evaluation coordinates. Set

    w0=-16b*s0+(16c+b)*t0, w1=b^2/c,
    r(eta)=(w0+eta*w1)/(C0-eta*D0).

Then W/V=r(eta), and C0*w1+D0*w0=-256h1 gives r'(eta)<0.
The interval J_L=(r(1),r(-1)) corresponds precisely to -1<eta<1 and has width

    w_L=512h1/(C0^2-D0^2)>0.                              (6)

Its midpoint m_L, its width and its reciprocal are fixed rational functions
of L, with polynomially bounded numerator/denominator sizes. This supplies
the cost of conditioning, beyond mere positivity of the width.

Partition whole prime-power factors of q into three products q_1*q_2*q_3=q
by always assigning the next factor to a smallest current product. The q_i
are pairwise coprime and max q_i<=B*q^(1/3): before the last factor f of a
maximal final group is assigned, that group is at most (q/f)^(1/3), so its
final size is at most q^(1/3)*f^(2/3). Empty groups are allowed.

Choose distinct primes k_i>B and k_i>256/w_L, all polynomial in L.
Bertrand's theorem gives them in successive intervals above K,2K,4K for an
integer K exceeding both bounds, hence k_i<=8K. The exact pinned declaration
`Nat.exists_prime_lt_and_le_two_mul` was inspected in
`Mathlib/NumberTheory/Bertrand.lean`; no new Lean interface is claimed here.

Set V_i=k_i*q_i and Q_i^*=q/q_i. Choose W_i in the congruence class

    W_i = k_i*P*(Q_i^*)^(-1) mod (256*q_i)                 (7)

nearest to V_i*m_L. The inverse exists because Q_i^* is coprime to 256*q_i.
The spacing is 256*q_i, so abs(W_i/V_i-m_L)<=128/k_i<w_L/2. All three
ratios are strictly in J_L. The large actual numerator P is used modulo
256*q_i; it does not become an uncontrolled coefficient height.

The associated evaluations satisfy

    rho_i=[k_i*P-W_i*Q_i^*]/[256*k_i*q],
    a_i=den(rho_i) divides k_i*q/q_i.                     (8)

The first numerator is divisible by the full 256*q_i, retaining every prime
power. Since the k_i are distinct and greater than every prime dividing q,
the three upper denominators in (8) have gcd one; so do the a_i.

To realize these coordinates in the actual Pade family, solve its three linear
equations. The inverse is

    u0=[-b^2*V+(b-16c)*W]/[256*Delta],
    u1=[a*(16c+b)*V+(256c-a)*W]/[256*Delta],
    u2=[(16a-256b)*W-16ab*V]/[256*Delta].                  (9)

The matrix determinant is 256*Delta>0. Formula (9) satisfies
a*u0+b*u1+c*u2=0 and the prescribed V,W. The safe interval forces u0>0
and -1<eta<1. This inverse depends only on local rational moments; clearing
its denominators costs a polynomial in L. Also abs(W_i) is at most
k_i*q_i*abs(m_L)+128*q_i. Thus the resulting integer vectors have heights

    height(Q_i)<=poly(L)*q_i<=poly(L)*q^(1/3)
               =exp(2L+o(L))<16^L eventually.             (10)

Scaling or primitive coefficient reduction changes neither slope nor evaluated
ratio. Equations (8)-(10) prove the construction for every L>=2 and its eventual
height budget; no explicit asymptotic threshold is asserted.

For a triple with gcd(a1,a2,a3)=1, integer residuals and all cross-relations
define one rational k with each a_i*k integral. Bezout then forces k integral.
The false grid is gone. Together with (5), three is the smallest number that
can do this eventually under the stated height budget. No inexpensive Bezout
linear combination is claimed: using those coefficients to create another
auxiliary vector would require its own height analysis.

## What the positive construction still needs

Keeping a common tau in C still asks whether x belongs to Z+C. The actual
correlated scalar enclosure has not been placed in a gap, nor given a uniform
positive separation from that set. The triple removes an arithmetic defect
of a relaxed pair test; it does not prove this missing real-position estimate.
A useful next bound must exploit the common tail and actual moment data at a
favorable cost, not repeat denominator growth or cross-relations. The complete
arbitrary-interval, arbitrary-threshold V contract remains open.

## Evidence

The parent read both reports and checker sources, reconstructed the moment,
lattice and construction proofs, inspected the pinned Bertrand declaration
and reran both checkers, exit 0. Frozen files:

- `/tmp/pi-m4-coupled-tail-report-v3.md`, SHA-256
  `f9c556006112fca6a9c1861a5138332d60e5557540df0378813a195197044b5e`.
- `/tmp/pi-m4-coupled-tail-check-v1.py`, SHA-256
  `5dc5633d34564f4d2d59d62ac92e8c782da477d1b65290c5ee7b04ba8ee9a590`.
- `/tmp/pi-m4-coupled-tail-receipt-v1.json`, SHA-256
  `5b0f585af94205aa27f9ef545a6cbeeac0c0b227745b7a97dcb844a6d4b5aab2`.
- `/tmp/pi-m4-three-residual-report-v1.md`, SHA-256
  `5ec2c752dade8551042a62b571eea5bc5a1adbffc40f08dcc5eb7536a3b4b8b4`.
- `/tmp/pi-m4-three-residual-check-v1.py`, SHA-256
  `b3279f0d8c553992b0c88edb44593c05231428467ff9f1913f6c8958b6fe0ca6`.
- `/tmp/pi-m4-three-residual-receipt-v1.json`, SHA-256
  `58b4733b22257a1df5916db59fe902353550592985de5dafefcd59332d94456a`.

The pair checker covers 95 moment identities, 570 joint divisibilities,
3,990 lattice points, 475 common moment intervals and 2,699 relaxed witnesses.
The triple checker constructs 78 safe actual vectors at 26 anchors, verifying
all full congruences, denominator divisibilities and gcd-one triples. These
finite diagnostics compute no pi digits and do not certify the universal
arguments. Report v3 only corrects v2's phrase "interior point": C has empty
interior; the chosen point lies inside its hull. Both versions are preserved.
The [review record](agy-reports/m4-continuation-review.md) owns independent
criticism and evidence limits. No production Lean, audit or pin changes.
