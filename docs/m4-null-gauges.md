# M4 variable rational corrections: finite blocks and the shadowing cost

This 2026-11-26 paper diagnostic tests a variable-degree rational correction
to the actual BBP forcing. It preserves the constant pi and zero initialization,
but changes the forcing. No visitation estimate or Lean theorem follows.
The [proof plan](proof-plan.md#5-prove-the-missing-universal-visitation-theorem)
owns V; the [review record](agy-reports/m4-continuation-review.md) owns review
status. The earlier [null-family analysis](m4-generating-functions.md) and
[pole-orbit assessment](m4-rational-forcing.md#pole-structure-a-sharper-separating-example)
remain relevant boundaries.

## Exact correction and arbitrary finite blocks

Let r be a rational function defined at every nonnegative integer, with
r(0)=0 and r(x) tending to zero as x tends to positive infinity. Set

    g(x)=A(x)+16*r(x)-r(x+1).

Finite telescoping, absolute convergence and the vanishing boundary term give

    sum_(j>=0) g(j)/16^j=pi,
    S^g_n=S_n-r(n+1), E^g_n=E_n+r(n+1).                  (1)

Both recurrences start at zero. Without r(0)=0, the infinite sum acquires
16*r(0), and the prefix acquires 16^(n+1)*r(0). The changed tail in (1) need
not be positive. It still tends to zero, so the usual strict inner-interval
argument transfers late visitation equivalently between g and the pi orbit.
This does not make every finite block of their fractional parts close.

Fix natural n,K, positive J and rational t. Let D=J+K+2 and

    Q(X)=product_(h=1)^D (X+h+1/8), x_j=n+j+1,
    v_j=S_(n+j)-16^j*t,                 0<=j<=J.

Interpolate a rational polynomial L of degree at most J with
L(x_j)=v_j*Q(x_j)/x_j and set r(X)=X*L(X)/Q(X). All nodes and denominators
are nonzero, and

    r(0)=0, r(x_j)=v_j, r(X)=O(X^(-K-1)),
    S^g_(n+j)=16^j*t, g(n+j)=0 for 1<=j<=J.              (2)

The new poles are simple, negative and in the original -1/8+Z shift orbit.
The total pole count grows. The other three original poles are unchanged,
and the weighted residue in each of the four shift orbits is unchanged:
sum_k 16^(-k)*(16*c_k-c_(k+1))=0. Increasing K preserves any prescribed
finite number of algebraic tail coefficients, not every order simultaneously.
No positivity or complete monotonicity of g is asserted.

For t=floor(S_n)+1/5 every transformed fractional part in this block is 1/5.
This finite construction keeps pi and zero initialization, unlike the earlier
entry perturbation, but it changes the rational forcing. It is not an infinite
avoiding orbit. In the exact example n=2,J=5,K=2,

    t=4021/5, r(3)=7102/153153,
    r(8)=7751957344122109581452776/154923473562396513975.

The correction grows from a small anchor value to more than 50000 by the last
node. Finite block programming alone does not transfer a visit or avoidance.

## Uniform shadowing forces the original phase approximation

If S^g_n=t and g(n+j)=0 for 1<=j<=J, put Delta=16^n*pi-t. Equation (1) gives

    r(n+j+1)+E_(n+j)=16^j*Delta.                          (3)

Consequently abs(r(n+j+1))<=eta throughout the block implies

    abs(Delta)<=16^(-J)*(eta+E_(n+J)).                    (4)

Allowing large integer corrections does not remove this cost for a small
uniform circular margin. Suppose 0<eta<=1/34 and dist(r(n+j+1),Z)<=eta
for every 0<=j<=J. Write r(n+j+1)=k_j+epsilon_j with k_j integral and
abs(epsilon_j)<=eta. Since the forcing of g is zero on the block,

    k_(j+1)-16*k_j=A(n+j+1)+16*epsilon_j-epsilon_(j+1).

For these positive coefficient indices, 0<A(n+j+1)<4/9. The right side has
absolute value below 4/9+17/34=17/18<1, so the integer is zero. Therefore
k_j=16^j*k_0 and (3) yields

    dist(16^n*pi-t,Z)<=16^(-J)*(eta+E_(n+J)).              (5)

Adding k_0 to the rational seed changes neither its reduced denominator nor
its circle orbit. Thus uniform circular shadowing also requires exponentially
accurate approximation to the actual initialized phase. An argument needing
closeness only at a separately located occurrence time is outside this uniform
bound; no impossibility claim about such a sparse transfer is made.

## Degree or denominator content must pay for old primes

Write r=P/R with integral polynomials, R nonzero on the block. If
S^g_n=a/Q in reduced form, Q>0, then q_n=den(S_n) divides Q*R(n+1).
For d=deg R and H its largest absolute coefficient,

    log H+d*log(n+2)+log(d+1)>=6n-log Q+o(n),              (6)

using the assessed log q_n=6n+o(n). This concerns an integral polynomial
representation; sparse partial fractions can have a different written cost.

For a full block there is an additional root-count constraint. Use n>=1,
1<=J<=floor(n/2) and the established fresh-prime product

    P_n=product {p prime: p=1 mod4, 4n+3<p<=8n+1}.

Every p|P_n has valuation -1 in all S_n,...,S_(n+J): it divides none of
the intervening coefficient denominators. Let C>0 be the content of R and
T_j=S_(n+j)-r(n+j+1). If p does not divide C, the nonzero polynomial R
modulo p has at most d roots among the J+1 distinct nodes. At every other
node r is p-integral, so T_j retains valuation -1. For d<=J this proves

    [P_n/gcd(P_n,C)]^(J+1-d) divides product_(j=0)^J den(T_j). (7)

In particular, removing all these primes at all nodes forces P_n|C, and
H>=C>=exp(2n+o(n)). For a homogeneous rational block T_j=16^j*a/Q,

    (J+1)*log Q >= (J+1-d)*log[P_n/gcd(P_n,C)].            (8)

This does not exclude degree J+1 or exponential denominator content. It
quantifies what an alleged inexpensive block cancellation has to retain.

The individual-prime count is sharp. For 1<=d<=J, let U be the monic product
of d selected node factors. Choose M=1 modulo p large enough that R=U+p*M
has no zero on the block. At selected nodes R=p*M; interpolation of integral
P modulo p with P(x_j)=p*S_(n+j) modulo p cancels precisely those d principal
parts. At the others R is a p-unit. The leading coefficient of R is 1, so its
content is 1. For d=0 use r=0,R=1 separately. This sharpness example imposes
no real smallness and supplies no visitation estimate.

## Uniform prime survival strengthens the block cost

The positive compression result has a uniform consequence: for fixed
alpha>0 and kappa>=0, every sufficiently late n has the following property.
Every prime eligible at n with p>alpha*n has v_p(S_m)=-1 simultaneously
for n<=m<=(1+kappa)*n. Choose fixed H with H+1>(1+kappa)/alpha and apply
the existing fixed-H survival theorem at each m; eligibility is monotone.
The same threshold works because m>=n. This does not let H grow with n or
ignore new pole entries. The full compressed states remain nonzero.

Let r_n=P_n/R_n be integral polynomial representations with denominator
degree d_n and positive content C_n. Suppose the first d_n+1 corrected
states form the same homogeneous rational orbit:

    S_(n+j)-r_n(n+j+1)=16^j*a_n/Q_n,  0<=j<=d_n,

where a_n/Q_n is reduced and Q_n>0. For any squarefree prime product G whose
factors satisfy p>d_n and v_p(S_(n+j))=-1 at every node, root counting gives

    G divides C_n*Q_n.                                  (9)

Indeed, for p not dividing Q_n the denominator polynomial vanishes modulo p
at d_n+1 distinct nodes, so every coefficient is divisible by p. This exact
divisibility applies to any displayed integral representation; no polynomial
coefficient denominator is discarded.

If d_n=o(n), fix H>=1 and use all primes eligible at n with p>n/(H+1).
Eventually they exceed d_n; uniform survival with kappa=1 covers the block.
Their product has logarithm (6-1/(H+1))*n+o(n), by the previously assessed
PNT in fixed progressions. First take the limit inferior for each fixed H,
then let H increase. Equation (9) gives

    liminf_(n->infinity) (log C_n+log Q_n)/n >= 6.         (10)

The same holds with denominator coefficient height in place of C_n.
It is a combined correction-and-seed cost, not a bound on either factor
alone. This removes the d_n*log n allowance in (6) when the homogeneous
block supplies d_n+1 states. No effective threshold follows.

For fixed theta>0 and d_n<=theta*n, the exact analogous lower bound is

    F(theta)=((8-theta)_+ +(4-theta)_+)/2,

where x_+=max(x,0). Use p>theta*n and uniform survival with kappa=theta.
The two eligible supports end at 8n+5 and 4n+3, so F(theta)=6-theta for
0<theta<=4, 4-theta/2 for 4<=theta<=8, and 0 thereafter. Bounded endpoint
shifts contribute at most O(log n). This does not assert a prescribed rate
of survival for a cutoff tending to zero.

Eventual uniformity is essential. The actual prime p=19 survives S_8 but
cancels in S_9. Put a=19*S_8, b=20*S_9 and
L(X)=(b-a)*X+a-9*(b-a). Its coefficients have common denominator D prime
to 19. Then P=D*L and R=D*(X+10) interpolate r(9)=S_8,r(10)=S_9, with
deg R=1 and content D prime to 19. Both corrected states are zero, yet 19
does not divide C*Q. This violates no theorem above: the required survival
at every node fails. It is not a zero-anchored gauge or an asymptotic example.

## Evidence and remaining bridge

The parent read both full checker sources and the report, reconstructed the
telescoping, interpolation, lifting and root-count arguments, and replayed
both exact checkers with exit 0. They cover 126 gauges, 567 interpolation
conditions, 441 zero-forcing identities, 1,323 prefix identities, 1,134 finite
tail telescopings, 126 anchor-height tests, 3,775 old-prime checks, 537
occupation products, 282 sharp positive-degree examples and 756 circular lifts.
These are finite algebra checks; the example's floor is used to construct
the gauge, not to infer distribution of pi digits.

Frozen report `/tmp/pi-m4-null-gauge-report-v1.md`, SHA-256
`5c5a93bb3284e577f630f903c4c3ac5c8e8ca35b06580f7e455e58892aeaec04`,
and `/tmp/pi-m4-null-gauge-receipt-v1.json`, SHA-256
`715ef78e5f9d456f5772110de4637f12ee666c4562d092e3e78ca119f468a0c5`,
retain the complete derivations and checker hashes. The report's sharpness
construction is interpreted for positive degree, with degree zero separated
above. The separately frozen root checker v2 uses `math.isqrt` and retains
the original assertions/counts; the v1 checker remains unchanged.

The uniform extension is `/tmp/pi-m4-null-gauge-uniform-report-v1.md`, SHA-256
`16d47d5abd435e064d50fcd4b9141e32a717c5e35e0b6a25996804ca3d9ed8a6`.
Its receipt `/tmp/pi-m4-null-gauge-uniform-receipt-v1.json`, SHA-256
`86b7f3106455d221b10d5de2e1a1fcc02f761715ccefe05781b65f317dddb3ae`,
records 537,253 compression comparisons, 20,996 finite certified prime/block
pairs, 419,769 survival nodes, 171 content-divisibility constructions and
the finite p=19 countercondition. It also preserves the integer-square-root
revision and degree-zero clarification. These finite checks are not an
asymptotic proof or a certification of PNT.

The first unsupported implication is still a real cylinder-margin bound for
the constructed correction. Equations (3)--(5) identify the initialized-phase
approximation that it must prove. Denominator cancellation, arbitrary finite
interpolation and preservation of the constant do not establish that estimate.
No positive V argument survives this test. Independent review completed with
no D/I/Q items; the review record retains its scope and evidence limits.
