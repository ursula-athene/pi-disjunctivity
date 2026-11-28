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

## Two smooth-modulus source contracts do not supply the phase estimate

The targeted source check retains the actual finite-minorant consumer above.
For scale comparison let t be the prefix scale and L be a proportional window
length. A natural common modulus is lcm(1,...,8(t+L)+6), which contains every
coefficient denominator through the window. The archived actual-denominator and
lcm estimates give log q and log rad(q) of order t and largest prime P of order t.
This scale comparison does not identify the actual phase as a source character.

[Chang, *Short character sums for composite moduli*, v2](https://arxiv.org/pdf/1201.0299v2),
Theorem 5, p.2, requires a primitive nonprincipal multiplicative character,
an integer interval of length L, and

```text
q > L > P^1000,
log L > (log q)^(1-c)
          + C*log(2*log q/log rad(q))*log rad(q)/log log q.
```

Here c,C are fixed positive source constants; nonprincipal is the convention
on p.6. The bound is of size L*exp(-sqrt(log L)). The mixed Theorem 8, p.38,
keeps those premises and permits a real polynomial twist of degree at most
(log L)^c. No primitive multiplicative-character representation of the actual
BBP phase is supplied. A general dependent complementary phase is not that
polynomial twist. Independently, L~t and P~t fail the first length condition;
the radical term in the second has order t/log t, exceeding log L. These are
failed hypotheses of this transfer, not lower bounds for the true sum.

[Wu--Xi, *Arithmetic exponent pairs for algebraic trace functions and applications*, v5](https://arxiv.org/pdf/1603.07060v5),
pp.10--11 and 19--23, uses positive squarefree q, admissible local trace
functions of uniformly bounded conductor, and the specified amiability of the
function and its Fourier transform. Its deformation is a function W on
Z/deltaZ with gcd(delta,q)=1, with its cost retained. The scalar estimate has form

```text
|sum_I K(n)W(n)| <<_(epsilon,c) L^epsilon*||W||_infinity
                                  *(q/L)^kappa*L^lambda*delta^nu.
```

The natural lcm is not squarefree. A suitable squarefree/coprime factor
separation and control of the remaining phase are additional requirements;
taking the radical alone need not leave a coprime quotient. The composite
denominator's coarse smoothness fits the premise that each prime
factor is at most q^eta for each fixed eta>0; it supplies none of the remaining
hypotheses. In particular it does not make the actual phase a controlled trace
function. The [strongest existing actual representation](m4-transform-phases.md#a-finite-logarithm-identity-removes-c0)
does remove the initialized exponential term: C(0)=0 for split primes and
U_n=C(n+1) on the specified pole-free prefix. Its natural rational and polynomial
sheaf conductors nevertheless grow linearly with the auxiliary prime. The
[restricted-prefix bounds](m4-transform-phases.md#restricted-prefix-interpolation-and-modular-taylor-error)
also exclude bounded-degree exact rational interpolation on long prefixes.
Neither statement rules out every possible restricted trace representation.
The single auxiliary prime is a different encoding and fails the coarse
smoothness premise of Theorem 4.3, although the general trace-function framework
allows prime q. Reduction after an actual p-pole is not licensed.

Even granting a hypothetical class match, each fixed inspected scalar exponent
pair with kappa>0 has normalized cost q^kappa*L^(lambda-kappa-1+epsilon),
which grows when L is of order log q. The trivial pair gives no saving.
The displayed A-process shifts must fit the interval; its fixed-pair balancing
choice has an exponentially large factor in this regime. Growing width needs
new uniform control of constants and conductor; Remark 9 and Theorem 8.1 retain
weakening savings and explicit factor costs. This rejects these proposed uses,
not all exponential-sum methods or all possible exponent pairs.

The exact activated product still has its dependent complement, with all
simultaneous activations summed. Modulus one alone does not make that complement
a permissible W: a suitable coprime period and its cost remain to be supplied.
A source on multiplicative-order time groups would likewise need an exact
coupled phase identity and a useful bound at the required length. That is an
unresolved source question, not a positive route established by this check.

Primary statements and selected theorem pages were inspected; no full source
proof, hidden-constant, external Lean or axiom audit is claimed. No theorem from
either source is adopted. The [review record](agy-reports/m4-continuation-review.md)
retains the scope, immutable sources and parent assessment. V/M4 remain open.

## Joint two-prime cancellation still leaves the complementary phase

The 2026-11-28 test builds on the
[growing-prime projection](m4-fourier-windows.md#growing-prime-projections-and-the-unscaled-branch).
It proves cancellation for a genuinely joint two-prime factor, then restores
the exact remaining phase. This is a paper result. No actual unscaled estimate,
Lean theorem or visitation premise is obtained.

Let X tend to infinity, choose distinct p,q in [X,2X], both 1 modulo8, with
`ord_p(16)>=p^(1/4)` and `ord_q(16)>=q^(1/4)`, and put

```text
L=floor((log X)^(1/3)), H=floor(X*L),
I={ceil(H/2),...,H-1}, N=|I|~X*L/2, P=p*q.
Q=lcm{den A(k):0<=k<H}, M=Q/P,
S_-1=0, S_n=16*S_(n-1)+A(n), Z_n=Q*S_n.
```

Such pairs exist eventually: fixed-progression PNT supplies logarithmic prime
mass X/4+o(X), whereas primes with small order divide the product of
`16^j-1` for j<=(2X)^(1/4), of logarithmic size O(sqrt X). No prime census
is involved. Both p,q divide Q exactly once for large X. Hence gcd(P,M)=1.
Fix `u=M^(-1) mod P`, `v=P^(-1) mod M` for the entire horizon and define

```text
G_n(h)=e_P(h*u*Z_n), C_n(h)=e_M(h*v*Z_n), e_m(t)=exp(2*pi*i*t/m).
e(h*S_n)=G_n(h)*C_n(h),
G_n(h)=e_p(h*Z_n*(qM)^(-1))*e_q(h*Z_n*(pM)^(-1)).
```

The same time exponent appears in both prime factors; no independence of
their averages is asserted. The real expression for G is `e(h*u*M*S_n)`,
an integer multiple of the actual phase. For the unreduced branch put
`a_n=Z_n mod P` in [0,P) and `b_n=(Z_n-a_n)/P`. Then

```text
e(h*S_n)=e(h*a_n/(P*M))*e(h*b_n/M),
a_(n+1)=(16a_n+J_(n+1)) mod P,
b_(n+1)=16b_n+floor((16a_n+J_(n+1))/P), J_(n+1)=Q*A(n+1).
```

All transitions here and below require **0<=n+1<H**. Q need not clear A(H).
The exact integer branch and zero initialization have been retained.

For ell=p or q, let t_ell=(ell-1)/8. The original pole r activates at
`e_(ell,j,r)=(8j+r)*t_ell+j`, since `8e+r=(8j+r)*ell`.
Quadratic reciprocity gives `16^t_ell=1 mod ell`. Each A clock, with offsets
1,4,5,6, has gaps 3t,t,t,3t+1. Their union partitions I into O(L) pieces,
without aligning those pieces to the joint period. Simultaneous activations
satisfy `mp-m'q=r-s`; every contribution enters J. On activation-free edges,

```text
G_(n+1)(h)=G_n(h)^16,
C_(n+1)(h)=C_n(h)^16*e(h*A(n+1)),
b_(n+1)=16b_n+M*A(n+1)+floor(16a_n/P).
```

Thus the complementary factor retains the original forcing at every step.
For fixed nonzero h its innovation is nontrivial eventually, since
0<|h|A(n+1)<1. Unit modulus does not supply independence or regularity.

### The joint estimate and its precise source use

For a fixed rational coefficient vector supported on **1<=r<=8**, let B be
any nonzero ordered partial

```text
B_(j,r)=sum_(k<j,s) c_s/[16^k(8k+s)]
          +sum_(s<=r) c_s/[16^j(8j+s)], j<=L.
```

An integer Q0 clearing the fixed coefficients makes
`Q0*16^L*(8L+8)!*B` a nonzero integer of absolute value less than X eventually:
its logarithmic size is O(L log(L+2))=o(log X). All clearing factors are
ell-units. Hence B is nonzero modulo either selected prime, uniformly at the
growing depths. For A every partial is positive: the first term of each
coefficient is positive and its remaining terms are negative, with positive
completed coefficients. The exact recurrence gives
`16^(-n)*Z_n=(Q/ell)*B_(j,r) mod ell`. Both primes have activated on I, so
every homogeneous projected piece has a unit coefficient for fixed h!=0.

[Bourgain–Chang, *Exponential sum estimates over subgroups and almost subgroups
of Z_q*, where q is composite with few prime factors](https://math.ucr.edu/~mcc/paper/122%20NewExp.pdf),
Corollary4.5 on printed p.42, bounds a unit-coefficient sum of powers by
`t^(1-epsilon)` when local orders and length exceed `q^delta`.
The definition on p.38 bounds total prime-factor multiplicity, not merely
the number of distinct primes. P=pq meets it, and its local orders exceed
P^(1/16). Printed p.43 retains the local-order condition for incomplete sums.

The printed corollary omits an upper length bound. We use only lengths at
most the period, consistently with its set-of-powers argument; an unrestricted
repeated-period reading is not adopted. Put `d=ord_P(16)` and
`T=ceil(P^(1/16))+1<d`. Split any piece of length J into full d-periods and
a remainder r<d. Apply the corollary at d and at r>=T; bound r<T trivially.
For a uniform fixed epsilon>0 this gives

```text
|sum over a piece G_n(h)| <= J*T^(-epsilon)+T,
|(1/N)*sum_(n in I) G_n(h)| <= T^(-epsilon)+O(L*T/N) ->0.
```

This is joint cancellation modulo pq. It neither multiplies marginal means
nor completes the actual short window to the full denominator's period.
The primary statements and these pages were inspected; their full classical
proof chain was not audited or formalized here.

### Restoring the phase retains exponential conductor and correlation

For n in I the reduced actual denominator is q_n=P*m_n, gcd(P,m_n)=1.
The [denominator result](m4-prime-compression.md#the-evaluated-denominator-exponent) gives
`log m_n=6n+o(n)` uniformly on I. The value C_n(h) has exact root-of-unity
order `m_n/gcd(m_n,|h|)`: write S_n=A_n/(P*m_n) reduced and substitute
Z_n=(M/m_n)*A_n, using that v is a unit. The full value's order is
q_n/gcd(q_n,|h|). Ambient characters on Z/M and Z/Q instead have conductors
M/gcd(M,|h|) and Q/gcd(Q,|h|), respectively.

The common denominator satisfies `log Q=6H+o(H)`. Apart from finitely many
small primes, its support is primes 1 modulo4 up to 8H+O(1), and primes
3 modulo4 up to 4H+O(1). The unique first pole gives a nonzero residue;
higher powers contribute o(H). PNT gives the upper bound 4H+2H+o(H), matching
the reduced denominator at H-1. Even the weaker bounds 6H+o(H)<=log Q<=8H+o(H)
suffice to reject the restored source application. Its prime factors are at
most 8H+O(1), so their orders are below Q^delta for every fixed delta>0;
the available length H is also too short, and total factor multiplicity
is at least log Q/log(8H+O(1)), tending to infinity. Fixed h removes at most
log|h|. The complement also remains forced rather than a pure power sequence.
The preceding Chang and Wu–Xi contracts do not license this dependent weight.
These are failures of the specified transfers, not all exponential-sum methods.

The positive [comparison forcing F](m4-rational-forcing.md) exhibits the
missing correlation explicitly. For the null forcing D, with coefficients
`(4,-4,-2,-4,-1,-1,1/2)` at offsets1,...,7 and initialized state U_n, use

```text
R(n)=1/[2(8n+1)(8n+5)]-D(n)/8, R(0)=2/21,
F(n)=(15/8)D(n)+16R(n)-R(n+1),
W_n=(15/8)U_n+16^(n+1)*R(0)-R(n+1).
```

Every D partial is nonzero: 0<U_n<1/(16n+18) makes the penultimate partial
negative, the preceding one positive, and all earlier nonempty partials
larger. The unit argument therefore applies to D. Its residue transfers to F
except at O(L) indices where R(n+1) has p or q in its denominator. F's thirteen
fixed poles likewise yield O(L) pieces. Deleting the exceptional points and
using the same period split proves joint projected cancellation for F.

Define Q_F,M_F,Z_F,u_F,v_F,G_F,C_F by the same formulas. These moduli and
actual numerators may differ from A's; the primes, horizon, frequency and
restored statistic are the same. F has denominator exponent8 rather than6.
Since `W_n=16^n*(32/21)-E_F(n)` and E_F(n)=O(n^-2), at h=21,

```text
C_n^F(21)=conj(G_n^F(21))*e(-21E_F(n)),
(1/N)*sum_I G_n^F(21) ->0,
(1/N)*sum_I G_n^F(21)*C_n^F(21) ->1.
```

This is the fixed initialized positive, completely monotone F, whose phases
stay below11/21. Its rational constant remains a difference from pi. Moreover,
on ordinary edges the squared projected increment is
`2-2 Re G_n^F(315)`. Applying the joint bound at315, discarding O(L) exceptional
edges and using the O(H^-2) pointwise error gives

```text
sum_(consecutive n in I) |C_(n+1)^F(21)-C_n^F(21)|^2 = 2N+o(N).
```

Each increment has modulus at most2, so ordinary total variation is at least
N+o(N). Thus projected cancellation and unit modulus alone supply neither the
restored cancellation nor small variation. Actual A's correlation and
variation remain unproved. Further projection-only refinements are suspended;
the next bounded diagnostic tests the variation required by summation by parts
against the exact complementary recurrence. No useful bound is assumed.

The [review record](agy-reports/m4-continuation-review.md) retains I1/I2's scope
clarifications, the immutable packet, and limits of the synthetic identity
checks. No actual prefix, denominator, digit, carry or orbit census, originality
claim, Lean result, selected-time hit or V/M4 conclusion follows.

## Complementary variation requires more than the finite arithmetic data

The next 2026-11-28 diagnostic suspends the ordinary-variation repair.
It proves an exact cost, a small-variation implication for the actual orbit,
and opposite finite replacement-entry examples. It supplies no useful actual
variation bound. Keep the preceding Q=P*M, fixed h!=0 and exact G,C. On a
homogeneous piece n=N,...,N+J-1, the recurrence is
`C_(n+1)=C_n^16*e(h*A(n+1))`. The long pieces selected from the O(L) partition
have J comparable to X and N comparable to XL, so J=o(N). This is not asserted
of every piece.

Write g_j=G_(N+j), c_j=C_(N+j), U_j=sum_(i<j)g_i. Telescoping gives

```text
sum_(j<J) g_j*c_j
 =U_J*c_(J-1)+sum_(1<=j<J)U_j*(c_(j-1)-c_j).
```

If |U_j|<=B(j), the exact available upper bound is
`B(J)+sum_(1<=j<J)B(j)*|c_j-c_(j-1)|`. The preceding finite-period source
contract supplies `B(j)=min(j,j*T^(-epsilon)+T)`, with 0<epsilon<=1.
For V=sum_(j<J-1)|c_(j+1)-c_j|, the coarse normalized bound is
`(T^(-epsilon)+T/J)*(1+V)`. A sufficient budget is V=o(X^(epsilon/8));
V=o(J) alone does not ensure it. The position-sensitive bound may be better,
and neither small variation nor this certificate is necessary for actual
cancellation. No upper bound is reversed into a lower bound for the sum.
The finite identity is proved here; [DLMF2.10(ii)](https://dlmf.nist.gov/2.10#ii),
equations2.10.9–10, is a checked formula reference, not an imported analytic theorem.

Put d_j=|c_(j+1)-c_j|. The actual recurrence gives

```text
d_j^2=2-2 Re(c_j^15*e(h*A(N+j+1))),
Evar=sum d_j^2, Rvar=sum |c_j^15-1|^2,
|Evar-Rvar| <= 4*pi*|h|*(J-1)/(N+1)^2,
Evar<=2V, V^2<=(J-1)*Evar.
```

For n>=1, the numerator of A over (t+1)(t+4)(t+5)(t+6), t=8n, is
15t^2+151t+376. This bounds 0<A(n)<=n^-2. Its integral kernel
`x^(8n)*(4-2x^3-x^4-x^5)` is positive on (0,1), giving monotonicity and
`0<E_n<=1/[15(n+1)^2]`. Thus for J,N tending to infinity,
`V=o(J) iff Evar=o(J) iff Rvar=o(J)`. Sublinear variation would require
concentration near the fifteen roots of unity; this equivalence does not
prove that concentration.

There is a rigid implication when J>=2, V<=1/100 and
|h|A(N+j+1)<=1/100 throughout. Some fifteenth root zeta admits unique lifts

```text
c_j=zeta*e(theta_j), |theta_j|<1/250,
theta_(j+1)=16theta_j+h*A(N+j+1),
theta_j=-h*E_(N+j)+16^j*delta_0,
|delta_0|<=16^(-(J-1))*(1/250+|h|E_(N+J-1)).
```

Indeed the first edge puts |c_0^15-1|<9/100, so its angular distance to a
fifteenth root is <3/2000. The total chord variation adds at most1/400 to
the angular distance, yielding <1/250 for all vertices. The possible integer
in the lift recurrence has magnitude <=17/250+1/100<1 and is zero.
The exact tail recurrence then supplies delta_0=theta_0+hE_N.
Restoring G_N=e_P(r) gives some integer k with

```text
|h*16^N*pi-k/(15P)|
 <=16^(-(J-1))*(1/250+|h|E_(N+J-1)).
```

As an approximation to pi, the unreduced denominator is **15P|h|16^N**.
At J=o(N) the supplied precision has exponent1+o(1) relative to it, too weak
even to contradict an irrationality-exponent-two bound. No reduction of this
denominator is proved. Greedy partition into variation-at-most1/100 blocks
uses at most1+100V blocks, giving one length at least J/(1+100V); this cannot
enlarge the available window or improve the approximation contradiction.

The finite entry test preserves more arithmetic data than arbitrary weights.
Write S_N=K+r/(P*m) reduced, 0<r<P*m, m|M and log m=6N+o(N). Choose the
canonical 0<r_0<P with r=r_0+P*k_0. The entries

```text
S'_N=K+(r_0+P*k)/(P*m), 0<=k<m, gcd(r_0+P*k,m)=1
```

have exactly the same reduced entry denominator and integer floor. Moreover
`Q(S'_N-S_N)=P*(M/m)*(k-k_0)`, preserving both prime projections at subsequent
indices within the fixed horizon, in particular throughout the homogeneous
piece, under the actual A forcing. Reducing v modulo m gives v_m=P^(-1) mod m and
`C'_N=e_m(h*v_m*r_0+h*k)`.

Let eta=8|h|4^omega(m)/m. Every target angle has at least two such choices
within eta for large N: an arc preimage contains a k-interval of length at
least eta*m/|h|=8*4^omega(m), including a longer half at a boundary.
Mobius inversion bounds the admissible count in an interval of length W
below by `W*phi(m)/m-2^omega(m)`. Since phi(m)/m>=2^(-omega(m)), there are
enough entries to exclude the actual one. Also m>=(omega(m)+1)! gives
omega(m)=o(N), hence eta=exp(-6N+o(N)). No actual numerator is evaluated.

Choose target entry phases from the two exact forced paths
`c_j^slow=e(-hE_(N+j))` and `c_j^fast=e(16^j/17-hE_(N+j))`.
The ratio of an approximating entry path to its target is e(16^j*delta),
|delta|<=eta, so variation changes by O(eta*16^J). Tail monotonicity and
16=-1 modulo17 therefore give

```text
V_slow=O_h(N^-2)+exp(-6N+o(N)),
V_fast=2*sin(2*pi/17)*(J-1)+O_h(J/N^2)+O(eta*16^J).
```

These entries retain exact future A, entry denominator, floor and projections,
but lose zero initialization, actual prior history and any claim of equal
later reduced denominators. Neither selects the actual variation regime or
constructs an infinite avoiding orbit. The preceding F example separately
retains initialization while changing the forcing and total constant.

The useful actual Abel cost remains unproved. Its concentration reformulation
is not proposed as a new proof step; the variation route is suspended.
Independent review and 501 exact synthetic checks are recorded in the
[review record](agy-reports/m4-continuation-review.md). Those checks do not
certify trigonometric bounds, asymptotics, source theorems or actual states.
No Lean or V/M4 conclusion, actual-state census or originality claim follows.
