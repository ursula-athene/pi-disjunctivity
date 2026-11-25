# Gemini Carbon code reviews with `agy`

Use Gemini Carbon on **High effort** for the milestone and intermediate reviews
required by [the proof plan](proof-plan.md#changed-file-reviews-with-gemini-carbon),
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
agy --model gemini-4-carbon-high --mode plan --output-format stream-json \
  --print-timeout 20m \
  -p 'Read AGENTS.md using read-only file tools. Review only <scope and supplied diff> and relevant surrounding code. Do not modify files or invoke shell/Bash tools. Report actionable correctness issues with severity, file/line references, and reasoning. State any review limitations; if there are no findings, say so.'
```

Capture stdout and stderr through the execution tool; save captured output in a
separate permitted file-write operation. Do not append shell redirection to the
`agy` invocation; see the persistent-approval instructions below. Collect the
terminal `result` event and inspect the process exit code and its result payload
fields `status`, `response`, `error`, `finished_reason`, and `denied_actions` when
present. Treat timeouts,
interruptions, errors, and an empty `response` as incomplete reviews, even with
exit code zero and `status: SUCCESS`. Require substantive findings or an explicit
no-findings response; resolve scope-blocking denials or record incomplete coverage.

Save the returned `conversation_id` and use it for follow-ups, replacing the
placeholder below. Prefer an explicit ID over `--continue` when multiple tasks
may be running:

```sh
agy --model gemini-4-carbon-high --mode plan --output-format stream-json \
  --print-timeout 20m --conversation '<conversation_id>' \
  -p 'Recheck your findings against the supplied fix diff and repository instructions. Use read-only file tools only if needed; do not modify files or invoke shell/Bash tools. Explain any remaining uncertainty.'
```

## Progress, timeouts, and bounded retries

Default to `--output-format stream-json --print-timeout 20m` for initial reviews
and follow-ups. One successful review took about eight minutes twenty seconds;
a later run reached a three-minute deadline without a response. Twenty minutes
is a starting operational limit, not a completion guarantee. Do not use
`--print-timeout 0` for unattended reviews: it removes the CLI deadline without
solving a stall. Let the execution tool yield and retain its running session;
poll that session in waits of at most sixty seconds, rather than treating an
individual tool wait as the review deadline or launching a replacement process.

Capture the stream continuously. Record the invocation start time, the `init`
event's conversation ID/model, and timestamps of meaningful `step_update`
changes: new steps, tool results, text deltas, or available usage updates. Keep
the user informed while waiting. Repeated polls, an unchanged `ACTIVE` state,
or a live client process do not demonstrate model progress. Silence can mean
hidden reasoning or a service wait; record an unknown or suspected stall unless
there is stronger evidence. In `json` mode, output arrives only at completion,
so silence alone says even less. Record per-invocation wall time from caller or
log timestamps; duration/usage counters on resumed conversations can be cumulative.

After a timeout or failure, inspect captured events, stderr, and the relevant
CLI log before retrying. Distinguish permission denials, explicit service errors,
and a deadline reached without a known cause. `print_timeout` establishes that
the CLI deadline expired, not that the model hung. Resolve an identified cause
within existing authorization, or narrow the supplied review scope, and make
at most **one focused recovery attempt per failed review**, retaining the explicit
conversation ID and context when available. Verify the previous invocation has
ended and check any reported active-turn state before resuming; do not create
overlapping review runs. Record both attempts and any coverage omitted by a
narrower retry. If recovery also fails, record the incomplete review and tooling
obstacle; do not retry indefinitely, lower effort, switch models, bypass
permissions, or claim completion. This recovery limit does not replace the
focused follow-up review of substantive fixes after a completed review.

## Persistent approval for unattended review runs

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
  agy --model gemini-4-carbon-high --mode plan --output-format stream-json \
  --print-timeout 20m \
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

## Evidence utilities and retention

Use the [process tools](process-tools.md) to prepare an explicitly scoped
index diff with baseline/hash and to inspect separately saved execution chunks.
They do not invoke `agy` or automate retries; the literal command above stays
outside scripts. Request adequate tool capture budgets (recent local runs used
50,000 tokens initially and 60,000 per poll), save full results separately, and
display concise summaries. Mark any truncation or missing capture explicitly.

Capture completeness, terminal review completion, and the caller's assessment
of correctness are distinct. Utility exit zero is only a candidate for human
acceptance; inspect the response, coverage, diagnostics, and findings yourself.
“No findings” is not proof. Record actual capture locations and retention limits
in the review report. Temporary files and saved conversation IDs are not durable
archives; loss of context must be recorded, not assumed away.
