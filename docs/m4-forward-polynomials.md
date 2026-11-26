# M4: joint forward polynomials and the floor inequalities

Research checkpoint, 2026-11-26; independent review complete. These are paper
arguments and exact finite checks, not Lean exports or M4 acceptance. The
[exact V contract](proof-plan.md#5-prove-the-missing-universal-visitation-theorem)
and the checked recurrence/orbit offset are unchanged.

Write A for the actual BBP coefficient and
S_n=sum_(j=0)^n 16^(n-j) A(j), so y_(n+1)=fract(S_n). The question is whether
permanent exclusion of a word can force an integer-valued polynomial of a
forward block while leaving enough dependence on S_n for its old denominator
primes to contradict integrality. A second test uses Hankel determinants,
whose state dependence and signs can be proved from the positive moment kernel.

## Arithmetic restriction on a short forward block

For n>=1 and 1<=h<=floor(n/2), put

    P_n=product {p prime : p=1 mod4, 4n+3<p<=8n+1},
    R_0=0, R_j=sum_(ell=1)^j 16^(j-ell) A(n+ell),
    L=lcm {denominator(A(n+j)) : 1<=j<=h}.

The exact identities are S_(n+j)=16^j S_n+R_j. Each p dividing P_n has
v_p(S_n)=-1: there is a unique original BBP denominator equal to p, with
coefficient 4 or -1 according to p modulo 8. No other denominator is a multiple
of p. Moreover p divides none of the local coefficient denominators, with no
boundary exceptions. For r=n+j<=3n/2, their four odd factors satisfy

    2r+1<p;
    4r+3<2p, but 4r+3 cannot equal p modulo 4;
    p<8r+1,8r+5<3p, and neither odd number equals 2p.

Thus gcd(P_n,L)=1. The fixed-progression prime number theorem gives
log P_n=2n+o(n); this is a paper use of the
[primary PNT statement](https://math.mit.edu/~drew/PrimeGapsOberwolfach1.pdf#page=3),
not a new Lean result or an O(log n) error bound.

Let F in Z[X_0,...,X_h] have total degree at most d>=1 and coefficient height
H>=1. Restrict it to the forward affine line:

    f(T)=F(T,16T+R_1,...,16^h*T+R_h)=sum_(i=0)^r c_i*T^i.

If its actual degree r is positive, g=L^(d-r)*c_r is a nonzero integer: a
monomial contributing T^r uses at most d-r correction factors. For p|P_n
with p not dividing g, all c_i are p-integral and c_r is a unit. The leading
term at S_n has strictly smallest valuation, namely -r. Hence, for the reduced
denominator q of F(S_n,...,S_(n+h)),

    [P_n/gcd(P_n,abs(g))]^r divides q,
    q*abs(g)^r >= P_n^r.                                      (1)

The original coefficient cost is retained. Since 0<R_j<16^j,

    abs(g)<=L^(d-r)*H*binomial(h+d+1,d)*2^d*16^(h*d).           (2)

If r=d, the leading coefficient is the integer F_d(1,16,...,16^h), with
absolute value at most H*binomial(h+d,d)*16^(h*d); no L factor is needed.
After top-degree cancellation, use (2) instead. For fixed d,
h=o(n/log n) and log H=o(n), the bound L<=[8(n+h)+5]^(4h) makes every
cost subexponential, giving log q>=(2r+o(1))*n whenever r>=1.
An integer or zero evaluation in this sector therefore needs a compensating
coefficient cost. Large denominator alone does not contradict a real inequality.

## A nonlinear family with nonzero state dependence

For k>=2 let H_(n,k)=det[S_(n+i+j)]_(0<=i,j<k). Descending row operations
row_i <- row_i-16*row_(i-1), followed by the analogous column operations, give

    H_(n,k)=det [[S_n, a^T], [a, C]],
    a=(A(n+1),...,A(n+k-1))^T,
    C_ij=A(n+i+j)-16*A(n+i+j-1),  1<=i,j<k.

Thus H_(n,k)=gamma*S_n+beta, with gamma=det C and beta depending only on the
local coefficients. The actual moment density is

    w(x)=(1/8)*x^(-7/8)*(4-2*x^(3/8)-x^(1/2)-x^(5/8))>0,
    A(m)=integral_0^1 x^m*w(x) dx.

For nonzero v, -v^T*C*v is the integral of
x^(n+1)*(16-x)*w(x)*(sum v_i*x^(i-1))^2, which is strictly positive.
Consequently gamma is nonzero with sign (-1)^(k-1). The Schur complement
H_(n,k)/gamma=S_n-a^T*C^(-1)*a is strictly positive, so H_(n,k) has the
same sign. At k=2 this reads

    H_(n,2)=[A(n+2)-16*A(n+1)]*S_n-A(n+1)^2.

For n>=4(k-1), the previous prime window is disjoint from all local
denominators. If gamma=u/v is reduced, P_n/gcd(P_n,abs(u)) divides the
denominator of H_(n,k). For fixed k, u has polynomial height in n; for example,
with L clearing the 2k-2 local coefficients,
abs(u)<=(k-1)!*16^(k-1)*L^(k-1). Thus its evaluated denominator has logarithm
at least 2n+o(n). The source report also derives a fixed-order coefficient
asymptotic; no growing-order estimate or visitation inference is used here.

The signs alone are shared by positive completely monotone avoiding models.
The arithmetic restriction additionally uses the actual rational forcing, but
still gives no incompatible constraint on a forbidden fractional interval.

## Why the natural word equations eliminate the initial value

Fix integers p_0,...,p_h, before asserting that they are the actual floors.
The formal carry expressions

    K_j(X)=16*(X_(j-1)-p_(j-1))+A(n+j)-(X_j-p_j)

restrict on the forward line to p_j-16*p_(j-1), independently of T.
Every polynomial in these carries is therefore in the constant sector of
the arithmetic test, including polynomial indicators for any finite carry
language. The actual recurrence carries after index zero lie in {0,...,16};
they have not been identified with ordinary hexadecimal digits or with a
finite-state actual process.

What remains is the floor selection:

    p_j <= 16^j*T+R_j < p_j+1.                                (3)

A nonempty finite cell defined by (3) contains an interval. A polynomial
integer-valued throughout that interval must be constant. Thus the finite
carry condition alone cannot force the nonconstant polynomial integrality
needed by (1), uniformly over the cell. This does not exclude using the fixed
rational anchor, nearness to integers, simultaneous inequalities or infinite
windows. Floor-dependent coefficients also need their actual height budget.

The changed question is whether a joint residual can retain the nonconvex
allowed-tail set and beat its arithmetic spacing while respecting coefficient
cost and the shared actual tail. Producing more carry equations or Hankel signs
alone would not address this missing implication. The next bounded test is
owned by the research log; V remains open.

## Evidence and limits

The parent read and reconstructed the report and reran the exact checker,
exit 0. No pi digit search was used. Frozen evidence:

- `/tmp/pi-m4-forward-polynomial-report-v2.md`, SHA-256
  `e2c9c38a0ae2538b14c43dfc45f8cde33829bafee597e3ea0ec843db19667f57`.
- `/tmp/pi-m4-forward-polynomial-check-v4.py`, SHA-256
  `cba54356e36f08e5c45b67746e8201b6d54ee757c8d78fd529bb56740ed41515`.
- `/tmp/pi-m4-forward-polynomial-receipt-v4.json`, SHA-256
  `b27f6804fcf45d92a303b3ea2ef4955e649c38137625b92858b7f93e908dcdef`.

The receipt includes 2,251 prefix valuations, 87,211 local-prime exclusions,
1,103 forward identities, 2,238 polynomial examples, 31,853 leading-term
valuations, 445 Hankel determinants, 7,905 Hankel valuations and 384 indicator
identities on 192 synthetic word cells. These finite checks do not certify the
universal arguments. The [review record](agy-reports/m4-continuation-review.md)
owns independent criticism and its limits. No production Lean, audit or pin changes.
