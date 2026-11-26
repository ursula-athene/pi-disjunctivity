# Session prompts

Use only the **Current prompt** below when the user asks to start or resume the
next milestone. Everything under **Old prompts - do not use** is historical,
even where an archived prompt contains imperative instructions or a different
policy. A completed milestone must not be repeated or automatically extended.
Saving this prompt does not begin the milestone; invoking it does.

## Current prompt: M4 Universal Visitation

**Restart record (2026-11-26): M4 remains incomplete.** Read
[the M4 handoff](m4-handoff.md) and [argument assessment](m4-visitation-obstruction.md)
before another cycle. The bounded source audit, three avoidance candidates and
two recovery candidates did not supply the BBP-specific exclusion of an infinite
proper limit set. Generic expansion/decay, irrationality, complexity and residue
reformulations must not be repeated as if untested. Continue by investigating
structure those methods did not exploit; discovering a new estimate or source
connection is part of the authorized work, not a prerequisite for restarting.
No unconditional V theorem, V audit or M5 assembly exists from that invocation.

Work in `/Users/adam/personal/proj/pi-disjunctivity/pi-disjunctivity`.

### Authorization and endpoint

Invoking this prompt authorizes the entire **M4 Universal Visitation milestone**
([Step 5, obligation V](proof-plan.md#5-prove-the-missing-universal-visitation-theorem)):
mathematical research, targeted literature/library search, necessary supporting
lemmas, Lean formalization, exports/audits, required reviews, local commits,
post-commit necessity inspection and a durable handoff. Carry useful work
through those internal checkpoints without asking again between authorized
steps. Do not stop after a plan, candidate sketch or intermediate lemma.
Saving this prompt does not invoke it or begin research.

M4 is open research: no complete visitation argument is supplied. Aim to prove
the exact unconditional statement below; do not promise that an argument must
exist within a session. Keep **M4 incomplete** until that statement and its
acceptance checks are complete. A conditional reduction, a tool trial, a
reviewed obstruction or a research handoff alone does not complete M4 and is
not a reason to end an otherwise authorized research effort.

This is known to be a hard unsolved problem. Be persistent in solving it and
do not give up.

Apply the [persistence protocol](meta-proof-plan.md#persistence-and-stopping-conditions):
bound individual investigations, reassess their outcomes, and continue with a
changed question or method. Do not convert an agent-chosen cycle limit into a
limit on the milestone. If no candidate survives, generate new questions and
test them; do not wait for the user to supply a breakthrough or renew permission.
Actual interruptions follow that protocol and leave an honest continuation
record. Persistence never relaxes proof standards or the scope exclusions below.

**Reviewer override (2026-11-26):** the user stopped Carbon and directed use of
Codex subagents for reviews. Follow the
[replacement-review procedure](gemini-review.md#current-user-directed-reviewer-replacement)
where this prompt names Carbon; do not invoke Carbon unless the user changes
that instruction. Review gates and adversarial guides remain required.

B1–B3 and the general B4/P3 lemmas are already checked. Do not repeat them or
the tooling milestone. Final export/assembly of `PiHexadecimalDisjunctivity`
belongs to M5 and is outside this prompt. Keep all new work directed at V;
optional modular-sum machinery is justified only by a specific M4 obligation.
Do not install tools, change dependencies/pins/permissions, contact people,
use new paid services, rewrite Git history, push or open a PR without separate
authorization.

### 1. Verify the checkout and establish the contract

Inspect the actual branch, HEAD, index and working tree first. Preserve unrelated
configuration, Obsidian, retrospective, notes and paper changes. Use a prepared
M4 branch if present; otherwise create an implementation branch from the verified
checkout containing accepted B3 and the current process improvements. Do not
assume `main` has unmerged work or reset to a historical handoff.

Read `AGENTS.md`, relevant sections of the proof plan and blueprint, the meta-plan
(including stuckness and TRIZ), workflow, Gemini procedure, handoff template,
and current B3/process handoffs. Follow links by the question being answered;
read applicable review guides in full. Inspect the actual recurrence, coefficient,
orbit bridge, tail-decay and B4 declarations and their `Test.lean` audits.

From the root containing `lakefile.toml` and `lean-toolchain`, verify Lean
`4.37.0-rc1` (adding `$HOME/.elan/bin` to `PATH` if needed), then establish the
baseline with `lake build`, `lake env lean Test.lean` and `git diff --check`.
Update the proof plan with the bounded research sequence and acceptance boundary
before substantial work; it remains the owner of mathematical contracts.

Prove, for the existing fixed `PiDisjunctivity.bbpRecurrence`, exactly:

```text
∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
  ∀ N : ℕ, ∃ n ≥ N,
    PiDisjunctivity.bbpRecurrence (n + 1) ∈ Set.Ioo a b
```

The existing initialization is `y_0 = 0`, with
`y_(n+1) = Int.fract (16*y_n + bbpCoeff n)`. Recurrence index `n+1` corresponds
to hexadecimal orbit index `n`; `N` bounds that orbit index. Keep every real
interval and every natural threshold, including `a = 0`, `b = 1`, and `N = 0`.
Do not replace the fixed sequence by a generic sequence assumed to visit, prove
only one visit, or restrict the interval/threshold quantifiers. The theorem
must have no unproved visitation, density, normality, dichotomy or other premise.

### 2. Find and challenge the mathematical argument

Work backward from V and record the first unsupported implication. Start by
assessing the proof plan's two proposed mechanisms: exclude permanent avoidance
of an interval, or establish the needed dichotomy for this particular recurrence.
Neither is an available theorem merely because it appears in the plan. A better
in-scope route is allowed when evidence supports revising the plan.

For a candidate, write its exact claims, dependencies, sources and genuinely new
π/BBP-specific input. Check source theorems in their original context and map all
side conditions to the intended application. Search the pinned library before
building supporting theory. Separate generation, criticism and revision; use
`pi-argument-critic` for scoped criticism and `paper-to-lean-contract` when an
assessed source theorem needs extraction. Read each skill's instructions when
applying it. Skills and reviewer agreement are not proof certificates.

Challenge candidates with model problems and counterexamples. Irrationality,
transcendence, almost-everywhere results, finite digit searches, BBP extraction
and vanishing error do not by themselves establish V. A finite missed interval
does not disprove arbitrarily late visitation either. Do not assume Hypothesis A,
a density dichotomy, Hπ or the final conjecture and report V as unconditional.
Keep speculative claims in Markdown, not Lean axioms or placeholder proofs.

Before substantial downstream formalization, obtain Carbon criticism of the
central argument and its proposed interfaces. Resolve its first unsupported
step or retain it explicitly as open; compiling peripheral lemmas cannot close
that gap. Read-only Carbon reviews of mathematical sketches use both adversarial
guides under the Gemini procedure; the caller performs any requested checks.

### 3. Monitor progress and recover from stuckness

Use the [meta-plan](meta-proof-plan.md#recognizing-stuckness) throughout, not only
at the end. State a finite effort bound and evidence sought for each research
cycle and its recovery work. At checkpoints, answer with evidence: **What did we
learn? What changed? What could the next attempt resolve?** Different attempts
reaching the same unsupported implication, cosmetic reformulations, or inability
to name a useful next test are warning signs. Useful negative results and a
sharper obstruction count as learning; slow progress alone is not stuckness.

If understanding stops changing and no justified next step emerges, activate
the recovery protocol: simplify/generalize, change representation, work backward,
look for counterexamples, seek precise neighbouring-theorem connections, or use
TRIZ to examine conflicting requirements and available resources. Turn promising
ideas into explicit claims and small discriminating checks. Record failures so
fresh contexts and workers do not repeat them. Distinguish mathematical gaps
from library, compiler and environment failures.

At each bound, record the exact obstruction, attempts and strongest checked
result, then choose the next in-scope investigation. If recovery produces no
candidate, change the discovery question: inspect unused BBP structure, a
countermodel's missing hypothesis, or a neighbouring method's failed bridge.
Explain what the next check could teach without pretending it is likely to
succeed. Suspend exhausted routes and avoid unchanged retries, but continue
the milestone under the persistence protocol. Do not weaken V or label the
milestone complete. A documented failure informs the next cycle; it is not a
substitute for doing it.

This invocation permits bounded subagent work when useful for M4 searches,
alternative arguments, source connections, proof candidates and diagnosis.
Give workers distinct questions, ownership and effort bounds. TRIZ ideation
workers return exact candidates, used structure, counterexample checks and the
first unproved bridge; the parent filters proposals before Carbon criticism.
Proof workers deliver immutable scratch paths, declaration names/types, exact
verification receipts and an explicit completion signal. The parent owns
production edits and checks integration. Use the installed tools/skills within
the workflow's compatibility rules, with native feedback for project files and
shell Lean for `/tmp` probes; retain the working fallback.

### 4. Formalize, audit and review the complete result

Once an argument survives criticism, implement only needed supporting lemmas
and the unconditional V theorem, using a suitable BBP module. Probe definitions
and full downstream interfaces through `import PiDisjunctivity` early. Use the
adapted `lean-search-discovery` and `lean-proof-patterns` skills when relevant,
explicit types and targeted normalization, and real compiler feedback.

Preserve Mathlib as the only direct external Lean library, Lean/Mathlib
`v4.37.0-rc1`, existing conventions and Ursula Athene attribution. Add no `sorry`,
`admit`, project-specific axioms, `native_decide` bypasses or unsafe shortcuts,
including in scratch work. Only `propext`, `Classical.choice` and `Quot.sound`
may occur as axiom dependencies. The completed V theorem must have no extra
unproved premises beyond the displayed interval bounds and natural threshold.

Export V through the library root. Add its complete type and actual guarded
axiom list to `Test.lean`, preserving existing audits. Boundary tests must
instantiate the theorem. Check that the proved V supplies B4's late-visit input
at `fun n => bbpRecurrence (n+1)`, with B3 decay and B2's orbit offset, using
the existing interface audit as a model. This acceptance check is in scope;
the public M5 final-conjecture theorem is not.

Run `lake build`, `lake env lean Test.lean`, the offline process tests and
documentation checker specified in the workflow, and working/staged whitespace
checks. Inspect actual exits, imports, theorem statements, pins and protected
definitions. Obtain required intermediate reviews when building on substantial
or uncertain proof blocks and a complete task-owned-diff Carbon High review
before the milestone commit. Retain exact scope, applicable guides, read-only
file tools, separate logs, complete captures, D/I/Q dispositions and bounded
recovery. Ask Carbon for periodic updates at meaningful inspection boundaries
and before long analysis; poll the same live handle and never infer a hang from
silence alone. A prior request to self-review documentation preparation does
not waive these M4 reviews. Stop acceptance on any required failure or incomplete
review; substantive fixes need focused follow-up and affected checks.

### 5. Accept M4 or preserve an interrupted continuation

Mark V/M4 complete only after the exact unconditional theorem, its dependencies,
integration checks and reviews pass. Keep Hπ/T/final-conjecture export status
honest: the remaining M5 assembly is not automatically executed here. While an
obstruction remains, keep V/M4 open and retain every unproved premise. Reserve
an external-blocker report for the persistence protocol's actual stop conditions;
missing mathematics alone calls for continued discovery.

Update the proof plan, blueprint and research log to the actual result. Save
a dated M4 retrospective under `docs/retrospectives/` and a concise M4 handoff
using the template. Record arguments tried, failures, remaining obligations,
review dispositions, validation and the next justified decision. Keep any
`PROGRESS.md` to evidence pointers; after compaction read those records and the
actual target before continuing. On incomplete work, keep the current entry
pointing to the precise M4 continuation question; on acceptance, archive this prompt
and record the stopping boundary without automatically starting M5.

Commit only task-owned, validated and reviewed work locally, including any
clearly labelled partial results at useful checkpoints. Such a commit or handoff
does not end the ongoing research. At an actual interruption that prevents
review/validation, preserve uncommitted continuation notes under the
[workflow's memory rules](proof-workflow.md#records-and-project-memory), report
their unreviewed state, and resume checks before committing. Do not stop research
early merely to finalize a partial handoff. Run Git mutations as standalone
execution calls. Inspect the committed result for necessity and duplication;
validate/review substantive simplifications before a further commit, without
creating an empty follow-up. Report exact completed results, all remaining
hypotheses, review/check limitations, commit IDs and publication state. Print
the handoff in terminal-readable form at acceptance or an actual interruption.
Stop at accepted M4 before M5 or unrelated work; otherwise continue M4 whenever
the persistence protocol permits work.

## Old prompts - do not use

<a id="current-prompt-b3-stopping-point"></a>

### Session prompt: B3 stopping point

B3 is accepted: its coefficient bound, explicit tail bound and decay are
kernel-checked, reviewed and pushed. [The B3 handoff](b3-handoff.md) records
acceptance, necessity and publication evidence. Stop here; there is no pending
B3 mathematical or review work. Do not repeat B1/B2/B3 or the tooling milestone.
No visitation research, modular computation, final conjecture assembly or
new milestone is authorized. V, Hπ, T and π disjunctivity remain open; B4 needs
arbitrarily late visits, and P3 needs open-interval visits.

<a id="current-prompt-b3-tail-control"></a>

### Session prompt: B3 tail control

Work in `/Users/adam/personal/proj/pi-disjunctivity/pi-disjunctivity`.

Invoking this prompt authorizes the complete **B3 tail-control milestone** in
[the proof plan](proof-plan.md#next-bounded-task-b3-tail-control), through
implementation, audits, required reviews, validation, commits, post-commit
necessity review, and a durable handoff. Saving this prompt does not start B3.
Complete its internal steps without asking for fresh authorization between them.
Do not execute an archived prompt or repeat completed B1, B2, or the B2 process
and tool improvement milestone.

### 1. Verify the baseline and state the endpoint

Read `AGENTS.md`, the B3 contract and Step 4 in `docs/proof-plan.md`,
`docs/proof-blueprint.md`, `docs/b2-handoff.md`, `docs/proof-workflow.md`,
`docs/meta-proof-plan.md`, `docs/gemini-review.md`, and `docs/handoff-template.md`.
Read the installation follow-up in `docs/b2-improvements-handoff.md`,
`docs/b2-tool-evaluation.md`, and `docs/agy-reports/b2-improvements-review.md`,
plus `docs/b2-tool-installation.md` for tool use, fallback and rollback.
Inspect the relevant checked Lean declarations and recent research-log entries.

Verify the actual branch, HEAD, index, working tree, remotes, and host capabilities.
Use a user-prepared B3 branch if present; otherwise create an implementation
branch from a verified baseline containing completed B2, the accepted tooling
work, and this prompt. Do not assume `main` contains unmerged branch work.
Preserve all unrelated staged, modified and untracked work, including Obsidian,
notes and papers; use a separate worktree only if needed. Keep user configuration
and other branches intact. Git mutations must be standalone execution-tool calls.

Before implementation, record the bounded sequence and acceptance criteria in
the proof plan; the meta-plan owns only process decisions and observations.
B3 must deliver, for every natural `j` and `n`, with real division:

```text
|bbpCoeff j| ≤ 8 / (8 * (j : ℝ) + 1)
|bbpTail n| ≤ 8 / (15 * (8 * (n : ℝ) + 9))
Filter.Tendsto bbpTail Filter.atTop (nhds 0)
```

Verify these proposed constants and all side conditions before building on
them. The results must be unconditional: no unproved analytic, summability,
tail-decay or visitation premise. If a proposed bound fails, report the exact
mathematical obstruction; do not silently weaken the contract or mark B3 complete.

### 2. Use the installed tools and skills in the proof loop

The B2 tooling milestone is complete. LSP 0.33.0 and the four selected skills
are installed. The user ran the maintained migration successfully; receipt
`/Users/adam/.local/share/pi-b2-activation/run-9ci32pt6` records reuse of the
packages/skills, a passing five-tool protocol test and migration to the installed
Python with `-m lean_lsp_mcp`. The configuration was checked against that receipt.
Earlier pending-migration prose predates this result; do not reinstall or repeat
the tooling milestone. Native tools worked before migration; verify availability
and the configured project root in the actual new session rather than assuming
that configuration or a terminal test proves app activation.

Discover and exercise the five native `pi-b2-lean-lsp` tools against existing
Lean or a disposable root-import probe, then use them throughout B3:

- `lean_local_search`: find candidate Mathlib declarations, including generated
  declarations; inspect index state and allow bounded warmup. An empty or warming
  result is not proof of theorem nonexistence. Use `rg` and source inspection too.
- `lean_hover_info` and `lean_declaration_file`: inspect full signatures,
  hypotheses, casts, indexing and source before applying a candidate.
- `lean_goal`: inspect the actual local context and before/after tactic goals.
- `lean_diagnostic_messages`: check elaboration after edits; partial results
  require follow-up, and a cleared diagnostic is not the final kernel audit.

Read and apply the installed **adapted** `lean-search-discovery` and
`lean-proof-patterns` skills for discovery and proof construction. Apply
`pi-argument-critic` to the proposed B3 estimate/limit argument before relying
on it, preserving every premise; this is a same-session criticism pass, not
independent review. Use `paper-to-lean-contract` only if an already assessed
source claim actually needs extraction. Do not force a new literature campaign
or repeat the deferred source-transfer experiment merely to exercise that skill.
Repository rules and the adaptations override conflicting upstream examples.

Keep the five-tool selection unchanged and the REPL disabled; do not enable remote search,
install additional skills/libraries, or change pins or permissions. If native
tools are unavailable, use the documented shell/source-search and `lake env lean`
fallback, record the exact activation step, and continue independent B3 work.
Pending descendant-shutdown and app disable/restore checks remain tool limits,
not prerequisites for the mathematical proof or permission to expand this task.
Record a few concrete B3 tool successes/failures and practical costs in existing
records; do not claim general productivity gains or start a benchmark project.

### 3. Prove the estimates and decay with explicit interfaces

Reuse B2's `hasSum_bbpTail` for the existing definition
`bbpTail n = ∑' r : ℕ, bbpCoeff (n+r+1) / (16 : ℝ)^(r+1)`.
Preserve the tail's first coefficient `n+1` and first denominator `16`, and the
orbit/recurrence offset `n` versus `n+1`. A total `tsum` definition alone is not
convergence evidence. Retain B1/B2 definitions, contracts, proofs and audits;
extend the library with only the lemmas needed for B3 and its checked consumers.

Establish the coefficient estimate, a summable geometric majorant for the tail,
the explicit tail estimate, and convergence to zero. Prove denominator positivity,
cast/index facts and summability needed for norm/absolute-value sum bounds.
Choose the simplest pinned-Mathlib route; inspect its actual types before use.
Keep helpers private unless a proof or audit consumer needs an exported result.
Avoid unrelated refactors, optional modular computation and performance tuning.

Probe new public theorem interfaces through `import PiDisjunctivity` early,
before composing dependent layers. Extend `Test.lean` with complete theorem-type
checks, actual axiom guards, and boundary checks that explicitly instantiate
the coefficient and tail theorems at zero (and other useful first-index cases).
Check that the decay result fits B4's vanishing-error input while keeping its
arbitrarily-late-visitation premise explicit; do not start final conjecture assembly.

Preserve Lean/Mathlib `v4.37.0-rc1`, Mathlib as the only direct external Lean
library, existing module/public-section conventions, MIT headers, Ursula Athene
attribution and enabled linters. No project-specific axioms, `sorry`, `admit`,
`native_decide`, unsafe proof shortcuts, new library imports/dependencies outside
the permitted stack, or direct imports of Mathlib's transitive packages.
Allowed axiom dependencies remain only `propext`, `Classical.choice`, `Quot.sound`.

### 4. Review, validate and finish the whole milestone

Follow the normal B3 review requirements in `docs/proof-plan.md` and
`docs/gemini-review.md`: useful intermediate checkpoints, complete task-owned
Carbon High review before the milestone commit, and focused review of substantive
fixes. The user's stop on further Carbon reviews applied to the completed B2
improvement milestone; it is not a standing B3 waiver. Supply the Lean adversarial
guide; also supply the strategy/tooling guide if substantive strategy/tooling
changes enter the authorized diff. Keep review scope concise, exact and read-only;
use the approved literal command prefix, separate `--log-file`, complete capture
and result/log inspection, progress updates and bounded recovery.
Preserve every defect, improvement and question's disposition. Carry forward
Q2's lightweight cost/usefulness observations from actual required reviews only.

Run `lake build`, `lake env lean Test.lean`, offline process tests,
`tools/check_docs.py`, and working/staged `git diff --check`; inspect exit codes.
Use `uv --no-cache run --locked --offline` for the Python checks when appropriate.
Check new/staged files, protected pins/dependencies and unrelated-work preservation.
Reconcile README, proof plan, blueprint and the active prompt semantically,
not merely by passing the link checker. Do not finalize with a failed required
check, incomplete required review or unresolved acceptance-blocking finding.

Update the existing proof plan, blueprint and research log to checked facts.
Write `docs/b3-handoff.md` using the handoff template and a dated B3 retrospective
under `docs/retrospectives/`; link the review evidence rather than duplicating logs.
Commit only task-owned files, perform post-commit proof-necessity review, and
validate/review any substantive follow-up change. Do not manufacture an empty
second commit. Push the completed B3 branch and verify the remote commit; do not
open a PR. Report exact results, remaining hypotheses, tool limitations and
local/pushed state, with a short whole-review-cycle summary.

Stop at accepted B3. It supplies vanishing error, not visits: V, Hπ, T and π
disjunctivity remain open. B4 retains its arbitrarily-late-visit premise and P3
its open-interval-visitation premise. Do not begin visitation research, modular
computation, final conjecture assembly or another milestone automatically.

### 5. Context management and use of subagents

We are trying to conserve parent (supervisor, you) context to enable us to run a long
time unattended. 

So for long-running proof tasks, use subagents for Mathlib searches, independent
proof attempts, and diagnosis of verbose build failures. Give each worker the
exact question and relevant files. Ask it to return the result, verification
command, and any precise obstruction. Keep parallel edits in separate scratch
files or worktrees.

The parent (supervisor, you) owns the target theorem and verifies candidate proofs \
in the project. At each verified milestone or decisive failure, update PROGRESS.md with the
current obligation, evidence, and next step. After context compaction, read
PROGRESS.md and the target declaration before continuing.



<a id="current-prompt-b2-improvement-plan"></a>

### Session prompt: B2 improvement plan

**Archived after completion:** the improvement milestone and installation follow-up
are complete with the recorded review boundary and remaining tool limits. See
[the handoff](b2-improvements-handoff.md). The original execution prompt follows;
it grants no new scope.


Work in `/Users/adam/personal/proj/pi-disjunctivity/pi-disjunctivity`.

When the user invokes this prompt, implement and evaluate
[the B2 process and tool improvement plan](b2-process-tool-improvement-plan.md)
through P0–P5, including required intermediate reviews and final acceptance.
That document is the sole implementation specification; do not combine its
scope with the superseded prompt below.

**Complete the improvement milestone before going on to B3. B2 proof
development is out of scope.** B2 is already complete and is used only as
fixed test material. Do not solve B2 again, change production Lean or audits,
begin B3, or start visitation research. Saving or reviewing this prompt does
not invoke it. Execution was subsequently authorized; the
[implementation handoff](b2-improvements-handoff.md) records actual acceptance
and pending activation. Do not repeat completed steps.

Read `AGENTS.md`, the replacement plan, `docs/proof-workflow.md`,
`docs/meta-proof-plan.md`, the B2 retrospective, `docs/gemini-review.md`,
and `docs/handoff-template.md`. Verify the actual checkout and host state;
preserve unrelated work and existing configuration.

When invoked, this scope includes the plan's necessary isolated user-scoped
LSP installation, supported minimal MCP configuration, selective installation
of compatible search/proof skills, and bounded original-skill evaluations,
subject to host permissions. It does not include the unmodified elaboration
skill, optional remote-search activation, Sage installation, or broader
frameworks. Keep the REPL disabled and both Lean/Mathlib pins unchanged.

Distinguish installation, configuration, protocol testing, and actual host
availability. Complete independent work if activation is pending, and leave
an exact continuation step. Do not report adoption or acceptance that has
not passed its required checks and reviews.

Commit only reviewed task-owned files; perform post-commit necessity review
and record the actual local publication state. Do not push or open a PR unless
the executing user separately requests it. Stop at the improvement milestone's
acceptance boundary; B3 requires a later explicit instruction.



<a id="current-prompt-b2-workflow-and-lean-tooling"></a>

**Superseded on 2026-11-25:** the replacement
[B2 process and tool improvement plan](b2-process-tool-improvement-plan.md)
and current prompt above replace this proposal. The original text below is
historical: its installation list and push instructions grant no current scope.
Do not execute it or merge its requirements into the replacement plan.

### Superseded prompt: B2 workflow and Lean tooling

Work in `/Users/adam/personal/proj/pi-disjunctivity/pi-disjunctivity`.

Implement the process and tooling improvements proposed in
[the B2 retrospective](retrospectives/retrospective-2026-11-25-b2.md).

This is a bounded workflow/tooling milestone. Do not begin B3, visitation
research, or new mathematical proofs. Do not execute another saved prompt.

Read first:

- `AGENTS.md`
- `docs/proof-attempt-session-prompt.md`
- `docs/retrospectives/retrospective-2026-11-25-b2.md`
- `docs/proof-workflow.md`
- `docs/meta-proof-plan.md`
- `docs/gemini-review.md`
- `docs/handoff-template.md`
- The relevant review requirements in `docs/proof-plan.md`

#### 1. Establish a safe baseline

Inspect the actual branch, index, working tree, remotes, and applicable host
rules. Preserve all existing branches and unrelated staged, modified, and
untracked work.

Create a new implementation branch from a verified baseline containing B2
and retrospective commit `07304f8`. Use updated main if it contains that work;
otherwise use the appropriate B2 branch. Use a separate worktree if needed.

Record the bounded plan and acceptance criteria in the meta-plan before
implementation. Preserve historical retrospectives and handoffs as snapshots.

#### 2. Implement the workflow improvements

Make small, concrete updates to the authoritative workflow documents:

- Inspect exact Lean signatures and root-import visibility before composing
  dependent proofs; make natural-index equalities explicit.
- Add a focused semantic status pass before review, covering the active
  overview, proof plan, blueprint, and current prompt.
- Prefer bounded source reads and less frequent review polling, consistent
  with the mandatory progress and timeout procedure.
- Make review inputs self-contained: exact diff, baseline, contracts,
  relevant API locations, and prior findings.
- Keep detailed evidence in its authoritative record and link to it elsewhere.

Do not create a semantic documentation checker, duplicate status ledger,
new approval framework, dependency graph, or multi-agent orchestration.
Preserve the mathematical roadmap and all outstanding hypotheses.

#### 3. Install and configure the recommended tools

Local clones are available at:

- `/Users/adam/personal/proj/pi-disjunctivity/lean-lsp-mcp`
- `/Users/adam/personal/proj/pi-disjunctivity/LeanAutoformalizationSkills`

Inspect their instructions, revisions, working trees, licenses, and installers.
Use the revisions assessed in the retrospective as the starting point;
verify and explain any different revision selected. Preserve clone contents
and unrelated existing installations.

I authorize the necessary user-scoped package and skill installations and
minimal supported MCP configuration changes, subject to host permissions.
Prefer existing package managers and isolated environments.

Install lean-lsp-mcp from a verified local source snapshot or a pinned package
version, preferably using uv. Keep it outside this project's Lean dependencies
and Python dependency lock. Avoid an editable installation unless there is a
concrete reason for one. Record the source revision, installed version,
resolved environment, launch command, and removal instructions.

Configure it for the actual Codex host in use, preferably with local stdio.
Inspect the host's supported configuration rather than assuming a CLI config
change makes tools available in the current session. Preserve existing MCP
entries and keep machine-specific configuration out of portable repository
files.

Keep `LEAN_REPL` disabled. Do not add leanprover-community/repl or any other
external Lean library. Initially expose only the local capabilities needed
for the pilot; leave optional remote search services and automatic source
rewriting out of scope.

Install these complete skill folders, including their supporting resources:

- `lean-search-discovery`
- `lean-proof-patterns`
- `lean-elaboration`

Reserve lean-elaboration for measured performance problems. Install only
these selected skills: the clone's bundled installer may install the entire
collection. Use a supported selective installation method or links to the
complete folders in the preserved clone. Preserve attribution and license
notices; do not relabel third-party material as project-authored code.
Inspect conflicts before replacing anything.

Repository instructions prevail over skill guidance. Do not adopt the
collection's frozen-manifest, draft-sorry, or orchestration workflows.

#### 4. Validate with completed B2

Keep Lean and Mathlib pinned at `v4.37.0-rc1`. Demonstrate the installed LSP
against this exact checkout:

- Find `hasSum_nat_add_iff'`, including its generated-declaration search path.
- Inspect actual signatures such as `pow_sub₀`.
- Retrieve useful proof goals, declaration information, and diagnostics
  from the completed B2 code or disposable probes.

Use no `sorry`, `admit`, additional axioms, `native_decide`, or proof bypasses.
Preserve production Lean declarations and audits.

Record a small comparison with the existing shell workflow: successful
results, failures, startup versus warm behavior, and practical effort.
Do not claim a general performance improvement from a few probes.

Distinguish installation, configuration, protocol-level testing, and actual
host tool availability. If activation requires a restart or new session,
complete independent work and leave an exact continuation step; do not claim
that untested integration passed.

#### 5. Complete acceptance and publication

Run the required documentation/process tests, documentation checker, and
whitespace checks. Run `lake build` and `lake env lean Test.lean` to verify the
pilot against the preserved project. Add tests only for meaningful new
behavior if scripts are changed.

Perform the required Gemini Carbon High review of the complete task-owned
milestone diff using `docs/gemini-review.md`. Address findings and rerun affected
checks. Preserve exact scope, read-only reviewer tools, capture inspection,
and bounded recovery.

Commit only task-owned repository files, push reviewed commits regularly,
perform post-commit necessity review, and leave a concise durable handoff.
Record adopted changes, installation evidence, limitations, outstanding
activation steps, and publication state.

Proceed through these internal steps without fresh authorization. Respect
host restrictions; if genuinely blocked, state the exact failed action and
required user step while completing independent authorized work.

Do not open a PR. Stop before B3 or visitation research.

<a id="current-prompt-paused-after-b2"></a>

### Session instructions: paused after B2

B2's convergent split, recurrence/range, and exact π-orbit identity are checked.
Read [the B2 handoff](b2-handoff.md) for final review, commit, publication, and
necessity-review acceptance. Do not repeat B1/B2 or automatically start B3.

The next proposed bounded task is [B3 tail control](proof-plan.md#next-bounded-task-b3-tail-control),
requiring separate authorization. B3, V, Hπ, T, and π disjunctivity remain open.
B4 still assumes vanishing error and arbitrarily late visits; P3 still assumes
open-interval visits. B2 alone does not complete M3/Step 4 or prove visitation.

<a id="current-prompt-b2-complete-orbit-bridge"></a>

### Session prompt: B2 complete orbit bridge

**Implementation record (2026-11-25):** all mathematical obligations are checked;
see [the B2 handoff](b2-handoff.md) for final review, commit, and necessity status.
The user superseded pre-merge branch instructions and authorized regular pushes,
with no PR. The original prompt below is historical and grants no new scope.

Resume work in `/Users/adam/personal/proj/pi-disjunctivity/pi-disjunctivity`
on `feature/attempt-05-b2`.

Read `AGENTS.md` and [the B1 handoff](b1-handoff.md) first, then the relevant [proof plan](proof-plan.md#4-connect-bbp-arithmetic-to-the-actual-hexadecimal-orbit),
[blueprint](proof-blueprint.md#remaining-bbp-route), [meta-plan](meta-proof-plan.md),
[research log](research-log.md), [workflow](proof-workflow.md), and
[process handoff](process-improvements-handoff.md). Ignore **Old prompts - do not use**.

Invoking this prompt authorizes **all of B2**, step by step, as one bounded
milestone. Saving it does not start implementation. This replaces the earlier
B2a-only proposed stopping point: finish the split, recurrence/range proofs,
and actual orbit identity without asking for fresh authorization between these
steps. B3 tail estimates and Step 5 visitation research remain outside scope.

### 1. Inspect the checkout, announce the endpoint, and update the proof plan.

PR #4 is merged. At prompt preparation, `main` was fast-forwarded to
`53ae688f3c56becdb3ca562d75e6eb3c95fe9dd7`, and
`feature/attempt-05-b2` was created from it. Verify the actual local/remote
state; do not recreate the prepared branch or discard this prompt. Preserve
unrelated staged, modified, and untracked work, including Obsidian, notes,
and papers. Check effective permissions without changing permission settings.

B1 is complete and unconditional; B4/P3 are checked conditional results.
Read the actual declarations in `PiDisjunctivity/BBP/Series.lean`,
`PiDisjunctivity/OrbitCriteria.lean`, the library root, and `Test.lean`. Preserve the existing
BBP coefficient, all B1 proofs/exports, original problem definitions, and
all 27 existing theorem audits and other checks. Do not repeat B1.

Before editing, state the endpoint: a kernel-checked B2 bridge relating the
BBP recurrence and convergent tail to `Int.fract ((16 : ℝ)^n * Real.pi)`,
with definitions, root exports, full type/axiom audits, validation, required
Gemini review, local commit and necessity review, and a durable B2 handoff.

Then update the `docs/proof-plan.md` with the following steps.

After doing so, execute the following steps.

### 2. Establish the minimal definitions and B2a series split

Use a focused project module, preferably `PiDisjunctivity/BBP/Orbit.lean`,
depending only on existing project modules and the permitted Mathlib stack.
Choose consistent names such as `bbpPartialSum`, `bbpTail`, and
`bbpRecurrence`. The following mathematical notation specifies their values;
it is not an instruction to add duplicate definitions:

```text
A(j) = bbpCoeff j
S(n) = ∑ j ∈ Finset.range (n+1), (16 : ℝ)^(n-j) * A(j)
R(n) = ∑' r : ℕ, A(n+r+1) / (16 : ℝ)^(r+1)
y(0) = 0
y(n+1) = Int.fract (16 * y(n) + A(n))
```

All indices are natural and values/divisions are real. Define the recurrence
recursively with exactly this initialization and coefficient index; do not
define it directly as the fractional part of the finite sum. Expose the
definitions/equations through the root as needed by existing module conventions.

First use `hasSum_bbpCoeff` to prove, for every `n : ℕ`, the exact B2a claim:

```lean
HasSum (fun r : ℕ => bbpCoeff (n + r + 1) / (16 : ℝ) ^ (r + 1))
  ((16 : ℝ) ^ n * Real.pi -
    ∑ j ∈ Finset.range (n + 1), (16 : ℝ) ^ (n - j) * bbpCoeff j)
```

Search the local pinned Mathlib sources and inspect actual finite-prefix
splitting and scaling signatures. Split at `n+1`, scale the original series
by `(16 : ℝ)^n`, and normalize the prefix and tail coefficients. Use
`j ≤ n` from prefix membership before manipulating natural subtraction.
Keep convergence in `HasSum`; do not replace this endpoint with a `tsum`
equality alone or assume summability.

Use this checked convergence to identify the defined `R(n)` with the tail
sum and prove, unconditionally for every `n`:

```text
(16 : ℝ)^n * Real.pi = S(n) + R(n)
```

A `tsum` definition is total in Lean, so its definition alone supplies no
convergence evidence. Retain an exported `HasSum` theorem connecting the
specified tail terms to their value. No separate tail-bound layer is needed.

### 3. Prove the recurrence, range, and finite-sum identity

Prove the finite-prefix recurrence needed for induction:

```text
S(0) = A(0)
S(n+1) = 16 * S(n) + A(n+1)
```

Keep helper facts local unless a concrete proof or audit consumer needs them.
For the recursively defined `y`, establish its initial/step equations,
`0 ≤ y(n)` and `y(n) < 1` for every `n`, and the universal identity:

```text
y(n+1) = Int.fract (S(n))
```

Use induction and the pinned integer/fractional-part arithmetic APIs.
Multiplication by the integer 16 preserves equality modulo integers; justify
that fact explicitly rather than treating fractional part as a linear map.
Check the difference between the recurrence coefficient `A(n)` at step
`y(n+1)` and the finite-sum coefficient `A(n+1)` at step `S(n+1)`.

### 4. Assemble the exact π-orbit bridge

Combine the scaled series split and recurrence identity to prove exactly,
for every `n : ℕ`, with no convergence, density, or visitation hypotheses:

```text
Int.fract ((16 : ℝ)^n * Real.pi)
  = Int.fract (y(n+1) + R(n))
```

The recurrence index is `n+1` and the actual hexadecimal orbit index is `n`.
Keep `Real.pi`, the established BBP coefficients, and the original orbit
convention. The endpoint is an exact identity, not a numerical approximation.

Review `n = 0`, the inclusive prefix `0..n`, the tail starting at `n+1`,
`y(0)=0`, and the first recurrence step explicitly. Add meaningful root-import
definition/equation or boundary checks where they catch indexing mistakes.
Do not assume a global inequality
`|Int.fract u - Int.fract v| ≤ |u-v|`; it is false across an integer.

### 5. Validate and obtain the required review

Follow [AGENTS.md](../AGENTS.md), the [implementation sequence](proof-workflow.md#minimal-working-feedback-loop),
and the mandatory [Gemini procedure](gemini-review.md). Establish the pinned
baseline and probe root-import definitions/equations and full downstream theorem
interfaces early. Compile the dependency chain incrementally, export through
`PiDisjunctivity.lean`, and preserve every prior audit/check. For each reviewed
theorem, inspect the actual `#print axioms` output and add full quantified type
checks and guards in `Test.lean`. Boundary checks must instantiate the intended
theorem, including the indices and convergence checks in steps 2–4 above.

Run `lake build`, `lake env lean Test.lean`, the offline documentation/utility
checks, and working-tree/staged whitespace checks as specified in the workflow.
Review definitions, indices, hypotheses, and mathematical meaning separately.
Inspect imports, pins, manifest, and preservation of existing statements.
Distinguish compiler/library/environment failures from missing mathematics;
record exact obstructions without weakening the endpoint. Stop finalization
if any required check fails or review is incomplete.

Obtain Carbon High review of the exact task-owned diff and baseline before the
milestone commit, plus intermediate review where uncertainty warrants it and
focused follow-up for substantive fixes. Use [evidence utilities](process-tools.md)
for scope and capture checks; follow the mandatory procedure for literal `agy`
invocation, read-only tools, adequate capture budgets, terminal-result inspection,
explicit conversation IDs, and bounded recovery. Evaluate findings and coverage
independently; tool success and no-findings text are not proof of correctness.

### 6. Finalize the complete B2 milestone and stop

Update records according to the [responsibility split](proof-workflow.md#records-and-project-memory):
proof-plan contracts, blueprint declarations/status/hypotheses, concise log and
current session instructions, meta-plan lessons where supported by evidence,
and a new `docs/b2-handoff.md` using the [handoff template](handoff-template.md).
Link orientation summaries to those records rather than duplicate audit counts.
Mark B2 complete only when all the split,
convergence, recurrence/range, and exact orbit-identity obligations above are
proved, exported, audited, and reviewed. Partial work must be recorded as partial.

After validation and review, commit only task-owned changes locally. Perform
the proof plan's post-commit necessity review, removing or simplifying genuinely
unneeded pieces; validate/review substantive changes and commit actual follow-up
work without an empty commit. Leave a concise durable handoff of theorem
contracts, dependencies, checks, reviewer findings/limitations, and commit IDs.

Stop before B3 coefficient/tail estimates or `R(n) → 0`, optional modular
digit-extraction/computation support, V/Step 5 visitation research, or final
conjecture assembly. B2 is only part of M3/Step 4; completing it does not complete
all of M3. B3, V, Hπ, T, and π disjunctivity remain open. B4 still assumes
vanishing error and arbitrarily late visits; P3 still assumes open-interval
visits. This bridge discharges none of those remaining hypotheses.

Report the exact results, validation, review status/limitations, local commit
IDs, and handoff path. Propose B3 as the next bounded task without starting it.
Do not push or open a PR unless separately requested; use `gh pr create` when
PR creation is authorized. Pause at the B2 endpoint.



<a id="current-prompt-paused-after-b1"></a>

### Session instructions: paused after B1

The full B1 `HasSum (fun j : ℕ => bbpCoeff j / (16 : ℝ)^j) Real.pi` theorem
is checked. Read [the B1 handoff](b1-handoff.md) for the actual validation,
required review, local commit, and necessity-review status. Do not repeat
completed B1 work or automatically advance to Step 4.

The user explicitly extended the prior B1d proposal to completing B1 in one
combined cycle. That scope reused the checked B1c bridge and included rational
decomposition, the primitive derivative, FTC/integral evaluation, and final
series assembly. The earlier pause-after-B1c restrictions no longer governed
that authorized completion; archived prompts remain historical.

The next smallest proposed task is
[B2a finite-prefix and tail split](proof-plan.md#next-bounded-task-b2a-finite-prefix-and-tail-split),
requiring separate authorization. B2/B3, V, Hπ, T, and π disjunctivity remain
open. B4 assumes vanishing errors and arbitrarily late visits; P3 assumes
open-interval visits. No Step 4 BBP bridge or Step 5 work has begun.


<a id="current-prompt-b1c-sumintegral-interchange"></a>

### Session prompt: B1c sum/integral interchange

**Implementation record (2026-11-25):** the exact unconditional bridge is checked.
See [the handoff](b1c-handoff.md) for finalization evidence. The prompt below is
preserved as historical scope and grants no new authorization.


Resume work in `/Users/adam/personal/proj/pi-disjunctivity/pi-disjunctivity`.

Read `AGENTS.md` and `docs/b1b-handoff.md` first, then the relevant proof plan,
meta-plan, blueprint, research log, proof workflow, and session instructions.
Ignore “Old prompts - do not use.” Invoking this prompt authorizes only B1c;
saving it does not start proof work. B1c is the next bounded slice of proof-plan
**Step 3**, implementation milestone M2. It does not begin Step 4.

### Inspect the actual checkout

PR #3 was merged. At prompt preparation, `feature/attempt-04` was already based
on merged main at `4eb973b`. Verify actual local/remote state rather than
assuming that snapshot is still HEAD. Use a new or already prepared B1c branch
containing current merged main and this saved prompt; do not recreate an
appropriate branch unnecessarily. Preserve all unrelated staged, modified,
and untracked work, including Obsidian, notes, and papers. Check effective
permissions without changing permission settings.

The B1 source/proof review, B1a, and B1b are complete. Do not repeat them.
Preserve `bbpCoeff`, `integral_bbpTerm`, `hasSum_bbpTerm`, `norm_bbpTerm_le`,
their root exports, and all existing checks. Read their current statements in
`PiDisjunctivity/BBP/Series.lean` and `Test.lean` before using them.

### Bounded endpoint and exact statement

Implement only [B1c: sum/integral interchange](proof-plan.md#next-bounded-task-b1c-sumintegral-interchange).
State the endpoint before editing: one unconditional, kernel-checked bridge
from the BBP coefficient series to the unevaluated rational integral, with its
root export, complete type/axiom audit, validation, required review, local
commit/necessity review, and durable handoff.

In namespace `PiDisjunctivity`, prove exactly:

```lean
HasSum (fun j : ℕ => bbpCoeff j / (16 : ℝ) ^ j)
  (∫ x in (0 : ℝ)..1,
    (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5) / (1 - x ^ 8 / 16))
```

Choose a clear theorem name consistent with the module, such as
`hasSum_bbpCoeff_integral`. The statement must have no unproved convergence,
measurability, domination, integrability, or BBP-identity hypotheses. Preserve
`HasSum`; a `tsum` equality alone is not the endpoint. Do not add separate
public definitions or a general analytic API without a demonstrated consumer.

### Proof route and remaining premises

Use the independently proved B1a/B1b results and the pinned Mathlib
`intervalIntegral.hasSum_integral_of_dominated_convergence` API. Search the
local pinned sources and inspect its actual signature before implementing.
For mathematical notation only, put:

```text
F j x = (x^8/16)^j * (4 - 2*x^3 - x^4 - x^5)
K x   = (4 - 2*x^3 - x^4 - x^5) / (1 - x^8/16)
bound j x = 8 * (1 / (16 : ℝ))^j
```

Discharge all five premises with natural indices, real values, volume measure,
and endpoints `0`, `1`:

1. Each `F j` is almost-everywhere strongly measurable for volume restricted
   to `Set.uIoc 0 1`; polynomial continuity suffices.
2. The norm bound holds almost everywhere on that interval, using
   `norm_bbpTerm_le` and the inclusion in `Set.Icc 0 1`.
3. The majorant is summable in `j`, using the geometric ratio `1/16 < 1`.
4. The function `x ↦ ∑' j, bound j x` is interval integrable. It is constant
   in `x`; its exact numerical value need not be evaluated.
5. The pointwise `HasSum` holds almost everywhere on the interval, using
   `hasSum_bbpTerm` with the correct interval inclusion.

Obtain `HasSum` of the term integrals directly, then rewrite them with
`integral_bbpTerm`. Keep supporting facts local unless a later consumer needs
an exported lemma. Do not introduce a preliminary tail layer. Check the
restricted measure, interval orientation, zero-based index, real division,
and the treatment of interval endpoints explicitly. Preserve B1b's existing
endpoint and zero-index regressions. Do not copy or translate external proofs.

### Validation and review

Follow the Mathlib-only dependency and proof-trust policies, both
`v4.37.0-rc1` pins, module/import/public conventions, enabled linters, and
Ursula Athene-only copyright and author attribution. Add no project axiom,
`sorry`, `admit`, `native_decide`, or unsafe proof shortcut. Only `propext`,
`Classical.choice`, and `Quot.sound` may occur in an actual axiom list.

Run Lean commands from the root containing `lakefile.toml` and `lean-toolchain`,
with `$HOME/.elan/bin` on `PATH` if needed. Confirm `lean --version` is
`4.37.0-rc1`, establish the baseline, and after implementation run:

```sh
lake build
lake env lean Test.lean
git diff --check
```

Export the bridge through the library root. Add its complete unconditional
type check and guard its inspected actual `#print axioms` output in `Test.lean`.
Preserve all twenty-two existing theorem audits and all definition/value and
boundary checks. Review the mathematical meaning and preservation of existing
statements separately from compilation; inspect imports, pins, and manifest.
Classify failures as compiler/library/environment issues or missing mathematics,
and record exact obstructions without weakening the target.

Obtain the required Gemini Carbon High changed-file review through `agy`,
following `AGENTS.md` exactly: literal approved prefix, plan mode, supplied
exact task-owned diff, read-only file tools only, no file changes or shell/Bash
calls, stream JSON, twenty-minute deadline, retained conversation ID, bounded
waits, progress reporting, terminal-field inspection, and at most one focused
recovery after a failed invocation. Capture output through the execution tool
and save it separately. Reserve enough output budget, especially once text
deltas begin, to avoid the intermediate-stream truncation recorded in B1b.
Resolve substantive findings and obtain required follow-up review. Do not
claim review completion from an empty response or an incomplete invocation.

### Finalize and stop

Update both plans, the blueprint, research log, current session instructions,
affected audit-count summaries, and `docs/b1c-handoff.md` to reflect actual
checked results and remaining obligations. Commit only task-owned changes
locally after validation and review. Perform the post-commit proof-necessity
review; simplify only where justified, validate/review substantive changes,
and commit actual follow-up changes without creating an empty commit.

Stop before rational integral evaluation, antiderivative/FTC development,
the full `HasSum ... Real.pi` theorem, Step 4/B2/B3, or universal visitation.
Retain all unproved obligations: full B1, B2/B3, V, Hπ, T, and π disjunctivity
remain open; B4 assumes vanishing errors and arbitrarily late visits, and P3
assumes open-interval visits. B1c does not prove any of these missing premises.

Report exact results, validation, Gemini review outcome/limitations, local
commit IDs, and the handoff path. Propose the next smallest task without
starting it. Do not push or open a PR unless separately requested; when PR
creation is authorized, always use `gh pr create` as required by `AGENTS.md`.
Pause before another milestone.



The following completed prompts are archived for provenance. They grant no
current authorization and do not override the current prompt or review policy.

<a id="current-prompt-b1b-pointwise-series-and-domination"></a>

### Session prompt: B1b pointwise series and domination

<a id="current-prompt-b1-source-and-proof-review"></a>

**Implementation record (2026-11-25): B1b is checked.** Read
[the B1b handoff](b1b-handoff.md) for validation, Gemini review status, local
commits, and the post-commit necessity review. The prompt below records the
executed scope; do not repeat it or automatically begin another milestone.
B1c sum/integral interchange is only a proposal in the plans and requires a
new user instruction. The full B1 identity and π disjunctivity remain unproved.

Resume work in `/Users/adam/personal/proj/pi-disjunctivity/pi-disjunctivity`.

Read `AGENTS.md` and `docs/b1a-handoff.md` first, then the relevant proof plan,
meta-plan, blueprint, research log, proof workflow, and session instructions.
Ignore “Old prompts - do not use.” This prompt authorizes B1b and supersedes
the previous session prompt’s completed B1a scope.

PR #2 was merged. Verify the actual repository and remote state rather than
assuming an earlier commit is HEAD. Start from current merged main on a new
or already prepared B1b branch, preserving this saved prompt and all unrelated
staged, modified, and untracked files. At prompt preparation, `feature/attempt03`
was already based on the merged main; do not recreate it unnecessarily. Check
effective permissions without changing permission settings.

The B1 source/proof review and B1a implementation are complete. Do not repeat
them. Preserve `bbpCoeff`, `integral_bbpTerm`, their exports, and existing audits.

Proceed only with [B1b: pointwise series and domination](proof-plan.md#next-bounded-task-b1b-pointwise-series-and-domination),
under proof-plan Step 3 and implementation milestone M2. State the bounded
endpoint before editing.

For real `x`, use these mathematical abbreviations:

```text
q(x) = x^8 / 16
P(x) = 4 - 2*x^3 - x^4 - x^5
K(x) = P(x) / (1 - q(x))
```

Independently implement and prove exactly:

1. For every `x ∈ Set.Icc (0 : ℝ) 1`:
   `HasSum (fun j : ℕ => q(x)^j * P(x)) (K(x))`.
2. For every `j : ℕ` and `x ∈ Set.Icc (0 : ℝ) 1`:
   `‖q(x)^j * P(x)‖ ≤ 8 * (1 / (16 : ℝ))^j`.

Use the pinned Mathlib geometric-series and inequality APIs. Establish the
required ratio bounds and denominator conditions explicitly. Keep helpers
local unless a consumer needs them; the abbreviations above do not mandate
new public definitions or a general analytic API.

Add the necessary root exports, complete theorem-type checks, and guarded
actual axiom audits in `Test.lean`. Preserve all twenty existing theorem audits
and definition/value checks. Check endpoints `x = 0` and `x = 1` and index `j = 0`,
alongside the universal proofs.

Follow the Mathlib-only dependency policy, Lean/Mathlib `v4.37.0-rc1` pins,
proof-trust requirements, module/export conventions, enabled linters, and
Ursula Athene attribution policy. Do not copy or translate external proof scripts.

Run `lake build`, `lake env lean Test.lean`, and `git diff --check` from the
repository root, confirming the pinned toolchain first. Review mathematical
meaning, imports, and preservation of existing statements separately.

Obtain the required Gemini Carbon High review through `agy`, following
`AGENTS.md` exactly for scope, supplied diff, read-only restrictions, stream
capture, progress reporting, deadlines, and bounded recovery. Resolve substantive
findings and obtain any required follow-up review.

Update both plans, the blueprint, research log, current session instructions,
and a durable `docs/b1b-handoff.md` to reflect actual checked results and remaining
obligations. Commit only task-owned changes locally. Perform the post-commit
proof-necessity review, simplify only where justified, and validate/review any
substantive changes before a further commit. Do not create empty commits.

Stop before sum/integral interchange, rational integral evaluation, the full
`HasSum ... Real.pi` theorem, B2, B3, or universal visitation. Retain every
unproved hypothesis; B1b does not prove π disjunctivity.

Report validation, review outcome, commit IDs, and the handoff path. Do not
push or open a PR unless separately requested. Pause before another milestone.

<a id="current-prompt-b1a-coefficient-and-one-term-integral"></a>

### Session prompt: B1a coefficient and one-term integral

**Implementation record (2026-11-25):** `bbpCoeff` and `integral_bbpTerm` are
checked and audited. Read [the B1a handoff](b1a-handoff.md) first for validation,
Gemini review status, commits, and the stopping point. The B1 source/proof review
at `2b7a745` and `ab43f71` is complete and must not be repeated. Inspect actual
HEAD/status rather than assuming those historical commits are current.

The user authorized only the [B1a slice](proof-plan.md#completed-bounded-task-b1a-coefficient-and-one-term-integral):
independently implement the coefficient and unconditional single-term integral,
root export, complete type/axiom audit, coefficient expansion and `j = 0` value
check. Preserve unrelated staged, modified, and untracked work. External code
was reference only: do not copy or translate its proof scripts. Do not begin
infinite interchange, π evaluation, B2, B3, or universal visitation.

Before resuming any unfinished B1a finalization, read `AGENTS.md`, the durable
handoff, proof plan, meta-plan, blueprint, research log, and workflow. Verify
current permissions without changing them. Retain Mathlib as the only direct
external Lean library, both `v4.37.0-rc1` pins, enabled linters, module/export
conventions, and Ursula Athene-only copyright/author attribution. No extra
axioms, placeholders, `native_decide`, or unsafe shortcuts are permitted.

Run Lean commands from the directory containing `lakefile.toml` and
`lean-toolchain`, with `$HOME/.elan/bin` on `PATH` if needed. Require
`lean --version` to report `4.37.0-rc1`. Run `lake build`,
`lake env lean Test.lean`, and `git diff --check` after Lean changes. Preserve
the twenty exact theorem type/axiom guards, two π definition checks, and BBP
coefficient checks. Only `propext`, `Classical.choice`, and `Quot.sound` are
permitted dependencies; a theorem may use fewer.

For any remaining required review or substantive fix follow-up, follow
[AGENTS.md](../AGENTS.md#gemini-carbon-code-reviews-with-agy) exactly: explicit
`agy --model gemini-4-carbon-high --mode plan`, stream JSON, twenty-minute
deadline, exact task-owned diff, read-only file tools only, no file changes or
shell/Bash calls. Capture through the execution tool and save separately;
record start/init/progress timestamps and all terminal fields. Keep waits at
most sixty seconds and report meaningful progress or its absence. Require a
substantive response, inspect denials, and permit at most one focused recovery
after inspecting failure evidence/logs and confirming the prior invocation ended.
Retain the explicit conversation ID. No permission bypass, model substitution,
additional agents, or repeat of a completed review is authorized by this record.

Finish the scoped milestone review before its local commit. Then perform the
post-commit proof-necessity review; substantive changes need a focused Gemini
follow-up and affected checks before a further commit. Do not create empty
commits. Update the plans, blueprint, research log, and handoff to actual results,
review the staged scope, commit only task-owned paths, and do not push. Print
the durable handoff, report validation/review/commit IDs, then pause.

**Next proposed task, not invoked:** [B1b pointwise series and domination](proof-plan.md#next-bounded-task-b1b-pointwise-series-and-domination).
It needs separate authorization. B1's full `HasSum ... Real.pi`, B2/B3, V, Hπ,
and T remain unproved. B4 retains vanishing error and arbitrarily late visits;
P3 retains open-interval visits. No conditional reduction proves these premises.

### Session prompt: begin the proof attempt with B4 and P3

Use this prompt to start the next bounded implementation session. The Step 2
interval-hitting pilot is complete. B4 and P3 are the next supporting milestone;
the universal-visitation claim about the BBP recurrence remains open.

#### Authorization and endpoint

Implement and validate **B4, the conditional interior-margin transfer, and P3,
the open-interval-to-hexadecimal-cell conversion**, as specified in
[the proof plan](proof-plan.md#next-bounded-task-conditional-interior-margin-transfer).
Proceed autonomously within this scope; this is an implementation request,
not a request for another plan.

Complete the two general lemmas, their exports and audits, then retrospect on
the milestone and recommend the next bounded task. Review both the proof plan
and meta-plan and make evidence-based adjustments within this milestone's scope.
Stop after that handoff; recommending a later task does not authorize starting it.

Follow the existing Viewpoint policy for local milestone commits: validate and
commit the scoped code and documentation, then review whether every proof piece
is needed, simplify where justified, rerun affected checks, and commit any actual
follow-up changes. Do not manufacture an empty second commit. Do not push unless
the user separately requests it. Do not install tooling, use paid services,
launch sub-agents, change dependencies, or rewrite Git history.

#### Inspect the actual checkout first

Locate the repository root containing **both `lakefile.toml` and
`lean-toolchain`**. It may be the `pi-disjunctivity/` subdirectory of the initial
workspace, alongside another Lean project. Run every Lean/Lake command from
that root with `$HOME/.elan/bin` on `PATH`. Require `lean --version` to report
**4.37.0-rc1** before building; `lake --dir` alone does not select the correct
Elan toolchain.

At this prompt's creation, the branch is `feature/attempt-02`, with committed
baseline `64f5b28` in `ursula-athene/pi-disjunctivity`. Inspect current status and
history rather than resetting to that snapshot. Preserve unrelated changes,
particularly `docs/.obsidian/*` and `docs/notes/`, and stage only task-owned files.
If the milestone has since been implemented, inspect its checks and status
instead of duplicating it or automatically advancing to another milestone.

Read before editing:

- `AGENTS.md` and any applicable nested instructions.
- `docs/proof-plan.md`, `docs/meta-proof-plan.md`, `docs/proof-workflow.md`,
  `docs/proof-blueprint.md`, and `docs/research-log.md`.
- `README.md`, `docs/problem-formulation.md`, and `docs/dependencies-and-trust.md`
  for the reviewed formulation, current status, and trust boundary.
- `PiDisjunctivity/OrbitCriteria.lean`, `PiDisjunctivity/OrbitEquivalence.lean`,
  their relevant prerequisites, `PiDisjunctivity.lean`, and `Test.lean`.
- `lakefile.toml`, `lean-toolchain`, and `lake-manifest.json`.

The external review in `docs/agy-reports/meta-proof-plan-review-report.md` is
historical evidence. Its recommendations were independently triaged; use the
accepted specifications and decisions in the current plans and research log.
Do not reinstate its rejected or deferred recommendations.

Establish the baseline with `lake build`, `lake env lean Test.lean`, and
`git diff --check`. Announce the bounded endpoint before implementing.

#### Required mathematical statements

Choose clear theorem names consistent with the module. The signatures below
specify the hypotheses and conclusions; they are not incomplete Lean source
files to add to the repository.

##### B4: conditional interior-margin transfer

For `u r : ℕ → ℝ`, assume exactly:

```text
Filter.Tendsto r Filter.atTop (nhds 0)

∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
  ∀ N : ℕ, ∃ n ≥ N, u n ∈ Set.Ioo a b
```

Prove:

```text
∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
  ∃ n : ℕ, Int.fract (u n + r n) ∈ Set.Ioo a b
```

Do not add the redundant global hypothesis `∀ n, 0 ≤ u n ∧ u n < 1`.
Use the reviewed interior-margin argument: for a target `(a,b)`, take
`δ = (b-a)/4`, obtain a threshold after which `|r n| < δ`, then select a late
visit of `u` to `(a+δ,b-δ)`. The perturbed value lies strictly between `a` and
`b`, so its fractional part equals itself. Verify the quantifier order,
`a = 0`, `b = 1`, and errors of either sign. Do not assume a global Lipschitz
bound for `Int.fract` across integers.

Keep the single-visit conclusion. Arbitrarily late output visits and an extra
composition theorem are deferred until needed.

##### P3: open-interval-to-cell conversion

For arbitrary `t : ℕ → ℝ`, assume:

```text
∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
  ∃ n : ℕ, t n ∈ Set.Ioo a b
```

Prove:

```text
∀ k m : ℕ, m < 16 ^ k → ∃ n : ℕ,
  t n ∈ Set.Ico ((m : ℝ) / (16 : ℝ) ^ k)
    (((m : ℝ) + 1) / (16 : ℝ) ^ k)
```

Apply the hypothesis to the open interior of each cell. Check positive width,
nonnegative lower endpoint, upper endpoint at most one, natural-to-real casts,
and `k = 0`, `m = 0`, and `m = 16^k - 1`. This lemma is independent of B4 and
requires no range hypothesis on `t` or BBP assumption.

#### Implementation and verification

Use `PiDisjunctivity/OrbitCriteria.lean` unless inspection demonstrates a smaller
suitable location. Preserve existing definitions, theorem contracts, public
exports, module/import conventions, headers, and linters. Use only Mathlib,
Lean's core/standard libraries, and permitted project modules; retain the
Lean/Mathlib `v4.37.0-rc1` pins.

Follow the local workflow: search the project and pinned Mathlib first, sketch
and criticize the argument, use disposable `/tmp` scratch files when useful,
then implement incrementally. `#check`, `#print`, `trace_state`, `exact?`,
`apply?`, and `rw?` are available within the existing stack. Remove diagnostics
and replace successful search suggestions with explicit proof steps in the
production proofs. Add only necessary helpers.

Use kernel-checked proofs with no `sorry`, `admit`, project-specific axioms,
`native_decide`, or unsafe shortcuts. The only permitted axiom dependencies
are `propext`, `Classical.choice`, and `Quot.sound`; individual results may use
fewer. Inspect the actual lists before adding guards.

Export both results through the existing library root and extend `Test.lean`
with their explicit complete type checks and guarded `#print axioms` outputs.
Preserve the existing seventeen theorem audits and both expanded conjecture
definition checks. Add `Examples.lean` cases only when they provide useful
semantic or boundary regression coverage beyond the universal proofs and audits.

Validate the integrated result from the repository root:

```sh
lake build
lake env lean Test.lean
git diff --check
git diff HEAD -- lean-toolchain lakefile.toml lake-manifest.json \
  PiDisjunctivity/Definitions.lean PiDisjunctivity/Conjectures.lean
```

Review all other changed theorem signatures, imports, and the staged diff as
well. Preserve pre-existing unrelated work. Resolve compiler/linter problems
without weakening the specifications. If blocked, record the precise obstacle,
commands and diagnostics, and whether it is a mathematical, library, compiler,
or environment issue; keep every unproved claim explicit.

#### Retrospective, plan adjustment, and stopping point

At completion or a documented obstruction, assess:

1. What was actually established, and which hypotheses and mathematical gaps
   remain?
2. What helped or hindered the work: mathematics, library search, formalization,
   or workflow?
3. Does the evidence justify changing the mathematical route, task order, or
   research process?
4. What is the next smallest useful task, with an explicit endpoint and stopping
   condition?

Update the blueprint and research log with actual declarations, statuses,
checks, and outcomes. Review both plans; update the proof plan for mathematical
or status changes and the meta-plan/workflow for process changes that the
evidence warrants. Keep the linked next-task entries aligned in both plans.
Reconcile affected audit-count summaries. Avoid a planning-system rewrite or
edits made only to show that every document was touched.

Keep user-owned policy choices explicit. In particular, changing the existing
commit cadence or the later B1/B3 ordering needs a separate user decision.
You may recommend weighted-series/tail summability and B3 before B1, with reasons;
do not silently reorder or begin that work. Review new mathematical arguments
before committing to substantial formalization.

Mark B4 and P3 checked only when their proofs and audits pass. Hπ, T, and the
π conjecture remain unproved because independent visitation and BBP bridges
are still missing. Stop before defining or proving BBP series, recurrences,
tail estimates, or attempting Step 5's universal visitation.

Finish with a concise handoff: exact results and hypotheses, files changed,
validation actually run, retrospective conclusions, plan adjustments, commit
IDs, remaining obstructions, and the next task proposed for authorization.

Write the handoff to a markdown file, commit it, and print to the user in a
format that is readable on the Codex terminal.

Then pause for the user's questions and decision.

### Session prompts

Milestone C is complete; see the [consolidated review](formulation-review.md).
The prompt below is retained as the record of the authorized review scope, not
as a pending task. Formulation verification is complete, and the pi disjunctivity
conjecture remains unproved. A proof attempt or BBP formalization requires
separate authorization. The older
[Step 2 prompt](step-2-session-prompt.md) is retained as historical context;
that foundational step is already complete.

#### Next session: final formulation audit and review (milestone C)

**Completed 2026-11-24. Historical prompt follows.**

Complete **milestone C, "Complete the formulation audit and review,"** in
`docs/problem-formulation.md`. This authorizes the review, necessary corrections,
validation, and documentation within that scope, not merely another plan.

We want to finish verifying that our Lean formulation expresses the intended
problem: every finite hexadecimal word occurs contiguously after the radix point
of pi, including words with leading zeros. We are not yet working on a proof that
pi has this property. Do not begin conjecture-proof research or BBP formalization.

##### Read the current project first

Locate the repository root containing `lakefile.toml`; it may be the
`pi-disjunctivity/` subdirectory of the initial workspace. The repository is
`ursula-athene/pi-disjunctivity`, on branch `feature/attempt-01` at handoff.
Read applicable `AGENTS.md` instructions, inspect Git status, and preserve
existing changes. Do not switch branches or rewrite history.

Read before editing:

- `README.md`, `docs/problem-formulation.md`, `docs/foundations-plan.md`, and
  `docs/dependencies-and-trust.md`.
- Every project Lean module: `Definitions.lean`, `BlockValue.lean`, `Digits.lean`,
  `Cylinders.lean`, `Conjectures.lean`, `OrbitEquivalence.lean`, and `Examples.lean`
  under `PiDisjunctivity/`, plus `PiDisjunctivity.lean` and `Test.lean`.
- `lakefile.toml`, `lake-manifest.json`, `lean-toolchain`, and
  `.github/workflows/lean_action_ci.yml`.

All three foundational steps and milestones A and B are implemented. Their
twelve reviewed theorem types and guarded axiom checks passed at handoff.
Milestone C remains pending. The old base-10 handoff and Step 2 prompt are
historical; the current formulation and roadmap govern this task. Review the
current proofs rather than restoring previously discarded proofs from history.

##### Perform the consolidated review

1. Compare the actual definitions and exported theorem statements with the
   intended problem. Check the quantifier order (every length and word has an
   occurrence), explicit word length and leading zeros, contiguous digits,
   zero-based positions after the radix point, digit values 0 through 15, and
   the vacuous empty word. Disjunctivity requires existence of occurrences,
   without a frequency condition.
2. Check the nonnegativity hypotheses required by `Nat.floor`, preservation of
   the integer part in reconstruction, and the terminating-expansion convention
   of trailing zeros. Review how the universal proofs justify these conventions;
   examples alone are insufficient.
3. Review both directions of the word–interval correspondence, including fixed
   length, digit shifts, and left-closed/right-open boundaries. Review both
   directions of the orbit-closure equivalence, including approximation of both
   0 and 1 and the use of interval interiors to recover occurrences. Confirm that
   the pi specialization uses Mathlib's `Real.pi` and proves only equivalence
   between the two proposition definitions, without asserting either one.
4. Preserve the twelve exported-type checks and guarded `#print axioms` audits.
   Record each theorem's actual axiom dependencies, allowing only `propext`,
   `Classical.choice`, and `Quot.sound`; a theorem may use fewer. Unexpected
   dependencies must still fail the audit. Check configuration, manifest, and
   source imports separately for compliance with the dependency policy.
5. Review the existing examples for empty and one-digit words, zero, `00A`, `FF`,
   nonzero offsets, integer parts, terminating expansions, and both interval
   boundaries. Add meaningful checks or supporting lemmas where the review
   reveals a gap. Preserve the reviewed definitions and theorem statements;
   explain any necessary correction and its effect on the intended meaning.
   Never weaken a statement or a check merely to make validation pass.
6. Write a consolidated review in `docs/formulation-review.md`, mapping each
   requirement to its definitions, general theorems, and relevant examples.
   Record findings, any corrections, actual axiom lists, commands and results,
   and remaining limitations. Distinguish kernel-checked proofs from the
   mathematical review of their intended meaning. Update `README.md`,
   `docs/foundations-plan.md`, `docs/problem-formulation.md`, and
   `docs/dependencies-and-trust.md` consistently. Mark milestone C complete only
   if its criteria have actually been met; otherwise identify the precise gaps.

##### Constraints and validation

Mathlib must remain the only direct external Lean library. Our own Lean code
depending only on Mathlib, Lean's core/standard libraries, and compliant local
modules is allowed. Keep Mathlib's pinned transitive dependencies; add no other
external libraries, vendored libraries, or direct imports of those packages.
Follow `AGENTS.md` and `docs/dependencies-and-trust.md`.

Keep Lean and Mathlib pinned to `v4.37.0-rc1`. Add no `sorry`, `admit`,
project-specific axioms, `native_decide` proof bypasses, or unsafe shortcuts.
Preserve `module`, import, and public-section conventions, MIT SPDX headers,
enabled linters, and copyright/author attribution only to Ursula Athene.

Run from the repository root:

```sh
lake build
lake env lean Test.lean
git diff --check
```

If needed, first run `export PATH="$HOME/.elan/bin:$PATH"`. Resolve build or
linter warnings without disabling checks. Ensure CI still runs the audit after
the build. Do not mark verification complete solely because the build passes.

Finish with the review findings, changes, validation results, axiom dependencies,
and a clear statement of whether formulation verification is complete. State
explicitly that the pi disjunctivity conjecture remains unproved. Stop at this
phase; work on proving the conjecture requires separate authorization. Leave
this next session's changes uncommitted and ready for review; do not push.
