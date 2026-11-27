# M4 exact CRT phases and the cost of absolute completion

This 2026-11-26 paper calculation connects the
[two-anchor reconstruction](m4-prime-square-lift.md#two-anchor-reconstruction-from-many-prime-endpoints)
to a finite Fourier condition sufficient for V. It exposes the remaining
signed estimate and tests two ways of discarding phases. No new visitation
estimate or Lean theorem is supplied. Review status belongs to the
[review record](agy-reports/m4-continuation-review.md).

## Exact residues and the remaining denominator

Use the reconstruction's L=L_N, P=P_N, G=gcd(P,L), M=PG, and
H=4*16^N*L. Work at N>=10 and, when using a canonical representative in
the height interval, M>H. This strict inequality holds eventually. Put

    a_p=47/15 if p=1 mod4, -65/21 if p=3 mod4
       =2/105+(109/35)*chi_4(p),
    e_p=v_p(L) in {0,1}, m_p=p^(1+e_p),
    C_(N,p)=16^N*a_p/p-sum_(j=N+1)^(p-1)16^(N-j)*A(j),
    r_p=L*C_(N,p) mod m_p.

The negative powers of 16 are rational p-units. Dividing the complete-block
identity gives S_N-C_(N,p) in p*Z_(p), so L*C_(N,p) is p-integral.
For integer z=L*x the initialized conditions are exactly z=r_p mod m_p.
The full future forcing sum is essential. CRT gives R in [0,M), and
the height inequality identifies R=L*S_N, not just its residue class.

Write L=G*D. Then gcd(D,P)=1 and log D=2N+o(N). All prime powers not
removed in G remain in D. Let b in [0,G) be the class specified by r_p mod p
for p dividing G, taking b=0 when G=1. Then

    R=b+G*u_*, 0<=u_*<P,
    u_p=u_* mod p
       =((r_p-b)/p)*(G/p)^(-1) mod p, if p divides G,
       =(r_p-b)*G^(-1) mod p, otherwise.

The first division is exact, and all displayed modular inverses exist.
The closed height bound becomes

    0<=u_*<=T<P, T=floor((H-b)/G),
    T=4*16^N*D if b=0, and 4*16^N*D-1 otherwise,
    S_N=b/L+u_*/D,
    (T+1)/P=exp(-(3-log16)*N+o(N)).

This very sparse height interval is not a uniform sample of the CRT classes.
Its selected class is determined by initialization.

The canonical carry cannot be dropped. If v_p represents (P/p)^(-1) mod p
and V=sum_p u_p*(P/p)*v_p, then u_*=V-P*floor(V/P). For e(t)=exp(2*pi*i*t),

    e(h*u_*/D)=e(h*V/D)*e(-h*(P/D)*floor(V/P)).

The last factor is generally nontrivial. Additive characters modulo P can
discard that carry; the real phase modulo D cannot.

## The finite consumer, with all phases retained

For J>=1, define

    B_j=sum_(s=1)^j16^(j-s)*A(N+s),
    beta_j=16^j*b/L+B_j,
    D_T(theta)=sum_(u=0)^T e(theta*u),
    Xi_N(k)=e(k*u_*/P)
           =product_(p|P)e(k*u_p*(P/p)^(-1)/p).

The inverse in the product is modulo p. The actual prefix at N+j is
beta_j+16^j*u_*/D. Finite Fourier inversion on Z/PZ gives exactly

    Z_(N,J)(h)=sum_(j=0)^(J-1)e(h*S_(N+j))
      =(1/P)*sum_(k=0)^(P-1) Xi_N(k)
          *sum_(j=0)^(J-1)e(h*beta_j)*D_T(h*16^j/D-k/P). (1)

All selected prime-square information is retained in u_p, unselected
prime powers in D, and the real representative in the height truncation.
There is no average over alternative initialized states.

Take the [positive-mean minorant](m4-transform-phases.md#a-sufficient-estimate-for-one-finite-block)
F(t)=mu+2*Re sum_(h=1)^K c_h*e(h*t), with mu>0, B=sum|c_h|>0,
and positivity only inside a strict target interval. The exact sufficient
condition is

    |the right side of (1)| < mu*J/(2B), 1<=h<=K.        (2)

Then sum_j F(S_(N+j))>0, giving an actual recurrence visit at index N+j+1.
For every target and threshold, one N above that threshold and one J
satisfying (2) suffice. No visit in every proportional window is required.
Applying the minorant directly to S uses B2 without a tail approximation.
Using pi*16^(N+j) instead costs at most
2*pi*|h|*sum_(j<J)E_(N+j), which must be retained.

Condition (2) is unproved. Formula (1) supplies an exact interface for a
new estimate, not that estimate itself.

## Exact hole propagation is not a quantum Fourier operator

A multi-step test retains more than the singleton CRT character. For a
block N,...,N+J let Q be the least common multiple of the reduced denominators
of S_N and A(N+1),...,A(N+J). It is odd. The last prefix denominator divides
Q, and the natural clearing lcm bounds Q above, so
log Q=6*(N+J)+o(N+J). The exact canonical recursion is

    a_(j+1)=16*a_j+c_j-Q*k_j,
    c_j=Q*A(N+j+1) in Z,
    k_j=floor((16*a_j+c_j)/Q), 0<=a_j<Q.

Each map F_j(a)=(16a+c_j) mod Q is a permutation. Let U_j be its unitary
action on the finite entry basis and P_j the diagonal projection onto states
avoiding the hole. For V_j=U_(j-1)...U_0 and
T_J=P_J*U_(J-1)*P_(J-1)*...*U_0*P_0, all pulled-back projections
V_j^*P_jV_j are diagonal and commute. If W is the set of surviving entries,

    T_J=V_J*1_W,  T_J^*T_J=1_W.

Thus the operator norm is 1 whenever any entry survives, regardless of a
small survival proportion. Arbitrary unit-modulus transition phases leave
this identity unchanged: a phase on a unique path creates no interference.
For the unitary DFT, F_Q*U_j*f(k)=e(-k*c_j/Q)*(F_Q*f)(16k mod Q).
The forcing supplies a phase and permutes frequency labels, not a second
Cantor support. Raw CRT, height and carry tests can instead be retained on
the original entry labels u in [0,T]; they are still commuting diagonal tests.

[Dyatlov--Jin, v3, Theorem 2 and (1.12), p.4](https://arxiv.org/pdf/1608.02238v3)
gives a fractal uncertainty estimate for 1_Ck*F_(M^k)*1_Ck, where C_k is
a base-M digit Cantor set with 1<|Alphabet|<M. The associated quantum baker
contains full and block Fourier transforms and smooth cutoffs (pp.1--2).
Its spectral gap is not a gap for the monomial operator above. Its base-power
modulus also differs from this exact odd grid; changing moduli would not by
itself repair the missing operator correspondence.

Hypothetical permanent avoidance does supply two classical Cantor coordinates.
Use B2/B3 with a strictly inner interval to transfer avoidance to
fract(16^n*pi), paying the tail margin. Choose a closed base-M cylinder
inside that interval, M=16^r. Aligned r-block digits then avoid one symbol v.
Their future coordinate u belongs to the corresponding Cantor set C, and
prepending these allowed digits by xi_next=(xi+d)/M keeps a second
coordinate xi in C. This is classical trapping in C times C, not a function
supported in both position and Fourier space. For the same alphabet an
interior allowed digit a gives the trapped fixed point u=xi=a/(M-1), while
the source uncertainty estimate still holds. An actual BBP-derived amplitude
or approximate eigenvector with the needed frequency constraint is absent.

Frozen packet `/tmp/pi-m4-fractal-phase-20261127/`, report SHA-256
`a5d412a105701942dbf953e3d522e2bfe8647141b3f78dbce9d12efb35933489`,
retains the full forcing identities, source contract/pages, criticism and
checker. Parent reconstruction, visual source inspection and unchanged-copy
replay passed: exit 0, identical receipt, originals preserved. The 47,504
finite structural checks use synthetic or explicitly changed entries, not
actual pi phases. Direct quantum-gap transfer and support-only refinements
are suspended; no universal visit estimate or Lean result was obtained.

## Height already forces a nonzero-frequency correlation

At h=0,J=1, equation (1) says

    1=(1/P)*sum_k Xi_N(k)*D_T(-k/P),
    (1/P)*sum_(k=1)^(P-1) Xi_N(k)*D_T(-k/P)
       =1-(T+1)/P ->1.

Thus a uniform-residue main term with error o(1) is already false at the
actual class before imposing any word restriction. For any finite A contained
in [0,T], the exact count is

    1_A(u_*)=(1/P)*sum_k Xi_N(k)*sum_(u in A)e(-k*u/P).

If the actual class lies in A, its nonzero-frequency part is 1-|A|/P,
which tends to 1. This applies to the exact forced avoidance set defined
by fract(beta_j+16^j*u/D) outside the target for every j<J. Its cardinality
alone does not determine membership of the selected class. No avoidance of
the actual pi orbit is asserted here.

For a fixed h>=1 and fixed j, the kernel in (1) peaks near
k=h*16^j*P/D, whose logarithm is 3N+o(N). The peak's grid width has
scale P/(T+1)=exp((3-log16)*N+o(N)). For varying j the center must be
reduced modulo P. On the circle, the number of grid points within
1/(2(T+1)) of h*16^j/D differs from P/(T+1) by at most 2; at such points
|D_T|>=(2/pi)*(T+1). The arithmetic correlation near zero does not bound
the phases at these moving centers. Xi_N has modulus exactly 1: its
factors are characters of the same k, not independent local sums.

## Two precise failures of absolute completion

For P>T>=0 and any real theta,

    (1/P)*sum_k |D_T(theta-k/P)| >=1.

Fourier inversion at any u in [0,T] gives a unit complex value, so this
follows by the triangle inequality. Taking absolute values separately for
each j in (1) therefore gives a certificate at least J. The specified
proper-interval minorant has mu/(2B)<1, so that certificate cannot prove (2).
This is a lower bound on a proposed upper bound, not on |Z_(N,J)(h)|.

Even retaining the j sum inside the absolute value has a limitation. Define

    C_(N,J,h)=(1/P)*sum_k
        |sum_(j<J)e(h*beta_j)*D_T(h*16^j/D-k/P)|.

This is the Fourier L1 certificate for the function
f(u)=sum_(j<J)e(h*(beta_j+16^j*u/D)) on [0,T], zero elsewhere in Z/PZ.
Inversion gives C_(N,J,h)>=|f(u)| for every grid seed u in [0,T]. Such
seeds preserve the actual b class and forcing, but need not satisfy u=u_*.
That is exactly the selection information the absolute value discarded.

Choose u nearest to D*(1-E_N-b/L). Since 0<=b/L<1/D, E_N<1/4 and
D>=4 eventually, this u lies in [0,D], which lies in [0,T]. For
x=b/L+u/D, |x-(1-E_N)|<=1/(2D). The exact tail identity gives

    16^j*x+B_j=16^j-E_(N+j)+16^j*(x-(1-E_N)).

Using |e(t)-1|<=2*pi*|t| and the checked B3 bound
epsilon_N=8/(15*(8N+9)) for every E_m with m>=N proves

    C_(N,J,h)>=J-2*pi*|h|*
                      (J*epsilon_N+(16^J-1)/(30D)).      (3)

For fixed h and fixed 0<eta<2/log16, uniformly over
1<=J<=(2/log16-eta)*N, this is (1-o(1))*J. Thus this combined absolute
certificate cannot prove a fixed strict cancellation ratio below 1 in that
range. Longer blocks and estimates retaining the signed Xi_N correlation
remain open. The construction does not replace the actual state or show
that its character sum is large.

The actual null state is again a discriminator. Its analogous reconstruction
leaves a denominator of logarithmic size 2N and the same Fourier formula,
yet

    |sum_(j<J)e(h*U_(N+j))-J| <=2*pi*|h|*J/(16N+18).

A successful A argument must use the actual signed residues and forcing
across consecutive indices. Modulus sizes, uniqueness and absolute values
alone cannot supply that distinction.

## Evidence and next question

Frozen report `/tmp/pi-m4-crt-word-20261126/report-v1.md` has SHA-256
`3baa6e5e8dd9a8ffd2027aad0526654dd8f673e366057ed3a1599035471ce2a0`.
The parent read its full report/checker, reconstructed the Fourier inversion,
carry, height and grid-shadow arguments, and replayed an unchanged checker
copy in a separate directory. It exited 0 with a byte-identical receipt:
1,828 local and 1,828 compressed residue checks, 46 CRT/carry cases,
24 actual affine propagation checks and 72 synthetic shadow identities.
All frozen hashes were unchanged. Synthetic tails check algebra and rounding,
not actual numerical phases; no pi digit search was made. The asymptotic and
Fourier arguments remain paper mathematics. Independent changed-file review
completed with no D/I/Q items; the review record retains its scope and limits.

The next useful question is a signed cross-index relation or estimate specific
to A and Ahat that fails for D. Restating the forced recurrence, discarding
beta_j, or averaging over all seeds would repeat the missing step. V and M4
remain open; this bounded diagnostic does not end the authorized research.

## Full mixed differences retain the largest denominator

A second consumer test uses the unrestricted mixed-prime relations directly,
without Fourier completion. Let Q be a nonempty squarefree product of primes
at least 7 and retain every transformed state:

    C_Q^c(k)=sum_(d|Q) mu(Q/d)*d*F_(T_(Q/d)c)(dk),
    B_Q=product_(p|Q)(p-chi_4(p)).

For each selected p, v_p(C_Q^c(k))>=2. In the real absolute value, for
fixed Q, C_Q^A(k) tends to pi*B_Q, C_Q^R(k) to 2*pi*B_Q, and C_Q^D(k)
to zero. Thus the A expression itself is not small. Cancelling its constant
by adjacent subtraction gives

    Delta_Q(k)=C_Q^A(k)-C_Q^A(k+1)
      =-sum_(d|Q) mu(Q/d)*d
          *sum_(j=dk)^(d(k+1)-1)16^(-j)*(T_(Q/d)A)(j). (4)

The smallest corner survives. Set a_Q=T_Q A and delta=91/65536000. For all
k>=1, uniformly in every such Q,

    |Delta_Q(k)+mu(Q)*16^(-k)*a_Q(k)|
       <=delta*16^(-k)*|a_Q(k)|.                       (5)

For j>=1 the elementary coefficient bounds are

    0<A(j)<=1/j, 0<-Ahat(j)<=1/j,
    min(A(j),-Ahat(j))>=40/(819*j^2).

For A the lower bound follows from its explicit positive quadratic numerator;
for Ahat, -Ahat(j)>4/(8j+2). A divisor d>1 contributes at most
(16/(15k))*16^(-dk). Relative to the d=1 term this is at most
(546/25)*k*16^(-(d-1)k). All such divisors are at least 7. Summing over
every integer d>=7, and using k*16^(-(d-1)k)<=16^(-(d-1)), gives exactly
delta. In particular the actual Delta_Q(k) is nonzero and has size at least
(1-delta)*40*16^(-k)/(819*k^2).

This failure of zero forcing persists after actual denominator reduction.
For even k>=2, K=Q(k+1) is odd. Both coefficient states have odd reduced
denominators; an explicit form is

    Ahat(j)=-2/(4j+1)-2/(8j+3)
                 -3*(j+1)/[(2j+1)*(8j+7)].

The last two factors have gcd dividing 3, cancelled by the numerator. A(j)
is a 2-adic unit for even j. In 16^(K-1)*Delta_Q(k), the last term in
(4) is -Q*A(K-1), a 2-adic unit, while every earlier term has an additional
factor of 16. Hence

    v_2(Delta_Q(k))=-4*(K-1).

If Delta_Q(k)=a/b is reduced, b>0, then 16^(K-1) divides b, gcd(b,Q)=1,
and Q^2 divides a. Its supplied reduced lattice step is Q^2/b. Therefore

    |Delta_Q(k)|/(Q^2/b)
      >=(1-delta)*(40/819)*16^((Q-1)*(k+1))/(k^2*Q^2)>1. (6)

The final inequality holds for Q>=7,k>=2: k^2<=16^(k-1) and
Q^2<=16^(Q-1) leave at least 16^11. For fixed Q the ratio grows
exponentially along arbitrarily late even k, including k coprime to Q.
Thus selected prime-square divisibility and this actual real smallness
cannot force the period-annihilated rational to vanish. No stronger
valuation or new avoidance-dependent estimate is ruled out.

For the full denominator cost, put L_K=lcm of the positive odd integers
at most 8K-1 and V=L_K/product_(p|Q)p^(v_p(L_K)). The legitimate scaled
modulus is product_(p|Q)p^(2+v_p(L_K)), giving the coarse step

    g=Q^2/[16^(K-1)*V].

The ordinary PNT gives log L_K=8K+o(K). The removed selected-prime part
has logarithm O((log K)^2), since Q<=K. Hence
log g=-(8+log16)K+o(K). All unselected odd prime powers remain. This
coarse cap is consistent with, but not needed for, the reduced bound (6).

There is also a precise limitation of separately relaxing word cells. For
the original C_Q^A(k), K=Qk, retain canonical integers z_d and fractions
theta_d of each transformed S_(dk-1). The exact expression is
sum_(d|Q)mu(Q/d)*d*16^(-(dk-1))*(z_d+theta_d). Separate cells of length
w give an interval of width at least 16^(-(k-1+w)); it exceeds g whenever
16^(K-k-w)>Q^2. Such an open interval contains a scalar lattice point.
This tests only continuous box relaxation, not an actual coupled avoidance
model. Initialization, forcing and the carry in S^Ahat=U-S^A cannot be
discarded. For eventual avoidance take k-1 beyond the specified threshold.

Adjacent subtraction also removes the old initialized prefix: (4) depends
only on coefficients at indices at least k. Replacing F_A(m) by F_A(m)+t
and F_Ahat(m) by F_Ahat(m)-t for m>=1 changes C_Q^A by t*B_Q but leaves
Delta_Q unchanged. Such a replacement loses the actual initialization;
it diagnoses information discarded by this auxiliary alone. It does not
refute combining the auxiliary with a separate initialized constraint.

The actual null state satisfies the same selected-prime bounds and
|C_Q^D(k)|<2*16^(-k)/k. Its small real values coexist with those constraints
while its recurrence avoids (1/2,1). The nonzero A period remains available
to a different argument; it was cancelled in the tested construction.

Frozen report `/tmp/pi-m4-mixed-consumer-20261127/report-v1.md` has SHA-256
`bb296725710eeb9a794122220572673c9365a1ce90a19ccccfcc41ad19a06022`.
The parent read its full report/checker, reconstructed the bounds and exact
dyadic argument, and replayed an unchanged checker copy with an identical
receipt and unchanged originals. It exited 0: 38 adjacent products, 60
selected-prime valuations, 19 reduced-lattice cases, 20 complete denominator
caps and 114 word-width comparisons. These finite checks do not certify
the universal paper argument. A useful new consumer must retain the actual
branch information and obtain an additional signed or avoidance-dependent
estimate. The raw period-cancelling route above supplies neither; V remains
open, and research continues under the unchanged contract.


## Short ordinary differences retain an exponential denominator

This paper test keeps the actual zero-initialized S_n and every new forcing
term. It assesses one proposed use of arithmetic differencing; it is not a
lower or upper bound for cancellation of the resulting complex phases.
Fix0<delta<1 and positive integer shifts h_1,...,h_r with H=sum h_i<=delta n.
For every fixed r, uniformly over these shifts,

```text
log den(Delta_(h_1)...Delta_(h_r) S_n) >=2(1-delta)n-o(n),
Delta_h f(n)=f(n+h)-f(n).
```

In fact this holds uniformly for1<=r<=n^(1/2-eta), for each fixed0<eta<1/2.
The denominator is reduced and logarithms are natural. The analytic input is
the already assessed PNT in the fixed progression1 modulo4; it is not newly
formalized or source-proof-audited here.

For integer X>=2, let L_X=lcm(1,...,X). An elementary order argument gives

```text
log gcd(L_X,16^h-1)
 <=sqrt X*((1+tau(h))*log X+tau(h)*log16),       h>=1.
```

Primes at most sqrt X contribute at most sqrt X log X, including all their
powers. A larger prime occurs to the first power only. Its order d modulo p
for16 divides h and p-1. For d<=sqrt X, the product of primes with that exact
order divides16^d-1, costing at most d log16. For d>sqrt X, p=kd+1<=X
allows at most sqrt X choices per divisor d. Summing gives the bound.
For any epsilon>0, tau(h)<=C_epsilon h^epsilon: use a+1<=2^a<=p^(epsilon a)
for all sufficiently large primes, and bound the finitely many remaining
prime factors by their finite suprema. Thus no prime-order randomness is assumed.

Take the common prime set

```text
P_(n,delta)={p prime: p=1 mod4,
                       4(1+delta)n+3<p<=8n+1}.
```

Each such p occurs exactly once in the original prefix through n, with
coefficient numerator4 or-1 and denominator p, so v_p(S_n)=-1. Every pole
denominator at indices n+1,...,n+H lies strictly between p and2p and is
therefore a p-unit. Expanding the differences gives exactly

```text
Delta_(h_1)...Delta_(h_r) S_n = W*S_n+C(n),
W=product_i(16^(h_i)-1),
```

where C(n) is an integer linear combination of A(n+1),...,A(n+H).
Consequently every prime in the common set not dividing W survives to
valuation-1 in the actual difference. No new forcing term is omitted.

The common prime product has logarithm2(1-delta)n+o(n) by the fixed-progression
PNT. With X=8n+6, the lost primes cost at most
`sum_i log gcd(L_X,16^(h_i)-1)`. For fixed0<epsilon<1 this is

```text
O_epsilon(sqrt n*log n*(r+r^(1-epsilon)*H^epsilon)),
```

using concavity to bound sum h_i^epsilon by r^(1-epsilon)H^epsilon.
For r<=n^(1/2-eta), choose epsilon<eta/(1/2+eta). The powers of n are then
at most1-eta and1-eta+epsilon*(1/2+eta), both below1. The loss is o(n),
uniformly over the stated shifts and depths. The common fixed-delta interval
also makes the PNT remainder independent of these choices.

For a fixed nonzero integer frequency ell,
`den(ell*x)=den(x)/gcd(den(x),abs ell)`, losing at most log(abs ell).
The same lower bound therefore holds uniformly over a fixed finite set of
nonzero minorant frequencies. This connects the discriminator to the existing
finite-frequency consumer, without providing that consumer's signed estimate.
It rules out reducing these actual differences to polynomial-size denominators
in the specified regime. It does not rule out cancellation at large denominators,
a different operator, or other depth and total-shift regimes.

### Prime activation has a dependent complement

For N>=1, take primes p=1 mod4 in(8N+6,16N+1]. Write r_p=1 or5 according
to p modulo8, j_p=(p-r_p)/8 and c_p=4 or-1. Define, for N<=n<=2N,

```text
R_N(n)=S_n-sum_(p:j_p<=n)c_p*16^(n-j_p)/p,
e(ell*S_n)=e(ell*R_N(n))*product_(p:j_p<=n)e(ell*c_p*16^(n-j_p)/p).
```

This is an exact factorization of the actual prefix. At N<n<=2N its complement
satisfies

```text
R_N(n)-16R_N(n-1)=A(n)-sum_(p:j_p=n)c_p/p.
```

The sum is essential: at N=7,n=12, both97 and101 activate, giving
`A(12)-4/97+1/101`. The earlier proposed singleton identity was false in
general; its N=4,n=5 fixture happens to have only41. Since A(n)=O(n^-2),
the complement cancels the whole first-order activation sum. Treating it as
independent of the prime factors loses actual structure before any estimate.

Changing the prime decomposition alone is also not a new consumer. Centered
CRT coefficients can individually be small: for pairwise coprime prime powers
q_p, L=product q_p, choose |a_p|<=q_p/2 with a_p*(L/q_p)=1 mod q_p.
Then sum a_p*(L/q_p)=1+kL, so for L*S_n integral,
`e(S_n)=product_p e(a_p*(L/q_p)*S_n)`. The cost is the growing joint product
and its full conductor, not necessarily exponentially large individual
Bezout coefficients. This is ordinary CRT factorization.

A usable source must control the explicitly coupled activated product at the
actual initialized numerator and in the required short window. The preliminary
smooth-modulus screen has not supplied that estimate. It is neither a full
source audit nor an impossibility result for all arithmetic exponential-sum
methods. No actual phase, raw prefix, digit or carry census was used; finite
checks cover only pole, order, coefficient and operator bookkeeping.
Review evidence is in the [continuation record](agy-reports/m4-continuation-review.md).
V, actual odd-carry infinitude and M4 remain open.
