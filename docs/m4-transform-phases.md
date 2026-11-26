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

## Evidence and next discriminating question

Parent reconstruction, official-source inspection and checker replay passed.
The exact checker covers 65 Laurent families, 260 means, 168 geometric sums
and 1,700 rational branch cases, without pi digits or empirical orbit tests.
These finite checks do not certify the analytic or universal statements.
Frozen report `/tmp/pi-m4-mellin-phase-20261126T223305Z-report.md`, SHA-256
`0bd5453bb1efee258b123f8f9a631c32824e98a77bdbcbc4ffb4417ce50ff86e`,
has sibling checker, result receipt, source receipt and SHA256SUMS manifest.

The next test concerns the norm and phase cost of extracting r=4^n by finite
Fourier completion at a rational approximation to 2*pi*k. It must retain
approximation error, modulus reduction, parity and the distinction between
fixed and moving block starts. A full rational-period estimate or small
modular prefactor alone would repeat a rejected inference. CANC and V remain
open; no production Lean, audits, dependencies or pins change.
