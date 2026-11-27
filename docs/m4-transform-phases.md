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

## Short-sum source tests retain their size and phase hypotheses

Two targeted source connections were tested against the actual CRT phase,
whose full modulus has log q_N=6N+o(N), or residual modulus log q_N=2N+o(N)
after compression. These are applicability tests, not general exclusions
of sum-product or trace-function methods.

[Bourgain, Corollary 3, p.351](https://www.numdam.org/item/10.1016/j.crma.2007.01.019.pdf)
requires H subset (Z/qZ)^*, small multiplicative doubling, and quantitative
nonconcentration in every fiber modulo q_1|q with q_1>q^epsilon.
It bounds the number of frequencies with large sums; it does not bound
each prescribed frequency. In particular its q_1=q condition, for any
occupied fiber, forces |H|>q^gamma with a fixed gamma>0. A segment
{16^j:0<=j<J} with J polynomial in N fails this condition for either
exponential modulus. Letting gamma vary with N would require new uniform
control of the theorem's parameters. The paper's separate remark about
complete multiplicative subgroups does not supply a short-segment theorem;
the original earlier subgroup source was not assessed in this cycle.

[Fouvry--Kowalski--Michel, Proposition 6.1, p.15](https://people.math.ethz.ch/~kowalski/sliding-sum.pdf)
requires a prime p, a generator g of F_p^*, and the trace function tau of
an isotypic, weight-zero middle-extension sheaf of conductor c whose
geometric irreducible components are not Kummer sheaves. For an interval
I in Z/(p-1)Z of length greater than sqrt(p-1), it gives

    |sum_(j in I) tau(g^j)|
      <=66*c^4*|I|*(sqrt(p-1)/|I|)^(1/3).

No such bounded-conductor representation of the BBP phase has been
constructed. The whole modulus is composite; projecting to one prime
loses other coupled CRT components. Also 16 is a square and cannot be a
generator at an odd prime. Subgroup parametrization/pullback needs its own
conductor and length analysis. The non-Artin--Schreier hypothesis from
the paper's additive section is not an extra hypothesis of this proposition.

In both connections the actual forcing must be retained:

    S_(N+j)=16^j*S_N+B_j,
    B_j=16^j*E_N-E_(N+j),
    E_N=sum_(r>=1) 16^(-r)*A(N+r).

For t>=1, the established rational coefficient bounds imply

    5/(1638*(N+1)^2)<=E_N<=53/(1280*(N+1)^2).

Consequently freezing B_j by demanding a fixed small real error permits
only j<=2*log_16(N+1)+O(1). At a prime p comparable to N this is below
the sliding-sum length threshold. This restricts the stated raw-error
approximation, not every possible long shadowing modulo one; the latter
would itself need new phase control. Neither deleting B_j nor replacing
the selected state by a complete orbit is a valid application.

The parent source-contract and separate criticism passes are retained in
`/tmp/pi-m4-short-sums-20261127/`, report SHA-256
`6f5c6348dadae442348fbc88d49116721f4fc7000e1a285ffc8deee187734230`.
Both primary PDFs and relevant page images/text were inspected. These
exact source hypotheses and elementary scaling bounds need no numerical
digit experiment. A surviving use would need an A-specific phase
representation retaining the forcing and initialized CRT class.

## Modular inverses retain the complete initialized prefix

The next source screen targets the actual rational prefix
S_n=sum_(k=0)^n 16^(n-k)*A(k) and its finite-frequency statistic

```text
W_h(M,L)=sum_(n=M)^(M+L-1) e(h*S_n),
e(x)=exp(2*pi*i*x),  h a nonzero integer.
```

The finite interval-minorant consumer above needs suitable cancellation for
finitely many frequencies on a sufficiently late block. It does not require
normality, but no such initialized estimate is supplied here. Summing
individual reciprocal phases over k is a different statistic from taking
the exponential of the full prefix and then summing over n.

[Bourgain--Garaev, Theorem 5, printed p.45](https://www.impan.pl/shop/en/publication/transaction/download/product/83636)
bounds sums of e_m(a*x^(-1)) over unit x in [1,X], for fixed coprime a
and X>m^c, with c a fixed small positive constant. The bound is
X*(log log m)^O(1)/(log m)^(1/2), with constants depending on c.
The units convention and X<m reduction remain essential; no uniformity
as c tends to zero is supplied. This theorem does not estimate W_h.

For r in {1,4,5,6}, put c_r=(4,-2,-1,-1), d_(k,r)=8k+r, and
D_T=lcm{d_(k,r):0<=k<=T}. Clearing denominators uses D_T/d, not the
inverse of d modulo D_T: every d>1 is a nonunit there. This literal
substitution fails before an analytic estimate can be applied.

There is an exact repair. Choose q=1+t*D_T with t>=1, and define

```text
v_q(d)=(1+(d-1)*q)/d,   0<v_q(d)<q,
v_q(d)/q=1-1/d+1/(d*q),
K_n=sum_(k=0)^n sum_r c_r*16^(n-k)*v_q(8k+r).
```

Each v_q(d) is the least positive inverse, including d=1. Since sum c_r=0,
K_n=-(q-1)*S_n exactly, hence e_q(-h*K_n)=e(h*S_n-h*S_n/q).
With T=M+L-1, M>=0 and L>=1, the complete-prefix comparison is

```text
|W_h(M,L)-sum_(n=M)^T e_q(-h*K_n)|
  <= (2*pi*|h|/q)*sum_(n=M)^T |S_n|.
```

Positivity and A(k)<=4 give 0<S_n<(64/15)*16^n. The normalized error is
at most (128*pi/15)*|h|*16^T/q, which can be made small by enlarging t.
This keeps every prefix term and the zero initialization. It gives an exact
representation and an error bound, not cancellation of the transformed sum.

The source averages one inverse with fixed coefficient. The transformed
target averages the exponential of a signed, exponentially weighted inner
prefix over n. Cancellation of a sum of individual phases does not bound
their product. Moreover the displayed error-controlled choice has exponential
q against ranges O(T); neither the denominator index nor time window has
length greater than q^c for fixed c>0. The archived exponential growth of
den(S_T), which divides D_T, independently forces exponential q in this
repair. It does not supply the missing estimate.

In fact the repaired individual phases are almost maximally aligned. For
each fixed integer a, including a=1, define the unweighted progression sum
R_T(a,q)=sum_(k=0)^T sum_r e_q(a*v_q(8k+r)). The inverse identity and
|e(x)-1|<=2*pi*|x| give

```text
|R_T(a,q)-4*(T+1)|
  <=2*pi*|a|*(97/60+H_T/2),
H_T=sum_(k=1)^T 1/k,  H_0=0.
```

The k=0 reciprocal sum is 97/60; for k>=1 the four reciprocals sum to
at most 1/(2k). Thus R_T/(4(T+1)) tends to 1 for fixed a, uniformly over
these auxiliary moduli. This rejects cancellation of the individual factors
in this construction, not cancellation of the actual weighted prefix.

[Garaev--Shparlinski v1, Theorems 1.1--1.2, pp.3--4](https://arxiv.org/pdf/2304.07953v1)
give another precise limit on generic inverse-sum heuristics. For fixed A>1
and every sufficiently large X, an existential prime p has (log p)^A
comparable to X and normalized discrepancy bounded below by a positive
constant depending on A. For one such p,
sum_(a=1)^k |sum_(x=1)^X e_p(a*x^(-1))| is bounded below by a constant
times kX for k_0<=k<=X, with k_0 depending on A. This does not select a
prescribed bad modulus or frequency, or a missed interval for the BBP time
sequence. Constants and the existential quantifiers are retained.

Neither source estimates the initialized triangular phase sum. The relevant
next object is the rational skew recurrence for (n,K_n), with all inverses,
the selected initial state, and a short time prefix retained. Complete
periods, seed averages or another range requiring length greater than q^c
would not close this transfer. No rational-function or trace representation
is adopted without such a consumer.

The authoritative source assessment is
`/tmp/pi-m4-bbp-sum-source-clarification-20261127/report-v2.md`, SHA-256
`66ccc4a38f8c13eb0605524a3f7a4e6d7495c4ec66edef8f9722674a36cf53a5`.
The original packet retains both primary PDFs and five inspected page images.
Parent replay passed 3,612 exact algebra/denominator checks, identical receipt
and 15 original evidence files preserved; no actual digit or phase was
evaluated. Independent source review and focused comparability repair passed.
Source statements/application and selected clustering proof pages were
inspected; neither full source proof was independently audited. The universal
algebra and bounds remain paper results, not consequences of the finite checks
or new Lean theorems. V and M4 remain open.

## Finite-field conjugacy and the split-prime constant

Let p>5 be prime, F=F_p, b=16 in F, and sigma f(z)=f(z+1).
Since sigma^p=1 and b^p=b!=1, the unique rational solution of
R(z+1)-b*R(z)=A(z) is

```text
R(z)=[sum_(j=0)^(p-1) b^(p-1-j)*A(z+j)]/(1-b^p).
```

The operator product telescopes to sigma^p-b^p; a homogeneous solution
would satisfy H=b^p*H and hence vanish. R is proper with simple poles in F.
Writing R(z)=sum_t r_t/(z-t), and a_t for the four residues of A, gives
r_(t+1)-b*r_t=a_t. The poles of A are -1/8,-1/2,-5/8,-3/4, with respective
residues 1/2,-1/4,-1/8,-1/8. Residues r_t are not regular values R(t).

The four geometric residue blocks give the following exact classification.
Here p=8m+s and supports use representatives 0,...,p-1.

| s | Support of r_t | Number s_p of poles |
| --- | --- | --- |
| 1 | [m+1,6m] | (5p-5)/8 |
| 3 | complement of [4m+2,7m+2] | (5p+1)/8 |
| 5 | [m+1,6m+3] | (5p-1)/8 |
| 7 | complement of [4m+4,7m+6] | (5p-3)/8 |

For a derivation, Euler's criterion and the supplementary law for 2 give
b^m=1,-1/2,-1/4,1/8 in the four rows. Starting from
r_0=(sum_f a_f*b^(-f))/(1-b), with f the four forcing poles, the residue
recurrence gives the table; r_0=0 in the split cases p=1 mod4 and 1/16
otherwise. Comparing at infinity gives sum r_t=0 and sum t*r_t=-1/64.
Thus the reduced denominator has degree s_p and numerator degree s_p-2.
The unique rational solution has complexity growing linearly with p.

Canonical finite parts repair evaluation at its poles. Define total functions

```text
C(t)=sum_(u!=t) r_u/(t-u),   B(t)=sum_(u!=t) a_u/(t-u).
C(t+1)-b*C(t)=B(t).
```

The identity follows by reindexing and the residue recurrence. Outside A's
four poles, B(t)=A(t); at a pole B is a specified extension, not a reduction
of an undefined rational value. On any prefix avoiding A's poles, the zero
initialized modular prefix satisfies

```text
U_(-1)=0,   U_n=b*U_(n-1)+A(n),
U_n=C(n+1)-b^(n+1)*C(0).
```

This does not reduce a real rational prefix modulo p after a denominator
divisible by p appears. For split primes R is regular on 0,...,m, so C=R
there. In particular p>8T+6 permits ordinary rational evaluation throughout
0,...,T+1. The auxiliary primes p=1 mod D_T are split since 4 divides D_T.

The canonical polynomial P(z)=sum_u r_u*(z-u)^(p-2) represents C on F.
Its degree is exactly p-3, with leading coefficient -1/32, by the two
moments above. Reindexing proves P(z+1)-b*P(z)=Q(z), where
Q(z)=sum_u a_u*(z-u)^(p-2), as a polynomial identity. More generally a
polynomial satisfying the recurrence at all p-4 nonforcing points has
degree at least p-8: otherwise clearing A's four-pole denominator gives
too many roots and an impossible rational identity. A rational total
extension with no poles in F and numerator/denominator degrees at most d
similarly needs d>=(p-8)/2. These global bounds say nothing by themselves
about a representation on an arbitrary short prefix.

### A finite-logarithm identity removes C(0)

There is a paper proof that **C(0)=0 for every prime p>5, p=1 mod4**.
It concerns the finite part, not merely the already vanishing residue r_0.
All calculations below take place in an algebraic closure of F. Put

```text
L(x)=sum_(d=1)^(p-1) x^d/d,
Z={z:z^8=1/16},   J(z)=4/z-2/z^4-1/z^5-1/z^6.
```

Taking constant Laurent coefficients in the inverse formula gives
C(0)=-(1/15)*sum_(j=0)^(p-1)16^(-j)*A_reg(j), where A_reg omits only the
individual terms whose denominators vanish. The eighth-root filter selects
n=8j+r in 1<=n<=8p-1, excluding multiples of p. Splitting n=lp+d gives
sum_(l=0)^7(z^p)^l=(15/16)/(1-z^p), hence the exact bridge

```text
C(0)=-(1/128)*sum_(z in Z) J(z)*L(z)/(1-z^p).
```

All eight roots are distinct and 1-z^p!=0 for p>5. Choose i in F with
i^2=-1, x with x^2=1/2, and y=(1+i)/2 in F. Factoring rho^8-16 into
rho^2-2, rho^2+2, rho^2-2rho+2 and rho^2+2rho+2 shows that J(1/rho)
reduces respectively to -16,0,16rho,0. Only z=+x,-x,y,1-y survive.
The finite-log identities needed to evaluate them are

```text
L(x)=L(1-x),
L(x)=-x^p*L(1/x)                         (x!=0),
L(x^2)=(1+x^p)*L(x)+(1-x^p)*L(-x),
L(a)-L(b)+a^p*L(b/a)
  +(1-a)^p*L((1-b)/(1-a))=0              (a!=0,1).
```

These follow from the defining finite sum and the integer polynomial
G(X)=[1-X^p-(1-X)^p]/p, whose reduction is L. Substitution of G proves
the four-term identity by cancellation of -(a-b)^p-(b-a)^p, before
reduction modulo p. Thus no infinite p-adic logarithm is being evaluated.
Duplication makes the pair +x,-x contribute -32*L(1/2), since x^(2p)=1/2;
no square root of 2 in F is required. The pair y,1-y contributes 64*L(y),
since y*(1-y)=1/2. The four-term identity at a=1/2,b=y, followed by
inversion and reflection at 1+i and 1-i, gives L(1/2)=2*L(y). The sum
vanishes, proving C(0)=0 in both split residue classes modulo 8.

Consequently U_n=C(n+1), or R(n+1) on the regular prefix. The exact sign
in the real comparison is

```text
e_p(-h*U_n)=e(h*S_n-h*S_n/p)  when p=1 mod D_T and n<=T.
```

This removes an initialized exponential factor. It supplies no estimate
for the remaining selected sum of e_p(-h*C(n+1)).

### The inspected completion estimate remains too weak

[Fouvry--Kowalski--Michel--Raju--Rivat--Soundararajan, (1.2)--(1.3), p.2, and (2.6), p.8](https://people.math.ethz.ch/~kowalski/short-sums.pdf)
give normalized Fourier completion
|sum_I phi|<=||hat(phi)||_infinity*sqrt(p)*log(3p), and the bound
max(||phi||_infinity,||hat(phi)||_infinity)<=10*c(F)^2 for a pointwise
pure weight-zero Fourier sheaf. The Fourier condition excludes linear
additive-character geometric components. The conductor definition and
rank-one additive-character pole formula are in
[Fouvry--Kowalski--Michel, Definition 2.5 and section 3.1, pp.7--8](https://people.math.ethz.ch/~kowalski/trace-functions-pisa.pdf).
For nonzero h in F, the natural sheaf of hR has conductor 1+2*s_p and
trace zero at poles; that of hP has conductor p-1 from its sole pole of
order p-3 at infinity. These nonlinear phases satisfy the Fourier condition,
but this generic bound yields order p^(5/2)*log(p), vacuous even for a full
period. This does not lower-bound the actual sum or rule out other
representations of its restricted values.

Even a bounded conductor would leave this completion bound above the
required length O(T) when the error-controlled modulus is exponential in T.
The completed algebra therefore leaves a specific analytic obligation:
control the initialized, selected short prefix using more of the BBP
structure. Full periods, seed averages and the vanishing constant alone
do not supply that control. Both universal paper arguments have separate
immutable reports and caller replays; their review/integration evidence is
recorded in the continuation review. No new Lean theorem or visit follows.
