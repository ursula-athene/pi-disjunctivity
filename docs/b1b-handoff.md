# B1b pointwise series and domination handoff

Implementation checked 2026-11-25 on `feature/attempt03`, in
`/Users/adam/personal/proj/pi-disjunctivity/pi-disjunctivity`.

**B1b is complete: checked, reviewed, committed, and reviewed for necessity.**
The full B1 identity and π disjunctivity conjecture remain unproved.

## Checked results and mathematical review

[Series.lean](../PiDisjunctivity/BBP/Series.lean) adds exactly two public theorems.
For real `x ∈ Set.Icc (0 : ℝ) 1`, put `q = x^8/16` and
`P = 4 - 2*x^3 - x^4 - x^5` as mathematical abbreviations only:

- `hasSum_bbpTerm x hx`: `HasSum (fun j : ℕ => q^j * P) (P/(1-q))`.
- `norm_bbpTerm_le j x hx`: `‖q^j * P‖ ≤ 8*(1/16)^j`, for every `j : ℕ`.

The sole hypothesis is membership in the closed unit interval. The ratio is
nonnegative and at most `1/16`; the sum proof explicitly establishes a positive
`1-q`, hence a nonzero denominator and ratio strictly below one. Mathlib's
geometric `HasSum`, multiplication, and a final algebra normalization give the
exact rational kernel. The bound combines power monotonicity with `|P| ≤ 8`,
derived from `0 ≤ x^k ≤ 1` for the three polynomial powers. Each helper fact is
local to its proof; no new definition or public helper is needed. These are
independent local proofs; no external scripts were copied or translated.

The existing root import exports both results. `Test.lean` preserves every
previous theorem/type guard and definition/value check, adds both full types,
and guards the actual axiom lists. All twenty-two lists are exactly `propext`,
`Classical.choice`, `Quot.sound`. Endpoint checks instantiate the exported
results: at `x = 0`, the sum is `4` (including the zero-index term); at `x = 1`,
the polynomial vanishes and the sum is `0`. Domination is checked at both
endpoints and for `j = 0` at every admissible `x`.

## Checkout, permissions, and validation

Started at `32e0974ea7389e38f28758a60cbeaad3b1794f2d`, the saved B1b prompt on the
already prepared branch. `git ls-remote origin refs/heads/main` returned
`9148792313151ac712f4caabe039b7b162690691`, matching local `main`/`origin/main`
and an ancestor of HEAD. Its commit records merged PR #2. No branch recreation,
reset, dependency change, push, or PR was needed.

The saved `codex execpolicy check` returned `decision: allow` for the exact
required `agy` prefix. The active profile permits workspace/temporary writes
and provides no escalation. Permission settings were not changed.

From the repository root with `$HOME/.elan/bin` on `PATH`:

| Check | Result |
| --- | --- |
| `lean --version` | `4.37.0-rc1` |
| Baseline `lake build` / `lake env lean Test.lean` | Pass: 7201 jobs and twenty existing theorem audits |
| Integrated `lake build` | Pass: 7201 jobs, no warnings |
| `lake env lean Test.lean` | Pass: twenty-two guarded theorem audits and definition/value/boundary checks, no warnings |
| Actual `#print axioms` probe | Both new theorems report exactly the three permitted axioms |
| `git diff --check` | Pass |

The first series proof failed when broad commutative simplification produced
a different polynomial multiplication order. Targeted `convert`/`ring` fixed
it. Linters then identified redundant sequencing and endpoint `simpa` calls
whose goals simplified without using the supplied theorem; explicit conversion
made those checks instantiate the theorems. These were compiler/linter issues,
not mathematical gaps, and no statement was weakened.

Meaning was reviewed separately: exact coefficients/signs/exponents, every
natural index, closed endpoints, positive denominator, and a uniform majorant.
The only added import is pinned Mathlib's `Analysis.SpecificLimits.Basic`.
`bbpCoeff`, `integral_bbpTerm`, all earlier declarations and checks, dependency
pins/manifest, CI, and repository instructions are preserved. The source-review
assessment and B1a were not repeated. Unrelated Obsidian, notes, and papers are
excluded. No clean-environment rebuild or remote CI result is claimed.

## Review and local commits

Gemini Carbon High returned **no actionable correctness, policy, or
documentation-consistency findings** on the thirteen-file supplied diff against
`32e0974`. Conversation: `374e74bf-0499-402c-bc1d-c413278a6a00`. The
[saved review](agy-reports/b1b-review.md) records the diff hash, complete response,
terminal fields, timestamps, coverage, and capture limits. One invocation
finished in 212.730 seconds, exit 0, `SUCCESS`, nonempty response, and absent
terminal error/finished-reason/denied-action fields. Five read-only document
reads completed; no shell or mutating tool call was observed. No retry or
substantive-fix follow-up was needed.

CLI-owned persistence was denied by the sandbox. The final execution-tool
chunk also truncated intermediate text events, but retained the complete
terminal response and result; the record does not claim a lossless stream.
The caller saved the available capture separately. No permissions were changed.
Gemini did not reproduce Lean, hash, or preservation checks.

Preservation passed for 24 unrelated/protected files, B1a declarations, all
twenty original guards and prior type/definition/value checks, and the archived
prompt bytes. Pre-review local Markdown links/anchors passed (171). The
post-review record and final staging receive fresh link/whitespace/preservation
checks. The reviewed Lean source and audits are unchanged after passing checks.

The reviewed milestone was committed locally as
`0f5d5da16c51e805294f32aec8f633ee462d1582`, selecting only the fourteen task-owned
paths with `git commit --only`. Its parent is the saved prompt commit `32e0974`.
Staged whitespace passed; final links/anchors passed (206), alongside all
preservation checks. Only the unrelated Obsidian/notes/papers work remained.

After committing, reread the committed `Series.lean`, root export, and audit
additions. `hq0` supplies geometric-series applicability and norm/power signs;
`hqle` supplies strict convergence/denominator positivity and the exponent
bound; `hden` makes the denominator condition explicit. `hp` supplies both
sides of the polynomial absolute bound, and `mul_le_mul` combines it with the
ratio-power bound under the required signs. Final algebra matches the exact
requested sum/majorant expressions. The existing public root import exports
the two declarations; type, axiom, and boundary checks meet the acceptance
criteria. No unused proof layer or unnecessary public helper was found. No
substantive simplification or fix was justified, so no focused Gemini follow-up
or empty code commit was needed.

The final documentation commit changes only this handoff and the research log
to record that completed necessity review. Retrieve its ID with
`git log -1 --format=%H -- docs/b1b-handoff.md`; both commit IDs are also reported
in the session's final response. These factual records do not change the
reviewed proofs or their passing validation inputs.

## Remaining obligations and proposed next task

B1a/T1 and B1b/T2 plus T3's pointwise norm bound are checked. The summable
majorant/measurability/integrability instances and sum/integral interchange
remain unproved locally, as do rational algebra, antiderivative/FTC conditions,
endpoint evaluation of the integral, and the final `HasSum ... Real.pi` theorem.
B2's orbit bridge, B3's tails, V's independent arbitrarily late visitation,
Hπ, T, and π disjunctivity remain open. B4 assumes vanishing error and arbitrarily
late visits; P3 assumes open-interval visits. No premise is discharged here.

The next proposed slice, requiring separate authorization, is
[B1c sum/integral interchange](proof-plan.md#next-bounded-task-b1c-sumintegral-interchange):
prove `HasSum (fun j => bbpCoeff j / 16^j) (∫ x in (0 : ℝ)..1, P(x)/(1-q(x)))`.
It would use B1a/B1b and discharge dominated-convergence premises, stopping
before integral evaluation. No B1c proof was begun. The integral route, direct
`HasSum` plan, B1-before-B3 ordering, and Viewpoint cadence are retained.
Local library search and the compiler loop sufficed; no optional tooling or
process expansion is justified.

**Paused at the B1b endpoint, before interchange or any other milestone.**
No push, PR, history rewrite, or permission change was made. The final two-file
documentation diff, whitespace, links, and preservation are checked before its
commit; unrelated work remains untouched.
