# Meta-plan for AI-assisted proof research

This document owns evidence-based lessons, process decisions, and evaluation.
The [proof plan](proof-plan.md) owns mathematical contracts, the
[blueprint](proof-blueprint.md) owns declaration/dependency status, and the
[workflow](proof-workflow.md) owns execution. The original 2026-11-24 pilot
plan below is retained as a dated design record; its pilot is complete, not a
standing instruction to repeat it. Outcomes are in the [research log](research-log.md).

Next session: <!-- current-prompt --> [Current prompt](session-prompts.md#current-prompt-b2-workflow-and-lean-tooling)
is the execution entry, only when invoked by the user.

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
axiom audit. The current B2 prompt links consolidated procedures and retains
all mathematical contracts and its proof-plan-before-implementation requirement;
this adoption does not execute it. B2/B3, V, Hπ, T, and π disjunctivity remain
unproved. B4 assumes vanishing errors and arbitrarily late visits; P3 assumes
open-interval visits.

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
