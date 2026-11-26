# M4: signed remainders and primitive evaluation

Research checkpoint, 2026-11-26; independent review complete. These are paper
proofs and exact finite checks, not Lean exports or M4 acceptance. This extends
the [actual Pade family](m4-pade-residues.md), retaining its coupled coefficients.

The signed remainder has an explicit, well-conditioned formula. Primitive
evaluation also gives a genuine height/denominator tradeoff. Neither supplies
visitation: the safely conditioned family represents every rational in an
explicit interval around the scaled value of pi. Existence of a suitable slope
alone is therefore insufficient. The original congruence prescription cannot
be rescued using only a signed interval for the omitted-digit tail.

## Exact signed formula

Write A(n)=integral_0^1 x^n w(x) dx, where

    w(x)=(1/8)*x^(-7/8)*(4-2*x^(3/8)-x^(1/2)-x^(5/8))>0.

Fix L>=2, H(z)=sum A(n)z^n, Q(z)=u0+u1*z+u2*z^2 with rational coefficients,
P=trunc_L(QH), R=QH-P, and impose

    A(L+1)*u0+A(L)*u1+A(L-1)*u2=0.

For d rho_L=x^(L-1)w(x) dx, put

    c=A(L-1), b=A(L), a=A(L+1), d=A(L+2), e=A(L+3),
    Delta=ca-b^2>0, mu=b/c,
    s0=(cd-ab)/Delta, t0=(bd-a^2)/Delta,
    p1(x)=x-mu, p2(x)=x^2-s0*x+t0,
    h1=integral p1^2 d rho_L=a-b^2/c,
    h2=integral p2^2 d rho_L=e-s0*d+t0*a.

Direct substitution makes p1 orthogonal to constants and p2 orthogonal to
linear polynomials. The positive density gives strict Cauchy--Schwarz and
positive norms. The two roots of p2 are distinct and in (0,1): otherwise
multiplication by the product of its sign-changing factors in (0,1), of degree
at most one, contradicts orthogonality by giving a nonzero constant-sign integral.
Moreover x*p1 is monic quadratic, so orthogonality yields
h2<=integral x^2*p1^2<h1. Consequently, with

    C=p2(16), D=p1(16), K_j=integral p_j(x)^2/(16-x) d rho_L,

we have 225<C<256, 15<D<16, and h_j/16<K_j<h_j/15.

For u0!=0 set eta=-u1/u0-s0. The reversed polynomial is
Q*(x)=u0*(p2(x)-eta*p1(x)). The geometric tail and orthogonality give

    R(1/16)=16^(-L)*integral Q*(x)/(16-x) d rho_L,
    Q(1/16)=Q*(16)/256,
    integral p_j(x)/(16-x) d rho_L=K_j/p_j(16).

For the last identity, multiply by p_j(16) and subtract: division of
p_j(16)-p_j(x) by 16-x leaves a polynomial of degree less than j.
Thus, when eta!=C/D (equivalently Q(1/16)!=0),

    F_L(eta):=16^(L-2)*R(1/16)/Q(1/16)
        =[K2/C-eta*K1/D]/[C-eta*D].                  (1)

For |eta|<=1 the denominator is greater than 209. Its unique zero is
theta_L=(D/C)*(K2/K1), with rational bounds

    0<(15/16)*(D/C)*(h2/h1)<theta_L
        <(16/15)*(D/C)*(h2/h1)<256/3375<1.          (2)

Hence (1) has the sign of theta_L-eta in this interval. If u0=0 and Q!=0,
Q*=u1*p1 instead; Q(1/16)!=0 and F_L=K1/D^2>0. The zero polynomial is excluded.

There are arbitrarily sharp rational enclosures without assuming a sign.
For I_(j,k)=integral p_j^2*(1-x)^k d rho_L>0 and
S_(j,r)=sum_(k<r)(-1)^k I_(j,k)/15^(k+1), the exact finite geometric identity is

    K_j=S_(j,r)+(-1)^r/15^r *
                 integral p_j^2*(1-x)^r/(16-x) d rho_L.

For even r, lower/upper bounds are S+I/(16*15^r), S+I/15^(r+1);
for odd r they are S-I/15^(r+1), S-I/(16*15^r). The lower bound is positive
by the corresponding pointwise resolvent polynomial. Their widths tend to zero.
Ratios enclose theta_L and substitution encloses F_L, respecting the sign of
eta. Order r uses actual moments through A(L+r+3); increasing order incurs
denominator and coefficient costs, with no uniform height bound assumed here.

## Rational evaluation and exact conditioning

Put T=16^L*sum_(j<=L) A(j)/16^j, V=256u0+16u1+u2,
W=16b*u1+(16c+b)*u2. For integer Q and positive coefficient-clearing delta,

    256*16^L*P(1/16)=T*V-W,
    alpha=delta*V, beta=delta*16^L*P(1/16),
    rho=beta/alpha=(T-W/V)/256.

Assume V!=0. After common-gcd reduction and orientation, rho=beta'/alpha'
with alpha'>0 and gcd(alpha',beta')=1. Thus alpha' is the reduced denominator
of rho, independent of delta and scalar rescaling of Q. For M=16^(L-2),
n=floor(M*pi), tau=M*pi-n in (0,1),

    F_L=M*pi-rho, J'(n)/alpha'=n-rho=F_L-tau.       (3)

Primitive reduction preserves F_L. Under permanent omission of F after the
tested position, tau<=14/15. This gives a signed interval for J'; an actual
contradiction still needs its disjointness from admissible residual values.

With w0=-16b*s0+(16c+b)*t0 and w1=b^2/c,

    rho(eta)=[T-(w0+eta*w1)/(C-eta*D)]/256,
    C*w1+D*w0=-256*Delta/c,
    rho'(eta)=h1/(C-eta*D)^2,
    F_L'(eta)=-h1/(C-eta*D)^2.                    (4)

This exact rational derivative sharpens the initial integral conditioning
estimate. The map sends [-1,1] bijectively onto [rho(-1),rho(1)], of width
2*h1/(C^2-D^2). By (2), M*pi lies strictly inside. Every rational point of
this image has rational inverse

    eta=[(T-256rho)*C-w0]/[(T-256rho)*D+w1],

whose denominator is nonzero there, and hence an integer coefficient
representative after clearing denominators. No rational point is excluded
when coefficient height is unrestricted. The linear u0=0 direction gives
rho=(T+w1/D)/256, the projective limit outside this finite slope interval.

More generally, the determinant 256*Delta of the cancellation/evaluation
matrix is nonzero, so every rational rho occurs in the whole family. For an
integral basis of the saturated cancellation kernel, let E be its integer
evaluation matrix and d_E=det(E)!=0. For a primitive pair w, set
z=adj(E)w and h=gcd(z1,z2). Then h divides d_E and the primitive parameter vector
sign(d_E)*z/h maps to (abs(d_E)/h)*w. Saturation makes its coefficient vector
primitive as well. This gives the exact gcd factor and coefficient direction;
the gcd cannot be chosen independently. In particular rho=n has zero J'(n)
and is not a valid nonzero-residual witness.

## A tradeoff for the actual primitive evaluated denominator

Let P_L be the product of primes p=1 mod4 in (4L+3,8L+1], excluding
{8L-7,8L-3,8L+1}. For each remaining prime, v_p(T)=-1: exactly one original
BBP pole occurs through L, since 2p>8L+6. Its index is (p-1)/8 or (p-5)/8,
according to p modulo 8, and no other term can cancel that pole.

The exclusions make a,b,c p-integral. Indeed their factors 2n+1 are below p;
4n+3 cannot equal p=1 mod4 and is below 2p; their remaining odd factors are
below 3p, and the only possible equalities inside the window are the three
excluded boundary values. Therefore W is p-integral. If p does not divide V,
then v_p(beta)=v_p(delta)-1 and v_p(alpha)=v_p(delta), so v_p(alpha')=1.
Otherwise p already divides V. Squarefreeness yields

    P_L/gcd(P_L,abs(V)) divides alpha',
    P_L divides V*alpha',
    height(Q)*alpha'>=P_L/273.                    (5)

This argument holds even without the cancellation constraint. It concerns
primitive evaluation, not merely coefficient clearing. The fixed-progression
PNT on [Sutherland's slide 3](https://math.mit.edu/~drew/PrimeGapsOberwolfach1.pdf#page=3)
gives log P_L=2L+o(L); removing three primes costs only O(log L).
Thus log height(Q)+log alpha'>=2L+o(L). For alpha'=1 this recovers the earlier
interpolation cost. In general a useful consequence needs a compatible upper
bound on height or denominator. Large height alone does not damage the
normalized formula (1); rational slopes may approach theta_L arbitrarily closely.

## Why the old modular certificate also fails with a signed interval

For m>=2, M=16^m, let S_m contain the m-digit integers using only 0,...,14.
The maximum consecutive gap in S_m+M Z is (M+14)/15. Internal gaps after k
trailing digits 14 are (16^k+14)/15 with k<m; the larger cyclic gap runs from
14(M-1)/15 to M. Every open interval longer than this maximum meets the set.

The earlier alpha=1 mod M, beta=31M/32 mod M prescription gives allowed
residual classes S_m-31M/32+M Z and forces abs(alpha)>=M-1. Any interval
containing the full signed range r_Q-alpha*tau for 0<=tau<=14/15 has width

    abs(alpha)*14/15 >=14(M-1)/15 >(M+14)/15.

It must meet those classes, regardless of the centre or sign. Better sign
control alone cannot make this particular certificate empty. This does not
analyze an additional gcd constraint, the exact affine image of admissible n
and its integer part, joint residuals, the full Cantor tail, or other alpha
residues. Those extra restrictions cannot be silently replaced by this larger
periodic class set.

## Evidence and continuation

The parent read and reran all three standard-library exact checkers, exit 0:

- Signed moments: 127 systems, 6,096 envelope cases, 63 orthogonality checks,
  217 independent direct-convolution/tail comparisons including the linear case.
- Primitive evaluation: 1,524 vectors, 28,954 primitive valuations, 889 rational
  interior targets, plus direct convolution and projective inversions.
- Periodic gaps and evaluation rays: 54,240 prefixes and 1,024 primitive rays.

Immutable reports are `/tmp/pi-m4-signed-moment-report-v1.md`,
`/tmp/pi-m4-primitive-evaluation-report-v1.md`, and
`/tmp/pi-m4-primitive-gap-report-v1.md`. The review packet retains their hashes,
full checker sources and caller receipts. Finite cases do not certify the
universal statements; these remain paper arguments. No pi digits were searched.

The exact signed formula and tradeoff improve the available constraints, but
no compatible integer selection theorem or visit follows. Further changes to
the same residue prescription without new constraints are suspended. Current
discovery changes representation to the actual backward 2-adic interpolation
and its reflected anchor, testing the bridge to real fractional parts against
avoiding models. The unchanged V contract and M4 acceptance boundary remain open.
