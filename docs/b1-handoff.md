# B1 completion handoff

Implementation checked 2026-11-25 on `feature/attempt-04`, in
`/Users/adam/personal/proj/pi-disjunctivity/pi-disjunctivity`.

**The full B1 BBP identity, audits, and required review pass.** Local commit
and post-commit necessity review follow below. π disjunctivity and universal
visitation remain unproved.

## Authorized endpoint and checked results

After the completed B1c cycle, the user asked to press on and complete B1.
This explicitly broadened the proposed B1d-only slice to include rational
algebra, the antiderivative, FTC/integral evaluation, and final assembly.
The checked B1c bridge was reused unchanged. The bounded endpoint announced
before editing was full B1 with audits/review/local commits and a handoff,
stopping before B2/B3 or visitation work.

[Series.lean](../PiDisjunctivity/BBP/Series.lean) adds four public theorems.
Write `K(x) = (4 - 2*x^3 - x^4 - x^5)/(1-x^8/16)` and
`F(x) = 2*Real.log(2-x^2) - 2*Real.log(x^2-2*x+2) + 4*Real.arctan(x-1)`
as mathematical abbreviations only, not new Lean definitions:

| Declaration | Complete claim and hypotheses |
| --- | --- |
| `bbpKernel_eq_partialFractions` | For `x : ℝ` and `hx : x ∈ Set.Icc (0 : ℝ) 1`, `K(x) = (-4*x)/(2-x^2) - 4*(x-2)/(x^2-2*x+2)`. |
| `hasDerivAt_bbpPrimitive` | For the same `x` and sole hypothesis `hx`, `HasDerivAt F (K(x)) x`, with ordinary derivatives at both endpoints as well. |
| `integral_bbpKernel` | `(∫ x in (0 : ℝ)..1, K(x)) = Real.pi`, with no hypotheses. |
| `hasSum_bbpCoeff` | The following full unconditional BBP identity. |

```lean
HasSum (fun j : ℕ => bbpCoeff j / (16 : ℝ) ^ j) Real.pi
```

Here the preserved coefficient is exactly
`4/(8*(j : ℝ)+1) - 2/(8*(j : ℝ)+4) - 1/(8*(j : ℝ)+5) - 1/(8*(j : ℝ)+6)`.
The natural index starts at zero and all division is real. The sum is Mathlib's
`Real.pi`, with convergence retained in `HasSum`. No integrability, convergence,
density, or BBP-identity hypothesis remains in the final theorem.

The existing public root import exports all four declarations. `Test.lean`
checks their complete types and guards each inspected actual axiom list:
exactly `propext`, `Classical.choice`, `Quot.sound`. There are 27 theorem audits
in total. The earlier 23 guards, proposition/coefficients/value checks, and
B1b endpoint/zero-index regressions are preserved. There is no new primitive
or kernel definition, generic analytic API, factorization lemma, or import.

## Mathematical review and proof dependencies

On `[0,1]`, `x^2 ≤ 1` gives `2-x^2 > 0`; the square `(x-1)^2 ≥ 0` gives
`x^2-2*x+2 > 0`; and `x^8 ≤ 1` gives positive `1-x^8/16` and `16-x^8`.
These facts discharge every denominator introduced by field normalization.
Ring algebra proves the exact partial-fraction identity, including `x=0,1`.

Polynomial derivatives and the logarithm/arctangent chain rules give the
ordinary derivative of `F`. Positive logarithm arguments supply their nonzero
premises. The identity `1+(x-1)^2 = x^2-2*x+2`, followed by the partial fractions,
matches the original kernel. Each exported intermediate theorem has a direct
consumer in this proof chain; all denominator facts stay local.

The kernel's numerator and denominator are continuous polynomials with a
constant divisor. Its denominator is nonzero throughout `[0,1]`, so the kernel
is continuous there and interval integrable for volume. The pinned FTC API
uses `Set.uIcc 0 1`, explicitly rewritten as `Set.Icc 0 1`. It applies the
derivative theorem to the complete closed interval and yields `F(1)-F(0)`.
At one, both logarithms and the arctangent vanish. At zero, the logarithm terms
cancel and `Real.arctan_neg`/`Real.arctan_one` give `F(0) = -Real.pi`.
Thus the integral equals π. Rewriting B1c's existing integral value proves
`hasSum_bbpCoeff` directly, without a separate `tsum` theorem or tail layer.

These are independent local Lean proofs from the assessed mathematical route
and actual pinned Mathlib APIs. No external proof scripts were copied or
translated. Mathematical statement review is distinct from kernel checking.
The result completes proof-plan Step 3 / M2, not the disjunctivity conjecture.

## Checkout, compiler feedback, and validation

Starting HEAD was `0584737a5cba74ad4acc1754457c260e2ea468b8`, the final B1c
handoff commit on the existing branch. Live remote main remained
`4eb973b0c3521a962a90f3d0aacafc2a4d5d7d50`, matching local main/origin/main and
an ancestor of HEAD. No branch recreation, dependency change, or history
rewrite was needed. Unrelated Obsidian, notes, and papers files are preserved.
The existing approved review prefix and workspace/temporary write restrictions
remain in effect; no permission changes or escalation were requested.

Scratch compilation exposed compiler/tactic issues, not missing mathematics:

- Default `field_simp` left inverses of normalized denominators. Explicit local
  positivity/bounds and a `linarith` discharger allowed polynomial closure.
- `convert` produced a function-equality goal, closed by `rfl` before normalizing
  the derivative value.
- An untyped `ContinuousOn.div` application led `fun_prop` to unfold real
  arithmetic and exhaust the default heartbeat limit. Explicitly typed
  continuity facts resolved elaboration; no limit or linter was changed.
- Endpoint simplification left `π = 4*(π/4)`, closed by `ring`. Redundant
  tactic sequencing was removed in response to the linters.

The production module and integrated checks then passed without warnings.
From the correct root, with `$HOME/.elan/bin` on `PATH`:

| Check | Result |
| --- | --- |
| `lean --version` | `4.37.0-rc1` |
| Baseline `lake build` / `lake env lean Test.lean` | Pass: 7201 jobs and 23 existing theorem audits |
| Direct production-module compilation | Pass, no warnings |
| Integrated `lake build` | Pass: 7201 jobs, no warnings |
| Root-import axiom/type probe | All four exact types and permitted axiom lists inspected |
| `lake env lean Test.lean` | Pass: 27 guarded audits and all prior checks, no warnings |
| `git diff --check` | Pass |
| Pins, manifest, and reviewed definition diff | Empty |

All earlier BBP declarations, Mathlib-only dependency policy, both version
pins, module/public conventions, Ursula Athene-only attribution, MIT SPDX
headers, linters, and CI remain unchanged. No optional tooling was introduced.
No clean-environment rebuild or remote CI result is claimed. Final import,
manifest, preservation, link, and staged-scope checks accompany the review.

## Required review and local finalization

Gemini Carbon High completed the full twelve-file exact-diff review with
**explicit no findings**. Conversation: `a5edb71a-c1be-402f-b627-8c8e1939edd2`.
The [review report](agy-reports/b1-review.md) includes the exact diff hash,
complete response, timestamps, terminal fields, capture evidence, and limitations.

One invocation completed in 259.935 seconds, exit 0, `SUCCESS`, nonempty
response, with absent terminal error/finished-reason/denied-action fields.
The inline diff preserved the full scope and avoided B1c's temporary-file
read obstacle. All 26 reviewer file reads completed; no shell or mutating
review tool was used. No retry or substantive-fix follow-up was needed.

Gemini did not rerun Lean/Git/hash checks or inspect the Mathlib checkout;
those rely on caller validation. CLI persistence was sandbox-denied, but
existing-login authentication and the review succeeded. All raw execution
chunks and the terminal result were saved separately and are complete.
No permission changes were made. An incorrect file link in the response was
corrected only in the portable saved report; it was not a code finding.

Pre-review preservation passed for 25 unrelated/protected file hashes, all
previous BBP declarations, all 23 prior guards and other checks, archived
prompt bytes, and earlier research-log entries. Manifest/package revisions,
project imports/trust, and 192 local Markdown links/anchors passed. Final
factual review records and staging receive fresh preservation/link/whitespace
checks. The reviewed Lean proof and audits are unchanged after validation.

Local commit and post-commit proof-necessity results are recorded below when
completed.

## Remaining obligations and next proposal

B1/M2 is checked. B2's scaled split, recurrence, and fractional-part bridge;
B3's tail bounds and decay; V's independent arbitrarily late visitation;
Hπ; T; and π disjunctivity remain unproved. B4 retains vanishing error and
arbitrarily late visits as premises; P3 retains open-interval visits. The BBP
identity produces no independent visitation argument.

The next smallest proposed slice is
[B2a finite-prefix and tail split](proof-plan.md#next-bounded-task-b2a-finite-prefix-and-tail-split):
for each `n`, use B1 to express `16^n*π` as the prefix through `n` plus a
convergent tail starting at `n+1`, retaining the tail `HasSum`. Check natural
exponent subtraction, all real divisions, and `n=0`. Stop before recurrence,
fractional-part identities, B3 bounds, or V. This needs separate authorization;
no B2a implementation was begun.

The integral route and B1-before-B3 ordering succeeded as planned. Explicit
types and local arithmetic facts resolved the observed elaboration problems;
no process expansion was justified. Both plans, blueprint, current session
instructions, and affected audit summaries reflect the completed analytic
identity and remaining obligations. Keep the Gemini/Viewpoint cadence.

**Stop at B1, before B2/B3 or V. No push or PR.**
