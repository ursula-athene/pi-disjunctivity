# M4 continuation: arithmetic windows and rational corrections

Research record, 2026-11-26. This tests one unconditional neighboring method
against the actual BBP sequence. It does not supply V. All universal arguments
below are paper proofs except the explicitly identified Dirichlet interface
probe. The exact [M4 contract](proof-plan.md#m4-research-sequence--2026-11-26)
and the checked B1–B3/conditional B4/P3 frontier are unchanged.

## A finite-frequency consumer

Write `e(x)=exp(2*pi*i*x)` and `u_n=bbpRecurrence(n+1)`. For an interval I
strictly inside `(0,1)`, choose a real trigonometric polynomial

```text
P(x)=c_0+sum_(0<abs(h)<=H) c_h*e(h*x),
P(x)<=1_I(x),  c_0>0.
```

Such a minorant follows by uniformly approximating a nonzero continuous
nonnegative bump bounded by `1_I`, then subtracting a sufficiently small
positive constant. If arbitrarily late windows `(M,...,M+J-1)` satisfy

```text
sum_(0<abs(h)<=H) abs(c_h)*abs((1/J)*sum_(j<J) e(h*u_(M+j))) < c_0,
```

then each such window contains a visit to I. Otherwise all its P values are
nonpositive, contradicting the positive average. An interior subinterval
handles targets touching 0 or 1. This sufficient test uses finitely many
frequencies for one interval, without requiring normality or making cancellation
at every frequency a new acceptance condition. No BBP estimate for it is proved.

## The solved-neighbor theorem and failed direct application

Bailey–Crandall, [*Random Generators and Normal Numbers*](https://www.davidhbailey.com/dhbpapers/bcnormal-em.pdf),
Experimental Mathematics 11(4), 2002, Theorem 4.6 (printed p.534), states:
for fixed coprime integers `b,c>1`, constants `A,B,D>0` exist such that, for
`J>=1`, sufficiently large r, and integer h with `gcd(h,c^r)<D*c^r`,

```text
abs(sum_(j<J) e(h*b^j/c^r))
  < B*(A*c^(r/2)+J*c^(-r/2))*log(c^r).
```

Their sparse-forcing construction has long intervals with one unchanged
modulus; Corollary 4.9(i), p.536, applies it to Stoneham constants
`sum_(i>=1) 1/(c^i*b^(c^i))`. This is unconditional, unlike Hypothesis A.
The source PDF text and its theorem hypotheses were inspected; usable visual
screenshots were not returned by the tool. No source theorem was formalized.

Let `S_m=bbpPartialSum m`, `E(m)=bbpTail m`. The checked split gives

```text
16^(m+j)*pi=16^j*S_m+16^j*E(m),
S_(m+j)=16^j*S_m+16^j*E(m)-E(m+j).
```

Thus the phase error in replacing the recurrence by the rational orbit of a
frozen prefix is bounded by
`2*pi*abs(h)*(16^j*abs(E(m))+abs(E(m+j)))`. B3 gives
`abs(E(m))<=8/(15*(8m+9))`; its available bound guarantees a uniformly close
window only at length `J=O(log m)` for fixed accuracy and frequencies.
This describes the guarantee, not an assertion that every longer actual
window has large error.

In contrast, the source estimate at `q=c^r` has normalized right side
`B*(A*sqrt(q)/J+1/sqrt(q))*log q`. Making this small needs windows large
relative to `sqrt(q)*log q`. For a unit numerator a and fixed nonzero h,
`gcd(h*a,q)<=abs(h)`, so its gcd condition eventually holds; that does not
remove the length requirement. BBP prefixes also lack its fixed modulus tower.
The denominator argument below makes that mismatch explicit, even after any
fixed rational correction.

The short-window issue is substantive. At `q=3^r`, seed 1 and
`J=floor(log_16(q)/2)`, every `16^j/q<=q^(-1/2)` for `0<=j<J`. Therefore

```text
abs((1/J)*sum_(j<J) e(16^j/q)-1) <= 2*pi/sqrt(q) -> 0.
```

These unit seeds satisfy the favorable coprimality conditions but do not
cancel on logarithmic windows. This is not a model of the actual BBP seed;
it refutes a seed-independent strengthening of the proposed short-window step.

## Any fixed rational correction: prime denominators survive

Fix `R=P/Q in Q(X)` with integer polynomials P,Q and Q nonzero, defined at
all sufficiently large natural inputs. Its degree and coefficients are fixed,
not chosen anew with m. Let `q'_m` denote the odd part of the reduced denominator
of the rational number `S_m+R(m)`.

First, a purely algebraic argument plus Dirichlet shows unbounded prime support.
Choose `k>=0` with `Q(k-5/8)!=0`, possible among `0,...,deg Q`. For sufficiently
large primes `p=5 mod8`, put `m=(p-5)/8+k`. Exclude primes dividing the fixed
nonzero integer `8^(deg Q)*Q(k-5/8)`. Then `p` does not divide Q(m).
If additionally `p>8k+1`, all coefficient denominators through m are less
than `2p`; exactly one equals p, namely `8*(m-k)+5`. Hence

```text
S_m=-16^k/p+(a p-integral rational),
v_p(S_m+R(m))=-1,       q'_m>=p=8m-8k+5.
```

The choice of k matters: `R_K(X)=sum_(ell=0)^K 16^ell/(8X+5-8ell)` cancels
precisely those offending terms at fixed offsets `0,...,K`. Choosing an offset
outside the finitely many denominator roots repairs the argument. The claim
with k=0 for every R would be false.

The pinned source theorem `Nat.forall_exists_prime_gt_and_modEq` in
`Mathlib/NumberTheory/LSeries/PrimesInAP.lean` specializes at modulus 8 and
residue 5 to

```text
forall N : Nat, exists p>N, p.Prime and p == 5 [MOD 8].
```

That small interface was compiled; the general valuation argument was not.
This alone proves a subsequence result, which would not exclude selecting
different favorable anchors. The next source-dependent step closes that gap.

### All-anchor strengthening using PNT in a fixed progression

Let M_m be the squarefree product of primes `p=1 mod4` in `(4m+3,8m+1]`.
Each is congruent to 1 or 5 modulo 8 and appears exactly once among A's
coefficient denominators through m, as `8j+1` or `8j+5`. The endpoints ensure
`j<=m` and `2p>8m+6`; the corresponding numerator 4 or -1 is not divisible
by p. Therefore `v_p(S_m)=-1`. Every such prime not dividing Q(m) survives:

```text
M_m/gcd(M_m,abs Q(m)) divides q'_m,
q'_m >= M_m/abs Q(m).
```

The prime number theorem in progressions gives `Theta(x;4,1)~x/2`, with
`Theta(x;q,a)=sum_(p<=x, p prime, p=a modq) log p`. See Sutherland,
[*Sieve theory and small gaps between primes: Introduction*](https://math.mit.edu/~drew/PrimeGapsOberwolfach1.pdf#page=3),
Oberwolfach, 6 July 2015, PDF index 2. Only the fixed coprime pair `(4,1)` is
used; no estimate uniform in a growing modulus is assumed. Consequently

```text
log M_m=Theta(8m+1;4,1)-Theta(4m+3;4,1)=2m+o(m),
log(abs Q(m))=O(log m),
liminf_(m->infinity) log(q'_m)/m >= 2.
```

In particular, for every `eps>0`, `q'_m>=exp((2-eps)*m)` at every sufficiently
large m. This strengthening is a paper consequence of the inspected PNT source,
not a kernel result from the Dirichlet probe.

## A fixed rational correction cannot leave an all-orders flat error

For every such R there are `d in Z` and `c in Q`, `c!=0`, with

```text
E(m)-R(m) ~ (c/15)*m^d.
```

To see this, put `D(m)=E(m)-R(m)` and
`G(X)=A(X+1)-16*R(X)+R(X+1)`. The exact tail shift gives
`16*D(m)-D(m+1)=G(m)`. The rational function G is nonzero: otherwise
`A(X+1)=16R(X)-R(X+1)` would contradict the
[weighted-pole obstruction](m4-rational-forcing.md#pole-structure-a-sharper-separating-example).
The four shifted poles lie in distinct integer-shift orbits and have nonzero
weighted residues. Thus G has a nonzero rational leading ratio c and integer
degree difference d, with `G(m)~c*m^d`.

Both R and D have at most polynomial growth on the eventual naturals.
Iterating the difference equation and letting L tend to infinity gives

```text
D(m)=sum_(r=0)^(L-1) G(m+r)/16^(r+1)+D(m+L)/16^L,
D(m)=sum_(r>=0) G(m+r)/16^(r+1).
```

Polynomial growth kills the boundary term and guarantees absolute convergence;
an exponential homogeneous solution cannot survive. To divide by `m^d` and
pass to the limit, use `abs(G(s))<=C*s^d` for large s. If `d>=0`, the normalized
terms are bounded by `C*(1+r)^d/16^(r+1)`; if `d<0`, by `C/16^(r+1)`.
Both are summable. Each fixed-r term tends to `c/16^(r+1)`, whose sum is c/15.
No analyticity or convergent asymptotic expansion of E at infinity was assumed.

For example, `R=0` gives `E(m)~1/(64*m^2)`. For `R(m)=1/(64*m^2)`, exact
Laurent coefficients give `G(m)~-345/(512*m^3)` and therefore
`E(m)-R(m)~-23/(512*m^3)`. This verifies a nonzero leading error, not merely
an upper bound compatible with unexpectedly better approximation.

## What this does and does not rule out

For a fixed rational correction tending to zero, the residual has some fixed
inverse-power order, so its absolute-error guarantee allows only
`J=O(log m)` uniformly close frozen-prefix windows. Meanwhile its corrected
odd denominator grows at least exponentially, by the PNT-dependent argument.
Even granting an analogue of the neighboring bound with uniform constants for
these moduli, its required window scale is incompatible with that guarantee.
The original theorem's fixed-tower requirement also remains unsatisfied.

This rules out that fixed-correction repair of that sufficient comparison.
It does not rule out actual cancellation, later returns to small phase error,
comparisons that exploit cancellation in the errors, approximants of growing
order, or V. Arbitrary rational R also satisfies the residual theorem, but a
large integer-valued polynomial part can disappear in circle phases; a large
raw error must not be mistaken for an actual circle-phase obstruction. The
application above concerns corrections tending to the vanishing tail.

The reassessment is to stop computing more fixed-order corrections for this
comparison. A different estimate would have to exploit the changing BBP moduli,
or establish compatible denominator and residual bounds for a genuinely
different approximation. Those inputs remain open; no such premise is added
to the target.

## Receipts

The worker reports are `/tmp/pi-m4-fourier-window-applicability-final-20261126.md`
and `/tmp/pi-m4-fixed-rational-correction-report-final.md`.
The parent inspected and reran the exact-rational checker
`/tmp/pi-m4-fixed-correction-check-final.py`, SHA-256
`3d8977fff7ce4cc423a5e0928c145bb6ebfb727c65b221078178ec694721e9f4`: exit 0.
It checks finite prime/residue examples, deliberate cancellations, first
asymptotic coefficients and product divisibility. These are sanity checks;
universal claims rely on the paper arguments above.

The scratch `/tmp/pi-m4-dirichlet-probe-v1.lean`, SHA-256
`23b5703ec2a0d2170aaa1fad942a96ac164df418fbd20d616da259edaa824f46`,
instantiates the displayed prime theorem and prints only `propext`,
`Classical.choice`, `Quot.sound`; worker and parent compilations exited 0.
No valuation, PNT, residual-asymptotic or
visitation theorem was added to the project. No dependency or audit changed.
