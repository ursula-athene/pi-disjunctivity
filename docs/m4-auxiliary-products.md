# M4 continuation: avoidance detectors and coupled auxiliary products

Research record, 2026-11-26. A fresh-context pass tested whether a forbidden
interval could feed pi's Gaussian-logarithm arithmetic through an explicit
polynomial detector. A follow-up tested two consecutive prefixes. These paper
arguments and exact arithmetic checks do not prove V, and no new Lean theorem
or acceptance claim is made. The [M4 target](proof-plan.md#m4-research-sequence--2026-11-26)
still requires every interval and every natural threshold.

## A detector with the right sign

For `0<=x<=1`, set

```text
z=x*(1-x),  g(x)=z*(z-3/16),  q(x)=1+g(x),
P(x)=16*q(x)=16*x^4-32*x^3+19*x^2-3*x+16.
```

Since `0<=z<=1/4`, one has `1015/1024<=q(x)<=65/64`, and `q(x)>1`
exactly on `J=(1/4,3/4)`. Direct polynomial integration gives
`integral g=1/480` and `integral g^2=13/161280`. The inequality
`log(1+u)>=u-u^2` for `abs(u)<=1/2` follows by differentiation: its difference
decreases to zero on `[-1/2,0]` and increases from zero on `[0,1/2]`. Thus

```text
integral_0^1 log(q(x)) dx >= 323/161280 > 0.
```

This repairs a real issue with the simpler detector `x*(1-x)`: its geometric
mean `exp(-2)` is below its maximum `3/16` on J's complement, so even uniform
distribution would not yield the desired strict product comparison for it.
Lebesgue mean positivity for the repaired q is not an assertion about pi's orbit.

Write `t_j=fract(16^j*pi)` and `p_j=floor(16^j*pi)`, and define

```text
F_(N,L)(X)=product_(j=N)^(N+L-1) P(16^j*X-p_j),
F_(N,L)(pi)/16^L=product_(j=N)^(N+L-1) q(t_j).
```

The sufficient intermediate claim `forall N, exists L>=1, F_(N,L)(pi)>16^L`
would give arbitrarily late visits to J: the product must have a factor above 1.
It is still stronger than mere visits, since visits alone do not control the
negative logarithmic contributions of other terms. A positive limiting average
would be stronger again and is unnecessary for this test. Neither estimate is
proved. Even proving this central-hole case would leave other intervals and
the exact recurrence transfer; it would not accept M4.

## Height and content: the independent product does not suffice

The degree is `4L` and the leading coefficient is exactly
`16^(L+4*sum_(j=N)^(N+L-1) j)`. Since `0<=p_j<4*16^j`, the coefficient
height H also has upper bound `C^L*16^(4*sum j)` for an absolute constant C,
by the coefficient l1 norm. Consequently `log H=4*(sum j)*log16+O(L)`,
quadratic in L for fixed N. The detector comparison gains only a fixed
exponential factor per iterate. Increasing a fixed detector's multiplicity
scales both costs and does not remove their mismatch.

Nor does digit avoidance alone force enough primitive-part cancellation.
For the exact avoiding model `x=1/15`, all hexadecimal digits are 1 and, for
`j>=1`, its prefix `r_j=(16^j-1)/15` is 1 modulo 16. The constant term of
`P(16^j*X-r_j)` is `P(-r_j)=6 mod16`. All its nonconstant coefficients are
divisible by 16 and its leading coefficient is a power of 2. Thus its integer
content is exactly 2. Gauss's content lemma gives content `2^L` for the product
over `j=1,...,L`; its primitive leading coefficient is
`2^(3L+16*sum_(j=1)^L j)`. The quadratic cost survives. Gaussian ramification
of 2 changes its prime valuation convention, not this scale comparison.

This model refutes that intermediate content claim. It does not possess pi's
logarithm relation and therefore does not refute the pi-specific product target.

Mahler, [*On the approximation of pi*](https://ems.press/content/book-chapter-files/27418)
(1953; reprint pp.557–570), supplies a concrete neighboring auxiliary method.
Section 3, original p.31/reprint p.559, selects a nonzero auxiliary value at
`(i,i*p/(2q))`; multiplying by `(2q)^m` makes it a Gaussian integer.
Section 6, Theorem 1, original p.33 and its continuation on p.34, gives
`abs(pi-p/q)>q^(-42)` for positive integers p and `q>=2`.
Source text was inspected; no visual verification or formalization is claimed.

That nonvanishing argument applies at a Gaussian rational approximant, not
directly to F(pi), which is transcendental for nonconstant F. The rational
bound yields only `t_j>16^(-41j)` and `1-t_j>16^(-41j)` for `j>=1`.
Multiplying these bounds cannot supply the required positive normalized
product. This tests this application, without claiming that every possible
pi-specific auxiliary method is exhausted.

## Two-prefix coupling: an exact identity that eliminates pi

For `a=16^j`, `p=p_j`, and digit `d=floor(16*t_j)`, the next prefix is
`16p+d`. Put `G_d(Z)=P(16Z-d)` and `R_d=Res_Z(P,G_d)`. The root-product
definition of the resultant gives

```text
Res_X(P(aX-p),P(16aX-16p-d)) = a^16*R_d.
```

Indeed, the first polynomial's leading coefficient is `16*a^4` and its roots
are `(alpha+p)/a`, where alpha ranges over P's four roots; the second evaluates
there to `G_d(alpha)`. This proves the scaling for every nonzero a.

There are no vanishing real-d cases. Centering with `u=2Z-1` gives
`4P((u+1)/2)=4u^4-5u^2+65`; its roots have squares
`(5 +/- i*sqrt(1015))/8`, so all have the same positive absolute imaginary
part. The affine map `u ->16u+15-2d` multiplies that part by 16 and cannot
send a root to another root. Conjugate pairs then show `R_d>0` for real d.
The symmetry `P(1-Z)=P(Z)` also yields `R_d=R_(15-d)`.

For integer digits, the resultant supplies integer polynomials U_d,V_d of
degree at most 3 with

```text
U_d(Z)*P(Z)+V_d(Z)*P(16Z-d)=R_d.
```

Substituting `Z=aX-p` retains that constant, independent of a and p; the
canonical factor `a^16` is avoidable in this Bézout representation. But at pi
the result is only `U_d(t_j)*P(t_j)+V_d(t_j)*P(t_(j+1))=R_d`. Its integrality
comes from an identity valid for every argument. In the all-1 avoiding model,
`d=1`, `t_j=t_(j+1)=1/15`, and `P(1/15)=803686/50625<16`; the identity still
holds. In particular it cannot imply that one of these factors exceeds 16.

The pi-specific rewriting `Z(Y)=-2*i*a*Y-p` does not repair this. At
`Y=log(i)` it gives the actual prefix; at `Y=i*p/(2a)` it gives Z=0.
Both evaluations of the identity equal R_d, so subtracting them gives zero,
not a nonzero analytic remainder. The relation `exp(log(i))=i` never enters.
The cancellation of scale has also removed the information about pi.

A different auxiliary expression would need all three properties jointly:
a nonzero Gaussian integer at rational approximants, a controlled remainder
at the genuine logarithm, and a gain from avoidance that beats its actual
height and denominator. Neither the independent product nor this coupled
resultant supplies them. Calling for Hermite–Padé approximation without such
a construction would only rename the missing step. This particular route is
suspended; M4 continues with a different discovery question.

## Verification

The immutable reports are `/tmp/pi-m4-avoidance-auxiliary-report-v1.md` and
`/tmp/pi-m4-two-prefix-resultant-report-v1.md`. The parent inspected and reran
both standard-library exact-arithmetic checkers, with exit 0:

- `/tmp/pi-m4-avoidance-auxiliary-check-v1.py`, SHA-256
  `250ddd1639373d4b4e517f455762896f2af263ff190362eaa03dd7e3d12e9426`:
  detector integrals and contents for lengths 1–8.
- `/tmp/pi-m4-two-prefix-resultant-check-v1.py`, SHA-256
  `279b4fc82fde3f690269474d66c72a002fd59e3f486a97e457e974924a7ceced`:
  all sixteen digit resultants, Bézout identities, symmetry, three substitution
  pairs per digit, and the all-1 evaluation. Polynomial Euclid and an independent
  Sylvester/Bareiss determinant check the two constructions.

The complete coefficients are retained in the immutable JSON receipt
`/tmp/pi-m4-two-prefix-resultant-receipt-v1.json`, SHA-256
`2333ead8fc66ce507badd5c026fddb5f90153835624c4cccec8b6e130fab0517`.
The universal height, content, and nonvanishing arguments are the paper proofs
above, not extrapolations from those finite cases. No new kernel claim is made.
