# Lean tools and AI skills for the pi disjunctivity project

Recommendation snapshot: 2026-11-25. These are candidates for evaluation, not
installed capabilities or authorization to implement them. The
[proof plan](proof-plan.md) remains the mathematical roadmap; the
[workflow](proof-workflow.md) and [trust policy](dependencies-and-trust.md)
remain authoritative.

The later [B2 improvement plan](b2-process-tool-improvement-plan.md) selects and
sequences these candidates for this project. It supersedes this snapshot as an
implementation proposal; the recommendations below are retained as source context.

Prioritize live Lean feedback, better lemma search, and focused mathematical
review. The project has two different needs: formalizing established arguments,
such as the remaining B3 tail bounds, and discovering the missing universal
visitation argument V. B1 and B2 are recorded as checked and reviewed in the
[blueprint](proof-blueprint.md). Faster formalization does not establish V.

## Recommended tools

### 1. Trial lean-lsp-mcp for live Lean feedback

[lean-lsp-mcp](https://github.com/oOo0oOo/lean-lsp-mcp) exposes Lean goals,
diagnostics, declaration information, and candidate-tactic trials to an agent.
It could reduce the effort spent reconstructing proof states from repeated
compiler runs. Compare it with the existing shell workflow on a bounded task
before adopting it.

Test ordinary LSP functionality against the unchanged Lean and Mathlib
`v4.37.0-rc1` pins. Compatibility has not been tested here. Skip the documented
optional REPL recipe: it adds another direct Lean dependency, contrary to this
project's policy. Preserve shell diagnostics and compilation as a fallback.

### 2. Use complementary theorem search

The Lean community's
[theorem-search guide](https://leanprover-community.github.io/blog/posts/searching-for-theorems-in-mathlib/)
describes Loogle, which searches by types and expression structure, and
LeanSearch, which accepts natural-language queries. These help when the desired
mathematical fact is known but its Mathlib name is not.

Search the project and pinned Mathlib first. Use external results as leads,
then inspect local signatures with `#check` and compile a small application.
Local `exact?`, `apply?`, and `rw?` already complement `rg` without adding a
dependency. Replace successful suggestions with explicit proof steps where
required by the workflow. A remote search result is not evidence that its
declaration exists in this project's pinned version.

### 3. Adopt lean4-skills guidance selectively

The community
[Lean 4 skill](https://github.com/cameronfreer/lean4-skills/blob/main/plugins/lean4/skills/lean4/SKILL.md)
covers Mathlib search, proof development, debugging, review, and simplification.
The existing workflow already incorporates selected guidance from an inspected
revision. Assess a concrete missing capability before installing a larger suite.

Some upstream workflows assume placeholder-based drafts, extra helpers, or
different review conventions. Preserve this project's no-placeholder rule,
source and attribution conventions, full authorized-milestone scope, dependency
policy, and required Gemini Carbon reviews. Inspect and record the revision
before adopting any additional guidance; do not copy an upstream workflow
wholesale or treat its command names as installed capabilities.

### 4. Consider SageMath for bounded mathematical experiments

Exact rational computations can explore finite BBP recurrences and proposed
identities. Sage also provides
[arbitrary-precision real-ball arithmetic](https://doc.sagemath.org/html/en/reference/rings_numerical/sage/rings/real_arb.html)
when numerical error must be bounded. Useful outputs include counterexamples,
candidate inequalities, and patterns suggesting a precise lemma.

Finite orbit coverage cannot establish universal visitation. Symbolic or
numerical results remain exploratory until the needed statements are proved
in Lean. Prefer an already available lightweight exact-arithmetic tool when
it suffices; a new computer-algebra environment needs a demonstrated use case.

## Proposed project-specific skills

The names below are proposals, not installed skills. Keep them small and refer
to existing project documents instead of duplicating policy or status.
[Codex skills](https://learn.chatgpt.com/docs/build-skills) can package reusable
instructions, focused references, and optional scripts.

| Proposed skill | Required output |
| --- | --- |
| `lean-lemma-lab` | An exact theorem contract, relevant pinned-Mathlib signatures, a minimal compiled proof, and the precise remaining obstruction if unsuccessful. |
| `pi-argument-critic` | Review of a candidate argument for circularity, quantifier errors, hidden distribution assumptions, and applicability to this specific BBP recurrence. |
| `paper-to-lean-contract` | A paper's exact statement and hypotheses, source locations, a proposed Lean statement, and missing bridge lemmas. |

The argument critic is the highest-priority custom research skill. It should
detect transitions from almost every starting point to this particular orbit,
from observed visits to arbitrarily late visits, or from a conditional reduction
to an unconditional result. It should also identify accidental strengthening
from disjunctivity to normality. A same-session criticism pass must not be
described as independent review. Preserve the required Carbon changed-file
review as a separate acceptance check.

## Evaluation and scope

A useful initial comparison is a bounded lemma or replay with the current
shell workflow and ordinary LSP feedback. Record setup cost, diagnosis/search
effort, successful local compilation, failures, and any learning/order effects;
do not claim a measured improvement without comparable evidence. Any future
B3 proof work requires its own authorization. Tool evaluation can instead use
already checked B2 interfaces without changing mathematical scope.

Retain `lake build`, `lake env lean Test.lean`, exact theorem-type and axiom
guards, and mathematical statement review. No tool is a substitute for the
missing visitation argument. This recommendation snapshot installs nothing,
changes no Lean source or dependency, and makes no new proof claim.
