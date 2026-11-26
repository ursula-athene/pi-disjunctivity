# Actual BBP reflected zero and coherent 2-adic prefix invariant

Research checkpoint, 2026-11-26; independent changed-file review complete. This cycle proves on paper that the actual reflected BBP series vanishes in Q_2. Consequently every initialized weighted rational prefix is the value of one analytic isometry of Z_2, with exact pairwise valuations and no initial transient. This is an actual infinite cross-anchor identity, not a finite residue prescription. It does not prove real interval visitation. V and M4 remain open, and the parent continues the authorized research.

All universal statements here are paper arguments, not Lean exports. The parent read and reran the exact checker successfully. No pi digits were searched. The companion [avoiding models](m4-two-adic-models.md) test which of these properties alone can constrain the real orbit.

## 1. Exact coefficient domain and local isometry

Let Z_(2) denote the rationals with odd reduced denominator, embedded in Q_2, and normalize v_2(2)=1. The actual BBP coefficient has the rational identity

A(x)=4/(8x+1)−2/(8x+4)−1/(8x+5)−1/(8x+6)
    =P(x)/D(x),
P(x)=120x^2+151x+47,
D(x)=(2x+1)(4x+3)(8x+1)(8x+5).             (1)

The second expression defines A on all Z_2: every denominator factor is a unit. In particular A(n) belongs to Z_(2) for every integer n, positive or negative. The original fractions and (1) agree at every such integer.

There is more than mere compatibility modulo powers of 2. The polynomial D has odd constant term15 and all its other coefficients even. For x,y in Z_2,

[P(x)−P(y)]/(x−y)=120(x+y)+151

is odd, while [D(x)−D(y)]/(x−y) is even. These quotients are polynomial divided differences, also defined when x=y. Therefore the divided difference of A is a 2-adic unit. For x≠y,

v_2(A(x)−A(y))=v_2(x−y).                    (2)

Thus A is a 2-adic isometry. In particular A(n+2^k)≡A(n) modulo2^k, and their difference has valuation exactly k.

## 2. Analytic graph and the initially unresolved anchor

Define, for x in Z_2,

B(x)=Σ_(j≥0)16^j A(x−j).                    (3)

Every A(x−j) is integral, so this series converges uniformly: its j-th summand has valuation at least4j. It also defines an analytic function on Z_2. To see this directly, expand the four reciprocal linear factors of D(x−j) around x=0. Their constant terms are odd and their slopes divisible by2. The coefficient of degree d in A(x−j) has valuation at least max(0,d−2), uniformly in j. Multiplication by16^j and summation gives convergent power-series coefficients with the same bound, tending to zero as d increases. The joint bound justifies the required coefficient summations.

Reindexing the convergent series gives

B(x)=A(x)+16B(x−1).                         (4)

Moreover, after dividing B(x)−B(y) by x−y, its first summand is the unit supplied by (2), and every remaining summand is divisible by16. Hence

v_2(B(x)−B(y))=v_2(x−y)  for x≠y.           (5)

For the actual weighted prefix, set S_(−1)=0 and

S_n=Σ_(j=0)^n16^(n−j) A(j),  n≥0.

From (4), before knowing the anchor, one only obtains

S_n=B(n)−16^(n+1)B(−1).                     (6)

A generic forcing with odd denominators has an eventual local graph of this kind. The new actual identity is B(−1)=0, proved next; it removes the transient term exactly.

## 3. Rigorous reflected-zero identity

The claim is

C := Σ_(j≥0)16^j A(−1−j)=0 in Q_2.          (7)

Work in the complete quadratic extension K=Q_2(t), with t^2=2 and v_2(t)=1/2. Define the formal series

L(z)=Σ_(m≥1)(−1)^(m+1) z^m/m,
T(z)=Σ_(m≥0)(−1)^m z^(2m+1)/(2m+1).

They are the zero-constant formal logarithm log(1+z) and arctangent. At every argument used below, valuation is at least1, so the series converge. For L this follows from m v_2(z)−v_2(m)→∞; for T, the odd denominators have valuation0. No complex logarithm or arctangent branch is being chosen.

Write H_r(u)=Σ_(j≥0)u^(8j+r)/(8j+r). Direct substitution into the original four terms gives

A(−1−j)=−4/(8j+7)+2/(8j+4)+1/(8j+3)+1/(8j+2),
C=[H_2(t)+H_4(t)]/2 + t[H_3(t)−H_7(t)]/4.  (8)

Here t^8=16. The right side is the value at u=t of the zero-constant formal primitive of

R(u)=[(u+u^3)/2+t(u^2−u^6)/4]/(1−u^8)
    =u/[2(1−u^2)(1+u^4)] + t u^2/[4(1+u^4)].

An explicit zero-constant primitive is

Ψ(u)=−L(−u^2)/8 + L(u^4)/16
     +[L(u^2−tu)−L(u^2+tu)]/16
     +[T(u^2)+T(tu/(1−u^2))]/8.             (9)

This is a formal power-series identity over K. To verify the derivative, put Q_±=1±tu+u^2. Then Q_−Q_+=1+u^4 and

(2u−t)/Q_− − (2u+t)/Q_+
    =2t(u^2−1)/(1+u^4),
[d/du] T(tu/(1−u^2))=t(1+u^2)/(1+u^4).

Together with L'(z)=1/(1+z) and T'(z)=1/(1+z^2), these give Ψ'(u)=R(u). Both primitives have constant0, so equality of their derivatives in characteristic0 proves their formal equality.

**Specialization and convergence.** On the closed disk v_2(u)≥1/2, one has v_2(u^2)≥1, v_2(tu)≥1, v_2(u^4)≥2, and 1−u^2 is a unit. Thus every argument of L and T in (9) has valuation at least1. All displayed compositions and the primitive in (8) converge there, including u=t. The primitive notation is formal; it is not a real path integral through the real pole at u=1, and no real convergence of the reflected series is asserted.

At u=t, the four logarithm arguments are −2,4,0,4, and the two arctangent arguments are2 and−2. Therefore

C=Ψ(t)=−L(−2)/8.                            (10)

Finally the formal logarithm identity

L(X)+L(Y)=L(X+Y+XY)

can be specialized at X=Y=−2, since all the series converge there. It gives 2L(−2)=L(0)=0, hence L(−2)=0. Equations (8)–(10) prove (7).

There is an independent primary-source verification of this final cancellation: Henri Cohen, *On the 2-adic Valuations of the Truncated Polylogarithm Series*, Fibonacci Quarterly37 (1999), printed p.117, Lemma2, proves Σ_(m≥1)2^m/m=0 in Q_2 using the corresponding Li_1 functional identity. [Primary PDF](https://www.fq.math.ca/Scanned/37-2/cohen.pdf). Its printed convergence condition is v_2(z)≥1, so z=2 is included; web OCR incorrectly renders some ≥ signs as >. Locally `/tmp/pi-m4-cohen-polylog-source.pdf`, SHA-256 `70e56e27e1ed2b6ccc74fc1ad7ea8c49172c1682af5520238c07964b942f3335`; the page was visually checked at `/tmp/pi-m4-cohen-reflection-page-1.png`. Cohen's lemma supports the final logarithm value, not the full BBP reflection identity or visitation.

## 4. Exact initialized-prefix consequences

Combining (6)–(7),

S_n=B(n) for every n≥0.                     (11)

These are equalities in Q_2 of the actual rational prefixes, not approximations. From (5), for distinct m,n≥0,

v_2(S_m−S_n)=v_2(m−n).                      (12)

Since B(−1)=0, one also obtains the exact valuation

v_2(S_n)=v_2(n+1),  n≥0.                    (13)

For every k≥0 and n≥0,

v_2(S_(n+2^k)−S_n)=k.                       (14)

In particular the residue sequence S_n modulo2^k has least period2^k from the first index, with no transient. Each block of2^k consecutive indices represents every residue exactly once. Injectivity of a residue block follows from (12), and its cardinality is2^k. The compatible inverse residue permutations also show that B maps Z_2 onto itself.

A second exact rational consequence concerns the finite reflected sum

R_M=Σ_(j=0)^(M−1)16^j A(−1−j),  M≥1.

Splitting the convergent series (7) gives

R_M=−16^M B(−M−1),
v_2(R_M)=4M+v_2(M).                         (15)

These conclusions retain dependence across all indices and all powers of2 simultaneously. No real normality or digit frequency is inferred from the complete local residue cycles.

## 5. A separating model calculation and the real-word consumer

The parent supplied a rational diagnostic with

r(x)=(x+c)/[(2x+1)(4x+1)(8x+1)],  c=424/2159,
g(x)=16r(x)−r(x+1).

For this comparison only, its exact relevant facts are g(0)=47/15, integrality on Z_2, and a unit divided difference. The latter follows because c is even in Z_2, the numerator has slope1, and the denominator has odd constant and even remaining coefficients. The term −r(x+1) dominates16r(x) in the divided difference of g. Thus the compatibility/isometry property alone does not select the actual coefficient function.

But direct 2-adic telescoping gives

B_g(x)=Σ_(j≥0)16^j g(x−j)=−r(x+1),
B_g(−1)=−424/2159≠0.                        (16)

The companion [model assessment](m4-two-adic-models.md#rational-isometry-model-with-a-nonzero-anchor) supplies its real avoidance and complete-monotonicity analysis. Equation (16) is proved here from its displayed rational formula; it shows exactly which new actual identity the model lacks. This is not a claim that reflected zero alone implies visitation, nor a full countermodel to all the new lemmas.

The actual real consumer remains

y_(n+1)=fract(S_n),
∀0≤a<b≤1, ∀N, ∃n≥N, a<fract(S_n)<b.

Equations (11)–(15) constrain the Q_2 images of the same rational S_n. A real forbidden word constrains their real fractional parts. The floor operation separating S_n into its integer part and its fractional part has not been related to the analytic graph (3). In particular no continuity, finite-state rule, or automaticity of the carries follows from the present argument.

There is no pointwise incompatibility between these two kinds of data. Given any real open interval I and any residue a modulo2^k, choose an odd positive q with q·length(I)>2^k and an integer p≡aq modulo2^k inside qI. Then p/q lies in I∩Z_(2) with the required residue. This elementary observation only identifies the missing pointwise bridge; it is not an infinite model preserving the actual A or its analytic graph.

No solenoid, adelic equidistribution, or automatic-sequence theorem is invoked without a verified hypothesis connecting the real floor/carry process to this graph. The output of this cycle is the proved positive invariant, with the real-word implication still unsupported. The separately constructed [analytic model](m4-two-adic-models.md) now preserves the coherent zero anchor, irrationality and exponential prefix heights while avoiding an interval. It drops the exact rational forcing, polynomial height of the individual coefficient and rationality at negative integers. Thus this positive invariant alone is insufficient; those lost restrictions identify the remaining opening.

## 6. Exact checks and status

`/tmp/pi-m4-two-adic-reflection-check-v1.py` exited0, SHA-256 `b329a79e2f0c956a41037a26df18dac3dc0d454b11220d8e2741ebe929be7f33`. It checks the derivative and endpoint algebra in Q[t]/(t^2−2), 513 coefficient identities, 256 prefix valuations, 2016 pair valuations, 128 reflected-sum valuations, complete residue tables through12 bits, reflected zero through512 bits, and the distinct nonzero reflected constant in (16). All computations use exact integers and fractions. They do not prove convergence or the infinite identity; those are the paper arguments in Sections2–3. No pi digits or real orbit searches were performed.

The exact V statement and initialization are unchanged. The checked B1–B3 results and conditional B4/P3 remain the Lean frontier; none of B4's visitation hypotheses is discharged. Independent review is complete; any selected implementation still requires ordinary kernel-checked proofs under the existing trust policy.

The positive-lemma endpoint is complete; M4 continues. The next inquiry asks whether the actual rational forcing controls odd-denominator characters well enough to transfer local residue information to real fractional parts.
