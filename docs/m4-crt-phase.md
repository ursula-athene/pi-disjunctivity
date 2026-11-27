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
