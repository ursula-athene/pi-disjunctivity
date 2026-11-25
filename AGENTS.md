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

Recommend Gemini Carbon on **High effort** for code reviews through the Google
Antigravity CLI (`agy`). Select it explicitly with
`--model gemini-4-carbon-high`; `agy models` lists the models available to the
signed-in account. Headless runs use the existing Antigravity login. If needed,
authenticate in an interactive `agy` session first.

Run from the repository root. Give the reviewer a bounded scope, ask it to read
`AGENTS.md`, and request findings with file/line references and reasoning.
Use `--mode plan` for review and explicitly request no file changes or mutating
commands. For example:

```sh
agy --model gemini-4-carbon-high --mode plan --output-format json \
  --print-timeout 10m \
  -p 'Read AGENTS.md, then review the current uncommitted changes and relevant surrounding code. Do not modify files or run mutating commands. Report actionable correctness issues with severity, file/line references, and reasoning. State any review limitations; if there are no findings, say so.'
```

Capture stdout to receive the JSON result; diagnostics go to stderr. Inspect
the process exit code and the result fields `status`, `response`, `error`, and
`finished_reason` when present. Treat timeouts, interruptions, and errors as
incomplete reviews, even if partial text is returned or the process exits zero.
`--print-timeout 0` waits without a CLI deadline. For live progress, use
`--output-format stream-json`: read the `init` and `step_update` events, then
collect the final `result` event.

Save the returned `conversation_id` and use it for follow-ups, replacing the
placeholder below. Prefer an explicit ID over `--continue` when multiple tasks
may be running:

```sh
agy --model gemini-4-carbon-high --mode plan --output-format json \
  --print-timeout 10m --conversation '<conversation_id>' \
  -p 'Recheck your findings against the repository instructions and explain any remaining uncertainty. Do not modify files or run mutating commands.'
```

If the host sandbox blocks `agy` from opening its local server, writing runtime
files, or reaching the service, request scoped execution approval through the
host agent. Do not use `--dangerously-skip-permissions` for reviews.

Evaluate the findings before applying changes. Gemini feedback does not replace
the required Lean builds, axiom audits, or review of the mathematical statement.
Submitting a task and resuming it with retained context have been tested with
this model; file-editing tasks have not been validated by that test.

See the [Antigravity headless documentation](https://antigravity.google/docs/cli/headless/)
for output formats and conversation continuation.
