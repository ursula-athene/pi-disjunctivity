# Meta-plan for AI-assisted proof research

**Executed 2026-11-24 within one authorized pilot.** The
[adapted workflow](proof-workflow.md), [dependency index](proof-blueprint.md),
and [research log](research-log.md) record the baseline, original-source
inspection, source adaptations, and Step 2 interval-hitting reduction.
The pilot is complete; the conditional π theorem retains its unproved hitting
hypothesis. A second authorized cycle completed B4 and P3 on 2026-11-25,
with nineteen theorem audits passing. BBP formalization and universal visitation
were not attempted. A subsequent B1 source/argument review is recorded below,
without new Lean declarations. The separately authorized B1a cycle subsequently
checked the coefficient and one-term integral, bringing the theorem audit count
to twenty. B1b now checks pointwise summation and domination, bringing that
count to twenty-two. The stages below remain the procedure for future separately scoped work.

**Review-policy update, 2026-11-25:** the user requires Gemini Carbon High
changed-file reviews through `agy` at milestones and at useful intermediate
points. Follow the [proof-plan review policy](proof-plan.md#changed-file-reviews-with-gemini-carbon)
and [AGENTS.md](../AGENTS.md#gemini-carbon-code-reviews-with-agy). This is a new
user-directed process requirement; it does not retroactively claim an external
review of the completed B4/P3 cycle.

## B1a/B1b outcomes and next bounded task

The [B1 source and proof assessment](b1-source-proof-review.md) was already
complete at `2b7a745`/`ab43f71` and was not repeated. The authorized B1a cycle
independently implemented `bbpCoeff` and the single-term integral. The
[handoff](b1a-handoff.md) records checked results, review status, and commits.
B1's full `HasSum` identity, B2/B3, and universal visitation remain unproved;
B4/P3 retain every hypothesis.

The separately authorized B1b cycle independently proved `hasSum_bbpTerm` and
`norm_bbpTerm_le`, with root-import type/axiom guards and endpoint/zero-index
checks. See [the B1b handoff](b1b-handoff.md). The next proposed cycle is
[B1c: sum/integral interchange](proof-plan.md#next-bounded-task-b1c-sumintegral-interchange),
subject to separate authorization. It stops before integral evaluation and
identification with `Real.pi`. The [current session prompt](session-prompts.md#current-prompt-b1c-sumintegral-interchange)
prepares B1c for explicit invocation; saving it does not start the milestone.
B1b's completed prompt is archived in the same file.

B1b needed only the pinned geometric-series and order APIs. A broad commutative
simplification initially failed to match the series target; a targeted `convert`
and `ring` closed it. Linter feedback removed redundant tactic sequencing and
ensured the endpoint checks actually instantiate the exported theorems. These
were compiler/linter issues, not missing mathematics. No new public helper,
optional tooling, library dependency, or external proof script was needed.
The existing workflow remains sufficient; no process rewrite is justified.

Pinned-source search and the local compiler loop sufficed. The term proof
compiled immediately; root-import definition checks then exposed a module
visibility issue, fixed by `@[expose]` on `bbpCoeff`, matching existing exposed
definitions. This was an export/compiler issue, not missing mathematics.
No external proof scripts were copied or translated, and no optional tooling
was added. Keep the integral route, direct `HasSum` plan, B1-before-B3 order,
and Gemini/Viewpoint cadence. See the log for actual review-tool outcomes.

## B4/P3 workflow retrospective

Project and pinned-library search, a disposable scratch file, and the shell
compiler loop sufficed. Both candidate proofs compiled on the first attempt;
the integrated build and exact type/axiom guards passed without warnings.
Boundary and quantifier review confirmed the intended statements without new
hypotheses. No optional tooling, additional helper API, or separate agent was
needed. This is evidence that the loop sufficed for these two elementary
lemmas, not a performance comparison or evidence about universal visitation.

Keep the existing workflow and Viewpoint commit/review cadence. No process
rewrite or B1/B3 reorder is warranted by this cycle. The next task adds a bounded
source/argument review because B1 needs analytic identities and possible source
adaptation, unlike B4/P3. See the [research log](research-log.md) for actual checks.

## Purpose and scope

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
