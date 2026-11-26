# M4: positive transforms with growing cancellation order

Status, 2026-11-26: paper mathematics and exact finite checks, independently
reviewed. No production Lean export or unconditional V theorem.
This records a positive result from fresh-context recovery and tests its
actual approximation consumer. It does not equate acceleration with visitation.

## Exact input and a positive block identity

Use C_n=binomial(2n,n), Cat_n=C_n/(n+1), u_n=C_n^3/256^n. The assessed
[Ramanujan identity](m4-transforms-and-periods.md#ramanujan-reciprocal-series-fast-convergence-and-its-arithmetic-location)
is sum (6n+1)u_n=4/pi. The neighboring-term ratio gives exactly

```text
(6n+1)u_n=8n*u_n-8(n+1)*u_(n+1)+(6n+5)*u_n/[4(n+1)^2].
```

Summing on any finite interval p<=n<=q retains both displayed boundary
terms. Sending q to infinity is justified by C_n<=4^n, hence
8n*u_n<=8n/4^n ->0. With p=0 this gives

```text
H=sum_(n>=0) h_n=16/pi,
h_n=(6n+5)*C_n*Cat_n^2/256^n >0.
```

These coefficients are integers since Cat_n=C_n-binomial(2n,n+1).
If A_N is the original Ramanujan integer numerator and B_N the one for H,
the finite identity says

```text
B_N=4*A_N+(N+1)*(C_(N+1)/2)^3.
```

This retains the actual dependence between anchors. Writing s(n) for the
binary digit sum, Legendre's formula and unique minimum valuation give

```text
w_N=s(N)+2s(N+1)-2,
v_2(B_N)=w_N,
x_N=4/(B_N/256^N)=2^(8N+2-w_N)/(B_N/2^w_N).
```

Indeed the term j places before the last has valuation excess at least
8j-3s(j)>=5j>0, by digit-sum subadditivity. The denominator is odd and
no odd cancellation is possible. At N=0 the formula gives x_0=4/5.

The strict ratio bound h_(n+1)/h_n<1/4 follows after clearing positive
denominators from `120n^3+416n^2+440n+149>0`. For H_N=sum_(n<=N)h_n,
with h=h_(N+1), it gives the explicit enclosure

```text
4/(H_N+4h/3) < pi/4 < 4/(H_N+h) < x_N,
0<x_N-pi/4<epsilon_N=16h/[3H_N(H_N+4h/3)].
```

A concrete consumer of this rational enclosure is available. For any orbit
index m define r=fract(4*16^m*x_N) and
delta=4*16^m*epsilon_N+8/[15(8m+9)]. If
`0<=a<b<=1` and `a+delta<r<b-delta`, then B1--B3 imply
`bbpRecurrence (m+1)` is in (a,b). The absolute tail bound and the margins
prevent crossing either endpoint when subtracting the approximation error
and BBP tail. Requiring m>=M retains the late-visit threshold. **The existence
of such m and r is not proved.** The first unsupported step remains an
arithmetic estimate placing actual modular phases inside those margins.

## Arbitrary order retains positive integer coefficients

For r,n>=0 put

```text
v_r(n)=u_n/(n+1)_r^2,
c_r=(2r)!/r!,
D_r(n)=c_r*C_n/(n+1)_r=(2r)!(2n)!/[r!n!(r+n)!].
```

The empty rising factorial is one. D_r(n) is a positive integer. For an
elementary verification, it equals
`(-1)^r [z^(r+n)](1-z)^(2r)(1+z)^(2n)`.
Taking the constant term after z=exp(i theta) reduces this equality to the
integral of sin^(2r)(theta/2) cos^(2n)(theta/2). Repeated integration by
parts, starting with the integral of 1, gives the displayed factorial
quotient. Thus no assumption of integrality of a factorial ratio is needed.
Equivalently D_r(n)=C_r*C_n/binomial(r+n,r).

Direct multiplication gives the exact identity

```text
(6n+4r+1)v_r(n)
 =8n*v_r(n)-8(n+1)*v_r(n+1)
  +(2r+1)^2/4*(6n+4r+5)*v_(r+1)(n).
```

For each fixed r, the boundary term again tends to zero. Multiplication by
c_r^2 and c_(r+1)=2(2r+1)c_r proves by induction on r that

```text
t_r(n)=(6n+4r+1)*C_n*D_r(n)^2/256^n,
H_r=sum_(n>=0)t_r(n)=4*16^r/pi.
```

There is no interchange of an infinite order limit with a sum: the identity
is first proved for each natural r. One may then choose r depending on N.

Source comparison identified this as an existing WZ family, not a new identity:
[Guillera, Generators of some Ramanujan formulas](https://arxiv.org/pdf/1104.0392),
printed p.4, first formula under “Some more series.” Its term is
`(6n+4r+1)*C_n^3*C_r^2/[256^n*16^r*binomial(n+r,n)^2]` and its sum is
4/pi, exactly our normalization divided by 16^r. The parent visually
checked that formula. Only integer r>=0 is used; no real-parameter extension
or Carlson theorem is needed in the elementary proof above.

For finite sums put

```text
B_(r,N)=256^N*sum_(n<=N)t_r(n),
x_(r,N)=16^r*256^N/B_(r,N).
```

They satisfy both exact positive integer recurrences

```text
B_(r,N)=256*B_(r,N-1)+(6N+4r+1)*C_N*D_r(N)^2  (N>=1),
B_(r+1,N)=16*B_(r,N)+(N+1)*C_(N+1)*D_r(N+1)^2/2.
```

The correction in the second recurrence is integral since C_(N+1) is even.
These are stronger constraints than independently chosen congruence classes.
Legendre's formula now simplifies to v_2(D_r(n))=s(r+n). The same unique
minimum argument, valid for every r,N, gives

```text
d=s(N)+2s(N+r), e=4r+8N-d>=0,
v_2(B_(r,N))=d,
x_(r,N)=2^e/q, q=B_(r,N)/2^d odd.
```

Here s(j)<=j implies d<=3N+2r and hence e>=5N+2r. No growing odd factor
can cancel against the pure power-of-two numerator.

## Uniform accuracy and height comparison

The adjacent-term ratio is

```text
t_r(n+1)/t_r(n)
 =(6n+4r+7)/(6n+4r+1)*(2n+1)^3/[32(n+1)(n+r+1)^2] <1/4.
```

Both r-dependent factors decrease as r grows, so it suffices to check r=0.
Clearing its denominators gives `24n^3+48n^2+24n+1>0`. Thus, for the tail
R=H_r-sum_(n<=N)t_r(n), we have t_r(N+1)<R<4t_r(N+1)/3.

The first term, normalized by 16^r, is
W_r=(4r+1)*C_r^2/16^r. We have W_0=1 and

```text
W_(r+1)/W_r=(4r+5)(2r+1)^2/[4(4r+1)(r+1)^2]>1,
```

because numerator minus denominator is 1. Since 3<pi<4, the normalized
partial sum lies in [1,4/3). Consequently

```text
2^e<=q<(4/3)*2^e,
(9/16)*t_r(N+1)/16^r < Delta=x_(r,N)-pi/4
                                  <(4/3)*t_r(N+1)/16^r.
```

All bounds are uniform in r,N. They give computable rational enclosures and
can replace the order-one enclosure in the preceding BBP margin consumer.

They also limit how much increasing r helps. Put m=N+1. The elementary
binomial bounds C_j>=4^j/(2j+1) and binomial(r+m,r)<=2^(r+m) give

```text
D_r(m)>=2^(r+m)/[(2r+1)(2m+1)],
P=(2r+1)^2*(2N+3)^3, a=6N+4r+7,
Delta > [9a/(256P)]*2^(-2r-4N).
```

Since e=4r+8N-d and q>=2^e, this implies

```text
Delta > [9a/(256P*2^(d/2))]*q^(-1/2),
2^(d/2)<=sqrt(N+1)*(N+r+1).
```

The latter inequality follows from 2^s(j)<=j+1. If x_(r,N) and pi/4
actually have L common hexadecimal digits, necessarily Delta<16^(-L).
Therefore, uniformly over all choices of growing order and truncation,

```text
L < (1/2)*log_16(q)
    + log_16(256P*sqrt(N+1)*(N+r+1)/(9a))
  = (1/2)*log_16(q)+O(log(N+r+2)).
```

Since log q grows linearly with r+N, this is eventually less than
log_16(q) as r+N tends to infinity. Except for r=N=0, the approximant is
strictly between pi/4 and 1, so q>1. Its complete period T satisfies
q | 16^T-1 and hence T>log_16(q). Thus **no selection of r,N makes the
available common-prefix window cover even one complete period** eventually.
This does not rule out early occurrences or prove any word absent from pi.

The balanced diagonal attains the exponent 1/2 in this accuracy/height
comparison: D_N(N+1)=2C_N and C_(N+1)=2(2N+1)C_N/(N+1) give

```text
t_N(N+1)/16^N
 =(10N+7)(2N+1)*C_N^3/[32(N+1)*4096^N],
-log_2(Delta)=6N+O(log(N+1)),
log_2(q)=12N-3s(N)+O(1).
```

The elementary bounds on C_N suffice for these logarithmic estimates.
This is an error-rate statement, not a lower bound on the actual common
prefix. It matches the leading accuracy/height ratio already available
from the M=12 Ramanujan series; it does not surpass that earlier benchmark.

## What changes next

The recovery pass produced an exact positive identity and a family of actual
integer recurrences with usable enclosures. Increasing order can improve the
original M=8 approximation rate, but the uniform bound settles this particular
attempt to make complete-period information transfer. Further acceleration
alone is suspended as a visitation mechanism. The unresolved consumer needs
actual ordered modular positions, or a different way to contradict avoidance.
No conditional premise has been promoted to V, and this checkpoint does not
end the authorized milestone.

The worker also supplied a coherent rational-limit countermodel in its
immutable report: it retains positive hypergeometric forcing with coefficient
6n+1+O(1/n), initial partial sum one, an integer recurrence and power-of-two
inverse numerators, but tends to 1/3. It deliberately changes the exact
coefficient and pi enclosure. This diagnoses the relaxed cross-anchor claim;
the exact identities above, rather than that model, are the retained positive
result. The detailed model is not a premise of the uniform family argument.

## Evidence and limits

Order-one report `/tmp/pi-m4-catalan-positive-transform-report-v1.md`, SHA-256
`f960771cdaf68960e9e4539206bdb8f3febcbf50656ea37b795134a8b85783ce`;
checker `/tmp/pi-m4-catalan-positive-transform-check-v1.py`, SHA-256
`d837696ec9e2ce23e1b69b114de79347163b4df4cd4d7b5a695c7a6f779bc6fa`.
Parent inspection and execution passed: 513 local identity/valuation/ratio
cases, 65 independent BBP enclosures and 561 block identities, plus the
supplementary model and finite checks of the proposed extension.

Parent checker `/tmp/pi-m4-growing-catalan-check-v1.py`, SHA-256
`149c5c52d7ac7b760b4006729e8edcaad25e05a4b3ce2d479dd80bbfe867d7b8`,
exited 0: 1,681 pairs for integrality, telescoping, valuations, enclosures and
uniform lower bounds; 1,640 order recurrences; and 80 diagonal difference
identities. Its exact rational pi enclosure uses positive BBP terms and the
checked absolute majorant. Receipt:
`/tmp/pi-m4-growing-catalan-receipt-v1.json`. Source image:
`/tmp/pi-m4-guillera-generators-page-4.png`.

These are finite consistency checks. The source identity and universal paper
proofs are not Lean theorems. No production build or new axiom audit is claimed.
