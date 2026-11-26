# Bounded proof research workflow

Established 2026-11-24 by executing [the meta-plan](meta-proof-plan.md).
The mathematical roadmap remains [proof-plan.md](proof-plan.md); the
[blueprint](proof-blueprint.md) indexes its dependencies and the
[research log](research-log.md) records actual attempts and validation.
This workflow authorizes no additional research, services, or workers.
The user-directed Gemini Carbon review requirement below is the specified review
exception; it does not authorize broader orchestration or additional services.

Use the [meta-plan](meta-proof-plan.md) to evaluate and revise the mathematical
route and this workflow at bounded endpoints. Completed process trials and tool
capabilities are recorded in their [handoff](b2-improvements-handoff.md), with
the [B3 process adoption](b3-process-improvements-handoff.md) recording later changes.

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

## Records and project memory

| Record | Responsibility |
| --- | --- |
| [Meta-plan](meta-proof-plan.md) | Strategy for monitoring, evaluating and revising the proof plan and proving process. |
| [Proof plan](proof-plan.md) | Sole mathematical roadmap and exact milestone contracts. |
| [Blueprint](proof-blueprint.md) | Declaration/dependency/status index retaining every unproved hypothesis. |
| This workflow | Operational implementation and verification sequence. |
| [Research log](research-log.md) | Concise dated outcomes linked to validation/review evidence. |
| [Handoffs](handoff-template.md) | Restart baseline, contracts, pitfalls, and acceptance evidence as dated snapshots. |
| Review reports (or a handoff's review section) | Exact review scope, evidence limits and every finding's disposition. |
| [Retrospectives](retrospectives/) | Dated lessons and proposed improvements; adoption is recorded separately. |
| [README](../README.md) and [session entry point](proof-attempt-session-prompt.md) | Short orientation and authoritative links. |
| [Session prompts](session-prompts.md) | One current execution prompt; archived prompts remain historical. |

Use the existing log and handoffs as project memory; do not create a competing
status ledger. Any agent-managed memory should hold stable preferences and
pointers only. Verify branch state, audit counts, and next tasks from the actual
checkout. Memory never overrides explicit user instructions. No global memory
or configuration is changed by this convention.

Keep dated snapshots intact, including their then-current next-task proposals.
Update authoritative records when facts change, and link from orientation pages
instead of repeating mutable status prose. Retain all hypotheses when shortening
conditional-result summaries. New handoffs use the linked template; process-only
milestones explicitly say that theorem contracts and indices are unchanged.
Keep any prompt-required `PROGRESS.md` to a short pointer to those records.
Do not copy their inventories, review findings or acceptance receipts into it.

Before a context handoff or actual interruption, record the exact open target,
the latest learning, failed approaches with reasons, the next investigable
question and its proposed bounded check, and any pending tool/review handle.
State why work is interrupted; an exhausted agent-chosen cycle is a checkpoint,
not a session stopping condition. After compaction or resumption, read these
pointers and the live checkout, then continue the already authorized objective.
Do not treat a status question, correction or process improvement as cancellation
unless the user says so. Historical stopping proposals yield to current user
instructions and the [persistence protocol](meta-proof-plan.md#persistence-and-stopping-conditions).

Keep lightweight continuation notes during the work. If a real interruption or
exhausted review recovery prevents validation/review, leave those notes
uncommitted in the working tree and report their unreviewed state; resume the
required checks before committing. A desire to finalize a clean partial handoff
is not itself a reason to terminate research early. This permits preserving
work, not accepting or committing unreviewed results.

## Read and coordinate by dependency

Locate relevant headings with `rg` before reading long documents. Read bounded
sections to answer the next question, plus the required instructions and review
guides in full. Retrieve only the tool signature needed next. If output is
truncated, narrow the read; do not repeatedly request the same broad dump.
Keep one compact acceptance checklist with evidence pointers in the task notes
or handoff, rather than creating another status document.

When delegation is authorized, assign distinct scratch-file ownership and ask
each worker to deliver a final immutable path, exact declaration names/types,
verification command and result, and an explicit completion signal. The parent
integrates only after that signal and checks the result through the intended
interface. A worker needing a later revision delivers a new path and receipt;
it must not rename or edit a delivered file while the parent consumes it.
The parent owns production edits. This protocol grants no delegation authority.

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

1. Inspect branch, HEAD, index, and working tree; preserve unrelated work.
   State the complete authorized endpoint, exclusions, exact contracts, and
   dependencies before implementation. Complete that milestone through internal
   checkpoints without asking again between authorized steps. Scope extensions
   need authorization. Read current declarations, not remembered names. Follow
   any prompt requirement to update the proof plan before implementation.
2. Choose the proof-feedback route before probing: use native goals/diagnostics
   for project files when available; use `lake env lean` from the repository
   root for `/tmp` probes, which lack the project ancestry required by the LSP.
   Use the shell fallback immediately when that limitation is predictable.
   Corroborate suspicious declaration results with hover and pinned source.
   A warming index, empty result or failed lookup is limited search evidence,
   never proof of theorem nonexistence.

   Search the project, then the pinned Mathlib checkout. For example:

   ```sh
   rg -n 'blockValue_lt|exists_blockValue_eq|block_iff_mem_interval' PiDisjunctivity
   rg -n 'disjunctiv|hexadecimalOrbit|block_iff_mem_interval' .lake/packages/mathlib/Mathlib
   ```

   Inspect complete local signatures, implicit arguments, and side conditions
   with `#check @name` before composing applications. For generated declarations,
   trace the `@[to_additive]` source or use a tested local symbol index. Make
   natural-index equalities explicit before field/ring normalization; check
   subtraction orientation against the actual inequality premise.

   A search exit status of 1 means no matches; it is not a compiler failure or
   proof that no related result exists under another name.
3. Sketch the argument and review it separately for quantifiers, hypotheses,
   boundary cases, circularity, and whether it supplies any new π-specific fact.
   Record conclusions and objections, not a transcript of internal reasoning.
   Before substantial Step 5 formalization, a fresh-session criticism pass is
   recommended, using the statement, candidate proof, and cited sources. This
   is advisory and does not gate exploratory work. It is distinct from the
   required changed-file reviews below and authorizes no additional agents or
   services. The mechanism suggested by Aletheia is not a measured guarantee
   for this project's review process.
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
5. Probe the intended downstream interface through `import PiDisjunctivity`
   early, including definition bodies/equations and full quantified theorem
   types. Build the export chain before the probe; fix visibility or elaboration
   before building dependent layers. Boundary checks must explicitly instantiate
   the theorem being tested; a simplification that bypasses it is not evidence
   for that contract. Prefer explicit types and targeted normalization before
   increasing tactic resource limits.
   Compile an edited module with `lake env lean PiDisjunctivity/OrbitCriteria.lean`.
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
   Where relevant, add a consequence stated in established mathematical objects
   and a downstream application sensitive to index/offset errors. B3's
   `|Real.pi - 47/15| ≤ 8/135` check and B4 probe at recurrence index `n+1`
   are examples in `Test.lean`. Explicitly consume the reviewed theorem and
   retain every unproved premise; a bare type check against an arbitrary
   sequence cannot protect a recurrence-to-orbit offset.
7. For Lean changes, finish with `lake build` and `lake env lean Test.lean`.
   Run `uv run --locked --offline python -m unittest discover -s tests -v` and
   `uv run --locked --offline python tools/check_docs.py` for process-tool or
   documentation changes. Check `git diff --check`, then selected newly added
   files and staged whitespace (`git diff --cached --check`). The documentation
   checker uses tracked files, including staged additions; stage only owned
   paths before the final check. Inspect exit codes: stop finalization on any
   required failure or incomplete review, repair within scope, then rerun
   affected checks.
   When relying on a saved Git command rule, run Git mutations as standalone
   execution calls. Mixing Git and another program in one shell command may
   prevent the approved path from matching. On denial, inspect the applicable
   repository and host rules before concluding permissions changed; do not
   broaden them. Run validation separately and check each result.
   Review definition/signature preservation and dependency/import diffs
   separately. Before committing, inspect the pinned files and reviewed
   definitions explicitly:

   ```sh
   git diff HEAD -- lean-toolchain lakefile.toml lake-manifest.json \
     PiDisjunctivity/Definitions.lean PiDisjunctivity/Conjectures.lean
   ```

   Also review changed theorem signatures and imports outside this file list.
   Before review, read the active README overview, relevant proof-plan status,
   blueprint row, and current prompt together. Reconcile completed versus
   proposed work, recurrence/orbit offsets, and every remaining hypothesis.
   Link to `Test.lean` for the executable inventory instead of copying live
   counts. Valid links do not establish current mathematical status.
   Read bounded source sections and display summaries; retain full review
   captures under the mandatory procedure.
   Obtain the required Gemini Carbon High review of the task-owned milestone
   diff, triage its findings, and rerun affected checks after fixes, following
   the review procedure below.
   Record concise actual outcomes and evidence links in the log, declaration
   status/hypotheses in the blueprint, and restart/acceptance evidence in a
   handoff. Commit only task-owned paths. Inspect the committed result for
   necessity and duplication; validate and review substantive fixes before a
   follow-up commit. Report completed substeps, remaining obligations, commit
   IDs, and publication state. Stop at the authorized endpoint.

Compiler errors and `trace_state` supply file-based feedback. Native LSP tools
have also been tested; the [capability record](b2-tool-evaluation.md#persistent-installation-and-native-host-follow-up)
owns their availability and remaining limits. Preserve the shell fallback.
CI retains the Lean build and axiom audit alongside offline process checks.

## Milestone and intermediate changed-file reviews

The [proof-plan policy](proof-plan.md#changed-file-reviews-with-gemini-carbon)
defines milestone/intermediate review cadence and post-commit necessity review.
Follow the mandatory [Gemini procedure](gemini-review.md) for preparation,
subject-specific adversarial background, literal invocation, capture, terminal
inspection, and bounded recovery. Ask for defects, nonblocking improvements,
and open questions, rather than correctness failures alone. Record the
[disposition of every item](gemini-review.md#response-categories-and-caller-disposition),
including suggestions outside the findings section; report earlier fixes as
well as remaining items. Unresolved acceptance-blocking issues prevent
finalization; useful later work can be explicitly deferred. Use
[process tools](process-tools.md) to prepare evidence and detect incomplete runs;
they do not invoke `agy`, retry, assess mathematical correctness, or replace
human findings triage. Reviewer feedback supplements Lean and statement checks.

## Focused skill compatibility

When adopted, selected external skills supplement this workflow; they do
not replace its contracts or reviews. A failed search, even under two strategies,
is evidence about that search only. Preserve approved conditional B4/P3 results
with their explicit premises. Do not reinterpret them as failed formalizations
of an unconditional theorem. Frozen-manifest approvals, placeholder drafts,
companion installation, remote search, and source-statement changes are not
adopted. The repository headers, pins, trust rules, complete authorized scope,
root probes, checks, and Carbon reviews prevail over skill guidance. Pins, Mathlib-facing imports,
and the no-placeholder/trust prohibitions apply to disposable scratch files too;
these probes do not require production headers, root exports, or Git-staged review.
Use Mathlib-facing imports rather than direct imports of its transitive packages.

Inspect complete skill resources and resolve cross-skill links before activation.
An omitted companion is a documented boundary, not permission to install it.
Preserve upstream notices in external installations and label local adaptations.
Installation or copying alone does not establish discovery or successful use by
the actual host. Record those separately, with exact rollback and a tested shell
fallback in the milestone handoff. Original argument/source skills return scoped
criticism or contracts, never proof certificates or independent review.

## Handling a failed attempt

| Failure class | Required response |
| --- | --- |
| False statement or counterexample | Record the witness and revise the proposed route; preserve reviewed definitions and theorem contracts. |
| Missing mathematics | Name the exact unproved implication and its hypotheses. Reassess that route at its bound, then pursue another bounded investigation under the persistence protocol; tactics cannot supply a missing argument. |
| Missing library infrastructure | Record the searches and smallest supporting lemma needed before implementing a larger API. |
| Syntax, elaboration, type, or tactic error | Inspect the compiler's actual context, check local signatures and imports, and make a focused repair. |
| Resource or environment limit | Record the failing command and limit; do not classify it as mathematical evidence. |

Repetition without new evidence calls for a recorded obstruction and a change
of approach within the authorized milestone. Use a handoff when actually
interrupted; do not end research merely because a cycle was unsuccessful.
Unproved claims stay in Markdown, never as Lean axioms
or placeholder proofs. Almost-everywhere density, finite digit checks, BBP
extraction, and shrinking errors cannot be promoted to π-specific visitation.
Conditional claims keep their hypotheses in the graph.
For missing mathematics, use the [meta-plan's recovery protocol](meta-proof-plan.md#when-mathematical-progress-stalls)
to seek new representations, model problems and precise connections within the
authorized research scope. It does not turn an infrastructure failure into a
reason to change the mathematical target.

## Automation decision after the pilot — 2026-11-24 snapshot

Local search found the complete supporting API and one scratch compilation
closed the reduction. No diagnostic or search bottleneck justified optional
tooling. Keep this manual loop. Reconsider LSP only for a concrete live-goal
need, and verify it on the unchanged project pins before relying on it.
This pilot did not execute BBP work or Step 5 research. Future work needs its
own bounded scope; the meta-plan's completion does not extend this session.

The [2026-11-25 adoption](meta-proof-plan.md#b1-process-adoption--2026-11-25)
adds only offline checks and evidence utilities for observed documentation and
capture failures. It does not add proof orchestration or change the Lean loop.
