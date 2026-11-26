# B2 orbit bridge handoff — 2026-11-25

## Baseline and authorized endpoint

Started from updated `main` at `c3b3bd1dff4f975a93a1530e4daeaf9273a0176d`, after
GitHub verified PR #5 merged. Created `feature/attempt-07-b2-orbit`, preserving
all existing branches and unrelated Obsidian workspace/hotkeys, notes, and papers.
No separate worktree was necessary. The user invoked all B2, superseded the
saved pre-merge branch instructions, authorized regular pushes, and prohibited
a PR. The proof plan was updated before implementation.

**B2 is complete: checked, reviewed, committed, pushed, and reviewed for necessity.**
B2a commit: `d4135bea00cd5fdb47468f09301dc269abfd8b93`. Complete bridge commit:
`a7f31bc63e00082c14f8579a3c3e17ca6b523ddf`. Both are pushed to the new branch.
The final factual acceptance receipt is committed/pushed separately; identify it
with `git log -1 --format=%H -- docs/b2-handoff.md`. No PR was opened.
The endpoint excludes B3 estimates/decay, modular computation, visitation
research, and final conjecture assembly. B2 alone does not complete M3/Step 4.

## Contracts and indexing

All names below are in `PiDisjunctivity`, exported through the root from
[Orbit.lean](../PiDisjunctivity/BBP/Orbit.lean). The existing `bbpCoeff` and B1
proofs are unchanged. Exposed definitions use natural indices and real values:

```text
bbpPartialSum n = ∑ j ∈ range (n+1), (16 : ℝ)^(n-j) * bbpCoeff j
bbpTail n = ∑' r : ℕ, bbpCoeff (n+r+1) / (16 : ℝ)^(r+1)
bbpRecurrence 0 = 0
bbpRecurrence (n+1) = Int.fract (16 * bbpRecurrence n + bbpCoeff n)
```

The recurrence is independently recursive, not defined as the finite sum's
fractional part. The six public results are unconditional, each for every
`n : ℕ`:

| Theorem | Complete conclusion |
| --- | --- |
| `hasSum_bbpTail_sub` | `HasSum (fun r : ℕ => bbpCoeff (n+r+1)/(16 : ℝ)^(r+1)) ((16 : ℝ)^n*Real.pi - ∑ j ∈ Finset.range (n+1), (16 : ℝ)^(n-j)*bbpCoeff j)` |
| `hasSum_bbpTail` | `HasSum (fun r : ℕ => bbpCoeff (n+r+1)/(16 : ℝ)^(r+1)) (bbpTail n)` |
| `pow_mul_pi_eq_bbpPartialSum_add_bbpTail` | `(16 : ℝ)^n*Real.pi = bbpPartialSum n + bbpTail n` |
| `bbpRecurrence_mem_Ico` | `bbpRecurrence n ∈ Set.Ico (0 : ℝ) 1`, equivalently `0 ≤ bbpRecurrence n ∧ bbpRecurrence n < 1` |
| `bbpRecurrence_succ_eq_fract_bbpPartialSum` | `bbpRecurrence (n+1) = Int.fract (bbpPartialSum n)` |
| `fract_pow_mul_pi_eq_bbpRecurrence_add_bbpTail` | `Int.fract ((16 : ℝ)^n*Real.pi) = Int.fract (bbpRecurrence (n+1) + bbpTail n)` |

B1 is scaled and split at `n+1`. Prefix membership supplies `j ≤ n` before
natural subtraction is rewritten. Tail reindexing starts at coefficient `n+1`
with denominator 16, not coefficient `n` or denominator 1. `HasSum` supplies
convergence independently of the total `tsum` definition.

Private zero/successor prefix lemmas prove `S(0)=A(0)` and
`S(n+1)=16*S(n)+A(n+1)`. Induction for the recurrence uses
`Int.fract_eq_fract` with integer witness `-16 * ⌊S(n)⌋`. Thus multiplication
by 16 is justified modulo integers. `Int.fract_fract_add` then gives the exact
orbit bridge. No fractional-part linearity or global Lipschitz claim is used.
The range theorem handles zero separately and uses fractional-part bounds at
successors. None of these results supplies visitation.

## Acceptance evidence and limitations

Pinned Lean `4.37.0-rc1` baseline build passed (7201 jobs) with all 27 original
audits. Integrated build passed (7203 jobs), and `lake env lean Test.lean`
passed **33** complete theorem-type/axiom guards and all definition/boundary
checks. All six inspected new axiom lists are exactly `propext`,
`Classical.choice`, and `Quot.sound`. Prior `Test.lean` content is preserved
verbatim. Early root definition/equation and downstream full-type probes passed.
The final build has no warnings; the line-length linter remains enabled.

Zero-index checks instantiate both the convergent split and scaled identity;
recurrence and orbit boundary checks instantiate the intended theorems at zero,
and the orbit theorem also at one. Separate definition arithmetic checks
`y(1)=2/15` and `S(1)=16*A(0)+A(1)`.

The B2a checkpoint passed 23 offline utility tests, documentation checks,
working/staged whitespace, imports/pins/definition preservation, and 80 baseline
file hashes outside that checkpoint's scope. Final pre-review validation also
passes all 23 utility tests, 44 tracked Markdown files, working/staged whitespace,
and 76 baseline file hashes outside the complete scope. Original audits/log
content and the original B2 prompt body/prior archive are preserved verbatim. No dependencies,
linters, permissions, original problem definitions, or prior Lean proofs changed.
No extra axioms, placeholders, unsafe shortcuts, or external proof scripts were added.

See [the Carbon High report](agy-reports/b2-review.md) for exact baselines/hashes,
conversations, timing, terminal fields, findings, and capture locations. B2a's
review found no proof/audit issue and one stale documentation status/count issue,
which was corrected. Raw captures are temporary and CLI conversation persistence
was sandbox-denied; those are retention limitations. Reviewer tools are read-only;
caller Lean/Git/Python validation is separate. No clean-environment rebuild or
remote CI result is claimed.

B2a's post-commit necessity inspection found each definition, convergence result,
split, export, and check required by the contract or next proof layer. No
substantive simplification or empty follow-up commit was needed. The completed milestone
necessity inspection is recorded below.

## Restart and remaining obligations

Use [the current entry point](proof-attempt-session-prompt.md),
[proof plan](proof-plan.md#next-bounded-task-b3-tail-control), and
[blueprint](proof-blueprint.md#remaining-bbp-route), verifying actual branch,
HEAD, working tree, and remote state. B3 coefficient/tail bounds and `R(n) → 0`,
V's independent arbitrarily late visits, Hπ, T, and π disjunctivity remain open.
B4 still assumes vanishing errors and late visits; P3 assumes open-interval
visits. The exact B2 identity discharges none of those premises.

Compiler feedback, not missing mathematics, repaired explicit `pow_sub₀`
arguments, tail power normalization, the natural-successor subtraction rewrite,
and a boundary simplification's `Nat.zero_add`. One diagnostic `#check` used a
nonexistent API name; all exported definition probes themselves passed. One
long production line was wrapped. The [retrospective](retrospectives/retrospective-2026-11-25-b2.md)
records process lessons without claiming a productivity measurement.

Stop at B2. B3 is the next proposed bounded task, not an active authorization.

## Final acceptance and post-commit necessity review

Full Carbon High review completed with explicit no actionable findings and
confirmed the B2a documentation finding resolved. Two successful invocations
(one checkpoint, one complete-milestone review), no failed runs or recovery
retries, both captures complete. Elapsed times: 322.675 and 395.930 seconds.
The full review also inspected the pinned Mathlib floor/infinite-sum sources.
The prior conversation was unavailable, so the CLI created a new one from the
fully supplied diff/context; this did not narrow coverage. See the linked
report for both conversations and terminal fields.

Reviewed all six public theorem proofs, two private prefix lemmas, three exposed
definitions, root export, and new audits again from committed `a7f31bc`.
The scaled `HasSum` split supplies both the defined tail convergence and exact
π split. Prefix zero/successor facts supply the induction base/step. The range
result is an explicit requested contract; the integer witness supplies the
modulo-integer argument; the orbit theorem composes those results directly.
Definition checks protect the independent recurrence and offsets, while the
boundary instances exercise actual theorems. Each public result is a required
endpoint or a direct proof consumer's prerequisite. No unnecessary abstraction,
unused helper, or justified substantive simplification was found. No empty code
commit or additional fix review was needed.

Final factual receipts update completion status, commit/publication evidence,
and this necessity review. Documentation links, working/staged whitespace,
exact owned scope, unchanged reviewed Lean/audit hashes, preserved prior audit/log
and prompt/archive content, and unrelated-file preservation are rechecked before
the receipt commit. Final remote equality is verified after pushing. The tested
and reviewed Lean/audit bytes are unchanged; no additional Lean run is needed
for these factual Markdown receipts. Stop before B3 or visitation.
