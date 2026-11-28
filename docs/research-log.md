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


### Post-commit proof-necessity review and final handoff

Milestone code, audits, plans, and status documentation were committed locally
as `203e16c56c120072dba04301ef975b76ee342300`. Reviewed the committed proof
pieces after that commit, following Viewpoint. B4's margin, convergence
threshold, late visit, signed bounds, and fractional-part identity each serve
the required implication. P3's denominator positivity and three endpoint
conditions are exactly the inputs needed to apply open visitation. Both lemmas
are needed in the planned chain; neither needs a new helper or composition
result. The existing P1/P2 proofs remain relevant and unchanged.

Simplified B4's final bounds to explicit order transitivity, replacing two
`linarith` calls, and used `div_le_one` for P3's upper endpoint, removing the
extra `one_mul` rewrite. The statements, imports, and axiom guards are unchanged.
After these actual follow-up changes, reran
`lake env lean PiDisjunctivity/OrbitCriteria.lean`, `lake build` (6655 jobs),
`lake env lean Test.lean`, and `git diff --check`; all passed without warnings.
The preservation diff against initial `04ac826` for pins and reviewed definitions
was empty. No further proof simplification was warranted.

The [final handoff](b4-p3-handoff.md) records the exact results, changed files,
validation, remaining gaps, and proposed next bounded task. It accompanies the
simplification commit; its introducing commit records that follow-up without
an empty commit or history rewrite. Nothing was pushed. Pause here for the
user's questions and next-milestone decision.


## 2026-11-25 — Review policy and next-session prompt preparation

The user requested the B4/P3 completion information in the proof plan,
Gemini Carbon High code reviews through `agy` at milestones and useful
intermediate points, and a current next-session prompt before an explicitly
inactive archive. This is a documentation follow-up, not execution of B1.

Starting checkout: `feature/attempt-02`, HEAD `76f6e40`. Read the current
`AGENTS.md`, including the user-added `agy` instructions, and retained that
file unchanged. The proof plan already marked B4/P3 checked; added the exact
implementation/follow-up commit references and linked the active B1 prompt.
Added the required review policy to Viewpoint and aligned the meta-plan and
workflow, retaining the existing post-commit necessity review and B1/B3 order.
The completed B4/P3 cycle is not retroactively labeled externally reviewed.

`docs/session-prompts.md` now starts with the bounded B1 source-and-proof-review
prompt. Both the B4/P3 and formulation-review prompts are retained under
`Old prompts - do not use`, unchanged apart from heading depth.
`docs/proof-attempt-session-prompt.md` redirects to the current prompt, and the
README points to the current prompt/archive arrangement. Invocation in a future
session authorizes the B1 review and local milestone commits, followed by a pause;
it does not authorize BBP implementation or universal-visitation work.

Local validation: changed Markdown file/heading links and `git diff --check`
passed; direct comparisons confirmed both archived prompts were preserved.
SHA-256 comparisons confirmed that `AGENTS.md`, all project Lean source and
`Test.lean`, and all three dependency/pin files were untouched. No Lean build
was rerun for this documentation-only change; the B4/P3 validation remains
recorded above. Unrelated Obsidian and notes changes were left untouched.


Gemini review used `agy --model gemini-4-carbon-high --mode plan` and explicit
conversation `4a903f42-ee6d-4555-9609-9b6a401614bd`, scoped to the six plan/prompt/
README files against baseline `76f6e40`, excluding Obsidian and notes. The host
sandbox initially blocked runtime log writes and localhost binding; the approved
scoped retry ran without a permission-bypass flag. Its first result exited zero
with `status: SUCCESS`, an empty `response`, and a denied Bash action. That result
was treated as incomplete. A follow-up restricted to read-only file tools
returned a substantive `SUCCESS` response and one Medium finding: the new review
instructions needed explicit empty-success/denied-action handling and a supplied
diff to avoid headless shell denial.

Accepted that finding after comparison with the actual returned JSON. Updated
the proof plan, workflow, and active prompt to require substantive findings or
an explicit no-findings response, inspect `denied_actions`, and record unresolved
coverage. Headless reviewers should use file tools, with the exact task-owned
diff supplied by the caller. Host execution approval is explicitly distinct
from permissions of the reviewer's internal tools. Gemini reported no other
actionable issues. Its broad pass inspected current files and surrounding
repository context, not the Git baseline diff; local diff, archival, and link
checks were performed separately. The reviewer did not run Lean checks, verify
external BBP sources, or begin B1 work.


A final focused follow-up in the same Gemini Carbon High conversation reviewed
the supplied fix diff without tools and returned `status: SUCCESS` with a
substantive response: resolved, with no remaining actionable issues. This was
a supplied-patch recheck, not a fresh repository/build audit. Final preservation,
archive, Markdown link/anchor, and whitespace checks passed. The documentation
follow-up is committed locally; no next-milestone work or push is included.


## 2026-11-25 — Persist unattended `agy` invocation guidance

At the user's request, updated `AGENTS.md` and linked its persistent-approval
procedure from the proof workflow. Future sessions should invoke the literal
`agy --model gemini-4-carbon-high --mode plan` prefix directly, capture output
through the execution tool, and save it separately. Shell redirects, wrappers,
substitutions, and inline environment assignments can prevent the saved prefix
rule from matching. The guidance distinguishes host rules from Gemini's internal
permissions, records startup/restart behavior, and retains file-tool-only review,
explicit diff input, and incomplete-result handling. No permission rule or global
approval setting was changed.

Validation: the saved host rule was inspected; `codex execpolicy check` returned
`decision: allow` for the direct prefix. Markdown links/anchors and
`git diff --check` passed. The diff for Lean source, audits, pins, and CI is empty,
so no Lean build was rerun. Unrelated Obsidian and notes work is excluded.

A bounded Gemini Carbon High review of the supplied two-file diff was attempted
through direct `agy` invocation, with no shell redirection or reviewer tools.
Conversation: `65b42fe3-3019-4a94-bcb0-e4075583afb3`. It reached the three-minute
CLI deadline and exited 3 with `status: ERROR`, an empty response, and
`finished_reason: print_timeout`. This is an **incomplete external review**;
there are no returned findings or review approval to claim. The requested
documentation commit proceeds with the local checks and this explicit limitation.
No proof milestone or B1 work was started.


## 2026-11-25 — Bound and observe `agy` review waits

The user requested the timeout fix in the agent instructions and appropriate
docs, with the live trial deferred to the next session. `AGENTS.md` now defaults
both initial reviews and explicit-conversation follow-ups to streaming JSON and
a twenty-minute CLI deadline. The proof plan, workflow, and current B1 prompt
link the same progress and bounded-retry procedure. Capture meaningful event
changes and per-invocation timestamps, distinguish permission/service errors
from an unexplained deadline, inspect logs before at most one focused recovery
attempt, and avoid overlapping runs. Unlimited unattended waits are not the
default. No host permission rule, effort level, or model was changed.

The diagnosis used existing results and CLI logs: the substantive review in
conversation `4a903f42-ee6d-4555-9609-9b6a401614bd` took about eight minutes twenty
seconds (00:28:20 to 00:36:40 in the log), and its focused recheck took about one
minute. The resumed conversation's reported duration was cumulative, not the
recheck's wall time. In conversation `65b42fe3-3019-4a94-bcb0-e4075583afb3`, the
log recorded a generation RPC at 00:48:48 and the three-minute CLI timeout at
00:51:40, without a substantive response. This establishes deadline expiry;
it does not distinguish slow reasoning or service waiting from a hung request.
Twenty minutes is a pragmatic starting limit, not an empirically verified cure.

No new `agy` run was launched: the user explicitly deferred that trial to the
next session. External review of this documentation follow-up is therefore
deferred, not passed. Local validation passed: all 48 local Markdown links/anchors
in the changed files, `git diff --check`, archive preservation, and preservation
of Lean source, audits, dependency pins, CI, and the agent trust/scope policies.
No Lean build was rerun for these documentation-only edits. No B1 work
or next proof milestone was started.


## 2026-11-25 — B1 source and proof review

### Authorized endpoint and baseline

Executed only **Current prompt: B1 source and proof review**, ignoring the
archived prompts. Initial checkout: `feature/attempt-02`,
`a3feb6bf02cea0aafdba29331e551d9e8173477d`. Announced a documentation-only
endpoint: source/license assessment, mathematical argument, pinned-Mathlib map,
smallest implementation slice, validation, Gemini Carbon High review, local
commits, retrospective and handoff, then pause. No BBP declaration, external
code adaptation, B2/B3 implementation, or V attempt was authorized or made.
Unrelated Obsidian and notes changes are preserved and excluded from staging.

Read the repository instructions, both plans, workflow, blueprint/log, B4/P3
handoff, literature report, formulation/trust records, relevant current Lean
source/root/audits, and dependency files. From the correct root with Elan on
`PATH`, Lean reported `4.37.0-rc1`; `lake build` passed (6655 jobs, no warnings),
`lake env lean Test.lean` passed silently (nineteen theorem audits and both
definition checks), and `git diff --check` passed.

### Source assessment, mathematical review, and API feedback

[The complete B1 review](b1-source-proof-review.md) records exact source URLs,
the external commit `e5376424f932afdbf529c696f985e516836e6601`, the original PDF
hash, inspected proof bodies/imports/configuration, and the scope of inspection.
The original Theorem 1 page was rendered and visually checked. The external
identity uses the same real coefficients and `Real.pi`; its source constructs
`HasSum` before exporting a `tsum` equality. No external project was rebuilt or
axiom-audited. Its referenced H04 planning document returned 404. The PDF shell
download initially hit sandbox DNS restrictions; the scoped approved retry
succeeded. Existing macOS PDFKit supplied rendering; nothing was installed.

The external code is Apache 2.0, with applicable third-party notice requirements;
the external paper text is CC BY 4.0. These notices cannot be replaced with the
project's Ursula-only MIT header. Recommend independent local proof scripts,
with scholarly source references, rather than code adaptation. This is a
project-policy constraint, not a claim that Apache 2.0 and MIT are inherently
incompatible. No external library or copied source entered the checkout.

Reviewed the scaled-kernel argument on `[0,1]`, its termwise integral, geometric
ratio bound, summable domination, almost-everywhere measurability, positive
denominators, rational identity, log/arctangent derivative, FTC, and endpoints.
Retain `HasSum` directly from dominated convergence; no preliminary tail layer
is necessary. The report explicitly retains every local proof obligation.
This is established mathematics awaiting local formalization, with no visit or
distribution hypothesis discharged.

Pinned-source searches and an imports/`#check`-only `/tmp` probe confirmed the
needed API on Mathlib `31ce06eaadf4a200c0e1407c5f10953cf606b8f8`.
Initial probes failed for the guessed `intervalIntegral.integral_pow` and
`HasSum.congr`/`hasSum_congr` names. Corrected to root `integral_pow` and ordinary
rewriting; the final probe passed. These are lookup/compiler diagnostics, not
missing mathematics. No BBP definitions or proofs were made even in scratch.

Both plans and the blueprint now propose the same **B1a coefficient and
one-term integral** slice. Its exact definition, sole public theorem,
prerequisites, checks, and stop condition are in the report. B1 is not marked
checked; B1-before-B3 and Viewpoint's commit cadence are unchanged. No optional
tooling or process expansion is justified by this cycle.

### Review and final validation record

Gemini Carbon High completed a supplied-evidence review of the exact seven-file
diff against `a3feb6b`, with explicit **no findings**. Conversation:
`a8f04fb2-eee8-4285-873b-cfcda7b64149`. The
[detailed record](agy-reports/b1-source-proof-review.md) preserves both terminal
payloads, progress observations, response, and independent assessment. The
initial attempt had an internal read-file denial, empty response, and nominal
`SUCCESS`; it was treated as incomplete. Stream/stderr and the CLI log confirmed
cancellation/shutdown. One recovery retained the conversation and supplied the
full diff, AGENTS, and source excerpts inline, requesting no tools. It finished
with exit 0, `SUCCESS`, a substantive response, and no error/denial fields.
The recovery took 5 min 47 s by caller observations. Both invocations used the
required twenty-minute deadline, direct approved prefix, and bounded waits;
neither timed out, and no overlapping invocation or permission bypass occurred.

No substantive fixes were requested. The caller independently rechecked the
argument and API mapping. Gemini did not perform fresh source retrieval,
compile proposed BBP statements, or reproduce builds/audits; omitted external
files and unchanged context were outside its independent inspection. The
complete changed-file diff was still supplied. Baseline checks and the successful
signature probe remain local validation; they do not prove B1.

Pre-review checks passed for 112 local Markdown links/anchors, byte preservation
of 18 protected Lean/config/CI/instruction files, all nineteen axiom guards,
archive preservation, and whitespace. Final staging and post-commit necessity
review are recorded with the handoff. No Lean-related input changed, so a
second Lean build/audit is unnecessary for these documentation edits.

During the external review, an unrelated `.codex/config.toml` appeared already
staged. A global `git diff --cached --check` flags a trailing blank line there;
it was left untouched. Task-scoped staged whitespace checks are used alongside
`git diff --check`, and commits select explicit task paths to preserve that
unrelated staged work. This is a user-file validation limitation, not a B1 or
Lean failure.

### Post-commit necessity review and handoff

Committed the reviewed milestone and finalized review record locally as
`2b7a74529c47df66c7beb4f0218cbb1f0e3cb0a2`, selecting the eight task-owned
documentation paths explicitly. The unrelated staged config was excluded and
its index blob preserved. An untracked `papers/` directory also appeared during
the session and is left untouched.

After that commit, reread the committed mathematical outline and proposed proof
pieces. The coefficient fixes the intended terms; the one-term integral links
them to the kernel; the geometric bound and measurability justify interchange;
the rational identity, derivative, FTC, and endpoints identify `Real.pi`.
Each is needed. The direct `HasSum` route already avoids a preliminary tail
layer and separate summability theorem. B1a needs no public monomial helper,
separate summand definition, or new general analytic API. No further substantive
simplification or fix was justified, hence no focused-fix Gemini follow-up or
empty implementation commit is needed. The handoff/log update is actual
follow-up documentation, with no changed mathematical proposal.

Pre-milestone-commit validation passed for 115 local links/anchors and all
preservation checks; a trailing blank line in the new saved reviewer report was
caught by the staged check, removed, and the task-scoped check rerun successfully.
The global cached check's unrelated config finding remains explicitly excluded.
The [final handoff](b1-review-handoff.md) records results, remaining obligations,
validation, review limits, process lessons, commits, and the B1a proposal. Final
handoff links, preservation, and scoped whitespace are checked again before its
commit, then the handoff is printed. No push, new Lean declaration, B2/B3 work,
or visitation attempt follows. Pause for the user's decision.


## 2026-11-25 — B1a coefficient and single-term integral

### Authorized endpoint, baseline, and proof

The user explicitly authorized only B1a, following the completed B1 source/proof
review at `2b7a745` and `ab43f71`. Verified actual HEAD:
`ab43f71285be84d92952765c4b67990866fed6f0`, branch `feature/attempt-02`.
Read `AGENTS.md` and `b1-review-handoff.md` first, then the current plans,
blueprint, log, workflow, session instructions, and relevant sources. Ignored
archived prompts as instructions; their bytes are preserved. Did not repeat
the completed source review or retrieve/copy/translate external proof scripts.

Announced endpoint before editing: independent `bbpCoeff`, unconditional
`integral_bbpTerm (j : ℕ)`, root export, guarded audit, coefficient/sign/index
checks, validation, required review, local commits, necessity review, and handoff.
Excluded infinite interchange, π integral evaluation, B2/B3, and V.

The fresh-session saved-rule check returned `decision: allow` for the exact
Gemini Carbon High plan-mode prefix. The active profile restricts filesystem
writes to workspace/temporary roots and provides no escalation; permission
settings were left unchanged. Baseline `lean --version` was `4.37.0-rc1`;
`lake build` passed (6655 jobs), `lake env lean Test.lean` passed with nineteen
audits and two definition checks, and `git diff --check` passed.
A temporary hash snapshot records sixteen unrelated files and the staged
config blob `f26b0af1c41298dc2e43bd7637febe853ecfa800` for preservation checks.

Pinned Mathlib search confirmed `integral_pow`, interval-integral subtraction,
constant multiplication/division, and continuity-based interval integrability.
The independent proof expands powers to four monomials, pulls out `16^j`, uses
linearity and the power integral, and normalizes casts/algebra. A local `hp`
fact avoids repeating monomial integrability; no public helper was introduced.
The module compiled on its first attempt. The first root-import audit then
failed because the definition body was not exposed. Existing definitions use
`@[expose]`; adding it to `bbpCoeff` fixed the export. This was a visibility
compiler failure, not a failed mathematical claim or missing mathematics.

The rebuilt library passed with 7201 jobs and no warnings. The root audit
passes with twenty exact theorem type/axiom checks, both previous π definition
checks, the coefficient expansion, and the exact `j = 0` value `47/15`.
A separate actual `#print axioms` probe reported exactly `propext`,
`Classical.choice`, `Quot.sound` for the theorem and coefficient; the theorem
list is now guarded. `git diff --check` passes. No pin, dependency, old theorem,
problem definition, linter, CI, or instruction change was needed.

### Status, review, and stopping point

Only B1a/T1 is checked. Full B1 still needs pointwise summation,
domination/measurability, interchange, rational algebra, derivative,
integrability, endpoint evaluation, and final `HasSum ... Real.pi` assembly.
B2/B3 and V are untouched; V, Hπ, T, and the π conjecture remain unproved.
B4 retains vanishing error and arbitrarily late visits; P3 retains open-interval
visits. The updated plans and blueprint propose B1b (pointwise geometric sum
and majorant) only for separate authorization; nothing in that slice is begun.
Keep the integral route, direct `HasSum`, B1-before-B3 order, and existing
workflow. The ordinary compiler loop sufficed; optional tooling is unwarranted.

### Gemini review and final validation

Gemini Carbon High completed the exact thirteen-file supplied-diff review with
**no actionable correctness findings**. Conversation:
`97aef234-10e0-4246-a752-904553cb1ce9`. The
[review record](agy-reports/b1a-review.md) preserves the diff hash, terminal fields,
full response, progress observations, persistence limitations, and independent
triage. One invocation used the required literal prefix, plan mode, stream JSON,
and twenty-minute deadline. It finished in about 6 min 46 s, exit 0, `SUCCESS`,
nonempty response, no terminal error/finished-reason/denied-action fields.
No recovery attempt or substantive-fix follow-up was required.

The CLI could not persist its own log/conversation/artifact/cache files under
the active sandbox. It nevertheless authenticated, received the complete
supplied review, and returned its full response. The caller saved combined
stdout/stderr chunks separately. A shutdown diagnostic interleaved into the
terminal JSON was removed solely for parsing; the parsed response exactly
matches concatenated agent-response text deltas. CLI-storage continuation is
unverified; no permissions were changed or bypassed. This limits runtime
persistence, not the supplied-diff review coverage. The reviewer ran no tools,
builds, or independent source retrieval.

The reviewer requested two nonblocking finalization checks. A concurrent user
commit had advanced HEAD from the initial `ab43f71` observation to
`855bb40f340ce7f70946975d2e017016291aa293` before the snapshot/review packet.
It contains only the existing `.codex` permissions configuration. The prompt
intro cited `ab43f71`, while the packet cited `855bb40`; exact task-owned diff
equality against both was verified. The user commit and configuration bytes
are preserved. A historical link in `proof-attempt-session-prompt.md` uses the
former current-prompt anchor; retaining that anchor in `session-prompts.md`
keeps it working without changing archived prompt bytes or milestone scope.

Preservation passed for sixteen unrelated files, the original config index blob,
sixteen protected source/configuration files, and all nineteen earlier axiom
guards. Pre-review local Markdown links/anchors passed (156); task-scoped staged
whitespace also passed. The reviewed Lean source has not changed after the
successful build/audit, so those checks remain valid. Final link/preservation
and staged-diff checks include the review report and outcome records.
The [durable B1a handoff](b1a-handoff.md) records the milestone. The local commit
and post-commit necessity review follow; no push or next milestone follows.


### Post-commit necessity review and final handoff

Committed the reviewed B1a milestone locally as
`b60656d6498d30a887a2d2101b0662844701e0ef`, selecting the fourteen task-owned
paths explicitly with `git commit --only`. Its parent is the preserved user
permissions commit `855bb40`. The remaining working-tree changes are unrelated
Obsidian/notes and papers. No push or history rewrite occurred.

Then reread the committed `BBP/Series.lean`, root export, and new audits.
The coefficient fixes the intended term; the local `hp` fact is reused by the
subtraction premises; `hexpand` rewrites the scaled integrand into monomials;
linearity and `integral_pow` evaluate them; cast/algebra normalization identifies
the exact coefficient. The exposed definition and root export enable the required
importer checks, and the guarded audit preserves the trust boundary. Each piece
is needed for the statement, proof, or acceptance checks. No additional public
API or removable proof layer was found. No substantive simplification or fix
arose, so no focused Gemini follow-up or empty code commit was warranted.

Pre-milestone-commit validation passed for 163 local Markdown links/anchors,
task-scoped staged whitespace, `git diff --check`, preservation of sixteen
unrelated files and sixteen protected files, the config blob, archived prompts,
and all nineteen earlier axiom guards. Final handoff/log edits are factual
records only; the reviewed Lean inputs are unchanged after their successful
build and twenty-theorem audit. Their final links, whitespace, preservation,
and two-file staged scope are checked again before the handoff commit.

The [final B1a handoff](b1a-handoff.md) records results, review/runtime limitations,
commits, the necessity check, remaining obligations, and B1b as a proposal only.
The final documentation commit contains this actual retrospective and handoff;
its own ID is printed after committing. No infinite-sum interchange, π evaluation,
B2/B3, or visitation work follows. Pause for the user's decision.

## 2026-11-25 — B1b pointwise series and domination

### Authorized endpoint and actual checkout

Executed only the first Current prompt in `session-prompts.md`, after reading
`AGENTS.md` and the B1a handoff, current plans, blueprint/log, workflow, source,
audits, and trust/formulation records. Ignored archived instructions and did
not repeat the completed B1 source review or B1a. Announced the bounded endpoint
before editing: exactly the pointwise `HasSum` and uniform geometric norm bound,
root-import checks, guarded audits, validation/review, local commits, necessity
review, and handoff; stop before interchange, π evaluation, B2/B3, or V.

Actual starting HEAD was `32e0974ea7389e38f28758a60cbeaad3b1794f2d` on the prepared
`feature/attempt03`. Live `git ls-remote` found remote main at
`9148792313151ac712f4caabe039b7b162690691`, matching local main/origin/main and
an ancestor of HEAD, recording merged PR #2. Preserved the saved prompt and
all unrelated Obsidian/notes/papers work. The saved `agy` prefix rule check
returned `decision: allow`; active workspace/temporary write restrictions and
no escalation were retained. No permission settings changed.

### Independent proof and compiler feedback

Pinned Mathlib source search confirmed `hasSum_geometric_of_lt_one`,
`HasSum.mul_right`, `pow_le_one₀`, and `pow_le_pow_left₀`. The two new public
theorems in `BBP/Series.lean` are `hasSum_bbpTerm` and `norm_bbpTerm_le`.
Both assume exactly `x ∈ Set.Icc (0 : ℝ) 1`; the norm bound quantifies every
`j : ℕ`. The proofs explicitly bound the ratio by `1/16`; the sum proof obtains
positive `1-q`. Geometric summation and multiplication identify `P/(1-q)`.
Power monotonicity and the polynomial absolute bound give `8*(1/16)^j`.
All helper facts stay local; there is no new definition or public helper.

The first sum proof's broad `simp` using commutativity produced mismatched
multiplication orders inside the polynomial. `convert` followed by `ring`
closed the exact intended target. Linter feedback removed redundant tactic
sequencing and ensured endpoint tests used the exported theorems. These were
compiler/linter issues, not missing mathematics. No external proof scripts,
extra libraries, placeholders, or proof bypasses were used.

From the correct root, Lean reported `4.37.0-rc1`; baseline and integrated
`lake build` passed with 7201 jobs, and final source validation had no warnings.
The root-import `Test.lean` passes with twenty-two exact type/axiom guards,
preserving all twenty earlier audits and definition/value checks. Both actual
new axiom lists were inspected before guarding them: exactly `propext`,
`Classical.choice`, `Quot.sound`. Checked both `x = 0` and `x = 1` for the sum
and bound, and `j = 0` for all admissible `x`. `git diff --check` passes.

Separate mathematical review confirmed the quantifiers, signs, real division,
closed endpoints, denominator positivity, and majorant independent of `x`.
The only added import is pinned Mathlib's `Analysis.SpecificLimits.Basic`;
B1a definitions/proof, the earlier statements, pins, manifest, CI, and policies
are preserved. No clean-environment build or remote CI result is asserted.

### Status and review preparation

Only B1a/T1, B1b/T2, and T3's pointwise bound are checked. T3's remaining
measurability, summability/integrability instances and interchange, T4,
antiderivative/FTC conditions, integral endpoint evaluation, and final B1
assembly remain open. B2/B3/V/Hπ/T and π disjunctivity remain unproved;
B4 retains vanishing errors and arbitrarily late visits, and P3 retains
open-interval visits. Both plans and the blueprint propose B1c only for new
authorization. No further milestone has begun. Keep the direct `HasSum`
integral route and B1-before-B3 order; the local workflow needed no new tooling.

The [B1b handoff](b1b-handoff.md) records the exact results and scope. Required
Gemini review, final preservation checks, local commits, and the post-commit
necessity assessment are recorded below when completed.


### Gemini review and final validation

Gemini Carbon High completed the thirteen-file exact supplied-diff review with
**no actionable correctness, policy, or documentation-consistency findings**.
Conversation: `374e74bf-0499-402c-bc1d-c413278a6a00`. The
[saved report](agy-reports/b1b-review.md) includes scope/diff hash, complete
response, terminal fields, observed progress, and limitations. One invocation
completed in 212.730 seconds: exit 0, `SUCCESS`, substantive nonempty response,
no terminal error/finished-reason/denied-action fields. It used five read-only
file calls and no observed shell/write tools. No recovery or substantive-fix
follow-up was needed. The finalization reminder is to record actual commits
and the post-commit necessity review, not a correctness finding.

Sandbox restrictions prevented CLI-owned log/conversation/cache persistence,
while authentication and the full review succeeded. The last tool return
truncated some intermediate text events at its output budget; the complete
terminal JSON/response and process exit were retained. The report explicitly
records that capture limitation. Available chunks/result/timestamps are saved
separately under `/tmp`; future polls should use a larger output budget as
response deltas begin. No permission setting or effort/model changed.

Before review, preservation passed for 24 unrelated/protected hashes, B1a's
unchanged declarations, all twenty earlier guard blocks and all original
checks, and archived prompt bytes. All 171 local Markdown links/anchors passed.
The post-review report and outcome records receive final preservation/link and
whitespace checks before staging/commit. No substantive code changed after
the passing build and twenty-two-theorem audit; no additional Lean rerun is
needed solely for factual review/commit records.


### Post-commit necessity review and final handoff

Committed the reviewed milestone locally as
`0f5d5da16c51e805294f32aec8f633ee462d1582` on `feature/attempt03`, with parent
`32e0974`. `git commit --only` selected fourteen task-owned files; the remaining
working-tree changes are the preserved Obsidian, notes, and papers. No push or
PR was made. Pre-commit checks passed for 206 local Markdown links/anchors,
24 unrelated/protected hashes, B1a declarations, all twenty earlier audits
and original checks, archived prompts, and staged/global whitespace.

Then reread the committed module, root export, and audit additions. The local
ratio facts supply the geometric premises, denominator positivity, norm signs,
and exponent bound. The polynomial bound and multiplication inequality supply
the requested uniform majorant, with exact algebra normalizing the final
expressions. The existing public root import, full type and axiom checks, and
boundary examples provide the required importer/trust/semantic coverage.
Each piece serves the authorized statement, proof, or acceptance checks; no
extra API or removable proof layer was found. No substantive simplification
or fix was warranted, so no focused Gemini follow-up or empty code commit
was made.

The final two-file documentation commit records this actual retrospective and
[handoff](b1b-handoff.md), with fresh whitespace/link/preservation checks.
The reviewed source and audits are unchanged after their successful validation.
Its commit ID is reported after committing. Stop at B1b: no interchange,
integral evaluation, full BBP identity, B2/B3, or universal visitation proof
has been begun. Pause for the user's next decision.


## 2026-11-25 — B1c sum/integral interchange

### Authorized endpoint and checkout

Executed only the first Current prompt, after `AGENTS.md`, the B1b handoff,
current plans, blueprint, workflow, source, audits, and trust/status records.
Announced the endpoint before editing: one unconditional coefficient-series
`HasSum` to the unevaluated rational integral, its export/audit, validation,
required review, local commit/necessity review, and durable handoff. Archived
prompts were not executed; completed B1 source review/B1a/B1b were not repeated.

Actual HEAD was `57a0b0a6f6fbd078bc90073e627de37b26eef63d` on prepared branch
`feature/attempt-04`; remote main was `4eb973b0c3521a962a90f3d0aacafc2a4d5d7d50`,
matching local main/origin/main and HEAD's parent (merged PR #3). Preserved
unrelated Obsidian, notes, and papers work. The exact saved `agy` prefix check
returned `decision: allow`; workspace/temporary write limits and no escalation
remain in effect, without permission changes.

### Checked argument, compiler feedback, and validation

Pinned source inspection found the requested interval dominated-convergence
`HasSum` API at `Mathlib/MeasureTheory/Integral/DominatedConvergence.lean:218`.
The measurable-term premise uses restricted volume; the bound, summability,
and limit premises use almost-everywhere implications under unrestricted
volume. The local inclusion `uIoc 0 1 ⊆ Icc 0 1` and `ae_of_all` match these
precisely. Polynomial continuity, B1b domination/pointwise sum, geometric
summability, and constant interval integrability discharge all five premises.
B1a then rewrites each term integral, preserving `HasSum` directly.

`hasSum_bbpCoeff_integral` has exactly the requested unconditional statement;
its existing public root import suffices. The proof compiled on its first
module check, with no compiler/library/mathematical failure. No external code,
extra library, proof bypass, public helper, or tail layer was used. Meaning
review confirmed volume, forward interval orientation, both endpoints,
zero-based natural indices, real division, and no hidden analytic hypotheses.

Lean is `4.37.0-rc1`; baseline and integrated `lake build` pass (7201 jobs).
The root-import audit passes with twenty-three full type/axiom guards and all
previous definition/value/boundary checks. The new actual axiom list was
inspected before guarding it: `propext`, `Classical.choice`, `Quot.sound`.
`git diff --check` passes; pins, manifest, reviewed definitions, and existing
root imports are unchanged. The only added import is Mathlib dominated
convergence. No clean-environment or remote CI result is claimed.

### Status, retrospective, and review preparation

B1a/T1, B1b/T2, and B1c/T3 are checked. T4, antiderivative/FTC conditions,
integral evaluation, and final B1 assembly remain unproved. B2/B3, V, Hπ, T,
and π disjunctivity stay open; B4 retains vanishing error and arbitrarily late
visits, and P3 retains open-interval visits. No later milestone was begun.
Both plans and the blueprint now propose B1d rational kernel decomposition
only for separate authorization; session instructions pause after B1c.

The pinned API and local compiler loop sufficed without new infrastructure.
Retain the direct `HasSum` integral route, B1-before-B3 order, and existing
review/commit cadence. The [B1c handoff](b1c-handoff.md) records the full result,
validation, and stopping point. Required Gemini review and commit/necessity
outcomes follow when actually completed.


### Gemini review and final validation

Gemini Carbon High returned **explicit no findings** on the complete twelve-file
supplied diff against `57a0b0a`. Conversation:
`4a662fa5-c864-445d-bd2c-9e10168f1c93`. The [saved report](agy-reports/b1c-review.md)
records the full response, diff hash, timestamps, both attempts, and limitations.

The initial invocation (13.070 seconds) ended with exit zero / `SUCCESS`,
empty response, and denied temporary-input `read_file`: incomplete. Captured
events/stderr and the CLI log identified the internal headless file permission
failure and terminal stream exit. The process-list check was sandbox-denied,
but execution completion and recovery's `active=false` established no overlap.
The single focused recovery supplied the full diff inline, prohibited retrying
the denied read, and retained the explicit conversation and all twelve files.
It completed in 209.461 seconds, exit zero, `SUCCESS`, nonempty no-findings
response, and absent terminal error/finished-reason/denied-action fields.
No scope was omitted, permissions changed, or substantive follow-up needed.

All observed reviewer tool calls were read-only file reads. Gemini did not
rerun Lean or inspect the Mathlib checkout/manifest; those depend on the caller's
validation. Recovery CLI persistence was sandbox-denied, but review completed.
Each execution chunk was captured with 50,000 tokens and saved separately before
summarization; none was truncated. A combined-event diagnostic display was
abbreviated, and the terminal response was then separately read in full.

Preservation passed for 25 unrelated/protected hashes, existing B1a/B1b code,
all twenty-two prior guards and other checks, old prompt bytes, and earlier log
entries. Manifest/dependency pins, project imports, and trust tokens passed;
pre-review local links/anchors passed (184). Final factual review records and
staging receive fresh preservation/link/whitespace checks before committing.
The passing Lean proof/audits are unchanged. No later milestone was begun.


### Post-commit necessity review and final handoff

Committed the reviewed B1c milestone as
`f4184d8d5ccb112f9449e6e9148d8cbcc50b35e9` on `feature/attempt-04`, parent
`57a0b0a`, using `git commit --only` for thirteen task-owned files. Staged
whitespace, 235 local Markdown links/anchors, and preservation checks passed.
Only the unrelated Obsidian, notes, and papers work remained. No push, PR,
history rewrite, or permission change occurred.

Then reread the committed `Series.lean`, root import, and audit additions.
The shared interval inclusion supplies B1b's domain in two premises. The
explicit term-integral `HasSum` selects the required API and kernel; continuity,
domination, geometric summability, constant integrability, and pointwise sum
each discharge a necessary premise. The final B1a rewrite gives the exact
coefficient sequence. The root import and full type/axiom guards meet export
and trust requirements. No proof layer or helper was removable with a justified
simplification; no substantive fix, focused review, or empty code commit was
needed.

The final two-file documentation commit records this retrospective and the
[completed B1c handoff](b1c-handoff.md), after fresh whitespace/link/preservation
checks. The reviewed proof and audits are unchanged after successful Lean
validation. Its ID is reported after committing. B1d is proposed only; stop
before rational kernel algebra, antiderivative/FTC, integral evaluation,
full B1, B2/B3, or V. All open obligations and conditional premises are retained.


## 2026-11-25 — Complete B1 after the checked B1c bridge

### Authorization, endpoint, and actual checkout

The user asked to keep going and complete B1 after discussing B1d and the
primitive/FTC stages. Interpreted the explicit full-B1 objective as authorization
for rational decomposition, derivative, integral evaluation, and assembly,
reusing completed B1c unchanged. Announced that bounded endpoint before editing,
including exports/audits, validation/review, local commit/necessity review, and
handoff. Stop before B2/B3 or universal visitation; no archived prompt was invoked.

Starting HEAD was `0584737a5cba74ad4acc1754457c260e2ea468b8` on `feature/attempt-04`.
Live remote main remained `4eb973b0c3521a962a90f3d0aacafc2a4d5d7d50`, matching
local main/origin/main and an ancestor of HEAD. Preserved unrelated Obsidian,
notes, and papers work and saved 25 protected/unrelated file hashes. No branch
recreation, permission change, dependency change, or history rewrite occurred.
Read repository instructions, current source/audits, plans/blueprint, prior
handoff, and assessed argument. The existing workflow/trust policy governs;
the earlier source review and B1a/B1b/B1c proofs were not repeated.

### Independent proof and compiler feedback

Read actual pinned `HasDerivAt.log`, `HasDerivAt.arctan`, polynomial derivative,
`ContinuousOn.intervalIntegrable_of_Icc`, and
`intervalIntegral.integral_eq_sub_of_hasDerivAt` signatures. Existing public
Mathlib imports already expose these APIs; no new import was necessary.

`bbpKernel_eq_partialFractions` proves T4 on `Icc 0 1`, using local denominator
bounds and field/ring algebra. `hasDerivAt_bbpPrimitive` proves the ordinary
derivative, including endpoints, of the assessed logarithm/arctangent primitive.
`integral_bbpKernel` supplies kernel continuity/integrability, invokes FTC on
`uIcc 0 1 = Icc 0 1`, and evaluates `F(1)-F(0) = π`. `hasSum_bbpCoeff`
rewrites the unchanged B1c bridge and proves the full unconditional BBP series.
No primitive/kernel definition, unused helper API, preliminary tails, extra
library, external proof translation, or proof bypass was introduced.

Scratch failures were compiler/tactic issues: default field normalization did
not discharge rearranged denominators; `convert` exposed a function equality;
an untyped continuity-division application made `fun_prop` unfold reals and
hit the default heartbeat limit; endpoint normalization left a ring identity.
Local positivity plus `linarith`, `rfl`, explicitly typed continuity facts,
and `norm_num`/`ring` resolved them. Linters removed redundant sequencing.
No statement, limit, or linter setting was weakened.

### Validation, mathematical meaning, and status

Lean reports `4.37.0-rc1`; baseline build/audit passed with 7201 jobs and 23
existing guards. Production module and integrated `lake build` pass without
warnings. The actual four new axiom lists were inspected before guarding:
exactly `propext`, `Classical.choice`, `Quot.sound`. `Test.lean` passes 27 full
root-import type/axiom audits and all earlier definition/value/boundary checks.
`git diff --check` passes; pins, manifest, reviewed definitions, root imports,
source conventions, and CI are unchanged. No clean-environment/remote CI claim.

Separate meaning review confirms real division, natural zero-based series,
nonzero kernel denominators and positive log arguments on both endpoints,
ordinary derivatives, volume measure, forward `0..1` orientation, correct FTC
integrability premises, and exact Mathlib π through `arctan_one`. The final
`HasSum (fun j : ℕ => bbpCoeff j / (16 : ℝ)^j) Real.pi` has no hypotheses.
All eight BBP theorems and 27 total audited results are now checked.

Both plans and the blueprint mark Step 3/M2 checked. B2/B3, V, Hπ, T, and π
disjunctivity remain open; B4 retains vanishing error and arbitrarily late
visits, and P3 retains open-interval visits. The next proposal is B2a's
finite-prefix/convergent-tail split, only with separate authorization.
The [B1 handoff](b1-handoff.md) records precise claims and remaining work.
Local source search and typed compiler feedback sufficed; retain the planned
order and Gemini/Viewpoint cadence without optional tooling or a process rewrite.

### Review preparation

The required Gemini review will receive the exact task-owned diff against
`0584737` inline, avoiding B1c's demonstrated temporary-file permission obstacle.
Keep the literal approved Carbon High/plan prefix, read-only repository file
tools, no shell/Bash/modifications, twenty-minute deadline, bounded polling,
and separately saved execution capture. Final review/commit/necessity outcomes
are recorded below only when completed.


### Gemini review and final validation

Gemini Carbon High returned **explicit no findings** on the exact twelve-file
B1-completion diff against `0584737`. Conversation:
`a5edb71a-c1be-402f-b627-8c8e1939edd2`. The [saved review](agy-reports/b1-review.md)
records the full response, scope/diff hash, progress, terminal fields, capture,
and limitations. One invocation took 259.935 seconds, exit 0, `SUCCESS`,
nonempty response, and absent terminal error/finished-reason/denied-action fields.
No retry or substantive fix/follow-up was needed.

The saved exact prefix rule was rechecked: `decision: allow`. Inline review
input avoided B1c's temporary-file read permission obstacle without changing
permissions. The reviewer completed 26 read-only repository-file reads; no
shell/mutating tool was used. Its review included manifest and CI inspection,
but actual Lean/axiom/Git/hash checks and the pinned Mathlib source signatures
remain caller validation. CLI persistence was sandbox-denied while existing
login and review succeeded. No clean-environment or remote CI claim is made.

All five execution chunks were saved separately, using 50,000 tokens at startup
and 60,000 per poll; none was truncated. A step-summary display was abbreviated
after saving the complete capture, and the terminal result was separately read
in full. The review report normalizes file links and corrects one erroneous
response-only path; no source change was required.

Pre-review preservation passed for 25 unrelated/protected hashes, all B1a/B1b/B1c
declarations, all 23 earlier audits and other checks, archived prompt bytes,
and earlier log entries. Manifest/package revisions and imports/trust checks
passed. Local Markdown links/anchors passed (192); final records and staging
receive fresh link/preservation/whitespace checks. The passing Lean source and
audits remain unchanged. No B2/B3 or visitation proof work was begun.


### Post-commit necessity review and final handoff

Committed the full B1 milestone locally as
`5cbbd14fbf7e42392b314a553090d34ef22a93a8` on `feature/attempt-04`, parent
`0584737`. `git commit --only` selected the thirteen task-owned paths. Staged
whitespace, 240 local Markdown links/anchors, and preservation checks passed;
only the original Obsidian, notes, and papers work remained. No push, PR,
history rewrite, or permission change occurred.

Then reread the committed additions, root export, and audits. Local positivity
and power bounds discharge field denominators. Polynomial derivatives and log
nonzero facts justify the chain rules; the denominator identity and partial
fractions match the kernel. Kernel continuity supplies interval integrability;
the FTC application uses the derivative at every point of the closed interval,
and exact endpoint arithmetic yields Mathlib's π. The final rewrite preserves
B1c's coefficients and `HasSum`. Each new theorem has a direct consumer or is
the requested endpoint; the root import/type/axiom guards provide the required
export and trust evidence. No unnecessary layer or substantive simplification
was justified, so no follow-up fix review or empty code commit was made.

The final two-file documentation commit records this retrospective and the
[completed B1 handoff](b1-handoff.md), with fresh link/whitespace/preservation
checks. The reviewed source/audits remain unchanged after passing validation.
Its ID is reported after committing. Step 3/M2 is complete; stop before B2a,
B2/B3, or V. No visitation or disjunctivity hypothesis has been discharged.

## 2026-11-25 — Prepare the complete B2 session

The user reported PR #4 merged and requested preparation of a new branch and
a step-by-step prompt for all of B2, without beginning proof work. GitHub
confirmed the merge at `53ae688f3c56becdb3ca562d75e6eb3c95fe9dd7`.
Switched to `main`, ran `git pull --ff-only origin main`, and created/switched
to `feature/attempt-05-b2` from that commit. Unrelated local work was retained.

The first current section of [session-prompts.md](session-prompts.md#current-prompt-b2-complete-orbit-bridge)
now specifies the convergent B2a split, independently defined recurrence and
range, finite-sum identity, exact π-orbit bridge, audits, review, local commits,
necessity review, and handoff. It ends before B3, optional modular computation,
or visitation. The previous paused-after-B1 instructions were moved to the old
section with their anchor retained; the older archive was preserved. Entry-point
and next-task references in both plans and the blueprint agree with the new scope.

This is prompt preparation only. B2/B3, V, Hπ, T, and π disjunctivity remain
unproved; B4/P3 retain every hypothesis. No Lean source, test, dependency, or
pin changed, so no new Lean build/audit is claimed. Whitespace, all 11 unrelated
file hashes, exact previous-prompt/archive preservation, and 115 local links
in the review scope passed; final records receive the same checks.

Gemini Carbon High returned explicit no findings for the six-file preparation
diff against merged main. Conversation: `da7f8d40-3204-4276-b930-9ed1c7da2421`.
Exit zero, nonempty `SUCCESS` response, no terminal error or denied actions;
the single invocation took 309.920 seconds by caller timestamps. See the
[review record](agy-reports/b2-prompt-review.md) for capture, progress, findings,
and limitations. No proof change or substantive prompt fix was needed.
The preparation is finalized in a local documentation commit; no push or PR
is part of this request. The next session must invoke the first Current prompt
to begin B2, then stop at its specified endpoint.

## 2026-11-25 — Adopt B1 process improvements

Authorized as one process-only milestone from `563ffed` on the existing
`feature/attempt-05-b2`, preserving unrelated work and both existing local
commits. Consolidated durable rules and mandatory Gemini operations, established
record ownership and handoff conventions, added offline documentation/review
evidence tools and CI checks, and shortened the current B2 prompt by linking
procedures. Its exact mathematical contracts and archive remain unchanged; B2
was not executed. The original retrospective remains a dated proposal record.

The [meta-plan adoption](meta-proof-plan.md#b1-process-adoption--2026-11-25)
connects decisions to evidence and specifies future measurements without
inventing historical gains. The [process handoff](process-improvements-handoff.md)
records checks, required review, limitations, finalization, and restart details.
B2/B3, V, Hπ, T, and π disjunctivity remain unproved; B4/P3 retain their hypotheses.

Initial Carbon High review completed with explicit no findings. A caller-found
path-traversal edge in the historical-link exception was tightened and sent for
focused follow-up. The apparent Git blocker was resolved by using the existing
Git allow rule with a standalone command, without permission/configuration changes.
See the [review record](agy-reports/process-improvements-review.md) for outcomes.

Full and focused Carbon High reviews both returned explicit no findings; both
captures are complete. Final validation passes 23 utility/CI tests, 41 Markdown
files, whitespace, exact staged scope, and preservation checks. No Lean check
was rerun because no Lean source or dependency changed. Review limitations and
per-invocation elapsed times are in the linked report. Local finalization follows.

Committed the 24 owned paths locally as `3ef470c6aced848edd7675e28fc9b5f99d92f3c0`
on the original branch, preserving its prior commits and unrelated work.
Post-commit inspection found each tool/check and consolidated guidance layer
necessary; no further substantive simplification was justified. A final handoff/
log receipt records completion with fresh link, whitespace, scope, and preservation
checks. No push, PR, permission change, Lean change, or B2 execution occurred.

## 2026-11-25 — Documentation alignment and publication follow-up

After the process milestone, the user authorized deleting the unused untracked
`src/` scaffold and opening [PR #5](https://github.com/ursula-athene/pi-disjunctivity/pull/5).
The PR includes B2 prompt preparation, the retrospective, and its process
improvements; it does not implement B2. Build and process CI passed at `4e5bc2f`.

A follow-up audit found a historical nineteen-theorem count still labeled
current in the foundations overview. Corrected that framing, directed subsequent
research from AGENTS to the proof plan, and replaced duplicated mutable audit
inventories with links to `Test.lean` and the blueprint. The formulation retains
its dated B1 snapshot. No theorem contract, proof, pin, current/archived prompt,
or unproved hypothesis changed. See the
[handoff follow-up](process-improvements-handoff.md#documentation-alignment-and-publication-follow-up--2026-11-25)
and [review record](agy-reports/process-improvements-review.md) for acceptance
evidence and limitations. B2/B3, V, Hπ, T, and π disjunctivity remain unproved;
B4/P3 retain their hypotheses.

Documentation follow-up acceptance: 23 tests and the 41-file documentation
check passed, with whitespace and preservation checks. Carbon High returned
explicit no findings in one invocation (284.916 seconds by caller timestamps),
with complete capture; see the linked report for limitations. Final factual
receipts are caller checked before committing and updating PR #5.

## 2026-11-25 — B2 implementation: convergent split checkpoint

Verified PR #5 merged at `c3b3bd1dff4f975a93a1530e4daeaf9273a0176d` and
created `feature/attempt-07-b2-orbit` from updated `main`. Existing branches and
unrelated Obsidian, notes, and papers work are preserved. The invoked current
prompt authorizes all B2, with regular pushes and no PR; updated the proof plan
before implementation. B3 and visitation remain outside scope.

Baseline Lean `4.37.0-rc1`, `lake build` (7201 jobs), all 27 prior audits, and
whitespace passed. Added exposed prefix/tail/recursive definitions in
`BBP/Orbit.lean`; early root-import equation probes passed. Pinned Mathlib's
`hasSum_nat_add_iff'`, `HasSum.mul_left`, and `pow_sub₀` supply the convergent
split. Prefix normalization first proves `j ≤ n`; tail normalization preserves
the `n+r+1` coefficient and `r+1` denominator. The defined tail's `HasSum` and
scaled π equality follow without convergence hypotheses.

Integrated build (7203 jobs), 30 full type/axiom guards, definition and zero-index
checks, and 23 offline utility tests pass. All three new axiom lists are exactly
`propext`, `Classical.choice`, `Quot.sound`. Scratch repairs concerned an API
argument and exponent normalization; a boundary simplification needed explicit
`Nat.zero_add`. No mathematical gap or changed contract was involved. B2a is
checked; checkpoint review/commit and recurrence/range/orbit work follow within
the same authorization. B3, V, Hπ, T, and π disjunctivity remain unproved;
B4 retains vanishing error and late visits, P3 retains open-interval visits.

Carbon High completed the exact six-file B2a review: no proof/audit/trust
findings, one low-severity stale Step 4 status and audit-count finding in the
proof-plan overview. Corrected the status and replaced the duplicated count
with the executable inventory link. These are factual documentation repairs;
no mathematical statement or code changed. The complete B2 review will include
them. [Review evidence](agy-reports/b2-review.md) records full capture, terminal
fields, coverage, and limitations. Checkpoint commit/push follows validation.

## 2026-11-25 — B2 recurrence and exact orbit bridge

Committed and pushed the reviewed B2a checkpoint as
`d4135bea00cd5fdb47468f09301dc269abfd8b93` on `feature/attempt-07-b2-orbit`.
Post-commit inspection found the split theorem, tail `HasSum`, scaled identity,
exposed definitions, root export, and guards necessary for the specified B2
contracts and next proof layer; no substantive simplification was justified.
No empty follow-up commit was made.

Added private prefix zero/successor lemmas and the three public results
`bbpRecurrence_mem_Ico`, `bbpRecurrence_succ_eq_fract_bbpPartialSum`, and
`fract_pow_mul_pi_eq_bbpRecurrence_add_bbpTail`. The recurrence proof explicitly
uses the integer witness `-16 * ⌊bbpPartialSum n⌋`; the final bridge combines
that identity with the scaled split and `Int.fract_fract_add`. No convergence,
range, density, or visitation hypotheses enter the final theorem. B3 has not
begun. The original B1 proofs and all earlier audits remain unchanged.

Full root-import types and actual axiom lists passed; all three lists contain
only `propext`, `Classical.choice`, `Quot.sound`. Boundary probes explicitly
instantiate recurrence/orbit theorems at zero and the orbit theorem at one;
definition arithmetic also checks `y(1)=2/15` and the two-term prefix. Scratch
feedback corrected a natural-subtraction rewrite; a production line-length
warning was fixed without changing linters. No missing mathematics was found.

All B2 mathematical obligations are checked. Complete milestone review,
validation, commit/push, post-commit necessity review, and final handoff
acceptance are recorded in [the B2 handoff](b2-handoff.md) and
[review report](agy-reports/b2-review.md). B3, V, Hπ, T, and π disjunctivity
remain open; B4 retains vanishing error and late visits, P3 retains
open-interval visits. The current session entry now records the B2 stopping
point, and B3 is proposed only.

## 2026-11-25 — B2 accepted, pushed, and reviewed for necessity

Complete Carbon High review returned explicit no actionable findings, including
resolution of the B2a documentation issue; both captures are complete. See
[the review report](agy-reports/b2-review.md) for scope, timing, conversation
persistence limitation, and caller-versus-reviewer checks. Final validation
passes pinned build (7203 jobs), 33 guards, 23 offline tests, 44 Markdown files,
whitespace, exact owned staging, and preservation. No remote CI or clean rebuild
is claimed. No proof changes followed passing validation/review.

Committed and pushed the complete bridge as
`a7f31bc63e00082c14f8579a3c3e17ca6b523ddf`, following pushed B2a `d4135be`.
Post-commit review found all definitions, two private prefix lemmas, six public
contracts, exports, and audits necessary for the specified endpoint or proof
chain. No substantive simplification or empty code commit was warranted.
The [durable handoff](b2-handoff.md) contains exact contracts, both implementation
commit IDs, acceptance/necessity evidence, and a command identifying its own
final receipt commit. That factual receipt receives preservation/link/whitespace
checks and is pushed separately. No PR was opened; unrelated work is preserved.

B2 is complete; M3/Step 4 is not. B3 tail bounds/decay, V, Hπ, T, and π
disjunctivity remain open. B4 retains vanishing error and arbitrarily late
visits; P3 retains open-interval visits. Stop before the proposed B3 task or
visitation research. The current prompt records this boundary.


## 2026-11-25 — Replacement B2 process and tool plan

Saved the [tooling recommendations](lean-tooling-recommendations.md), then
reviewed the expanded B2 retrospective, meta-plan, and previous tooling prompt.
The [replacement plan](b2-process-tool-improvement-plan.md) specifies process
improvements, completed-B2 LSP replays, selective skill evaluations, acceptance
criteria, and explicit deferrals. The prior prompt is archived and all active
entry links select its replacement. The meta-plan records a proposal, not adoption.

This is plan-writing only. Future improvement implementation precedes B3;
B2 proof development is out of scope and completed B2 is test material only.
No tool installation, skill activation, configuration, Lean change, or new
mathematical result is claimed. See the
[planning handoff](b2-improvement-planning-handoff.md) and
[review report](agy-reports/b2-improvement-planning-review.md) for actual
validation, review, concurrent-commit handling, and local publication evidence.


## 2026-11-25 — Carbon adversarial review guidance

The user authorized adopting the review-guidance subset of the B2 improvement
plan. The Carbon procedure now routes Lean proof reviews to the proof guide,
tooling/meta-plan reviews to the strategy guide, and substantive mixed work to
both. The two guides retain their scrutiny while respecting Carbon's read-only
execution boundary. Reviews separately report defects, nonblocking improvements,
and open questions; every item receives a reasoned disposition and cycle-wide
reporting preserves earlier fixes and suggestions.

See the [review-guidance handoff](carbon-review-improvements-handoff.md) and
[review report](agy-reports/carbon-review-improvements-review.md) for actual
validation, items/dispositions, and local publication evidence. The remaining
improvement implementation and all open mathematical obligations are unchanged.
No installed-tool evaluation or gain in reviewer effectiveness is claimed.

## 2026-11-25 — B2 process and tool improvement evaluation

Invoked P0–P5 on the user-prepared improvement branch at `e83580e`.
Implemented signature/index discipline, manual semantic review, bounded reads,
and I6 diagnostic-log retention, reconciling the prior Carbon guidance subset.
The P1 checkpoint returned no defects and four implemented improvements;
full-cycle review/acceptance is in the [handoff](b2-improvements-handoff.md)
and [review report](agy-reports/b2-improvements-review.md).

The [evaluation](b2-tool-evaluation.md) records pinned temporary LSP protocol
success, blocked persistent installation/configuration, selected-skill
compatibility checks, original seeded skill evaluations, and explicit decisions.
Shell remains default; host adoption is deferred. No production Lean, audit,
pin, manifest, or mathematical contract changed. B3/V/Hπ/T remain open;
B4/P3 retain their premises. The user later authorized branch pushes, no PR.

## 2026-11-25 — B2 tooling installation follow-up

The user completed persistent installation. After correcting an overstrict
config comparison and repairing an empty generated launcher, app restart made
all five MCP tools available and tested in this conversation; the four installed
skills were visible and exercised. The requested [repeatable installer](b2-tool-installation.md)
uses the tested Python module entry point, validates packages/protocol before
configuration, and reuses matching components. A fresh isolated installation
passed with its console wrapper deliberately emptied. See the
[evaluation follow-up](b2-tool-evaluation.md#persistent-installation-and-native-host-follow-up)
and [review report](agy-reports/b2-improvements-review.md#repeatable-installation-follow-up).
Clean descendant shutdown and app disable/restore remain pending; known-case
skill checks do not measure broader usefulness. No Lean contract or proof changed.


## 2026-11-25 — B3 authorized baseline and argument criticism

Invoked the current B3 prompt on the prepared `feature/attempt-08-b3` branch
at `ae4a0e3`. Recorded the full implementation/acceptance sequence in the
proof plan before proof work. The index was empty; unrelated Obsidian settings,
notes and papers are preserved. Pinned Lean `4.37.0-rc1`, baseline `lake build`
(7203 jobs) and `lake env lean Test.lean` pass with exit 0.

Applied the adapted search/proof skills and `pi-argument-critic` to the proposed
estimate: all four coefficient denominators are positive, their reciprocals
are bounded by that at `8*j+1`, and `4+2+1+1=8`. Tail coefficients start at
`n+1`; geometric weights start at `1/16` and sum to `1/15`. The resulting
`8/(15*(8*n+9))` tends to zero. No missing mathematical premise was found in
this same-session criticism; denominator order, casts and convergent-sum
comparison still require Lean proofs. It supplies no visits and cannot remove
B4's arbitrarily-late-visitation premise or P3's open-interval-visitation premise.

All five native LSP tools are exposed and exercised against unchanged B2:
diagnostics pass, source extraction locates the generated additive split
lemma's multiplicative source, hover exposes `pow_sub₀` with its nonzero and
index-order premises, and goal inspection shows the tail reindexing equality.
Search first reported an unavailable index and later a warming index with the
generated declaration found; neither state is used as a negative theorem test.
The configured project root, disabled REPL and Python module command match
the user's successful migration receipt. No installation/configuration change.
The prompt-requested isolated proof workers use scratch files only; the caller
owns integration and final checks. The compact root `PROGRESS.md` points here
and to the mathematical plan, as required by the invoked prompt.


## 2026-11-25 — B3 proofs and intermediate review checked

`BBP/Tail.lean` exports `abs_bbpCoeff_le`, `abs_bbpTail_le`, and
`tendsto_bbpTail` with the exact unconditional B3 contracts. The coefficient
root probe passed before tail composition; B2's `hasSum_bbpTail` and a local
geometric `HasSum` give the norm bound. Denominator growth and squeeze give
decay. No private/public helper API, definition change or new hypothesis.
Pinned build (7205 jobs), root/audit checks, actual three-axiom guards and
integrated native diagnostics pass without warnings. Scratch/compiler repairs
were elaboration/normalization issues, not missing mathematics.

Intermediate Carbon High review completed with no defects/questions and two
nonblocking audit improvements, both implemented: the definition-free zero-index
π error bound and B4 compatibility at the actual `n+1` recurrence offset with
its complete late-visitation premise retained. See [the report](agy-reports/b3-review.md)
for exact diff, terminal/capture/log inspection, cost and periodic-update limits.
The full milestone review and commit/necessity/push steps remain pending.
The [handoff](b3-handoff.md) and [retrospective](retrospectives/retrospective-2026-11-25-b3.md)
record those boundaries. V, Hπ, T and π disjunctivity remain open; P3 still
requires open-interval visits. No visitation research or final assembly begun.


## 2026-11-25 — B3 complete precommit review

Full Carbon High review accepted all three unconditional contracts and the
14-file scope, rechecked intermediate I1/I2, and found no defects, new
improvements or blocking questions. Both captures/logs were inspected; see
[the report](agy-reports/b3-review.md) for exact hashes, conversations, timing,
progress-update gaps and retention limits. The active entry now records the B3
stopping boundary; its executed prompt and older archive are preserved.
Only factual acceptance receipts change after the reviewed Lean/audit snapshot.
Commit, post-commit necessity inspection and verified push follow; no new
mathematical work or research is authorized.


## 2026-11-25 — B3 accepted, pushed and reviewed for necessity

Implementation commit `06d15b74c96369870615de526bee8bf621956704` contains exactly the
14 owned files and is pushed to `origin/feature/attempt-08-b3`; `git ls-remote`
verified equality. Post-commit inspection of the actual source and audits found
all three contracts, local majorant/comparison facts, export and checks needed
for the endpoint or proof chain. No substantive simplification or empty code
commit was warranted. The [handoff](b3-handoff.md) records that inspection and
identifies its final factual receipt commit via Git; that receipt receives
documentation/whitespace/scope checks and a separate push. Reviewed Lean/audit
bytes remain identical. No PR was opened; unrelated work remains untouched.

Whole review cycle: two completed Carbon High runs, no failures/retries, no
defects, two nonblocking improvements implemented and rechecked, no blocking
questions. See [the report](agy-reports/b3-review.md) for timings/captures and
periodic-update limits. B3 supplies vanishing error only. V, Hπ, T and π
disjunctivity remain open; B4 retains late visits and P3 open-interval visits.
Stop at accepted B3; no further research or final assembly is authorized.

## 2026-11-25 — Adopt B3 process lessons and rewrite the meta-plan

The user authorized implementing the expanded B3 retrospective's improvements
and replacing the accumulated meta-plan with a concise strategy for evaluating
and revising the proving process. The [adoption handoff](b3-process-improvements-handoff.md)
owns the recommendation mapping, checks, Carbon review and publication evidence.
Execution rules live in the workflow/review procedure; the meta-plan now focuses
on uncertainties, bounded tests, decision signals and plan revision. Historical
records retain their evidence. No Lean contract, proof, audit or pin changes,
and no visitation research or new proof milestone is started.
During review, the user requested a stronger strategy for mathematical impasses.
The meta-plan now adds model problems, alternative representations, counterexample
search, precise source bridges and bounded tests, with fresh-context criticism
and explicit stopping/reopening conditions. The handoff records methodological
sources, review refinements and their limits.
The user also requested TRIZ and possible differentiated subagent/Carbon roles;
these are included as a bounded heuristic adaptation, not a proof mechanism or
authorization to start a research campaign.

## 2026-11-26 — Define and recognize mathematical stuckness

At the user's request, added the [definition and checkpoint rule](meta-proof-plan.md#recognizing-stuckness)
from the discussion, with observable signs, the distinction from slow progress
and tooling failures, and consistent parent/worker handoff requirements.
Baseline: `352eb674d04ee7c6c7586d7e8b598ffe4ff9db1c` on `feature/attempt-08-b3`.
The user explicitly requested self-review instead of Carbon for this change.
Self-review checked repeated unsupported steps, useful negative results and
environment failures against the rule; effort bounds remain binding, with no
fixed failure quota or inference of impossibility. All 38 offline process tests,
the 64-file documentation check and whitespace checks passed using the documented
`uv --no-cache run --locked --offline` prefix. No Lean files, mathematical
contracts or open hypotheses changed; no research milestone was started.

## 2026-11-26 — Prepare the full M4 Universal Visitation prompt

Prepared the [current M4 prompt](session-prompts.md#current-prompt-m4-universal-visitation)
from baseline `6d53f9d`, moving the B3 stopping point into the archive with its
old anchor and body preserved. Older archives are unchanged. Aligned active
entry links and the compact continuation pointer. This prepares authorization
on invocation; it does not start M4 or discharge V, Hπ, T or π disjunctivity.

The prompt retains the exact late-visit contract at recurrence index `n+1`,
all thresholds and interval bounds, bounded research/recovery, stuckness/TRIZ,
worker delivery rules, kernel audits, required Carbon reviews, local acceptance
and an honest incomplete endpoint if the mathematical gap persists. M5 is separate.
Self-reviewed this documentation preparation in line with the session's requested
review approach; actual M4 reviews remain mandatory. Compared the contract with
the blueprint, recurrence and existing B4 input audit. All 38 offline process
tests, the 64-file documentation check, archive-preservation checks and whitespace
checks passed. No Lean source, audit, pin or mathematical contract changed.

## 2026-11-26 — M4 bounded visitation research, incomplete

Invoked the current M4 prompt at `b7c3bca` on `feature/attempt-09-b4`, with an
empty index and unrelated Obsidian/notes/papers changes; created
`feature/m4-universal-visitation`. Baseline Lean `4.37.0-rc1`, `lake build`,
`lake env lean Test.lean` and whitespace checks passed. Recorded the finite
source/avoidance/recovery sequence in the proof plan before substantial work.

[The argument assessment](m4-visitation-obstruction.md) owns the results:
Lagarias's weak dichotomy is conditional; its identical one-based recurrence
represents `pi/16`. A root-import probe checked coefficient algebra,
irrationality after scaling and the orbit offset. A separate diagnostic model
with positive rational-function forcing and zero initialization permanently
misses an interval; parent and worker compilation passed with exactly the
permitted axioms. Its BBP-matching leading asymptotic is paper algebra.
An exact transcendental perturbation drops fixed rational-function structure.
Actual-BBP denominator clearing left residue coverage unproved.

Two bounded recovery tests also isolated gaps: maximal language entropy merely
reformulates disjunctivity, and the Thue–Morse–Mahler source supplies a nondense
number of irrationality exponent 2. No source or candidate supplied the needed
BBP-specific exclusion of an infinite proper limit set. The source/argument
skills supported separate same-session assessments; two authorized workers
returned immutable evidence and no production edits. Compiler repairs (wrong
irrationality namespace and explicit function shape) were distinct from the
mathematical obstruction. The native symbol index was unavailable; pinned
source and shell Lean worked. No new tooling was justified.

**Checkpoint:** learned exact limitations of generic decay/expansion,
irrationality, complexity and approximation routes; narrowed the missing
arithmetic mechanism but did not move the π proof frontier. No justified new
test emerged after the stated cycles. Suspend those routes and require a
concrete BBP-specific estimate/source connection before reopening them.
The meta-plan recovery loop remains appropriate; no process-policy change is
supported by this attempt. A bounded failure is not proof of impossibility.

M4/V, Hπ, T and π disjunctivity remain open. B4 retains late visits and vanishing
error; B3 supplies only the latter. P3 retains open-interval visits. Production
Lean, audits, pins and protected definitions are unchanged. The current prompt
now points to the precise restart obligation; M5 is not started.
The [handoff](m4-handoff.md), [retrospective](retrospectives/retrospective-2026-11-26-m4.md)
and [Carbon report](agy-reports/m4-review.md) own final checks, review dispositions,
local commit and post-commit necessity evidence.

Finalization: Carbon High completed with no defects or open review questions;
both nonblocking documentation recommendations were implemented. Complete
capture/log inspection passed, with source/kernel checks distinguished from
reviewer inspection. Final build/audit, 38 process tests, 68-file documentation
check, whitespace and owned-scope checks passed. Local research commit
`7cc5bd38e45315348aa7580ee83f68011971f025` contains eleven documentation paths.
Post-commit necessity inspection found no substantive simplification or unused
proof API. The handoff records the separate factual receipt commit by lookup
command. No push, PR, production Lean change or M5 work occurred. M4 remains
incomplete; the reviewed obstruction is not acceptance of V.

## 2026-11-26 — M4 persistence instruction correction

The user reaffirmed sustained work and requested durable instructions against
premature stopping. The initial attempt's small, agent-chosen research bounds
were incorrectly treated as an endpoint despite the instruction to persevere.
Its countermodels and source gaps remain valid; no external execution limit
forced the decision to finalize.

The [persistence protocol](meta-proof-plan.md#persistence-and-stopping-conditions)
now separates local experiment bounds from continued milestone authorization.
AGENTS, workflow, the current prompt, proof plan and restart pointers require a
changed inquiry after failure and allow discovery before a new estimate exists.
Historical snapshots remain identified as such; current instructions supersede
their stopping proposals. Trust, review/retry rules, exact V, M5 exclusion and
external resource/permission limits remain intact. No mathematical progress or
behavioral effectiveness is claimed for these instruction edits.

The [follow-up handoff](m4-handoff.md#persistence-follow-up--2026-11-26),
[retrospective](retrospectives/retrospective-2026-11-26-m4-persistence.md) and
[review report](agy-reports/m4-persistence-review.md) own the correction and its
acceptance evidence. Process tests (38), documentation (70 files), and whitespace
checks passed; the final subagent review completed without defects, additional
improvements or acceptance-blocking questions. Initial Carbon recommendations
and their dispositions are retained in the report; its interrupted follow-up
is not treated as a completed review.

While the focused Carbon follow-up was running, the user directed an immediate
stop, replacement by a Codex subagent reviewer, and continued proof research
during their absence. The invocation was interrupted (exit 1); its partial
response is not accepted as a completed review. The current override in AGENTS,
the review procedure and M4 prompt preserves review gates and forbids further
Carbon calls unless the user changes that instruction. The subagent review
covered the final sixteen-file correction; M4 research remains authorized.

## 2026-11-26 — M4 continuation: rational forcing structure

Research resumes after local process checkpoints `dacbd3c` and `050e025`, under
the user's instruction to keep working during their absence and to use Codex
subagents instead of Carbon for review. Lean `4.37.0-rc1`, cached `lake build`
(7205 jobs), and `lake env lean Test.lean` passed. The exact V contract and all
trust/scope constraints remain unchanged.

**Next bounded inquiry:** compare the actual BBP rational forcing with the
telescoping avoidance model at the level of pole locations, residues and
rational difference equations. The first reassessment point is an explicit
structural comparison plus a test of whether the resulting condition says
anything beyond irrationality/nonperiodicity already known. Do not formalize
a new API unless an exact visitation consumer appears. A condition that merely
rules out the old rational model is insufficient; attempt a stronger separating
example or identify a specific missing implication before changing direction.
In parallel, seek a precise primary-source connection for that structural gap,
with source hypotheses intact. This cycle's endpoint is a reassessment, not
permission to end M4. Findings and the next inquiry will be appended here.

**Checkpoint:** [the rational-forcing assessment](m4-rational-forcing.md) gives
an explicit positive completely monotone, simple-pole non-coboundary model with
the same leading asymptotic and uniform avoidance. Its rational weighted value
keeps it outside a proposed irrational-or-dense conclusion. A null BBP series
also changes the actual pi representation to a pure arctangent kernel, changing
the coefficient decay order without changing the represented constant.
The parent inspected and reran the exact-rational checker successfully; analytic
arguments remain paper proofs. Independent subagent criticism of the frozen
assessment is in progress, with both guides and no Carbon invocation.

The source-contract pass found G-function approximation/repetition theorems,
but did not verify their large-base hypotheses at the actual value. A separate
Thue–Morse argument shows that even zero normalized repetition growth does not
imply visits. This changes the next decision: do not build a G-function or
rational-telescoping Lean API for an inference already separated from V.

**Next bounded inquiry:** inspect a finite-frequency cancellation mechanism
after the null-series representation change. The first check is whether the
pure-arctangent/Gaussian factorization actually controls the phases
`exp(2*pi*i*h*16^n*pi)`, rather than just evaluating the original integral.
End this check at an exact phase identity or the first unjustified operation;
compare it with the rational model at h=21 before proposing estimates. In
parallel, one worker tests the fixed-modulus exponential sums used in a solved
Stoneham model against BBP's prefix/tail scales. These are discovery questions;
no cancellation premise is added to V and no positive answer is presumed.

**Second checkpoint:** [the arithmetic-window assessment](m4-fourier-windows.md)
extracts an unconditional fixed-modulus theorem and its finite-frequency
consumer, then tests both window length and denominator hypotheses. A fixed
rational tail correction cannot repair this comparison: its error has a finite
nonzero algebraic leading term, while a source-dependent PNT argument shows
exponential corrected odd-denominator growth at every sufficiently large
anchor. The parent and worker inspected the PNT statement at fixed modulus 4;
this is not a Lean theorem. The smaller Dirichlet specialization compiled in
both sessions with only the three permitted axioms. Exact rational checks passed.
This rejects that repair of that sufficient bound, not actual cancellation or V.

The pure arctangent identity alone evaluates the integral; it supplies no bound
on `exp(2*pi*i*h*16^n*pi)`. Exponentiating an integral and replacing it by an
integral of exponentials would be an unjustified operation. Positivity or a
Gaussian factorization cannot silently supply that step. More fixed-order
correction computations would repeat the now-resolved scale mismatch, so that
route is suspended while M4 continues.

**Changed discovery question:** a fresh-context worker constructed a positive
polynomial detector for the central hole `(1/4,3/4)` and tested whether its
radix pullback could enter pi's Gaussian-logarithm auxiliary arithmetic.
The detector is valid, but independent products incur quadratic logarithmic
height; an exact all-1 digit model defeats the proposed automatic content
cancellation. The parent inspected and reran its rational checker successfully.
The next bounded test couples two consecutive prefixes using
`p_(j+1)=16*p_j+d`: derive the actual resultant/Bézout scaling, check all digit
cases, and identify whether eliminating the height has also eliminated pi from
the arithmetic identity. Its endpoint is that identity and its precise consumer
or missing bridge, not another unquantified request for a better bound.

The first independent subagent review of the rational-forcing assessment found
no defects or unresolved diagnostic questions. Both improvements were applied:
H's nonrational-function premise is discharged using its irrational special
value, and the exact exponential sum and finite-frequency scope are now stated.
The full frozen response is retained in
`/tmp/pi-m4-rational-forcing-review-20261126/review.md`; final combined-diff
review and local checkpoint validation are still pending. No Carbon was used.

**Third checkpoint:** [the auxiliary-product assessment](m4-auxiliary-products.md)
retains the exact detector and the two-prefix test. The resultant scales as
`a^16*R_d`, with no vanishing digit cases. A Bézout representation removes a
from its constant but is an identity for every argument, including the all-1
avoiding model. Rewriting at `log(i)` yields zero upon subtraction at the
rational approximant, not a nonzero auxiliary remainder. Parent exact checker
execution passed. The independent-product and this elimination route are
suspended; they supply no pi-specific average estimate.

**Next bounded inquiry:** derive the generating functions of the actual
recurrence and carries, inspect the precise analytic-continuation/natural-boundary
connection, and test whether avoidance gives an additional restriction. The
endpoint is the actual implication and its first missing bridge or separating
example. Neither rational forcing nor a missing cylinder permits assuming the
carry word is holonomic or automatic. A worker is investigating this while
the combined partial checkpoint undergoes review; M4 remains active.

Combined checkpoint review completed with no defects, additional improvements
or unresolved diagnostic questions; the initial two improvements were verified.
All 38 offline process tests, the 74-file documentation check, working/staged
whitespace and protected-source preservation checks passed. The
[review report](agy-reports/m4-continuation-review.md) retains exact scope and
complete-response pointers. This accepts the diagnostic checkpoint only;
V remains unproved and the generating-function inquiry continues.

## 2026-11-26 — M4 continuation: generating functions and phases

The previous seven-path checkpoint is committed locally as `052234d`, with
factual receipt `7b73048`; no push or PR. The next cycle supplied an actual
analytic consequence for the BBP sequence, not visitation: its carry series K
and recurrence series Y have natural boundaries, although the forcing series H
has analytic continuation across the rest of the unit circle. Their exact
identity exhibits cancellation of those boundaries. A restricted-digit model
shows why the natural-boundary conclusion does not imply V. The
[assessment](m4-generating-functions.md) retains the source contract and gap.

To verify the critical indexing, the parent used the Lean search/proof-pattern
skills for a bounded scratch interface. Through `import PiDisjunctivity`, it
proved the carry decomposition, initial carry 3, a sufficient finite integer
range, summability of the weighted recurrence, and `HasSum (carry n/16^n) pi`.
The final immutable probe compiled with only the three permitted axioms.
No production API was added; the complex-analytic consequences remain paper
mathematics awaiting independent review.

**Next bounded inquiry:** test the exact phase-weighted correction G_h at high
frequencies, retaining its dependence on the actual orbit. First determine
whether the generic `O(sqrt(abs h))` bound is sharp on the earlier avoiding
model at frequencies divisible by 21. The endpoint is an exact identity and
an improper-integral limit, or a counterexample to that proposed calculation,
with all endpoint estimates justified. Then isolate the specific improvement
the pi phases would need. Fixed-frequency summability alone is not a new
visitation mechanism. This test is underway while the accepted frontier and
all V quantifiers remain unchanged.

**Phase checkpoint:** the generic square-root estimate is sharp along frequencies
divisible by 21 for the earlier rational avoiding model. The exact scaling
limit has nonzero real part; integrable domination controls both endpoints.
For actual BBP, `G_h(1)=e(h*pi)-1+T_h-T_(16h)` retains the unresolved orbit
phases. Fixed-frequency summability gives invariance only. An explicit diffuse
restricted-digit invariant measure also defeats an inference from averaged
frequency decay to decay along powers of 16. These are paper arguments, not
new kernel results or a disproof of a pi-specific estimate.

**Representation checkpoint:** the null family with `t(n)=n/(n+1)^4` preserves
pi, the leading coefficient and full late visitation for each fixed parameter.
Its uniform horizon laws, however, escape to infinity. A zero-base model has
the same uniform marginals and no visiting fixed orbit; every fixed probability
law gives vanishing circle offsets. Even all-index positivity bounds the
allowable parameter using the first two coefficients. The parent inspected
and reran the 240-case exact checker successfully. The assessment retains the
circle/representative distinction and missing joint-event estimate.

**Next bounded inquiries:** a 30-minute structural pass determines the rational
nullspace inside the original four simple poles, retaining O(n^-2) decay; a
separate 35-minute fresh-context pass seeks one pi-specific arithmetic mechanism
or precise neighboring-theorem test not already refuted by these examples.
Each must return an exact relation or first missing bridge, not a renamed V
premise. The parent prepares independent review of the generating, phase and
null-family checkpoint while those investigations run. Cycle bounds remain
reassessment points; M4 continues with all original quantifiers and trust rules.

The independent `/root/generating_review` review completed with no D/I/Q findings.
The exact four-path packet and full response are retained under
`/tmp/pi-m4-generating-review-20261126/`. Scratch and arithmetic checks, 38
process tests, the 75-file documentation check and whitespace checks passed.
This accepts the diagnostic checkpoint only; the two changed inquiries continue
and no V premise has been removed or silently assumed.

## 2026-11-26 — M4 continuation: logarithmic constraints

The generating/phase checkpoint is committed locally as
`9b6ca1b63f21be4f57ff195a36effa09255384c0`. Post-commit inspection verified
exactly four documentation paths, unchanged production/pins/audits, and
preservation of unrelated Obsidian, notes and papers. The note retains distinct
diagnostics without new proof infrastructure; no substantive simplification
was found. No push or PR occurred, and research continued.

The [logarithmic assessment](m4-logarithmic-constraints.md) records a positive
structural result: Baker's theorem and exact endpoint algebra give Q-rank 4
for the original four weighted pole sums, with no rational null direction.
All nonzero rational combinations are transcendental. This excludes the
rational-value model inside that precise pole space, but gives no orbit estimate.
The parent inspected the proof, reran its exact field checker, and used the
PDF skill plus installed macOS PDFKit to visually verify Baker's primary
statement on printed p.20. No installation or dependency change was needed.

A fresh-context neighboring-theorem test found a separate exact mismatch:
dimension one for the Bernoulli convolution at pi/4 does not control the
hexadecimal orbit of pi. A rational affine Thue–Morse example retains dimension
one, transcendence and irrationality exponent 2 while avoiding a fixed interval.
The parent verified the cited theorem pages and reran the finite exact checker.

The next 30-minute cycles test an allowed-prefix auxiliary construction against
the quantitative polynomial-value bound actually available for pi, and a
different identity exploiting the original pole pattern. These checks must
compare real costs or supply a discriminating identity; renamed cancellation
premises are not progress. The new assessment still requires independent
review. V, Hpi, T and final assembly remain open, with M4 research active.

**Parent extension, bounded to 20 minutes:** test whether the four-pole
uniqueness reflects its sparsity or extends to all eight simple poles
`-r/8`, r=1,...,8, after imposing coefficient sum zero. Preliminary field
components suggest a one-dimensional full nullspace generated by the earlier
zero-series polynomial C, whose coefficient sum is nonzero. The endpoint is
an exact kernel calculation with the missing angle relation justified, plus
an exact arithmetic check; no visitation implication will be inferred from
uniqueness. This would distinguish a four-pole accident from a full residue-
period constraint and explain why the known null change alters the decay order.

**Extension outcome:** the full eight-pole kernel is exactly the line generated
by the previous C=(1,-1,-1/2,-1,-1/4,-1/4,1/8,0). Its sum is -15/8, so no
nonzero null direction retains O(n^-2) decay. The paper proof uses Baker
component separation, prime factorization for log(2), log(3), log(5), and an
explicit angle-independence argument: (4+3i)/5 cannot be a root of unity since
its trace 8/5 is a nonintegral rational algebraic-integer candidate. The exact
eight-pole checker passed on its first run; the calculation finished within
the 20-minute bound. The result clarifies a representation invariant, not V.

## 2026-11-26 — M4 continuation: arithmetic costs and growing-order tails

The initial logarithmic assessment received independent subagent review with
no defects and one source-notation improvement, now applied. The combined
checkpoint review remains pending. The
[approximation-interface assessment](m4-approximation-interfaces.md) records
three changed tests: the actual polynomial-value threshold for pi and an
all-allowed-prefix interpolation barrier; arithmetic holonomy's simultaneous
continuation/rational-coefficient/denominator requirements; and the missing
second radix action after finite BBP blocking. Each test identifies a precise
failure of the proposed transfer, not a general impossibility of the method.
The parent inspected the primary theorem pages and reran the exact checkers.
A visual source check corrected a non-strict transcendence lower bound and
its corresponding strict contradiction target; all downstream comparisons
remain valid. Versioned worker artifacts preserve the correction.

The [growing-order tail extension](m4-fourier-windows.md#growing-order-corrections-a-uniform-obstruction)
answers a stronger question than the earlier fixed-rational result. For every
anchor n>=1 and every finite order K, a positive integral representation and
an exact finite remainder identity give
`abs(E(n)-R_K(n))>=15*16^(-n)/(16n+6)^2`. The coefficient denominators contain
only primes 2,3,5, so every prime in the earlier exponential product survives
in the corrected seed. Thus arbitrary K(n) still permits only n+O(log n)
absolute real-shadowing windows, whereas the tested fixed-modulus Fourier
bound needs an exponential scale. Direct orbit, raw-prefix and corrected-prefix
comparisons have different exact errors, all retained. Circular coincidences,
actual phase cancellation and other approximants remain unexcluded. The
parent reran the 30-order, 245-pair exact checker successfully; the universal
argument and PNT input are paper mathematics, with independent review pending.

**Reassessment:** increasing natural truncation order is now suspended for
this real-shadowing comparison. The next bounded inquiries change the input:
a specified dihedral rational pullback tests whether a radix-aligned rational
approximation preserves its claimed denominator advantage; a 30-minute source
pass seeks a pi-specific prefix coupling using the exponential relation; and
a 20-minute transform calculation tests why all sampled tail coefficients
are actually dyadic and whether resummation exposes a different usable identity.
These are discriminating questions, not promised proofs or stopping conditions.
V and M4 remain incomplete, and production Lean, audits and pins are unchanged.

**Dihedral outcome:** the substitutions produce the asserted rational/pi
coefficient ratios. Exact even-index valuations give primitive aligned
denominator `16^m*D_(8m)/4`, with an odd factor whose log is at least
4m+o(m). The primitive integer linear form therefore grows, despite the
ratio's geometric convergence. Modulo-eight grouping is exactly A-2C plus
the endpoint correction 4/(8m-1); its shifted pole prevents misuse of the
eight-pole uniqueness claim. The parent inspected the paper proof and reran
the exact composition/valuation checker successfully. This closes the specific
pullback test and directs continuation to the other changed inquiries.

The combined six-path independent review and focused clarification follow-up
are complete. No defect or blocking question was found. Its I1 verified the
prior zero-polynomial clarification; I2 made explicit that the rational finite
empirical transforms use actual BBP recurrence samples, and I3 removed the
completed dihedral test from the active handoff list. All are resolved. The
complete responses and exact diff hashes are retained in the continuation
review record. The 38 offline process tests, 77-file documentation check and
working/staged whitespace checks passed. This accepts only the diagnostic
checkpoint; distinct scratch inquiries continue and V remains unproved.

## 2026-11-26 — M4 continuation: transforms and rational periods

The arithmetic-cost checkpoint is committed locally as
`b102ab3dde2820203e1c064f43f38f459a885a32`. Post-commit inspection verified
its exact six documentation paths, empty index, unchanged production/pins/audits
and preserved unrelated work. No unneeded API, tooling or substantive
simplification was found. No push or PR occurred; research continued.

The [transform/period assessment](m4-transforms-and-periods.md) records two
changed tests. The tail's explicit transform proves exact dyadic coefficient
denominators, identifies all poles and residues, and separates contour loops
from the decaying solution. The avoiding model shares the coarse singularity
pattern, so those features alone cannot imply visitation. Pole subtraction
gives a different exact integral but no rational or modular consumer.

A precise Stoneham theorem genuinely applies to an explicit Wallis subsequence
in base16. Its full period is at least quadratic in n, while even the actual
prefix shared with pi/4 has length at most logarithmic in n. The same-denominator
numerator-one test shows that the source hypotheses alone do not locate a word
in that prefix. Parent primary-page inspection and both exact checkers passed;
universal claims remain paper mathematics and independent review is pending.

The next 20-minute arithmetic test retains the full numerator phase modulo
the controlled power of three and asks what its actual global shape contributes.
A separate fresh-context 30-minute pass changes representation to a modular or
theta construction, retaining arithmetic costs before proposing a visitation
consumer. These cycles continue the unchanged M4 objective; no V premise,
production proof or acceptance result has been added.

**Full-phase outcome:** the actual Wallis reduced numerator is exactly
`2^(4n+1-popcount(n)-popcount(n+1))`. Elementary inclusion–exclusion supplies
a small coprime replacement in every unit class modulo its full three-power
factor, for every s>=2, without PNT. Such replacements can have a zero prefix
through the possible transfer window. But the full phase together with the
global power-of-two constraint uniquely identifies the actual numerator;
the replacements cannot retain both. The exact shift of 2^h/q_n near position
n is retained, with no unsupported distribution conclusion. Parent inspection
and exact tests passed, including all unit residues through s=4. The structural
test is complete; independent review is pending and the fresh modular/theta
inquiry continues. No renamed early-hitting premise is counted as a proof step.

**Next arithmetic source test, bounded to 30 minutes:** the fresh representation
inquiry is deriving dyadic truncated Ramanujan series for 1/pi and exact
denominators after inversion to approximate pi/4. Inspect one primary
supercongruence for an actual family, retaining truncation length, normalization
and exceptional primes. Test whether its odd-prime valuation or phase gives
anything usable by the rational-period or short-window consumer. The endpoint
is an exact applicability check and smallest discriminating calculation, not
an inference from p-adic divisibility alone to visits. This is authorized
discovery while the preceding diagnostics await independent review.

**Reciprocal-series outcome:** two fixed Ramanujan identities give geometric
approximation and exact valuation v_2(A_n)=3*popcount(n). After inversion,
the reduced odd denominator is exponential; the actual shared-prefix ceiling
is linear and smaller than the elementary minimum full-period scale. At
n=2^s an exact denominator congruence controls the end of a seed repetend.
Its shifted location in the actual period is before a trailing zero block;
parent inspection explicitly retains possible leading padding and the missing
alignment/coverage arguments. Primary-page inspection and the exact checker
passed. This resolves that representation test without a V implication;
the distinct odd-prime supercongruence inquiry continues.

**Supercongruence outcome:** Long's proved theorem applies exactly at p>3,
n=(p-1)/2 and yields v_p(q_n)=1 plus a normalized unit congruence modulo p^3.
It does not give a p^4 denominator factor or Type A excess. A same-numerator,
comparable-height congruence-class construction approaches 1/3 with long
initial strings of fives; it explicitly loses the actual hypergeometric
recurrence and pi limit. Parent theorem-page inspection and exact checks passed.
The source's p=3 exception and p=5 squarefree-period example remain finite
diagnostics, not asymptotic claims. This test is complete and awaits review.

**Next changed test, bounded to 25 minutes:** use the actual extra central-
binomial summands to extend the half-truncation congruence to every prime
n<p<=2n+1. Test the simultaneous modulus and its compatibility with the
existing low-two-bit information. The proposed endpoint is an exact prime-
window statement and a comparison of its total modulus with the numerator
and shared-prefix scales. This uses more of the actual coefficient recurrence;
it must still distinguish constraints on extracted arithmetic from a theorem
about the real leading digits. The unchanged V objective continues throughout.

**Combined-prime outcome:** every prime n<p<=2n+1, p>3, has denominator
valuation one and the extended congruence modulo p^3; a prime endpoint retains
p^4. Combining these with the known exact low-bit datum still allows
same-numerator fractions with all-five prefixes through the entire possible
transfer ceiling. The ordinary PNT proves the needed modulus/height comparison
eventually at every anchor. The parent inspected and ran the exact checker,
including 5,903 prime-window pairs and 244 model prefixes. This closes the
extracted-congruence consumer, not the actual recurrence or real pi enclosure.

**Meta-plan recovery, bounded to 30 minutes:** several arithmetic tests now
reach the same missing real-position implication. A fresh-context agent is
attempting a positive intermediate lemma with a concrete visitation consumer,
retaining the exact dependence across anchors that the countertests discard.
The endpoint is a proved candidate or its first unsupported implication and
a genuinely changed next question; it is not a new label for V or a reason
to end the authorized research.

**Intermediate review:** the independent reviewer found one endpoint-convention
defect in the Stoneham source contract. The parent reproduced its q=81 example
and repaired the strict bound to use half-open intervals, preserving the
hexadecimal-cell application. The original report is preserved with a versioned
correction and erratum. Focused review of this repair and the combined-prime
addition is complete: D1 resolved, no further D/I/Q findings. M4 remains
incomplete; no production Lean or trust policy changed.

**Changed positive test, bounded to 25 minutes:** the recovery worker found an
exact positive Catalan-coefficient transform of the actual Ramanujan series.
The parent derived an arbitrary-order extension with integer super-Catalan
coefficients. Test its telescoping identity, primitive valuation and positive
tail enclosure, allowing the cancellation order to grow with the truncation.
The discriminating consumer compares the enlarged possible shared-prefix
window with the actual denominator/period scale. This differs from the earlier
BBP Stieltjes truncations and must be checked on its own; acceleration alone
is not visitation. The preceding four-path diagnostic checkpoint is committed
locally as `5b431a35e07427503e85f03c2a7ccdb33666863f`; post-commit scope and
protected-source checks passed, with no push or PR.

**Positive-transform outcome:** the exact Catalan block identity gives positive
integer coefficients and explicit BBP margin enclosures. Its arbitrary-order
extension preserves two exact integer recurrences and has primitive valuation
`s(N)+2s(N+r)`. The parent found the same family in Guillera's 2011 paper and
visually checked the normalization; no novelty is claimed. A uniform elementary
lower error bound proves that every possible common-prefix length is at most
half the denominator's base-16 logarithm, up to logarithmic terms, even with
growing order. The balanced diagonal attains that exponential ratio but matches
the existing M=12 benchmark. This closes acceleration alone as the proposed
complete-period transfer mechanism. Exact finite checkers passed; the new
[assessment](m4-catalan-transforms.md) passed independent review, with its sole
navigation improvement applied and no mathematical finding. V remains open.

**Next connection test, bounded to 25 minutes:** seek one precise primary-source
theorem about digit restrictions of G-function values or logarithms of algebraic
numbers. The consumer must constrain the actual pi orbit without relying on
complete rational periods, almost-everywhere assertions, or insufficient
complexity/irrationality bounds. A fresh-context worker has the failed bridges
and the exact target. The endpoint is a fully mapped theorem and discriminating
applicability check, or an explicit missing bridge with a changed next question.
This is targeted discovery within the ongoing milestone, not a claim that such
a theorem exists or that a bounded search can exclude all possible connections.

**Parallel strategy test, bounded to 20 minutes:** determine whether positive,
completely monotone rational forcing can match an arbitrary finite endpoint
Taylor jet of the actual BBP moment kernel while its weighted constant is
dyadic rational. Such a construction would delimit all finite-order tail
arguments at once, rather than test another coefficient order. The planned
test uses a positive polynomial cutoff preserving the chosen endpoint jet
and a rational integral adjustment; it must retain initialization and exhibit
actual eventual interval avoidance. This is a diagnostic of finite local
information, not a counterexample to the fixed BBP recurrence or a V proof.

**Source-connection outcome:** the best theorem was already assessed;
the new calculation proves that its published sufficient constants fail for
every pure BBP radix dilation and the tested joint dyadic Machin identity.
The existing cube-free separating word also satisfies a full fixed-multiplier
denominator bound. This sharpens two recorded gaps without supplying a new
visitation mechanism. Parent source-page inspection and the exact checker
passed; the universal argument awaits integration review.

**Finite-jet outcome:** for each K>=1 a separate rational positive completely
monotone forcing matches the actual tail through O(n^(-K-2)), preserves
g(0)=47/15 and y_0=0, yet has weighted value 51/16 and avoids (1/4,3/4).
The positive polynomial cutoff and two moment corrections were proved on
paper and checked exactly for K=1,...,8. Independent sketch review found no
defect. Irrationality and the exact four-pole function are explicitly lost;
the result does not refute a method using those additional inputs. Integration
review remains pending. The positive-transform checkpoint is committed locally
as `1bb8bffc41a6f00f0047eaeb55dc66f2ff821b4d`, with exact post-commit scope,
unchanged protected sources and no push or PR.

**Next distinct test, bounded to 30 minutes:** inspect the actual cleared
integer residual in a non-diagonal Pade construction for BBP or a pi
logarithmic identity. Attempt one way for a forbidden-word automaton to force
a larger divisor or absolute lower bound, while preserving the analytic
remainder and coefficient-height budget. The worker must retain dependence
between the actual auxiliary coefficients; prescribing arbitrary residues for
free is not an argument. The endpoint is a nontrivial proved gain and consumer,
or the first unsupported step with its concrete cost. No finite pi-word search
or renamed prefix-exclusion premise counts as a result.

**Combined review outcome:** the five-path finite-data checkpoint passed after
one integration repair: the actual kernel is P_A, whereas the older note's P
denotes a null-series polynomial. The focused correction restores the already
reviewed construction. All D/I/Q items are resolved. The source-threshold and
fixed-multiplier arguments were independently reconstructed with their exact
limits; no kernel theorem or M4 acceptance is implied. The next Pade test is
outside that reviewed mathematical scope and continues independently.

**Numerator-sensitive outcome:** an actual degree-two BBP Pade kernel permits
arbitrary residual residues modulo powers of two and gives a nonzero lower
bound 16^m/32 for every m-digit suffix omitting F. This is a positive arithmetic
gain with coupled coefficients. Its selected congruence also forces
abs(alpha)>=16^m-1, so the symmetric error estimate cannot exploit the gain.
The exact signed identity remains intact; coefficient clearing, evaluated
cancellation and primitive residual reduction are kept distinct.

The point-evaluation determinant is strictly positive by the actual BBP moment
kernel. It shows that every rational approximant can be encoded in this small
family; an explicit inverse and numerator-independent interpolation height cost
quantify why mere coefficient existence is insufficient. Exact interpolation
has zero residual and is expressly excluded as a source witness. Parent
inspection and the replayable exact checker passed, including 63 prescriptions
and 54,225 allowed-prefix residue cases. The new
[assessment](m4-pade-residues.md) passed independent review; no pi digits were
searched, production theorem added or V proved.

**Fresh recovery, bounded to 30 minutes:** the residual test sharpened the cost
but has not supplied an actual visit. A fresh-context worker has the exact
target and failed-route map and is attempting one positive intermediate lemma
using unused exact pi/BBP structure. It must name a concrete consumer, retain
all hypotheses and distinguish any arithmetic gain from a renamed density
assumption. This is a deliberate reset under the meta-plan, alongside review
of the completed residual test. The finite-data checkpoint is committed locally
as `1dba613b5b9ba39143ca419db59b3a198be3c5a3`, with post-commit scope and
protected-source checks passed. No Carbon, push or PR occurred.

**Pade review outcome:** no blocking defect or additional open question was
found. I1 requested explicit integer and positivity domains for the general
residual interface; these are now stated. The actual family already fixed B=1.
Both adversarial guides were applied, with the full response and exact scope
retained. The signed-remainder recovery remains separate ongoing research;
review of a diagnostic is not acceptance of M4.

**Signed-remainder recovery outcome:** the actual moment kernel gives an exact
signed formula with rational sign enclosures. Combining it with point evaluation
simplifies the derivative to a rational function and shows the safe slope cone
represents every rational in its explicit image interval. A new prime argument
bounds the product of coefficient height and the actual primitive evaluated
denominator; it does not substitute coefficient clearing for evaluation.
The original residue certificate also fails with any signed interval containing
the full omitted-digit tail hull. These facts and their precise exclusions are
in the [signed-evaluation assessment](m4-signed-evaluation.md). Parent exact
checkers passed; independent changed-file review completed with no D/I/Q items.
No V follows.

**Changed representation, bounded to 30 minutes:** investigate the full tower
of actual BBP congruences via B(x)=sum_(j>=0)16^j A(x-j) in Z_2. The question is
whether coherent interpolation, beyond freely prescribed residues, constrains
permanent real interval avoidance. The worker must prove the exact invariant,
retain the real-fractional-part bridge, and challenge it with an avoiding model.

**Parent discriminating follow-up, bounded to 20 minutes:** the worker has a
paper proof of B(-1)=0 and isometry, hence exact prefix valuations. Before
using them as a visitation mechanism, test whether analytic interpolation can
preserve those properties, irrationality and exponential rational-prefix height
while producing an avoiding real orbit. The proposed Newton-binomial model
drops the exact rational forcing function; its role is to isolate that remaining
input, not to refute the BBP target. This investigation continues while the
completed signed calculation is reviewed.

**2-adic outcome:** the actual reflected sum vanishes in Q_2, proved by an
explicit convergent formal log/arctangent identity. Thus B(n)=S_n exactly;
v_2(S_m-S_n)=v_2(m-n), v_2(S_n)=v_2(n+1), and every residue block is a
permutation modulo each power of two. The parent reconstructed the proof,
visually checked Cohen's supporting logarithm lemma and reran the exact checker.
The [assessment](m4-two-adic-reflection.md) retains the missing real bridge.

**Analytic countertest outcome:** a Newton-binomial interpolation preserves
the zero reflected anchor, analytic isometry, irrational weighted real sum,
initial forcing, leading decay and exponential rational-prefix heights, while
all recurrence values avoid (4/5,9/10). It loses the exact rational function,
polynomial height of individual forcing values, real complete monotonicity and
rationality at negative integers. The simpler rational/CM model preserves the
isometry but loses the zero anchor and irrationality. Both proofs and exact
checks are in the [model assessment](m4-two-adic-models.md); independent review
of the combined checkpoint is complete after one domain correction: the
binomial basis vanishes at nonnegative prior inputs, with -1 treated separately.
No V or new Lean theorem is claimed.

**Next cycle, bounded to 30 minutes:** work backward from e(h*S_n) or an omitted
hexadecimal cylinder. Derive an actual local/global character relation retaining
the odd denominators, and test whether the full rational four-pole structure
controls their contribution. The worker must identify a nontrivial consumer
estimate or precise missing bridge, distinguish the analytic countermodel, and
avoid repeating complete-period or free-numerator arguments. The new positive
invariant survives; its insufficiency alone calls for a changed question.

**Local/global character outcome:** an exact CRT identity separates the
2-adic permutation from an odd correction whose conductor survives dyadic
rescaling. At integer real frequency the 2-adic character is trivial. The
four-pole formula supplies explicit fresh-prime factors; their joint correlation
is still uncontrolled. A stronger stress test uses the actual negative branch:
complete local cycles and exponential fresh odd denominators coexist with real
values tending to zero. The [extended assessment](m4-two-adic-reflection.md#7-exact-real-characters-and-the-missing-odd-correction)
retains the distinction from the target's forward evolution and gives a precise
weighted comparison, without asserting its missing variation estimate.

**All-jets enhancement, bounded to 20 minutes, completed:** replacing the
analytic model's rounding target by the actual BBP tail preserves every
algebraic tail term at once, with exponentially small forcing error. Fixed-tie
rounding avoids an unjustified claim that xi-pi is irrational. A 7-adic witness
proves no rational function represents its forcing even eventually, and forces
exponential denominators on an infinite progression. This makes the lost
polynomial-height input precise. Parent inspection and both new exact checkers
passed; combined independent review completed with three wording clarifications
resolved: scaling of the rounding target, the height proof's extra ingredients,
and growth of the prime product rather than its count. No Lean theorem or V is claimed.

**Fresh recovery, bounded to 30 minutes:** after the character barrier, a
fresh-context worker receives the exact target and failed-route map. It is to
formulate materially different mechanisms using the global rational forcing
and forward iteration, then investigate one discriminating small claim. The
consumer should be no stronger than needed for an arbitrary cylinder visit
unless a stronger estimate has a concrete advantage. A forbidden-language
automaton must not be mistaken for a finite-state actual carry process. This
is a change of source of ideas under the meta-plan, not another permission gate.

**Joint forward outcome:** exact old-prime valuations survive polynomial
restriction to a short forward block, with original coefficient height and
leading-term cancellation accounted for. Hankel determinants supply nonzero
affine dependence and strict signs, but finite carry-language polynomial
equations are constant on that same forward line. The missing information is
the inequalities selecting the actual floors. The
[assessment](m4-forward-polynomials.md) records the scope; parent reconstruction
and the immutable exact checker passed. No V consumer or production Lean follows.

**Changed arithmetic test, bounded to 25 minutes:** after that obstruction,
test whether multiple original poles at a prime combine into a usable exact
state relation. The endpoint is an identity retaining incomplete blocks, a
proved survival bound or a concrete cancellation, and a specific consumer with
its normalization costs. This uses the actual rational four-pole forcing rather
than a freely chosen residue system.

**Prime-compression outcome:** the two sign states give eventual survival on
every fixed linear prime scale. Together with the support upper bound and
fixed-progression PNT, they prove log den(S_n)=6n+o(n) at paper level. The actual
cancellation n=9,p=19 prevents a false square-root-scale claim. Exact evaluated
divisibility q_L | alpha'*D_bc*V strengthens the primitive Pade height tradeoff
and rules out the specified convex-hull interval/modulus certificate, retaining
its degree and height restrictions. Parent reconstruction, source-page inspection
and 40,774 exact compression cases passed. The [assessment](m4-prime-compression.md)
and forward note passed combined independent review. No normality, V or new
kernel theorem is asserted.

**Next discriminating test, bounded to 25 minutes:** keep two signed residuals
and the same nonconvex omitted-digit tail, rather than independent tail intervals.
First classify their exact joint lattice after primitive normalization and ask
whether it provides information beyond one scalar enclosure. Start with one
explicit forbidden word as a test, retaining the full arbitrary-word V target.
Compare with a genuinely nonlinear residual only if the shared-tail calculation
identifies a concrete advantage. The worker must retain coefficient costs,
correlations and the first missing bridge; no finite pi digit search or carry
equation already shown constant counts as a new consumer.

**Arithmetic review outcome:** no defects or additional open questions were
found. I1 repaired the handoff's latest-continuation pointer; the reviewer
inspected its exact one-line delta and resolved it. Both guides, full source
reports/checkers and all hashes were inspected; successful executions remain
caller evidence. The full response and six-path scope are retained in the
review packet. These are reviewed paper diagnostics, not M4 acceptance.

**Shared-tail outcome:** an exact moment identity reduces the two remainders
to one correlated scalar. Under the stated height budget their primitive
denominators share an exponentially large gcd. Dropping the individual
congruences therefore creates false fractional integer parts; keeping a full
Cantor tail alone does not exclude these relaxed witnesses at fixed moment
order. The full lattice and higher-order enclosures remain outside that
obstruction. The [assessment](m4-shared-residuals.md) retains the exact limit.

**Positive triple extension within that bound:** partitioning the actual
denominator's whole prime powers and selecting congruences through 256*q_i
constructs three conditioned actual Pade vectors with primitive denominator
gcd one. Nearest-point selection in their safe evaluation interval costs only
a polynomial factor; total coefficient height is exp(2L+o(L)). Three is the
first possible number at the stated height budget. This removes the pair's
false grid, but a costed uniform exclusion from the actual forbidden-tail set
is still missing. Parent reconstruction and both exact checkers passed. The
source report's ambiguous "interior point" wording was corrected to an allowed
point inside the hull; the Cantor set itself has empty interior.

**Opposite-direction test, bounded to 15 minutes, completed:** test whether
the positive denominator exponent distinguishes the actual negative branch
already known to concentrate in the reals. The increasing-weight compression
has an exact zero state on two prime strips of combined weighted mass m/5.
It gives log den(X_m)=(29/5)m+o(m), with full dyadic cancellation retained.
The real-positive rational state m=20,p=13 still cancels modulo p, so fixed-scale
quantifiers remain essential. A finer mesh also lets the analytic avoiding
model match scalar exponent 6; it still loses exact rational forcing. Parent
reconstruction and the 40,557-case checker passed. This extension and the
shared-tail/triple note passed combined independent review with no D/I/Q items.

**Fresh source of ideas, bounded to 30 minutes:** the arithmetic now removes
a concrete lattice obstruction but still does not control real position.
A fresh-context worker has the exact target and compact failure map and is
testing an analytic sampling/interpolation bridge. It must distinguish this
from the already failed ordinary generating-function natural-boundary inference
and the missing second-base closure premise. The endpoint is a proved small
claim with an actual cylinder consumer or a newly identified precise obstruction,
not another denominator estimate. No change to V or authorization is requested.

**Shared-tail review outcome:** the independent reviewer reconstructed the
full triple construction and its restricted lattice consumer, pair limits,
negative exponent and mesh adjustment. No defects, improvements or additional
open questions were reported. Both guides, full reports/checkers and all hashes
were inspected; successful executions remain caller evidence. No V or new
Lean theorem follows. The ongoing analytic investigation is outside this scope.

**Analytic sampling outcome:** the actual complex interpolation has bounded
imaginary growth, but no floor or fractional-part interpolator can satisfy the
specified uniform bound C*exp(a*x+b*abs(y)) with b<pi. A contour continuation
argument and the inspected finite-alphabet theorem prove that obstruction.
It applies generically to bounded nonperiodic carries and supplies no
four-pole visitation estimate. The period-two model makes the threshold sharp
for the attempted hole-to-growth inference. This inheritance route is suspended.

The exact Newton transform changes 16^n to 16^n*15^k with a signed moment
tail; finite blocks are unimodular changes of the earlier forward data, with
no cylinder-transfer theorem. Splitting off a prime also leaves a complement
that follows the same expanding forced phase recurrence between pole entries.
Its exact entry value has not become slowly varying or independent. The
[extension](m4-generating-functions.md#analytic-sampling-finite-differences-and-the-complementary-phase)
retains all three limits. Parent paper reconstruction, source-page inspection
and the revised exact checker passed. The checker now uses integer square
roots; frozen earlier evidence is preserved with an erratum. Independent review
completed with no D/I/Q items; no new Lean proof or V is claimed.

**Entry-phase countertest, bounded to 15 minutes:** take a large prime N=p,
the actual q_N=p*Q, and alternative entries S_N+16^N*t/Q. Test whether their
actual initial floor, exact denominator, p-principal component and dyadic
residue modulo 16^N can all be retained while the exact forward forcing avoids
(4/5,9/10) for N steps. The proposed lattice interval has exponential length
because 6>2*log16, while an elementary sieve for its exact denominator costs
only exp(o(N)). The endpoint is a proof or a failed bound, preserving that the
changed entry is not the globally zero-initialized orbit. This tests the
specific input needed by a prime-block consumer rather than assuming one.

**Entry-phase outcome:** the construction works for every sufficiently large
prime N. An open-interval sieve preserves the actual initial denominator and
floor while a nonzero perturbation retains the entire p-principal sequence
and dyadic congruences modulo 16^(N+j) throughout N+1 states. Those states all
lie in (18/100,21/100). It changes the global zero initialization and need not
preserve future reduced denominators or infinite avoidance. This rules out
only a block guarantee based uniformly on the retained summaries. Parent
reconstruction and exact checks passed; the combined sampling/entry extension
passed independent review with no D/I/Q items. No assertion about an actual
missing pi word follows.

**Changed real-analytic connection, bounded to 25 minutes:** test a precise
Mellin/Poisson or Gamma-functional identity for a periodic interval detector
sampled at pi*16^n. The uncertainty is whether the pi scale supplies any
actual cancellation, or merely returns the same coupled phase (or a statement
about 1/pi). Keep contours, regularization, endpoint terms and uniformity
explicit. The worker must prove or refute one proposed gain with a cylinder
consumer, not present another transform identity alone as a visitation result.

**Mellin/Poisson outcome:** the frozen report supplies a smooth finite-mode
minorant with an exact one-block sufficient estimate, retaining the strict
interval margins and B3 transfer. The estimate remains unproved. Zeta reflection
crosses the explicit -Log z and z/2 residues; its boundary branches count
floor(pi*16^n) exactly. The original phase is still present. Gaussian inversion
has an unresolved sparse-selection step and a quantified growing dual length.
Parent reconstruction, official DLMF formula inspection and exact checker replay
passed. The [assessment](m4-transform-phases.md) preserves these paper limits.

**Conjugate state, bounded to 20 minutes, completed:** test whether the second
prime-compression state has a usable global real relation. Its coefficient sum
with A is four times the existing null kernel. Integration proves weighted
constant -pi and a positive null prefix U_n<1/(16n+18), with two explicit
asymptotic coefficients. The local transform swaps the two states for primes
3 modulo 4 and fixes their sum, retaining distinct endpoint terms. Thus their
real characters are asymptotically conjugate, not independent. Opposite entry
perturbations preserve the entire null-prefix sequence and both actual forcings,
but lose individual initialization. The
[extension](m4-prime-compression.md#the-alternate-state-is-a-reflected-real-phase)
and full exact checker were reconstructed and rerun by the parent. Its observed
finite valuation pattern is not a theorem. Both new extensions passed independent
review after restricting the compression coefficient domain, requiring a
positive minorant exponent and clarifying coincident circle endpoints.

**Extraction follow-up, bounded to 20 minutes:** quantify the finite Fourier
completion norm of the powers-of-four mask against a quadratic Gauss sum.
Retain aliases, even-modulus active frequencies, reduction after factoring the
start index, and the distinction between fixed and adaptive starts. The test
seeks a proved obstruction or a genuinely useful bound, not another invocation
of a full-period estimate. A finite irrationality measure alone must not be
claimed to control every adaptive block.

**Fresh meta-plan pass, bounded to 25 minutes:** the exact arithmetic and
analytic identities still leave the actual phase unestimated. A fresh context
received the failure map and is testing variable rational telescopers that
preserve both the BBP constant and zero initialization. For the chosen sign
D(n)=16*r(n)-r(n+1), the weighted sum is 16*r(0), and the prefix correction is
16^(n+1)*r(0)-r(n+1); r(0)=0 is essential. The proposed discriminating question
is whether variable order permits useful denominator cancellation with a
costed real cylinder margin. Fixed corrections or unrestricted interpolation
alone would repeat earlier failures. No successful cancellation is assumed.

**Extraction outcome:** absolute Gauss completion costs at least L for an
L-term powers-of-four mask at every odd squarefree effective modulus. The
quadratic-character duality proof includes aliases. The nonsquarefree loss,
q=27 counterexample, active even-frequency exceptions, exact replacement error
and modulus reduction remain explicit. A finite irrationality exponent rules
out the stated fixed-start long-block certificate, but not every adaptive
start. Retaining the Gauss chirp exactly returns the original sparse sum.
Parent reconstruction, exact checker replay and visual source inspection
passed. The [extension](m4-transform-phases.md#absolute-gauss-completion-cannot-help-at-odd-squarefree-moduli)
does not claim impossibility of every phase-sensitive estimate.

**Variable-correction outcome:** finite rational interpolation programs an
arbitrary rational orbit block while preserving pi, zero initialization,
simple negative poles in the original four shift orbits and any prescribed
finite asymptotic order. It changes the actual forcing and need not shadow
the original orbit. Even a uniform circular margin at most 1/34 forces the
same exponentially accurate initialized-phase approximation. Old-prime root
counting gives a degree/content occupation bound. The
[assessment](m4-null-gauges.md) retains all domains and missing real estimates.
Parent read/replayed both original exact checkers. The positive-degree
sharpness construction now has a separate degree-zero case.

**Uniform-survival extension, bounded to 10 minutes, completed:** apply the
existing fixed-H theorem uniformly on a proportional forward interval before
root counting. If the denominator degree is o(n), cancelling the first d+1
states into one rational orbit forces combined denominator content and seed
denominator exponent at least 6. For degree at most theta*n the exact cutoff
mass is ((8-theta)_+ +(4-theta)_+)/2. Limits are taken at fixed cutoff first.
The actual n=8,p=19 cancellation supplies a finite countercondition to an
all-index version. Parent reconstruction and the 537,253-comparison checker
passed. The revised root checker uses math.isqrt with unchanged counts;
the original is preserved, together with the explicit sharpness clarification.

**Antisymmetric state, bounded to 15 minutes, completed:** diagonalize the
two-state transform and test whether chi_4 signs yield a prime-average
consumer. Its exact kernel reduces to 8/((z-1)^2+1), with constant 2*pi.
The complete CRT expression retains the actual endpoint numerators, all
prime powers and local division by two. Quadratic Gauss data loses additive
numerator information. The same actual kernel run backward retains the
eigen-sign but has real prefix bounded by 5/(2m), so a directional hypothesis
cannot be dropped. Parent reconstruction and exact checker replay passed.
The [extension](m4-prime-compression.md#the-antisymmetric-sign-does-not-determine-the-real-crt-phase)
does not supply a forward character bound. All three extensions passed
combined independent review with no D/I/Q items. Full reports/checkers, source
pages and hashes were inspected; execution results remain caller evidence.

**Changed cofactor question, bounded to 20 minutes:** lift p*S_n modulo p^2
and retain the regular terms killed by principal-part reduction. Test whether
the actual null/arctangent kernels collapse complete blocks to short Fermat
quotient or finite-logarithm expressions, or retain a full-length endpoint
sum. This is a closure test before any density inference. Even a successful
single-prime lift would leave the entry-sieve and coupled real-phase gap;
finite extra p-adic precision is not presumed to imply V.

**Prime-square outcome:** complete regular blocks really do close. The root
filter reduces them to two finite-log pair evaluations at (1+/-i)/2 and
+/-1/sqrt(2), giving a Fermat quotient of 2. The pole-power correction cancels
the complete regular contribution, yielding an initialized congruence modulo
p^2 and a short complete-endpoint supercongruence. Parent independently
derived the pair evaluations and cancellation, then reconstructed the full
report and replayed both exact checkers. The
[assessment](m4-prime-square-lift.md) retains all four states and p-unit domains.

The endpoint term remains an incomplete finite logarithm; before the first
pole it is exactly the initialized prefix at the remainder index. At p=17,
two endpoints with the same coarse pole/block data give different values.
The parent's exact p=11 test also shows that the same complete-block formula
fails modulo p^3 for A and R; the worker independently reproduced it. No
higher-order claim about D follows. A separate clarification states the
partial root-filter normalization explicitly; complete-block geometric
prefactors are not carried into partial windows. All frozen originals remain.

This is positive arithmetic closure with an unproved real consumer. The
entry sieve can retain any fixed number of additional digits at one prime
at only polynomial cost, so the initialized joint phase still needs a new
estimate. Independent changed-file review found no substantive defect or
blocking question. Its sole improvement made primality explicit at the opening
definition; the fix passed focused follow-up. This is not kernel verification.

**Changed source connection, bounded to 25 minutes:** a fresh context is
testing pi as the first positive zero of the rational-coefficient E-function
sin z. Under missing-word avoidance, dyadic approximation numerators lie in
a proper finite-type language. The test asks whether quantitative E-function
values or simultaneous auxiliary expressions exploit that restriction with
a better cost than the previously rejected generic polynomial/G-function
bounds. It must retain shared arguments, numerator sets, degree/height/error
and source hypotheses; irrationality or transcendence alone is not a bridge.
No finite digit search, generic complexity assumption or successful estimate
is presumed. The parent continues integration and review in parallel.

**Sine-zero outcome:** the actual product over permitted prefixes is within
exp(O(M)) of the old node polynomial at pi. Exact primitive-content removal
leaves log-height M*log q+O(M). Roy's fully explicit theorem applies to the
moving argument i/q, but its degree/height cost is far larger than the
avoidance gain. Fixed-rational E-function value bounds do not cover pi as
a transcendental argument of a zero. Parent source-page inspection, exact
checker replay and manifest verification passed. The
[assessment](m4-language-auxiliaries.md) retains source hypotheses and costs.

**Changed investigations, each bounded to 25 minutes:** one fresh context
tested recursive language auxiliaries that avoid the product cost; another
tested coupled congruences across indices while retaining actual low anchors.
The first derived both tensor and maximal-moment signed sums: substantial
cancellation occurs without using pi's membership. A positive resolvent does
detect membership but has exactly one uncancelled double pole per allowed
prefix. Cyclotomic deduplication still forces degree at least M*sqrt(3Q) in
the stated root-detector class. The parent reconstructed these arguments,
inspected the primary theorem pages and replayed the checker with a matching
receipt, preserving all frozen originals.

The arithmetic investigation produced a positive
[two-anchor reconstruction](m4-prime-square-lift.md#two-anchor-reconstruction-from-many-prime-endpoints).
The parent proposed increasing the endpoint range to remove the floor and
dyadic assumptions; the worker simplified this to primes N<p<=6N and just
the zeroth A/Ahat anchors. Its exact difference lattice has spacing PG/L_N,
with logarithm 3N+o(N), exceeding the natural real height scale. The actual
prefix is therefore uniquely characterized eventually. The parent read the
full report/checker, reconstructed the lcm and valuation/PNT argument, and
replayed an unchanged checker copy: byte-identical receipt, 10,626 A lifts,
53,130 lattice checks, 9,440 coherent-pair identities and 1,405 D lifts.
An actual null-state analogue reconstructs a sequence tending to zero, so
uniqueness alone does not supply V. Independent changed-file review of all six
paths found no D/I/Q items. The reviewer inspected the full reports/checkers,
source theorem images, manifests and replay differences, reconstructing the
arguments independently; executions remain caller evidence. No Lean certificate
or visitation estimate follows from this review.

The prior prime-square checkpoint is local commit `ccb24d0`, with five-path
scope, empty index, unchanged protected sources and necessity inspection
verified. It has no new Lean code and no remote publication. Current paper
integration does not change V/Hpi/T/M4 status.

**Changed consumer test, bounded to 20 minutes:** derive the explicit CRT
class for L_N*S_N from the two-anchor conditions, retaining the full future
forcing sums. Test a forbidden-word count or the finite Fourier minorant
against its actual canonical representative and natural-height interval.
The endpoint is a valid estimate or a precise cost/quantifier obstruction;
neither a random-residue assumption nor averaging over different starting
values is allowed. The null state is a required discriminator. This work
continues while the parent obtains independent integration review.

**CRT consumer outcome:** the [exact formula](m4-crt-phase.md) preserves the
future forcing, canonical CRT carry and residual denominator D with
log D=2N+o(N). It expresses the actual orbit sum through a finite Fourier
correlation. The height interval occupies only exp(-(3-log16)N+o(N)) of
the modulus, so an independent-uniform-residue approximation already fails
at frequency zero. Taking absolute values term by term costs at least J.
Even after combining the J terms, an explicit alternative grid seed gives
a certificate at least (1-o(1))J for J<=(2/log16-eta)N, fixed eta>0.
This bounds the certificate, not the actual initialized sum. Longer windows
and signed estimates remain open. Parent full-report reconstruction and
unchanged checker replay passed with an identical receipt; finite synthetic
shadow checks are not measurements of pi's phases.

**Changed arithmetic question, bounded to 20 minutes:** the parent derived
a divided-binomial identity that may remove the square restriction even when
the two raw terms have p-power poles. The worker independently reconstructed
it and established the [unrestricted difference](m4-prime-square-lift.md#unrestricted-differences-and-multiplicative-indices)
for every k>=1 and p>=7. Complete regular terms cancel the pole correction
after subtraction. The integral restatement scales both terms and modulus;
it does not silently treat nonintegral terms as residues. Twisted normalized
prime-power prefixes are Cauchy in Z_p for p>=11, with the p=7 distinction
retained. The full mixed-prime four-corner relation has valuation at least
two at both primes; dropping its middle terms fails in an exact p=11,q=13
example. The null state has all these properties while tending to zero in
the real absolute value, so no real visitation inference follows.

The parent read the full unrestricted report/checker, reconstructed its
arguments and replayed an unchanged copy in a separate directory. It exited
0 with a byte-identical receipt: 3,072 raw and 3,072 scaled lifts, 2,817
nonintegral raw pairs, 200 mixed differences, 60 tower steps and 468 longer
precision diagnostics, with 140 exact/modular overlap checks. All frozen
hashes remained unchanged. Finite tests suggest additional powers of k in
the valuation; these remain explicitly unproved. Separate adversarial review
of the six-path integration completed with no D/I/Q items. The reviewer
independently reconstructed both arguments, inspected both full reports and
checker sources, and verified all scoped hashes and replay equivalence.
Executions remain caller evidence. No Lean declaration is introduced.

The initialized-reconstruction/language checkpoint is local commit `2130035`;
its exact six paths, empty index and protected-source preservation were verified.
No push or PR occurred. The current two-report integration is against that
baseline and does not alter V/Hpi/T/M4 status.

**Next investigations, each bounded to 20 minutes:** the arithmetic worker
tests a general proof or counterexample for the stronger k-dependent
precision, including nontrivial unit cofactors. A separate consumer worker
tests signed mixed-index differences against word restrictions while retaining
all intermediate states, denominator growth and the actual null-state
comparison. A successful p-adic refinement is not assumed to supply the real
consumer. The parent continues independent reconstruction and review; these
cycle bounds are reassessment points, not an end to authorized M4 research.

## 2026-11-27 UTC — boundary precision and positive certificates

The preceding CRT/unrestricted-lift checkpoint is local commit `8a50efa`.
Its exact six-path scope, empty index and unchanged protected/unrelated files
were verified; no push or PR occurred. The following work keeps V/M4 open.

**Arithmetic outcome:** [canonical interpolation](m4-prime-defect-boundary.md)
first reduced the stronger all-k valuations to two exact boundary zeros.
The analytic forcing alone did not establish them: an essential homogeneous
term retained the actual initialization. A changed 20-minute cycle identified
the boundaries through Newton generating functions and normalized Coleman
primitives. The constant comparison uses the ordinary-disc identity principle;
the derivative comparison derives single-annulus uniqueness from Besser's
finite horizontal-kernel construction and natural fiber-functor transport.
The sourced de Jeu reflection identity then gives the required derivative
zero. This proves the stronger precision at paper level, including arbitrary
unit cofactors and the explicit p=7 integrality limitation. The parent
reconstructed the argument, inspected source pages, and replayed the exact
checks. Independent central-argument review found no D/I/Q items. Production
integration and kernel checking are distinct; no Lean result was added.

**Mixed-consumer outcome:** the [complete-corner calculation](m4-crt-phase.md#full-mixed-differences-retain-the-largest-denominator)
proves an exact dyadic denominator for adjacent period-cancelling differences.
Their real smallness is insufficient relative to the available prime-square
lattice, even after reduction. Separate word-cell relaxation likewise leaves
scalar lattice points and drops the coupling. The parent reconstructed the
paper proof and replayed the checker with an identical receipt. This limits
the specified constructions, not every use of the stronger precision.

**Direct avoidance cycles, each bounded to 20 minutes:** a determinant
certificate made the missing numerator estimate explicit. A rational rotation
improved its threshold, and elementary order filtering extended actual
denominator survival to m=o(sqrt N). Prime-length blocks retain an uncontrolled
floor-dependent collision sum. Testing an equidistributed model then exposed
a geometric limitation for narrow gaps, motivating a circle kernel instead.
The [circle-product calculation](m4-positive-certificates.md) proves a fully
finite avoidance bound with explicit smoothing and diagonal errors. Uniform
grids pass, but a weakly uniform configuration with one very close pair fails,
even within a BBP-sized scalar denominator cap. This additional anti-clustering
requirement makes the product no demonstrated improvement over the earlier
finite-frequency consumer. Actual denominator costs double; the actual A
numerator estimate remains absent. Parent unchanged-copy replays for all three
packets exited 0 with identical receipts and preserved frozen originals.
Finite synthetic checks are not evidence of pi's distribution.

**Next changed questions, 20 minutes each before reassessment:** test the new
prime-power precision on actual canonical gaps at structured indices, retaining
all floors; independently test a bounded Bernoulli circle energy, which removes
the exceptional-pair instability and lowers the denominator exponent. The
endpoint is an actual new estimate or a precise reason it returns to the
missing signed information. The parent is integrating the completed work for
required changed-file review while these investigations continue. No cycle
limit, partial proof, review or commit is treated as ending the authorized M4
effort. B4 still needs arbitrarily late visits and P3 still needs interval visits.

The complete seven-path integration subsequently passed independent review
with no D/I/Q items. The reviewer reconstructed the boundary comparison,
mixed-consumer costs and both positive-certificate arguments, verified every
scoped hash, and inspected the full new reports/checkers and receipts. All
executions remain caller evidence. Documentation (93 tracked Markdown files)
and working/staged whitespace checks exited 0. The exact review packet and
limitations are retained in the [review record](agy-reports/m4-continuation-review.md).
Newer precision-consumer and Bernoulli-consumer work is outside that review.

**Continuation after local commit `dd44760`:**
the seven-path boundary/product checkpoint was committed and inspected with
an empty index, unchanged protected/unrelated files and no remote publication.
Research continues. The following immutable scratch packets supplied the next
integration:

- `/tmp/pi-m4-precision-consumer-20261127/`: normalized divided differences,
  a balanced four-edge valuation, exact single-prime coefficient cost, and
  actual prime-power canonical-gap valuations. The latter put the tested
  prime entirely in the circle-product denominator; the null state retains
  the same pattern while clustering. Parent full report/checker reconstruction
  and replay passed; receipts differ only in UTC timestamp.
- `/tmp/pi-m4-bernoulli-consumer-20261127/`: the nonsingular energy has sharp
  avoidance gap `(b-a)^3/6` and an exact sorted-numerator formula. Its actual
  quadratic pole survives on windows `m=o(N/log N)` without an order
  hypothesis. Transfer, complete-seed reciprocity and a localized tent test
  retain the missing ranks/carries. Parent reconstruction, primary-source-page
  inspection and unchanged-copy replay passed with an identical receipt.
- `/tmp/pi-m4-short-sums-20261127/`: a parent source-contract/critic pass
  found concrete failures in direct applications of Bourgain's almost-subgroup
  bound and the Fouvry–Kowalski–Michel multiplicative sliding-sum bound.
  Full-modulus nonconcentration already fails by cardinality for the tested
  short segments; freezing the actual forcing by raw small-error control
  allows only logarithmic windows. Single-prime or complete-orbit replacement
  loses the actual coupled phase. Primary PDFs and inspected pages are retained.

The repeated return to actual canonical selection triggered a meta-plan reset.
The fresh-context Archimedes investigation retained the isolated algebraic
branch and good derivative conditioning, but its degree/amplification cost
still defeated bare integral separation. The source's full Galois average
does not select that coherent branch. The shared-multiplier investigation
escaped the single-prime coefficient-height barrier, but proved a pole on
the actual infinite subsequence k=13^r for both A and D. Further odd linear
congruences alone leave the dyadic carry image unchanged. More stencil
refinement is suspended unless it identifies a real consumer. These frozen
packets are `/tmp/pi-m4-fresh-phase-20261127/` and
`/tmp/pi-m4-balanced-multiprime-20261127/` (authoritative manifest v2).
Parent reconstruction, source-page inspection and unchanged-copy replays
passed, preserving originals; the multiprime receipt differs only in UTC.

**Next changed questions, 20 minutes each:** exploit the actual coefficient's
positive moment density in an avoidance-dependent signed inequality, testing
nearby rational-period forcing before crediting positivity; independently test
whether the nonzero real period's height contribution can give the missing
Bernoulli numerator lower bound. The latter must distinguish full Galois
averages and ordinary height from the actual circle state, and challenge any
candidate on D and rational-period models. The endpoint is a new estimate or
an exact scaling/countermodel failure, followed by another changed inquiry.
No numerical pi/actual fractional-state search is proposed. The completed
five packets were integrated into four existing mathematical notes plus the
existing plan, log, handoff and review record. Separate changed-file review
is complete with no D/I/Q items; it reconstructed the arguments and verified
all scoped hashes. A requested supplemental source-definition inspection
confirmed the contract without a correction. Documentation and whitespace
checks passed. None supplies V, and no new Lean result is claimed. The
positive-kernel and height investigations remain outside that reviewed scope.

**Continuation after local commit `c9f4fb7`:**
the eight-path consumer checkpoint was committed and inspected with an empty
index and unchanged protected/unrelated files; no remote publication occurred.
The completed positive-kernel packet is
`/tmp/pi-m4-positive-kernel-20261127/`. Its exact integer-filter norm prevents
the tested positivity certificate from reaching arbitrary small holes. An
eight-pole family preserves all moment/Hankel signs with uniform relative
bounds, but has rational periods and eventually avoiding orbits; its fixed
members lose A's denominator rate. The completed height packet is
`/tmp/pi-m4-adelic-height-20261127/`: actual D has rate 8, A has rate 6, and
canonical reduction removes A's extra raw-height contribution. A precise
elliptic Bernoulli connection retains an essential selected-place weight,
with a torsion countertest. Parent full reconstruction, source-page inspection
and unchanged-copy replays passed; positive-kernel receipt differs only in UTC,
height receipt is identical. The positive replay harness first expected a
file instead of stdout JSON; corrected capture and one repeat retained exit 0.
Originals are preserved. These are paper results, not V or Lean proofs.

**Changed questions, each bounded to 20 minutes before reassessment:** classify
whether a single rational-period forcing in the fixed finite simple eighth-grid
pole family can have forward denominator rate 6, using the already proved
eight-pole logarithmic kernel rather than repeating its derivation; separately,
test whether full multi-index BBP forcing yields the simultaneous support
hypotheses of a precise missing-digit/fractal Fourier theorem. A singleton CRT
class has flat Fourier modulus, so naive sparse-support uncertainty is already
excluded. Any surviving proposal must retain the actual carry and selected
class. Endpoint outcomes are a new estimate or a precise discriminating failure,
followed by a changed inquiry. More generic positivity or unweighted Galois
averaging is suspended. The classification cycle completed in
`/tmp/pi-m4-rational-period-classification-20261127/`: every rational-period
member of the specified fixed pole family is lambda*D plus a rational
coboundary, with denominator rate 0 or 8. The older positive thirteen-pole
model is exactly the rate-8 alternative. Parent reconstruction and unchanged-copy
replay passed, differing only in UTC and preserving originals. Committed input
copies separate the pre-existing Baker/kernel and F model from concurrent draft
integration. This answers the scoped countermodel question but supplies no
missing-word implication. Further same-family classification is suspended;
off-grid classification was not launched without a real consumer. The parent
integrated the three completed packets while the distinct fractal Fourier
investigation continued. Independent changed-file review completed with no
D/I/Q items, reconstructing the arguments and checking every scoped hash.
Requested supplemental source pages confirmed discrepancy nonnegativity and
the Tate retraction without a correction. Documentation and whitespace checks
passed. The newer fractal and word-carry work remains outside that review;
M4 remains open.

**Reviewed continuation after local commit `16f8735`:**
the eight-path positivity/height/classification checkpoint passed its separate
review, exact staged checks and post-commit necessity/preservation inspection.
Only task-owned documentation was committed; no remote publication occurred.
The frozen `/tmp/pi-m4-fractal-phase-20261127/` packet proves that exact forced
hole propagation remains a partial permutation even with transition phases;
its operator norm is 1 whenever any entry survives. A genuine two-coordinate
classical Cantor lift still supplies no position/Fourier-localized wavefunction.
The parent reconstructed the complete report/checker/critic, visually inspected
the primary theorem/matrix pages and replayed an unchanged copy: exit 0,
identical receipt and originals preserved. This connection is suspended at the
missing amplitude/frequency constraint, not treated as a visitation result.

The next 20-minute cycle worked directly on word-dependent carry constraints
for the exact rational forcing. Its initial uniform-polynomial test exposed a
denominator/window cost. A parent-proposed strengthening constructs an entire
translated two-symbol Cantor set inside every relaxed avoidance entry set;
the worker reconstructed a uniform logarithmic-potential bound that defeats
this certificate for all degrees and windows. The construction keeps actual
future forcing and can keep an admissible past-language state, but relaxes the
exact initialized phase. A discrete denominator-grid restriction is outside
the conclusion and must not be silently discarded. The frozen packet is
`/tmp/pi-m4-word-carry-20261127/`. The parent read its complete report/checker,
input contract and separate criticism and replayed an unchanged copy: exit 0,
receipt differing only in UTC, originals preserved. No actual A phase was
evaluated. Separate integration review found two narrow definition/domain
defects and one coefficient-clearing improvement. All three were repaired and
accepted by focused review; the main operator and Cantor conclusions are
unchanged. Full captures and dispositions are in the continuation review
record. No Lean theorem or V acceptance follows from this paper checkpoint.

**Next changed question, 20 minutes before reassessment:** test rational affine
invariance of late base-16 orbit density and its exact transfer to arbitrary
rational entries under the same future A-forcing. If valid, this could broaden
the consumer while preserving the ultimate V contract. Finite rational-grid
averages can look uniform even for an irrational nowhere-dense orbit, so the
test must retain the distinction between one globally visiting rational entry
and changing entries for finite targets/windows. The active scratch path is
`/tmp/pi-m4-rational-entry-20261127/`. Further support-only or uniform real-entry
polynomial refinement is suspended. This checkpoint does not stop M4 research.

**Next continuation, after local commit `c9a9c46`:** the six-path propagation
and word-carry checkpoint passed review, focused corrections, documentation
and working/staged whitespace checks. Exact post-commit scope, empty index,
17 protected and 11 unrelated file hashes were verified. Nothing was pushed.
The rational-entry worker then delivered its immutable packet. The parent
read the full argument, input contract, critic and checker, reconstructed the
finite-cover and omega-limit proofs, and replayed an unchanged copy: exit 0,
5,369 checks, identical receipt, original hashes preserved. It establishes a
paper equivalence with V for any fixed rational entry, and for a fixed finite
family with universally visiting union. Independent integration review completed
with no defects, requested improvements or additional evidence gaps. Full scope,
capture and evidence limits are retained in the continuation review record;
there is no new Lean theorem or proof of the consumer premise.

Growing-grid averaging is suspended: even one rational seed per target with
infinitely many visits exists for every base phase, including an explicit
irrational nondense model. The quantifier failure is therefore stronger than
merely switching seeds at each finite horizon. **Two distinct 20-minute
reassessment questions** now test whether the new freedom is usable: a fixed
rational entry's compatibility with the prime-square/stronger defect identities,
and the quantitative missing-hole cost of rational translation versus analytic
variation of the exact tail across entry times. Scratch paths are
`/tmp/pi-m4-entry-precision-20261127/` and
`/tmp/pi-m4-entry-entropy-20261127/`. Neither cycle assumes a new visitation
estimate or treats a finite changing family as the fixed-family consumer.

**After local commit `358c940`:** the five-path rational-entry equivalence
checkpoint passed independent review with no findings, documentation and
working/staged whitespace checks, exact scope and post-commit necessity and
preservation inspection. No publication occurred. Both follow-up packets are
now complete and parent-reconstructed. Independent integration review found one
production quantifier defect: unbounded k does not imply unbounded v_p(k).
The repaired condition requires all sufficiently large admissible k; focused
review accepted it. No additional findings remain. The continuation review
record retains the full cycle and evidence limits.

`/tmp/pi-m4-entry-precision-20261127/` classifies the exact rational shift of
the prime defect. Its main limitation is deliberately about raw representatives:
integer shifts already preserve every canonical value while destroying raw
precision. Finite precision can be restored by dyadic gauges; a nonzero repair
with h<=N and normalized height B requires M<=B*q*16^N. This closes one
specific height-budget question, not the canonical carry problem. Parent
inspection corrected a signed-floor linearity sentence and clarified normalized
entry bounds in immutable v2; the parent-proposed budget corollary was worker
reconstructed in v3. The original checker replay passed 1,507 checks, exit 0,
identical receipt, all originals preserved; no code changed for those supplements.

`/tmp/pi-m4-entry-entropy-20261127/` gives exact rational-offset count
L_N=ord_(q_N)(16), log L_N<=2N+o(N), an explicit transported-hole guarantee,
dimension invariance, and differentiated tail bounds. It proves variable-N
diagonal visits but separates them from the fixed-family consumer with a
positive rational coboundary. The particular hole guarantee is below the
sampling mesh and finite-time tail error; its changing address is uncontrolled.
The parent corrected the rational-entry quantifier and the checker's floating
square-root endpoint in immutable v2. Unchanged-copy v2 replay passed 3,791
checks, exit 0, UTC-only receipt difference, originals preserved. No actual
initialized A fractional state or pi digit was searched.

**Meta-plan reset, 20 minutes before reassessment:** both cycles again require
an actual phase estimate. A fresh-context worker now tests positive Gaussian
quadrature and an exact-prefix consumer in
`/tmp/pi-m4-fresh-mechanism-reset-20261127/`. A visit inside a model's segment
of exact A agreement would transfer directly, unlike a target-dependent change
of rational entry. Whether the spectral model provides an independent estimate
within that segment is the discriminating question. The finite-family and
post-prefix limits must remain explicit. This is new discovery within M4,
not authorization to install tools or formalize a missing premise.

**After local commit `ae15209`:** the six-path entry-cost checkpoint passed
independent review, D1's focused quantifier repair, documentation and staged
checks, exact post-commit scope/necessity and preservation inspection. No push
or PR occurred. The fresh quadrature packet is complete. An order-m positive
Gaussian model has rational moments, exact agreement through 2m-1 and a
rational full period. Its comparison remains exponentially small through
floor(11m/4), but no early-window visit estimate was found. Fixed-model
nondensity does not refute the valid growing-order consumer. The parent read
and reconstructed the complete packet, inspected Allen et al.'s rendered
Theorem 1 pages 65–66, and replayed 444 exact checks: exit 0, identical JSON,
originals preserved. This resolves the worker's source-image evidence limit.

A subsequent 20-minute countertest in
`/tmp/pi-m4-analytic-moment-model-20261127/` reconstructed a parent-proposed
analytic relative perturbation of the actual positive measure. Orthogonality
makes each modified moment a finite rational sum while rational greedy choices
encode any period in a small interval. It yields an irrational nondense period,
any prescribed exact prefix, all positive moment comparisons, and the same
15/64 and 1/64 asymptotic constants. Finite rational polynomial perturbations
still have period a+b*pi; the infinite construction loses rational-function
forcing and denominator bounds. The parent read and reconstructed the full
argument/critic/checker, then replayed 150 checks: exit 0, identical JSON,
originals preserved. Infinite coefficient choices are paper mathematics.
Independent integration review of both packets is complete with no D/I/Q
findings. The reviewer verified the exact five-path diff and 34 evidence
hashes, reconstructed both arguments and inspected the primary theorem images.
The [continuation review](agy-reports/m4-continuation-review.md#gaussian-prefixes-and-irrational-analytic-moment-models--2026-11-27-utc)
owns the full-response receipt and evidence limits. No V or Lean result follows.

**Next changed question, 20 minutes before reassessment:** test the uncontrolled
height explicitly in `/tmp/pi-m4-controlled-moment-model-20261127/`. A standard
Jacobi basis with integer polynomial coefficients may permit rational grids
whose common denominator gives upper exponent 6+eta, for each eta>0. Required
checks include nonvanishing period coefficients, a fixed analytic neighborhood,
greedy selection on discrete grids, natural odd-lcm inclusion and all changed
scope limits. An upper bound near 6 is not exact rate 6, nor the strong prime
defect information. This inquiry tests a missing hypothesis of the countermodel;
it does not assume an early-window visit or stop M4 research.

**Controlled-height outcome and changed question — 2026-11-27 UTC:** the
frozen Jacobi packet establishes the claimed upper ceiling and a lower
liminf bound 4, leaving exact rate 6 and strong prime defects absent. Parent
reconstruction and official DLMF hypothesis inspection passed; unchanged-copy
replay passed 42,823 finite checks, exit 0, identical JSON and preserved
originals. This remains paper mathematics pending independent integration
review. The previous Gaussian/analytic checkpoint is local commit `9a4b896`;
its exact five-path scope, empty index and preservation/necessity checks passed.

**Two distinct 20-minute tests before reassessment:**
`/tmp/pi-m4-exact-envelope-model-20261127/` tests direct moment grids against
the natural odd clearing denominator, using triangular orthogonality rather
than bounding coefficient denominators. The endpoint is a proof or obstruction
to exact eventual denominator equality while retaining an analytic positive
model with a nondense irrational period. Separately,
`/tmp/pi-m4-congruence-moment-model-20261127/` tests whether stagewise CRT
can retain the reviewed strong prime defects for A/H while fixing D, using
their common clearing envelope. Its endpoint is exact compatibility and
height/noncancellation bounds, with analytic existence supplied only if the
first worker proves the required grid estimates. These are unproved parent
proposals; neither assumes that a finite check realizes an infinite model.
Success would isolate the exact rational-function forcing more sharply;
failure could identify a genuinely restrictive arithmetic condition. M4
research continues with its unchanged unconditional target.

**Additional parent test, 20 minutes before reassessment:** the CRT worker
has identified a scope distinction: its construction concerns the displayed
pointwise prime-defect laws, not the common analytic interpolants or all
normalized divided differences. The parent will derive the necessary Newton
difference congruences from the already reviewed Taylor bounds and compare
their combined modulus at indices n+1 having many prime factors against the
moment-grid freedom. The endpoint is an explicit cost inequality or its
failure, not a claim that excess modulus disproves existence. This tests
whether the stronger analytic family escapes the inexpensive pointwise CRT
construction; no real visitation consequence is assumed.

**Outcomes of these tests — 2026-11-27 UTC:** direct moment-grid selection
succeeds, with eventual reduced denominator exactly L_A,n, while retaining
an irrational nondense period and the previous analytic properties. The
separate arithmetic packet proves a triangular CRT and two-residue sieve on
the common A/H envelope. Parent reconstruction of the universal-history
interface supplies the combined model with the specified pointwise laws,
unchanged D and denominator rate 6 for both companions. Full Taylor/Newton,
normalized divided differences and original incomplete-block compression are
explicitly excluded. Unchanged-copy replays passed 28,412 analytic and 10,757
arithmetic checks, exit 0; receipts are identical except the latter's UTC,
and frozen originals are preserved. These are finite diagnostics, not an
instantiation of the infinite model. Two reads initially used the wrong
contract/critic filename; corrected reads completed, with no mutation or
mathematical failure.

The parent cost packet `/tmp/pi-m4-analytic-congruence-cost-20261127/`
derives necessary Newton precision b_p(k)+v_p(k!), between k-floor(log_p k)
and k+1. The simultaneous modulus has log M_n/n tending to infinity along
primorial n+1, exceeding the uniform exponential moment intervals. This
invalidates that universal counting guarantee, not existence of aligned or
correlated choices. It supplies no canonical numerator estimate. Two exact
checker runs passed 24,118 finite checks, exit 0, identical receipts. Parent
self-criticism and worker agreement are not independent review. The subsequent
combined independent review is complete with no D/I/Q findings; it verified
the exact six-path diff and 57 evidence hashes and reconstructed the critical
analytic/arithmetic interfaces. The continuation review record owns its full
response and evidence limits. No V or Lean theorem follows.

**Fresh-context recovery, 20 minutes before reassessment:**
`/tmp/pi-m4-analytic-family-consumer-20261127/` seeks an actual V consumer
from the full analytic family and finite rational forcing, or a precise
neighboring-theorem connection with its first missing bridge. The worker must
check the unchanged D model, actual earlier-prefix dependence and integer
floors, and distinguish identifying A from proving a real visit. This changes
the source of ideas after the comparison-model sequence. No broad literature
campaign, source-free independence claim, digit enumeration or premature
formalization is authorized by this inquiry. Research continues.

**Arithmetic checkpoint and fresh-context outcome — 2026-11-27 UTC:** local
commit `868a092c7797065f90b5a73d5d0222d69d0f7a88` contains the reviewed six-path
comparison-model/analytic-cost assessment. Exact scope, empty index, preserved
protected/unrelated files and post-commit necessity were verified. No push or
PR occurred. The fresh consumer packet gives a paper classification instead
of a visit: continuous initialized p=17 defect selects span_Q{A,D} in the
fixed unshifted eight-pole space; the BBP asymptotic normalization selects A.
It proves no reconstruction of a distinct vector from an avoiding actual
carry sequence. More same-family classification is suspended without that
independent consumer.

The worker and parent inspected Brumer's original Theorem 1 on the publisher's
p.121 image, including its definitions and hypotheses; the full proof was
not accessed. Parent reconstruction covered the p-adic logarithm kernel,
generic constant-boundary extension, initialization and asymptotic restrictions.
Unchanged-copy replay passed 825 exact field/rank/pole checks, exit 0,
identical receipt and preserved originals. Brumer and Coleman arguments are
paper inputs, not certified by those checks. The production clarification
retains the earlier fact that integer seed changes preserve canonical orbit
values even while destroying raw p-adic continuity. Independent integration
review is complete: no defects or new improvements; Q1–Q2 remain open, and
Q3's generic boundary extension passed paper reconstruction. All five scoped
file hashes and 28 evidence hashes matched. The continuation review record
owns the complete response and limits; no V or Lean theorem follows.

**Changed question, 20 minutes before reassessment:**
`/tmp/pi-m4-adelic-rationality-test-20261127/` tests one precise adelic
rationality or analytic-continuation criterion for the missing reconstruction
step. The first check is whether there is a common function at every place;
the known Phi_p are prime-dependent. The source contract must retain all
coefficient, radius, domain and integrality hypotheses, and test the actual
logarithmic A generating function as a sanity case. No finite-state language
is assumed to imply analytic continuation, and no generic Dwork-congruence
converse is assumed. The endpoint is a concrete applicable bridge or a
precise failed hypothesis that changes the next decision. M4 continues.

**One-prime checkpoint and changed tests — 2026-11-27 UTC:** local commit
`9a9a0403686f235a1c862cd4743a61b12835e3e4` records the reviewed classification.
Exact five-path scope, empty index, preservation and necessity checks passed;
no push or PR occurred. The adelic source packet is frozen. Dwork's actual
integral-coefficient/one-prime meromorphic-entire criterion has been inspected
on original printed pp.41–42. The actual moment series is nonrational with
radius 1 at every place and infinitely many denominator primes; it cannot
be the rationality target. The canonical carry series has the right integrality
and value pi at 1/16, but its exact defect identity retains the fractional-state
series. An avoidance-dependent continuation theorem for that same carry
series is missing. Parent reconstruction and primary-image inspection passed;
unchanged-copy replay passed 1,181 exact checks, exit 0, identical receipt and
preserved originals. Independent integration review remains pending.

**Two new 20-minute bounds:**
`/tmp/pi-m4-fixed-prime-analytic-model-20261127/` tests whether the moment
model can retain the full Taylor valuation class at p=17, rather than only
pointwise laws. The proposed Newton precision k+2+v_p(k!) would produce an
analytic perturbation on |x|_p<p; the total interpolant retains only the
common actual radius. A limited finite-prime extension requires its explicit
cost inequality. Exact coefficients, original finite-pole forcing and the
all-prime analytic family are not being assumed preserved.

Separately `/tmp/pi-m4-global-analytic-lattice-20261127/` tests the finite-block
lattice determinant and total cost of all those stronger constraints. A small
average cost might survive even though rare individual stages exceed the
greedy budget. Its endpoint includes a test of the critical logical gap:
positive lattice volume alone need not give fixed-target covering or a
nonzero compatible infinite model. The parent supplied a triangular toy
system with large finite volume but only the zero infinite solution for
verification. No volume count will be reported as visitation or a completed
countermodel. These are changed discriminating questions within M4.

**Fixed-prime and global-lattice outcomes — 2026-11-27 UTC:** both packets are
frozen. The fixed-prime construction succeeds under the explicit budget
sum_(p in P)log(p)/(p-1)<4+log(15/128), including P={17} and {13,17}.
It retains the Taylor valuation class at those primes by a sufficient Newton
condition, while keeping the earlier pointwise laws, both denominator rates
6 and an irrational nondense period. The perturbation's analytic disk p is
distinguished from the total interpolant's smaller guaranteed disk. Exact
coefficients, finite-pole forcing and an all-prime extension remain excluded.
Parent reconstruction and unchanged-copy replay passed, including 1,202
synthetic CRT stages and 16 nonintegral raw-side cases, exit 0, UTC-only
receipt difference and preserved originals.

The global calculation proves log index=(C/2)N^2+O(N log^2 N), C<1, and
the exact orthogonal-coordinate determinant product L_n*h_n. The resulting
positive normalized volume gives finite nonzero vectors. The supplied toy
has the same qualitative volume surplus but only the zero infinite bounded
solution, with every finite weighted period projection tending to zero.
Thus a prescribed period covering estimate, not more volume, is the next
missing condition. Parent reconstruction and unchanged-copy replay passed
12,890 finite checks, exit 0, identical receipt and preserved originals.
No infinite all-prime model or actual visitation conclusion is inferred.
Independent combined integration review of these and the Dwork source test
is complete: no defects or new improvements, with Q1–Q3 retaining carry
continuation, actual period covering and the omitted global denominator sieve.
All six production hashes and 41 evidence hashes matched; the continuation
review record owns the full response and limits. Universal results remain
paper mathematics.

**Changed 20-minute questions:**
`/tmp/pi-m4-actual-period-projection-20261127/` tests an explicit projection
or dual estimate using the actual lattice's off-diagonal coefficients. Its
endpoint must distinguish covering from the toy's collapse, rather than
repeat the determinant calculation or rename the missing estimate.
`/tmp/pi-m4-canonical-carry-reset-20261127/` separately works backward from
actual avoidance to a restriction on canonical carries usable with the
rational forcing equation. It must retain floors and reject the already
unsupported finite-language-to-rational-path implication. Each worker owns
scratch only and a separate criticism pass; the parent owns integration.
The user received a status update distinguishing these diagnostic advances
from a promising proof mechanism. V/M4 remain open; research continues.

**Reviewed checkpoint and changed discovery source — 2026-11-27 UTC:** local
commit `088fa55b625b2c58d3bc5b8bd3017a359601e19e` contains the six-path
analytic-class/rationality/lattice assessment. Exact scope, empty index,
preservation and necessity checks passed; nothing was pushed. The canonical
carry worker has frozen a new transition/sentinel calculation, pending parent
integration and independent review. It explicitly does not turn rare borrow
endings into rare whole corrections or a visitation theorem.

**Next distinct inquiry, 20 minutes before reassessment:**
`/tmp/pi-m4-two-series-coupling-20261127/` tests the actual identity
pi/4=arctan(1/2)+arctan(1/3), with component series using scales 4 and 9.
The endpoint is an exact initialized coupling and one discriminating test of
whether it constrains a hypothetical proper base-16 omega set. A base-9 series
does not by itself make that set invariant under multiplication by 9; neither
component's density is assumed. A mere scalar period reexpression will be
reported as such. This changes the source of ideas toward unused exact
identities; it is not evidence yet that the approach is promising. The parent
continues checking the preceding frozen results while this scratch inquiry runs.

**Borrow and actual-dual checkpoint — 2026-11-27 UTC:** the two preceding
packets are frozen and reconstructed. The actual-dual packet proves optimized
box errors Theta(L_(p-1)/p^6) for the first Newton row and
Theta(L_(n+1)/n^4) for an adjacent-prefix stencil. The exact orthogonal
Wronskian gives the nonzero determinant needed for the lower bounds; a natural
choice of period multiplier alone would not suffice. Primitive witnesses
exclude hidden row rescaling in the stated cases. These two estimates are
suspended, while general combinations and feasible-subset bounds remain open.
Unchanged-copy replay passed 613 symbolic/rational checks, exit 0, identical
receipt and preserved originals.

The canonical packet proves the exact borrow transition table, O(N/log N)
carry-16 count and a right-sentinel word transfer. Its lacunary changed-phase
example retains actual future forcing but shows that the full correction can
have upper density one. It is not the selected initialized pi orbit. The
word-indicator relation is Hadamard, not ordinary polynomial multiplication;
canonical range inequalities remain explicit. Unchanged-copy replay passed
31,883 synthetic checks, exit 0, identical receipt and preserved originals.
A read initially used an incorrect contract filename; the corrected full read
completed. No actual phase or pi digit was computed by either checker.
Independent integration review is complete: no defects or new improvements;
Q1–Q2 retain the word-indicator and full-lattice gaps. All six production
hashes and 25 evidence hashes matched; the continuation review record owns
the full response and evidence limits. These paper diagnostics clarify failed
bridges but do not move the V proof frontier; M4 research continues.

**Borrow/dual checkpoint and growing-support test — 2026-11-27 UTC:** local
commit `f7a2d22080a80f5dbd08068cc119079924005257` contains the reviewed
six-path result. Exact scope, empty index, preservation and necessity checks
passed; nothing was pushed. The two-series worker is completing its separate
criticism; no result from that packet is yet accepted here.

**Changed test, 20 minutes before reassessment:**
`/tmp/pi-m4-growing-stencil-test-20261127/` allows the finite-difference
order d to grow with the cutoff m=n+d, testing
L_m*sum_(j<=d)(-1)^(d-j)*binom(d,j)*V_(n+j). Its residual kernel gains
(1-t)^d, so the fixed-order asymptotics cannot decide it. The worker must
compare that possible exponential cancellation with denominator cost, optimize
period alignment uniformly including interior concentration points, and account
for the actual integer content before treating the row as primitive. A raw
large norm alone would not rule out division by a large common factor.
General Newton-row combinations and feasible-subset norms remain separate.
This is a distinct scale test, not a retry of the fixed adjacent stencil.

**Separate content question, 15 minutes before reassessment:** the parent
proposed a construction for the d=0 prefix functional's integer content on
the full finite Newton lattice with fixed zero prefix K. The candidate is
log(content(a_m))=O_K(log^2(m+2)) for m>=K, despite the rare large newest-stage
moduli. For each active prime, a scaled integral polynomial defect would
vanish on the required initial indices and selected low p-chain nodes;
its finite differences supply the strong Newton bounds, and distinct remaining
chain valuations would prevent cancellation. Multiplication by a p-unit can
then clear other primes' finite rows. The worker in
`/tmp/pi-m4-prefix-content-test-20261127/` must verify or refute this construction,
including integrality, zero initialization, threshold choices and uniform
valuation bounds. It is not yet a proved content result or a bounded-box
witness. The d>=1 growing-stencil packet remains separately scoped.

**Fresh-context positive-consumer reset, 20 minutes before reassessment:**
`/tmp/pi-m4-positive-consumer-reset-20261127/` starts from the exact V contract
and a compact failure map. The source of ideas changes again: seek one actual
visitation consumer using unused exact forcing structure, or one precise
neighboring-theorem bridge with a discriminating check. Further finite-pole
classification, generic countermodels, full-entropy reformulations and marginal
density claims are not sufficient endpoints. The worker must identify the
first unsupported implication and why the relevant comparison models lack
its proposed input, then criticize the candidate separately.

This checkpoint distinguishes learning from proof progress. The preceding
tests have clarified failures of carry, radix and lattice shortcuts; none has
yet supplied a surviving positive argument for V. Their negative conclusions
do not establish impossibility. The fresh pass and the ongoing content check
continue within the same authorized M4 objective, with no promise of a proof.

**Three completed paper tests — 2026-11-27 UTC:** the two-series packet derives
the exact native and common-base recurrences. It identifies the actual integer
carry residue lost by marginal-circle shortcuts and gives a Baire countertest
to dense-independent-marginals implying a dense sum. The full native trajectory
still reconstructs its carries; the pointwise lift grid is not an alternative
actual trajectory. Parent reconstruction and unchanged-copy replay passed
2,078 exact checks, exit 0, UTC-only receipt difference, originals preserved.

The growing-stencil packet proves actual content divides the positive order,
then uses three-coordinate separation and uniform beta concentration to handle
all orders and all endpoint/interior regimes. The primitive optimized error
retains exponential rate at least 4-log2. Parent reconstruction and unchanged-
copy replay passed 16,660 checks, exit 0, identical receipt and preserved
originals, including genuine nonprimitive finite examples. The whole positive-
order binomial family is now suspended for that full-box certificate.

The parent-generated single-prefix candidate survived separate worker
verification: its finite-lattice content has log size O_K(log^2(m+2)).
The p-local polynomial construction covers both chain regimes and other-prime
clearing. A proposed universal lower bound omitted a free bottom chain state;
it was withdrawn and an exact counterexample retained. No witness-height bound
is claimed. Parent combination with the earlier raw prefix-tail/determinant
norm gives primitive zero-order logarithmic error rate 4. Unchanged-copy replay
passed 134 synthetic cases and 32,679 checks, exit 0, UTC-only receipt difference
and preserved originals. Independent combined integration review is complete:
no unresolved defects or required improvements; Q1–Q2 retain the bounded
feasible-lattice and actual joint-carry gaps. It independently reconstructed
the new zero-order norm interface and verified all six production hashes and
32 evidence hashes. The continuation review record owns the full response
and limits. No actual pi phases or new Lean results occur in this checkpoint; the fresh
positive-consumer pass continues separately.

**Uniform-certificate checkpoint and targeted source question — 2026-11-27 UTC:**
local commit `062667e49a715e9c3e89d42b3d7857fa62ec4698` records the reviewed
six-path result. Exact scope, empty index, preservation and necessity checks
passed; nothing was pushed. The fresh worker's first proposed automaton-moment
closure was directed back to the existing language assessments before counting
it as new; a generic continuum-of-entries obstruction is already known.

**Parent source check, 15 minutes before reassessment:** seek one precise
primary-source theorem connecting logarithmic periods or values of differential
equations to restricted digit sequences, with a possible consumer for the
actual canonical carries. Preserve distinctions between a missing word,
automaticity, algebraicity, normality and almost-everywhere statements.
The endpoint is an exact applicable implication or a specific failed hypothesis
that changes the next test. No broad survey or unsupported period-versus-Mahler
independence claim is authorized by this bounded question. Research continues.

**Fresh-pass result and source triage — 2026-11-27 UTC:** the fresh worker
returned no positive V consumer. Its finite-state proposal repeats the existing
language/path gap. The parent read its complete scratch report
`/tmp/pi-m4-positive-consumer-reset-20261127/report.md`
(SHA-256 `f7059df16c7791e8989a95081c5320cb33c8a85fe39f166f0d60f8c8afd90cec`).
Its logarithm-lift proposal lacks a coherent lift of the canonical floors;
the optional rescaling diagnosis is not integrated as a reviewed result.
The worker's finite checks have not been replayed by the parent. This pass
did not move V or identify a distinct positive continuation question.

The parent source triage found no applicable visitation theorem. Adamczewski
and Faverjon, [2012.08283v1, Theorem 1.1](https://arxiv.org/html/2012.08283v1),
requires Mahler functions and multiplicative independence of their arguments
or their transformation bases. Neither a Mahler equation for the canonical
carry series nor a second such representation of pi has been obtained.
The existing factorial-word and language/path countertests already prevent
deducing that equation from word avoidance. Theorem 1.1 and the introductory
definitions were read; its proof and appendices were not assessed. Subsequent
web searches within that page timed out and supply no additional evidence.
Fischler--Rivoal's G-function digit theorem was rediscovered, then matched to
the existing assessment in `m4-rational-forcing.md`; it is not new progress.
The Mahler 1953 publisher abstract was screened, without extracting or using
an uninspected approximation theorem.

The search also surfaced an unassessed September 2026 preprint claiming
irrationality exponent two for pi. Its
[introduction and proof outline](https://github.com/openai/math/blob/main/preprints/The-irrationality-exponent-of-pi-is-2-September-24-2026/build/main.tex)
were read through the GitHub connector (blob
`fe28ac589090c44a8877aa326b60e753c863fa24`). The headline conclusion would
still not imply V. A separate **20-minute source-bridge test** now examines
its proposed center-uniform logarithmic jet interpolation and determinant
mechanism: does word avoidance supply any replacement for the exceptional
rational approximations used by that mechanism? Restricted digit entropy is
not reduced rational height. The endpoint is an exact new consumer or a
specific failed input, not acceptance of the preprint or a broad source audit.
The source search ends at this reassessment; authorized M4 research continues.

**Parent carry-density test, 15 minutes before reassessment:** test whether
bounded partial quotients (stronger than irrationality exponent two) force
the canonical borrow corrections to have density zero when the exact future
BBP forcing is retained. The prior factorial-phase countermodel has no finite
irrationality exponent. The new candidate phase is the base-16 Kempner sum
`alpha=sum_(j>=0)16^(-2^j)` with the same actual E_n. Its geometric zero
blocks may yield density-one corrections while its continued fraction remains
bounded. Verify the original Shallit theorem's base and indexing and the
all-prefix density estimate. An example would exclude this proposed repair
of carry sparsity, not be a counterexample to the actual initialized V.

**Source-bridge outcome:** the worker's complete assessment at
`/tmp/pi-m4-logarithmic-determinant-bridge-20261127/assessment.md`
(SHA-256 `1d4d913693983e7679b3548b7f9b50adbfbf0bb1d561b840e65a612bf9c235ac`)
identifies the missing input: approximations with exponent greater than two.
Actual raw BBP approximants miss that scale; ordinary truncations supply only
their usual O(1/q) guarantee. The determinant counts transverse Taylor indices,
not allowed numerator words. Rescaling weights by digit entropy also rescales
denominator clearing. The parent read the assessment/critic, checked the
source's approximation and gap statements, and verified all four source Git
blob identities. No geometric theorem or headline irrationality claim is
accepted, and no new V estimate results.

**Carry-density outcome:** the separate worker reconstructed the parent
candidate without finding a defect. Its frozen report is
`/tmp/pi-m4-bounded-quotient-borrows-check-20261127/report-v1.md`
(SHA-256 `6b2bdad4f53ebd329e1825d7563287c5da008ff95167678062470d0018cb3cd1`).
The exceptional count is O(log^2 N) for every prefix, not just a subsequence.
The continued-fraction bound 18 also yields the explicit approximation lower
bound 1/(76q^2). The parent read the complete report, source contract, critic
and checker, reconstructed the estimates, and replayed an unchanged checker
copy: 5,692 exact checks passed, exit 0; receipts agree after removing UTC and
all seven frozen files are unchanged. No actual pi phase or tail was computed.
The optional relaxed-model application is retained in scratch, not added to
the production claim. Independent integration review remains pending.

The preceding discovery pass did not find a positive consumer. A different
**20-minute fresh-context inquiry** now tests exact rationality of all BBP
prefixes and their particular rational-coefficient recurrence against word
omission, looking for a precise rigidity implication or a solved-neighbor
bridge. A restatement of Hypothesis A or another generic rounding obstruction
does not count as a new mechanism. V/Hpi/T/M4 remain open and research continues.

Independent five-path integration review is complete: no defects or required
improvements; Q1--Q2 retain the original initialization and missing determinant
input. The reviewer reconstructed the mathematical claims, visually checked
the Shallit pages and verified all scope/evidence hashes. The continuation
review record owns the full response and limits. The rational-prefix inquiry
continues separately; no V theorem or M4 acceptance is claimed.

**Rational-prefix outcome and source reset — 2026-11-27 UTC:** the reviewed
carry/source checkpoint is local commit
`0c666a0c335d84c25895c7565ea42dd6e4de7be4`; nothing was pushed. The rational-prefix
worker returned no distinct positive consumer. Its complete note at
`/tmp/pi-m4-rational-prefix-recovery-20261127/note.md` reconstructs the
order-two equation and the remaining integer carry defect. Neither rational
prefixes nor minimal recurrence order constrains that defect using word
omission. No checker or Lean result was produced. The parent read the note.

The parent determinant reassessment also returned to an existing obstruction:
`m4-positive-certificates.md` already treats both short-block denominator cost
and long-block collision valuations. No new determinant theorem is claimed.
That variation is suspended rather than counted as a new approach.

A ten-minute, at-most-three-relevant-source screen found no applicable V
theorem. Nieuwveld--Ouaknine's
[prodisjunctivity theorem](https://drops.dagstuhl.de/storage/00lipics/lipics-vol345-mfcs2025/html/LIPIcs.MFCS.2025.80/LIPIcs.MFCS.2025.80.html),
Definition 3/Theorem 4, concerns sorted positive values of simple integer
linear recurrences with two dominant roots, not BBP carries. An unaudited
normality research archive was screened only for ideas; none of its claims
was adopted. A search-result arXiv identifier associated with Stoneham work
actually resolved to an unrelated consecutive-gap paper and was discarded.
This is not an exhaustive literature or nonexistence claim.

The useful source comparison was
[*Binary Words in the Reciprocal Fermat Constant*](https://github.com/CaptainSude/reciprocal-Fermat-constant-Nonnormal/blob/334679abee4f13d0b9e3761e221fc0df60b3fd62/fermat-reciprocal-disjunctivity.pdf),
Theorem 2, pp.2--3. Its integer Lambert coefficients give explicit block
residues at sparse divisibility times; a polynomial residue mesh supplies
visits without requiring normality. The parent read all four pages' extracted
text and visually inspected pp.1--3. A separate 15-minute worker bridge test
finished without an actual-BBP identity. Its immutable report is
`/tmp/pi-m4-fermat-bridge-20261127/report-v1.md`, SHA-256
`e1c05ea211b85d6b29ef8f50345157b39d12c963da6b14b283d50c467c3909aa`.
The parent read it completely. No external Lean archive was inspected.

The coefficientwise transplant has a simple obstruction: a Lambert series
whose coefficients lie in one fixed lattice D^(-1)Z has every Taylor
coefficient in that lattice. Actual A(n)>0 tends to zero, so the BBP generating
function cannot be that series plus a polynomial. This does not exclude a
different identity at 1/16 or a null-series transformation. Literal prefix
returns repeat the existing shadowing-time obstruction and leave possible
modular cancellation uncontrolled. The missing bridge is still an actual-pi
identity controlling integer block residues with a vanishing remainder.
Independent integration review found no mathematical defects. Its one
nonblocking navigation correction was implemented; Q1 retains the missing
actual-pi identity. The continuation review record owns scope and limits.

**Changed global-lattice inquiry, 20 minutes before reassessment:** examine
general combinations of the actual all-prime Newton rows, beyond the already
failed prefix and binomial-stencil families. The endpoint is a precise
period-aligned dual or covering estimate with its actual hypotheses checked,
or a distinct obstruction. Positive volume is not covering; no generic
lattice theorem will be applied without its missing bounds. The worker owns
scratch `/tmp/pi-m4-global-dual-recovery-20261127/`; production remains with
the parent. V/Hpi/T/M4 remain open, B4/P3 retain visits, M5 is excluded, and
research continues.

**Global-lattice reassessment — 2026-11-27 UTC:** the sparse-source checkpoint
is local commit `b114f4bd2fd46cecf8bf26bdb81d7d0015c8c44f`; exact scope,
empty index and preservation checks passed, with no push. The new worker
tested the finite rational-period slice, not another prefix stencil. Its
report `/tmp/pi-m4-global-dual-recovery-20261127/report-v1.md` has SHA-256
`f7551487bdedc9d85eee8bf36c004b3312e42ca8827965c8ddad03a77d7d75a6`.
It derives a sufficient bounded-lift criterion and exact slice-spacing and
covolume formulas. At six tested cutoffs the rational period grid is too
coarse for its all-center certificate. These are finite results; small slice
volume is not emptiness, and no eventual failure is claimed. The parent read
the complete report, criticism and checker, then replayed an unchanged copy:
2,547 exact checks, exit 0, identical receipt, all six frozen files unchanged.

The parent's **15-minute thin-strip test** relaxes that exact-zero slice.
Its frozen report `/tmp/pi-m4-thin-strip-20261127/report-v1.md` has SHA-256
`5ea680e350ab87487d99b81f360ddc6e5df97efb92fd41c7f627c226d7e56fdc`.
Exact two-dimensional basis reduction certifies unrestricted projected
coverage at the same six cutoffs; 2,460 assertions passed, exit 0. It supplies
no bounded preimages, asymptotic estimate or infinite model. A separate real
hyperplane calculation is scratch-only. Both packets await independent
review and are not new Lean or accepted visitation results.

A **20-minute follow-up** now tests bounded preimages in the full coefficient
space. An exact early-coordinate obstruction rejects the proposed full-basis
certificate with K=1, while leaving actual feasible-set coverage unresolved.
The worker is removing the coefficients forced to zero and screening a later
finite cutoff. One targeted basis-reduction trial may run with a three-minute
execution cap after that screen; no tools are installed. Neither volume nor
an unbounded projected image is treated as bounded covering. The unchanged
M4 objective continues; any diagnostic model would still differ from actual A.

**Bounded covering checkpoint — 2026-11-27 UTC:** the K=1 full-basis test
fails for an exact early-coordinate reason, while bounded points can remain
in a lower-rank section. A later N=48 exact-rational reduction trial reached
its 180-second cap during initial Gram--Schmidt; no mathematical failure was
inferred. Changing the search representation produced a K=31,N=50,B=1/4096
basis in 8.8 seconds. Approximation chose the integer transformation only.
The independent original-data verifier and parent output-path-only replay
both passed 2,680 exact checks; JSON and certificate bytes match, and all
frozen inputs remain unchanged. The verified result is a finite all-target
bounded-covering certificate, now stated in the
[prime-defect assessment](m4-prime-defect-boundary.md#a-finite-bounded-covering-certificate).

The parent's separate 15-minute calculation found a
[single-functional consumer](m4-prime-defect-boundary.md#a-single-rational-functional-suffices-for-future-covering-certificates)
with a fixed positive target interval and an absolute error bounded by the
remaining period tail. Independent Codex criticism found two minor ambiguities
(rational B and determinant sign), both corrected, and an explicit zero-prefix
clarification was adopted. It found no remaining defect in the conditional
implication. Suitable basis widths at arbitrarily large cutoffs remain unproved.
The N50 certificate is not claimed to satisfy this different coordinate frame.

A distinct **20-minute uniform-dual inquiry**, begun at 06:48 UTC, tests
controlled witnesses or dual support at rare many-prime stages. Another finite
cutoff would not settle the issue, so larger basis searches are suspended.
Scratch ownership is `/tmp/pi-m4-uniform-dual-20261127/`; the parent integrates
the completed finite results separately. This diagnostic route could identify
which arithmetic data remain compatible with perturbations; even an infinite
model would not retain exact A or prove V. No Lean theorem, unconditional visit,
infinite all-prime model or M4 acceptance is claimed. Research continues.

**Continuation and context decision — 2026-11-27 UTC:** the finite covering
checkpoint is local commit `8155234c34be6aed22d33b6f45e0392f64ec886a`;
its exact five-path scope, empty index, protected/unrelated preservation and
post-commit necessity checks passed. Nothing was pushed. After discussing
a fresh-session handoff, the user explicitly chose to keep working in this
session and reassess tomorrow. No pause or reset was requested.

The uniform-dual cycle completed with four paper claims in
`/tmp/pi-m4-uniform-dual-20261127/report-v1.md`: an ordinary-stage lower
bound including the full tail, arbitrarily long exceptional CRT blocks,
simultaneous polynomial-prefix witnesses with controlled exponential height,
and a p=7 obstruction forcing bounded nonzero raw-prefix polynomials to
degree greater than N/200 eventually. Parent reconstruction and unchanged-copy
replay passed 1,477 exact checks, exit 0, identical receipt and six preserved
artifacts. Independent paper criticism found no defect and suggested making
the uniform error constant explicit. Production integration review is pending;
these are not a uniform covering result or actual V.

The separate actual-forcing cycle gives exponentially small continuous
Fourier integrals but an exact-A changed-initialization model whose integer
averages tend to one. A rational four-pole coboundary additionally retains zero
initialization and the first/leading coefficients, while losing exact A and
the irrational period. Parent unchanged-copy replay passed 1,137 exact checks,
exit 0, identical receipt and three preserved artifacts. Independent paper
criticism found no defect and requested explicit integer frequency/window
domains. Its packet is `/tmp/pi-m4-actual-forcing-recovery-20261127/`;
production integration remains pending.

Next bounded questions are distinct: a 20-minute adaptive logarithmic-window
test for the Newton constraints, a 15-minute test of nonzero Poisson sampling
terms retaining the actual tail, and a 15-minute actual arcsine-prefix
comparison using central binomial coefficients. Each must identify a new
quantitative consumer or a specific failure, not relabel the existing gap.
Their scratch roots are respectively `/tmp/pi-m4-adaptive-window-20261127/`,
`/tmp/pi-m4-poisson-aliases-20261127/` and
`/tmp/pi-m4-arcsin-prefix-20261127/`. No results from those ongoing inquiries
are accepted here. V/Hpi/T/M4 remain open; M5 remains excluded.

**Global arithmetic and sampling reassessment — 2026-11-27 UTC:** all three
follow-ups above completed. The adaptive-window packet proves an exact local
content formula: sublinear frozen-history windows have a superexponential
full-basis/all-center obstruction at primorial endpoints, even with positive
volume surplus. This concerns the local lattice, not global fixed-K or
period-line covering. Parent replay passed 3,288 original prime/order checks,
exit 0, identical receipt and six preserved files. Independent criticism found
no defect; its integer-square-root cleanup was made in a new frozen version
with an identical passing receipt, leaving the original packet intact.

The Poisson packet retains the actual tail and proves a uniform transformed
formula with summable error, but reconstructs the sampled phases. Its exact
cross-scale convolution changes frequency and does not furnish the required
scalar cancellation. Parent source inspection included Tao's original pp.6--8;
unchanged-copy replay passed 2,589 exact normalization checks, exit 0, identical
receipt and four preserved files. Independent criticism found no defect or
required improvement. No analytic estimate is inferred from those checks.

The arcsine packet gives actual-time approximants, a vanishing tail, exact
dyadic denominator and a local binomial residue formula. The actual odd-division
remainder remains coupled to the real phase. Parent DLMF inspection and
unchanged-copy replay passed 36,484 coefficient/synthetic checks, exit 0,
identical receipt and six preserved files. Independent criticism found no
defect; its direct-to-V error/offset clarification is included in the assessment.
No actual prefix or pi phase was computed. Final integration status for these
paper results is recorded separately in the continuation review record.

A **40-minute global-support inquiry** now tests the parent's proposed small
single-prefix witnesses and their consequences for integer-valued duals.
Its scratch root is `/tmp/pi-m4-global-support-20261127/`. A separate
**30-minute fresh-context recovery pass**, `/tmp/pi-m4-strategy-reset-20261127/`,
seeks an actual-initialization/avoidance implication, rejecting ideas already
covered in the archive. Both endpoints require a new precise bound or an
informative failure, not renamed visitation. No outcome is claimed here.
The user-directed continuation remains active; V/Hpi/T/M4 remain open.

**Discrete entries and source applicability — 2026-11-27 UTC:** the preceding
seven-file checkpoint is local commit
`0d8b849176116446acdd8edb320656256009ca4b`. Its full review, exact staged
scope, 93-file documentation check, 38 process tests, whitespace checks and
17 protected/11 unrelated preservation checks passed. Post-commit scope,
parent, diff hash, empty index and necessity inspection passed; no follow-up
change was warranted. Nothing was pushed.

The 30-minute fresh-context pass completed the
[discrete grid test](m4-language-auxiliaries.md#the-actual-denominator-grid-still-admits-many-avoiding-entries).
Under a quantified linear horizon/seed-precision budget, exponentially many
reduced entries retain the actual denominator, prescribed numerator bits and
exact future A while avoiding a word. Uniform strict integer-evaluation
certificates must pay for all those roots. A weaker actual target, infinitely
many odd canonical carries, remains open; a finite character pair only shows
non-determination among replacements. Parent reconstruction and byte-unchanged
replay passed with identical receipt and all four originals preserved.
Independent criticism found no blocking defect; its replacement-only
quantifier clarification is implemented in production. Final integration
review remains pending. No actual canonical numerator or pi digit was evaluated.

A separate **20-minute source-applicability screen** sought a rigidity or
population theorem with an actual-entry consumer. The parent inspected
[Beukers--Houben--Straub, Theorem 8.1, p.18](https://arminstraub.com/downloads/pub/gausscongruences.pdf#page=18):
the generating function must already be rational, and the Gauss property
requires coefficient integrality at almost all primes. The existing actual
moment series fails both requirements; separate prime-dependent interpolants
do not repair them. This classification supplies no new rigidity bridge.

[Chow--Varju--Yu, Theorem 1.2, pp.2--3](https://wrap.warwick.ac.uk/id/eprint/195877/7/1-s2.0-S0001870826000290-main.pdf#page=3)
bounds the population of rational members of one fixed infinite missing-digit
set. Blocking a forbidden word fits the one-omitted-digit alphabet, but
finite shadowing does not place rational BBP prefixes in that set. No large
enough collection of distinct rational members was constructed. This result
also supplies no actual-numerator selection. Both sources were read in their
original context, with relevant pages visually inspected by parent and critic;
neither full source proof was independently audited. The frozen assessment is
`/tmp/pi-m4-rigidity-source-screen-20261127/assessment-v1.md`, SHA-256
`924ec16e4d2710dbf5f82b0a565d7cdbd8cca98d618d9fd388dcae31cd214d84`.
Independent criticism found no defect or required improvement, retaining the
two missing application bridges. These are informative applicability failures,
not new theorem exports or a literature-exhaustion claim.

The global-support inquiry continues within its original 40-minute bound.
Its next test concerns the real norm of duals surviving the ordinary-support
zeros. A proposed sparse-support interpolation bound is exploratory and not
yet an accepted global theorem. No larger finite basis campaign is underway.
V, C_odd, global covering, Hpi/T/M4 remain open; M5 remains excluded.

A **25-minute sparse-support inquiry**, begun at 08:10 UTC, now tests the
sharp p-local conductor of arbitrary finite Newton-support sets and its
consumer for the complete real dual norm. Worker `/root/m4_strategy_reset`
owns `/tmp/pi-m4-sparse-newton-support-20261127/`. The current global worker
already has an elementary interpolation/interface calculation; the new pass
must go beyond that calculation, not duplicate it. p-power ancestor mixing,
zero-prefix conditions and p-unit globalization remain explicit. Its endpoint
is an exact sharper bound with a tested consumer, an attained obstruction,
or an informative failure. No global covering or actual visitation result
is assumed. The parent continues independent work and integration.

**Global support and sparse conductors — 2026-11-27 UTC:** the discrete/source
checkpoint is local commit `1d1410fd3e844d01f91ad2c6427bba6f6830e77a`.
Its full review and focused navigation correction, documentation/process and
whitespace checks, exact staged scope, and post-commit necessity/preservation
checks passed. Nothing was pushed; no Lean file changed.

The 40-minute global-support inquiry completed. Small global singleton
witnesses force ordinary q-coordinates to vanish in a logarithmic window at
the actual support horizon. A primitive exceptional-supported CRT family
has superexponential top denominators, so support alone does not bound them.
An exposed earlier coefficient nevertheless proves that this family cannot
be short. Parent reconstruction and unchanged-copy replay passed 7,047 checks,
exit 0, identical receipt and eight preserved originals. Independent criticism
found a missing i>=K hypothesis in the exact singleton statement and a prime
range clarification in the content proof. Both are corrected in a new v3
report, with originals preserved; the eventual support theorem is unchanged.
A separate integer-square-root checker cleanup passed the same receipt.

The 25-minute follow-up completed a sharp local conductor theorem, its full
root/ancestor interface and a complete-norm consumer for arbitrary sparse
global duals. Short sequences with top index j tending to infinity must have
liminf r*log^2(j+2)/j >= (4-log8)*log7, for fixed K,B and a-support size r.
The local bound is attained by divided differences; this does not imply
attainment for a prescribed global support. The exceptional set contains a
positive-density progression, so its support restriction supplies no required
sparsity. Parent reconstruction and byte-unchanged replay passed, with identical
receipt and all four originals preserved. The checks include independent
minors, root tests, p-unit globalization and the complete-tail minimization;
the universal and asymptotic claims remain paper arguments. Independent
criticism completed with no defect or required improvement; dense cancellation,
fixed-global-support attainment and actual visitation remain open. Final
production review found two compression defects: omitted CRT family domains
and reuse of b for both a chain coefficient and the positive budget. Both
were repaired and passed focused review; the full cycle is retained in the
continuation review record. Documentation/process/whitespace checks passed.

The next actual-sequence question has a separate **30-minute bound**. Worker
`/root/actual_negative_anchor` owns
`/tmp/pi-m4-negative-anchor-consumer-20261127/`. It tests whether the exact
two-sided rational prefix graph and reflected zero can constrain canonical
carries, first separating consequences already forced by backward recurrence.
The opening was the negative rationality lost by earlier comparison models;
neither 2-adic analyticity of B nor a hypothetical continuation of floors is
taken as a real-word theorem. Its report and criticism are not yet accepted.
The auxiliary lattice analysis remains directed at the comparison-model
boundary; it is not substituted for the unchanged actual V obligation.
V/C_odd/global covering remain open, B4/P3 retain visits, and M4 work continues.

**Actual negative history and canonical selection — 2026-11-27 UTC:** the
global/sparse checkpoint is local commit
`7268e5525e60106246ebf2160ae4aa29049b9da4`. Full and focused review,
documentation/process/whitespace checks, exact staged scope and post-commit
necessity inspection passed. All 17 protected and 11 unrelated files were
preserved; no push, PR or Lean change occurred.

The 30-minute actual-history inquiry completed with a precise failed consumer.
Exact A and the raw zero anchor already determine rational negative prefixes.
Their canonical carries are 15 for n<=-3, 16 at -2 and 3 at -1; the entire
portion before -1 cancels in Q_2, leaving only the known forward initialization.
Two bounded even-carry decompositions keep the actual B everywhere, negative
canonical history and initial state while relaxing the positive remainder
cell. Thus those relaxed assumptions cannot select canonical parity. The
actual negative samples also give an explicit floor-continuity failure.
The unit-cell question remains open; no actual avoiding trajectory is supplied.

Parent reconstruction and byte-unchanged replay passed with identical receipt
and five preserved originals. Independent reviewer `/root/m4_strategy_reset`
found no defect and requested an explicit recurrence offset/C_odd contract;
a new immutable report v2 adds that clarification and passed focused review.
The continuation review record owns captures and dispositions. Final production
review completed with no defect or new recommendation; documentation (93),
process tests (38), whitespace and preservation checks passed. Universal
identities retain their paper status.

The next two questions each have a **25-minute reassessment bound**. Worker
`/root/global_dual_recovery` owns `/tmp/pi-m4-descendant-witness-20261127/`:
construct earlier-root witnesses with required descendants, retaining all
original rows, and quantify their full real norm or identify its obstruction.
Worker `/root/canonical_selection_recovery` owns
`/tmp/pi-m4-canonical-selection-recovery-20261127/`: a fresh-context meta-plan
pass must propose a concrete actual-selection mechanism and discriminating
test, using the exact positive unit cell and checking the failure archive.
No finished result from either is accepted here. The direct reflected-carry
consumer is suspended, while V/C_odd/global covering remain open and M4 continues.

**Descendant costs and relative forcing — 2026-11-27 UTC:** the actual-history
checkpoint is local commit `974a8f17f0693156f027ade70552356a3b639626`.
Review, documentation/process/whitespace checks, exact staging and post-commit
necessity/preservation inspection passed; nothing was pushed or changed in Lean.

The descendant inquiry completed within its 25-minute bound. It constructs a
full all-prime witness for any root with sufficient scaling, then proves that
any completion with a nonzero integral root and both G_7(r)=G_11(r)=0 costs
an exponentially growing budget norm. One prime's identically zero defect
subspace has vanishing bounded period image and only the zero infinite vector.
A necessary normalized difference identifies what nonzero admissible defects
must supply; the full lattice remains open. Parent replay passed 1,144 exact
checks, identical receipt, six preserved originals. Parent criticism repaired
the strict certificate at the zero witness. Independent criticism accepted
the result and clarified the integer threshold; immutable v3 retains both.

The fresh actual-selection inquiry also completed. Its finite cyclotomic
orbit fixes i and actual future forcing phases, retains primitive orders,
and includes both canonical parity branches. A fresh-prime suborbit gives
many such branches through h<=N/2; all conjugate freedom disappears within
8N+5 future constraints. Neither statement selects the actual initialized
phase. The automorphisms fix rational S_n; replacement real lifts are not
their images. Parent replay passed 8,076 checks with identical receipt and
four preserved originals. Independent criticism and this wording clarification
passed. Pinned Mathlib power-action declarations and archived prime inputs
were inspected; all applications remain paper arguments. No optional smaller
collapse constant was adopted. Final production review passed after a focused
counting-window clarification; no mathematical formula changed. Documentation
(93), process tests (38), whitespace and preservation checks passed.

Next, `/root/actual_negative_anchor` owns
`/tmp/pi-m4-finite-grid-escape-20261127/` under a **25-minute bound**. It tests
a candidate linear escape horizon from all-even carries for all entries of
small complete q_N grids under exact future A. The endpoint is an exact
survivor recurrence, exhaustive finite diagnostics and a precise assessment
of the missing uniform estimate, including a changed-forcing comparison.
Partial samples cannot be reported as exhaustive; a finite result is not
C_odd or V. No output from this new inquiry is accepted here. The zero-defect
repair and relative norm/trace positivity inference are suspended; research
continues toward the unchanged M4 target.

**Finite-grid escape and source limits — 2026-11-27 UTC:** the
descendant/relative-field checkpoint is local commit
`c25b65627b8757fc6b10bcef67177feb633fdfba`. Exact staging, post-commit
necessity and preservation checks passed; no PR or Lean change occurred.
This run issued no push. A later read-only `git ls-remote` check
verified the remote branch at c25b656; the local remote-tracking reflog records
an update by push at 09:36 UTC. The publication state changed outside this run's
actions; subsequent checkpoint edits remain local until separately verified.

The 25-minute grid inquiry completed. Two exact algorithms exhaust the
q_0=15, q_1=4095 and q_2=765765 grids, giving all-seed escape times 5,9,15
and reduced times 4,9,15. A reduced nonactual N=2 witness rejects C<5 for
the proposed horizon C(N+1) uniform in every N. A separately capped N=3
search covers only 5,000,000 of 111,035,925 seeds; its lack of a 20-step
survivor is inconclusive. No constant was refitted. The exact survivor
intersection uses permuted half-intervals; all unfiltered states stay distinct
even after forcing-field collapse. Continuum measure 2^-h and component
counts give a lower-survival range but cannot certify emptiness.

Parent byte-unchanged replay in
`/tmp/pi-m4-finite-grid-parent-replay-20261127/` passed both scripts, with
matching mathematical JSON results after excluding elapsed-time fields and
six preserved originals. Independent critic `/root/generating_review`
reconstructed the identities and found no defect or required improvement.
The actual-threshold covering estimate and the incomplete N=3 case remain
open; neither is a validation requirement for this explicitly finite report.

A targeted **20-minute source screen** completed for Schleischitz's rational
Cantor separation/exit bounds, Shparlinski's rational-membership/full-period
restrictions, and Gilson's corrected v3 separation preprint. Primary versions,
exact contracts, source hashes and application limits are retained in the
[language assessment](m4-language-auxiliaries.md#source-limits-for-escape-and-separation).
The first source assumes outside membership; removing actual forcing introduces
an irrational translated seed. The second does not transfer full rational
periods to actual A. The third withdraws the earlier exit claim. None closes
the grid-cover gap. This is a statement screen, not full proof verification.

Existing PDFKit rendered four theorem pages, all visually inspected. Its
initial default-cache attempts exited 1; specifying a writable /tmp module
cache recovered with exit 0, without installation or permission changes.
Independent reviewer `/root/m4_strategy_reset` found no defect and requested
explicit source domains. Immutable report v2 adds them; the original packet
is preserved. Final integration review requested the p.1 missing-digit domain
2<=|W|<b and a positive-dimension restriction for the local separation contract.
The parent inspected that extra primary page and retained immutable v3; focused
review of this repair passed with no remaining finding. Documentation (93),
process tests (38), whitespace and preservation checks passed. No Lean theorem
or proof-frontier advance is claimed from these paper/finite results.

Next, `/root/actual_negative_anchor` has a **25-minute bound**, starting about
09:37 UTC, to test rational shift/coboundary relations of exact A. The endpoint
is a relation with a justified parity/error consumer, or an exact obstruction
to that mechanism, after checking archived finite-filter/gauge failures.
It must pivot if the initial question is already settled, and use only scratch
files; no new census or constant fitting is requested. This changes the test
from ambient denominator size to correlated forcing constraints. No output
from the new inquiry is accepted here. V/C_odd/global covering remain open;
the user requested a status update, which was answered without stopping work.

At about 09:47 UTC, `/root/m4_strategy_reset` began a distinct **20-minute
meta-plan recovery pass**. It must use the failure archive, exclude the active
gauge inquiry, and return at most two materially different exact candidates,
each with a concrete consumer and discriminating test, or a precise account
of the missing resource. New notation for an already failed mechanism is not
a new candidate. This is bounded ideation, not review or authorization to stop;
no output from it is accepted in this checkpoint.

**Rational gauges and conditioned endpoints — 2026-11-27 UTC:** the
grid/source checkpoint is local commit `890a4e0f2a390998c423c2235e0ee3287c24ea41`.
Full/focused reviews, documentation/process checks, exact staged content and
post-commit necessity/preservation checks passed. All 17 protected and 11
unrelated files were preserved. The new commit was local, one ahead of the
verified remote c25b656; this run issued no push or PR.

The 25-minute shifted-coefficient inquiry recognized the archived telescoping
and finite-filter obstructions and pivoted to a new parity-label consumer.
Fixed rational lag gauges have a nonzero proper residual, bounded below
modulo two by a power of N. Whole-grid mismatch counts and a truncated-gauge
depth cost follow. Parent replay passed 1,971 exact cases, byte-identical
receipt and three preserved original artifacts. These are synthetic checks,
not actual-grid or digit searches.

Parent reconstruction then found an exact matched-endpoint correlation missed
by the initial broad survivor limitation. A **15-minute focused extension**,
started about 09:57 UTC and completed within its bound, proved that every
specified parity word pushes restricted Lebesgue measure to 2^-h times uniform
terminal measure. Endpoint mismatch is a single interval in that terminal
state. The resulting reduced-grid error is 2^omega(q)*m_h; growing truncated
gauges have main/error gap 6N-m*log16+o(N). At every resonant lag q|16^h-1,
the particular component-error lower bound is strictly negative, independent
of truncation. No true-count or visitation conclusion follows from that failure.

Independent critic `/root/global_dual_recovery` found three initial defects:
the ancillary norm bound needed W nonzero, truncation formulas needed beta=0,
and the blanket absence of survivor correlation was too broad. The authoritative
extension/correction map and parent's signed-error clarification resolved all
three in focused review. Parent replay of two exact constructions agreed on
1,400 complete synthetic qualifying sets, with byte-identical receipt and
all original packets preserved. The continuation review record owns the full
captures and dispositions; final production integration review completed with
no remaining finding. Documentation (93), process tests (38), whitespace and
preservation checks passed.

The changed understanding is a precise short-horizon survivor estimate and
its failure to reach resonance, not just an absence of any correlation. It
still leaves actual-seed selection, longer-horizon arithmetic and intermediate
model-carry transfer open. The separate 20-minute meta-plan pass was asked
to close at its reassessment point; no unfinished result from it is adopted
here. These remain paper results, with no Lean/audit/dependency change and
no claim of C_odd, universal grid escape, V or M4 acceptance. Work continues.

The earlier meta-plan worker subsequently had no completed packet and no
entry in the live-agent inventory. Its research outcome is unavailable, not
negative or completed; no cause is inferred. After a status/closure message,
the parent started `/root/unused_structure_reset` as a fresh **15-minute**
recovery, scratch root `/tmp/pi-m4-unused-structure-reset-20261127/`.
It must return at most two genuinely different exact candidates or a precise
inconclusive outcome, using the failure archive and excluding the completed
gauge lane. It has no production/Git/service/delegation authority. This
operational recovery does not alter the mathematical conclusion or end M4.

**Progression conductors and recovered ideation — 2026-11-27 UTC:** the
gauge/endpoint checkpoint is local commit
`390730c8b88922a55dd0306e1f49ce6e9b06029c`. Its full review, checks, exact
staging and post-commit necessity/preservation inspection passed. At this
inspection the branch is two commits ahead of its remote-tracking reference;
the run has issued no push or PR. All 17 protected and 11 unrelated hashes
still match the preceding preservation snapshot.

The fresh 15-minute meta recovery completed at 10:18:35 UTC with no surviving
candidate. The raw second-order recurrence retains the archived floor/carry
gap. The exact identity (240n+151)^2-241=480*(120n^2+151n+47) does not make
A(n) a quadratic norm: A(1)=106/819 has odd 7-valuation, while 241 is a
nonsquare modulo 7. Parent symbolic expansion and this single counterfixture
passed; the worker's unstored finite checks were not replayed. The report at
`/tmp/pi-m4-unused-structure-reset-20261127/report-v1.md` retains the limits.
This is a completed negative screen, not an exhaustion result.

At 10:21:46 UTC, `/root/global_dual_recovery` began a **25-minute** inquiry
into comparison duals supported where Q divides i+1, with Q fixed. It completed
before the bound with the [rescaled conductor](m4-prime-defect-boundary.md#progression-support-gives-a-rescaled-conductor).
Explicit original-root adjustment improves the ambient ancestor estimate;
primes dividing Q alone cannot appear in the top denominator. Genuine global
rows attain the leading scale, and the finite-prefix surcharge is only
polynomial. The full-tail bound excludes further dense support families,
while rescaled primorial tops and arbitrary cancellation remain open.
The particular CRT constructions still fail shortness after normalization.

Parent reconstruction and unchanged-copy replay passed 8,430 checks with an
identical receipt and six preserved originals. These include 2,968 original
uncleared Newton rows, not just a replaced sampled module. Independent paper
review by `/root/generating_review` passed with no defect, including the
negative meta screen. The optional exact finite-prefix conductor refinement
is deferred; complete-norm cancellation and actual selection remain open.
Final production review and its focused repair passed: the compressed liminf
statement now explicitly retains growing actual tops, and the handoff's
latest-continuation link is updated. Documentation (93), process tests (38)
and whitespace checks passed. There is no Lean change or actual visitation claim.

A separate **20-minute** source inquiry by `/root/unused_structure_reset`,
started 10:42:24 UTC, tests logarithmic values against missing-digit membership
theorems. Its
scratch root is `/tmp/pi-m4-logarithmic-fractal-screen-20261127/`. It must
retain complex branch and algebraic-multiplier conditions for pi=log(-1)/i,
and distinguish whole-set exclusion from approximation or low-complexity
results. At most two primary results will be assessed; no unfinished source
claim is adopted here.

At 10:45:46 UTC, `/root/global_dual_recovery` began a distinct **20-minute**
follow-up at `/tmp/pi-m4-dual-polynomial-capacity-20261127/`. It must derive
the exact polynomial representation of a general dual with theta and the
infinite tail, then test whether a product-formula or polynomial-norm method
controls coupled coefficients beyond the already insufficient leading
denominator. The endpoint is a precise inequality and discriminating check,
or the exact missing bridge. No unfinished output is accepted. V/C_odd/global
covering and M4 remain open; work continues.

**Complete norms and logarithmic source limits — 2026-11-27 UTC:** the
progression checkpoint is local commit
`f18bcb21d09dbbfc3d14f32f7361d780749b3c9e`. Complete/focused reviews,
documentation/process/whitespace, exact staging and post-commit necessity
and preservation checks passed. The index was empty, task-owned tree clean,
and branch three ahead of its remote-tracking reference at inspection.
No push or PR was issued by this run; protected and unrelated work is intact.

The 20-minute polynomial inquiry begun at 10:45:46 UTC completed and froze
by 11:01 UTC. The [quadratic test](m4-prime-defect-boundary.md#a-quadratic-test-retains-the-complete-dual-error)
represents the full error exactly, including the infinite tail, and removes
theta using a period-zero polynomial test. It retains mixed-coefficient
information that the leading bound loses. The homogeneous leading-only
analytic factor cannot improve the 8^(-j) scale; explicit CRT denominators
show why that scalar is insufficient. A fixed early short dual also rules
out unqualified all-dual norm coercivity. The target-phase mismatch must be
retained; absence of a certificate is not a covering theorem.

Parent reconstruction and unchanged-copy replay passed 353 rational checks,
with an identical receipt and six original artifacts preserved. The three-prime
fixture cancels two orthogonal moments, but its large integer weights imply
no primitive/optimal/uniform claim. Independent critic `/root/generating_review`
found no defect in the inequality; its retained-row domain clarification was
implemented in immutable v2 and passed focused review. Complete arithmetic
control of the quadratic ratio and a target-sensitive consumer remain open.

The separate logarithmic source screen completed at 10:49:40 UTC within its
20-minute bound. The [two source contracts](m4-language-auxiliaries.md#logarithmic-values-do-not-yet-supply-pointwise-exclusion)
do not exclude the required point. Parent and `/root/logarithmic_source_review`
inspected six rendered primary pages, the local declarations and retained
publisher statement. The 18 original artifact hashes match. Focused review
passed explicit positive block-length/late-start domains and the reverse
transfer margin argument. No full source-proof or exhaustive literature audit
is claimed, and no external theorem was added to Lean. Final production
integration review and its focused clarification passed: the roadmap now
states the exact separating inequality. Documentation (93), process tests
(38), whitespace and preservation checks passed.

At 11:05:24 UTC a fresh `/root/actual_seed_research_reset` began a **20-minute**
meta-plan investigation, scratch `/tmp/pi-m4-actual-seed-reset-20261127/`.
It must reassess the comparison route's relevance to V and test at most one
materially different claim using the initialized seed, identifying exactly
which archived countermodel lacks its proposed resource. Its endpoint is a
discriminating claim/test or a precise negative outcome and changed next
question, not another name for actual selection. No unfinished result is
accepted. V/C_odd/global covering and M4 remain open; work continues.

**Ordered reciprocity and exact affine updates — 2026-11-27 UTC:** the
polynomial/source checkpoint is local commit
`73dd5cae0f7799b35aa5c75bd7027b43360c899d`. Its full/focused reviews,
checks and post-commit necessity/preservation inspection passed. At inspection
the branch was four ahead of its remote-tracking reference, index empty and
task-owned tree clean; this run issued no push or PR. All 17 protected and
11 unrelated hashes still matched the preservation snapshot.

The 20-minute reset begun at 11:05:24 UTC completed by 11:21:27 UTC with
no surviving actual-seed claim. Its ordered-sum inversion collision and
failed half-shift sign rule are retained in the
[mathematical assessment](m4-language-auxiliaries.md#ordered-reciprocity-retains-an-unestimated-carry-correlation).
Parent replay passed 160 exact checks. Independent `/root/generating_review`
found two missing domains: define the finite sum beyond coprime pairs, and
require canonical inverse units at odd q. Both were repaired in immutable v2;
the requested pairwise-versus-actual-statistic clarification was also applied.
Focused review passed with actual-history selection and richer consumers open.

At 11:23:57 UTC the same research worker began a distinct **15-minute**
one-step affine-update test, completing at 11:32:59 UTC in
`/tmp/pi-m4-affine-reciprocity-test-20261127/`. It derives the exact weighted
carry remainder, including reduction and endpoint terms. A synthetic pair
using actual A(1), with matching old/scaled sums and denominator reduction,
has different output sums and opposite floor parity. Arbitrary finite raw
2-adic agreement is possible, without a uniform height bound. No actual past
is retained by that pair. Classical reciprocity moves the missing information
to a numerator-dependent sum or selected lift; no telescoping consumer follows.
Parent unchanged-copy replay passed 78 exact checks, with an identical receipt
and all seven originals preserved. The primary classical formula was inspected
in text and its rendered page; no full source-proof audit is claimed.
Independent affine paper review by `/root/generating_review` completed with
no defect or improvement; its actual-history estimate remains explicitly open.
Final five-path integration review by `/root/logarithmic_source_review`
completed with no new finding; earlier domain/scope repairs remain integrated.
Documentation (93), process tests (38), whitespace and preservation checks
passed. No Lean, audit, pin or dependency changed.

At 11:33:11 UTC a fresh-context `/root/exact_function_recovery` began a
**20-minute** meta-plan inquiry, deadline 11:53:11 UTC, scratch
`/tmp/pi-m4-exact-function-recovery-20261127/`. It tests at most two precise
implications using the exact finite rational function or logarithmic period
against an entire eventually restricted carry language. It must distinguish
the archived raw homogenization, natural-boundary and source-complexity
failures. The endpoint is a discriminating claim/test or a precise changed
question, not a renamed selection hypothesis. No unfinished result is adopted.
C_odd, V, global covering and M4 remain open; work continues.

**Finite algebraic and tail profiles — 2026-11-27 UTC:** the
ordered-reciprocity checkpoint is local commit
`f09cf5d382d16078118f97659d5cceb67ed872ef`. Reviews, validation, exact
staging and post-commit necessity/preservation checks passed. At inspection
the branch was five ahead of its remote-tracking reference, index empty and
task-owned tree clean; this run issued no push or PR.

The 20-minute exact-function reset begun at 11:33:11 UTC completed at
11:48:35 UTC. It proves the [finite algebraic-family obstruction](m4-language-auxiliaries.md#finite-algebraic-profiles-do-not-follow-from-a-restricted-language)
and the periodic-carry F countertest. Its constant-tail extension deliberately
retains an edge-identity hypothesis: infinitely many samples alone do not
give an identity for a transcendental expression. Parent unchanged-copy
replay passed 492 exact synthetic checks with an identical receipt and all
five original artifacts preserved. No actual digit or phase was computed.

At 11:46:36 UTC the parent began a separate **10-minute** repair of that
sampled-tail gap, freezing the packet at 11:51:34 UTC. The full Laplace
remainder and an uncancelled complex pole force divergent tail coefficients;
convergent algebraic Puiseux coefficients cannot match them to every order.
This proves eventual nonvanishing and supplies the previously missing edge
identities for the specified finite profiles. The 136 exact coefficient
checks verify normalization only; the universal argument is a paper proof.
The primary Puiseux statement was read, including its finite negative-power
convention. Its full classical proof was not audited or formalized.

Independent `/root/generating_review` reviewed both packets and the focused
repair. D1 corrected the consumer's algebraic remainder to include its
rational tail term; I1 retained the missing source paragraph in a supplement.
Both are resolved in immutable v2. The language-to-profile implication is
still unsupported, and further profile classification without a consumer is
suspended. The result supplies no C_odd/V or M4 acceptance.
Final five-path integration review by `/root/logarithmic_source_review`
completed with no new finding and the language-to-profile gap retained.
Documentation (93), process tests (38), whitespace and preservation checks
passed; no Lean build was repeated for unchanged Lean files.

At 11:59:04 UTC a fresh-context `/root/language_consumer_recovery` began a
**20-minute** inquiry, deadline 12:19:04 UTC, scratch
`/tmp/pi-m4-language-consumer-recovery-20261127/`. It seeks at most two exact
positive consumers of eventual language restriction using the initialized
BBP period, with a discriminating test against the archives. The first
question tests a path-sensitive integral/auxiliary inequality; no finite
state-profile assumption or unfinished result is adopted. No new Lean or
trust boundary changed. C_odd, V, global covering and M4 remain open.

**Polynomial telescopes and integer-path inquiry — 2026-11-27 UTC:** the
finite-profile checkpoint is local commit
`7b7f83589bb3e9c85932a4a250460e1079b933b3`. Required reviews, checks,
exact staging and post-commit necessity/preservation inspection passed.
At inspection the index was empty, task-owned tree clean and branch six
ahead of its remote-tracking reference. This run issued no push or PR.

The language-consumer recovery begun at 11:59:04 UTC completed at 12:15:52
UTC, within its 20-minute bound. It found no positive visitation consumer.
The one new diagnostic rules out a uniform scalar polynomial telescope of
the odd-carry indicator; the surviving linear weights return the known period.
Parent replay passed 380 synthetic checks with identical receipt and five
preserved originals. Independent paper review and focused D1/I1 repair passed:
the even-carry sign factor equals 1, and the prospective integer-path contract
starts at N>=1. Authoritative scratch report is
`/tmp/pi-m4-language-consumer-clarification-20261127/report-v2.md`.
This completed diagnostic awaits combined production integration; no new
visitation claim or unfinished integer-cut result is adopted.

At 12:17:58 UTC the worker began a distinct **15-minute** inquiry, deadline
12:32:58 UTC, scratch `/tmp/pi-m4-integer-path-cut-test-20261127/`.
The endpoint is one explicit symbolic integer cut retaining the actual
numerator with a proved separating sign, or a precisely scoped obstruction
to the tested cut family. Merely reformulating the path as an integer program
does not qualify. The inquiry retains coordinate rounding, redundant carry
increments, and the distinction between exact and modular seed cancellation;
it does no actual phase/digit census. C_odd, V and M4 remain open.

That inquiry completed at 12:28:29 UTC, within its bound. It proves a limited
single-projection obstruction and retains modularly resonant pairs as a
genuine exception, with exact open residual windows. An exact-A changed-entry
family defeats all non-coordinate single projections; a changed-forcing
positive fixture confirms that pair cuts can separate. No actual initialized
sign was obtained. Parent unchanged-copy replay passed 4,136 synthetic checks,
with identical receipt and all five originals preserved. Independent paper
review by `/root/generating_review` completed with no D/I item; Q1 retains
the actual residual-window estimate. Combined five-path production review by
`/root/logarithmic_source_review` completed with no new D/I item and that
estimate retained open. Documentation (93), process tests (38), whitespace
and preservation checks passed. No new kernel result or M4 acceptance is
claimed; unchanged Lean files did not require a repeated build.

At 12:34:56 UTC the same worker began a distinct **20-minute** inquiry,
deadline 12:54:56 UTC, scratch
`/tmp/pi-m4-coupled-resonant-cuts-20261127/`. It tests simultaneous rounded
resonant pairs, explicitly outside the preceding single-projection family.
The endpoint is an actual initialized incompatibility certificate, or an
exact characterization and a discriminating countertest identifying what
coupling adds and still lacks. It tests at most two hypotheses, preserves
the actual numerator in the target, and does no phase/digit census or generic
solver expansion. No unfinished claim is adopted. C_odd, V and M4 remain open.

**Coupled-cycle extension inquiry — 2026-11-27 UTC:** the polynomial and
single-projection checkpoint is local commit
`ed9c0d96679cf1ee4c197e8ca12be6074fa7d8d8`. Required reviews, checks,
exact staging and post-commit necessity/preservation inspection passed.
At inspection the branch was seven ahead of its remote-tracking reference,
index empty and task-owned tree clean; this run issued no push or PR.

At 12:45:45 UTC a fresh-context `/root/actual_cycle_recovery` began a
**20-minute** inquiry, deadline 13:05:45 UTC, scratch
`/tmp/pi-m4-actual-cycle-recovery-20261127/`. It tests at most two explicit
extensions of the coupled mechanism, beginning with an order-scaled version
of the candidate finite triangle at the single next archived anchor. The
coupled report remains unreviewed input until its separate criticism is
complete; no unfinished conclusion is adopted. The endpoint is a symbolic
actual-A family with a proved separating sign, a refuted concrete extension,
or a worked new question with its exact missing bridge. No actual numerator,
initialized states or digit census is evaluated. C_odd, V and M4 remain open.

The coupled inquiry completed at 12:48:25 UTC, within its bound. Its signed
graph argument retains the actual lattice lift after real interval
intersection. At the single authorized forcing-only recurrence anchor N=1,
q=15, h=5, all pairs pass but one triangle has circulation -1, explaining
the already known finite escape. A supplied modulus check shows the method
has no pair at the known h=15 escape for q=765765. Parent unchanged-copy
replay passed 6,889 exact checks, identical receipt and six preserved
originals. Independent paper review completed with no D/I finding; Q1 retains
arbitrarily late incompatibility or prescribed lattice exclusion.

The extension inquiry completed at 12:52:35 UTC, within its bound. One
explicit proposed universal stencil, (1,1+3*tau_N,1+4*tau_N), fails at
actual N=2,q=4095,tau=3: all three pair projections pass with zero circulation.
An exact overlap and reduced changed-entry sampled-cell witness explain the
failure. No other triangle or omitted intermediate carries were evaluated.
Parent unchanged-copy replay passed with identical receipt and all eight
originals preserved. Separate paper review by `/root/generating_review`
completed with no D/I item; Q1 retains other cycles, actual lattice placement
and an eventual variant allowing exceptional anchors. Full five-path
integration review by `/root/logarithmic_source_review` completed with no
new D/I item and that late estimate retained open. Documentation (93),
process tests (38), whitespace and preservation checks passed. These are
not new arbitrary-late or kernel results; unchanged Lean was not rebuilt.

At 12:50:18 UTC a fresh-context `/root/bbp_sum_source_recovery` began a
**20-minute** primary-source/mechanism inquiry, deadline 13:10:18 UTC,
scratch `/tmp/pi-m4-bbp-sum-source-recovery-20261127/`. It examines at most
two precise estimates for reciprocal/exponential sums and maps their objects,
averaging variables and ranges to the initialized full BBP prefix. The
endpoint is an applicable source/consumer or a worked failed transfer and
changed question, not a generic bibliography or seed-averaged estimate.
No unfinished source claim is adopted. C_odd, V and M4 remain open.

**Reciprocal sums and a finite-ring inquiry — 2026-11-27 UTC:** the
coupled-cycle checkpoint is local commit
`02efb999a5d24a8588cd120636590984d1f14079`. Required reviews, checks,
exact staging and post-commit necessity/preservation inspection passed.
At inspection the branch was eight ahead of its remote-tracking reference,
index empty and task-owned tree clean. This run issued no push or PR.

The two-source inquiry completed at 12:57:04 UTC, within its bound.
Denominator clearing does not yield modular inverses; an exact auxiliary
modulus repairs that algebra but preserves the full cumulative BBP phase.
Its individual inverse phases instead align at each fixed frequency, with
an explicit harmonic error bound. The inspected source estimate has the
wrong averaging statistic and an unavailable length range. The second source
gives existential bad moduli, not control of the selected BBP sequence.
Parent replay passed 3,612 exact checks with identical output and 15 original
evidence files preserved; the unrelated Swift rendering cache is excluded.
Both primary PDFs were opened and all five retained source pages visually
inspected. Neither full external proof was independently audited.
Separate review and focused D1 repair completed: source comparability is
written as comparability, not asymptotic equivalence. Q1 retains the missing
time-prefix cancellation estimate. Authoritative v2 is
`/tmp/pi-m4-bbp-sum-source-clarification-20261127/report-v2.md`.
This completed assessment awaits production integration; no V result follows.

At 13:02:24 UTC `/root/bbp_sum_source_recovery` began a distinct
**20-minute** finite-ring inquiry, deadline 13:22:24 UTC, scratch
`/tmp/pi-m4-finite-ring-cocycle-20261127/`. It tests whether the actual
rational skew recurrence admits a rational conjugacy of uniformly bounded
degree usable on the initialized short prefix. The endpoint is such a
consumer or a proved complexity/pole obstruction, with function-field
identities distinguished from evaluation at poles and from total finite-ring
maps. At most two claims and six declared primes are tested; no actual
digits or phases are evaluated. No unfinished claim is adopted. V/M4 remain open.

The finite-ring inquiry completed at 13:16:08 UTC, within its bound. The
unique rational conjugacy has exact pole counts asymptotic to 5p/8. Canonical
finite parts solve the evaluation issue with a polynomial of degree p-3.
Split-prime prefixes are regular, but residue r_0=0 alone does not imply
finite part C(0)=0. The inspected completion/conductor bound is vacuous.
Parent replay passed 618 exact checks with identical output and 15 evidence
files preserved; both primary PDFs and all four retained source page images
were inspected. Deep Fourier/ramification proofs were not audited in full.
Separate review found no defect; I1 (real-comparison sign) and I2 (finite-part
domain) were resolved in immutable v2 and focused review. Q1 retains the
selected short-prefix estimate; the original Q2 constant question was then
addressed separately, not retroactively treated as proved in that packet.

At 13:13:30 UTC `/root/finite_log_constant` began a **12-minute** question,
deadline 13:25:30 UTC: prove or refute C(0)=0 for all split primes p>5,
using the finite-log reduction. It completed at 13:20:23 UTC with a paper
proof. The exact root filter and finite-log four-term identity prove the
vanishing without a p-adic infinite-series substitution. Parent replay
passed the supplied exact algebra and only the six already declared primes,
with identical output and all five original files preserved. Independent
`/root/finite_log_independent_review` completed at 13:25:58 UTC with no D/I
finding; its Q1 retains short-prefix cancellation. The result is paper
mathematics, not a new Lean theorem or visitation estimate. Its sealed
packet is `/tmp/pi-m4-finite-log-constant-20261127/`.

At 13:25:31 UTC `/root/bbp_sum_source_recovery` began a new **20-minute**
consumer inquiry, deadline 13:45:31 UTC, scratch
`/tmp/pi-m4-split-prefix-consumer-20261127/`. It tests at most two exact
uses of the vanishing constant and residue geometry for the selected short
prefix, first a low-complexity restricted representation with quantified
degree/error. Global bounds cannot be applied to that prefix without a
separate argument. The endpoint is an applicable estimate or worked failed
transfer and changed question. No new prime sampling, actual digit/phase
census or unfinished claim is adopted. V/M4 remain open.

Full five-path integration review completed at 13:33:13 UTC with no defect;
its one source-discrepancy clarification passed focused review at 13:34:34
UTC. The actual selected-prefix estimate remains open. Documentation (93),
process tests (38), whitespace and protected/unrelated preservation checks
passed. This checkpoint records paper results only; unchanged Lean was not
rebuilt. Research continues through the separate consumer inquiry.

**Restricted-prefix consumers and a fresh reset — 2026-11-27 UTC:** the
finite-field checkpoint is local commit
`8938b680031fcb878481d915871eec734e6760dd`. Its reviews, checks, exact
staging and post-commit necessity/preservation inspection passed. The index
was empty and task-owned tree clean; the branch was nine ahead of its
remote-tracking reference. This run issued no push or PR.

The short-prefix inquiry completed at 13:35:46 UTC, within its bound.
Its two tested mechanisms retain exact/approximate representations as
different questions and distinguish termwise Taylor error from collective
cancellation. Parent read the complete paper/checker and replayed 937 exact
algebra checks, with identical receipt and all five original files preserved.
Separate paper review completed at 13:39:50 UTC, with no defect. I1--I2
were resolved in immutable v3: the modular approximation needs a uniform
margin as T grows, and a field representative changes by a multiple of p.
Q1 retains the selected-prefix estimate, including moving starts and collective
cancellation outside these obstructions. No new visitation claim is adopted.

At 13:32:35 UTC a fresh-context `/root/m4_unused_structure_reset` began a
**20-minute** meta-plan discovery pass, deadline 13:52:35 UTC, scratch
`/tmp/pi-m4-unused-structure-reset-20261127/`. It seeks at most two materially
different uses of BBP-specific structure with an actual pointwise consumer,
starting with an exact test of a possible nonlinear period constraint.
The failure inventory explicitly excludes another linear alternate state,
null gauge, generic completion or unconsumed classification. The endpoint is
a worked candidate or failed transfer with its first missing implication.
No actual digit/phase census or unfinished candidate is adopted. V/M4 remain open.

The restricted-prefix checkpoint's full integration review completed at
13:45:26 UTC with no new D/I item. Its actual selected time-sum estimate
remains open. Documentation (93), process tests (38), whitespace and
preservation checks passed. No Lean change or rebuild; the ongoing
nonlinear-period inquiry remains outside this reviewed result.

**Quadratic-period enclosure and primitive cost — 2026-11-27 UTC:** the
restricted-prefix checkpoint is local commit
`fa00e24728bda3d391c16f8cf9dc6f4018e395ef`. Its reviews, checks, exact
staging and post-commit scope/blob/preservation inspection passed. The index
was empty and task-owned tree clean; the branch was ten ahead of its
remote-tracking reference. This run issued no push or PR.

The fresh reset completed at 13:46:21 UTC, within its bound. It tested a
separate pi-squared BBP series as a costed scalar enclosure and a mixed
quadratic period's leading-tail cancellation. Same-cutoff comparison,
canonical-floor terms and the avoiding model's lost hypotheses remain explicit.
Parent read the report/checker and replayed the exact-fraction checks with
identical receipt and all four original files preserved. Independent paper
review completed at 13:54:39 UTC with no defect. I1--I2 were resolved in v2:
use theta_n=y_(n+1) in the floor paragraph and distinguish the Cauchy square
from termwise squaring. Q1 retains actual placement; Q2 retains varying
quadratic costs and possible factorization. No visitation conclusion follows.

At 13:51:32 UTC `/root/m4_unused_structure_reset` began a **20-minute**
follow-up, deadline 14:11:32 UTC, scratch
`/tmp/pi-m4-primitive-quadratic-cost-20261127/`. Its one question is whether
varying primitive integer combinations of the actual linear and quadratic
prefixes can reduce the cost of the same-cutoff enclosure. It tests an exact
prime-product divisor of the displayed primitive quadratic's leading
coefficient, then charges the actual scale and inverse-branch derivative.
Primitive content and possible factorization are separate issues. The
endpoint is a proved cost statement with its actual consumer limits, or a
counterexample; no height bound alone is treated as phase separation. The
preceding packet completed separate paper review; this follow-up supplies no
adopted result before its own completion and review. V/M4 remain open.

The primitive-cost inquiry completed at 14:01:33 UTC within its bound.
Its exact odd divisor survives varying primitive coefficients, zero residual
and content removal; complete height, factorization and normalized root error
remain separate. Parent replay passed with identical receipt and four preserved
originals. Independent paper review completed at 14:06:20 UTC with no defect;
I1 was resolved in immutable v2 by distinguishing scaled and normalized branch
coordinates. Q1 retains coupled accuracy/height; Q2 retains actual placement.

Using the observed clock baseline 14:02:38 UTC, the parent undertook a
**10-minute** rational-root consumer test, deadline 14:12:38 UTC, scratch
`/tmp/pi-m4-quadratic-root-consumer-20261127/`. It completed at 14:04:32 UTC.
An exact parametrization puts every rational point of the actual two-sided
enclosure on the selected positive branch of some primitive quadratic. Its
residual still contains the unknown distance to that point. Exact checks
passed on 96 rational stand-ins, including 32 positive-branch and 16 zero
boundary cases. Separate `/root/finite_log_independent_review` criticism
completed at 14:06:23 UTC with no D/I item; Q1 retains joint height and
placement control. No universal root-cost impossibility or visit is inferred.

At its first clock reading, 14:09:46 UTC, fresh-context
`/root/m4_higher_rank_consumer` began a **20-minute** qualitative-dynamics
consumer inquiry, deadline 14:29:46 UTC, scratch
`/tmp/pi-m4-higher-rank-consumer-20261127/`. It assesses at most one primary
closed-set/nonlacunary-semigroup theorem and one actual prime-7 transfer.
The test asks whether an additional multiplicative invariance of the actual
omega-limit set follows, retaining floors, initialization and real defects.
An irrational initial point does not automatically put an irrational point
in its omega-limit set; the source consumer must handle that distinction.
No p-adic congruence is treated as a real matching estimate. The endpoint
is an applicable qualitative bridge or a worked failed transfer with the
exact remaining premise. No unfinished result is adopted; V/M4 remain open.

The combined quadratic-family integration review completed at 14:17:20 UTC
with no new D/I item. Coupled complete height/accuracy and actual forbidden-set
placement remain open. Documentation (93), process tests (38), whitespace and
preservation checks passed. Unchanged Lean was not rebuilt. The qualitative
prime-transfer inquiry is excluded from this reviewed mathematical result.

The quadratic-family checkpoint is local commit
`fb800d8d599295c0cb76d3d865eab3516b47e894`, parent `fa00e247`.
Exact staged scope/diff/blobs, working/staged whitespace and post-commit
necessity/preservation inspection passed. The index was empty and task-owned
tree clean; the branch was eleven ahead of its remote-tracking reference.
This run issued no push or PR. The checkpoint leaves V/M4 open.

The qualitative-dynamics inquiry completed at 14:20:18 UTC within its bound.
Its sealed report is `/tmp/pi-m4-higher-rank-consumer-20261127/report-v1.md`.
Parent read its full argument/checker, inspected the primary theorem's printed
pages 47--48 as text and rendered images, and replayed the unchanged checker:
35 exact checks, identical receipt, eleven original packet files preserved.
Independent paper review is pending; no new mathematical conclusion is adopted
before that review. Its remaining proposed premise is arbitrary late-index
real matching, not a p-adic congruence.

At 14:25:12 UTC the same generator began a **20-minute** follow-up, deadline
14:45:12 UTC, scratch `/tmp/pi-m4-off-index-matching-20261127/`. It tests all
fixed finite lag choices, including negative lags and adaptive signs, then
at most one unbounded index rule supplied by the extraction. The endpoint is
a rigorously allowed/excluded class with the actual initialized block/tail
terms retained, or a surviving precise estimate; finite tests cannot supply V.
The original sealed packet remains unchanged and under separate criticism.

Independent `/root/generating_review` completed the qualitative-consumer
paper review at 14:27:37 UTC, within its 15-minute bound. No D/I item was
found; Q1 retains the complete arbitrary late-index real matching premise.
It reconstructed the rational-only and finite-limit-set cases, source
contract, quantifier equivalence, exact block/tail identities and limsup
obstruction. Source dependencies earlier than the two inspected pages were
not fully audited. Production integration is pending; V/M4 remain open.

At 14:27:45 UTC `/root/m4_exact_structure_reset` began a **20-minute**
fresh-context discovery pass, deadline 14:47:45 UTC, scratch
`/tmp/pi-m4-exact-structure-reset-20261127/`. Its question is whether the
exact low-degree rational forcing or initialized period has a useful
feature lost by the recorded nondense countermodels. It must choose one
candidate and perform a discriminating calculation, retaining the first
unproved bridge. It excludes the current index-matching work, repeated
Borel/monodromy, quadratic and finite-field classifications, and numerical
digit/prime censuses. No unfinished result is adopted.

The index-rule inquiry completed at 14:35:15 UTC within its bound. The
finite-lag and compressed-index exclusions retain adaptive signs, negative
lags and positive limsup bounds. Return-conditioned fiber coverage is a
separate unproved sufficient condition, not refuted by those bounds. The
fixed-prime moment model applies at P={7}, distinguishing valuation classes
from the exact defect values and finite-pole forcing. Parent replay passed
43 checks, identical receipt and five preserved originals. Independent
paper review completed at 14:40:42 UTC, with no D/I item; Q1 retains the
real estimate at selected returns. Production integration remains pending.

The exact-structure reset completed at 14:38:59 UTC. It uses the exact
rational coefficient ratio to eliminate the homogeneous mode, retaining an
integer rounding defect with primitive coefficients of order n^6. Its
Bezout certificate bounds content independently of n; actual irrationality
forces normalized residual spikes. The two avoiding comparisons keep exact
A but lose the zero fractional seed and rational raw samples. Suspend the
proposed local small-error consumer: no actual avoidance estimate follows.

Parent found an evidence-label error in the sealed checker: zero was among
its purported synthetic seeds, so it computed actual initialized floors
for n<24. The immutable repair completed at 14:41:26 UTC within a five-minute
bound, removing only that seed and recording the historical error. Parent
unchanged-copy replay passed 2,769 checks, identical receipt, and preserved
all five original plus six repaired files. Independent paper review completed
at 14:44:32 UTC, resolving D1 with no new defect or improvement. Q1 retains
the missing avoidance-to-small-residual implication; the mathematical claims
were unchanged. Full combined integration and repository checks are pending.

Full six-path integration review completed at 14:52:34 UTC. Historical D1
remains resolved. I1 was resolved by calling the canonical-floor terms an
integer contribution, not floor(R_sigma); the remaining fractional-part
combination need not lie in [0,1). Q1 retains real matching/return selection,
and Q2 retains the missing avoidance-to-small-residual implication.
Documentation (93), process tests (38), whitespace and preservation checks
passed. Unchanged Lean was not rebuilt. Later source research is excluded
from this checkpoint, which leaves V/M4 open.

The qualitative-density/exact-carry checkpoint is local commit
`d78b31e70a254bf90f192e676f14c79c0e713010`, parent `fb800d8d`.
Exact staging and post-commit scope/blob/necessity/preservation inspection
passed. The index was empty and task-owned tree clean; the branch was twelve
ahead of its remote-tracking reference. This run issued no push or PR.

From 14:48:26 to 14:52:51 UTC, within a **20-minute** bound ending 15:08:26,
`/root/m4_recurrence_source_consumer` tested one direct arithmetic source for
the exact rational recurrence. Scratch report:
`/tmp/pi-m4-recurrence-source-consumer-20261127/report.md`. No applicable
visitation contract was found. Luca's publisher abstract concerns prime
support; the full theorem/PDF was unavailable, so no full theorem application
is asserted. Elementary comparison with the already reviewed denominator
rate shows that the advertised output supplies no new placement information.
Independent review completed at 14:58:56 UTC with no D/I item; Q1 retains
actual numerator placement. Parent checked the complete report and all four
manifest-bound hashes. No numerical or Lean checker was required. The
unsuccessful bounded search is not a literature-wide impossibility claim.

At 15:00:53 UTC `/root/m4_nonlocal_avoidance_reset` began a **20-minute**
fresh-context backward investigation, deadline 15:20:53 UTC, scratch
`/tmp/pi-m4-nonlocal-avoidance-reset-20261127/`. It starts from permanent
omission of a fixed word/interval and seeks one nonlocal consequence using
both exact rational forcing and the actual rational zero initialization.
The discriminating test must separate the known changed-seed and analytic
moment models, retain the first unsupported step, and avoid another scalar
height/divisibility reformulation. No unfinished result is adopted.

That inquiry completed at 15:15:29 UTC. It found no new initialized
avoidance consequence. Its explicit uniform rational automaton telescope
class loses phase dependence; the displayed discounted enlargement returns
only the known period and state endpoints. Parent unchanged-copy replay
passed with identical evidence and five preserved originals. Independent
paper review completed at 15:21:31 UTC; I1 requested the full endpoint sum
and separate C=0 case. An immutable clarification completed at 15:21:18 UTC,
and focused review at 15:22:31 resolved I1. Q1 retains a new restriction
on the actual selected path. These are paper arguments, not Lean proofs.
Full production integration remains pending.

At 15:32:01 UTC `/root/m4_nonlocal_avoidance_reset` began a **20-minute**
inequality inquiry, deadline 15:52:01 UTC, scratch
`/tmp/pi-m4-zero-entry-inequality-20261127/`. It tests one discounted
quadratic distance from an exact-forcing even-carry comparison, preserving
the actual zero-entry difference. The discriminator is whether an even-branch
sign inequality can accumulate from that known boundary. Eventual even carries
are only a weaker test: C_odd and V remain open. A changed-seed comparison
must retain its lost hypotheses explicitly. No unfinished claim is adopted.

The source/automaton six-path integration review ran 15:39:55--15:42:38 UTC
within twelve minutes, with no defects. I1's endpoint correction remains
resolved. I2 clarified that freely chosen scalar boundaries may contain A;
the classification removes phase/entry dependence, not every appearance of
A. The immutable paper v3 and production delta passed focused review at
15:44:01 UTC within six minutes. Q1 retains an actual selected-path
restriction; Q2 retains numerator placement. All 62 revised-manifest files
matched. Documentation (93), process tests (38), whitespace and preservation
checks passed; unchanged Lean was not rebuilt. The unfinished inequality
inquiry was excluded. This checkpoint leaves V, C_odd and M4 open.

The boundary/source checkpoint is local commit
`dace798dd2c1fd77a766f89b063629afb9125b7e`, parent `d78b31e7`.
Exact staging and post-commit scope/blob/necessity/preservation inspection
passed. The index was empty and task-owned tree clean; the branch was
thirteen ahead of its remote-tracking reference. This run issued no push or PR.

At 15:40:47 UTC `/root/m4_joint_structure_discovery` began a **20-minute**
fresh-context meta-plan pass, deadline 16:00:47 UTC, scratch
`/tmp/pi-m4-joint-structure-discovery-20261127/`. It seeks one mechanism
using both rational initialization and exact finite-pole forcing. Its chosen
test compares the real capacity gain of a long avoiding block against the
arithmetic cost of growing multitime determinants, retaining all floor terms.
This tests whether joint cancellation changes the scale, rather than repeating
fixed-order signs or scalar potentials. No unfinished claim is adopted.

The zero-entry inequality inquiry completed at 15:44:58 UTC within its bound.
The un-tilted square has valid even-branch nonincrease but no negative boundary;
the fixed tilt has the actual negative boundary but a positive increment
239/245760 in an exact-A changed-seed even-tail model. The arbitrary-threshold
identity retains the full finite past. Near-zero irrational comparison seeds
also retain the boundary sign while losing rational initialization. Suspend
this tilt; a new actual low-even contribution bound and late boundary remain
unproved. Parent unchanged-copy replay passed with identical evidence and five
preserved originals, without actual orbit or ceiling evaluation.

Independent paper review ran 15:46:29--15:48:57 UTC within ten minutes.
No defect was found; I1's explicit N>=1 domain was resolved in a separately
inspected immutable clarification. Q1 retains the actual late boundary and
low-even contribution. Full production integration remains pending; these
paper diagnostics do not discharge C_odd or V.

The determinant discovery completed at 15:56:53 UTC within its bound.
Parent read its complete report and checker and replayed a copy changing
only the receipt destination. All sixteen synthetic fixtures passed with
identical receipt and five original files preserved. Its proposed arithmetic
gain and capacity countertest are under independent review; no unfinished
claim is adopted here.

At 16:00:00 UTC the same worker began one **15-minute** follow-up,
deadline 16:15:00 UTC, scratch
`/tmp/pi-m4-hankel-linear-horizon-20261127/`. The question is whether the
original countertest's very late start leaves a viable linear-horizon case.
The proposed discriminator shifts the periodic pulse away from the endpoints,
controls its least singular value, and approximates an exact-forcing comparison
by a coprime numerator on the actual denominator grid. It must prove canonical
cell stability and distinguish exact denominator from the actual numerator.
This is a test of the remaining scale issue, not a new visitation claim.

Independent Hankel paper review ran 15:58:13--16:01:06 UTC within ten
minutes, found no defects, and resolved I1 by explicitly fixing the carry
block in the affine-state identity. Q1 retains nonvanishing and global
subquadratic denominator growth; Q2 retains actual-history decay. The critic
reconstructed both the rank-one arithmetic bound and finite-block countertest,
including its large-start restriction and lost actual entry/denominator.
The linear-horizon follow-up was excluded. Full production integration remains
pending; no conditional estimate was promoted to a visitation result.

The linear-horizon follow-up completed at 16:06:08 UTC within its bound.
It retains the exact actual reduced entry denominator and m=N, but chooses
a different coprime numerator. A shifted pulse and operator norm estimates
give avoiding canonical cells and determinant magnitude >34^(-N). The
finite threshold follows from the retained denominator rate 6N+o(N), an
elementary coprime-interval count and log256<6. The actual selected numerator
and full determinant-denominator estimate remain absent. Parent replay
changed only the receipt destination, passed thirteen synthetic fixtures
with identical receipt, and preserved five originals. No actual denominators
or phases were evaluated.

Independent paper review ran 16:07:05--16:09:24 UTC within ten minutes,
with no D/I item. Q1 retains actual-history decay, Q2 the complete arithmetic
contract. The prior denominator theorem remains a paper input, not a fresh
source-proof or Lean audit. Combined production integration is pending.

Full six-path integration review ran 16:12:10--16:15:24 UTC within fifteen
minutes. The quadratic-domain and fixed-carry clarifications remain resolved;
there were no new D/I items. Q1 retains the late boundary/low-even contribution,
Q2 the complete determinant arithmetic, and Q3 actual-history decay. All 79
manifest-bound files matched. Documentation (93), process tests (38), whitespace
and preservation checks passed; unchanged Lean was not rebuilt. The unfinished
selected-numerator inquiry was excluded; C_odd/V/M4 remain open.

At 16:09:14 UTC `/root/m4_selected_numerator_discovery` began a **20-minute**
fresh-context inquiry, deadline 16:29:14 UTC, scratch
`/tmp/pi-m4-selected-numerator-discovery-20261127/`. Its initial discriminator
tests backward exact recurrence with earlier odd-denominator grids, asking
whether arithmetic ancestry supplies a real-position estimate beyond unique
reconstruction of the zero-initialized point. Reversible CRT or a renamed
initial condition alone would not advance the target. No unfinished claim
is adopted; this research continues beyond the reviewed checkpoint. During
the cycle it moved to a quantitative coefficient-function perturbation test,
subject to the archived null-gauge and finite-prefix limitations.

The inequality/Hankel checkpoint is local commit
`0a213cc0588dbd2fc0bf0eae28c13451e2286a12`, parent `dace798d`.
Exact staging and post-commit scope/blob/necessity/preservation inspection
passed. The index was empty and task-owned tree clean; the branch was
fourteen ahead of its remote-tracking reference. This run issued no push or PR.

The selected-numerator discovery completed at 16:26:43 UTC within its bound.
Ancestry and coefficient perturbation returned archived reconstruction/transport
gaps and were not adopted as new results. The distinct reset-limit test yields
an explicit R sufficient for V, but requires exceptional N^(-2) returns to 1/3
with scale coverage. A direct measure argument gives generic exact-A visiting
comparisons failing R, without refuting it for pi. Moving centers leave only
the original phase identity. Parent unchanged-copy replay passed 80 synthetic
checks, identical receipt and five preserved originals. Independent review ran
16:28:12--16:30:20 UTC within ten minutes with no D/I item; actual fine returns
and moving-center residual placement remain open.

After a preliminary three-query source screen, a five-minute assessment ran
16:22:09--16:25:04 UTC, deadline 16:27:09. The Fuchsian holonomic paper's
discrete density passage has a linear-largest-phase hypothesis, excluding
direct application to the exponential phase here. Both relevant PDF pages
were inspected as text and images using the existing Swift renderer after
unavailable Poppler/default-Python tools; nothing was installed. Independent
review ran 16:25:47--16:27:21 UTC within six minutes with no D/I item. The
full source proof was not audited. Both bounded outcomes leave V/M4 open;
full production integration is pending.

Full integration review ran 16:40:24--16:42:46 UTC within twelve minutes,
with no D/I item and all three mathematical questions retained open. The
frozen five-path scope and complete capture are in
`/tmp/pi-m4-reset-source-review-20261127/`. Documentation (93), process
tests (38), whitespace and preservation checks passed; no Lean changed.

**Next discovery cycle, twenty minutes from the worker's first clock:**
fresh-context `/root/m4_history_interaction_reset` owns scratch
`/tmp/pi-m4-history-interaction-reset-20261127/`. It seeks one interaction
between exact rational-function forcing and the full initialized history
that the changed-numerator countermodels lose. The endpoint is a concrete
discriminating claim/test or an honest failed bridge, not a list of methods
or another denominator-only classification. The parent continues the pending
reset/source integration independently; no unfinished candidate is adopted.

The reset/source checkpoint is local commit
`13192550d5c9e6e47ce4bc412f396cb4473315e6`, parent `0a213cc0`.
Exact staging and post-commit scope/blob/necessity inspection passed at
16:45:02 UTC, with empty index, clean task-owned tree and all protected and
unrelated hashes preserved. The branch was fifteen ahead of its remote-tracking
reference; this run issued no push or PR. The fresh discovery started at
16:39:12 UTC with deadline 16:59:12. Its first history annihilator reduced to
the known telescope and was suspended; the changed test concerns a
multiplicative history identity and its zero-start boundary. No claim is adopted.

The fresh history inquiry completed at 16:54:07 UTC. Its product factors
exactly into the final phase difference divided by e(A(0))-1, on the stated
nonzero-intermediate domain; the initial zero contributes no further term.
The pi-phase lift exposes the unknown carry sign, which absolute values
discard. This is failure of one proposed mechanism, not a general product
obstruction or a new sufficient visitation estimate. Parent unchanged-copy
replay matched all synthetic evidence and preserved four originals. Separate
paper review ran 16:55:09--16:56:35 UTC within six minutes, with no D/I item
and actual signed history control retained open. Full packet:
`/tmp/pi-m4-history-interaction-reset-20261127/`; the
[review receipt](agy-reports/m4-continuation-review.md#initialized-multiplicative-history-test--2026-11-27-utc)
owns evidence limits. No actual future phases or new Lean results were obtained.

**Changed source-led question, 16:54:25--17:14:25 UTC:**
`/root/m4_rational_base_connection` owns
`/tmp/pi-m4-rational-base-connection-20261127/`. Seek a proved rational-base
orbit-exclusion mechanism using rational initialization, then test whether its
integer-divisibility argument survives exact BBP denominator clearing and a
multiple-branch forbidden-word language. The endpoint is one exact source
contract and discriminating transfer check, not a broad survey or an assumed
analogy. No source result is adopted while this inquiry is running.

The rational-base assessment completed at 17:02:24 UTC. Its singleton-residue
termination proof requires a fixed positive integer divisible by every q^n;
the changing BBP forcing and carry branches supply no such invariant.
Moreover floor(lambda) is integral for every real lambda, so this mechanism
does not exploit rationality of the raw seed. Parent unchanged-copy replay
passed 31 checks and preserved 23 top-level originals. The original packet
has no saved stdout receipt; no byte-identity comparison is claimed. Parent
read the selected primary source statement/proof as text; its PDF could not
be inspected visually. The [transfer assessment](m4-rational-forcing.md#a-rational-base-termination-proof-loses-its-fixed-integer)
retains the exact failure and source limits. Independent review is pending.

Independent source/paper review ran 17:07:28--17:08:38 UTC within six
minutes, with no D/I item. The actual branch/divisibility implication and
rational-seed distinction remain open. It verified the source contract,
BBP index offset and all retained originals; full integration is pending.

**Next changed representation, 17:07:39--17:27:39 UTC:**
fresh-context `/root/m4_euclidean_history_discovery` owns
`/tmp/pi-m4-euclidean-history-discovery-20261127/`. Seek one Euclidean or
matrix update retaining the actual canonical numerator and supplying a sign
or interval constraint. A complete encoding of the unknown numerator, the
archived Dedekind scalar correlation, or ordinary Padé/period shadowing is
not a sufficient endpoint. Reject such recodings early; no candidate is adopted.

The Euclidean inquiry stopped its candidate early, completing at 17:14:07 UTC.
Its [exact matrix update](m4-language-auxiliaries.md#a-local-euclidean-matrix-factor-does-not-select-carry-parity)
admits a synthetic collision: identical local triangular factor, denominator
and input matrix modulo 16, with opposite carry parity. This rejects only that
local consumer; the actual history and its denominator are not preserved.
Parent unchanged-copy replay matched 10,030 synthetic updates and two fixtures,
preserving six originals. The worker corrected one pre-delivery notation typo;
independent review ran 17:15:13--17:16:57 UTC within six minutes, verified the
correction and found no remaining D/I item. Actual-history selection stays open.

The next fresh inquiry, 17:14:18--17:34:18 UTC,
`/root/m4_direct_pi_discovery`, changes
from BBP numerators to a direct characterization of pi and the ordinary
hexadecimal orbit. Scratch ownership is
`/tmp/pi-m4-direct-pi-discovery-20261127/`.
It tests one geometric or trigonometric mechanism against exact modulo-one
precision and the selected lacunary indices. No unfinished claim is adopted.

Full five-path integration review ran 17:19:54--17:21:26 UTC within twelve
minutes, with no D/I item. A parent clarification explicitly retaining the
source's conditional Z-number hypotheses passed focused review at
17:23:07--17:23:10 UTC. All four mathematical questions remain open.
Frozen scope, complete captures and delta are in
`/tmp/pi-m4-history-source-matrix-review-20261127/`. Documentation (93),
process tests (38), whitespace and preservation checks passed; no Lean changed.

The history/source/matrix checkpoint is local commit
`5d25c54657f24df90c5513f9966e095f91408158`, parent `13192550`.
Post-commit scope/blob/necessity inspection passed at 17:26:16 UTC with
empty index, clean task-owned tree and all 28 preservation hashes matched.
The branch was sixteen ahead of its remote-tracking reference; no push or PR.

The direct-pi inquiry completed at 17:22:44 UTC. Its
[disk-count dissection](m4-transforms-and-periods.md#disk-count-dissection-cancels-the-area-coefficient)
cancels the area coefficient exactly. Fixed-shell asymptotics retain an
uncontrolled absolute tail and selected lacunary phases. This rejects the
tested consumer, not every geometric method. Parent source verification ran
17:26:49--17:32:38 UTC within six minutes; unchanged-copy replay passed with
identical output and three preserved originals. Independent paper/source
review ran 17:32:58--17:35:52 UTC within six minutes, with no D/I item and
uncancelled phase control retained open. Full integration remains pending.
No new Lean result or visitation premise is supplied.

**Next discovery bound, 17:34:30--17:59:30 UTC:** fresh-context
`/root/m4_initialized_arithmetic_reset` owns only
`/tmp/pi-m4-initialized-arithmetic-reset-20261127/`. Test whether exact
rational forcing together with prescribed rational initialization gives
a new arithmetic constraint on long avoiding carry histories. Rational-seed
equivalence and small-type interpolation were matched to archived failures
and suspended before redevelopment. The remaining discovery question concerns
congruence-preserving integer-valued functions; inheritance by canonical
floors is an unproved premise, not an available theorem. No unfinished claim
is adopted. V/M4 remain open and research continues.

Disk-count full integration review ran 17:40:24--17:41:54 UTC within ten
minutes, with no D/I item and uncancelled phase control retained open. The
frozen four-path scope and complete capture are in
`/tmp/pi-m4-disk-integration-review-20261127/`. Documentation (93), process
tests (38), whitespace and all preservation checks passed; no Lean changed.

The disk-count checkpoint is local commit
`ac9688f7bea43233bc45f7ee4bfc51474dd43750`, parent `5d25c546`.
Post-commit scope/blob/necessity inspection passed at 17:44:08 UTC, with
empty index, clean task-owned tree and all 28 preservation hashes matched.
The branch was seventeen ahead of its remote-tracking reference; no push or PR.

The arithmetic-reset discovery completed early at 17:47:21 UTC. Its
[higher-order concordance source](m4-generating-functions.md#higher-order-concordance-needs-a-new-arithmetic-hypothesis)
allows greater analytic growth but requires new integer congruences. Even
eventual first-order concordance of actual floors would force constant
carries; a continuous carry-tail extension to Z_2 would force periodicity.
Neither restriction follows from word avoidance. A synthetic rational-zero
comparison loses exact A and the reflected-zero anchor. Parent source and
algebra verification ran 17:48:37--17:49:46 UTC within five minutes; the
unchanged checker replay matched its output and preserved seven originals.

Independent paper/source review ran 17:50:05--17:53:54 UTC within six
minutes, including focused clarification inspection. No defect was found;
two wording improvements were implemented in an immutable addendum: the
checker certifies only the threshold comparison with 22/7, and odd denominators
are asserted at integer arguments. The new arithmetic implication from
actual avoidance remains open. Full production integration is pending; no
new Lean or visitation result is supplied.

**Changed source-led discovery, 17:51:37--18:16:37 UTC:**
`/root/m4_contracted_rotation_connection` owns
`/tmp/pi-m4-contracted-rotation-connection-20261127/`. Compare a proved
algebraic-parameter contracted-rotation theorem with exact reversed BBP
branches, preserving time dependence, branch selection and initialization.
The parent and worker are testing an autonomous inverse selector, including
its rational-partition special case. No unfinished source application or
selector theorem is adopted. V/M4 remain open and research continues.

Concordance full integration review ran 18:00:11--18:02:02 UTC within ten
minutes, with no defect, both source wording items resolved and the actual
avoidance implication retained open. A parent correction to the handoff's
stale opening pointer passed focused review at 18:03:45--18:07:14 UTC; its
two wording/anchor improvements were implemented and verified. The full
captures and deltas are in `/tmp/pi-m4-concordance-integration-review-20261127/`.
Documentation (93), process tests (38), whitespace and preservation checks
passed; no Lean changed.

The contracted-rotation worker completed at 18:03:59 UTC before its bound.
Its frozen packet awaits parent replay/source assessment and independent
review; no mathematical claim is adopted yet. A thirty-minute follow-up from
its own first clock, `/root/m4_global_inverse_history`, owns only
`/tmp/pi-m4-global-inverse-history-20261127/`. It investigates full inverse
history ordering with exact A and the zero root, with reassessment by fifteen
minutes. A translated survivor set or a different selected history is not a
visitation estimate. This is ongoing discovery, not M4 acceptance.

The concordance/navigation checkpoint is local commit
`ff5a5dbc7e63fa234062420abd3957f05afe9668`, parent `ac9688f7`.
Post-commit scope/blob/necessity inspection passed at 18:09:26 UTC, with
empty index, clean task-owned tree and all 28 preservation hashes matched.
The branch was eighteen ahead; no push or PR.

The [contracted-inverse assessment](m4-language-auxiliaries.md#contracted-inverses-do-not-yet-select-the-actual-history)
passed parent verification at 18:09:38--18:15:20 UTC within eight minutes.
Unchanged replay matched output and preserved sixteen originals. Independent
paper/source review ran 18:15:40--18:18:42 UTC within six minutes; no defect,
one finite-breakpoint wording improvement, and two selection/consumer questions
retained open. The immutable clarification passed focused review at
18:20:22--18:20:28 UTC. No source application to actual avoidance was obtained.

The [global inverse-history inquiry](m4-language-auxiliaries.md#full-inverse-order-does-not-isolate-the-zero-seed)
ran 18:08:04--18:26:02 UTC within thirty minutes, with reassessment at
18:10:15. It found an exact-A greedy failure, the essential odd-denominator
uniqueness filter, and conditional common-hole rational competitors matching
finite local data. Parent verification ran 18:26:29--18:27:52 within eight
minutes; unchanged replay matched 4,848 assertions and preserved 31 originals.
One worker real-bound failure was corrected and retained separately. Parent
clarification preserves asymptotic denominator growth for each fixed seed;
only exact profiles and uniform-in-family bounds are lost. Independent paper
review ran 18:28:15--18:31:18 UTC within six minutes, with no defect and two
wording improvements: identify the times in the finite count, and distinguish
unwrapped from normalized states. Both are implemented in an immutable
clarification and the production scope. Actual-history regularity remains
open; no new Lean or visitation result is claimed.

**Changed mechanism, 18:19:16--18:44:16 UTC:** fresh-context
`/root/m4_fresh_mechanism_reset` owns only
`/tmp/pi-m4-fresh-mechanism-reset-20261127/`. It tests AGM/Landen approximants
with exact algebraic initialization, accounting for degree, height and
conjugates before any digit-avoidance inference. Reassessment at 18:30:02
changed the test from a crude full norm to successive relative traces.
Unfinished claims are excluded from adoption; this is continued discovery,
not M4 acceptance.

Inverse-assessment full integration review ran 18:34:41--18:38:28 UTC
within ten minutes; no defect, all prior wording items verified, and the
selection/consumer obligations retained open. Its sole new improvement,
explicit circle sums and differences, passed focused review at
18:39:34--18:39:44 UTC. Exact scope and complete captures are retained in
`/tmp/pi-m4-inverse-integration-review-20261127/`. Documentation (93),
process tests (38), whitespace and preservation checks passed; no Lean changed.

The inverse-assessment checkpoint is local commit
`116f072de39aa7c291749e6f9b8bc2bfb053705b`, parent `ff5a5dbc`.
Post-commit scope/blob/necessity inspection passed at 18:43:27 UTC, with
empty index, clean task-owned tree and all 28 preservation hashes matched.
The branch was nineteen ahead; no push or PR.

The AGM discovery completed at 18:40:21 UTC within its 18:44:16 bound.
Its immutable final packet uses `agm-` filenames in
`/tmp/pi-m4-fresh-mechanism-reset-20261127/`. The assigned directory had
contained a historical Gaussian packet; two overwritten scratch files were
recovered exactly, and all seven original manifest hashes independently
matched after restoration. Old evidence is excluded from the AGM packet.
No repository file was affected by that collision. Future scratch ownership
must use a verified new path, not assume a date-based name is unused.

Parent source/arithmetic verification ran 18:37:33--18:44:37 UTC within ten
minutes. The unchanged checker replay matched 773 finite exact checks with
empty stderr and the final inventory preserved. An immutable correction
makes the initial D/U ratio comparison non-strict at m=1; its final strict
bound and trace conclusions are unchanged. Independent paper/source review
by `/root/agm_unit_review` began at 18:45:54 UTC, with a ten-minute bound.
No new Lean or visitation estimate is claimed; production integration awaits
that review. The compensated-double-trace follow-up uses a separate verified
new scratch directory and remains excluded from adoption.

The first AGM paper review completed at 18:49:48 UTC within its bound.
One earlier ratio defect was verified corrected; one residual-domain
clarification was implemented. Actual window visits and the full analytic
source audit remain open. A broader restoration check at 19:10:46 verified
all 28 scratch hashes from the historical integration inventory; its sole
nonmatching evidence entry was a production document changed by subsequent
reviewed work. No additional scratch loss was found in those inventories.

The compensated-F inquiry ran 18:46:07--18:57:24 UTC within fifteen minutes,
reassessed at 18:53:15. Parent verification completed at 19:04:51 within its
eight-minute bound; unchanged replay passed 132 exact checks with eleven
originals preserved. Independent paper review ran 19:05:10--19:08:10 within
eight minutes: no new defect or improvement, with interval placement and
source dependencies retained open. The smaller-field correction improves
precision by a polynomial factor but loses the former full window.

The exact-relative-norm Newton inquiry ran 18:59:02--19:07:40 UTC within
twelve minutes, reassessed at 19:04:02. It repairs that window loss, reduces
the ambient degree and has an explicit O(m) absolute Weil-height bound.
Parent verification began 19:10:27 with an eight-minute bound; unchanged
replay at 19:10:46 passed 200 checks and preserved seven originals. Independent
review ran 19:10:16--19:13:24 within the assigned 19:20:00 deadline; no defect
or improvement. Nonzero norm residuals, source limits and interval placement
remain explicit. No further approximation iteration was authorized by this
worker scope or adopted as the next research direction.

The selected-root inquiry ran 18:56:53--19:12:10 UTC within twenty minutes,
reassessed at 19:05:49. It proves at paper level that the tower has two real
embeddings and gives an exact norm-sign interval count. Its coefficient
recursions hold for arbitrary candidate words; the needed positive count is
unproved. The algebraic seed perturbation realizes arbitrary individual
finite windows while losing exact initialization and possibly conjugate
bounds; no fixed nondense model is obtained. Parent replay at 19:15:19 passed
143 exact checks and preserved seven originals. Independent review ran
19:13:12--19:16:22 within ten minutes, with no new defect or improvement and
the sign-count/source obligations retained open. The
[mathematical owner](m4-approximation-interfaces.md#agm-units-smaller-fields-and-the-missing-interval-estimate)
and [review evidence](agy-reports/m4-continuation-review.md#agm-approximations-and-selected-root-signs--2026-11-27-utc)
retain the exact distinctions; changed-file integration review is pending.

Fresh discovery continues in `/tmp/pi-m4-post-agm-discovery-20261127-1914/`,
with a twenty-minute bound from the worker's first clock and reassessment
within ten minutes. It seeks a different implication from actual permanent
avoidance, retaining initialized BBP structure lost by existing models.
Approximation acceleration without a visitation consumer is suspended.
V/M4 and even infinitely many odd actual carries remain open.

AGM full integration review ran 19:21:52--19:26:20 UTC within twelve
minutes, reassessed at 19:25:54. No new defect or improvement; the earlier
ratio correction and residual domains were verified in production. Actual
sign counts, conditional nonzero residuals and source-audit limits remain
explicit. The exact four-path diff and all 81 bound files matched; all 28
protected/unrelated hashes matched. Documentation (93), process tests (38)
and whitespace checks passed. No Lean changed. Complete evidence is in
`/tmp/pi-m4-agm-integration-review-20261127-1922/`.

The AGM checkpoint is local commit
`70666670dc9a017fad0fb77f0c13a8c6981340dc`, parent `116f072d`.
Post-commit scope/blob/necessity inspection passed at 19:29:22 UTC; index
empty, task-owned tree clean and all 28 preservation hashes matched. The
upstream tracking ref had moved to `116f072d` at 19:27:44, with reflog reason
"update by push"; this agent did not perform that push. The new AGM commit
is one ahead and remains local. No PR was opened.

The fresh discovery worker's actual bound is 19:14:55--19:34:55 UTC;
reassessment at 19:23:28 found no surviving new implication. A proposed
finite-entry test was matched to the existing generating-functions owner;
only genuinely changed word/quantifier consequences remain under inspection.
The parity-to-rigidity implication is still unproved. A separate parent
source screen from 19:22:25, bounded by 19:32:25, matched the exact Bourgain
short-sum application already recorded in the transform-phase owner and
stopped that duplicate. It supplies no new result.

A distinct fresh-context backward discovery pass,
`/root/m4_backward_structure_reset`, owns only
`/tmp/pi-m4-backward-structure-reset-20261127-1929/`, with twenty minutes
from its first clock and reassessment within ten. It excludes the active
carry-congruence branch and seeks a new exact-period constraint from permanent
avoidance. Unfinished claims are excluded from adoption. Research continues;
none of these checkpoints is M4 acceptance or a stopping condition.

The post-AGM worker completed at 19:31:51 UTC within its bound. Its retained
result is a word/quantifier extension of the old finite-entry sieve, together
with the elementary radius-one obstruction to the parity shortcut; no new
sufficient visitation implication survived. Parent replay at 19:33:19 passed
2,586 synthetic exact assertions and preserved six originals. Independent
review ran 19:33:13--19:34:58 within six minutes: no defect, one implemented
open-cylinder clarification, and the same-numerator/continuation obligations
retained open. The [owner extension](m4-generating-functions.md#every-finite-word-can-retain-the-dyadic-entry-precision)
is pending full changed-file review.

The fresh backward worker began at 19:27:48 UTC, with deadline 19:47:48 and
reassessment at 19:36:48. Its prime-power column decomposition and normality
source application are unfinished and excluded from adoption. The parent
recent-source screen ran 19:35:04--19:37:28 within ten minutes. It matched
the September 2026 logarithmic determinant to the exact previously assessed
commit and all four source blobs; no changed hypothesis or new consumer was
found. The preprint's theorem and external Lean scope remain unadopted here.
A handoff navigation pointer now makes that prior source assessment easier
to locate. Research continues under the unchanged V contract.

The column report froze at 19:42:01 UTC within its twenty-minute bound;
the worker's final unchanged replay finished at 19:43:27. Parent replay at
19:45:00 passed 1,208 exact synthetic checks, with five originals preserved.
Source pages and paper algebra were independently inspected by the parent
by 19:51 within eight minutes. Separate paper review completed at 19:48:53,
reassessed at 19:48:30; its initial clock was lost in compaction and only
the first recovered 19:47:02 and conservative 19:54 target are certified.
No defects or required improvements were found. Actual correlations,
uniform early visits and the insertion test's missing consumer remain open.
The [column assessment](m4-fourier-windows.md#normal-prime-power-columns-do-not-supply-a-sum-estimate)
and [review record](agy-reports/m4-continuation-review.md#prime-power-column-source-test--2026-11-27-utc)
retain the source and evidence limits. Neither this nor the finite-word
extension moves the checked proof frontier. Full integration is pending.

Two distinct follow-ups were assigned before integration: an eighteen-minute
uniform-window cost test, reassessing within nine minutes, and a twenty-two
minute fresh initialized-history investigation, reassessing within eleven.
Their bounds run from each worker's first clock. The former must test the
usable growing cutoff, not merely fixed-sum normality; the latter seeks a
constraint linking the same actual numerator across indices. Both own only
new scratch directories and their unfinished claims are excluded from adoption.
The parent continues M4; no local research bound is a stopping condition.

Full integration review of the finite-word and column checkpoint ran
19:54:16--19:56:41 UTC within twelve minutes, reassessed at 19:56:24.
No new defect or improvement; the prior open-cylinder clarification was
verified in production. The exact five-path diff, all 52 bound files and
28 preservation hashes matched. All same-history, analytic-continuation,
correlation and uniform-visit obligations remain open. Documentation (93),
process tests (38), and whitespace checks passed; no Lean changed.
Complete scope, validation and review capture are retained in
`/tmp/pi-m4-word-column-integration-20261127-1957/`. Research continues.

The finite-word/column checkpoint is local commit
`b98f4a458b4aa871301b09990b364a4997e32640`, parent `70666670`.
Post-commit scope/blob/necessity inspection at 19:59:46 UTC passed: exactly
five owned paths, empty index, owned tree clean and all 28 preservation
hashes matched. At that inspection it was two ahead of upstream `116f072d`.
This agent did not push or open a PR.

The uniform-column worker ran 19:50:29--20:03:07 UTC within eighteen
minutes, reassessing at 19:59:17. Its exact top-17 unit test succeeds for
all cutoffs and indices in the stated domains, but scaled orbit pieces
remain at most seven terms and denominator clearing loses the selected
unscaled branch. Parent replay passed 87,596 exact checks at 20:05:42;
paper reconstruction completed at 20:06:44 within nine minutes. Independent
review ran 20:07:10--20:10:04, reassessed 20:09:28, with no D/I and joint
visits/inverse-branch questions retained. The
[owner](m4-fourier-windows.md#the-unit-test-succeeds-but-the-available-orbit-pieces-stay-short)
states the partition-bound limit without claiming an actual discrepancy bound.

A parent source screen ran 19:55:31--20:01 within nine minutes after a
preliminary search. It inspected the September 2026 two-Stoneham-sum and
localized-logarithm claims and Vandehey's original short-sum statement.
Their fixed-parameter and sparse-insertion conditions do not supply the
actual uniform transfer. Review ran 20:03:03--20:06:17 within nine minutes;
no mathematical defect, one implemented serialization clarification, and
signed-sum/uniformity questions remain. Exact source bytes were preserved
separately during review; no external Lean proof was built or imported.

The initialized-history worker ran 19:50:47--20:06:59 within twenty-two
minutes, reassessed at 20:01:15. Its exact five-valuation permits two coherent
changed seeds preserving every forward denominator, while losing zero and
floors. A new source consequence makes each bounded fixed-support, fixed-hole,
fixed-threshold seed family finite. Actual avoidance has not supplied an
infinite such family. Parent replay passed 41,747 exact checks at 20:09:49;
reconstruction finished 20:11:15 within ten minutes. Review ran
20:11:34--20:15:02, reassessed 20:14:39, with no D/I. The
[profile](m4-generating-functions.md#coherent-seeds-can-preserve-every-forward-denominator)
and [common-hole](m4-generating-functions.md#fixed-odd-prime-support-limits-a-common-hole-family)
sections retain separate hypotheses. Full integration remains pending;
[review evidence](agy-reports/m4-continuation-review.md#column-unit-survival-and-profile-rigidity--2026-11-27-utc)
owns all dispositions and source limits.

Fresh-context `/root/post_profile_mechanism_reset` was assigned a twenty-minute
discovery bound from its first clock, reassessing within ten. It seeks a
different actual-period or initialized-history implication, with an archive
screen and a discriminating test, excluding more profile/approximation
refinements without a real-visitation consumer. Its unfinished claims are
excluded from adoption. No checked theorem or acceptance status has changed;
the parent continues the authorized M4 investigation.

The full unit/profile integration review ran 20:20:35--20:26:34 UTC within
twelve minutes, reassessing at 20:25:29. It caught one summary quantifier
defect: common-hole finiteness needs a bounded seed family, since integer
translates otherwise give a counterexample. It also requested an explicit
nonempty interval. Both repairs passed focused review at 20:28:45--20:29:31
within six minutes, reassessed at 20:29:21; no new findings. The prior source
serialization clarification remains verified. Exact initial scope, repair,
91-entry manifest and complete captures are retained in
`/tmp/pi-m4-unit-profile-integration-20261127-2020/`; all 28 preservation
hashes matched. Documentation (93), process tests (38), and whitespace passed,
with affected documentation/whitespace rerun after repair. No Lean changed.
All visit, branch, bounded-family and uniformity obligations remain open.

## M4 continuation: period division and point counting — 2026-11-27 UTC

The column-unit/profile checkpoint is local commit
`3f354d516832eb5970402696a61607cd193bb5c5`. Post-commit scope and blob checks
passed, with empty index, clean owned paths and all 17 protected plus 11
unrelated hashes preserved. The branch was three ahead of upstream
`116f072de39aa7c291749e6f9b8bc2bfb053705b` at inspection. This run made no
push or PR. The checkpoint does not complete M4.

Fresh discovery ran 20:12:20--20:28:41 UTC with a 20:32:20 deadline and
20:21:40 reassessment. [Period division and point counting](m4-generating-functions.md#period-division-does-not-create-a-common-hole)
supplied two scoped negative discriminators. Division does not propagate
avoidance to a suitable common-hole family. The actual rational BBP samples
have only logarithmic density in arithmetic height, compatible with the
Pila--Wilkie bound; retaining the fractional graph violates o-minimality,
while freeing the integer coordinate removes the transcendental remainder.
No positive visitation mechanism survived. A finite fixture initially missed
H(1/4,2)=4; the repaired result and failure are retained.

Parent assessment ran 20:36:33--20:37:55 within nine minutes. The unchanged
checker passed 257,126 exact tests with identical stdout and empty stderr;
all nine worker artifacts and thirteen inputs matched. Parent and separate
reviewer visually inspected original source pages 2--5. Paper review ran
20:38:15--20:42:49 within ten minutes, reassessing at 20:41:58: no defect or
actionable improvement; witness construction, raw-graph applicability and
pi-specific division propagation remain open. Full evidence/dispositions are
in the [review record](agy-reports/m4-continuation-review.md#period-division-and-point-counting--2026-11-27-utc).
No source proof or new Lean result is certified by these checks.

The next fresh-context pass seeks genuinely new arithmetic witnesses from
actual word avoidance, with a 22-minute bound from its first clock. A distinct
18-minute inquiry tests fixed-cutoff normality using the newly proved unit
property and sparse late insertions. This can remove a limited conditional
rung only; uniform visits before the approximation cutoff remain necessary.
Unfinished worker claims are excluded from adoption. Research continues.

## M4 continuation: fixed finite column normality — 2026-11-27 UTC

A distinct 18-minute inquiry ran 20:39:33--20:52:37 UTC, reassessing at
20:47:49 before its midpoint. The [fixed finite column argument](m4-fourier-windows.md#every-fixed-finite-column-sum-is-normal)
now proves on paper that every fixed actual T_M, M>=6, is 16-normal.
Global unit survival gives at most s_M homogeneous pieces per conductor
level; their weighted discrepancy costs sum geometrically. The resulting
bound tends to zero for fixed M. Real tail control and rational-affine
normality preservation transfer it to the actual finite signed sum without
assuming normality is additive. No new Lean theorem is claimed.

Parent read/reconstructed the proof and source displays, then replayed the
103,494 exact structural checks unchanged: exit zero, identical stdout,
empty stderr, all 18 worker artifacts preserved. Parent assessment completed
20:54:20 within its nine-minute bound starting 20:53:46. Independent paper
review ran 20:54:42--21:00:57 within twelve minutes, reassessing at 21:00:02;
no defect or corrective improvement. The [review record](agy-reports/m4-continuation-review.md#fixed-finite-column-normality--2026-11-27-utc)
retains every source/evidence limit and the two open questions.

This closes a limited paper rung, not V. The same estimate grows when the
cutoff and averaging horizon are comparable, while the guaranteed pi-transfer
window has that scale. Uniform early unscaled visits and inverse-branch
control remain missing. Fresh-context research now tests the exact connections
between short pieces rather than summing their errors independently, with a
20-minute bound from its first clock. Unfinished results remain excluded from
adoption; M4 and odd-carry infinitude remain open.

## M4 continuation: symbolic witness domains — 2026-11-27 UTC

Fresh-context discovery ran 20:35:42--20:51:09 UTC within 22 minutes,
reassessing at 20:46:15. It dropped fixed-window algebraic amplification as
already covered, then [tested symbolic pumping and finite tail edits](m4-generating-functions.md#symbolic-pumping-produces-the-wrong-arithmetic-witnesses).
A hypothetical nonperiodic missing-word path does produce new rational
periodic phases, but realizing them as BBP seeds requires irrational values.
Their repunit denominators also escape every fixed finite prime set. Finite
legal swaps retaining the actual tail instead produce infinitely many bounded
dyadic seeds with a common hole, conditional on V failure. Their unbounded
powers-of-two denominators defeat every single fixed rationally scaled odd
localization. No infinite admissible edit with the required arithmetic was
constructed; no positive V mechanism survived.

Parent replay at 20:53:00 passed 9,268 exact synthetic checks unchanged.
Assessment completed 20:57:23 within nine minutes. One fractional-prefix
versus full-period domain ambiguity was clarified in a separate immutable
addendum, preserving the original report and checker. Independent review ran
20:57:43--21:02:44 within ten minutes, reassessing at 21:01:50: earlier
all-15/coset defects and the domain repair verified; one fixed-slope family
clarification implemented, awaiting integration review. The [full dispositions](agy-reports/m4-continuation-review.md#symbolic-pumping-and-seed-domains--2026-11-27-utc)
retain the distinction between same-session criticism and independent review.
No actual pi phases or new Lean declarations were computed. The missing
infinite-edit construction, V/M4 and odd-carry infinitude remain open.

## M4 continuation: finite-normality integration review — 2026-11-27 UTC

The exact five-path integration received complete independent Codex review
21:07:58--21:15:36 UTC, reassessing at 21:12:15 within twelve minutes.
No new blocking defect was found. The pumping family clarification was
verified; one handoff clarification made the fixed odd support and family
quantifier explicit. Focused review 21:18:26--21:18:58 within six minutes
verified that repair with no new findings. All original mathematical
questions remain open. The [complete dispositions](agy-reports/m4-continuation-review.md#finite-normality-witnesses-and-point-count-integration--2026-11-27-utc)
retain immutable captures, manifests, preserved inputs and evidence limits.
Documentation (93) and whitespace passed after the repair; process (38)
remains the earlier unchanged-code result. No Lean or dependency changed.
The user-requested provenance search and separate joint-branch investigation
are excluded from this review. These internal checkpoints do not accept M4.

## M4 continuation: fixed-column provenance search — 2026-11-27 UTC

At the user's request, an independent literature lane ran 21:24:26--21:35:48
UTC within fifteen minutes, reporting at 21:30. It recorded 30 web queries,
five GitHub searches and primary-source inspections; the parent separately
searched the pinned Mathlib and inspected public Lean statements, definitions
and proof bodies. The [comparison](m4-fourier-windows.md#prior-work-and-existing-lean-machinery-for-the-fixed-column-result)
found no exact earlier T_M statement or Lean specialization. This is not an
originality determination. The argument developed here applies established
methods; a gap closed in this project is not thereby a literature open problem.

Anderson's general certificate theorem gives the qualitative conclusion after
our BBP-specific denominator proof. Its general Lean criterion, orbit estimate
and dilation theorem are source-visible; their external dependency chain was
not rebuilt or audited. Closely related signed same-prime and distinct-prime
BBP results have different hypotheses. Classical Bailey--Crandall estimates
remain the original argument's inputs. Parent inspected the certificate's two
theorem pages and signed-sum theorem page visually. A separate Codex source
review ran 21:32:47--21:38:50 within eight minutes, reassessing at 21:36:01:
no defect; missing normality definitions supplied and checked; one Kano base
hypothesis clarification implemented. The [complete record](agy-reports/m4-continuation-review.md#fixed-column-provenance-and-lean-search--2026-11-27-utc)
retains all evidence limits and dispositions. No external human review or
project Lean proof is claimed. The user received the search reports and links.

The user identified that checking classical ingredients had not included an
early search for this exact result and nearby generalizations. The
[meta-plan checkpoint](meta-proof-plan.md#prior-work-when-a-direction-changes)
now requires bounded early prior-work searches for materially new directions,
and exact-statement checks before originality language. Small refinements can
reuse an existing source map. The user approved retaining this for future use.
Fixed-M formalization has no assigned date; the early-visit bridge remains
the central mathematical gap. V/M4 remains open and research continues.

## M4 continuation: projected histories and the zero branch — 2026-11-27 UTC

The 20-minute inquiry begun 21:02:01 froze at 21:16:53, reassessing at 21:10:46.
It supplied the [exact integer branch and three restricted tests](m4-fourier-windows.md#the-zero-branch-and-what-the-scaled-projection-loses).
Complete projected histories admit changed rational seeds with arbitrarily
long early avoidance, although every fixed comparison period is normal. The
actual zero branch has a finite integer recurrence, but its target-cell
existence inequality remains unproved. A unique 137-pole prevents deletion of
the scaled-integral part of a 17-step block. Rounded forcing shadows the early
window but does not tend to zero; its static-period tail fails to vanish.
These tests do not refute V or rule out early visits of the actual branch.

Parent read the full report/checker and replayed it unchanged at 21:33:27:
exit zero, identical stdout, empty stderr, 53,682 structural checks with no
actual pi phase or initialized-prefix census. Assessment finished within nine
minutes. A literal raw-state closeness error was repaired by a separate
integer-centering addendum, preserving the original artifacts. Independent
review ran 21:35:38--21:38:36 within ten minutes, reassessing at completion:
that defect verified resolved; the distinction between raw lattice and
fractional finite grid is implemented for integration verification. The
[full review](agy-reports/m4-continuation-review.md#integer-branch-and-projection-tests--2026-11-27-utc)
retains every premise and open consumer. No Lean declaration changed. A new
bounded inquiry is testing structure that retains the full forcing and zero
anchor; unfinished results remain outside adoption.


### Provenance/branch integration review completed — 2026-11-27 UTC

The exact five-path production review completed at 21:59:45 UTC with no new
defect or improvement. Earlier centering, grid and Kano clarifications were
verified; all 91 evidence identities matched. The full cycle, retained early-visit,
source/Lean and originality limits, receipt clarification and read-only Git
procedure deviation are recorded in the [continuation review](agy-reports/m4-continuation-review.md#provenance-branch-and-prior-work-checkpoint-integration--2026-11-27-utc).
The meta-plan now retains the user's early prior-work checkpoint. This local
intermediate checkpoint does not complete M4; the signed-tail comparison and
actual visit investigation continue separately.


### Signed-tail windows and the simpler-prefix test — 2026-11-27 UTC

The bounded actual-tail investigation ran21:39:37–21:50:37 UTC, before its
21:57:37 endpoint. It proved a nonzero periodic leading coefficient for
16^L*(pi-T_(8L+6)), a sharp ordinary horizon on that family, and selected
integer-centered circular windows ending near L+(2-epsilon)log_16 L.
The exact forcing and zero entry were preserved; no visit was inferred.
The parent read the complete proof/checker, reconstructed the infinite bounds
and replayed148027 structural checks unchanged. Separate Codex review completed
21:57:48 with no D/I; Q1 retained the moving-window visit gap, and Q2 asked
whether the new window improved the full rational-prefix alternative.

The comparison cycle ran21:54:41–22:01:39, before22:06:41. Its exact centered
identity resolves Q2 for the present proposal: cutoff, full-prefix, pi and
driven phases have the same selected-window limit sets and fixed finite-frequency
averages. Existing ordinary prefix shadowing already reaches that scale at every
anchor, and its first rational correction reaches3log_16 L. The selected anchors
are exactly affine-geometric after fixing k modulo34, but their actual rational
phases cannot satisfy a fixed-order linear recurrence rational in the geometric
index: cumulative recurrence denominators grow logarithmically as O(t^2), while
the archived odd-prime denominator bound grows as a positive multiple of16^(34t).
The existing PNT dependency remains explicit. Parent replay passed5983 structural
checks; separate review completed22:07:38, no D/I, retaining actual phase placement.

The [mathematical owner](m4-fourier-windows.md#signed-cutoff-tails-and-their-full-prefix-comparison)
and [review record](agy-reports/m4-continuation-review.md#signed-tail-and-full-prefix-comparison--2026-11-27-utc)
retain proofs, packet identities and limits. Pure tail-window refinement is
suspended until a distinct visit consumer is supplied. A brief five-query
logarithmic/missing-digit source screen found no changed bridge beyond the
archived pointwise/whole-embedding gap; it is not counted as mathematical
progress. Its exact limits are in `/tmp/pi-m4-log-missing-digit-screen-20261127-2158/`.
A fresh-context critique now tests actual phase consumers and the strongest
simpler alternatives. M4, actual odd-carry infinitude and V remain open.


### Regular remote publication authorized — 2026-11-27 UTC

The user requested pushes every15 minutes during active work and at milestones,
results or new research directions. This is now a standing repository instruction,
with execution details in the [publication workflow](proof-workflow.md#regular-remote-publication);
the current prompt and handoff supersede their old no-push wording. Existing
review and validation gates remain, and pending research is not marked complete.
The five reviewed commits through `10cf104d9ece5467a0b49aa91885fa9a361e4957`
were pushed normally to `origin/feature/m4-universal-visitation`; the remote hash
was verified with `git ls-remote` (push result b08788, verification80fb88).
No PR was opened and unrelated working-tree material remained local.

Both the tail-comparison integration and prospective publication policy passed
separate exact-scope reviews. The applied composition passed93-document,
38-process-test and whitespace checks at22:19:07 UTC. Final publication receipts
follow in the same records; no Lean declarations or dependencies changed.
The next mathematical probe tests whether fixed-depth short differences retain
an exponential denominator in the actual initialized recurrence, including all
new forcing terms. A fresh critic supplied a candidate argument; it is not yet
independently checked or adopted as a theorem.


Publication receipt,2026-11-27 22:20:58 UTC: ordinary push completed and
`git ls-remote` verified `b5a6f2c1705102942e7c46b68a61ffb05bb9ac16` on
`origin/feature/m4-universal-visitation` (push b7a0ab, verification c48f7e).
The seven-path commit includes the reviewed tail comparison and durable regular
publication instruction. Post-commit scope/blobs, empty index, owned clean tree,
17 protected files and11 unrelated-file hashes were verified; necessity inspection
found no required simplification. No PR was opened. This receipt is an operational
record for the next checkpoint; confirm live state after restart.

### Actual short differences and prime activation — 2026-11-27 UTC

The fresh-context critique supplied an elementary gcd estimate and a fixed-depth
test for ordinary differencing. The parent reconstructed it and proved a uniform
extension to depth at most n^(1/2-eta), with total positive shift at most delta*n,
for fixed 0<eta<1/2 and 0<delta<1. The actual reduced denominator still has
logarithm at least 2(1-delta)n-o(n). The common large-prime interval keeps every
new forcing term integral at the surviving old poles. The existing PNT in the
progression 1 modulo 4 remains a paper input. This is a denominator bound, not
a character-sum or visitation bound; the stated operator regime is essential.

The cycle began 22:22:49 and froze 22:26:22, before its 22:34:49 endpoint.
Its unchanged structural replay passed 83,923 checks, with identical output and
empty stderr. No actual prefix, pi value, digit or carry was computed. The
parent also repaired the critic's singleton activation identity: two primes
can enter at once, so the exact complement subtracts their sum. Centered CRT
coefficients need not individually be large; the full joint conductor remains.
Separate Codex review completed 22:30:16: the repair was verified, no new defect
was found, and a fixed-frequency corollary was accepted for integration.
The [mathematical owner](m4-crt-phase.md#short-ordinary-differences-retain-an-exponential-denominator)
and [full review record](agy-reports/m4-continuation-review.md#actual-short-difference-paper-review--2026-11-27-utc)
retain the exact statement, proof, evidence identities and limitations.

The preliminary smooth-modulus source screen did not identify an estimate for
the coupled activated-prime product at the actual initialized numerator. It is
not an exhaustive audit or a proof input. The next source-fit question is whether
an available incomplete-sum theorem can handle both the surviving exponential
denominator and its dependent complement. V, odd-carry infinitude and M4 remain
open; no Lean declarations changed.

Remote synchronization was verified at 22:27:20 and again after compaction at
22:37 UTC: the branch still matched `b5a6f2c1705102942e7c46b68a61ffb05bb9ac16`
(latest verification result 21de24). There were no new ready commits; this
write-up was still awaiting integration review. The post-compaction check was
later than the 22:35:58 check target. This records the actual cadence miss rather
than backdating it; publication remains due promptly after the required review.

The exact four-path integration review completed at 22:43:05 UTC. No new D/I
was found; the simultaneous-activation repair and both arithmetic clarifications
were verified in production, with Q1--Q3 explicitly retained. All evidence and
preservation identities matched. Documentation (93), process tests (38) and
whitespace checks passed before review; outcome-only appends receive final
documentation and whitespace checks before the checkpoint is committed and pushed.
The [complete cycle](agy-reports/m4-continuation-review.md#short-difference-integration-review--2026-11-27-utc)
does not complete M4. A separate bounded source-contract inquiry is continuing.

Publication receipt, 2026-11-27 22:46:05 UTC: ordinary push completed and
`git ls-remote` verified `29eea2b5e71c3d52569c2afa174e2b7338641803` on
`origin/feature/m4-universal-visitation` (push 24a326, verification ef3442).
The four-path checkpoint passed final documentation and working/staged whitespace
checks. Post-commit parent/scope/blobs, empty index, owned clean files and all
preservation hashes matched; necessity inspection found no required repair.
No PR was opened. The next active cadence check is due by 23:01:05 UTC, or at
an earlier result/direction event; this timestamp is a receipt, not live state.

Continuation note, 22:48 UTC: the Chang/Wu--Xi source-contract inquiry has a
12-minute bound from its first clock at 22:40:45, with midpoint reassessment.
It tests exact phase, conductor and length hypotheses against both the actual
activated product and the archived finite-field zero-constant representation.
A fresh-context discovery pass was also launched with a 20-minute bound from
its own first clock. Its question is which unused actual BBP structure could
supply a signed phase or interval-exclusion estimate, rather than another size
bound. It must compare the archive, use early prior-work checks for new routes,
and identify the first unproved bridge. Both outputs remain pending assessment;
no new result is adopted by this note. At the direction event, remote verification
c3ce74 again matched `29eea2b5e71c3d52569c2afa174e2b7338641803` at 22:48:10 UTC;
no new reviewed commit was waiting.

### Chang and Wu--Xi source contracts — 2026-11-27 UTC

The source inquiry ran 22:40:45--22:50:04 UTC within its 12-minute bound, with
midpoint reassessment. Primary theorem pages and framework definitions give
precise failed direct transfers: Chang requires primitive multiplicative
characters, polynomial twists and much longer intervals; Wu--Xi requires
controlled local conductors and retains an ineffective fixed-pair cost at the
proposed logarithmic length. The strongest archived actual conjugacy, including
C(0)=0, was retained. A proposed rational-interpolation test was matched to the
existing stronger actual-prefix argument and excluded as new work.

The parent read the full report, inspected Chang pages 2/38 and Wu--Xi pages
19/23/32 visually, compared the remaining cited primary text, and verified all
50 artifact and 16 input identities. The source-contract mapping and actual
consumer are now recorded in the [owner](m4-crt-phase.md#two-smooth-modulus-source-contracts-do-not-supply-the-phase-estimate).
No source theorem, new Lean result or visitation estimate is adopted. The
parent's 10-minute assessment began at 22:50:32; exact-scope source/integration
review follows. The fresh discovery pass remains separate and unadopted.

Parent assessment froze at 22:53:29, before its 23:00:32 endpoint. Independent
source/integration review completed at 22:58:42 with no blocking defect. One
precision improvement was implemented and verified: distinguish positive
squarefree moduli in the general framework from Theorem 4.3's smooth family,
and state the natural lcm's additional coprime-factor/remainder obligations.
The actual source-class and signed-estimate bridge remains open. Full evidence
and all dispositions are in the [continuation review](agy-reports/m4-continuation-review.md#chang-and-wu--xi-contract-assessment--2026-11-27-utc).
Post-repair documentation and whitespace checks passed; final outcome records
are checked before publishing this checkpoint. No Lean or dependency changed.

Publication receipt, 2026-11-27 23:01:11 UTC: ordinary push and remote verification
completed for `dbba18d2cd3649bfb00392d26ac595b793fdc636` on
`origin/feature/m4-universal-visitation` (push aa71fe, verification 97f6a2).
Final documentation (93), working/staged whitespace, exact staged and committed
scope/blobs, parent, empty index, owned clean tree and all preservation hashes
passed. The earlier 38 process tests cover unchanged process code. Post-commit
necessity inspection found no required repair. The next active cadence check
is due by 23:16:11 UTC or at an earlier result/direction event; no PR was opened.

Continuation note, 23:14 UTC: the fresh discovery report froze at 23:06:35,
within its 22:48:12--23:08:12 bound. It proposes explicit actual-denominator
anchors whose complete rational periods are unions of fine grids. The parent
reconstructed the elementary Euler/LTE/CRT argument and replayed all three
synthetic checkers unchanged; receipts matched byte-for-byte. A separate parent
comparison, bounded 23:10:10--23:20:10 and frozen at 23:10:56, tests whether
natural inverse-power corrections make the grid traversal usable. Both paper
arguments are under independent review and are not adopted by this note.
At 23:14:31, remote verification 509ac6 still matched
`dbba18d2cd3649bfb00392d26ac595b793fdc636`; no new reviewed commit was waiting.

### Actual-denominator grids and their timing — 2026-11-27 UTC

The sharper radical-order question changed the discovery outcome: an explicit
Euler covering progression excludes high 17-parts of other prime orders while
the actual terminal pole retains the full 17-power denominator. The parent's
elementary subgroup argument then gives complete rational orbits made of
17^(-d) grids at infinitely many explicit actual anchors, uniformly in every
unit numerator. The [owner](m4-prime-compression.md#explicit-actual-denominators-with-fine-complete-period-grids)
states the fixed-d and fixed-word quantifiers. The main proof needs no external
digit-distribution theorem. The source screen is not an originality determination.

The parent read both complete arguments and all checkers. Three unchanged-copy
replays passed and matched their original receipts: 128 leading-zero fixtures,
four prime-power descriptions, one product counterexample, 253 coarse fixtures,
two exponent-covering constructions, 12 pole/order fixtures, 18 blocked-base
fixtures and 52 synthetic CRT grids. No actual prefix or denominator was evaluated.
The separate comparison retains high-prime logarithmic mass at least 5N+o(N)
under every finite natural tail correction. Its grid step exceeds the uniform
absolute-shadow horizon. It uses the archived PNT-dependent denominator result;
finite tests do not prove either universal argument.

Independent paper review ran 23:09:14--23:16:06, reassessing at 23:14:38 before
the 23:21:14 deadline. No defect was found. Three clarifications are implemented
for integration review: complete-period normalized counts and quantifier order,
source deleted-digit domain, and moving-set dynamics explicitly on R/Z. Actual
early selection and other transfer mechanisms remain open. The [full cycle](agy-reports/m4-continuation-review.md#actual-denominator-grid-and-correction-paper-review--2026-11-27-utc)
retains immutable packets, all dispositions and evidence limits. This intermediate
result is paper mathematics, not a Lean theorem or M4 acceptance.

Integration review completed at 23:27:07 UTC with no defect. All prior
clarifications were verified; one additional source-domain condition, p not
dividing the base m, was added and verified. The [review record](agy-reports/m4-continuation-review.md#actual-denominator-grid-integration-review--2026-11-27-utc)
retains exact scope, hashes and all dispositions. Final affected documentation
and whitespace validation follow before publication. At the 23:23 UTC event,
remote verification 81139b still matched dbba18d2cd3649bfb00392d26ac595b793fdc636;
no reviewed commit was waiting. V and M4 remain open.

Publication receipt, 2026-11-27 23:29:33 UTC: ordinary push 8770c2 and remote
verification a17f67 confirm `a5aaf53d59c081bf6da27ff7cce062dd3ab45ccd` on
`origin/feature/m4-universal-visitation`. Final documentation (93), working and
staged whitespace, exact staged/committed four-path blobs, parent, empty index,
owned clean files and all preservation identities passed. Post-commit necessity
inspection required no repair. No PR was opened. The next active cadence check
is due by 23:44:33 UTC or at an earlier result/direction event.

The user asked when sound findings would be formalized. The elementary grid
result now enters Lean formalization; its complete paper statement remains
unverified by the kernel until all parts compose. The first 20-minute parent
probe starts from the library root and tests an exact rational-prefix cast
bridge; a separate 12-minute local-library inquiry maps Euler/LTE/CRT and orbit
interfaces. No claim is made that these preliminary interfaces prove the grid
theorem or V. The separate timing estimates retain their paper PNT dependencies.


### From the reviewed grid argument to Lean — 2026-11-27 UTC

The parent began a20-minute interface cycle at23:30:23, bounded to23:50:23.
The exact rational coefficient/prefix cast and recurrence offset compiled first;
positivity, common denominator, oddness, coprimality with16 and prime bound8n+5
then compiled through the root. Initial cast and denominator-interface errors
were repaired; all accepted outputs list only the permitted axioms. Independent
contract/boundary review completed23:39:23 with no defect and two verified
quantifier/index clarifications. Production integration began23:39 UTC with a
25-minute reassessment bound, preserving unrelated files. Root build and expanded
Test audit passed; the exact changed-file review follows.

The full17-coordinate discriminator completed23:21:46 within its10-minute bound,
was independently reviewed23:25:27--23:27:35, and is summarized by reference to
archived sieve proofs. Both precision recommendations are implemented; no new
mechanism or infinite avoiding history is claimed. The parent replay passed
120 synthetic fixtures without evaluating an actual prefix or denominator.

A separate discovery cycle,23:24:40--23:35:19 within15minutes, retained an exact
initialized logarithmic-derivative identity but found no phase estimate from
integer winding. Its scratch report remains exploratory and unadopted; it is
not a reason for a Lean detour. Effort moved to the elementary grid proof.
General principal-unit/Carmichael components and the selected actual17-valuation
have since compiled in separate scratch packets; parent replays and independent
review precede their production adoption. Complete-period counting remains an
explicit unfinished obligation. V/M4 are unchanged and open.

At23:42 UTC, remote verification91c009 still matched
`a5aaf53d59c081bf6da27ff7cce062dd3ab45ccd`. New Lean work was awaiting integration
review, with no ready commit to push. The next cadence check is due by23:57 UTC
or at an earlier result/direction event; completed reviewed work will be pushed
promptly rather than waiting for the whole grid theorem.


The first rational-prefix production review completed at 23:50:48 UTC with no
defect. Its one evidence improvement, exact command bindings for existing
receipts, was supplied and verified. All previous paper/contract precision
changes were confirmed. The [integration record](agy-reports/m4-continuation-review.md#rational-prefix-production-integration--2026-11-27-utc)
retains the full cycle. Final outcome-only documentation and whitespace checks
precede publication. The initial 20-minute interface endpoint completed at
23:48:16; a new 20-minute composition cycle now joins the reviewed selected
exponent, principal units and CRT. This is not a new stopping boundary for M4.


Publication receipt, 2026-11-27 23:54:30 UTC: ordinary push f8c8e5 and remote
verification 77e9b7 confirm `a0597c124329e3a25b5c4c0b628c05da5187100e` on
`origin/feature/m4-universal-visitation`. The nine-path rational-prefix checkpoint
passed full build, Test, documentation, process and working/staged whitespace
checks. Exact committed paths/blobs, parent, empty index, owned clean files,
15 unchanged protected and 11 unrelated identities matched; the reviewed root
and Test changes were intentional. Post-commit necessity inspection found no
required repair. The next active cadence check is due by 00:09:30 UTC or at an
earlier result/direction event. No PR was opened. The complete grid and V remain open.


### Completing the elementary grid layers — 2026-11-28 UTC

The 23:48:16 composition cycle reached its endpoint at 00:04:41, before
00:08:16: exact LTE, selected Carmichael exponent, principal units, CRT and
real fractional-part grid translations all compiled. Separate actual denominator
decomposition and exact shifted-grid counting also compiled. Independent
component review, 00:05:43–00:09:19, found no defect or added improvement; its
remaining full-period consumer is retained. Euler covering had already received
its complete independent review at 23:56:42.

Production integration began 00:06:44 with a 00:31:44 reassessment bound. The
first root build exposed missing public imports and tactic availability; these
were repaired. No failed build is acceptance evidence. The first six modules
then passed root build and 32 exact public type/axiom probes. Actual BBP numerator
and denominator substitution compiled at 00:09 UTC. Finite-set averaging and
period/cardinality interfaces passed parent replays; their independent review
completed 00:14:04 with no defect. The historical root compiled artifact was not
retained; the exact intermediate source was reconstructed and hash-matched, and
fresh replays supply the new compilation evidence. A literal coset partition is
unnecessary: finite translation invariance and double counting give the same
complete-period count. The final actual consumer and word consequences still
require composition, checks and changed-file review before publication.

Remote verification 8531de at 00:15 UTC still matched
`a0597c124329e3a25b5c4c0b628c05da5187100e`. No reviewed unpublished commit was
waiting; the new modules remain in integration. Next active cadence check is
due by 00:30 UTC or an earlier result/direction event. V and M4 remain open.


At 00:20:57 UTC, the assembled actual-denominator discrepancy, actual-prefix
discrepancy, fixed-word consumer, arbitrary-anchor consequence and explicit
infinitely-many-prefix theorem all compiled cleanly (5b9776), using only the
permitted axioms. The positive-period/grid-witness consumer had compiled at
00:17 UTC (191689). The generic full-period composition was independently
reviewed to completion at 00:22:33, and the fixed-word branch at 00:19:58;
neither review found a defect or added improvement. Prior missing-composition
questions are now discharged by these compiled consumers, subject to the final
integration review. Root build 1875bd passed with 7237 jobs. The first expanded
Test run caught a generated type-check fragment truncated at a let-binding;
that test syntax was repaired and is being rerun. This was not a mathematical
proof failure. V/M4 remain open.


Expanded Test rerun09c694 passed cleanly; all49 new public axiom lists match the
permitted three in a separate root audit a82e3c. Documentation6c12a1, process
tests820c57, working/staged whitespace0a50e4/50dfe5 and pin/definition preservation
de0392 passed. The final exact16-path integration packet now enters independent
review. No acceptance or publication is inferred from the component reviews alone.


Final integration review completed00:32:00 UTC with no defect. Its sole
improvement—a stale “No Lean proof” clause—was repaired and independently
verified00:33:38. The [review record](agy-reports/m4-continuation-review.md#elementary-grid-production-integration--2026-11-28-utc)
retains every disposition and full captures. The25-minute integration cycle was
reassessed at00:30:45 while review continued; it was not used to stop the task.
All mathematics and root audits were already complete. Final outcome-only docs
and whitespace checks follow before commit/push; no Lean source changed after
the accepted review. The elementary grid is formalized, while V/M4 remain open.


Publication receipt, 2026-11-28 00:35:35 UTC: ordinary push dac9a6 and remote
verification ba6af2 confirm `be618abf67b774a26dfedf84bfd162ace3f2c67a` on
`origin/feature/m4-universal-visitation`. Final affected documentation373b73,
working/staged whitespace4fa77b/d3e3fb and exact16-path staged validationf5dfc9
passed. Commit67eeff and post-commit inspection824d29 verified the exact
committed blobs/parent, empty index, clean owned files,16 protected and11
unrelated identities. No repair or PR was needed. All Lean sources remained
byte-identical to the reviewed, built and audited versions. The elementary
actual-denominator grid formalization is complete and published; V/M4 remain
open. Next active cadence check is due by00:50:35 UTC or at an earlier event.

Parallel research resumed at00:29:16 with a20-minute bound to00:49:16, following
the meta-plan and early source screen. The initial fixed-unit finite-log question
was already covered by the archived prime-square-lift identities; the worker
therefore narrowed the inquiry to special-cutoff evaluations versus the actual
short-prefix range and precision costs. This is exploratory and unadopted,
with no new theorem or visitation claim. The initialized numerator/early-hit
obligation remains the target after the completed formalization checkpoint.

At 00:47:34 UTC, remote check096d45 still matched published `be618ab`; no
reviewed unpublished commit was ready. Next active cadence check is due by
01:02:34 UTC or at an earlier result/direction event. The 00:39:03–00:49:03
all-additive-grid discriminator froze at00:46:42, and the finite-log cutoff
packet froze at00:41:04. Independent review began00:47:17 with midpoint00:54:47
and deadline01:02:17. Both are unadopted paper arguments pending that review;
neither claims an actual early visit or a new Lean result.

A separate 00:38:37–00:58:37 discovery reset completed00:50:03. Its selected
solenoid calculation retains the actual initialization but transfers it to
the original pi phase, leaving a proposed rigidity bridge unsupported. This
is unreviewed scratch evidence, not a visitation theorem. The next source
comparison began00:49:44 with a20-minute bound: inspect a solved explicit
normality mechanism for a genuinely different way of controlling the growing
actual prefix. Separate normality of fixed truncations is insufficient.

Independent paper review of the all-grid and finite-log packets completed
00:55:41, before01:02:17. No defect remained; the sole finite-log domain
clarification was applied and verified. The solenoid review completed01:01:03,
before01:06:55, with no defect and two verified precision improvements: the
affine map is the conjugated one, and a proposed additional scalar action must
be multiplicatively independent of16. The
[full review dispositions](agy-reports/m4-continuation-review.md#post-grid-mechanism-discriminators--2026-11-28-utc)
retain all source/input limitations. These results exclude the specified
transfers; they supply no new actual visit or Lean declaration.

Remote checkcd296e at01:00:25 still matched `be618ab`; no reviewed unpublished
commit was ready. Next active cadence check is due by01:15:25 or an earlier
ready result. The seven-path documentation integration enters its separate
changed-file review. Initial documentationd9ef99 (93 files), process testscceb39
(38 tests), whitespace9ba592 and unchanged pin/definition diff4b2ab0 passed.
Only later factual review receipts have changed since those checks; affected
documentation and whitespace are checked again before publication. The exact
protected-source and unrelated-file snapshot remains unchanged (09f2ff).


The final seven-path changed-file review completed01:08:33 UTC, with no defect
and three verified clarifications. The detailed dispositions are in the review
record. The initial validation receipts remain valid for unchanged process and
Lean sources; final affected documentation and working/staged whitespace checks
now gate publication. The checkpoint records three limited paper findings;
actual early visitation and V/M4 remain open.


Publication receipt, 2026-11-28 01:11:39 UTC: pushcfd8d7 and remote check33286b
confirm `210de58f5a1e407dc2329652e251f4de706f3888` on the existing M4 branch.
Final documentation7d73de, working/staged whitespace5fd565/dcece5 and exact
stagingbb1a0b passed. Post-commit253a59 matched the seven committed paths/blobs,
parent, empty index,27 protected and11 unrelated identities; no repair was
needed. No Lean source or PR changed. Next active cadence check is due by
01:26:39 UTC or an earlier ready result/direction event. V/M4 remains open.

The 00:49:44–01:09:44 normality-source investigation froze01:03:39 and
verified01:03:52. It isolated Stoneham's small unscaled grid and bounded
multiplicity, proved a finite word-location implication, and quantified why
this literal counting bound does not transfer within the growing-column
approximation window. Independent paper review ran01:05:59–01:10:42 and
found no defect; its finite-prefix-cylinder clarification was applied and
verified. These are bounds on the method, not actual first-hit lower bounds.
The five-path documentation integration has a01:27 UTC reassessment endpoint.

A changed discovery question began01:07:03, with midpoint01:17:03 and
deadline01:27:03: inspect digit results that use differential/recurrence
structure of G-functions or rational-in-index forcing. Existing non-D-finite
carry arguments, repetition bounds and local recurrence failures were screened
out before new source work. No new positive mechanism is yet claimed.


The finite-occupancy five-path integration review completed01:17:58 UTC,
with no defect or new improvement and the prior cylinder clarification intact.
Documentation7f9ef3,38 process testsa4f95b and whitespace6ac694 passed before
the factual outcome additions. Final affected checks follow before publication.
No Lean or actual-visitation claim was added; the recurrence-source discovery
continues independently under its01:27:03 bound.


Publication receipt, 2026-11-28 01:20:31 UTC: push7c5bc1 and remote0e17dc
confirm `5bbd0989e5baf49fc3251bccd740992b5c0835eb`. Final documentationf1dd56,
working/staged whitespace14a90c/7b7dad and exact staging81bc06 passed. Commit
5702b6 and post-commitc32bdc verified the five exact paths/blobs, parent, empty
index and27 protected/11 unrelated identities; no repair was needed. The
finite-occupancy checkpoint is published. No Lean or PR changed. Next active
cadence check is due by01:35:31 UTC or an earlier ready event. V/M4 remains open.

The recurrence-source cycle reassessed01:18:11, slightly after its midpoint.
The selected opening is an exact base17 functional system for finite columns
and the D-finite/Mahler source contract for the actual coefficient series.
A quantitative finite-prefix refinement is being checked: bounded-order
functional relations would require polynomial degree growing with the cutoff.
This is exploratory paper work pending independent review; no actual word
visit, normality transfer or new Lean result is claimed.


The functional-structure packet froze01:23:06; a separate elementary pole
supplement and simplification completed01:24:33, before01:27:03. Independent
review completed01:32:31, before01:40:53, with no defect or required improvement.
It confirms an elementary base17 nonrelation and finite-prefix degree bound,
while the all-base result retains the cited external theorem. Neither gives
a digit/occupation or timing estimate. The exact five-path integration has a
01:50 UTC reassessment endpoint and remains unpublished pending its own review.

Remote check7f4ba9 at01:32:27 still matched `5bbd098`; no reviewed unpublished
commit was ready. Next active cadence check is due by01:47:27 or an earlier
ready event. A separate five-minute source follow-up began01:30:18 and
completed01:33:51. It found a potentially sharper differential-system zero
estimate, with an unspecified additive constant; its source/bridge review is
pending and no production bound is adopted yet.

The meta-plan's fresh-context discovery pass began01:28:00, with midpoint
01:38 and endpoint01:48. It receives the exact forcing, zero seed and archived
failures, and excludes repeating the current rescaling/occupancy routes. Its
purpose is a different mechanism or an exact new discriminator, not another
conditional wrapper. V/M4 remains open throughout these internal checkpoints.


The zero-estimate source bridge review completed01:38:38, before01:43:13.
It accepted the Q=4d+5 rational-system application and retained the unspecified
C_d. The sole d=0 coefficient-comparison clarification was applied and
verified. The source bound now accompanies the independent elementary bound
in the owner; both remain paper results without a digit or timing consequence.
The combined five-path integration proceeds to its exact changed-file review.

The integration review completed at 01:49:02 UTC with no defect and one
verified precision repair: the rational-function span has dimension at most
five. Full dispositions are in the review record. Final affected documentation
and working/staged whitespace checks now gate publication. The 01:50 root
checkpoint was reassessed at 01:52:52 after context restoration; the remaining
work is final checks and publication, not further mathematical revision.
Remote check ccd8bf still matched `5bbd098`; the 01:47:27 cadence checkpoint
was late, and no reviewed unpublished commit was ready. Next active check is
due by 02:07:52 UTC or an earlier ready result/direction event.

The fresh-context discovery pass completed at 01:45:28, before its 01:48 bound.
It found no surviving new mechanism and recommends no production theorem or
Lean work. Its unadopted source-screen report is retained in
`/tmp/pi-m4-nonlinear-decay-reset-20261128/`; the parent is checking its receipt.
The earliest gap is still deterministic selection of the actual initialized
orbit. Secondary generic curvature calculations are not promoted as new pi
progress. The next inquiry will examine the actual finite-sum numerator rather
than extend that metric argument. V/M4 remain open.

Publication receipt, 2026-11-28 01:55:01 UTC: commit 67d881, push f8dfb3
and remote 5a2ffd confirm `fac00f2d16844ce7bdc7bd5c68d60175d7faa534`.
Final documentation 0f6d73, working/staged whitespace 88b392/2bb717 and exact
staging d208e8 passed. Post-commit 102287 matched the five paths/blobs, parent,
empty index and 27 protected/11 unrelated identities; no repair was necessary.
The preceding review's final-check question is discharged. Parent b8473f also
verified all three entries in the unadopted fresh-discovery packet. No Lean
source or PR changed. Remote e3c6b2 at 02:10:19 still matched this head, with
no ready unpublished commit; that cadence check was 18 seconds late. Next
active check is due by 02:25:19 or an earlier ready result/direction event.

The prescribed-numerator source screen ran 01:56:12–02:12:14, reassessing
02:07:50 before its midpoint and ending before 02:21:12. It identified a
deterministic accumulated-harmonic-prefix method whose common-frequency factor
does not survive the BBP affine skew. Its rational/clock source contracts and
bounded-degree coordinate test are in separate independent review. Parent
989b40 verified all 69 frozen entries. No source theorem supplies V.

The parent separately tested the unequal-frequency repair from 02:02:47 to
02:06:25, before the 02:18 bound. The exact Cauchy statistic and an archived
zero-seed rational comparison separate those correlations from ordinary Weyl
cancellation. Independent paper review ran 02:06:49–02:08:42, with no defect
or required improvement; its sole question retains the actual fixed-frequency
consumer. No numerical actual-sequence check or Lean work was needed. The
five-path documentation integration began 02:12:06 with reassessment at 02:35;
source review and final changed-file review/checks gate publication.

A fresh-context backward proof attempt began 02:11:45, with midpoint 02:26:45
and endpoint 02:41:45. Its first archive check rejected generic non-coboundarity
as a distinguishing premise: an existing positive rational comparison already
has it and a nondense rational period. The narrowed inquiry retains the actual
four distinct pole classes and initialized period, and asks for a justified
consequence of permanent word avoidance. That consequence is not assumed.

The prescribed-prefix source review completed 02:15:18 UTC with no defect or
required improvement. Its fixed-frequency/short-window question remains open;
the detailed source, version and evidence limits are retained in the review
record. The combined five-path integration now enters its changed-file review.
Initial documentation e25da6, 38 process tests 771dca and whitespace 601b06
passed. No Lean source changed; final affected documentation and whitespace
checks follow the factual outcome edits before any commit.

The final integration review completed 02:20:28 UTC with no defect and one
verified precision clarification, retaining the source orbit's least period.
Final affected checks now gate publication. The preservation check noticed a
changed Obsidian layout at 02:15:14; its inspected current contents were kept
outside the five owned paths. The exact paper/source limits and all review
dispositions are retained. The backward proof investigation continues under
its original bound, with no new mathematical result adopted.

Publication receipt, 2026-11-28 02:23:41 UTC: commit c4ea10, post-commit
02017e, push 6209de and remote 5688fa confirm
`4f3108c58d49640879a797dae8d5e4ce982bd61f`. Final documentation aae556,
working/staged whitespace ab08a6/876d51, integrity 4eb4d9 and exact staging
b8daf9 passed. The five committed paths/blobs, parent, empty index, 27 protected
and 11 currently recorded unrelated identities matched; no repair was needed.
The Obsidian change described above was preserved, not restored. Remote
768100 at 02:52:51 still matched this head; no reviewed unpublished commit
was ready. No Lean source or PR changed.

The fresh backward pass finished within its 30-minute bound with **no new
mechanism**. Its forbidden-word polynomial did not put the actual carries in
a finite algebraic profile; its symbolic lifts repeated the archived gap
between the exact raw arithmetic and bounded canonical real states. The packet
`/tmp/pi-m4-zero-seed-reset-20261128T021145Z/` remains unadopted: report-v2
hash `87354fb9a68a93578ca9922f3e2abc31f6d35a8db683a8c2573cf89fbc4b645e`,
manifest `7a550ac060ed35bf7ee1dc83808213a11d828b6a0d99165c7799a15007d0d954`.
Parent 05bb59 verified all four entries; its synthetic checker was not replayed
and no new mathematical claim or Lean work is adopted from that packet.

## 2026-11-28 — Prime dilation and a fresh discovery reset

The action test ran 02:47:12–02:56:39 UTC, reassessing early at 02:55:12
before its 03:07:12 endpoint. The parent centered the exact defect from
02:51:02 to the observed 02:53:23 clock, before its 03:03:02 bound.
The [owning calculation](m4-two-adic-reflection.md#prime-time-dilation-does-not-supply-a-second-scalar-action)
retains the original pi phase and distinguishes index dilation from scalar17
preservation of the selected real closure. The latter remains unproved.
Neither the inspected automorphism theorem nor the different circle-semigroup
theorem supplies a visit from this identity. Parent cec362 verified all18+3
packet payloads. No actual-sequence census or numerical checker was needed.

Independent paper review by `/root/finite_log_independent_review` ran
02:57:21–03:00:21, before its 03:07:21 bound. It found no defect or required
improvement; both real-selection questions remain open. The
[review record](agy-reports/m4-continuation-review.md#prime-dilation-action-test--2026-11-28-utc)
retains full scope, source limits and dispositions. Five-path documentation
integration began 02:59:16 with reassessment at03:10 and endpoint03:20;
changed-file review and affected checks still gate publication.

**Discovery bottleneck:** these attempts still do not select the initialized
real orbit. The proposed logarithmic/missing-digit source search was matched
to repeated archived screens before another campaign began; it is not a new
direction. Under the meta-plan, fresh-context
`/root/m4_new_mechanism_reset_0259` began at02:59:16, with midpoint03:14:16
and endpoint03:29:16. Its task is one materially different mechanism and a
minimal discriminator, or an honest no-new-mechanism outcome with a changed
discovery question. It must retain the exact forcing/seed and compare the
existing failures before development. No result is presumed, and V/M4 remain
open. This is a reassessment cycle, not an M4 stopping boundary.

The five-path integration review finished at03:05:53 UTC with no defect or
material improvement. It retained both real-selection questions and verified
the frozen/live scope and protected/unrelated identities. Initial affected
documentation77a6a8 and whitespace922e77 passed. Final affected checks now
gate publication; the fresh discovery pass continues under its original bound.

Publication receipt, 2026-11-28 03:07:48 UTC: commit73baa0, post-commit1541ed,
push e2dd1f and remote fa2543 confirm
`c16b2c7fa3518ace0d32f77f3f1e3e929cbec694`. Final documentation fbf13a,
working/staged whitespace90d5a1/eb2ba5, preservation be4e62 and exact staging
801c5e passed. The five committed paths/blobs, parent, empty index and
27 protected/11 unrelated identities matched; no repair was needed. No Lean
source or PR changed. The next active remote check is due by03:22:48 or an
earlier ready result/direction event.

## 2026-11-28 — Test exponential integrality before using the prime defect

The parent tested a different use of the known prime defect from03:05:27
to03:12:32 UTC, resolving the endpoint before its03:12:57 midpoint and
03:20:27 bound. The [first-pole argument](m4-generating-functions.md#prime-defect-regularity-is-not-exponential-integrality)
rejects exponential integrality of three natural initialized-prefix series,
including integer-subtracted versions. A separate classical bounded-Dold
argument rejects global Euler-exponential integrality of every actual carry
tail. These are limits on two proposed constructions, not on all integral
objects and not a visitation advance. Neither argument evaluates actual
prefixes or carries.

Early prior-work checks identified the precise additive Dwork criterion and
bounded-Dold theorem. The inspected public Lean catalogue exposed no proof
body used here; narrow pinned-library searches found no matching statement.
No verified external Lean proof, dependency audit or originality claim follows.
The source and retrieval limits are retained in the
[review record](agy-reports/m4-continuation-review.md#prime-defect-and-exponential-integrality--2026-11-28-utc).
Independent paper review ran03:13:01–03:14:27, before its midpoint, with no
defect or required improvement. Its sole question retains the need for a
different integral object preserving the same selected carry path. Parent
d9bd89 and the reviewer verified all16 packet entries. No numerical checker
was needed. Three-path documentation integration began03:16:20, with
reassessment03:25 and endpoint03:35; changed-file review and final affected
checks gate publication. The separate continued-fraction discovery pass
retains its original03:29:16 bound, with no new mechanism accepted. V/M4
remain open.

Integration review completed03:20:39 UTC with no defect or material improvement;
its replacement-object question remains open. Final affected checks now gate
publication. The fresh continued-fraction pass ended early with no surviving
mechanism. Its unadopted packet is
`/tmp/pi-m4-source-reset-20261128-025916/`, report
`c986db45215bd564fd0536bad3237d3b5d01db98a3ff57e38911a299633a8d85`,
manifest `c8ff952f84518cb214a6f45922e296598c3283c916727dc8b7416478e5d4f560`.
Parent cc1287 verified its three entries; the symbolic checker was not replayed
and none of that packet's mathematics is adopted. A12-minute source-fit
follow-up began03:20:57, midpoint03:26:57, endpoint03:32:57, seeking one
specified disjunctive constant from a rational polynomial-coefficient linear
recurrence with an actual digit-transfer argument. Finding no matching source
would not prove nonexistence. This discovery continues under the unchanged V.

Publication receipt, 2026-11-28 03:23:06 UTC: commit9d1f6b, post-commit
afd962, push2e40e8 and remote669ddb confirm
`b400d754d9117cb7e4b651e337fc8bbec10f9fe7`. Final documentation61cd41,
working/staged whitespace2cb719/869c91, preservation410fc8 and exact
staging55472e passed. The three committed paths/blobs, parent, empty index
and29 protected/11 unrelated identities matched. This check was18 seconds
after the preceding03:22:48 deadline while final checks completed; the receipt
does not conceal that overrun. Later synchronization59e334 at03:27:03 and
9bd16f at03:42:53 matched the same head, with no unpublished task commit.
The latter check was50 seconds after its03:42:03 deadline. No Lean source
or PR changed.

## 2026-11-28 — Arctangent primitive arithmetic and its timing consumer

The general holonomic source-fit pass ended03:28:14 UTC without a qualifying
solved neighbor; the irrational nondisjunctive countermodel screen ended
03:37:34 without a qualifying example. These are bounded search outcomes,
not nonexistence results. The unadopted packets are respectively
`/tmp/pi-m4-holonomic-neighbor-20261128-032057/` (report-v2
`63c750777aa475e963f9ed4333315902ab1485aacb01bb57b6b3c4a419cd04b5`)
and `/tmp/pi-m4-holonomic-countermodel-20261128-033016/` (report-v2
`b83fac2ea3f67c310aab73516cbb73ad9e21bfc1bc29b2083c1ab9e966dcc3df`).
Parent d972f8 and451f93 verified their3 and4 manifest entries. Their
mathematical examples are not adopted. Generic minimality and value-class
questions are suspended without a new actual-specific consumer.

The exact Gauss arctangent family supplied a different, discriminating
question: how does its reduced denominator compare with its real shadow
window? The first inquiry ran03:26:57–03:40:03, reassessing03:34:16 and
03:36:42 before its03:46:57 endpoint. Its
[owning calculation](m4-approximation-interfaces.md#arctangent-convergents-and-a-partial-period-obstruction)
proves the two-sided error, exact primitive pair and an input limitation for
the crude radical-size method. It did not settle timing. Parent451f93
verified all46 entries. No actual convergent, prefix, digit, carry or orbit
census was performed.

Separate paper review ran03:43:35–03:47:44. It found a prime2 boundary
defect and requested an explicit circle-orbit domain; both were repaired
and independently rechecked before the midpoint. The original packet stays
frozen; the repaired report is separate. The review's remaining question
concerns primitive arithmetic sufficient for timing. Three-path documentation
integration began03:48:27, with reassessment04:00 and endpoint04:10;
changed-file review and final affected checks gate publication. The
[review record](agy-reports/m4-continuation-review.md#arctangent-primitive-timing--2026-11-28-utc)
retains exact scope and dispositions. V/M4 remain open.

A changed follow-up began03:44:40, with midpoint03:52:10 and endpoint
03:59:40: test which small primes survive the lcm factor, rather than infer
primitive height from factorial growth. Its midpoint reassessment was
03:52:29. An adjacent-index survival calculation exposed a possible consumer
of the already reviewed gcd/order bound in the CRT owner. That generic
lemma is reused, not claimed as new. The follow-up and its independent
review must finish before any resulting timing claim is adopted.

The follow-up froze03:54:36, before its03:59:40 endpoint. It proves exact
small-prime survival and an adjacent-index support inequality. With explicit
PNT, one fixed set G meets every sufficiently large adjacent pair. The
archived order bound then forces eventual periods to exceed every fixed
power of the index on G, while the real shadow horizon is linear. This
closes a subsequence full-period comparison without proving late first hits
or the earlier radical-size criterion. Parent d06e9e verified all20 entries.
Independent paper review ran03:55:10–03:57:33, before its midpoint, with no
defect or required improvement. Its questions retain first-word location,
complementary indices and the crude radical criterion. The three-path
integration and final checks remain pending; no Lean theorem is claimed.

Remote481491 at03:55:30 confirmed the published b400d75 head while the new
result was under review. The changed initial-segment source-fit inquiry
began03:56:45, with midpoint04:02:45 and endpoint04:08:45. It seeks a
prescribed-numerator estimate in the actual linear shadow window; complete
periods, average numerators and generic holonomic values do not satisfy
that contract. No positive visit is presumed. Research continues under V.

The three-path integration review completed04:00:57 UTC, before its
midpoint, with no new defect or material improvement. Both earlier repairs
were verified in production; first-word location, complementary indices
and the crude radical criterion remain open. The04:00 integration
reassessment therefore retained publication after final affected checks.
Initial documentation5734d3, whitespacee4e60a and preservation194517 passed.

Under the meta-plan, a fresh-context positive-mechanism reset was assigned
04:01:00, with midpoint04:11 and endpoint04:21. It receives the exact target,
failure record and early-phase obstruction, and must identify one changed
mechanism or an honest no-new-mechanism outcome. It does not duplicate the
ongoing prescribed-numerator source-fit inquiry or presume a breakthrough.
Neither cycle boundary is an M4 stopping point.

Publication receipt, 2026-11-28 04:03:24 UTC: commit7814e7, post-commit
ba7b5c, push325df5 and remote4e53eb confirm
`746fef9aa33e928322acf4da688422220e0b39fd`. Final documentation2a1c20,
working/staged whitespacebd8d35/34d76f, preservationac3551 and exact
stagingc8221c passed. The three committed paths/blobs, parent, empty index,
30 protected/11 unrelated identities and unchanged mathematical postimage
matched. No repair, Lean change or PR was needed. Synchronization0fdf2b
at04:17:27 still matched, before the04:18:24 cadence deadline.

## 2026-11-28 — Discovery reset outcomes and compact source-map repair

The prescribed-numerator source-fit inquiry ended04:03:54 UTC, before
04:08:45, with no applicable early-hit source. The parent read the complete
unadopted report and0b6e5d verified its seven-entry final manifest:
`/tmp/pi-m4-cf-early-sourcefit-20261128T035645Z/report-v2.md`, hash
`999daaf1db0e9206c1873f5b389c96a4f42adfa6039a2aef5304c10e7513a9ff`;
manifest-v3 `d6f18821111236ff750e760a739c9195a43d2aa98bb74364ab40bb3ff42f067d`.
This remains a bounded no-match outcome. Its residue observation and
finite-frequency consumer are not adopted as new mathematics. The parent
also checked the primary Vandehey statement's notation; this added no
matching theorem or new source mechanism.

The fresh positive-mechanism reset ended early at04:14, before04:21, with
**no new mechanism**. Finite-state histories, solenoid minimality and
Bernoulli-convolution dimension were exact archive matches. Its short
unadopted report is `/tmp/pi-m4-positive-reset-20261128T040100Z/report.md`,
hash `5f199a1fcebb5f7e622bf4e5667160ec734ae8da83adfcaef356cd5dd59d6247`.
Parent809968 verified that identity and read the whole report. No source-body
manifest was supplied; its URLs are not newly certified source contracts.
The automaticity remark is expressly a historical problem and no resolution
found in that search, not a claim about current literature status.

The compact handoff lacked a direct logarithmic-constraints pointer,
including the exact Bernoulli comparison rediscovered by the reset. A small
memory repair began04:17:53, reassessment04:23, endpoint04:28: add that
pointer and the already reviewed Dwork/dilation/arctangent boundaries in
the existing owner map. This adds no new theorem, workflow rule or second
status ledger. Adoption requires accurate links and faithful summaries of
the reviewed owners; it makes no measured search-efficiency claim. A
separate changed-file review and affected checks gate publication.

The changed model inquiry began04:16:10, with midpoint04:22:10 and endpoint
04:28:10. It tests the zero-seeded one-pole log2 recurrence for a single
late escape interval, against a rational coboundary comparator retaining
the same leading forcing decay. This is a model-problem investigation,
not a claimed easier theorem, a visitation advance or a weakening of V.
No actual-sequence census is authorized by it. M4 research continues.

The source-map review completed04:21:22 UTC, before its midpoint. It found
no defect and one useful pointer correction: link automaticity directly to
the explicit counterexample in the generating-functions owner. The repair
was independently verified. No new open question or efficiency claim was
introduced. The04:23 reassessment retains final checks/publication; the
model inquiry continues under its separate04:28:10 bound.

## 2026-11-28 — Rational-affine visitation enters Lean

Publication of the preceding navigation repair was verified at04:25:06 UTC:
`b441c397ca9120cb760b852d332b121104d3bb9c`, push b12311, remote7fb7cc.
Final documentation dc1315, whitespace286686, preservation4d1638, staged
whitespace a79e04 and exact staging8d3e20 passed. Later remote263504,
between the observed04:53:11 and04:53:53 clocks, still matched that head.
No unpublished reviewed commit or PR was present.

The one-pole model inquiry ended04:25:16, before04:28:10, without a late
escape proof. Parent fca532/297a91 read and verified its unadopted report
`/tmp/pi-m4-one-pole-20261128T041610Z/report.md`, hash
`c4820c42907b41d90441a4262916efe1a7c28efd999ee7539dee9b8fd7c1313d`.
The changed constructive-placement pass ended04:42:38, before04:53:30,
without a surviving word-placement mechanism. Its report is
`/tmp/pi-m4-constructive-placement-20261128T043330Z/report.md`, hash
`4cc5cea35b5a4dba572b724ea83bf537bcf26e9ac3950200a12023cf45a67c5e`.
The backward-selection pass ended04:51:56, before04:53, without a new
constraint on the actual initialized orbit. Its report is
`/tmp/pi-m4-backward-selection-20261128-0433/report.md`, hash
`c43327045e466d8592f363738f2b75fec28e648b2123f311638b04ab5e7e3ca7`.
Parent8d5e30 verified the latter two identities and read their reports.
These are factual discovery outcomes only: no new mathematics, source proof,
checker result or provisional countermodel refinement is adopted here.
The original four-pole, zero-seeded visitation question remains open.

A separate formalization inquiry changed the question to a reviewed component
with a concrete consumer: rational-affine invariance of universal late
visitation. Preparatory reads began04:38:33; the assigned window was04:39–04:59,
with a04:49 midpoint. The worker completed04:54:29. All interval/threshold
quantifiers and negative nonzero rational scales are retained. This is
visitation invariance, not the stronger normality-preservation statement.
Its explicit BBP consumer compares the phase e+bbpTail N with pi using the
existing inclusive rational prefix. It does not supply visits of either phase
or formalize the separate forced-recurrence error transfer.

The frozen candidate is
`/tmp/pi-m4-rational-affine-lean-20261128/FullAffine-v1.lean`, hash
`44a0926f9c3c0e0f54151e05ea7365ba008b9b63fa8d855244d8e67dc47d85c5`.
Parent e049eb verified all nine manifest entries; the manifest hash is
`b4ad225c47594d78fd758fee5b0799e920212ae19520115d72654e1aa46bc2a7`.
Independent parent scratch replay defe89/21b24f exited0 under verified
Lean4.37.0-rc1. This replay is distinct from the required subagent review.

Parent integration began04:53:11, with reassessment05:00 and endpoint05:14,
using `/tmp/pi-m4-affine-integration-20261128T0453Z/`. Eight owned paths,
135 other tracked paths and11 unrelated files are recorded. Production edits
began after the worker's explicit completion signal. The new general module
imports Mathlib directly, avoiding a library-root cycle. The early root-chain
build874186/968e53 and root consumer/actual-axiom probe fc967a/b0cb5c passed.
All14 new public theorems use exactly the three permitted axioms. The first
full Test run passed with unused proposition-binder warnings in the new type
audits; prefixing those binder names retained every premise and all linters.
The repaired Test run c39343/779874 passed without warnings.

At the05:00 reassessment the full consumer is feasible and integrated, so
continue through full build, documentation/scope checks, independent exact-diff
review and publication. V/M4 remain open; the integration checkpoint is not
an acceptance of V or a stopping point for the authorized research.

Independent exact-diff review completed before05:04:37 UTC, ahead of the
05:11 bound, with no defects, requested improvements or blocking questions.
All22 frozen entries, eight postimages,135 protected and11 unrelated
identities matched. Full build864ff9/6f5010, documentation3388aa, staged
whitespace580bdd and pin/formulation diff826f8b passed. Only factual review
completion is added after that review; final affected checks gate publication.
The supported equivalence is accepted mathematically and kernel checked;
it supplies no visitation premise and leaves the original M4 task active.

## 2026-11-28 — Published affine support and continued discovery

The affine support commit is `aa4dc115b1cd1feda40d37357fd99f06f13521a9`,
parent b441c39. Commit40979a, post-commit b8c90a, push7b0a42/d74f0f and
remote1daeff confirm publication at05:07:47 UTC. All eight committed blobs
matched exact staged scope; the index was empty, and135 protected plus11 unrelated
identities were preserved. Final documentation d71584, working/staged
whitespace416d25/e02776 and exact staging726eea passed. No repair or PR.
The receipt remains in `/tmp/pi-m4-affine-integration-20261128T0453Z/publication.json`.
Remote a594ca and checkout485e0c at05:21:49 still matched, before the05:22:47
cadence deadline, with only the preserved unrelated work present.

A narrow provenance screen for the new formal component ended05:14, before
its05:15 reassessment and05:18 endpoint. The bound was set after initial
queries, at05:11:42; no earlier bound is retroactively claimed. Bugeaud's
2012 book pages92,96,97 were read and viewed. The limited search located
related richness/density and normality results, but no exact prior
visitation-affine statement. This is not an originality or exhaustive
literature claim, and no original source proof was adopted. The report is
`/tmp/pi-m4-affine-priorwork-20261128T0510Z/report.md`, hash
`718e66089140ab84c8047a42b9e1b3fa585dfea04fae98d6b929cb796ed73fc6`;
ten-entry manifest `df7ab039bc7888995acf5384ffa4cb01ea761ccdeae24ea1a1dfd7ae4e5ad2b8`.

The coefficient-height discovery pass began05:08:43, reached a decisive
source mismatch05:13:25 and froze05:14:29, before its05:18/05:28 bounds.
It found no new positive visitation mechanism. Its unadopted report is
`/tmp/pi-m4-coefficient-height-reset-20261128-0508/report.md`, hash
`d3a3ec68d9eb1db5b98f953b70d797c362f4f69cc748159c5711c7efefa90406`.
Parent8f3688 read it. Its source-fit/pole-height mathematics has not received
independent review or production adoption. No new countermodel was developed.

A fresh-context positive-route reset began near05:17, with midpoint05:27
and endpoint05:37. It receives the expanded failure map and the completed
formal bridge, and seeks a changed positive mechanism with an actual-seed
consumer. A parent normalized17-adic numerator idea immediately collided
with the archived full17-component sieve at05:19:58. No complementary-coordinate
consumer was found and no limit was calculated. That unadopted outcome is
`/tmp/pi-m4-prime17-limit-screen-20261128T0520Z/report.md`, hash
`cfad5bc5738b996ca3b6bbde788d9892034eff7a8998e763191d5810eb0c74e9`.
No actual prefix, denominator, digit, carry, orbit or convergent census occurred.

The compact restart pointer is being refreshed at05:22, with reassessment
05:27 and endpoint05:32, to include the accepted affine support theorem.
This changes navigation and factual outcomes only, not mathematics or the
research policy. Separate review and affected documentation/scope checks gate
publication. V/M4 remains open, and the positive-route investigation continues.

The three-path restart review completed05:25:18 UTC with no defects,
requested improvements or blocking questions. The accepted mathematical owner
and Lean proofs were unchanged. All140 protected and11 unrelated identities
matched; only factual review completion follows the frozen diff. The05:27
reassessment retains final affected checks/publication, while the separate
positive-route research remains active under its05:37 bound.

## 2026-11-28 — Exact entry transfer and source boundaries

The restart-pointer commit is `278e35543d537fa6f873211240ee5a41b050aefd`,
parent aa4dc11. Post-commit6787a2, push5b96a0/d7a82d and remote406e28
verified publication at05:27:25 UTC. Final documentation1c2bbe,
working/staged whitespace dc1b9e/5c1d7d and exact staging4d11ac passed;
140 protected and11 unrelated identities were preserved. No PR or repair.
Its receipt is `/tmp/pi-m4-affine-handoff-20261128T0522Z/publication.json`.
Remote bcc424 at05:39:48 still matched; there were no unpublished commits.

The positive-route worker froze05:27:48, before its05:37 bound. Its entropy
source comparison found no arithmetic support for the required actual-remainder
entropy premise, so that route is suspended. Report
`/tmp/pi-m4-positive-route-reset-20261128-0517/report.md`, hash
`24f08381958a58d0186502a9bcdca6527aa76fa1b38997ab5bdd1f06be679b94`,
was read by parent65fd21/a6593a and hash-checked1929db. This records a factual
discovery outcome only, not mathematical adoption or an independent source audit.
A subsequent small logarithm-parameter check collided with the already assessed
[linear-complexity source boundary](m4-language-auxiliaries.md#logarithmic-values-do-not-yet-supply-pointwise-exclusion).
No pi identity or stronger digit conclusion was obtained.

A fresh-context exact-logarithmic-value inquiry began near05:35, with05:44
midpoint and05:53 endpoint. Archive checking rejected the previously assessed
exponential-product construction immediately. It is testing only genuinely
different analytic-image source contracts; a metric result is not pointwise
exclusion. Its outcome remains unadopted pending the completed report.

The separate Lean worker began near05:39 with05:49 midpoint and05:59 endpoint.
Its bounded target is the remaining forced-entry part of the reviewed
rational-entry equivalence, not a new route supplying visits. The initial
library-root probe passed; candidate compilation is in progress. Parent
integration preparation began05:42:10, with05:52 reassessment and06:02 endpoint,
in `/tmp/pi-m4-forced-entry-integration-20261128T0542Z/`. Ten owned paths,
134 protected and11 unrelated identities are recorded. Production Lean edits
await the worker's explicit immutable completion. V/M4 stays open, and research
continues through these internal checkpoints under the existing authorization.

The exact-value worker completed05:43:16, before its midpoint, with no new
visitation candidate. Report `/tmp/pi-m4-exact-exp-reset-20261128-0535/report.md`,
hash `9b440cfe3ca290341f78614a8c0de82c5383f14926533013fbdb01d06a3852eb`,
was read in54bf45; parent5dede7 verified all18 manifest entries. Its nonlinear
image and manifold source comparisons did not give fixed-point exclusion.
These source-fit arguments remain unadopted; only the completed inquiry's
outcome is recorded. No actual phase or digit census was performed.

The Lean worker delivered its immutable candidate before the05:45:08 parent
clock. All five entries of manifest
`92be4f19f321947da37068688277a690cf1a0cee34c7873f1f42ca71fa6f02e7`
matched in a80493. Candidate `ForcedEntry.lean`, hash
`4fbbd8a9c8f16bb6ef7ceb7ac91e92ce3a6e8115680a899be2614b434fe7711a`,
is under `/tmp/pi-m4-forced-entry-lean-20261128T0539Z/`. Only after completion,
parent integrated two general transfer lemmas and the seven BBP theorems with
one genuine raw-entry definition. Existing definitions and theorem statements
are unchanged. The root export-chain build f4f514/287409 and early root probe
697c04/fc7f81 passed. All nine public theorem axiom lists are exactly the three
permitted axioms. Native diagnostics returned success with no items.

Full build07baa3/582567 and38 offline process tests f56a7b passed. The first
Test run4700e9/c9a50f found an audit-generation name-prefix error at line1708;
correcting its full rational-entry contract left proof sources unchanged.
The repaired Test run7de247/0daba9 passed without warnings. Documentation805f82,
pin/formulation diff362dd9 and preservation5dede7 passed. Separate exact-diff
review and final affected checks gate publication. No visitation premise has
been discharged; the next research question must add actual-orbit information,
not another generic metric-to-point inference.

Separate review completed05:50:57 UTC, before its midpoint, with no defects,
requested improvements or open questions. All23 packet entries, ten postimages,
134 protected and11 unrelated identities matched independently. At the05:53
parent reassessment, after the planned05:52 checkpoint, retain final affected
checks and publication within the06:02 bound. Post-review edits change factual
completion status only. The accepted equivalence remains support for an open V,
and the authorized research continues.

## 2026-11-28 — Actual column dependence

The forced-entry support commit is
`4fa0f76c19d40f40ce6fc9f0b384777f3466f9a5`, parent278e355. Commit8c558d,
post-commit bd552a, push860385/0da57a and remote35346f verified publication
at05:55:27 UTC. All ten blobs matched exact staged scope, the index was empty,
and134 protected plus11 unrelated identities were preserved. Final
documentation e78f94, working/staged whitespace be7c2f/451480 and scope3af08c
passed. No repair or PR. Publication receipt:
`/tmp/pi-m4-forced-entry-integration-20261128T0542Z/publication.json`.

A changed inquiry tested joint equidistribution of the actual columns as a
possible resource for the infinite sum. The bounded discriminator was one exact
pair, cofactors1 and9; archive/source searches began by05:49:49, reassessment
was05:55, and the report froze05:55:26. It found an exact dependence:
C_1+9*C_9 is not16-normal, with proved long blocks near integers and first-cell
upper frequency at least8/17. This refutes joint equidistribution of that pair,
not visitation of pi or normality of the complete fixed T_M. The
[owner](m4-fourier-windows.md#an-actual-column-pair-is-not-jointly-equidistributed)
contains the symbolic argument; no actual digit or orbit census was used.

Report `/tmp/pi-m4-column-resonance-20261128T0549Z/report-v1.md`, hash
`63368b09b2983be53ce4bab804a4425febb09818b999d6ebf51b21ad4d50fcd2`,
was independently reviewed05:56:25–05:58:12 with no D/I/Q items. The early
source comparison reused the nearby finite cyclotomic criterion, without
claiming a direct source application or originality. This is a reviewed
paper obstruction, not a Lean result or a positive M4 step.

Production integration began06:00:57 with06:06 reassessment and06:12 endpoint,
using `/tmp/pi-m4-column-resonance-integration-20261128T0600Z/`: three owned,
141 protected and11 unrelated identities. Exact-diff review and affected
checks still gate publication. A separate weaker-correlation inquiry began
near05:59, with06:05 midpoint and06:10 endpoint. It tests whether the exact
dependence can help while retaining integer parts modulo each cofactor;
dropping them or assuming a small real tail is small in orbit average would
repeat the archived gap. V/M4 remains open and research continues.

The separate production integration review completed06:04:27 with no D/I/Q
items. It independently matched all nine frozen entries, three live postimages,
141 protected and11 unrelated identities, the accepted sketch/capture and
publication facts. At06:05 reassessment, before the planned06:06 checkpoint,
retain final affected checks and publication. The mathematical owner is unchanged
after review; only factual completion status follows. The weaker-correlation
inquiry retained its separate06:10 bound; no result from it is adopted here.

## 2026-11-28 — Actual modular comparison at dyadic anchors

The actual-column dependence commit is
`61837e1db23bf9911e365fed338354ee927e7882`, parent4fa0f76. Commit838055,
post-commit b123e6, push721d44/32266c and remote414ff3 verified publication
at06:07:43 UTC. All three owned blobs matched, the index was empty, and
141 protected plus11 unrelated identities were preserved. Final documentation
7f2db2, working/staged whitespace fbaaa2/21280f and scope666b66 passed.
No PR or repair. Receipt:
`/tmp/pi-m4-column-resonance-integration-20261128T0600Z/publication.json`.
Remote431fcd, checked before the06:21:32 clock, still matched; there were
no unpublished commits.

The weaker-correlation inquiry completed06:05:26, before its06:10 endpoint.
Report `/tmp/pi-m4-resonance-remainder-20261128-0600/report.md`, hash
`10a7fadf1d84c0ed9d06ef03139198546a9b8e610eb7ce78f250fec51edb816d`,
was read bcc776 and hash-checked87dce5. It found no new positive input:
the proposed square-summability estimate still loses integer parts modulo
the cofactors. This records its completed discovery outcome only; its
unreviewed mathematical formulation is not adopted.

A new modular-comparison cycle began near06:09, with06:16 midpoint and06:23
endpoint. Parent redirected the question before06:14:36 to exact dyadic
coefficient cancellation in the actual tail. The worker froze06:19:09 in
`/tmp/pi-m4-modular-shadow-20261128-0609/`. Report hash
`99e7056e00299d572eb4f91fdd62c30bb16e2b8c0acc7c683a47093222f54a89`;
manifest `797f536951fdb04d9e71a9854c9c2a868ce1a44d8f5d615b2034d6e5901c8902`.
All four entries matched in7b424d. Parent checker0d6868 passed32 symbolic
remainder identities,32 moment/coefficient checks and797 parameter bounds;
no actual phase, prefix, denominator, digit or orbit census was performed.

The [owner](m4-fourier-windows.md#dyadic-anchors-give-later-modular-shadow-blocks)
records the new actual-tail estimate and exact remaining target-placement
premise. Separate argument review completed06:23:41 with no D/I/Q items.
Early primary-source inspection found related Gregory-tail radix cancellation;
root's subsequent bounded public Lean queries found no exact candidate.
Source formulas are contextual, not imported into the proof, and originality
remains undetermined. The new result is paper mathematics, not kernel checked.

Production integration began06:22:46, with06:31 reassessment and06:40 endpoint,
in `/tmp/pi-m4-dyadic-shadow-integration-20261128T0622Z/`. Six owned,
138 protected and11 unrelated identities were recorded before edits. Exact-diff
review and affected checks gate publication. A separate follow-up started
near06:21, with06:31 midpoint and06:39 endpoint, testing whether the actual
grid construction extends to nearby dyadic anchors. Its candidate remains
unadopted pending a frozen report and separate review. No target placement
or V/M4 acceptance has been obtained; authorized research continues.

At06:31:30 reassessment524eaf, all138 protected and11 unrelated identities
still matched. Documentation42bd0d and whitespace7d0109 had passed. The
compatible-anchor worker had completed06:28:32, before its midpoint, and
separate criticism was underway. Its report
`/tmp/pi-m4-dyadic-grid-compatibility-20261128-0622/report-v1.md`, hash
`57134a94c5a024ba5d6608fd534980f43e0077d19e8d0da643931c466d334ef6`,
was read7dbdd3; all three manifest entries matched abe9a1. Parent e79413
reran its synthetic cutoff/odd-part checker successfully. Separate review
completed06:31:45 with no D/I/Q items. The accepted extension moves the
anchor forward while preserving the unique high17 pole, then consumes the
existing sieve at depth d+1. This establishes common anchors; it supplies
no selected-time hit. Both reviewed paper results belong in the same owner
and six-path integration; the06:40 publication checkpoint is retained.

A fresh target-placement inquiry began near06:30, with06:40 midpoint and06:49
endpoint. It tests whether freedom among the compatible anchors supplies a
new actual-numerator estimate, rejecting complete-period and generic-numerator
shortcuts already known to fail. After paper review completed, a separate
Lean cycle began near06:32, with06:44 midpoint and06:55 endpoint, to formalize
the nearby-anchor valuation, generic-grid application and unbounded dyadic
family. It owns scratch files only; production Lean adoption awaits explicit
immutable completion, root-interface checks and separate review. Neither cycle
changes the open selected-time intersection or V/M4 status at this checkpoint.

At06:40:02 reassessment8816a6, the full production review return had not yet
arrived, so its completion checkpoint was explicitly extended to06:46 rather
than bypassing review. The subsequently received return records recoverable
inspection clocks06:37:59–06:39:38; it had completed before the original bound.
All17 frozen entries, six live postimages,138 protected and11 unrelated
identities matched independently. No D/I/Q items were raised. The initial
broad read was truncated and the reviewer restored full guide/diff coverage
with narrow reads; no unavailable earlier clock is claimed. The mathematical
owner is unchanged after review. Only factual review-completion records and
final affected checks remain before publication; scratch Lean and actual
target-placement work continue under their separate bounds.

## 2026-11-28 — Checked nearby-dyadic grid component

The paired paper results were committed as
`7923f1badbe76d0c293659525eaa5daaa692b6e2`, parent61837e1. Commit d0019a,
post-commit2f3bf8, push853ac9/bf529d and remote65544a verified publication
at06:42:11 UTC. All six owned blobs matched; the index was empty and
138 protected plus11 unrelated identities were preserved. Final documentation
065bc4, working/staged whitespace661cdf/56ff02 and exact-stage2e4053 passed.
No repair or PR. Receipt:
`/tmp/pi-m4-dyadic-shadow-integration-20261128T0622Z/publication.json`.

The Lean worker's first clock was06:32:42, with06:44 midpoint and06:55 endpoint.
It froze06:43:07 after all eleven declarations, guarded audits and replay
passed, before the midpoint. Packet
`/tmp/pi-m4-nearby-anchor-lean-20261128-0632/`, ten-entry manifest
`6e8101d0a869b93f48701cdd2d1fd39d1484697cd92539a068497d77f5cf6780`,
matched completely in d8f6b2. Candidate hash
`8917e301b35c7d90e4a96367ce9a2f6c368365f3a059c2a7475ed51d31fc32cc`
was integrated unchanged as BBP/DyadicGrid.lean after explicit completion.
Compiler repairs in scratch were local-instance naming, nonzero sums, casts
and r+d versus d+r normalization; there was no missing mathematical step.

Parent integration began06:43:04, with06:52 reassessment and07:03 endpoint,
in `/tmp/pi-m4-dyadic-grid-lean-integration-20261128T0643Z/`: nine owned,
136 protected and11 unrelated identities. The early library-root build
8633db/0c31ad and root-only probe005141/77b160 passed. Native diagnostics
returned success, partial=false and no items. The exact audit adds eleven
complete types, eleven guarded axiom lists and six explicit boundary consumers.
Every new theorem uses exactly the three permitted axioms. Full build
6867e8/d0744b passed7243 jobs; Test0e8cb7/7db5e0 and38 process tests37b1c6
passed. Pin/formulation diff1d2634 was empty and protection94fc2b passed.
Independent production review and final affected checks gate acceptance.

The separate target-placement inquiry completed06:42:53, before its06:49
bound. Its report `/tmp/pi-m4-dyadic-anchor-placement-20261128-0630/report-v1.md`,
hash `0a4f85ccda3dce5b977045431c58e52eb3177957c988141dbb8dc4b9c37da8b4`,
was read d31191 and checked94fc2b. It found no new actual target-hit estimate;
the fixed-modulus source comparison did not control the varying actual phases.
Only that factual outcome is recorded; its mathematical observations and
source analysis remain unadopted. A changed comparison-model inquiry began
near06:45 with06:54 midpoint and07:04 endpoint, testing the new combined
resources against an existing avoiding forcing without rebuilding that model.

An independent analytic-contract/Lean inquiry began near06:44, with06:52
midpoint and07:02 endpoint. It is mapping the reviewed modular-shadow proof
to actual existing declarations and testing a first stronger BBP tail bound.
Its scratch results are unadopted. The grid formalization does not formalize
the analytic remainder or supply selected-time target hits. V/M4 remains open,
and these independent inquiries continue within the authorized milestone.

The06:52 checkpoint was assessed early at06:51:21 in6d726b: all21 frozen
entries, nine live postimages,136 protected and11 unrelated identities still
matched. Required executable checks were complete and review was finishing.
The subsequently received independent review records06:49:21–06:51:56 and
no D/I/Q items. It matched the production/worker sources, full audit contracts
and every packet entry, and retained caller execution/preservation receipts
as such. The code and audits are unchanged after review; only factual status
updates and final affected checks follow. The07:03 endpoint is retained for
publication while both independent scratch inquiries continue.

## 2026-11-28 — Testing the combined resources against the existing model

The nearby-dyadic Lean grid component was committed and pushed as
`0049319b74fa28e9afda81ed9ca7288094b76a06`, parent7923f1b. Commit91e5c2,
post-commit91251e, pushd4e995/fd4087 and remote9b5b2e verified publication
at06:54:38 UTC. Nine owned blobs matched;136 protected and11 unrelated
identities were preserved, with an empty index. Final documentationeb6b76,
working/staged whitespacea6f410/4826ae and exact-stage6575e0 passed.
No repair or PR. The publication receipt remains in the0643 integration packet.
Remote1b797a reverified0049319 at the next cadence; no ready commit was withheld.

The changed comparison test began06:45:17, reassessed06:54:06 and froze
06:59:06 before its07:04 endpoint. It proved the existing13-pole F retains
both original shadow blocks and common-anchor fine grids, while its selected
frozen phases all miss(3/4,7/8). The [owning argument](m4-fourier-windows.md#both-resources-alone-do-not-supply-selected-target-hits)
preserves the rational constant32/21, which pi's irrationality excludes.
This separates the two resources from the missing placement implication;
it does not refute actual V or identify a sufficient additional hypothesis.

Frozen report hashc5be0b1372c287d7189d1df6de96487213863a7c2020fff024ec5c79dc6592f0
is in `/tmp/pi-m4-combined-resource-test-20261128-0645/`.
The receipt's five hashes matched665fb8; caller checkerb61fb3 passed with
exit0 after source inspection. It checks universal polynomial identities,
the finite all-order integrality certificate, density tables and pole residues;
it computes no actual state. Separate paper review07:01:02–07:03:29 found
no D/I/Q items. The whole sketch cycle required no repair.

Documentation integration began07:10 UTC in
`/tmp/pi-m4-combined-resource-integration-20261128T0709Z/`, with07:16
reassessment and07:24 endpoint. Three owned paths,142 protected and11
unrelated identities were frozen3fc674. The exact source map is reused for
this extension of the same comparison; no new source theorem or priority claim.
Production-diff review and affected checks remain required before publication.

The independent analytic Lean worker froze its first packet07:00:12:
`/tmp/pi-m4-shadow-contract-20261128T0644Z/manifest-v1.sha256`, hash
`ce39c493b0800dd1557c22210807908cc4deb4b0f9cd8539577220aa870be458`.
It reports checked actual quadratic tail bounds, integral representation and
all-order numerator integrality. The successor inquiry, with07:12 midpoint
and07:22 endpoint, reports actual moment and signed factorial-remainder proofs
compiling in scratch. These are worker receipts, not adopted production or
independent code-review claims. The final modular-shadow theorem and selected
target visits remain outside the checked production result.

A changed actual-A inquiry tests the exact odd numerator residues just before
the integer-clearing times, asking whether they supply useful translated
comparisons or only another target-placement reformulation. Its07:24 midpoint
and07:34 endpoint require a justified use or a precise failure, not a further
countermodel taxonomy. No actual-state census is authorized. V/M4 stays open.

The07:16 integration checkpoint completed early: independent exact-diff review
ran07:13:37–07:14:57 and found no D/I/Q items. All nine frozen entries and
three live postimages matched; executable and protected-file receipts were
correctly retained as caller evidence. Documentationdcd696, whitespace77a2b3
and freeze/preservation53ba4e passed. No substantive repair followed; final
edits record review completion only. The mathematical owner is unchanged.
Final affected checks and publication complete this checkpoint, not M4.

## 2026-11-28 — Formalizing the actual finite tail expansion

The combined-resource comparison was committed and pushed as
`cb4a184b34cd4f9c81356930e3c0c479addead20`, parent0049319. Commit45ba40,
post-commit7e8b3b, pushf7e9b6/4e698b and remote6c8d40 verified publication.
All three owned blobs,142 protected and11 unrelated identities matched;
the index was empty. Final documentation62ac97, whitespace129786/31b211
and exact-stage7b4ef2 passed. No repair or PR; publication receipt is in the
0709 integration packet. The comparison limits a generic inference, not V.

The analytic worker's successor ran07:03:17–07:16:17, completing before its
07:22 endpoint. Its eight-entry manifest
`bf10a911b177948efa102e53c9f5206038903954d31fac39bc17e67de0b0d9a8`
in `/tmp/pi-m4-shadow-core-20261128T0703Z/` matched197687. Source
`a74bd1fb2b5d4817422e50dd7a719b661063e4a3c6f3ba22db14d05ac86bb5b8`
proves actual coefficient integrality, moment positivity/factorial bounds and
the signed remainder for all finite K at N>0. Parent read the complete source,
separate importing probe and report. These instantiate the previously reviewed
paper argument, using a finite integer recurrence rather than differentiating
an infinite transform. No new source theorem or originality claim is involved.

Production integration began07:18 UTC, with07:29 reassessment and07:40
endpoint, in `/tmp/pi-m4-tail-asymptotics-integration-20261128T0718Z/`.
Scope385af7 records nine owned,137 protected and11 unrelated identities.
The new BBP/TailAsymptotics module uses the actual existing Tail module;
nineteen public theorems and nine exposed definitions have concrete consumers.
Twenty-six helpers are private. The production namespace is BBPAsymptotics;
scratch diagnostics moved to Test.lean. No existing definition or proof changed.

The early root buildcb5508/19f365 succeeded but enabled style linters found
long lines and two `show` uses. Wrapping lines and using `change` cleared them:
a2c3f6/f19df3 passed7247 jobs without warnings, and native diagnostics returned
success with partial=false and no items. Root probe5afb5a/428f40 passed with
unused binder-name warnings; underscore names repaired those, and b3d3b7/ed38ea
passed silently. These were compiler/style repairs, not missing mathematics.

Full build30cf15/a6ad01 and38 process testscf1c81 passed. Initial full Test
1246ec/ef2759 failed because the new audit section opened only the inner
namespace; adding PiDisjunctivity locally repairs lookup of the actual tail
and coefficient. The theorem source and contracts were unchanged. The required
Test rerun and independent exact-diff review gate acceptance. Pina958d7 is
4.37.0-rc1; pin/formulation/old-tail diffa439c8 is empty.

The next arithmetic inquiry has07:28 midpoint and07:40 endpoint, using only
the immutable core in scratch. It reports integer clearing and the complete
original shadow bound compiling, pending a frozen packet and independent
review. This is not an adopted production result. The separate actual-residue
inquiry retains its07:24/07:34 bounds and the joint target-placement obstacle.
The analytic core closes concrete proof obligations; selected visits and M4
remain open.

The corrected full Test73cfba/f5f956 passed silently. Documentationa7c9b7,
whitespace1caecf and protectiondf723d passed; all137 protected and11 unrelated
identities match. The35 new examples are19 exact types,13 explicit theorem
consumers and3 definition consumers. All19 axiom guards passed. These checks
prepare the frozen production review; they do not replace it.

The07:29 checkpoint was assessed early at07:27:18 in076124: all23 frozen
entries, nine live postimages,137 protected and11 unrelated identities matched.
Independent review ran07:24:49–07:29:47 and found no D/I/Q items. It inspected
all716 source lines and the complete1187-line diff, exact audits and consumers,
and matched the worker/integration inventories. Execution and protected-file
checks remained caller evidence. No substantive repair was required; final
edits record factual acceptance only, followed by affected checks/publication.

The full-shadow worker separately froze v3 at07:26:37 and completed the
general s>=128 nonvacuity successor. Parent read v3 and verified all seven
entriesef9661. These packets remain unadopted pending their own integration
and review. The next worker slice checks the same-anchor combined statement
and exact finite target-transfer consumer, with07:43/07:55 bounds. It must
retain actual selected-time target hits as an explicit missing input. This
does not enlarge the accepted analytic-core scope or close V.

## 2026-11-28 — Full dyadic comparison and the retained phase obligation

The analytic core was committed and pushed as
`ae02a7a2b012935bbccc8b14acf460d434dab34c`, parentcb4a184. Commitbf6f71,
post-commitcb3d91, pushbe2fe6/180145 and remote1a3118 verified publication
at07:33:14 UTC. All nine owned blobs,137 protected and11 unrelated identities
matched; the index was empty. Final documentationc3a83d, whitespace8b58ba/da9d99
and exact-stage607b02 passed. No repair or PR; publication receipt remains
in the0718 analytic integration packet. Next cadence07:48:14 UTC.

Three immutable successor packets close the reviewed paper shadow/consumer
contracts in scratch. Parent read their full sources, reports and import probes:

- `/tmp/pi-m4-shadow-cancellation-20261128T0718Z/`: v3 froze07:26:37,
  seven-entry manifest3104f5c3fdcb8c03b0867e20a51d420480ed3536c743297ca88d869d4df8d7f9,
  matchedef9661. It checks finite integer clearing, the sign, all original
  floor/logarithm/real-power bounds, and the full v block.
- `/tmp/pi-m4-shadow-nonvacuity-20261128T0726Z/`: v3a froze07:29:35,
  six-entry manifestb964c7aa7b042a0971bb68f40da509393bbbc67961e7e7a9ebd4631e9c93fce8,
  matched7e701d. It proves h=1 admissible at every s>=128 and the first-block
  actual-tail consumer. Its proof uses elementary logarithm inequalities.
- `/tmp/pi-m4-shadow-consumer-20261128T0730Z/`: v4 ran07:30:49–07:37:27,
  before07:43/07:55 bounds. Seven-entry manifest
  63963c793d3120673b5954acc8cb68b5c03fe862c141a3d4d902766013873df2 matched90990a.
  It supplies one arbitrarily large common anchor and the exact finite target
  transfer with the actual prefix-hit premise and N+j+1 retained.

Parent integration began07:33 UTC in
`/tmp/pi-m4-dyadic-comparison-integration-20261128T0733Z/`, with07:44
reassessment and07:57 endpoint. Scope7e701d has ten owned,138 protected and11
unrelated identities. Two modules retain eight public theorems, three private
numerical helpers and one concrete error definition. Root/Test audits cover
every type and exact allowed-three axiom set, nine explicit theorem consumers
and the error body, including a conditional endpoint target(0,1).

Early shadow build32c69f/530430 passed with three long-line warnings; wrapping
those lines gave17efe2/c359ca clean7253 jobs. Shadow root probe01fe04/0bbb90
passed. Comparison root build0e7810/12739a passed7255 jobs, and its root probe
f2119d/a0ce12 passed. Both native diagnostic calls returned success,
partial=false and no items. Full build3e461b/b3ce86, Test61d31f/1dfd96 and
38 process tests4cc33d passed. No theorem or hypothesis changed in integration;
production review subsequently completed as recorded below.

The separate actual-coefficient inquiry ran07:12:31–07:24:49, with midpoint
07:23:53 before its07:34 endpoint. Its [paper result](m4-fourier-windows.md#translated-tail-comparisons-before-the-blocks)
proves exact pre-block residues and their fixed-t grid image, but does not
control the actual prefix floor branch. Reportcb47ad179f9373c41c275819a59fdc6be17cfd43515d2da909f9cbcf2994d26d
is in `/tmp/pi-m4-preblock-parity-20261128-0712/`; caller checker06f777 passed
and all three inventory hashes matchedd28567. An initial checker representative
assertion was repaired without changing the universal proof. Independent
review07:26:07–07:29:23 found no defects or improvements and retained Q1:
actual corrected-phase hits. Q1 remains unresolved and blocks V, not this
residue result. An estimated progress time was explicitly corrected; the
review's start/completion are actual observed clocks.

A supplemental prior-work check found Anashin's2006 p-adic dynamics abstract
and public Mathlib Mahler-basis documentation. Pinned source278262 confirms
the basis definition and natural-binomial identity; neither gives the actual
real floor-branch estimate. This is contextual source inspection, not an
imported theorem, a novelty conclusion or a new Lean proof of the residue grid.
The same elementary asymptotic source map still supplies the mathematical input.

A fresh-context recovery inquiry began near07:36 with07:46/07:58 bounds.
It is testing fixed-order rational tail approximations and exact radix clearing,
while retaining the distinction between failed integer clearing and possible
small nonzero modular residues. Its mathematics is unadopted. This changes
the approximation mechanism rather than relabelling the missing beta-phase
distribution. The full comparison formalization does not close that missing
mathematics; selected-time hits and V/M4 remain open.

Production review completed07:47:43 UTC after full inspection from07:45:20,
before the assigned07:51/07:55 bounds. The30-entry manifest is
255c382f9453d6855bd2a6e90f3a263d01fcb0fabdf8fc059b7cbfb70c88e99a;
the905-line diff is feaa1954668048beb6ff449254de662aced6d441eca3d28a37feb5da86aeaa0f.
Both guides and all original contracts were covered. No defects, improvements
or new questions; inherited pre-block Q1 remains unresolved and blocks V/M4.
The full return is captured outside the immutable inventory as
`review-full.md`, hash89691379f9d11c7840ae9711d6f1baef3d87e0aacf624d002bbb4143cab8bcb0.
All30 integration entries,20 worker entries and ten live postimages matched
for the reviewer. Execution and preservation receipts remain caller evidence.
Caller088d65 reverified138 protected and11 unrelated identities; remote1d3371
reverified ae02a7a at07:46:34, with no ready reviewed commit withheld.
Factual completion updates now prepare the accepted intermediate result for
publication; no Lean proof or mathematical contract changed after review.

The separate rational-tail inquiry completed its bounded test and froze at
07:48:15, before07:58; its actual midpoint was07:46:46. The scratch report
`/tmp/pi-m4-tail-rational-clearing-20261128-0736/report-v1.md` has hash
e44140f50e4160ca2bbcad1d9dbf0693f7cb1dfa9540584ed2dfeb3eee2a673a.
Parent read the complete report and receipt7c274b. Its proposed fixed-order
clearing obstruction remains unadopted pending separate mathematical review;
growing order, small nonzero modular residues and target placement remain open.

## 2026-11-28 — Rational tail clearing test and continued comparison search

The full dyadic comparison was committed and pushed as
`db3baef2ccd65dc437dcb3b1385813abacd5962a`, parent ae02a7a. Commit 9412b3,
post-commit ef9664, push 30851e/7c8eb5 and remote 78a62e verified publication;
receipt c43503 recorded it at 07:55:02 UTC. All ten committed blobs matched,
the index was empty and 138 protected plus 11 unrelated files were preserved.
Final documentation 9b3e4d, working/staged whitespace 07133d/f0792f and exact
stage 22a4f0 passed. No repair or PR. The publication receipt is in the 0733
integration packet. V/M4 remains open.

The rational-tail paper review ran 07:54:19–07:57:53, before its 08:01/08:07
bounds. It found no defects or blocking questions and one nonblocking I1:
derive the uniform factorial error bound from the existing moments. Parent
reconstructed that argument and included it in the
[mathematical owner](m4-fourier-windows.md#rational-tail-quadrature-and-exact-radix-clearing).
The first moments give a rational Gaussian correction, but every fixed-order
correction retains an odd denominator at sufficiently large dyadic anchors.
This excludes exact clearing only. Growing order, small nonzero residues and
actual target placement remain open. No Lean infrastructure was added.

Parent read the full report/receipt 7c274b and checker 59d7dd, reran the unchanged
checker 37881c with exit 0 and matched all three hashes c43503. Both primary
source pages 65–66 were visually inspected by parent as well as worker/reviewer.
The checker covers only universal formal-coefficient and one-node polynomial
identities; the all-order analytic and evaluated-gcd proofs remain paper work.

The three-document integration began 07:59:37 UTC, with 08:07 reassessment
and 08:13 endpoint, in `/tmp/pi-m4-tail-clearing-integration-20261128T0800Z/`.
Scope 3982d1 has three owned, 145 protected and 11 unrelated files. The complete
paper return is `paper-review-full.md`, hash
fc8f674237e2a2dcc66be0952fe048ce65ae6ed75a7087c36486ebdefb287126.
I1 is implemented and verified by the completed production review below;
final affected checks gate publication.

The next bounded comparison search has 08:08 midpoint and 08:18 endpoint.
It tests exact transformations of the actual rational exponential tail kernel,
asking whether a dual remainder can improve modular control or merely return
the unknown original phase. At most two candidates are allowed in that cycle;
new source connections require early primary/public-Lean checks. Symbolic
identities are allowed, actual-state censuses are not. This changes the failed
fixed-order clearing question without claiming a new visitation mechanism.

Exact production review ran 08:04:25–08:05:39 UTC, before its 08:08/08:11
bounds. The 202-line diff has hash
1a1b628d07006f59c6f28e16731621bc434a84b321f9f96a8e7ed652934a7b2d;
the ten-entry manifest is
d53272e7badb246aedf5ed9d9c591ff2ba3141c1c7b98f31b964b4cdd3259a48.
No defects, new improvements or blocking questions; I1 is implemented and
verified. Full return `review-full.md` in the 0800 packet has hash
f8cc4f5a0c29ad08fb6d4bbcafb3f3f5f4c74fb3bfb9f302d692ef8d8ba140ab.
All frozen entries and owned postimages matched independently; execution and
protected-file preservation remain caller evidence. Caller 9ef506 assessed
the midpoint at 08:06:58, verifying all ten entries, three owned files,
145 protected and 11 unrelated identities. Only factual completion records
changed after review; no mathematical claim or proof changed.

## 2026-11-28 — A second anchor family and the compatibility prior-work search

The rational-tail clearing record was committed and pushed as
`657bd34ac3a7193e9027c7bf9247e56e7b2d03dc`, parent db3baef. Commit e5f80a,
post-commit 735188, push 7d8a08/f8e655 and remote 851eb4 verified publication
by 08:09:03 UTC; receipt c23707 saved it in the 0800 integration packet.
All three committed blobs matched, the index was empty and 145 protected
plus 11 unrelated files were preserved. Final docs b79adb, whitespace
8abc49/587640 and stage 17e3f9 passed. No repair, new Lean changes or PR.

The parent tested an actual odd-factor anchor family. Its first external
clock was 08:03:32, following the algebraic candidate; the 08:12 endpoint
was met by freeze 08:10:55. The
[paper result](m4-fourier-windows.md#moving-the-first-block-to-five-times-a-dyadic-anchor)
uses one universal polynomial certificate to move the first signed block to
N=5*2^s, s=5 mod100. Classical irrational rotation then selects arbitrarily
large anchors in this family satisfying the existing nearby-grid conditions.
It supplies neither all original h blocks nor actual target placement.

Report `1f2db990324b5cb245bc6824d451d73da2df416ba9b938fc1b95bf70c9c08667`,
checker `24bd0657519fe8e96cad7b529fbc9bf8b6bbb9b9ce4f7d262191602158afbc86`
and receipt `d2602424b4c072641aa20e5749683e5e895843270ffeeae3bb79de63173360a3`
are in `/tmp/pi-m4-five-dyadic-anchors-20261128T0803Z/`. Checker bb37b9
passed without actual-state evaluation. Pinned source 8c6b35/a164dc supplies
an integer-multiple density declaration; the natural late-time bridge remains
explicit paper reasoning. Independent criticism ran 08:11:17–08:12:36, before
its 08:15/08:18 bounds, with no D/I/Q findings. Full return hash
`0bc03a4484ee0b2fc8b2bc23be796e478407d758674e747cb2bce425981ab987`
is captured in the current 0818 integration packet.

The user asked whether the already formalized compatibility theorem is original.
A separate targeted search ran within 08:05–08:18 and froze at 08:15:07.
It found close published analytic work and public Lean approximation/denominator
proofs, but no exact conjunction or stronger inspected theorem implying it.
The [owner's comparison](m4-fourier-windows.md#prior-work-and-originality-of-the-compatibility-statement)
now credits Chen–Zhang's actual BBP expansion, the public corrected-shadow
results, and the Gregory/Wallis method precedents. Originality remains unknown.
Search report `7f161bc00bd2c922811aadecd1cf2dbbf786dfa8e58db6ac46f4cf71b236e243`
is in `/tmp/pi-compatibility-originality-20261128-0805/`; parent read it fully
in 9df819 and visually inspected the two Chen–Zhang theorem pages at 08:13:45.
Public theorem signatures, corrected-prefix definition and date provenance
were inspected in 91e820. No external Lean build or axiom replay was performed.
One guessed local filename failed in 87d0b8; the actual saved public-prefixed
paths were found and read in b390f8/91e820. No mathematical evidence was lost.

Three-document integration began 08:18:08, with 08:27 reassessment and 08:38
endpoint, in `/tmp/pi-m4-anchor-literature-integration-20261128T0818Z/`.
Scope 5edb97 protects 145 tracked and 11 unrelated files. Exact production
review is complete as recorded below; final affected checks gate publication. No new Lean proof or V premise
is claimed. Separately, the tail-filter inquiry finished 08:13:28, with its
source-backed analytic result still under independent review; it is not
adopted in this scope.

Production review ran 08:21:56–08:24:09 UTC, before its 08:27/08:32 bounds.
The 228-line diff has hash
`ffe5e0ef31f137c9d2435ea04d384e90af1d4fd976e8122d48125080f56be8fc`;
the 13-entry manifest is
`f3f67f6417f49a700e999f53e15203122c7dd0b819e239bf2e5bbf4eb7d5a833`.
All entries and the 15-entry source inventory matched independently. No
defects or blocking questions; one nonblocking I1 identified a displaced
existing section anchor. Parent moved that unchanged anchor back before its
original Normal prime-power heading in 67e01b, without changing mathematics.
Full review capture `review-full.md` has hash
`e00d9b861a9ec4d2943563bc9e12231d0a0040d3e3d0874da5580fef76b06762`.
Caller midpoint 67e01b at 08:25:42 verified all 13 frozen entries, 15 source
entries, three owned, 145 protected and 11 unrelated files before that repair.
Remote d6ec76 reverified 657bd34 near 08:24 UTC during the required review;
no ready reviewed commit was withheld. Only navigation and factual completion
records changed after review. Originality, natural-time Lean formalization
for this new family and actual selected-time hits remain unresolved.

## 2026-11-28 — Filtered actual tails and a changed dynamics inquiry

The second-anchor and originality record was committed and pushed as
`e8cb5777f4571b5dac4aa8e8526f57d8249f2804`, parent 657bd34. Commit d14f0b,
post-commit ed415a, push 40c5cc/7a7f1c and remote b057f5 verified publication
by 08:28:26 UTC. All three committed blobs matched, the index was empty,
and 145 protected plus 11 unrelated files were preserved. Docs 751746,
whitespace 83be19/1265b8 and exact stage 0fe948 passed; a61a69 verified the
navigation repair without mathematical changes. No further repair or PR.

The tail-transformation inquiry ran 07:56:36–08:13:28, before its 08:18
endpoint; the scheduled 08:08 midpoint was observed at 08:09:03. The
[selected filter](m4-transforms-and-periods.md#a-fractional-shift-filter-gives-a-known-alternative-pi-representation)
removes the nearest real Borel pole and retains a pi period, but its series
is the known Ferguson formula. Its moment density is signed. A separate
absolute Cauchy remainder and exact dyadic clearing change constants while
retaining the factorial-order scale and explicit actual target-placement gap.
The other screened reciprocal-Lerch candidate returns the original identity.

The immutable 0756 packet has v1 report
`389d5270b4ad5da4da31c6918c89fb6354ba0dc0160b7848041a3ce8d0442e26`, checker
`2941ef7f59842b2565a03c293cdbafe02d0f4374f9c96cbf7d6ef80cb20b9203` and receipt
`f6a4ce0985b0d83539254d10c86f51d5b8040fd1e019f09fc27f4e27e2e22ff9`.
Parent read the full report ebe083 and checker/receipt 61ac62, reran the
unchanged checker 54f755 successfully and reverified hashes 4ca824. An earlier
checker trailing-zero comparison was normalized before freeze. An intermediate
factor-16 normalization error was corrected before the frozen paper argument.
Neither check evaluated actual states or certified the analytic proof.

Independent criticism ran 08:15:33–08:22:27. D1 found an omitted target-domain
premise; parent wrote v2 with only `0<=a<b<=1` added, retaining v1 untouched.
V2 hash `f2a96a71cd585553d06accd4cc88bb69b763c4f1fcfa7cf2676885fdc9932cf0`
and revision receipt `ef59417c2e47dbb92ea77acca68f37c399d1aaa0e58a8b30f0491e3b0119556b`
were verified in focused review. D1 is resolved. I1 requests explicit zero
density below 11/8; the owner implements it. Q1 retains unproved actual T_N
placement. Full verbatim review is in the 0827 integration packet, hash
`ca02c879153339b11b7d30d5c6913c6c51544dd509cadd234363befee7a8a414`.

The reviewer initially lacked local source captures. Parent retrieved the
primary Lerch v4 HTML and Bailey PDF in a8b911/264445, extracted math-preserving
text cd3c1c and rendered Bailey p.9 in 371d2f. Both parent and reviewer inspected
the formula/attribution; Lerch branch conditions were retained. Source captures
are in `/tmp/pi-m4-tail-duality-sources-20261128T0816Z/`; no source limitation
was silently treated as checked before the captures arrived.

Three-document integration began 08:28:26, with 08:36 reassessment and 08:45
endpoint, in `/tmp/pi-m4-filter-integration-20261128T0827Z/`. Scope 528f24
protects 145 tracked and 11 unrelated files. The transform owner's obsolete
opening review-pending status was replaced by per-result evidence links.
Separate production review is complete as recorded below; final affected
checks gate publication.

The changed dynamics inquiry has 08:34 midpoint and 08:45 endpoint. Its fresh
context first found the proposed solenoid representation already recorded;
it did not count that as new work. It is now testing exact applicability of
homogeneous-orbit and finite-matrix descriptions, retaining the actual initial
point and excluding circular insertion of the unknown phase. Its mathematical
findings remain unadopted. V/M4 and actual selected-time placement remain open.

Production review ran 08:36:40–08:38:16, before its 08:40/08:43 bounds.
The 275-line frozen diff is
`8f395c21fdba29ce82b8550c66f137d0c47b8454c4b8a80c69456defb0842f86`;
the 11-entry manifest is
`668fe17cc036dfaab9b55209a75abb7aff1b22463921bdad8d5327f2d1c10220`.
All entries, nine source entries, three owned postimages, 145 protected and
11 unrelated files matched independently. D1's domain repair and I1's zero
density interval are verified; Q1 remains open, with no new D/I/Q. Full return
`review-full.md` in the 0827 packet has hash
`d7a76d5e72e0af4d4c4563001fbdd74bcfcd646e486f76521078c7e4ea95bd9f`.
Caller 4f8603 reverified the same inventory at 08:39:35. The scheduled 08:36
midpoint was assessed at freeze 08:36:23: paper work was complete and exact
production review was the remaining gate. Docs 61c71f, working whitespace
15b92d and staged whitespace 819950 passed; final factual completion records
receive affected checks. No mathematical repair followed production review.

## 2026-11-28 — Exact cocycle source fit and a finite-matrix obstruction

The filtered-tail record was published as
`0bd22d755446b9a1f8491dd68c24d87e0b08fe4b`, parent e8cb577. Commit aa5019,
post-commit cff136, push df95cc/6d4839 and remote 1e376c verified the exact
three owned blobs and publication by 08:41:54 UTC. Docs c23007, working/staged
whitespace c4ab91/de0cf6 and exact-stage 6a0d76 passed. The index was empty;
145 protected and 11 unrelated files were preserved. No repair or PR.

The fresh cocycle inquiry ran 08:24:18–08:36:58, with observed midpoint
08:33:45 and endpoint 08:45. Its [two tests](m4-two-adic-reflection.md#two-precise-finite-dimensional-representation-tests)
find a failed noncontraction hypothesis for natural matrix products and exclude
an eventual rational observation of any fixed finite constant matrix orbit.
The second exclusion also holds for F, so it supplies no actual-phase selection.
The autonomous rational skew map remains available; general nonlinear or
quotient observations are not excluded. The initial solenoid proposal was
matched to the archive rather than counted as a new representation.

Packet `/tmp/pi-m4-cocycle-sourcefit-20261128T082418Z/` has report
`dfac0f319cbba4dc6b73b60516c2ec0c83375210b9e74f5bd67157416b0aa03c`
and eight-entry manifest
`79bc8745870680d08d09a82f476f2f5fda443b4df64066c4477d0a6ae55e2a2b`.
Parent read the full argument ab701b and checker/self-criticism 4caca0,
verified all eight entries f6b1e0, and replayed the unchanged certificate in
a separate directory 1256ab, exit 0. The certificate tests symbolic poles
and synthetic identities, not the universal paper arguments. The immutable
vector-domain supplement has hash
`1e1a0e5c6ecdc3139db41829f8279596993b30b705553f423238f8118d5bb109`.

Independent review ran 08:37:50–08:41:09, before its 08:44/08:49 bounds.
No defects or acceptance-blocking questions; I1 clarifies that polynomial
boundedness belongs to the o-minimal structure. The owner implements that
wording, now verified in production review. Full return in
`/tmp/pi-m4-cocycle-integration-20261128T0843Z/paper-review-full.md` has hash
`12af5056c6997c6dbfb2e51e0671b0912a2342bc0b310ebfcdd9fd6cf6d4c20c`.
Local PDF extraction was unavailable; caller-rendered BSX pp.3–5 and Schneider
pp.3–4 in 8c3d21/a67314 supplied the required primary pages. Both reviewer and
parent inspected the decisive BSX hypotheses; no source gap was ignored.

Three-document integration began 08:43:11, scope fef7a1, with 08:52 midpoint
and 09:03 endpoint, protecting 145 tracked and 11 unrelated files. Exact
production review is complete; final affected checks gate publication. No Lean changed.

The next algebraic test classifies fiber-preserving affine rational commuting
maps of Psi and compares the same class for F (08:50 midpoint, 09:00 endpoint).
Its consumer is a possible independent scalar action; an iterate alone supplies
none. A separate fresh-context inquiry excludes matrix/centralizer routes and
seeks a changed actual-phase discriminator (08:54 midpoint, 09:05 endpoint).
These research findings are not yet adopted. V/M4 remains open.

Production review completed 08:46:01–08:46:49, before its 08:50/08:54 bounds.
The 233-line diff has hash
`38cae916c2e306712d3d7b6d2db0d57cbfe3e208d1829d9ea7351e5a4eda39a4`;
the 11-entry manifest is
`f51f1b0632fc0d91896cb3bf1e83e8191420edd75bce3b2b689381103a09f264`.
All frozen entries, 15 source entries, owned postimages and protection hashes
matched independently. No D/I/Q beyond verified prior I1. Full return
`review-full.md` has hash
`7da76ac299cb85222ad84a4959c6b802122773a81418a4b262da4848964f7ee4`.
Caller 6bcb93 verified the same inventory at 08:49:10, before factual status
updates. This early completion serves the 08:52 integration reassessment;
the remaining work is affected checks and publication, without math changes.

## 2026-11-28 — The restricted commuting-action test closes without a visit

The matrix record was committed as
`94f4e8b19449a0f31caa2cf4d22d2f873033db84`, parent 0bd22d7, and pushed.
Commit d05bd5, post-commit c8564c, push c809bb/ae5f82 and remote 2e9392
verified publication by 08:51:30. Docs 645c06, whitespace 2903a2/f167f3 and
exact staging 8de448 passed. Three owned blobs, 145 protected and 11 unrelated
files matched, with an empty index and no post-commit repair or PR.

The commuting-action inquiry ran 08:41:51–08:47:33, finishing before its
08:50/09:00 bounds. The [restricted centralizer proof](m4-two-adic-reflection.md#the-affine-rational-commuting-maps-supply-no-second-action)
finds only integer iterates, both for actual A and avoiding F. The comparison
therefore gives no actual-phase distinction. This representation route is
suspended; broader centralizers are outside the result and have no new
visitation consumer. The separate growing-prime inquiry continues.

Immutable packet `/tmp/pi-m4-affine-centralizer-20261128T084151Z/` has report
`cf944362e504225cc10876eb5db70768befa8ab9d89d705bfe5b79d8f04e7e1f`
and eight-entry manifest
`2ab2c09006f5c53bc2c9ffed363ece1bb082f1c1a8b230ae50572ef6d6c698cb`.
Parent read the full report/checker 1ebeff, verified hashes 9e0b9c and replayed
the unchanged print-only certificate 37ff25, exit 0. It checks both weighted
profiles and fourteen symbolic rational identities, not arbitrary maps.

Independent review ran 08:48:50–08:51:24, before its 08:54/08:59 bounds.
No defects or new improvements; author I1's fiber-domain clarification is
verified. Q1 retains broader classes outside scope; Q2 retains no actual-phase
consequence and the route suspension. Both primary PDFs and five caller-rendered
pages were inspected. Full return in the 0853 integration packet has hash
`7443165fa483ee5a24b6c5a67da16bf354e3faef8314874a47d755d13bceabf8`.
Two unavailable pdftotext calls supplied no evidence; preserved renders did.

Three-document integration began 08:53:44, scope 41632d, with 09:00 midpoint
and 09:08 endpoint, protecting 145 tracked and 11 unrelated files. Exact
production review is complete; final affected checks gate publication. No Lean or dependency
changed. The growing-prime test has observed midpoint 08:53:24 and endpoint
09:05; its findings remain unadopted. V/M4 and actual target placement are open.

Production review ran 08:56:21–08:57:43, before its 09:00/09:03 bounds.
The 157-line diff has hash
`a83f22361fe84307004467d3b9884e9ee426282dfff317ef706264c238024f0e`;
the 11-entry manifest is
`20b82e0090b2647272ef9840e291807cafb9de9d092eec59893aa9d8f612c4e6`.
All frozen, 14 source, three owned, 145 protected and 11 unrelated entries
matched. No defects; author I1 preserved. New nonblocking I2 identified stale
preceding research-question wording; parent replaced it with a cross-reference
to the completed restricted test, retaining no second action. Q1/Q2 remain.
Full production return `review-full.md` in the 0853 packet has hash
`dde4a34343a4e320790b99d1df2e16ba6a5db0da5660608cc6ed93b560c938e2`.
Caller 047635 reverified every frozen/source/protection entry at 08:58:44
before that navigation/status repair. Early completion serves the 09:00
integration reassessment; no mathematical proof changed after review.

## 2026-11-28 — Growing-prime distribution preserves a positive avoiding model

The restricted-centralizer record was published as
`11a9f8b946d6036ef08d3045a3788863f4ee8680`, parent 94f4e8b. Commit c17392,
post-commit fea82b, push d41454/887b0a and remote a76571 verified publication
by 09:00:39. Docs 07c6f4, whitespace a0a907/fc1965 and exact-stage 1cd826
passed. The owner differed from its reviewed postimage only by I2's exact
navigation repair. The index was empty; three committed blobs, 145 protected
and 11 unrelated files matched. No post-commit repair or PR.

The fresh-context inquiry ran 08:42:57–08:59:34, with observed midpoint
08:53:24 and endpoint 09:05. Its initial Pade/language idea matched archived
failures. The [changed growing-prime test](m4-fourier-windows.md#growing-prime-projections-and-the-unscaled-branch)
instead finds complete cycles between activations, uniform unit survival at
growing depth and an applicable complete-subgroup source estimate. The same
prime, horizon and global multiplier work for actual A and positive avoiding F.
This closes a projected short-piece question but rejects the projected-only
visitation consumer. No unscaled hit or new Lean theorem is supplied.

The immutable packet `/tmp/pi-m4-variable-prime-projection-20261128T0843Z/`
has report `657acff4f1c792af82609c9c16fc1f39c0b3aaf7add0b25f07e63d37dbab3286`
and 14-entry manifest
`fbcc558fcd247423d638c9c4c34743a47037f0b1da0c07720684d97ad0fa6da5`.
Parent read the full report cd5d8d and checker e18420, verified the inventory
3d3c16, and replayed the unchanged checker dbec69: 10,818 assertions, exit 0.
Parent receipt `/tmp/pi-m4-variable-prime-parent-receipt-20261128T0901Z.json`
is byte-identical to the worker receipt; 94f090 reverified all originals.
These are synthetic/universal-identity checks, not actual-prefix computation
or certification of the analytic inputs. Both source pages were inspected.

Independent review ran 09:00:40–09:04:16, before its 09:07/09:13 bounds.
All D/I/Q categories are empty for the scoped paper claim. Source inspection,
exact clocks, factorial height, initial mass, common multiplier and positive F
comparison all passed; mixed statistics and actual placement remain open.
Full return in `/tmp/pi-m4-variable-prime-integration-20261128T0902Z/` has hash
`6e3d28b7312850e1c16c9d68e3598bcf90402b95e5381cebad2ef7864ed94734`.

Integration began 09:02:30, scope aa0a39, with 09:12 reassessment and 09:23
endpoint. It protects 145 tracked and 11 unrelated files. The owner's obsolete
opening exception for only one Lean probe was replaced by per-result status
and a link to the checked full comparison. Exact production review is complete;
final affected checks gate publication; no Lean changed.

The next mixed-prime cycle has 09:12 midpoint and 09:22 endpoint. It must
restore the complementary integer branch and full conductor, test exact
source hypotheses and compare the same statistic with F. Separate marginal
distribution or a repeated full-CRT reformulation does not meet that endpoint.
Its findings are unadopted. V/M4 and all actual-hit premises remain open.

Production review ran 09:08:51–09:09:54, before its 09:13/09:17 bounds.
The 254-line diff has hash
`338394d1fe84d6507fcdbd949082024618b9e4fe62105cf0a0dcfa39b690557d`;
the 11-entry manifest is
`7e481f602c772a336aef4312110ea3d0e004503b1fecf02459190fdfe02415d8`.
All entries, 16 source files, four worker-input identities, three owned,
145 protected and 11 unrelated hashes matched. D/I/Q remained empty.
Full production return `review-full.md` in the 0902 packet has hash
`1e0052ce026e0fdc8f839740b501c0cf360a2e7e4d18334a8fc3cb4547e52c82`.
Caller 9bb698 reverified the complete inventory at 09:10:46 before factual
completion updates. This early completion serves the 09:12 reassessment;
only final affected checks and publication remain. No proof changed after review.

## 2026-11-28 — Joint two-prime cancellation and a correlated complement

The growing-prime record was committed and pushed as
`88b9d48c6c2a7a0c845bc19e3c63dae7b64d5c90`, parent 11a9f8b. Commit c38b82,
post-commit 82dabe, push 56f258/39145d and remote 71b7fc verified publication
by 09:13:47. Docs b16f6a, whitespace 454e4b/c8b1af and exact stage 306968
passed. Publication receipt e301a5 records the unchanged committed blobs,
145 protected and 11 unrelated files. Remote equality was checked again at
the subsequent directions, including 84409b at 09:29. No empty commit or PR.

The [joint two-prime test](m4-crt-phase.md#joint-two-prime-cancellation-still-leaves-the-complementary-phase)
ran 09:01:47–09:19:48, with midpoint 09:11:18 and endpoint 09:22.
Bourgain–Chang's few-prime-factor source applies to the joint projected
factor after an explicit split into periods and a remainder. Restoring the
actual complementary factor retains both the forcing and exponential
conductor. The fixed positive F has normalized projected and restored means
tending to zero and one at frequency21, with complementary squared variation 2N+o(N).
This rejects the proposed joint-projection-only consumer; it supplies no
actual A correlation, variation or selected hit.

Immutable packet `/tmp/pi-m4-mixed-prime-restoration-20261128T0901Z/` has
report `0b3b4de076b994f54fa0800ac3e3b56ce843d48041c0ad2751083bfaf75baa17`
and 14-entry manifest
`3b31636aac44d41c2ff5e52d1e5e4561d8c944bc70ad217de3181fc6d54e65e9`.
Parent read the full report e9b2c4/19667d and checker 8e6aee. After the
09:24 replay output was lost to context truncation, 82e3a4 explicitly replayed
to a fresh receipt and returned exit0. It passed 60,791 synthetic/universal
checks, of which 55,582 are elementary division/remainder bookkeeping.
Neither the source theorem nor asymptotics follow from those finite checks.
20d2f3 verified the identical receipt and both 14-entry original inventories.
No actual A/D/F prefix, denominator, digit, carry or orbit was computed.
Parent and reviewer inspected the preserved printed source pages38,42,43.

Independent review ran 09:22:36–09:28:26, before the 09:35 endpoint.
No blocking defects. I1 requires transitions to stay below H; I2 restricts
the ordered-partial lemma to offsets1,...,8. Both are implemented in the
production draft. Q1 actual correlation and Q2 actual variation remain open.
Full return in `/tmp/pi-m4-mixed-prime-integration-20261128T0932Z/` has hash
`28581d4c5bf289cfecf74c36b5bbcd9e2a9fa1c02fca4e16d2cafddfbaf3c2e5`.

Integration began 09:30:49, scope 20d2f3 with disjoint protection corrected
in a1c873, midpoint09:40 and endpoint09:49. Three documents are owned;
145 tracked and 11 unrelated files are protected. Exact production review
is complete; final affected checks gate publication. No Lean or dependency changes.

The next diagnostic tests the variation budget needed by summation by parts
against the exact actual complementary recurrence, midpoint09:33 and
endpoint09:44. A separate recovery tests moving-target Subspace Theorem
hypotheses against the four-pole recurrence, midpoint09:27 and endpoint09:38.
Neither inquiry's findings are adopted here. M4/V and the target-time
intersection remain open; a reviewed obstruction does not end the research.

Production review ran 09:34:21–09:35:45, before its 09:40/09:44 bounds.
All 295 diff lines, 11 packet entries, 31 source entries, three postimages,
145 protected and 11 unrelated files matched. Manifest hash
`112b9d06f1d69c82f685dad603151696ef0b417126d54911c88d6c28f9713821`;
diff `dc88c8a362be3656d5192b0d51f4fc246deabbfe1d5ecbaead60829c19b20892`.
No defects; I1/I2 verified. I3's limit wording is implemented in the log;
Q1/Q2 remain open. The mathematical owner is unchanged after review.
Full production return in the 0932 packet has hash
`a2b8c4667ee76bdd04b074a17762feb517d3f1b775dbab3bafe091c2b86a919b`.
Caller 461ab4 reverified every frozen/source/protection entry at 09:37:18
before I3 and factual status updates. Early review completion serves the
09:40 reassessment; final affected checks and publication remain.

## 2026-11-28 — Complementary variation and moving-target source limits

The joint-projection record was committed and pushed as
`4951e0004727d9cb1bdeca595d7758374af7866f`, parent 88b9d48. Commit d96b78,
post-commit 009b7f, push 980103/120acb and remote 362bf7 verified publication
by 09:38:23. Docs 88ab55, whitespace df60d7/669874 and exact stage1f0820
passed; the mathematical owner was unchanged after review and log I3 was
verified. Receipt a44cb7 records publication. Three committed blobs,
145 protected and 11 unrelated files matched; no post-commit repair or PR.

The [variation diagnostic](m4-crt-phase.md#complementary-variation-requires-more-than-the-finite-arithmetic-data)
ran 09:24:10–09:38:10, midpoint sent09:32, endpoint09:44. It quantifies the
position-sensitive Abel cost and the coarse sufficient budget. Small actual
variation forces a fifteenth-root shadow, but the restored pi approximation
retains denominator15P|h|16^N and gives insufficient precision at J=o(N).
Alternative entries preserve exact entry denominator, floor, projections and
future A while permitting tiny or linear variation. They lose initialization.
No actual regularity follows; the ordinary-variation repair is suspended.

Packet `/tmp/pi-m4-complement-variation-20261128T0924Z/` has report
`a290c8c05b197932c4050c3556a194777e199a5345c952030a8315c1d734591d`
and 11-entry manifest
`907fdf686850709a108e455b23782f9de1daa9f016793ebd2f2d39bb7d1153d4`.
Parent read all report/checker text in 6857b9/91bc3f/1c4faf and the DLMF
formulas0cb8e0. Initial receipt comparison f50c38 failed because the author
receipt wraps the result, not because the checker failed. Inspection044d72
identified that schema; 09747d replayed and compared its `result` exactly:
501 synthetic assertions, exit0. No analytic or actual-state certification.

Independent variation review ran 09:40:28–09:42:40, before09:46/09:55.
No defects; I1's canonical r_0, m|M and explicit CRT difference are implemented.
Q1 actual Abel regularity and Q2 actual entry selection remain open.
Full return in `/tmp/pi-m4-variation-moving-integration-20261128T0941Z/`
has hash `914ddf99882f35c5eaf1c4df60ca15a3a9bef1438bd64c143465256df26f1da1`.
All11 packet entries and both preceding14-entry packets remained intact.

The independent recovery's [moving-target test](m4-language-auxiliaries.md#moving-target-approximation-retains-degeneracy-or-insufficient-precision)
ran 09:17:22–09:33:58, midpoint09:27:02, endpoint09:38. Ru–Vojta's
forcing-centered forms violate coordinate independence on a recurring-carry
subset. Constant forms repair applicability but their fixed-place proximity
is only O(log n), below the linear-height budget. Even labels supply no gain;
the same mechanism works for F. No actual odd-carry or visitation result.

Packet `/tmp/pi-m4-moving-target-test-20261128T0923Z/` has report
`6a32d645216d044f97ca1ca7077a26c0b7dccefcd55c425045c353688f767dc4`
and 15-entry manifest
`172ab97d0bbf28a8e337b3d0206fbc5b215140ba3aff41e2023e52e49882baa2`.
Parent read report c5855e/daadf8 and checker b4f239; eff6cb verified all15
entries, e70810 replayed786 formal/synthetic assertions with exit0, and
09747d saved an exactly matching result. Parent visually inspected Vojta's
printed pp.552–554; no external proof-chain or Lean audit is claimed.
Independent review ran09:35:01–09:39:13, before09:43/09:50. No D/I;
Q1 admissible strong approximation and Q2 other representations remain open.
Full return in the0941 packet has hash
`2ccacbe8c9bcba85d8af95972c003373b229d41c42ad93fc8c5a6983d43b3850`.

Four-document integration began09:40:23, scope f50c38, with09:51 reassessment
and10:07 endpoint, protecting144 tracked and11 unrelated files. Both paper
reviews and exact production review are complete; affected checks gate publication.
No Lean, dependency or theorem-contract change. A fresh recovery began with
remote equality at09:38:23, midpoint09:49 and endpoint10:01. Its candidate
Euler-product/parity mechanism is exploratory and must distinguish archived
Dwork and bounded-Dold failures before adoption. V/M4 remain open.

Production review ran09:47:04–09:49:33, before09:52/10:00. All378 diff lines,
14 packet entries,60 source entries, four postimages,144 protected and11
unrelated files matched. Manifest
`a14c1a07c7424bb87f9e0703ed60ec3c292c534a4f4cfdf63da55b0c8a3ddc0b`;
diff `9db7f5f8f37cbd16b523c7d494f49c28a6cf03e299e369bc80d2c7557c4b1075`.
No defects. I1 verified; I2's projection time range is now expressly within
the fixed horizon. All four open obligations remain. Full production return
in the0941 packet has hash
`492b6410a3300e681279b48338a68000e7f8b34c3877822b9f168610f4f72fb2`.
Caller eda1bf reverified every frozen/source/protection entry at09:50:42
before the exact I2 clarification and factual status updates. This early
review completion serves the09:51 reassessment; final checks/publication remain.

## 2026-11-28 — Euler squares, radial periods and the retained state factor

The variation/moving-target record was committed and pushed as
`ecc01aec2108dd80e51be9ac700ec3f0c58a4e1b`, parent4951e00. Commit02d6ae,
post-commit318681, push a7d39c/07084b and remote837b01 verified publication
by09:51:47. Docs c7af86, whitespace a32366/fe8f3e, exact stage cda4a8 and
exact I2 owner replacement95f38f passed. Receipt701c87 records publication;
four committed blobs,144 protected and11 unrelated files matched. Remote
equality was rechecked at09:56:37 in b9622b for the subsequent result.

The [changed Euler-product test](m4-generating-functions.md#formal-squares-can-retain-a-transcendental-radial-exponent)
ran09:39:23–09:55:30, observed midpoint09:49:06, endpoint10:01. The earlier
09:47:52 update prematurely used the planned midpoint label and was corrected.
An exact four-pole integral gives a transcendental unweighted exponent L,
but an integral formal square can have exactly that radial exponent and a
finite positive leading constant. Actual Q_k=P_A*J_y retains the whole
selected-state factor; Q_k and J_y both have infinite radial order. The
candidate fails before it can distinguish the actual phase or positive F.

The parent proposed a separate [root-of-unity continuation test](m4-generating-functions.md#the-forcing-product-itself-has-a-natural-boundary),
independently reconstructed and frozen09:57:41. At each primitive root of
order m>=3, P_A has a noninteger radial exponent between0 and1/2, ruling
out meromorphic extension through the dense set. This generic positive-weight
mechanism also holds for F; it supplies no parity or visitation conclusion.
The remaining consumer needs independent control of the same J_y quotient.

Packet `/tmp/pi-m4-euler-radial-test-20261128T0948Z/` has original report
`e3b95a17f63f1e8bae9be3fcf7f12dcc01f142836ea64d3c8f0ff47aa362ce96`
and seven-entry manifest
`515d37406fe09622276b444f6bf0a659b3d9ec56382afe1cba8462f3892d1ea2`.
Supplement `3809911afc8dc1d95a5cda5a4a093975f9405cb83be13605f252f6a6088e2e33`
has three-entry manifest
`f72e0c9736a0554b9ac693d03994d78949b0a72bb7c913d74145af272cb03a08`.
Parent read both reports23f942/dde48c/221783, checkers fdde30/db9358 and
visually inspected Pomerat–Straub p.1 and Baker printed p.20. Because both
checkers write receipts, unchanged copies ran in
`/tmp/pi-m4-euler-parent-check-20261128T0958Z/`. Replays be6ede and6dbf17
passed1,700 and1,057 exact assertions, exit0, with byte-identical receipts.
cd95d0 verified every original/supplement entry remained unchanged.
The finite checks certify neither convergence nor Baker nor actual visits.

Independent paper review ran09:57:29–09:59:45, before10:05/10:12.
No D/I. Q1 selected-state control and Q2 other specified normalizations remain
open. Full return in `/tmp/pi-m4-euler-integration-20261128T0959Z/` has hash
`8b5e6e5f3838ea5aec817215b2be12080121eaee1f30596ec50a4b722b0002de`.
The Baker PDF identity and both theorem pages were checked, without auditing
their full proof chains or claiming Lean certification or originality.

Three-document integration began09:58:48, scope6dbf17, midpoint10:09 and
endpoint10:24, protecting145 tracked and11 unrelated files. Exact production
review is complete; affected checks gate publication. No Lean or dependency changes.
The next bounded investigation checks an exact global adelic/radius-product
source against the actual coefficient denominators and forbidden-word premise,
midpoint10:12 and endpoint10:23. Its claims are unadopted. C_odd/V/M4 remain open.

Production review ran10:05:58–10:07:19, before10:11/10:17. All279 diff lines,
11 packet entries,17 source files, three postimages,145 protected and11
unrelated hashes matched. No D/I; Q1/Q2 remain. Manifest
`10cb4ad06ee293e538eccc770322647fecd9e3cfdd1a39bceff046aca77e3465`;
diff `0820b983d66dc51e7add35474073ee7251b5bbb313bd2751401090206ced2712`.
Full production return in the0959 packet has hash
`2da7e8de140ca6ab804e53336bac508cca71053236d05b2f8ed683843fc79757`.
Caller3dc171 reverified every frozen/source/protection entry at10:09:22
before factual completion updates; the mathematical owner is unchanged.
Early review completion serves the10:09 reassessment. Final affected checks
and publication remain; the global adelic inquiry continues independently.

## 2026-11-28 — Arithmetic sizes and the same-function continuation gap

The Euler radial/natural-boundary record was committed and pushed as
`5e0950474be3168f899a59fb748c0a41c4aaf042`, parent ecc01ae. Commit47989b,
post-commit751236, push5c23ed/975f96 and remote e59601 verified publication
at10:10:26. Final docs42c76e, whitespace3efe19/1fd3c4 and exact stage65e7c9
passed. Publication receipt a34f24 preserves the three committed blobs and
145 protected/11 unrelated files. Remote c216e5 reverified the same head
after the next direction began; no reviewed commit was waiting to push.

The [global arithmetic-size test](m4-generating-functions.md#global-arithmetic-size-retains-an-actual-continuation-gap)
ran from the10:01:32 assignment through10:17:59, midpoint10:12:01,
endpoint10:23. An earlier update used a premature10:07 label, corrected to
the observed10:04:51. The actual state series has local radii at least1,
yet a vanishing arithmetic-size product and exact rho=0, sigma=tau=6.
The positive F comparison has tail cost8. Neither direct algebraization
criterion applies to Y. For integral K, one centered p-adic meromorphy disk
of radius>1 would force rationality, contradicting K(1/16)=pi; a hypothetical
even half-tail has the same obstruction. Avoidance supplies no continuation.

Frozen packet `/tmp/pi-m4-adelic-size-test-20261128T1003Z/` has report
`a821400fe730f9f9eefd32e2bf2f6b5e399468c83413d07ce59e56d36cda3c61`
and15-entry manifest
`7773bab53a4416de9a4e2f82c5c0a9f08f70cef28cb16f65c5a09136b35b054b`.
Parent read the full report/checker and inspected Bost–Chambert-Loir pages
10,11,13,14,48,49 and Chambert-Loir printed196; the PNT slide3 was reused
with unchanged hash. A byte-identical checker copy in separate scratch
passed796 assertions, receipt5f0328, exit0, with a byte-identical receipt.
All original files remained unchanged. These finite symbolic/synthetic
checks certify neither the source theorems, PNT, infinite limits nor V.

Independent paper review ran10:18:48–10:21:57, before10:27/10:35.
No defects or required improvements. Q1 avoidance-to-continuation and Q2
other specified adelic constructions remain open. Full return in
`/tmp/pi-m4-adelic-integration-20261128T1022Z/` has hash
`6a19a3108faea8816e1aaa382f2a2c59be0ebce32bffc208f390da963d15a3b7`.
It was fully recovered and read after compaction, not inferred from a
truncated tool result. Source proof chains, priority and Lean remain unaudited.

Three-document integration began10:20:42, scope f74ca6, with10:32
reassessment and10:47 endpoint, protecting145 tracked and11 unrelated files.
Exact production review and affected documentation checks gate publication.
No Lean or dependency changes. The meta-plan's fresh-context recovery began
10:22:49, midpoint10:34 and endpoint10:46, testing for a materially changed
actual four-pole argument. Its unreviewed ideas are not adopted here.
C_odd/V/M4 remain open; this negative result does not end the milestone.

Exact production review ran10:32:27–10:34:13, before10:38/10:44. It found
D1, an ambiguous sentence that read as an assertion of no odd carries.
The single replacement to "gives no odd-carry conclusion" was independently
checked against a separately frozen repair; D1 is resolved, with no remaining
or new defects and no required improvements. Q1/Q2 remain open. All251
diff lines,11 frozen entries,18 sources,145 protected and11 unrelated files
matched. Original manifest
`ba9e94f338071dbcb0207a54f96e6ed7c2b1058721b38ca8a6284d1d168c5537`;
diff `7b190efdf4d6d1bde8236ff225d2f7686b2c7689ec0d4405faa9ec313487a6b8`.
Full return in the1022 packet has hash
`8409da79667ab12fc55ec471b6ef03c0711ee35f769ab1d752ee62c36bddbd26`.
Caller c2b129 reverified the frozen/source/protection inventory and exact
repaired owner at10:35:41 before factual completion updates. The10:32
reassessment was the completed integration freeze5c8e9f at10:32:09;
final affected checks and publication remain. No mathematical owner change
follows D1. This integration defect is distinct from the no-defect paper review.

## 2026-11-28 — Stronger counting source, unchanged visitation gap

The arithmetic-size record is published as
`77aae52e12f54edf32960f2588d7d792552f356b`, parent5e09504: commit3b62c2,
post-commit e441bf, push688df3, remote7057bc at10:36:39. Docs827ee4,
whitespace67f1fa/aa8688 and exact stage a72809 passed; publication d908be
retains the evidence. Three owned blobs and145 protected/11 unrelated files
matched; D1 was resolved before commit.

Fresh-context recovery10:23:38–10:38:08, checkpoint10:34:09, endpoint10:46,
found a [stronger counting source with the same failed consumer](m4-generating-functions.md#restricted-elementary-counting-does-not-repair-the-source-fit).
Its contribution is the exact source contract and reciprocal-height check;
the exponential-growth/counting/floor obstructions were already known.
Packet `/tmp/pi-m4-restricted-elementary-test-20261128T1032Z/`, report
`564ccdf7d8be312b79722aa4f301ebb25a92e23ec730654ed9c5cdd9a4f19d5d`,
has20-entry manifest
`44965e7381778874b95e84bfe157822a7f7fbd818a73149c53b9824bd742fb39`.
Parent ab0a9e read the full report; ea0b3f verified all artifacts and the
four primary-page images were inspected. No numerical checker was needed.

Paper review10:39:29–10:42:09 found no defects. I1 implemented by linking
the already assessed recurrence instead of adopting it as new. Q1 applicable
counting/witness construction and Q2 actual odd-carry count remain open.
Full return in `/tmp/pi-m4-counting-integration-20261128T1041Z/` has hash
`8f521620afdc12e1bf2eeba304d95e541663fcaae1ff3f7d8a18b747d4bb2357`.
Three-document integration began10:39:40, scope bee716, midpoint10:49,
endpoint11:00. Exact production review and affected checks remain required.
Separately, the10:37–11:01 recurrence inquiry was narrowed after archive
screening to the even-carry gap and one growing-order residual test; its
results remain unadopted pending review. No Lean change or V/M4 advance.

Production review10:44:43–10:45:21 passed with no defects/new improvements;
I1 closed, Q1/Q2 retained. All112 diff lines,11 packet entries,21 sources,
145 protected and11 unrelated files matched. Manifest
`ef9f08411179175ff5f60e075dd6307b0bb2919ecad84093fd6a0f91898555fe`;
full return in the1041 packet
`090df8781a3923484d33a70e68f6528b384ca98c2711477c7b0008884b380740`.
Parent00c5ad reverified all inventories at10:46:57 before factual updates
only; the mathematical owner is unchanged. Early completion serves the10:49
reassessment. Final affected checks and publication remain.

## 2026-11-28 — Even carries and the cost of growing differences

The counting addendum is published as
`91dcf04cc3ad23d991fbfc1ca0944340361dd37c`, parent77aae52. Commit ccd000,
post-commit987ecf, push d5a486 and remote d73c57 verified publication
at10:49:57. Docs491b07, whitespace ee8ec3/1e4d90 and exact stage9628ca
passed; publication receipt4a0864 retains the evidence. Three owned blobs
and145 protected/11 unrelated files matched.

The [even-stencil inquiry](m4-rational-forcing.md#even-carries-do-not-repair-growing-binomial-differences)
ran10:37:11–10:47:35, ahead of10:49/11:01. Archive screening found the
adjacent recurrence already assessed, narrowing the test to even carries
and one growing binomial-difference family. Root63e2ec then identified
that the universal17/2 barrier also followed the earlier norm lemma.
The author incorporated that overlap before freezing. Added evidence is
the family's exact all-order mass/content and an even exact-A comparison
that loses rational zero initialization; no new general barrier or V advance.

Packet `/tmp/pi-m4-even-adjacent-stencil-20261128T1041Z/` has report
`aa7f96eac19066366cddac2daeda100bf31ae79924ae66e8bc89adf198cb43cb`
and six-entry manifest
`34876bc178ecf4569fe2819c844cd8cde9312785743b8217eac66446cc1e0dc9`.
Parent2aa6d0/99b886 read report/checker and inspected Bell–Chen p.2.
An unchanged checker copy in separate scratch passed886 assertions3e6e06,
exit0;4a0864 verified byte-identical receipts and unchanged originals.
These are unevaluated polynomial identities and synthetic fixtures, not
certification of all orders, actual states, analytic limits or Lean.

Paper review10:50:58–10:55:19 found no defects or required improvements.
Q1 actual correlated error and Q2 selected growing-order nonvanishing remain
open. Full return in `/tmp/pi-m4-stencil-integration-20261128T1053Z/` has
hash `a2ef4f027d475dd8a2a2c068b83af71d6e217195fe57b801aa439ec527464d00`.
The parent proposed an elementary fixed-order argument removing Bell–Chen
as a necessary dependency. The separately frozen supplement completed
10:55:23, report97f5ce768cca54cea5851b6c15f5e87d1622972bd2ef8b141115fbadba440353;
its focused review is separate from the original verdict.

Three-document integration began10:52:03, scope96b849, midpoint11:05,
endpoint11:19. Exact production review and affected checks remain due.
Another fresh discovery cycle is authorized with11:11/11:26 checkpoints;
it must preserve actual initialization and identify a materially different
consumer before substantial development. Its ideas are unadopted. No Lean
change, actual-state census or C_odd/V/M4 acceptance is claimed.

Separate supplement review10:58:29–10:59:05 passed with no D/I. It checks
the Newton identity including d=0, polynomial degree cap, integer convergence
and rational constant-tail contradiction. Q1/Q2 and M4 remain open. Full
return in the1053 packet has hash
`65dae70ed62525dc0128e747d14fd0d96d11bd5def222bf3f1cabdda5f2c277d`;
supplement manifest
`079b1cfb2e26f202d83d795b5fd9040ffe238003fd638713e956df8f5705f9e8`.
Parent66ab20 read the complete supplement; no numerical check was needed.
The elementary proof removes the external finite-alphabet theorem dependency
for fixed-order nonvanishing, without adding an actual-history bound.

Exact production review11:00:50–11:02:23 passed with no D/I; Q1/Q2 and
M4 remain open. All187 diff lines,12 frozen entries,11 sources,145 protected
and11 unrelated files matched. Manifest
`61518e6e668da73beb83a1f526f37c0b6d23743decdddce3c8254518f0497b12`;
full return in the1053 packet
`ff3a846e53a38c49642d647fa808cf2a1cc1c72428bfd4f36e0c1513e0c1c210`.
Parent c43315 reverified all inventories and owned postimages at11:03:59
before factual updates only; the mathematical owner is unchanged. Early
completion serves the11:05 reassessment. Final affected checks/publication
remain; the fresh discovery pass continues independently.

## 2026-11-28 — Discovery reassessment without a new proof step

The even-stencil record is published as
`7e9bf7f21144dd3169fc39d250cf283f36d410c9`, parent91dcf04: commit478d5c,
post-commit cf6292, push ed5a11 and remote cd53c7 at11:05:18.
Docs4b8c39, whitespace84ed04/0a9edc and exact stage95893a passed.
The publication receipt is in the1053 integration packet. Remote checks
at11:14:16,11:23:57 and11:29:50 still matched; no empty commit was needed.

The10:56–11:26 discovery assignment completed early at11:17:28 without a
new mechanism. Parent8fe9b3 read its compact report in
`/tmp/pi-m4-cantor-tail-interface-20261128T1106Z/`, hash
`ae10a7b00dd684758c8497f66300211a7cf3bdbb1000b3023f4c32783a46076f`.
The source-fit calculation remains unadopted; its conclusion was overlap
with the existing [fixed-localization gap](m4-generating-functions.md#fixed-odd-prime-support-limits-a-common-hole-family).
The parent's11:08:20–11:09:35 congruence screen likewise found the proposed
prime-power refinements already in [the lift assessment](m4-prime-square-lift.md).
Neither screen warrants a new mathematical owner section.

Fresh-context recovery11:14:13–11:27:24 ended before its11:29/11:44 bounds.
Raw parity, generating-function divisibility, projective elimination and
sine-zero proposals returned to the archived floor-selection gap; no new
actual-history estimate survived. The complete worker return is retained
in `/tmp/pi-m4-discovery-checkpoint-20261128T1131Z/`.
These are inconclusive discovery outcomes, not new impossibility theorems.
The meta-plan therefore shortens the record and changes the discovery question:
the11:29–11:52 source inquiry, midpoint11:40, asks whether a fixed-number
restricted-digit theorem gives more than ordinary approximation bounds for
logarithms or arguments of algebraic numbers. Source applicability, including
the particular π value, must be proved before adopting an estimate.
No Lean change, actual-state census or C_odd/V/M4 acceptance. Research continues.

Two-record review11:32:07–11:33:01 passed with no D/I; Q1 actual-history
estimate, Q2 source applicability and Q3 milestone obligations remain open.
All56 diff lines,9 frozen entries,4 sources,147 protected and10 untracked
files matched. Manifest
`e5c0296656551d3215cc574b0cb39ab5242771001792720a723311b660197902`;
full return in the1131 packet
`bcab9bdf93ff6c192b7de7edf397e6ef5f7005cb3fb53bc4fc290f478d27b200`.
Parent83c0e7 reverified integrity at11:34:06 before factual completion
updates. This review accepts the recording, not the unadopted calculations.
