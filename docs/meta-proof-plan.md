# Meta-plan for AI-assisted proof research

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
   context or separate session can help. Use a separate agent only when the
   executing session authorizes delegation; it is not required by this plan.
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
