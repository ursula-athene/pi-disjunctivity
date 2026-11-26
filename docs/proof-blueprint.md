# Proof dependency and status index

Updated 2026-11-26 with the incomplete M4 research outcome; B3 remains checked. This indexes
[proof-plan.md](proof-plan.md), the sole mathematical roadmap. Validation and
review evidence are in [research-log.md](research-log.md). All Lean names below
are in namespace `PiDisjunctivity` and exported by the library root.

**Target remains unproved:** `PiHexadecimalDisjunctivity`, whose unchanged
definition is `IsDisjunctive 16 Real.pi`. B1 is implemented, including rational
algebra, the primitive derivative, integral evaluation, and the full `HasSum`.
B2 split, recurrence/range, the exact orbit bridge, and B3 tail control are
checked. Universal visitation remains unproved; B3 acceptance is in its handoff.

## Notation and status vocabulary

For this index only, put

\[
t_n(x)=\operatorname{fract}(16^n x),\qquad
I(k,m)=[m/16^k,(m+1)/16^k),
\]
\[
H(x)\iff\forall k,m\in\mathbb N,\ m<16^k\Rightarrow
  \exists n\in\mathbb N,\ t_n(x)\in I(k,m).
\]

`H` and `I` are mathematical abbreviations in this document, not new Lean
definitions. Bounds on `m` in Lean use naturals, so nonnegativity is implicit;
interval arithmetic uses reals. Each occurrence index may depend on `k,m`.

- **Checked:** compiled proof with type and axiom guards; conditional results
  still retain every stated hypothesis.
- **Known / unformalized:** established mathematics or a standard argument
  outlined in the roadmap; no project Lean proof is claimed.
- **Proposed:** precise candidate statement still needing verification.
- **Open / blocked:** missing mathematical argument, or a node depending on it.
- **Rejected route:** an invalid inference, not an unproved Lean theorem.

## Checked foundation and pilot

| Node | Exact claim and hypotheses | Dependencies and evidence | Role/status |
| --- | --- | --- | --- |
| F1: word range | For every `k : ℕ`, `s : Fin k → Fin 16`, `blockValue k s < 16 ^ k`. For every `m : ℕ` with `m < 16 ^ k`, there exists such an `s` with `blockValue k s = m`. | `blockValue_lt`, `exists_blockValue_eq` in [BlockValue.lean](../PiDisjunctivity/BlockValue.lean); recursive `blockValue`, natural quotient/remainder; guarded in `Test.lean`. | **Checked.** Converts between all fixed-length words and all cell indices; retains leading zeros. |
| F2: word/cell | For `x : ℝ`, `hx : 0 ≤ x`, `n k : ℕ`, `s : Fin k → Fin 16`: `(∀ i : Fin k, baseDigit 16 x (n + i.val) = (s i).val) ↔ t_n(x) ∈ I(k, blockValue k s)`. | `block_iff_mem_interval` in [Cylinders.lean](../PiDisjunctivity/Cylinders.lean); `baseDigit_fract_pow`, fixed-length injectivity, scaled-floor reconstruction; guarded in `Test.lean`. | **Checked.** Connects a visit to every digit of one contiguous word. Includes `k = 0`. |
| F3: alternative orbit criterion | For `x : ℝ`, `0 ≤ x`: `IsDisjunctive 16 x ↔ closure (hexadecimalOrbit x) = Set.Icc (0 : ℝ) 1`. Also `PiHexadecimalDisjunctivity ↔ PiHexadecimalOrbitClosure`. | `isDisjunctive_iff_orbitClosure`, `piHexadecimalDisjunctivity_iff_orbitClosure` in [OrbitEquivalence.lean](../PiDisjunctivity/OrbitEquivalence.lean); F1, F2, real topology, π positivity for specialization; guarded. | **Checked.** Alternative assembly route; proves neither side for π. |
| P1: interval criterion | For `x : ℝ`, `hx : 0 ≤ x`: `IsDisjunctive 16 x ↔ H(x)`. | `isDisjunctive_iff_hitsHexadecimalIntervals` in [OrbitCriteria.lean](../PiDisjunctivity/OrbitCriteria.lean); F1 and F2 only. New type/axiom guard in `Test.lean`. | **Checked in pilot.** Shows the interval obligation is exactly the existing conjecture for nonnegative inputs. |
| P2: π reduction | `H(Real.pi) → PiHexadecimalDisjunctivity`. | `piHexadecimalDisjunctivity_of_hitsHexadecimalIntervals` in the same module; P1 and Mathlib's `Real.pi_pos.le`; new type/axiom guard. | **Checked conditional theorem.** Step 2 complete. Its premise is still open. |
| F4: late occurrences | For `b : ℕ`, `2 ≤ b`, `x : ℝ`, **assuming** `IsDisjunctive b x`, every `k : ℕ`, `s : Fin k → Fin b`, `N : ℕ` admits `n ≥ N` with `∀ i : Fin k, baseDigit b x (n + i.val) = (s i).val`. | `isDisjunctive_occurs_ge` in [Disjunctivity.lean](../PiDisjunctivity/Disjunctivity.lean); zero-padding a word; guarded. | **Checked conditional theorem.** A consequence after solving the target, never an independent premise for it. |

[Test.lean](../Test.lean) is the executable audit inventory. The
[formulation follow-up](review-follow-up.md) and dated handoffs retain historical
counts and validation evidence. Each checked theorem keeps its actual guarded
axiom list; no claim here is an added axiom.

## Remaining BBP route

B1, B2 and B3 below are checked. V remains an unproved specification from
roadmap Step 5; no corresponding visitation theorem is claimed.
The general B4 and P3 lemmas are now checked and
exported; they contain no BBP-specific definitions. For the remaining nodes,
define, in real arithmetic,

\[
A(j)=\frac4{8j+1}-\frac2{8j+4}-\frac1{8j+5}-\frac1{8j+6},\quad
S_n=\sum_{j=0}^{n}16^{n-j}A(j),\quad
R_n=\sum_{r=0}^{\infty}\frac{A(n+r+1)}{16^{r+1}},
\]
\[
y_0=0,\qquad y_{n+1}=\operatorname{fract}(16y_n+A(n)).
\]

Here `A(j)`, `S_n`, `R_n`, and `y_n` are implemented as `bbpCoeff`,
`bbpPartialSum`, `bbpTail`, and `bbpRecurrence`. All indices are natural numbers. The tail is reindexed from
the roadmap's `r ≥ 1` sum to start at zero. The exported `hasSum_bbpTail` supplies convergence for the defined analytic tail.

| Node | Exact claim and hypotheses | Dependencies/evidence | Role/status |
| --- | --- | --- | --- |
| B1a: coefficient and term integral | For every `j : ℕ`, `∫ x in (0 : ℝ)..1, (x^8/16)^j * (4 - 2*x^3 - x^4 - x^5) = bbpCoeff j / (16 : ℝ)^j`. No hypotheses. | `bbpCoeff`, `integral_bbpTerm` in [Series.lean](../PiDisjunctivity/BBP/Series.lean); polynomial continuity, integral linearity, and Mathlib `integral_pow`. Root export, exact type/axiom guard, coefficient expansion and zero-index check in `Test.lean`. | **Checked.** Supplies only the term integral (T1). No series convergence, interchange, or π evaluation. |
| B1b: pointwise series and domination | For every `x ∈ Set.Icc (0 : ℝ) 1`, `HasSum (fun j : ℕ => (x^8/16)^j * (4 - 2*x^3 - x^4 - x^5)) ((4 - 2*x^3 - x^4 - x^5)/(1-x^8/16))`; for every such `x` and every `j : ℕ`, the term norm is at most `8*(1/16)^j`. | `hasSum_bbpTerm`, `norm_bbpTerm_le` in [Series.lean](../PiDisjunctivity/BBP/Series.lean); ratio/denominator bounds, geometric summation, power and absolute bounds. Root-exported; full type/axiom guards, endpoint and zero-index checks. | **Checked.** Supplies T2 and the pointwise bound for T3; not measurability, summability/integrability instances, interchange, or π evaluation. |
| B1c: sum/integral interchange | `HasSum (fun j : ℕ => bbpCoeff j / (16 : ℝ)^j) (∫ x in (0 : ℝ)..1, (4 - 2*x^3 - x^4 - x^5)/(1-x^8/16))`. No hypotheses. | `hasSum_bbpCoeff_integral` in [Series.lean](../PiDisjunctivity/BBP/Series.lean); B1a/B1b and pinned interval dominated convergence, with all five premises discharged locally. Root-import full type/axiom audit. | **Checked.** Supplies T3 and the coefficient-series bridge to the unevaluated integral. No π evaluation or visitation. |
| B1d: rational decomposition | For `x ∈ Icc (0 : ℝ) 1`, `(4-2*x^3-x^4-x^5)/(1-x^8/16) = (-4*x)/(2-x^2) - 4*(x-2)/(x^2-2*x+2)`. | `bbpKernel_eq_partialFractions` in [Series.lean](../PiDisjunctivity/BBP/Series.lean); local denominator bounds, field and ring algebra; full type/axiom guard. | **Checked.** T4 supplies the derivative normalization. |
| B1e: primitive derivative | For `x ∈ Icc (0 : ℝ) 1`, `HasDerivAt (fun y => 2*log(2-y^2)-2*log(y^2-2*y+2)+4*arctan(y-1)) ((4-2*x^3-x^4-x^5)/(1-x^8/16)) x`. | `hasDerivAt_bbpPrimitive`; positive log arguments, chain rules, T4; full type/axiom guard. | **Checked.** Ordinary derivative at every point including endpoints; no unproved analytic premise. |
| B1f: integral evaluation | `(∫ x in (0 : ℝ)..1, (4-2*x^3-x^4-x^5)/(1-x^8/16)) = Real.pi`. No hypotheses. | `integral_bbpKernel`; kernel continuity/integrability, B1e, FTC, exact log/arctangent endpoint values; full type/axiom guard. | **Checked.** Identifies the B1c integral with Mathlib's π. |
| B1: BBP series | `HasSum (fun j : ℕ => A(j) / (16 : ℝ) ^ j) Real.pi`, for the fixed `A` above. | `hasSum_bbpCoeff` in [Series.lean](../PiDisjunctivity/BBP/Series.lean); B1c rewritten with B1f. Full root-import type/axiom guard; [handoff](b1-handoff.md). | **Checked, unconditional.** Supplies the π-specific analytic identity and convergence. No density hypothesis, external adaptation, or visitation conclusion. |
| B2: orbit bridge | For every `n : ℕ`, the specified tail has sum `16^n*Real.pi-S_n` and has sum `R_n`; `16^n*Real.pi = S_n+R_n`, `0 ≤ y_n < 1`, `y_(n+1) = fract(S_n)`, and `t_n(Real.pi) = fract(y_(n+1)+R_n)`. No hypotheses. | Six public theorems in [Orbit.lean](../PiDisjunctivity/BBP/Orbit.lean): `hasSum_bbpTail_sub`, `hasSum_bbpTail`, `pow_mul_pi_eq_bbpPartialSum_add_bbpTail`, `bbpRecurrence_mem_Ico`, `bbpRecurrence_succ_eq_fract_bbpPartialSum`, `fract_pow_mul_pi_eq_bbpRecurrence_add_bbpTail`. B1, prefix split/scaling, private prefix recurrence, integer-floor witness; complete root types/guards and boundary checks. [Handoff](b2-handoff.md). | **Checked, unconditional; reviewed and committed.** Recurrence index `n+1` matches orbit index `n`. V remains open. |
| B3: tail control | For all `j,n : ℕ`, `abs(A(j)) ≤ 8/(8*j+1)` and `abs(R_n) ≤ 8/(15*(8*n+9))`; consequently `R_n → 0` as `n → ∞`. | `abs_bbpCoeff_le`, `abs_bbpTail_le`, `tendsto_bbpTail` in [Tail.lean](../PiDisjunctivity/BBP/Tail.lean); positive denominator comparison, local geometric `HasSum`, B2 `hasSum_bbpTail`, norm comparison and squeeze. Full root types/guards and boundary/B4 interface audits; [handoff](b3-handoff.md). | **Checked, unconditional.** Supplies vanishing error, gives no visits. |
| B4: general transfer | For `u r : ℕ → ℝ`, assume `Filter.Tendsto r Filter.atTop (nhds 0)` and `∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 → ∀ N : ℕ, ∃ n ≥ N, u n ∈ Set.Ioo a b`. Then `∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 → ∃ n : ℕ, Int.fract (u n + r n) ∈ Set.Ioo a b`. | `hitsOpenIntervals_fract_add_of_tendsto_zero` in [OrbitCriteria.lean](../PiDisjunctivity/OrbitCriteria.lean); `Metric.tendsto_atTop`, quarter-width margin, `Int.fract_eq_self`. Root-exported; complete type/axiom guards in `Test.lean`. | **Checked, conditional.** No global range hypothesis; signed errors and targets touching 0 or 1 included. Late visitation and vanishing error remain premises of the general theorem; B3 discharges only the latter for `bbpTail`. |
| P3: open intervals to cells | For `t : ℕ → ℝ`, assume `∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 → ∃ n : ℕ, t n ∈ Set.Ioo a b`. Then `∀ k m : ℕ, m < 16 ^ k → ∃ n : ℕ, t n ∈ Set.Ico ((m : ℝ) / (16 : ℝ) ^ k) (((m : ℝ) + 1) / (16 : ℝ) ^ k)`. | `hitsHexadecimalIntervals_of_hitsOpenIntervals` in the same module; positive cell width, natural-to-real endpoint bounds, weakening the strict lower inequality. Root-exported; complete type/axiom guards. | **Checked, conditional.** Independent of B4 and BBP, with no range hypothesis. Includes `k = 0`, the first cell, and the last cell. Open-interval visitation remains a premise. |
| V: universal visitation | For the fixed recurrence above, `∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 → ∀ N : ℕ, ∃ n ≥ N, a < y_(n+1) ∧ y_(n+1) < b`. | Particular BBP coefficients, initialization, and indexing; [Step 5](proof-plan.md#5-prove-the-missing-universal-visitation-theorem), [initial assessment](m4-visitation-obstruction.md), and [continued research checkpoint](m4-handoff.md#continued-research-checkpoint--2026-11-26). | **Open; M4 incomplete.** Source, countermodel and recovery work has not supplied a BBP-specific exclusion of infinite proper limit sets. Neither B1 nor B3 discharges V; research continues. |
| Hπ: actual cell visits | `H(Real.pi)` with no unproved premise. | B2 + B3 + B4 + V give visits to every open interval in `[0,1]`; P3 converts these to visits to each `I(k,m)`. | **Blocked.** Missing visitation V; B1/B2/B3 and conditional B4/P3 are checked. This is equivalent to the target, not independent progress. |
| T: final theorem | `PiHexadecimalDisjunctivity` with no distribution hypothesis. | P2 applied to an unconditional proof of Hπ; alternative F3 route also possible. | **Blocked.** No exported unconditional proof exists. |

Modular reduction of finite sums is optional computation support in Step 4;
it is not needed in the minimal logical chain above. Normality, arbitrary-base
orbit generalization, and numerical word searches are not prerequisites.

```text
B1 (checked BBP) ──> B2 (checked orbit identity) ──────────────────────┐
B3 (checked tail control) ──> vanishing error ─────────────────┤
V  (OPEN: late visits of the fixed recurrence) ────────┤
B4 (general conditional transfer) ────────────────────┤
P3 (general open-interval-to-cell conversion) ─────────┴─> Hπ (OPEN)
F1 + F2 ──> P1 ──> P2 (checked, conditional) ─────────────> T (OPEN)
                                                         ^
                         Hπ supplies P2's premise ────────┘
```

The arrows describe proof prerequisites, not evidence that the unproved nodes
hold. In particular, no edge may return from T or F4 to V. That would assume
disjunctivity while purporting to prove it.

## Rejected inferences and next task

The original pilot recorded the following review exclusions:
almost-everywhere density does not select π; finite word checks do not prove
universal occurrence; BBP extraction and a vanishing tail do not produce visits;
irrationality alone does not rule out infinite proper limit sets. A global bound
`abs(fract u - fract v) ≤ abs(u-v)` is false across an integer (take
`u = 99/100`, `v = 101/100`). The transfer must use an interior margin.

B1, B2, B3, B4, and P3 are checked. [The B3 handoff](b3-handoff.md)
records acceptance and publication. V, Hπ, T, and π disjunctivity remain open.
B4 retains its general vanishing-error and arbitrarily-late-visit premises;
B3 supplies only the former for the BBP tail. P3 retains open-interval visits.
Next session: <!-- current-prompt --> [Current prompt: M4 Universal Visitation](session-prompts.md#current-prompt-m4-universal-visitation)
remains the research entry point. Its 2026-11-26 invocation ended with M4
incomplete; [the handoff](m4-handoff.md) and argument assessment record the
tested routes. Their historical stopping proposals are superseded by the current
[persistence protocol](meta-proof-plan.md#persistence-and-stopping-conditions);
discovery does not require a new estimate before resuming. A checked countermodel of a
different recurrence rejects a generic implication, not V. The tooling
milestone is complete with its existing limits.
