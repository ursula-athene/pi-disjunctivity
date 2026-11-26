# M4 visitation argument assessment — 2026-11-26

This is the initial attempt's mathematical evidence. Its historical reopening
condition does not govern continued authorization: the current
[persistence protocol](meta-proof-plan.md#persistence-and-stopping-conditions)
supersedes that stopping proposal. Seeking a new BBP-specific estimate is part
of continued discovery, not a prerequisite for it. The arguments below and
their unproved obligations are unchanged.

**V remains open.** This is a mathematical assessment, not a visitation proof.
The [proof plan](proof-plan.md#m4-research-sequence--2026-11-26) owns the exact
contract and research bounds. The central question is whether the particular
BBP forcing excludes an infinite proper limit set. B1–B3 and B4 do not answer it.

## Fixed target and existing consumer

Write `A(n) = bbpCoeff n`, `y(n) = bbpRecurrence n`, and `R(n) = bbpTail n`.
We need, for every real `0 ≤ a < b ≤ 1` and every natural `N`, some `n ≥ N`
with `a < y(n+1) < b`, with no visitation or distribution assumption.
The recurrence starts at zero and uses `A(n)` in step `n+1`.

The checked root-visible identity is
`fract(16^n*pi) = fract(y(n+1)+R(n))`; B3 proves `R(n) → 0`.
The existing [B4 interface audit](../Test.lean) consumes exactly the missing
late-visit premise. Its conclusion has one visit per interval. No M5 assembly
or replacement theorem is proposed here.

## Source assessment and contract extraction

Read on 2026-11-26: Lagarias, *On the Normality of Arithmetical Constants*,
[arXiv math/0101055v2](https://arxiv.org/pdf/math/0101055v2), §§3–4,
printed pages 6–10 (Theorems 3.1, 3.3, 4.1; Lemma 3.2). Section 3 uses
`epsilon_m`, `m ≥ 1`, recurrence `z_(m+1)=fract(b*z_m+epsilon_(m+1))`,
`z_0=0`, and a convergent series `theta=sum epsilon_m*b^(-m)` with
`epsilon_m → 0`. The orbit comparison is on `R/Z`, identifying 0 and 1.
The finite-limit-set case characterizes rational `theta`. Theorem 4.1 assumes
the **Weak Dichotomy Hypothesis** for rational-function forcing; it does not
prove it. Strong dichotomy adds uniform distribution and is unnecessary here.
The paper's introductory and intermediate index displays are not used as
local rewrite rules; the mapping below follows (3.2)–(3.4) directly.

Bailey–Crandall, *On the Random Character of Fundamental Constant Expansions*,
[author PDF](https://www.davidhbailey.com/dhbpapers/baicran.pdf), dated
3 October 2000, Hypothesis A and Theorem 1.1, printed pages 2–3: their
`x_m=fract(16*x_(m-1)+r_m)` has the shifted rational function displayed below.
The normality conclusion is explicitly conditional on Hypothesis A, with
integer polynomial numerator/denominator, smaller numerator degree, and no
positive-integer poles. It supplies no unconditional V.

**Our translation, independently checked algebraically:** put `b=16`,
`epsilon_m=A(m-1)` for positive integer `m`. Then `z_m=y_m` and
`theta=pi/16`, by B1 and a one-place series shift. Explicitly,

```text
A(n) = (120*n^2 + 151*n + 47) /
       ((8*n+1)*(2*n+1)*(8*n+5)*(4*n+3)),       n ≥ 0,
epsilon_m = (120*m^2 - 89*m + 16) /
            ((8*m-7)*(2*m-1)*(8*m-3)*(4*m-1)), m ≥ 1.
```

All four unshifted factors are positive on natural indices; the shifted
denominator has no nonnegative integer root. Degrees are 2 and 4. Its roots
`7/8, 1/2, 3/8, 1/4` give numerator values `30, 3/2, -1/2, 5/4`, so there is
no common factor. These are real/rational divisions, never natural division.
The degree comparison gives coefficient decay; geometric weighting gives
absolute convergence. `pi/16` is irrational, and
`fract(16^(n+1)*(pi/16))=fract(16^n*pi)` checks the local offset.
The series shift, coprimality and source finite-limit theorem are paper
arguments here, not new exported Lean declarations.

The diagnostic root-import probe `/tmp/pi-m4-source-probe.lean` checks the
unshifted identity, `Irrational (Real.pi/16)` and orbit-index equality. It does
not formalize or prove a dichotomy. Its final verification receipt belongs in
the [M4 handoff](m4-handoff.md).

## Candidate 1: weak dichotomy plus irrationality

The strongest usable conditional route is:

1. Prove that the fixed recurrence's limit set is finite or its range is dense.
2. Use the source finite-limit theorem, with the translation above, and
   irrationality of `pi/16` to exclude the finite case.
3. A dense range in `[0,1]` yields late visits: remove the finitely many values
   with indices below the requested threshold and choose a smaller nonempty
   open subinterval avoiding those values. Density supplies an index outside
   that finite prefix. This works also for targets touching 0 or 1.

**First unsupported implication: step 1.** Excluding a finite limit set does
not establish density. The weaker statement actually needed is that this
particular irrational BBP orbit has no infinite proper limit set. That is not
supplied by the rational form or the source theorem. No conditional wrapper is
added to Lean; all of these source/application obligations remain explicit.

## Candidate 2: positive vanishing forcing and expansion

Consider this exact model, which is not the BBP coefficient:

```text
t_n = 1/(8*n+1)^2,
f_n = 16*t_n - t_(n+1),
v_n = 1 - t_n.
```

It has `v_0=0`, and
`16*v_n+f_n = 16-t_(n+1) = 15+v_(n+1)` with `0 ≤ v_(n+1)<1`.
Thus `v_(n+1)=fract(16*v_n+f_n)` exactly. The forcing is positive,
strictly decreasing, rational in `n`, and tends to zero. Both `f_n` and `A(n)`
have leading asymptotic `15/(64*n^2)`. Nevertheless, `v_n ≥ 80/81` for all
`n ≥ 1`, and `v_n → 1`; the model permanently misses `(1/4,3/4)`.
For positivity, `t_(n+1)<t_n` suffices. For monotonicity, the derivative of
`16/(8*x+1)^2-1/(8*x+9)^2` is negative for `x ≥ 0`.

The weighted constant of this model is rational: telescoping gives
`sum_(n=0)^M f_n/16^n = 16 - t_(M+1)/16^M`, hence limit 16.
This refutes positivity/decay/expansion arguments **without** an irrationality
premise; it does not refute the proposed weak dichotomy. It also shows that
matching the leading asymptotic cannot supply the missing distribution theorem.

The immutable diagnostic `/tmp/pi-m4-avoidance-probe-final.lean` was compiled
by both worker and parent with exit 0. Its `initial`, `recurrence`, `avoids`,
`forcing_pos`, `t_tendsto`, `forcing_tendsto`, and `not_visitation` theorems
have exactly the permitted three axioms. The checked missed interval is
`(0,1/2)`; the stronger lower bound above is inside that proof. Strict
monotonicity and matched asymptotics are paper calculations, not audited Lean
results. These diagnostic declarations are not exported or added to `Test.lean`.

Adding irrationality does not rescue the generic argument if rational-function
structure is dropped. Set `e_n=16^(-(n+1)!)` and `g_n=f_n+e_n`. The weighted
constant with the source normalization is `1+lambda`, where
`lambda=sum_(j≥0)16^(-L_j)` and `L_j=j+(j+1)!+1`. Its finite prefixes have
denominator `16^L_m` and positive error less than `2*16^(-L_(m+1))`.
As `L_(m+1)/L_m → ∞`, these are Liouville approximations, so the constant is
transcendental. For a recurrence step indexed `n+1`, the perturbation prefix
has fractional part `z_n` in `[0,1/15]`: its negative powers of 16 are distinct.
The new value is `fract(z_n-t_(n+1))`, hence belongs to
`[0,1/15] ∪ [80/81,1)` and misses `(1/4,3/4)`.
This is an unformalized exact construction. The forcing remains positive and
rational-valued with the same leading decay; it is not the fixed rational
function A, and gives no counterexample to V or to rational-function dichotomy.

## Candidate 3: denominator clearing and residues

For the actual BBP coefficient, let `D_n` be the positive least common multiple
of `8*j+r`, for `0 ≤ j ≤ n`, `r ∈ {1,4,5,6}`. Let
`P_n=sum_(j=0)^n 16^(n-j)*(D_n*A(j))`, an integer, and let `rho_n` be its
least nonnegative residue modulo `D_n`. Then `y(n+1)=rho_n/D_n`.
An exact sufficient condition for V is

```text
∀ k m N : ℕ, m < 16^k → ∃ n ≥ N,
  m*D_n < 16^k*rho_n ∧ 16^k*rho_n < (m+1)*D_n.
```

Every nonempty target interval contains a hexadecimal cell interior, so these
strict inequalities suffice. Conversely V supplies each such cell interior.
This is therefore a reformulation, not a new estimate. Fixed-modulus
periodicity does not settle it because `D_n` changes. **Missing bridge:** a
distribution or avoidance-rigidity result for these particular residues.
No modular-sum implementation is justified without an argument supplying it.

## Library and criticism boundaries

Two local discovery methods were used: text search for BBP/dichotomy/visitation
in pinned Mathlib and filename/API inspection of irrationality, minimality,
ergodic circle maps and omega limits. Native local search located
`irrational_pi` but reported its symbol index unavailable; pinned source and
compilation are the evidence for its use. `MulAction.dense_orbit` requires
`IsMinimal`; `AddCircle.ergodic_nsmul` is a measure-theoretic assertion, not a
visit theorem at this fixed starting point. Omega-limit membership APIs
characterize recurrence without establishing it for BBP.
These searches found no applicable unconditional V; they are not an exhaustive
nonexistence claim. Two targeted web discovery queries also found no applicable
replacement proof; secondary search hits were not adopted as mathematical evidence.

The `pi-argument-critic` pass reconstructs the exact quantifiers and identifies
missing mathematics at the infinite-proper-limit-set exclusion. The
`paper-to-lean-contract` pass distinguishes the shifted source contract from
the checked local B1–B3 identities. These same-session passes are not independent
reviews or proof certificates. Carbon criticism and bounded recovery outcomes
are recorded separately; V is not accepted by agreement among reviewers.

## Recovery 1: symbolic avoidance and complexity

The tension is between a tractable complexity estimate and an estimate strong
enough to force every word. Change representation: let `p(m)` count length-`m`
factors of a hexadecimal expansion. If a word of length `k ≥ 1` is absent
after position `N`, then for `m=q*k+r`, `0 ≤ r<k`,

```text
p(m) ≤ N + (16^k - 1)^q * 16^r.
limsup_(m→∞) log(p(m))/m ≤ log(16^k-1)/k < log(16).
```

There are at most `N` exceptional starts; every later factor splits into `q`
aligned blocks different from the forbidden word and a suffix of length `r`.
This is a bound even when some allowed concatenations never occur. Full entropy
`log(16)` would suffice, but is equivalent to disjunctivity: one missing word
gives this strict deficit, whereas all words give `p(m)=16^m`.

The neighboring result of Adamczewski–Bugeaud, *On the complexity of algebraic
numbers I*, [v1](https://arxiv.org/pdf/math/0511674v1), §2, Theorem 1,
printed page 3, gives superlinear complexity for irrational **algebraic**
numbers. It neither applies to π nor implies full entropy.
An exact separating construction concatenates all words over `{0,…,14}`:
it has `p(m)=15^m`, yet omits hexadecimal F and all orbit values are at most
`14/15`. Thus even exponential complexity of a smaller rate is insufficient.

For the recurrence, permanent avoidance transfers backward through B2/B3 to
avoidance by the π orbit of a smaller interior interval: for small `|R(n)|`,
`y(n+1)=fract(t_n-R(n))`, and a visit of `t_n` to the interior margin would
put `t_n-R(n)` in the original interval. A hexadecimal cell strictly inside
the smaller interval gives an eventually forbidden word. This is an informal
translation, not a new audited theorem. **Missing bridge:** a BBP-specific
complexity estimate that excludes every such entropy deficit. Repackaging it
as full entropy does not reduce the unresolved mathematical burden.

## Recovery 2: approximation quality

The proposed contradiction would derive excessively good rational
approximations from permanent avoidance. That implication is false for general
irrational numbers, even when their irrationality exponent is minimal.
Bugeaud, *On the rational approximation to the Thue–Morse–Mahler numbers*,
[published PDF](https://www.numdam.org/item/10.5802/aif.2666.pdf), AIF 61(5)
(2011), §2 theorem, printed page 2068, proves exponent 2 for
`xi_b = sum_(k≥0) t_k/b^k`, where `t_0=0`, `t_(2k)=t_k` and
`t_(2k+1)=1-t_k`. We use only the integer base 16; the bounded digits ensure
absolute convergence. Exponent 2 concerns infinitely many rational
approximations, not digit frequencies.

For every natural `n`, splitting the integer prefix gives

```text
fract(16^n*xi_16) = sum_(j≥1) t_(n+j)/16^j ≤ 1/15.
```

Consequently the number misses `(1/15,1)` despite exponent 2. The source also
records its transcendence. Rational finite truncations are not the irrational
sum, and this orbit is not the BBP recurrence. **Missing bridge:** why avoidance
for the exact BBP forcing, unlike this model, forces approximation quality
contradicting a known bound for π. No such argument was found; improving an
irrationality estimate alone cannot repair the generic inference.

Both recovery sources were inspected in extracted primary-source text. PDF
screen captures did not yield usable images; no visual verification is claimed.
The counterexample constructions and entropy estimates are paper arguments,
not kernel-checked results. No library, compiler or tool failure establishes
a mathematical impossibility.

## Bounded endpoint and reopening condition

The source audit, three avoidance candidates and two recovery candidates are
complete within their stated bounds. What changed is the precision of the
obstruction: generic decay/expansion fails even at the BBP leading asymptotic;
irrationality does not supply the omitted rational-function rigidity; and
complexity/residue formulations need a new estimate of essentially the same
strength as visitation. The checked proof frontier for π has not moved.

**M4 is incomplete.** A next attempt must supply a concrete BBP-specific
implication excluding eventual avoidance of an arbitrary interval, or the
particular weak dichotomy with all hypotheses discharged. No such implication
was justified by these cycles. Reopen a route when an exact candidate estimate
or applicable primary-source theorem survives the separating models above;
do not repeat generic tail sharpening, denominator wrappers or finite digit
searches as substitutes. No claim of impossibility or exhaustive search follows.
