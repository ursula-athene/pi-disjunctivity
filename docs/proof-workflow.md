# Bounded proof research workflow

Established 2026-11-24 by executing [the meta-plan](meta-proof-plan.md).
The mathematical roadmap remains [proof-plan.md](proof-plan.md); the
[blueprint](proof-blueprint.md) indexes its dependencies and the
[research log](research-log.md) records actual attempts and validation.
This workflow authorizes no additional research, services, or workers.

## Source adaptations

The original sources below were read on 2026-11-24. Repository revisions are
the `main` commit IDs returned during that inspection. Only methods were
adapted; no external code, prompts, Lean declarations, or packages were copied
into the project.

| Source and inspected version | Adopted here | Omitted or changed |
| --- | --- | --- |
| [A Minimal Agent for Automated Theorem Proving, v1](https://arxiv.org/html/2602.24273v1), §3 and §4.1 | Small proof proposals, compiler feedback, concise memory of outcomes, and a separate statement review. | No proposer/reviewer services, external search service, or automated retry loop. Its benchmark ablations support iterative refinement in that setup, not a guarantee for this conjecture or each instruction here. |
| [mini-Lean-agent, v1](https://arxiv.org/html/2610.17331v1), §2 | Shell/file access, local library search, scratch experiments, pinned compilation, and checking the submitted statement separately from proof generation. | No framework installation or Comparator dependency. Existing explicit type checks, definition checks, exact axiom guards, and source diff review are our local acceptance checks; they are not a reproduction of the paper's independent clean-environment evaluator. |
| [Goedel-Architect, v1](https://arxiv.org/html/2606.06468v1), §2; [repository README at `300d69e`](https://github.com/goedelarchitect/goedel-architect/blob/300d69e97c91a2a498091c898e736af69f391960/README.md) | A dependency/status graph, explicit hypotheses, and recording false claims separately from difficult proofs. Revise a failed proposed route while retaining checked statements. | A Markdown index replaces LeanArchitect and unproved Lean skeletons. No extra Lean library, `sorry_using`, server, model API, or parallel agents. No change to our toolchain to match the framework's example project. |
| [Aletheia, v2](https://arxiv.org/html/2602.10177v2), §2.2–2.3 | Review the statement, candidate argument, and sources as a separate task; admit unresolved gaps and then revise. | One session performs distinct generation and criticism passes. This is not an independent reviewer or fresh context, and natural-language approval never replaces kernel checking. System-level results do not establish a measured gain from this local review instruction. |
| [lean4-skills at `3f913c6`](https://github.com/cameronfreer/lean4-skills/blob/3f913c66251b8712bb58e6ce83a453fa96e3f94f/plugins/lean4/skills/lean4/SKILL.md), core principles, capabilities, file handling, and blocked-work guidance | Search before proving; preserve statement contracts; compile incrementally; inspect actual signatures and axioms; record the exact obstruction. | Selected guidance only, not an installed skill or slash-command suite. Shell search replaces LSP-first and helper-script instructions. Our source headers, import conventions, and strict no-placeholder policy take precedence over its templates. |
| [lean-lsp-mcp README at `7932203`](https://github.com/oOo0oOo/lean-lsp-mcp/blob/7932203d79db213852db215835bd79c943bb99b0/README.md), features, setup, and REPL setup | Consider live goals/diagnostics if a demonstrated bottleneck warrants them; retain shell fallback. | No Lean MCP tools were exposed in this session. Nothing installed or configured; compatibility with `v4.37.0-rc1` was not tested. The optional REPL recipe adds a direct Lean dependency and must not be followed under this project's policy. |

The papers provide evidence about their tested systems and benchmarks. This
pilot verifies that the selected workflow works for an elementary reduction;
it measures neither comparative proving performance nor progress on the open
visitation argument.

## Minimal working feedback loop

Locate and enter the repository root containing both `lakefile.toml` and
`lean-toolchain`; it may be a subdirectory of a multi-directory workspace.
Elan selects the toolchain before Lake processes `--dir`, so that option alone
does not protect against a parent directory's different default. Stop before
building unless `lean --version` reports `4.37.0-rc1`.
Existing Elan, Lake, Lean, and `rg` suffice:

```sh
export PATH="$HOME/.elan/bin:$PATH"
test -f lakefile.toml && test -f lean-toolchain || exit 1
git status --short
lean --version | rg '^Lean \(version 4\.37\.0-rc1,' || exit 1
lake --version
lake build
lake env lean Test.lean
```

1. Select a single endpoint within the authorized scope and record the exact
   statement and dependencies before implementation. Read current declarations,
   rather than relying on names remembered from an earlier session.
2. Search the project, then the pinned Mathlib checkout. For this pilot:

   ```sh
   rg -n 'blockValue_lt|exists_blockValue_eq|block_iff_mem_interval' PiDisjunctivity
   rg -n 'disjunctiv|hexadecimalOrbit|block_iff_mem_interval' .lake/packages/mathlib/Mathlib
   ```

   A search exit status of 1 means no matches; it is not a compiler failure or
   proof that no related result exists under another name.
3. Sketch the argument and review it separately for quantifiers, hypotheses,
   boundary cases, circularity, and whether it supplies any new π-specific fact.
   Record conclusions and objections, not a transcript of internal reasoning.
   Before substantial Step 5 formalization, a fresh-session criticism pass is
   recommended, using the statement, candidate proof, and cited sources. This
   is advisory, does not gate exploratory work, and authorizes no sub-agents
   or external services. The mechanism suggested by Aletheia is not a measured
   guarantee for this project's review process.
4. Use a uniquely named scratch `.lean` file under `/tmp` when an isolated
   experiment helps. Import built project modules; use `#check` for signatures,
   `#print` for declarations, and `trace_state` inside a proof for the actual
   goal/context. Optionally try `exact?`, `apply?`, or `rw?` as local,
   type-directed complements to `rg`; these need no new dependency. Replace
   successful suggestions with explicit proof steps and close every goal
   without placeholders. Run:

   ```sh
   lake env lean /tmp/pi-disjunctivity-interval-pilot.lean
   ```

   This pilot exercised all three prerequisites with `#check` and displayed
   the reverse implication's goal with `trace_state`. The scratch file is a
   disposable experiment, not a required artifact; the checked proof lives in
   [OrbitCriteria.lean](../PiDisjunctivity/OrbitCriteria.lean).
5. Compile an edited module with `lake env lean PiDisjunctivity/OrbitCriteria.lean`.
   A direct Lean invocation checks that file but does not rebuild its imported
   dependencies. Use `lake build PiDisjunctivity.OrbitCriteria` after changing
   prerequisites, and `lake build` before auditing through the root import.
6. Remove diagnostic commands from production proofs. Export the result, add
   an exact type check, inspect `#print axioms`, and then guard its actual list
   in `Test.lean`. Never change an expected list merely to make an audit pass.
   Add examples in `Examples.lean` when they provide useful semantic or boundary
   regression checks, rather than requiring an example for every module or
   freezing the file. Universal proofs, exported-type checks, axiom guards,
   and mathematical statement review remain the core validation.
7. Finish with `lake build`, `lake env lean Test.lean`, and `git diff --check`.
   Review definition/signature preservation and dependency/import diffs
   separately. Before committing, inspect the pinned files and reviewed
   definitions explicitly:

   ```sh
   git diff HEAD -- lean-toolchain lakefile.toml lake-manifest.json \
     PiDisjunctivity/Definitions.lean PiDisjunctivity/Conjectures.lean
   ```

   Also review changed theorem signatures and imports outside this file list.
   Record actual commands, outputs, semantic review, remaining
   obligations, and the next bounded task in the log and blueprint.

Compiler errors and `trace_state` supply file-based feedback. There is no live
editor goal service, semantic search endpoint, automated dependency-graph
validator, independent review agent, or clean-environment proof comparator in
this setup. The existing CI build and audit remain unchanged.

## Handling a failed attempt

| Failure class | Required response |
| --- | --- |
| False statement or counterexample | Record the witness and revise the proposed route; preserve reviewed definitions and theorem contracts. |
| Missing mathematics | Name the exact unproved implication and its hypotheses. Stop that route within the agreed bound; tactics cannot supply a missing argument. |
| Missing library infrastructure | Record the searches and smallest supporting lemma needed before implementing a larger API. |
| Syntax, elaboration, type, or tactic error | Inspect the compiler's actual context, check local signatures and imports, and make a focused repair. |
| Resource or environment limit | Record the failing command and limit; do not classify it as mathematical evidence. |

Repetition without new evidence calls for a recorded obstruction and handoff,
not indefinite retries. Unproved claims stay in Markdown, never as Lean axioms
or placeholder proofs. Almost-everywhere density, finite digit checks, BBP
extraction, and shrinking errors cannot be promoted to π-specific visitation.
Conditional claims keep their hypotheses in the graph.

## Automation decision after the pilot

Local search found the complete supporting API and one scratch compilation
closed the reduction. No diagnostic or search bottleneck justified optional
tooling. Keep this manual loop. Reconsider LSP only for a concrete live-goal
need, and verify it on the unchanged project pins before relying on it.
This pilot did not execute BBP work or Step 5 research. Future work needs its
own bounded scope; the meta-plan's completion does not extend this session.
