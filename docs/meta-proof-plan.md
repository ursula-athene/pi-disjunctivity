# Meta-plan for AI-assisted proof research

This document owns evidence-based lessons, process decisions, and evaluation.
The [proof plan](proof-plan.md) owns mathematical contracts, the
[blueprint](proof-blueprint.md) owns declaration/dependency status, and the
[workflow](proof-workflow.md) owns execution. The original 2026-11-24 pilot
plan below is retained as a dated design record; its pilot is complete, not a
standing instruction to repeat it. Outcomes are in the [research log](research-log.md).

Next session: <!-- current-prompt --> [Current prompt](session-prompts.md#current-prompt-b3-tail-control)
is the execution entry, only when invoked by the user.

## B2 improvement evaluation — 2026-11-25

The invoked P0–P5 cycle uses baseline `e83580e` on the user-prepared
`feature/b2-process-and-tooling-improvements`. The
[handoff](b2-improvements-handoff.md) owns acceptance/publication; the
[evaluation](b2-tool-evaluation.md) owns tool evidence and rollback. B2 is fixed
test material; no production Lean, audit, pin, or manifest changes are included.
The user subsequently authorized pushes on this branch, with no PR.

Retain the signature/index checks, manual semantic status pass, bounded reads,
self-contained review packets, and I6's separate CLI-log inspection. The stale
fixture passed link checking but failed the manual status comparison. The LSP
found a generated declaration via its symbol index and returned useful local
goals/diagnostics; actual host installation/configuration was denied, so adoption
is deferred and shell remains default. Selected external skills added no new
proof output in the known replay and remain deferred. Two small original skill
sources passed same-session seeded argument/contract cases and a focused retest;
retain them for explicit manual use, with catalog adoption deferred. No blind
skill-performance or general productivity claim follows.

Reject the redundant lemma-lab wrapper and broad frameworks for this endpoint.
Defer remote search, Sage, and elaboration tuning until the named triggers in
the evaluation arise. These decisions do not advance B3 or visitation. Keep
future evidence in the existing handoff/review records rather than adding more
interim execution-status sections here (P1 review I4).

## Carbon review guidance adoption — 2026-11-25

A later user request explicitly authorized adopting the Carbon review-guidance
improvements and integrating the two user-supplied adversarial guides. This is
the review-documentation subset of the B2 improvement plan, not invocation of
the full implementation prompt or permission to begin B3.

The [Carbon procedure](gemini-review.md) now requires the proof guide for Lean
milestones, the strategy/tooling guide for tooling and meta-plan reviews, and
both for substantive mixed work. The guides inform scrutiny within the supplied
scope; Carbon retains read-only file tools and requests caller-run checks where
their examples call for experiments or compilation.

The reporting change addresses observed omissions: B2a's documentation finding
was fixed before its clean final review, and the tooling recommendation review
included an optional supersession suggestion that was implemented but not
highlighted in the summary. Future reviews separate defects, nonblocking
improvements, and open questions. The caller records each item's disposition
and reports the full cycle, including improvements to otherwise correct work.
Neutral claim/evidence packets and explicit challenges to weak assumptions are
intended to reduce confirmation-oriented review; their effect is unmeasured.
There is no finding quota or claim that a low finding count demonstrates quality.

See the [review-guidance handoff](carbon-review-improvements-handoff.md) for
actual validation, review items/dispositions, and publication evidence. No Lean
proof, tool installation, LSP pilot, skill activation, or dependency changed.
At that scoped endpoint the rest of the B2 improvement plan remained future
work. The later evaluation above reconciles that adoption without repeating it.

## B2 improvement plan — proposed 2026-11-25

The [replacement process/tool plan](b2-process-tool-improvement-plan.md) now
owns the bounded implementation sequence and evaluation criteria. It supersedes
the earlier B2 tooling prompt, which remains archived. That initial update was
planning-only: no tools or skills were installed or activated, and no workflow
or Lean proof was implemented. The review-guidance adoption above is a later,
separately authorized subset; it does not complete the implementation plan.

Implement and evaluate the improvements before moving to B3. B2 proof work is
out of scope; already completed B2 provides fixed replay cases only. Preserve
the existing mathematical roadmap, guarded audits, and unresolved hypotheses.

The expanded B2 retrospective justifies a local LSP trial for generated-lemma
discovery and goal inspection, a manual semantic status pass, bounded reads,
and self-contained review packets. It does not establish a performance gain
or justify broader orchestration. The
[recommendation snapshot](lean-tooling-recommendations.md) adds focused
argument-criticism and source-contract skill candidates, to be evaluated on
existing material without beginning visitation research.

The replacement retains selective evaluation of `lean-search-discovery` and
`lean-proof-patterns`. It defers the old prompt's `lean-elaboration` installation:
the inspected procedure explicitly uses `sorry` substitution, and no measured
performance need warrants a compliant adaptation now. Remote search activation,
Sage installation, and overlapping full skill suites are also deferred pending
a concrete need. The plan records future trial criteria and preserves the
working shell fallback.

Future adoption must report functional correctness, actual host availability,
startup versus warm effort, skill conflict/resource checks, and explicit
adopt/defer/reject decisions. Small B2 replays have learning and cache effects;
they cannot establish general productivity gains. Installation, configuration,
protocol tests, and actual host tests are separate evidence. Keep detailed
results in the future implementation handoff, with a concise adoption entry
here only after execution. See the
[planning handoff](b2-improvement-planning-handoff.md) for this document-only work.

## B2 process evidence — 2026-11-25

Early root definition/equation probes succeeded, followed by complete theorem
interfaces before final audits. Local library search and scratch compilation
sufficed for splitting and the integer-floor recurrence argument; no new
proof infrastructure or mathematical hypothesis was needed. The B2a Carbon
review found stale overview status/count prose even though links were valid.
Corrected those summaries and removed the duplicated live audit count. The
offline documentation checker checks links/entry consistency, not mathematical
status prose; caller review must still reconcile both. This is a demonstrated
limit of the check, not a reason to expand it into a semantic status checker.

Keep the existing workflow and B1/B2/B3 ordering. See the
[B2 retrospective](retrospectives/retrospective-2026-11-25-b2.md) and
[handoff](b2-handoff.md) for observed repairs, review timing/capture, and final
acceptance. B3 is only proposed; no visitation argument or productivity gain
is inferred from this elementary orbit bridge.

<a id="b1-completion-and-next-bounded-task"></a>

## B1 process adoption — 2026-11-25

The [original B1 retrospective](retrospectives/retrospective-2026-11-25-b1.md)
is preserved as a dated proposal. A later user request authorized implementing
all its process improvements as one milestone, explicitly excluding B2,
mathematical changes, permission changes, and new external Lean dependencies.
The [process handoff](process-improvements-handoff.md) records acceptance evidence.

| B1 evidence | Adopted decision |
| --- | --- |
| B1a root-import visibility failure after a passing term proof | Probe exported definition bodies and downstream theorem types early. |
| B1b broad simplification and boundary tests that bypassed their theorem; B1 completion elaboration/denominator repairs | Use explicit theorem instantiations, targeted normalization, and typed API probes; distinguish compiler repairs from missing mathematics. |
| Successful composition of B1c, algebra, derivative, FTC, and final assembly | Complete the authorized milestone through internal checks, preserving intermediate reviews and the endpoint. |
| B1c empty SUCCESS response; B1b truncated intermediate capture; unavailable persisted conversation during PR follow-up | Consolidate mandatory Carbon High operations; add scoped diff/hash preparation and capture/result inspection, retaining human coverage assessment and bounded recovery. |
| Stale but valid archived entry anchor and duplicated mutable status prose | Establish record ownership, mark active current-prompt links, and test them offline in CI. Keep dated archives intact. |
| Existing log and handoffs already supplied project context | Standardize concise handoffs; agent memory holds stable preferences/pointers, with volatile state verified from the checkout. |
| Completion communication omitted substep labels and publication detail | Report completed substeps, remaining obligations, and local/pushed/PR state explicitly. |

[AGENTS.md](../AGENTS.md) holds durable rules, with the full mandatory
[Gemini procedure](gemini-review.md) moved to its own document. The
[process tools](process-tools.md) are small offline Python utilities in a root
`uv` project using MIT-licensed Markdown and YAML parsers. CI retains its Lean build and
axiom audit. At this historical B1 adoption baseline, the then-current B2
prompt linked consolidated procedures and retained all mathematical contracts
and its proof-plan-before-implementation requirement; the process adoption did
not execute it. B2/B3, V, Hπ, T, and π disjunctivity were then unproved. B4
assumed vanishing errors and arbitrarily late visits; P3 assumed open-interval
visits. Use the blueprint for current mathematical status.

Keep the successful mathematical decomposition, pinned-source search, direct
`HasSum` route, exact audits, and post-commit necessity review. No optional Lean
infrastructure, new service, automatic retry loop, or permission expansion was
justified. The source and prior cycle records support these decisions, not a
claim that universal visitation will be similarly tractable.

### Lightweight evaluation

In future handoffs, record interface failures and their fixes; compiler repairs
separately from missing mathematics; review attempts and per-invocation elapsed
time; capture completeness (including missing chunks); and stale-entry-link
incidents. Use short counts with evidence links when actually observed; say
"not measured" for missing data. Separate proof and review/finalization time
only when timestamps support it. Do not reconstruct historical counts, confuse
cumulative usage with wall time, or claim quantified gains from one cycle.

Deferred [Carbon review item Q2](agy-reports/carbon-review-improvements-review.md#items-and-dispositions):
in the next two authorized milestone reviews, retain per-invocation wall time,
capture token counts/budgets, and D/I/Q dispositions with concrete usefulness or
boilerplate examples. Use those observations to consider trimming the reporting
burden; they do not establish a detection rate. The [improvement review](agy-reports/b2-improvements-review.md) and
[retrospective](retrospectives/retrospective-2026-11-25-b2-improvements.md) record
P1/final observations within this first implementation milestone. Retain the
next authorized milestone as the second milestone sample; do not add benchmark
reviews or infer effectiveness from these counts.

## B4/P3 workflow retrospective — 2026-11-25 snapshot

Project and pinned-library search, a disposable scratch file, and the shell
compiler loop sufficed. Both candidate proofs compiled on the first attempt;
the integrated build and exact type/axiom guards passed without warnings.
Boundary and quantifier review confirmed the intended statements without new
hypotheses. No optional tooling, additional helper API, or separate agent was
needed. This is evidence that the loop sufficed for these two elementary
lemmas, not a performance comparison or evidence about universal visitation.

Keep the existing workflow and Viewpoint commit/review cadence. No process
rewrite or B1/B3 reorder was warranted by that cycle. Its proposed next task
added a bounded source/argument review because B1 needed analytic identities
and possible source adaptation, unlike B4/P3. See the [research log](research-log.md) for actual checks.

## Purpose and scope

The remaining sections preserve the 2026-11-24 pilot design and its previously
adopted review policy. For the operational sequence use the workflow linked above.

Adapt demonstrated theorem-proving methods into a practical research workflow
for this repository. This is a plan for how to conduct and check the work, not
a mathematical proof of hexadecimal disjunctivity of π.

The central design has two connected loops:

- **Mathematical research:** develop precise claims, expose dependencies,
  criticize arguments, and revise routes when the mathematics fails.
- **Lean formalization:** search the library, implement a small proof, inspect
  compiler feedback, and iterate until the intended statement is checked.

Improving the formalization loop cannot supply a missing mathematical argument
by itself. Reproducing selected methods does not reproduce the source systems
or guarantee their reported results.

Writing this document does not execute the plan, install tools, or start a proof
attempt. In the session executing it, follow the user's authorized scope and
the current repository instructions. Do not infer permission to launch a large
autonomous research campaign, use paid external services, or publish results.

## Read the current project before adapting anything

Read [AGENTS.md](../AGENTS.md), [the formulation](problem-formulation.md),
[dependencies and trust](dependencies-and-trust.md),
[the formulation review](formulation-review.md),
[the follow-up review](review-follow-up.md), and
[the mathematical proof plan](proof-plan.md). Inspect the actual Lean declarations
and `Test.lean`; use their current names and signatures.

At the time this document was written, the formulation review was complete and
the conjecture remained unproved. The mathematical proof plan identifies a BBP
route and explicitly isolates universal visitation as its unresolved step.
Earlier conversation examples used declaration names and files that have since
changed. Reconcile records with the checkout instead of restoring old content
from conversation history.

Preserve Mathlib as the sole direct external Lean library, the pinned Lean and
Mathlib versions, reviewed definitions, source conventions, and trust policy.
Research tooling is distinct from a Lean library dependency, but must not
silently introduce new imports, axioms, or proof bypasses.

## Methods to adapt

The numbers refer to the source list discussed when this plan was requested.
Read the relevant original sources before adopting implementation details.
Record what was adopted, omitted, and changed; distinguish empirical evidence
for a whole system from evidence for an individual prompt instruction.

| Source | Method to extract | Project adaptation |
| --- | --- | --- |
| **#1: Iterative proof refinement** — [minimal-agent paper](https://arxiv.org/abs/2602.24273), [mini-Lean-agent](https://arxiv.org/abs/2610.17331) | Generate, check, and revise small proofs using real compiler feedback. | Work on precisely stated intermediate lemmas; distinguish mathematical gaps from elaboration errors and tactic failures. Start with shell access and the pinned Lean toolchain. |
| **#2: Goedel-Architect** — [repository](https://github.com/goedelarchitect/goedel-architect), [paper](https://arxiv.org/abs/2606.06468) | Maintain a lemma dependency graph and refine the global plan when a node fails. | Map the existing proof plan to explicit claims, hypotheses, and dependencies. Highlight the exact π-specific input and reject circular dependencies. Do not import the entire framework or its Lean dependencies by default. |
| **#4: Aletheia** — [paper](https://arxiv.org/html/2602.10177v2) | Separate generation, criticism, and revision. | Review a candidate argument using its statement, proof, and sources, without requiring the generator's full reasoning history. Treat reviewer approval as provisional until formal checking. |
| **#9: lean4-skills** — [repository](https://github.com/cameronfreer/lean4-skills), [skill](https://github.com/cameronfreer/lean4-skills/blob/main/plugins/lean4/skills/lean4/SKILL.md) | Lean-specific search, proof repair, and blocked-goal procedures. | Select guidance compatible with this project's pins, conventions, and trust policy. Avoid copying a large instruction pack without inspecting it. |
| **#8: lean-lsp-mcp** — [repository](https://github.com/oOo0oOo/lean-lsp-mcp) | Live goals, diagnostics, search, and local proof experiments. | Use it if available and compatible. Keep a working shell-based fallback; do not make research depend on optional MCP infrastructure. |

## Stage 1: Establish a small, reproducible baseline

1. Inspect Git status and preserve unrelated work. Read the files above and
   identify the next authorized mathematical milestone.
2. Inspect available Lean commands and tools. Run `lake build` and
   `lake env lean Test.lean` to establish the current baseline; record actual
   results and any environmental blockers.
3. Inspect the source methods and produce a concise adaptation record in this
   document or a linked companion. Record source URLs and revisions where
   available. Do not represent the method summaries above as installed features.
4. Use existing shell tools first. Evaluate `lean-lsp-mcp` only if it materially
   improves access to goals or diagnostics. Verify compatibility against the
   project's pins before relying on it; do not upgrade Lean to accommodate it.
5. Incorporate only durable project rules into `AGENTS.md`, preserving its current
   policies. Put longer operational instructions in a linked document or a
   project-local skill when that offers a clear benefit.

**Deliverable:** a documented baseline and a usable, minimal proof-feedback loop,
with any missing optional capabilities explicitly recorded.

## Stage 2: Establish persistent research records

Use `docs/proof-plan.md` as the mathematical roadmap. Avoid creating a conflicting
second roadmap. Create the following files if absent, or reconcile them if they
already exist:

- `docs/proof-blueprint.md`: a concise dependency/status index linked to the
  roadmap and actual Lean declarations. For each node record its exact statement,
  hypotheses, dependencies, status, evidence, and role in reaching the target.
- `docs/research-log.md`: dated substantive attempts, sources checked, criticism,
  commands actually run, outcomes, exact obstructions, and next steps.

Distinguish proposed claims, known results awaiting formalization, Lean-checked
results, blocked routes, and abandoned routes. A conditional theorem retains its
unproved hypothesis in the graph. A restatement of disjunctivity is a reduction,
not a solution to the conjecture.

**Deliverable:** one coherent roadmap with enough persistent state for a fresh
session to continue without reconstructing the conversation.

## Stage 3: Pilot one bounded research/formalization cycle

Choose one small, useful milestone from the current mathematical plan within
the executing session's scope. Prefer an established supporting result or a
precise reduction for the initial pilot; do not begin by committing to solve
the universal-visitation gap. Agree on the pilot's concrete endpoint in the
initial task or select one and state it before proceeding.

1. **Specify:** write the exact target, hypotheses, and dependencies. Identify
   whether it needs a new fact specific to π or only general mathematics.
2. **Search:** inspect the pinned Mathlib and project sources before implementing
   supporting theory. Check original sources for external mathematical claims.
3. **Sketch:** give a short argument and expose every unproved step. Avoid
   formalizing an extensive route before checking its central implication.
4. **Criticize separately:** check quantifiers, hypotheses, boundary cases,
   cited results, circular dependencies, and potential counterexamples. A fresh
   context or separate session can help. Perform the required Gemini Carbon High
   changed-file reviews through `agy` at milestones and at useful intermediate
   points, following the proof-plan policy. Other delegation or proof-generation
   agents require separate authorization.
5. **Formalize incrementally:** inspect actual Lean goals, try a small proof,
   run the compiler, and revise based on its output. Respect the repository's
   prohibition on `sorry`, `admit`, extra axioms, and unsafe proof shortcuts.
6. **Classify failures:** distinguish a false claim, missing mathematics,
   missing library infrastructure, syntax/type errors, and resource limits.
   Revise the mathematical route when needed instead of endlessly changing tactics.
7. **Verify and record:** preserve the intended theorem statement, run the
   required checks, update guarded audits for new reviewed theorems, and record
   both successes and unresolved dependencies.

The reviewer must specifically check that almost-everywhere results have not
been applied to π without justification, finite digit checks have not replaced
universal quantification, and BBP extraction or small approximation error has
not been mistaken for a proof of interval visitation. A lemma that assumes
disjunctivity cannot independently establish it. Normality is a stronger claim,
not a free premise.

**Deliverable:** a completed pilot with verified evidence, or a precise documented
obstruction and the strongest independently verified partial result. Failure to
prove a research claim is an acceptable recorded outcome, not permission to
weaken the target.

## Stage 4: Review the workflow before adding automation

Assess which steps helped and which consumed effort without progress. Keep the
workflow manually supervised initially. Add orchestration, persistent workers,
or parallel proving only when a specific bottleneck justifies them and the user
has authorized the scope and resources. Do not install every referenced system.

For Lean changes, run:

```sh
lake build
lake env lean Test.lean
git diff --check
```

Audit both meaning and proof dependencies. Only `propext`, `Classical.choice`,
and `Quot.sound` are allowed; individual results may use fewer. A successful
build is not sufficient evidence that the intended conjecture was proved.

**Meta-plan completion means:** the adapted workflow is documented, its tools
work or have explicit fallbacks, records are usable, and one bounded pilot has
been evaluated. It does not mean the π conjecture is solved. The final handoff
must identify changes, checks actually run, remaining mathematical gaps, and
the next recommended task. Commit or publish only within the user's instructions.
