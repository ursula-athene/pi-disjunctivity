# B1c sum/integral interchange handoff

Implementation checked 2026-11-25 on `feature/attempt-04`, in
`/Users/adam/personal/proj/pi-disjunctivity/pi-disjunctivity`.

**B1c is complete: checked, reviewed, committed, and reviewed for necessity.**
The full B1 identity and π disjunctivity remain open.

## Checked result and mathematical meaning

[Series.lean](../PiDisjunctivity/BBP/Series.lean) adds exactly one public theorem,
`PiDisjunctivity.hasSum_bbpCoeff_integral`, with no hypotheses:

```lean
HasSum (fun j : ℕ => bbpCoeff j / (16 : ℝ) ^ j)
  (∫ x in (0 : ℝ)..1,
    (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5) / (1 - x ^ 8 / 16))
```

It establishes convergence and the sum's integral value. The integral remains
unevaluated; no equality with `Real.pi` is asserted. The existing public import
of `BBP.Series` in the library root exports the theorem without a root-file edit.
All twenty-two prior theorem audits, definition/value checks, and B1b endpoint
and zero-index regressions are preserved. `Test.lean` adds the full unconditional
type check and guards the inspected actual axiom list: exactly `propext`,
`Classical.choice`, `Quot.sound`. There are twenty-three theorem audits in total.

The pinned API in `Mathlib/MeasureTheory/Integral/DominatedConvergence.lean`
requires five premises. Each is discharged locally:

1. For each natural `j`, the term is continuous on the real line, hence almost
   everywhere strongly measurable for volume restricted to `Set.uIoc 0 1`.
2. `Set.uIoc 0 1 = Set.Ioc 0 1` by `0 ≤ 1`, and this is contained in
   `Set.Icc 0 1`. Thus `norm_bbpTerm_le` supplies the bound. The API asks for
   an almost-everywhere implication under unrestricted volume; `ae_of_all`
   supplies the stronger pointwise implication.
3. The geometric ratio `1/16` is nonnegative and strictly less than one, so
   multiplication by `8` preserves summability of the majorant.
4. Its sum is constant in `x`, so `intervalIntegrable_const` applies; no
   numerical evaluation of the sum is needed.
5. The same interval inclusion and `hasSum_bbpTerm` give the pointwise sum,
   again lifted by `ae_of_all` to the API's almost-everywhere implication.

The theorem first obtains `HasSum` of term integrals and then rewrites with
`integral_bbpTerm`. The measure is volume, endpoints are ordered `0..1`, the
index starts at zero, and all division is real. B1b covers both closed endpoints;
the restricted interval excludes zero and includes one exactly as the Mathlib
API requires. No endpoint assumption is lost. No extra definitions, public
helpers, tail layer, external proof translation, or unproved analytic premise
was introduced. Statement review is separate from the compiler/audit evidence.

## Checkout, permissions, and validation

Starting HEAD: `57a0b0a6f6fbd078bc90073e627de37b26eef63d` on the already prepared
`feature/attempt-04`. Live `git ls-remote origin refs/heads/main` returned
`4eb973b0c3521a962a90f3d0aacafc2a4d5d7d50`, matching local main/origin/main and
HEAD's parent, the merge of PR #3. No branch recreation or fetch was needed.
Unrelated Obsidian, notes, and papers files are preserved and excluded.

The exact saved `agy` prefix check returned `decision: allow`. The active
profile permits workspace and temporary writes and provides no escalation.
No permission settings were changed. The completed B1 source review, B1a,
and B1b were used as prerequisites and were not repeated.

From the repository root with `$HOME/.elan/bin` on `PATH`:

| Check | Result |
| --- | --- |
| `lean --version` | `4.37.0-rc1` |
| Baseline `lake build` and `lake env lean Test.lean` | Pass: 7201 jobs, twenty-two existing theorem audits |
| Direct module compilation | Pass on first attempt, no warnings |
| Integrated `lake build` | Pass: 7201 jobs, no warnings |
| `lake env lean Test.lean` | Pass: twenty-three guards and all existing checks, no warnings |
| Root-import axiom/type probe | Exact unconditional type and the three permitted axioms |
| `git diff --check` | Pass |
| Protected definitions, pins, and manifest diff | Empty |

There was no compiler, library, or mathematical obstruction. The only new
import is pinned Mathlib's dominated-convergence module. Existing declarations,
MIT headers, Ursula Athene attribution, module/public conventions, enabled
linters, dependencies, and CI remain unchanged. No clean-environment rebuild
or remote CI result is claimed. Final preservation and link checks accompany
review and staging below.

## Required review and local finalization

Gemini Carbon High completed the full twelve-file exact-diff review with
**explicit no findings**. Conversation: `4a662fa5-c864-445d-bd2c-9e10168f1c93`.
The [review report](agy-reports/b1c-review.md) records the diff hash, complete
response, attempts, timestamps, terminal fields, and limitations.

The first invocation ended after 13.070 seconds with exit 0 / `SUCCESS` but
an empty response and a denied temporary-file read, so it was incomplete.
After inspecting events/stderr and the CLI log and confirming termination,
the single focused recovery resumed the same conversation with the complete
diff supplied inline. It finished in 209.461 seconds, exit 0, `SUCCESS`,
nonempty response, and no terminal error/finished-reason/denied-action fields.
No scope was omitted, no denied resource was reread, and no permission changed.
No substantive findings or follow-up were needed.

The reviewer read repository files only; Lean execution, the manifest, Git
preservation/hashes, and the pinned Mathlib signature relied on caller checks.
Recovery CLI persistence was sandbox-denied but the review completed. Full raw
execution chunks were saved before any abbreviated diagnostic display; the
complete terminal response was separately inspected. The saved execution capture is complete.

Pre-review checks passed for 25 unrelated/protected file hashes, all earlier
Lean declarations/audits/checks, archived prompt bytes, manifest/package pins,
imports/trust, and 184 local Markdown links/anchors. Final review records and
staging receive fresh preservation/link/whitespace checks. The reviewed Lean
source and audits are unchanged after their passing validation.

Committed the reviewed milestone locally as
`f4184d8d5ccb112f9449e6e9148d8cbcc50b35e9`, with parent `57a0b0a`, using
`git commit --only` for the thirteen task-owned files (the twelve reviewed
files plus the review report). Staged whitespace, 235 local Markdown links/
anchors, and all preservation checks passed. The remaining working-tree
changes were only the original Obsidian, notes, and papers files.

After committing, reread the committed module, root export, and audit additions.
The local `hsub` is reused for both bound and pointwise sum; it explicitly fixes
the interval orientation and inclusion. `hsum` instantiates the required
integral-series API at the precise terms and kernel. Its five proof branches
supply exactly the five required premises; the final rewrite connects B1a's
term integrals to the required coefficients. The existing root import and
new complete type/axiom guards provide export and trust coverage. No unused
layer, public helper, or substantive simplification was justified, so no
focused fix review or empty code commit was needed.

The final two-file documentation commit records this completed necessity
review in this handoff and the research log. Retrieve its ID with
`git log -1 --format=%H -- docs/b1c-handoff.md`; both local commit IDs are
reported in the session's final response. Its diff, whitespace, links, and
preservation are checked before committing. The reviewed Lean inputs remain
identical to the passing build and audit.

## Remaining obligations and proposed next task

B1a/T1, B1b/T2, and B1c/T3 are checked. Full B1 still needs rational kernel
algebra (T4), antiderivative/FTC conditions, integral evaluation, and assembly
of `HasSum ... Real.pi`. B2/B3, V, Hπ, T, and π disjunctivity remain open.
B4 still assumes vanishing errors and arbitrarily late visits; P3 still assumes
open-interval visits. B1c proves none of those missing premises.

The next smallest proposed slice is
[B1d rational kernel decomposition](proof-plan.md#next-bounded-task-b1d-rational-kernel-decomposition):
prove the assessed T4 identity on `[0,1]`, discharging denominator conditions
locally, with an export, full type/axiom audit, validation/review, and handoff.
It requires separate authorization and stops before antiderivative/FTC work,
integral evaluation, full B1, B2/B3, or V. No B1d implementation was begun.

The direct `HasSum` integral route, B1-before-B3 order, and Viewpoint cadence
remain appropriate. Local pinned-source search and the compiler loop sufficed;
no process expansion or optional tooling was warranted. Both plans, blueprint,
current session instructions, and affected audit summaries reflect this status.

**Stop at B1c; no push or PR and no next milestone without authorization.**
