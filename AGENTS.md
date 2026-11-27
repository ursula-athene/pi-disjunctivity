# Repository instructions

## Lean dependency policy

The formulation must rely on Mathlib as its only direct external Lean library.
Our own Lean definitions, lemmas, and proofs are permitted when they depend only
on Mathlib, Lean's core/standard libraries, and other project modules satisfying
the same rule.

- Do not add other external Lean libraries through Lake, vendoring, or imports.
- Mathlib's own pinned transitive dependencies are part of the permitted Mathlib
  stack. Preserve them as supplied by Mathlib; their presence is not permission
  to add independent library dependencies or direct imports of those packages.
- Keep the Lean and Mathlib `v4.37.0-rc1` pins unless the user explicitly requests
  an upgrade.
- Use kernel-checked proofs. Add no project-specific axioms, `sorry`, `admit`,
  `native_decide` proof bypasses, or unsafe proof shortcuts. The only permitted
  axiom dependencies are `propext`, `Classical.choice`, and `Quot.sound`;
  individual theorems may use fewer. Preserve and extend the guarded audits in
  `Test.lean` when adding reviewed theorems.

See [dependencies and trust](docs/dependencies-and-trust.md) for the rationale,
current dependency inventory, and the distinction between proof checking and
review of the intended problem statement.

## Scope and validation

Complete and review the Lean formulation of the problem before beginning work
on proving the pi disjunctivity conjecture. The completed formulation milestones
are recorded in [the problem formulation](docs/problem-formulation.md); follow
[the proof plan](docs/proof-plan.md) for the subsequent mathematical roadmap and
exact milestone contracts.

For Lean changes, run `lake build`, `lake env lean Test.lean`, and
`git diff --check` from this directory. If needed, add `$HOME/.elan/bin` to
`PATH`. Preserve the existing `module`, import, and public-section conventions,
MIT SPDX headers, and enabled linters. Copyright and author attribution must
use only Ursula Athene.

## Remote publication cadence

The user authorizes regular pushes of reviewed, task-owned commits to the
current branch on its configured remote during active authorized work. Push
at least every 15 minutes, and at a milestone, a result, or the start of a new
research direction. This standing instruction supersedes older no-push wording
for the active work; do not ask for permission again. Follow the
[publication cadence](docs/proof-workflow.md#regular-remote-publication) while
preserving required checks, reviews and unrelated work. Pull-request creation
and force pushes are not authorized by this cadence.

## Pull request creation

Always use the GitHub CLI (`gh pr create`) to create pull requests for this
repository. Do not use GitHub connector or MCP tools to create PRs. For
multiline descriptions, write the body to a temporary file and pass it with
`--body-file` to preserve Markdown formatting.

## Pull request format

Use this format whenever the user requests PR text, including terminal output,
or asks to open a pull request:

- Give the PR a concise, plain-English title describing its subject. When
  printing PR text to the terminal, put the title on the first line, followed
  by a blank line.
- Write the body in GitHub Markdown. Explain at a high level why the changes
  were made and summarize the set of changes. Avoid excessive detail and
  laundry lists of features or commits.
- If concerns remain for future work, list them with concise descriptions.

## Bounded proof research

Use [the proof plan](docs/proof-plan.md) as the mathematical roadmap and
[the proof workflow](docs/proof-workflow.md) for the local feedback loop.
Keep [the blueprint](docs/proof-blueprint.md) and
[research log](docs/research-log.md) aligned with checked declarations and
actual outcomes. State a bounded endpoint before a research cycle, distinguish
compiler failures from missing mathematics, and retain every unproved
hypothesis in status records. A conditional reduction is not a proof of the
π conjecture. Optional tooling must address a demonstrated need and preserve
the dependency and trust policies above.

Save retrospectives in `docs/retrospectives/` using the filename pattern
`retrospective-YYYY-MM-DD-<milestone>.md`, for example
`retrospective-2026-11-25-b1.md`.

### Persistence within an authorized milestone

Treat research-cycle bounds as reassessment checkpoints, not permission to end
the authorized milestone. A failed candidate, exhausted self-selected search
quota, or lack of an immediate proof idea calls for a changed question and
another bounded investigation. Generating and testing new ideas is authorized
research; do not require a breakthrough before resuming. Suspend refuted or
unproductive routes while continuing to pursue the unchanged objective.
Follow the [persistence protocol](docs/meta-proof-plan.md#persistence-and-stopping-conditions).

Keep working without repeated permission requests within the authorized scope.
End research only at the accepted endpoint, an explicit user pause/stop or scope
change, an applicable user/host resource limit, or a genuine external blocker
that leaves no useful authorized independent work. Mathematical difficulty is
not such an external blocker. Respect tool-specific retry limits and all trust,
review, permission and scope rules; persistence does not override them.

At a real interruption, save the exact obstruction, failed approaches and next
investigable question in the existing log/handoff. State the actual reason work
ended and leave the milestone incomplete. On continuation, read those records
and resume the authorized work; a handoff or reviewed obstruction is not an
acceptance result. Do not manufacture activity, repeat failed searches unchanged,
weaken the theorem, or promise that persistence guarantees a proof.

## Authorized milestones and acceptance

Complete the entire authorized milestone through internal checkpoints, including
required intermediate reviews; seek further authorization only for a genuine
scope extension. Read the actual branch and working tree first and preserve
unrelated staged, modified, and untracked work. Do not execute a saved prompt
unless the user invokes it.

Run Git mutations (`git add`, `git commit`, etc.) as standalone execution-tool
calls; run `uv` and other validation separately. Mixed shell commands can miss
the existing Git approval rule. Before reporting a permission blocker, inspect
the applicable repository/host rules and use their approved command shape;
do not change permissions. See the [workflow](docs/proof-workflow.md#minimal-working-feedback-loop).

Probe new definitions and downstream theorem interfaces through the library root
early, before building dependent proof layers. Boundary checks must explicitly
instantiate the theorem they claim to exercise, rather than simplify away the
contract. Follow the [implementation sequence](docs/proof-workflow.md#minimal-working-feedback-loop).

Stop finalization when any required check fails or a required review is incomplete.
This stops acceptance, not useful independent work within the authorized scope.
Inspect actual exit codes and check newly added/staged files before committing.
Report completed milestone/substeps, remaining obligations and hypotheses, and
publication state: local commits, pushed commits, or a verified PR, as applicable.

Use the [document responsibilities and project memory rules](docs/proof-workflow.md#records-and-project-memory)
and [handoff template](docs/handoff-template.md). Verify volatile state from the
checkout; memory is not a second status store.

## Gemini Carbon code reviews with `agy`

**Current user override (2026-11-26): do not use Carbon for reviews.** Use a
separate Codex subagent under the
[replacement-review procedure](docs/gemini-review.md#current-user-directed-reviewer-replacement)
for ongoing M4 work, including the persistence correction. Preserve exact scope,
applicable adversarial guides, read-only review, evidence limits and D/I/Q
dispositions. Carbon-specific commands below remain dormant unless the user
reauthorizes Carbon; this changes the reviewer, not the required review gates.

The full [Gemini review procedure](docs/gemini-review.md) is **mandatory** for
milestone and intermediate reviews required by
[the proof plan](docs/proof-plan.md#changed-file-reviews-with-gemini-carbon).
It preserves Carbon High, exact task-owned diff scope, read-only reviewer file
tools, capture/result inspection, the literal approved command prefix, and
bounded recovery. It supplements kernel checks and mathematical statement review.
Supply the subject-specific adversarial guide required by that procedure:
the Lean proof guide for proof milestones, the strategy/tooling guide for
tooling, proof-strategy, and meta-plan reviews, and both for substantive mixed work. Require
separate defects, nonblocking improvements, and open questions; preserve each
recommendation's disposition and summarize the whole review cycle.

### Progress, timeouts, and bounded retries

Follow the mandatory [progress and bounded recovery procedure](docs/gemini-review.md#progress-timeouts-and-bounded-retries).
This heading is retained for historical incoming links.

### Persistent approval for unattended review runs

Follow the mandatory [literal-prefix and host-approval procedure](docs/gemini-review.md#persistent-approval-for-unattended-review-runs).
This heading is retained for historical incoming links. This guidance grants
no permissions and does not authorize changing host or reviewer permissions.
