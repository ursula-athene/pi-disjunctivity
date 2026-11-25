# Research log

Record substantive attempts and checked outcomes here. The mathematical
roadmap is [proof-plan.md](proof-plan.md); current dependencies and statuses are
in [proof-blueprint.md](proof-blueprint.md). Operational instructions and
source adaptations are in [proof-workflow.md](proof-workflow.md).

## 2026-11-24 — Meta-plan execution and bounded interval pilot

### Authorization and baseline

The user authorized execution of [meta-proof-plan.md](meta-proof-plan.md) and
one smallest useful unfinished milestone supporting the proof plan. They
excluded paid external services, sub-agents, and an indefinite π proof attempt.
Selected and announced endpoint: Step 2's explicit interval-hitting reduction,
including a general equivalence and a conditional π specialization. The
suggested implementation-order row also mentions a margin transfer theorem;
that separate Step 4 result was deliberately left for another bounded task.

Initial checkout: `feature/attempt-02`, HEAD
`990cd1316c678517419c2981a08ad9794f78ffe9`. The proof plan's older
`feature/attempt-01` commit is a historical planning baseline, not this run's
checkout. Read `AGENTS.md`, the formulation, dependency/trust policy,
consolidated review, follow-up, proof plan, and current Lean source/audit before
implementation. Formulation milestones A–C were complete; there were fifteen
audited theorems and no `OrbitCriteria.lean`.

Initial unrelated work: modified `docs/.obsidian/workspace.json`, untracked
`docs/.obsidian/hotkeys.json`, and untracked `docs/notes/`. Left untouched.
No dependencies, toolchain pins, existing mathematical definitions, or prior
proofs were changed.

With `export PATH="$HOME/.elan/bin:$PATH"`:

| Command/inspection | Actual baseline result |
| --- | --- |
| `command -v lake lean rg` | Existing executables found; no installation required. |
| `lake --version` | Lake `5.0.0-src+0b77e12`, Lean `4.37.0-rc1`. |
| `lean --version` | Lean `4.37.0-rc1`, `arm64-apple-darwin24.6.0`, commit `0b77e12952ad39077d80d8bd6b66d601f225c321`. |
| `lake build` | Passed: 6653 jobs, no warnings. |
| `lake env lean Test.lean` | Passed silently: fifteen theorem type/axiom guards and two expanded-definition checks. |
| `git diff --check` | Passed. |
| Available tool catalog | No Lean LSP/MCP tools exposed. Shell fallback used throughout; optional compatibility not tested. |

### Source inspection and adaptation

Read original method sections in arXiv `2602.24273v1`, `2610.17331v1`,
`2606.06468v1`, and `2602.10177v2`, plus Goedel-Architect's README,
lean4-skills' `SKILL.md`, and lean-lsp-mcp's README. Exact links, inspected
repository revisions, adoption decisions, and omissions are recorded in
[the adaptation table](proof-workflow.md#source-adaptations).

The useful components were local search, real compiler feedback, explicit
dependency records, and separate criticism of a proposed argument. No source
framework was installed or run. No benchmark was reproduced. The review was
performed sequentially in this session, not by an independent agent.

### Specify, search, and sketch

For `x ≥ 0`, prove exactly

```text
IsDisjunctive 16 x ↔
  ∀ k m : ℕ, m < 16^k → ∃ n : ℕ,
    fract(16^n*x) ∈ [m/16^k, (m+1)/16^k).
```

Then specialize the reverse direction to `Real.pi`, leaving the displayed
interval-hitting property as an explicit parameter. This needs no new
π-specific fact beyond the already available positivity theorem.

Project search with
`rg -n 'blockValue_lt|exists_blockValue_eq|block_iff_mem_interval' PiDisjunctivity`
located the full required API. Searching pinned Mathlib for
`disjunctiv|hexadecimalOrbit|block_iff_mem_interval` returned no matches (exit 1),
consistent with these being project-specific declarations. It was not a claim
to exhaust all related library mathematics. `#check` in the scratch file
confirmed the three exact signatures.

Forward sketch: given a cell value `m < 16^k`, obtain a length-`k` word from
`exists_blockValue_eq`, use disjunctivity once for that word, and apply
`block_iff_mem_interval`. Reverse sketch: for a given word, its value is below
`16^k` by `blockValue_lt`; the assumed visit and the reverse correspondence
give every digit at a single position `n`.

### Separate statement and argument criticism

Reviewed the displayed statement, short argument, and prerequisite signatures
as a distinct pass before formalization; checked the final proof again after
compilation. No fresh context or independent review is claimed.

- Natural `k,m,n` include zero and make the lower index bounds implicit.
  At `k = 0`, `m < 1` forces `m = 0`, so the cell is `[0,1)` and the word is
  empty. Existing range and correspondence proofs include this case.
- `k` remains independent of `m`: `00A` uses `k = 3, m = 10`, not the one-digit
  interval for `A`. All words retain their length and digit bounds.
- `Set.Ico` includes the left boundary and excludes the right boundary. The
  final cell has upper endpoint 1, which a fractional part never attains.
- `∀ k m, ∃ n` lets the position depend on the entire word. The reverse proof
  uses that same `n` for every `i : Fin k`; it does not choose positions per digit.
- Nonnegativity is retained for the `Nat.floor` digit interpretation; π uses
  `Real.pi_pos.le`. There is no extension to arbitrary signed inputs.
- Neither direction creates independent visitation evidence. The forward
  direction assumes disjunctivity and must not be used circularly to supply the
  π wrapper's premise. No normality, almost-everywhere theorem, finite digit
  experiment, BBP identity, or approximation estimate enters this proof.

No mathematical gap or counterexample was found in the reduction. The missing
unconditional π interval-hitting claim is exactly the original conjecture in
another form, as the checked equivalence makes explicit.

### Formalization and feedback

`lake env lean /tmp/pi-disjunctivity-interval-pilot.lean` passed on the first
candidate. It used the two project imports now in `OrbitCriteria.lean`, the
three `#check` commands, the complete proofs, `trace_state` before closing the
reverse implication, and unguarded `#print axioms` for the two additions.
The actual goal after obtaining the cell visit was:

```text
hn : fract(16^n*x) ∈ Ico (blockValue k s / 16^k) ((blockValue k s + 1) / 16^k)
⊢ ∃ n, ∀ i : Fin k, baseDigit 16 x (n + i.val) = (s i).val
```

This is a readable transcription; Lean's printed context additionally included
`x`, `hx`, the universal hitting hypothesis, `k`, `s`, and `n`, with casts.
The final line applies the existing correspondence at that `n`.
Both actual axiom lists were exactly `[propext, Classical.choice, Quot.sound]`.
No failed tactic repairs, resource-limit failures, or mathematical route changes
were needed; none are invented as evidence of iteration.

Production proofs are in [OrbitCriteria.lean](../PiDisjunctivity/OrbitCriteria.lean):
`isDisjunctive_iff_hitsHexadecimalIntervals` and
`piHexadecimalDisjunctivity_of_hitsHexadecimalIntervals`. The root exports the
module. `Test.lean` adds both explicit type checks and exact axiom guards while
retaining the earlier checks. The temporary diagnostics are absent from the
production module. Each proof step uses one of the three searched prerequisites
or π positivity; no extra supporting API was needed.

### Final validation and outcome

| Command/inspection | Result |
| --- | --- |
| `lake env lean PiDisjunctivity/OrbitCriteria.lean` | Passed silently. |
| `lake build` | Passed: 6655 jobs, no build or linter warnings. Builds the new module and root export. |
| `lake env lean Test.lean` | Passed silently: seventeen theorem-type/axiom checks plus the two original expanded-definition checks. |
| Scratch `#print axioms` for both new declarations | Each reports exactly `propext`, `Classical.choice`, `Quot.sound`; these observed lists are guarded in the integrated audit. |
| Byte comparison with `git show HEAD:<path>` | Every pre-existing Lean module is unchanged. Root and `Test.lean` have insertions only; all old proof, example, type-check, and guard lines are retained. |
| Dependency/configuration inspection | `lakefile.toml`, `lake-manifest.json`, `lean-toolchain`, and CI are byte-identical to HEAD. One direct Mathlib dependency, locked to `31ce06eaadf4a200c0e1407c5f10953cf606b8f8`; no new imports outside Mathlib/project modules. |
| Project source scan | No placeholder proofs, new axiom declarations, `native_decide`, or unsafe shortcuts. Seventeen exact axiom guards counted. |
| Documentation review | Local link targets and heading anchors in task-edited Markdown checked by a temporary Python inspection; status counts reconciled in the roadmap, formulation status, trust document, and README. |
| `git diff --check` | Passed. |

The preservation/import/link inspection used standard Python library code in
the shell, not an installed tool or a new project dependency. No remote CI,
clean-environment rebuild, or independent audit of all imported Mathlib
artifacts is claimed. The checks use the existing local dependency artifacts.
Changes were uncommitted at the pilot handoff; no publication was requested
or performed. The subsequent commit request is recorded below.

### Workflow assessment and handoff

The pilot completed Step 2, not the combined interval/transfer suggestion or
the BBP route. Local signature search avoided duplicating foundational theory;
the compiler displayed the needed goal without an LSP service; the type and
axiom audit checked the exported result. The blueprint makes the still-open
premise explicit. Source review and status reconciliation took more work than
this elementary proof; no additional orchestration would have helped it.

Remaining exact obstruction: for the fixed BBP recurrence, no independent proof
of visits to every interior interval beyond every threshold is supplied (node
V). BBP convergence/identity and the orbit/tail bridge also remain unformalized.
The next recommended bounded task is the generic interior-margin transfer
lemma and open-interval-to-cell conversion, keeping late visitation as a
hypothesis. Stop this session after the present pilot and documentation.

## 2026-11-24 — Record the next bounded task and prepare the requested commit

The user asked whether the conditional interior-margin transfer task was in
both plans, requested any missing addition, and authorized a commit. It was
already outlined in proof-plan Step 4 and its implementation-order table, but
was not explicitly named as the next task in the meta-plan.

Added a linked next-task entry to the meta-plan and a precise bounded-task
subsection to the proof plan: general sequences, vanishing error, arbitrarily
late visitation as a hypothesis, the interior-margin conclusion, conversion
to hexadecimal-cell visits, and the required validation. This records the
next task without starting it. The commit includes the completed pilot and
its documentation; unrelated Obsidian and notes changes are excluded.

## 2026-11-24 — Independent review triage and approved documentation follow-up

Independently assessed the [external review](agy-reports/meta-proof-plan-review-report.md)
at `0a59212` on `feature/attempt-02`. The user first authorized read-only triage,
then approved the targeted documentation patch, commit, and push, followed by
a pause. No proof milestone, tooling installation, or delegation was authorized.

The preceding triage located the nested repository root, read the cited source
and documentation, and checked the original papers and three pinned GitHub
documents. With `$HOME/.elan/bin` on `PATH`, Lean reported `4.37.0-rc1`;
`lake build` passed with 6655 jobs and no warnings, `lake env lean Test.lean`
passed silently with seventeen type/axiom audits, and `git diff --check` passed.
All nine dependency checkouts matched the manifests and were clean. Elan's
parent-directory selection was `4.36.0`; the reported wrong-toolchain cache
overwrite was not reproduced. Disposable `/tmp` probes, with the exact
`lakefile.toml` options passed to Lean, confirmed an `unusedVariables` warning
for an unused named `Prop` hypothesis and availability of the three search
tactics. No B4 or cell-conversion proof was implemented.

Adopted D1–D3 and R2: remove B4's redundant range premise, track independent
cell conversion as P3, correct the status summaries, and add root/version and
preservation-diff checks. The margin argument works at both boundary endpoints
and for signed errors: with `δ = (b-a)/4`, a late visit to `(a+δ,b-δ)` and
`|r n| < δ` keep the perturbed value in `(a,b) ⊆ (0,1)`. B2's range fact
remains valid independently.
Recurrence indexing, cell boundaries including `k = 0`, and both tail constants
were also checked mathematically; visitation V remains open.

Adapted R1, R3, and R4: retain the user-owned Viewpoint policies and requested
next-task entries in both plans; distinguish implementation milestones M1–M5
from roadmap Steps 1–7; use `Set.Ioo` consistently for B4/P3; and recommend
optional scratch tactic search and advisory fresh-session criticism. Aletheia's
suggested reasoning-trace mechanism is not a demonstrated guarantee here.
The report's Lean-size estimate is unverified, its source count should be eleven
files including `Test.lean`, and negative inputs need not have nontrivial
fractional-part orbits (for example, `x = -1`). D1 strengthens a valid statement;
it does not repair a false theorem.

For OQ1, examples remain selective semantic/boundary checks, supplementing
universal proofs and audits. For OQ2, weighted-series/tail summability and B3
could precede B1, but changing that order awaits a separate user decision.
The existing order and commit cadence are preserved. Late-output strengthening
and an extra composition theorem are deferred. B4 and P3 remain unformalized;
Hπ and T remain blocked. The external report and historical log entries are
preserved, as are unrelated Obsidian and notes files.

Documentation validation: `git diff --check` and relative Markdown file/heading
link checks passed. File hashes confirmed that only the seven approved Markdown
files changed; Viewpoint policy text was also compared directly with HEAD.
The preservation diff for all project Lean sources and dependency pins was empty.
The Lean build/audit results above are from the preceding triage; no rerun was
needed for this documentation-only change. Stop after the requested commit and
push, before beginning B4/P3.


## 2026-11-25 — B4 conditional transfer and P3 cell conversion

### Scope, checkout, and baseline

Executed `docs/proof-attempt-session-prompt.md` at the user's request. The
endpoint was exactly B4 and P3, their exports and audits, a retrospective,
plan/status reconciliation, local milestone commits and post-commit review,
and a committed handoff followed by a pause. No later milestone was authorized.

The repository root is the nested `pi-disjunctivity/` directory containing
both `lakefile.toml` and `lean-toolchain`, alongside another Lean project.
Initial branch: `feature/attempt-02`; HEAD:
`04ac826016f51cb190e44f8ba43dd9b4cc9a5a2a`. Existing user changes in
`docs/proof-attempt-session-prompt.md`, `docs/.obsidian/`, and `docs/notes/`
were preserved and excluded from staging. The prompt's working-copy addition
requests a committed Markdown handoff; it was followed without staging the
user's edit itself.

Read the required repository instructions, plans, workflow, blueprint, log,
formulation/trust records, current modules and audits, and dependency files.
With `$HOME/.elan/bin` on `PATH` and all Lean commands run from that root,
`lean --version` reported `4.37.0-rc1` (commit `0b77e12952ad39077d80d8bd6b66d601f225c321`).
Baseline `lake build` passed (6655 jobs, no warnings), `lake env lean Test.lean`
passed silently (seventeen theorem audits and both definition checks), and
`git diff --check` passed.

### Search, argument, and separate criticism

Project search located the cell endpoint arithmetic in `OrbitEquivalence.lean`.
Pinned Mathlib search and scratch `#check` confirmed `Metric.tendsto_atTop`,
`Int.fract_eq_self`, `Real.dist_eq`, `div_lt_div_iff_of_pos_right`, and
`div_le_iff₀`. These supply the entire required API; no new helper declaration
or external source adaptation was needed.

B4: for `u r : ℕ → ℝ`, assume only `r → 0` at infinity and visits of `u` to
every `Set.Ioo a b` with `0 ≤ a < b ≤ 1` beyond every natural threshold.
Set `δ = (b-a)/4 > 0`, choose `N` such that `n ≥ N` gives `|r n| < δ`, then
choose a visit to `(a+δ,b-δ)` at such an `n`. The signed error bounds give
`a < u n + r n < b`. Thus the perturbed value is in `[0,1)` and its fractional
part equals itself. The conclusion asserts one visit for each target interval.

P3: for arbitrary `t : ℕ → ℝ`, assume one visit to every such open interval.
For `k m : ℕ`, `m < 16^k`, the denominator `(16 : ℝ)^k` is positive, the lower
cell endpoint is nonnegative, the endpoints are strictly ordered, and the upper
endpoint is at most 1 by casting `m+1 ≤ 16^k`. Apply the hypothesis to that open
interior and weaken only its lower strict inequality to obtain `Set.Ico`.

Reviewed the statements and arguments in a distinct pass before formalization
and checked the resulting source again after compilation. This was sequential
self-review, not an independent agent or fresh-context audit.

- In B4 the convergence threshold is chosen before the late visit, and the
  occurrence can depend on the whole target interval. Single visits of `u`
  alone would not justify this choice.
- At `a = 0` and/or `b = 1`, the quarter-width margin still yields strict
  perturbed bounds inside `(0,1)`. Splitting `abs_lt` covers errors of either
  sign. No global range bound on `u` or Lipschitz assertion about `Int.fract`
  enters the proof.
- In P3, `k = 0` forces `m = 0`, with open interior `(0,1)` and output cell
  `[0,1)`. For any `k`, the first cell has lower endpoint 0, and the last cell
  `m = 16^k-1` has upper endpoint 1 because `16^k > 0`. The strict upper
  inequality is retained. There is no assumption that all values of `t`
  lie in `[0,1)`.
- P3 does not depend on B4 or any BBP fact. Neither lemma proves the input
  visitation hypothesis, and neither adds a π-specific analytic identity.

### Formalization and validation

The disposable `/tmp/pi-disjunctivity-b4-p3.lean` contained the signature probes,
both complete candidate proofs, and unguarded axiom reports. It compiled on the
first attempt. Each actual axiom list was exactly
`[propext, Classical.choice, Quot.sound]`; the integrated guards use those lists.
No compiler, library, mathematical, or environment obstruction occurred.

Added only two public theorems to `OrbitCriteria.lean`:

- `hitsOpenIntervals_fract_add_of_tendsto_zero` (B4).
- `hitsHexadecimalIntervals_of_hitsOpenIntervals` (P3).

The existing `public import PiDisjunctivity.OrbitCriteria` in the library root
already exports both results; the root needed no edit. `Test.lean` checks both
complete types through that root and guards their axioms, retaining all earlier
seventeen theorem audits and both expanded conjecture-definition checks.
The only added import is `Mathlib.Tactic`, following the neighboring module's
convention. Production proofs contain no scratch diagnostics. No helpers,
late-output strengthening, composition theorem, or `Examples.lean` additions
were needed; the complete type checks and universal proofs cover the specified
boundary cases without duplicating them as examples.

| Command/inspection | Actual result |
| --- | --- |
| `lake env lean /tmp/pi-disjunctivity-b4-p3.lean` | Passed; printed the exact library signatures and permitted axiom lists. |
| `lake env lean PiDisjunctivity/OrbitCriteria.lean` | Passed silently. |
| `lake build` | Passed: 6655 jobs, no compiler/linter warnings. |
| `lake env lean Test.lean` | Passed silently: nineteen complete theorem-type/axiom audits and both definition checks. |
| `git diff --check` | Passed after integration. |
| `git diff HEAD -- lean-toolchain lakefile.toml lake-manifest.json PiDisjunctivity/Definitions.lean PiDisjunctivity/Conjectures.lean` | Empty: pins, dependencies, and reviewed definitions unchanged. |
| Preservation/source inspection | All earlier Lean proofs and root exports are byte-identical to baseline; every prior `Test.lean` line remains in order. Nineteen guards and twenty-one type/definition examples counted. No forbidden proof constructs; Viewpoint policy unchanged. |
| Documentation inspection | Relative Markdown file/heading links in edited documents passed, including the preserved session-prompt anchor; historical audit counts retained. |

Validation used existing local dependency artifacts; no clean-environment
rebuild, remote CI, or independent audit of all Mathlib artifacts is claimed.

### Retrospective and plan adjustment

The mathematical endpoint is met without extra hypotheses. Local library search
and the scratch/compiler loop sufficed; no optional tooling or automation
bottleneck appeared. The proof design needed no revision. The work confirms
that the manual loop handles these elementary lemmas, without measuring its
comparative performance or testing a solution of universal visitation.

Updated the blueprint to mark B4/P3 checked, and reconciled the current audit
count to nineteen in the proof plan, README, formulation, foundations, and trust
summaries. Historical validation counts are preserved. Reviewed both plans:
M1 is complete; B1–B3 and V remain unfinished. The next-task entries now propose
a bounded B1 source and proof review, ending with the argument, source/license
assessment, pinned-library map, and smallest implementation slice. No source
review for that next milestone was begun here. The mathematical route, B1/B3
order, Viewpoint commit cadence, and operational workflow are retained; the
cycle supplied no evidence warranting a process rewrite. Tail/summability work
and B3 before B1 remain a separate user-owned option, not an adopted reorder.

Remaining obstruction to the target: V, arbitrarily late visitation of the fixed
BBP recurrence, has no independent proof; B1's identity, B2's orbit bridge, and
B3's tail control are unformalized. Hπ and T remain unproved. Completing B4/P3
supplies conditional infrastructure only. Stop after local commits, the required
post-commit proof-necessity review, and the final committed handoff; do not begin
the proposed next task.
