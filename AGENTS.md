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
on proving the pi disjunctivity conjecture. Follow the current status and
milestones in [the problem formulation](docs/problem-formulation.md).

For Lean changes, run `lake build`, `lake env lean Test.lean`, and
`git diff --check` from this directory. If needed, add `$HOME/.elan/bin` to
`PATH`. Preserve the existing `module`, import, and public-section conventions,
MIT SPDX headers, and enabled linters. Copyright and author attribution must
use only Ursula Athene.

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

## Gemini Carbon code reviews with `agy`

Use Gemini Carbon on **High effort** for the milestone and intermediate reviews
required by [the proof plan](docs/proof-plan.md#changed-file-reviews-with-gemini-carbon),
through the Google Antigravity CLI (`agy`). Select it explicitly with
`--model gemini-4-carbon-high`; `agy models` lists the models available to the
signed-in account. Headless runs use the existing Antigravity login. If needed,
authenticate in an interactive `agy` session first.

Run from the repository root, using the execution tool's working-directory
parameter. Give the reviewer a bounded scope, ask it to read `AGENTS.md`, and
request findings with file/line references and reasoning. Prepare the exact
task-owned diff in the calling session and supply it in the prompt or an
accessible review file. Use `--mode plan`, request read-only file tools only,
and explicitly prohibit file changes and shell/Bash calls: even a read-only
shell action can be denied by the headless reviewer's internal permissions.
For example, replacing the scope/diff placeholders with the actual review input:

```sh
agy --model gemini-4-carbon-high --mode plan --output-format json \
  --print-timeout 10m \
  -p 'Read AGENTS.md using read-only file tools. Review only <scope and supplied diff> and relevant surrounding code. Do not modify files or invoke shell/Bash tools. Report actionable correctness issues with severity, file/line references, and reasoning. State any review limitations; if there are no findings, say so.'
```

Capture stdout and stderr through the execution tool; save captured output in a
separate permitted file-write operation. Do not append shell redirection to the
`agy` invocation; see the persistent-approval instructions below. Inspect the
process exit code and the result fields `status`, `response`, `error`,
`finished_reason`, and `denied_actions` when present. Treat timeouts,
interruptions, errors, and an empty `response` as incomplete reviews, even with
exit code zero and `status: SUCCESS`. Require substantive findings or an explicit
no-findings response; resolve scope-blocking denials or record incomplete coverage.
`--print-timeout 0` waits without a CLI deadline. For live progress, use
`--output-format stream-json`: read the `init` and `step_update` events, then
collect the final `result` event.

Save the returned `conversation_id` and use it for follow-ups, replacing the
placeholder below. Prefer an explicit ID over `--continue` when multiple tasks
may be running:

```sh
agy --model gemini-4-carbon-high --mode plan --output-format json \
  --print-timeout 10m --conversation '<conversation_id>' \
  -p 'Recheck your findings against the supplied fix diff and repository instructions. Use read-only file tools only if needed; do not modify files or invoke shell/Bash tools. Explain any remaining uncertainty.'
```

### Persistent approval for unattended review runs

Use the exact literal command prefix, with these arguments in this order:

```text
agy --model gemini-4-carbon-high --mode plan
```

On this host, the following persistent Codex rule was verified in
`~/.codex/rules/default.rules` on 2026-11-25:

```python
prefix_rule(
    pattern=["agy", "--model", "gemini-4-carbon-high", "--mode", "plan"],
    decision="allow",
)
```

Invoke `agy` directly with literal arguments. Do not wrap it in a script or
another interpreter, reorder the prefix flags, or add shell redirection
(`>`, `2>`, `<`), substitutions, or inline environment assignments. Advanced shell
syntax prevents the simple command-prefix rule from matching. The prior review
runs used output redirection and therefore prompted despite the saved allow rule.
Use the execution tool to capture results and write them separately instead.

This file records the procedure; it does not grant host permissions. Verify the
effective approval on a new host or after configuration changes. A read-only
check of the saved rule is:

```sh
codex execpolicy check --rules /Users/adam/.codex/rules/default.rules --pretty -- \
  agy --model gemini-4-carbon-high --mode plan --output-format json \
  -p 'Review the supplied diff without modifying files.'
```

The check should report `decision: allow`; it does not run a Gemini review.
The path above is specific to this host. Codex loads rules at startup, so the
user should restart Codex after adding or changing a rule. See the
[Codex rules documentation](https://learn.chatgpt.com/docs/agent-configuration/rules).

Use the host's approved execution path for matching commands that need access
outside the sandbox. If no applicable approval exists and the sandbox blocks
the local server, runtime files, or service access, request scoped approval and
record the blocker. Do not broaden rules or disable global approvals without a
user request. Host approval does not grant permissions to Gemini's internal
tools; retain the file-tool-only review procedure above. Do not use
`--dangerously-skip-permissions` for reviews.

Evaluate the findings before applying changes. Gemini feedback does not replace
the required Lean builds, axiom audits, or review of the mathematical statement.
Submitting a task and resuming it with retained context have been tested with
this model; file-editing tasks have not been validated by that test.

See the [Antigravity headless documentation](https://antigravity.google/docs/cli/headless/)
for output formats and conversation continuation.
