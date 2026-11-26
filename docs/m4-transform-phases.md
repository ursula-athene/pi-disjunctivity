# M4 transform phases and their remaining arithmetic input

This 2026-11-26 paper assessment tests Mellin reflection and Gaussian modular
inversion against the actual phase pi*16^n. It supplies no new Lean theorem.
The [proof plan](proof-plan.md#5-prove-the-missing-universal-visitation-theorem)
retains V; the [review record](agy-reports/m4-continuation-review.md) owns review
status. The separate [sampling assessment](m4-generating-functions.md#analytic-sampling-finite-differences-and-the-complementary-phase)
concerns interpolation of floors, not the transforms below.

## A sufficient estimate for one finite block

Put x_n=pi*16^n=S_n+E_n, with the actual positive B3 tail E_n tending to zero.
For 0<=a<b<=1 set d=b-a, c=(a+b)/2, delta=d/4 and C=cos(2*pi*delta).
Choose a positive integer m with m/(m+1)>C and define

    F(t)=((1+cos(2*pi*(t-c)))/2)^m
           *(cos(2*pi*(t-c))-C)/(1-C).

This trigonometric polynomial is at most the indicator of
J=(c-delta,c+delta) on the circle, and F(t)>0 implies fract(t) in J.
It is at most 1 inside J and nonpositive outside. Writing

    w_j=4^(-m)*binom(2m,m+j) for abs(j)<=m, and 0 otherwise,
    d_j=((w_(j-1)+w_(j+1))/2-C*w_j)/(1-C),
    mu=d_0=4^(-m)*binom(2m,m)*(m/(m+1)-C)/(1-C)>0,
    K=m+1, B=sum_(k=1)^K abs(d_k)>0,
    T_(N,L)(k)=sum_(n=N)^(N+L-1) exp(2*pi^2*i*k*16^n),

the finite Fourier identity gives

    sum_(n=N)^(N+L-1) F(x_n)
      =mu*L+2*Re sum_(k=1)^K d_k*exp(-2*pi*i*k*c)*T_(N,L)(k).

Thus the following **unproved** estimate is sufficient for a visit:

    abs(T_(N,L)(k)) < mu*L/(2B) for every 1<=k<=K.        (CANC)

Since F is negative somewhere outside J, its Fourier expansion also gives
mu<2B. Thus this sufficient cancellation ratio lies strictly between 0 and 1.

Given any original threshold, first choose N beyond it with E_n<delta for
all n>=N. A positive term then has fract(x_n) in J, so subtracting E_n stays
strictly inside (a,b) and (0,1), and equals fract(S_n). This keeps the actual
recurrence offset n+1 and handles a=0 and b=1. It needs one suitable finite
block per interval and threshold, not equidistribution of the entire orbit.

For example C=3/4, m=4 and c=1/2 give d_0,...,d_5 equal to
7/128, 7/64, 11/64, 17/128, 13/256, 1/128. Here CANC is the five-mode
bound abs(T(k))<(7/121)*L. No such cancellation bound has been established.

## Reflection returns the same floor threshold

For Re z>0, use the principal logarithm and Q(z)=-Log(1-exp(-z)).
Its Mellin kernel is Gamma(s)*zeta(1+s), initially Re s>0. The
[zeta functional equation](https://dlmf.nist.gov/25.4.E2) and
[Gamma reflection](https://dlmf.nist.gov/5.5.E3) give the meromorphic identity

    Gamma(s)*zeta(1+s)
      =-pi*(2*pi)^s*zeta(-s)/(s*sin(pi*s/2)).

Shift to -2<Re s<-1 while retaining Re z>0. The double pole at 0 contributes
-Log z; the pole at -1 contributes z/2. The simple-pole coefficient at 0
vanishes before multiplying by z^(-s). Absolute convergence and analytic
continuation in the right half-plane give

    Q(z)=-Log z+z/2-sum_(r>=1) Log(1+(z/(2*pi*r))^2).      (1)

The same identity follows from the [sine product](https://dlmf.nist.gov/4.22.E1).
Each logarithm is analytic there; the series is locally uniformly convergent.
The frozen report supplies contour majorants using the
[vertical Gamma bound](https://dlmf.nist.gov/5.11.E9) and
[Euler--Maclaurin formula](https://dlmf.nist.gov/25.2.E9).

For z=epsilon-2*pi*i*x and noninteger x>0, let epsilon decrease to zero.
In (1), -Log z contributes imaginary part pi/2, z/2 contributes -pi*x,
and each integer 1<=r<x contributes +pi. The negative factors are approached
from below; reversing that side reverses the count incorrectly. The tail
converges locally uniformly at this noninteger boundary point. Consequently

    lim Im Q(epsilon-2*pi*i*x)
      =pi/2-pi*x+pi*floor(x)=pi*(1/2-fract(x)).             (2)

At x=pi*16^n the threshold r<x is the original unknown floor. Reflection
absorbs a Fourier normalization factor, but leaves the physical pi in the
threshold. The integer boundary has a half contribution from r=x and total
imaginary limit 0; it is not an ordinary strict-interval indicator.

The regularization cost also remains. For noninteger x,

    abs(Q(epsilon-2*pi*i*x)-Q(0+-2*pi*i*x))
      <=epsilon/(2*abs(sin(pi*x))).

At the n-th orbit point the epsilon from a common z is multiplied by 16^n.
A long-block estimate therefore needs additional phase control. Direct
Mellin inversion of exp(-(epsilon-2*pi^2*i*k)*16^n) has approximation error
at most epsilon*16^N*(16^L-1)/15 over a block. Its geometric factor
sum 16^(-ns) is entire; quotient-form singularities are removable. As epsilon
vanishes, one half-line loses the Gamma exponential decay, so the initial
absolute-integral bound cannot be used uniformly at the boundary.

## Gaussian inversion retains the sparse selection cost

For Im tau>0, [theta inversion](https://dlmf.nist.gov/20.7.E32) states

    Theta(tau)=(-i*tau)^(-1/2)*Theta(-1/tau),
    Theta(tau)=sum_(r in Z) exp(pi*i*tau*r^2),

with the principal square root. Setting tau=2*pi*k+i*v and selecting r=4^n
produces the damped target terms. The identity sums over all integers r;
it supplies no bound for that selected subset. Alternatively, moving 16^n
into tau_n=2*pi*k*16^n+i*v still requires extraction of r=1. Even the full
sum does not decay just because its prefactor does: the dual imaginary part
is v/abs(tau_n)^2 and its Gaussian scale is abs(tau_n)/sqrt(v). Explicitly,

    abs(Theta(tau_n))
      <=abs(tau_n)^(-1/2)+abs(tau_n)^(1/2)/sqrt(v).

This rejects the prefactor-only argument. It does not rule out modular
methods that prove a new bound for the sparse selection and actual phase.

## Evidence for the transform identities

Parent reconstruction, official-source inspection and checker replay passed.
The exact checker covers 65 Laurent families, 260 means, 168 geometric sums
and 1,700 rational branch cases, without pi digits or empirical orbit tests.
These finite checks do not certify the analytic or universal statements.
Frozen report `/tmp/pi-m4-mellin-phase-20261126T223305Z-report.md`, SHA-256
`0bd5453bb1efee258b123f8f9a631c32824e98a77bdbcbc4ffb4417ce50ff86e`,
has sibling checker, result receipt, source receipt and SHA256SUMS manifest.

The endpoint wording in the frozen report has a separate clarification:
`/tmp/pi-m4-sparse-gauss-20261126T224735Z-prior-erratum.md`. At a=0,b=1,
coincident circle endpoints add two halves to 1 in the Abel expression;
this is not a strict full-circle indicator. The smaller-interval minorant
above avoids that issue. The independent review accepted the clarification.

## Absolute Gauss completion cannot help at odd squarefree moduli

Approximate alpha=k*pi by a reduced fraction a/q. An approximation to the
theta parameter 2*k*pi must first be divided by 2 and reduced. Put

    e_q(t)=exp(2*pi*i*t/q),
    M(r)=#{n in [N,N+L): 4^n=r mod q},
    Mhat(h)=sum_r M(r)*e_q(-h*r),
    Lambda=(1/q)*sum_h abs(Mhat(h)),
    G(a,h;q)=sum_r e_q(a*r^2+h*r).

The mask includes multiplicities, so no distinctness of the powers is assumed.
Finite Fourier inversion gives

    S=sum_(n=N)^(N+L-1) e_q(a*16^n)
     =(1/q)*sum_h Mhat(h)*G(a,h;q),
    abs(S)<=C_q:=(1/q)*sum_h abs(Mhat(h))*abs(G(a,h;q)).    (3)

A lower bound on C_q limits this upper-bound method, not the actual sum S.
For odd q, completing the square gives abs(G)=sqrt(q), hence C_q=sqrt(q)*Lambda.
If q>2*4^(N+L-1), the additive energy of the mask is 2L^2-L by uniqueness
of base-4 pair sums. The normalized second/fourth Fourier moments and Holder
give sqrt(L/(2-1/L))<=Lambda<=sqrt(L). Aliased masks need not satisfy this.

A stronger obstruction needs no nonaliasing assumption: if q>1 is odd and
squarefree, let chi_q be the product of its Legendre characters. Its additive
Fourier transform has magnitude sqrt(q) at unit frequencies and zero elsewhere.
This follows by CRT from the elementary prime calculation abs(chihat_p(1))^2=p.
Every selected 4^n has chi_q(4^n)=1. Finite Parseval therefore gives

    L=sum_r M(r)*chi_q(r)
      <=sqrt(q)*(1/q)*sum_h abs(Mhat(h))=C_q.              (4)

Thus absolute completion cannot prove any strict bound below L at these
moduli. For q=1, C_q=L directly. For a general odd q>1, lifting the primitive
character modulo rad(q) gives only

    C_q>=L*sqrt(rad(q)/q).                                (5)

The limitation is real: q=27,N=0,L=9 has a mask equal to the indicator of
1 modulo 3, Lambda=1 and C_q=sqrt(27)<9. This is a scope counterexample,
not a full-period transfer argument for pi.

For even q and reduced a, direct squaring gives

    abs(G(a,h;q))^2=q*(1+(-1)^(q/2+h)).

The active frequencies have h congruent to q/2 modulo 2. Their inverse
projection is (M(r)+M(r+q/2))/2 when 4 divides q and
(M(r)-M(r+q/2))/2 otherwise. For N>=1 the mask is supported on even residues,
and a nonzero projected entry has absolute value at least 1/2. Consequently
C_q>=sqrt(q/2). The same holds for N=0,L>=3; the zero-projection exceptions
are exactly N=0,L=2,q in {2,6}. These must be retained when reindexing.

## Approximation cost and the moving-start limitation

For Delta=abs(k*pi-a/q), the termwise replacement certificate is

    abs(T_(N,L)(k)-S)<=E(Delta)
      :=sum_(n=N)^(N+L-1) min(2,2*pi*Delta*16^n)
      <=(2*pi/15)*Delta*16^N*(16^L-1).                    (6)

The [Zeilberger--Zudilin manuscript](https://sites.math.rutgers.edu/~zeilberg/mamarim/mamarimPDF/pimeas.pdf)
proves an irrationality exponent below 8. Its definition on PDF page 1 and
conclusion on page 13 imply a constant c>0 with abs(pi-p/q)>=c*q^(-8)
for all integers p and q>=1, after absorbing finitely many denominators.
No effective c or current-optimality claim is needed. Thus
Delta>=c*k^(-7)*q^(-8).

Fix 0<rho<1. If E(Delta)<=rho*L and R=floor(rho*L/2), the last R+1 terms
cannot all equal 2. Therefore

    Delta<pi^(-1)*16^(-(N+L-R-1)),
    q>(pi*c*k^(-7))^(1/8)*16^((N+L-R-1)/8).              (7)

Together with C_q>=sqrt(q/2), this defeats the unreduced absolute-completion
certificate at sufficiently late N, uniformly in L for fixed k,rho.
It concerns the displayed termwise error bound; possible cancellation in
the replacement error itself is outside this argument.

However, first factoring 16^N reduces the effective modulus to
Q=q/gcd(q,16^N). Completion then concerns S=sum_(j=0)^(L-1)e_Q(A*16^j),
where A=a*16^N/gcd(q,16^N). The correct scaled lower bound gives only

    Q>(pi*c)^(1/8)*(k*16^N)^(-7/8)*16^((L-R-1)/8).        (8)

For each fixed N this defeats asymptotically long blocks; its constant
deteriorates with N. It does not exclude all adaptive starts. If effective
Q is odd squarefree, (4) still gives the uniform obstruction C_Q>=L. If Q
has repeated prime powers, neither (5) nor (8) settles every moving block.
An effective modulus 1 likewise gives C_Q=L, not cancellation.

Keeping the Gauss phases does not itself create a new estimate. For odd q,
G(a,h;q)=G(a,0;q)*e_q(-(4a)^(-1)*h^2). Substituting Mhat and completing
the square again recovers exactly the original sum S. The geometric mask
relation Mhat(4h)=Mhat(h)-e_q(-h*4^N)+e_q(-h*4^(N+L)) translates only to
the original orbit's endpoint reindexing identity. A useful phase-sensitive
bound must do more than these exact identities or a full-period estimate.

Parent reconstruction and replay of the exact cyclotomic checker passed,
exit 0: 180 energy cases, 7,043 Gauss modulus cases, 304 character transforms,
1,280 parity cases, 216 completion identities and the q=27 counterexample.
The parent visually inspected source pages 1 and 13; PDF and rendered pages
are retained under `/tmp/pi-m4-transform-sources-20261126/pimeas*` with a
manifest. Frozen report `/tmp/pi-m4-sparse-gauss-20261126T224735Z-report.md`,
SHA-256 `1fa76a62525c7a51a352c328a69c30c0013d33a0e7428ffc6c874d25597ee64e`,
has checker, receipts and hash-manifest siblings. Finite consistency checks
are not proofs of the universal statements or V. This extension passed
independent review with no D/I/Q items; no Lean, audit, dependency or pin changes.
