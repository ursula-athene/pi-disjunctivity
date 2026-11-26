# Gemini Carbon code reviews with `agy`

Use Gemini Carbon on **High effort** for the milestone and intermediate reviews
required by [the proof plan](proof-plan.md#changed-file-reviews-with-gemini-carbon),
through the Google Antigravity CLI (`agy`). Select it explicitly with
`--model gemini-4-carbon-high`; `agy models` lists the models available to the
signed-in account. Headless runs use the existing Antigravity login. If needed,
authenticate in an interactive `agy` session first.

## Select the adversarial review background

Supply the appropriate guide **in addition to** `AGENTS.md`, this procedure,
the exact task-owned diff, and relevant surrounding context. Explicitly ask
Carbon to read the selected document; a link in an unrelated file is not enough.

| Review subject | Required background |
| --- | --- |
| Lean proof milestones, including formulation, theorem contracts, proofs, audits, and their claimed mathematical progress | [Adversarial Lean proof review](code-reviews/lean-adversarial-review-prompt.md) |
| Tooling, skills, engineering workflow, proof-strategy proposals, and meta-proof-plan reviews | [Proof strategy and tooling review](code-reviews/lean-proof-strategy-and-tooling-review.md) |
| A milestone with substantive changes in both areas | Both guides, identifying which parts of the diff each informs |

Ordinary status documentation accompanying a proof milestone does not by itself
make the review mixed. Review-procedure changes use the strategy/tooling guide.
Documentation-only mathematical route or argument reviews, including source-proof
assessments and M4 proof sketches, use both guides even before Lean code exists.
Apply each guide to the supplied scope; background material does not authorize
reviewing or implementing an unrelated milestone, solving an open conjecture,
changing dependencies, or expanding tool permissions.

The guides describe possible builds, probes, and experiments. **Carbon remains
read-only and file-tool-only under this procedure:** it must not run shell/Bash,
write a temporary example, execute Lean, install tools, or modify files. It may
inspect supplied outputs and propose the smallest check needed. The caller runs
authorized checks and returns the exact commands, results, and relevant source
revision; Carbon distinguishes these receipts from checks it independently
performed. Untested examples and repairs must remain explicitly untested, with
no prohibited proof shortcuts. Missing evidence stays a verification limit.

Record the selected guide paths and revisions or content hashes in the review
report, and verify they were read or supplied in full. If a required guide is
unavailable, the review is incomplete until its coverage is restored under the
bounded-recovery procedure. Follow-ups name the applicable guides and retain
the needed context; a saved conversation ID alone does not establish continuity.

## Prepare a neutral, self-contained review request

Supply the baseline, exact diff/hash and file list, intended claims/contracts,
scope exclusions, relevant API/source locations, and prior items needing
recheck. Present caller checks as evidence with their limits, separately from
the author's interpretation. Do not ask Carbon merely to confirm that the
change is correct or compliant, or treat a previous no-findings verdict as an
endorsement it must preserve. Passing builds constrain some failure modes;
they do not settle mathematical meaning, strategy, or engineering value.

Ask Carbon to reconstruct the intended claim, challenge the weakest-supported
implication, and consider what could be simplified, removed, or tested more
convincingly. For tooling, compare the proposal with the existing workflow and
the simplest credible alternative, including setup and maintenance cost.
Concrete improvements to correct work are welcome. Apply the same scrutiny to
objections and proposed repairs; do not manufacture criticism or impose a quota.
Adjacent opportunities may be reported as out of scope without executing them.

Run from the repository root, using the execution tool's working-directory
parameter. Give the reviewer a bounded scope, ask it to read `AGENTS.md`, and
request categorized findings with file/line references and reasoning. Prepare
the exact task-owned diff in the calling session and supply it in the prompt or an
accessible review file. Prefer the exact diff and relevant evidence inline when
temporary, user-config, or sibling paths are outside reviewer workspace access.
Never retry a denied file through another tool or change reviewer permissions.
A continuation ID is only an optimization; resupply the needed context.
Give each checkpoint one precise review question and the relevant signatures
and concise caller receipts. Keep the full required diff and guides, but link
to existing evidence instead of repeating file inventories and status history.
Request a short verdict with material D/I/Q evidence and coverage limits; a
shorter response must not omit a category or required scope.
Use `--mode plan`, request read-only file tools only,
and explicitly prohibit file changes and shell/Bash calls: even a read-only
shell action can be denied by the headless reviewer's internal permissions.
For example, replacing the scope/diff placeholders with the actual review input:

```sh
agy --model gemini-4-carbon-high --mode plan --output-format stream-json \
  --print-timeout 20m --log-file /tmp/pi-MILESTONE-initial-cli.log \
  -p 'Read AGENTS.md, docs/gemini-review.md, and <required adversarial guide paths> using read-only file tools. Review <scope, baseline, exact diff/hash, intended claims, and supplied evidence>. Apply the guides within this scope; do not modify files or invoke shell/Bash tools. Give periodic progress updates at meaningful inspection boundaries and before long analysis; say what is complete, what is next, and any blocker. Do not split useful work solely to simulate a timed heartbeat. Independently assess the claims and weakest-supported step. Return a brief verdict, then separate defects, nonblocking improvements, and open questions or missing evidence, followed by coverage and limitations including guides used and reviewer checks versus caller receipts. Give each item an ID, location, evidence, consequence or benefit, and concrete repair or smallest investigation; label untested proposals and scope extensions. Each category may be empty. Do not equate passing caller checks or prior review approval with correctness. <exact diff or accessible review packet>'
```

Use a unique permitted `--log-file` path for each invocation. Keep that CLI
log alongside the raw execution chunks; inspect both before accepting a result
or diagnosing a failure. Log separation kept terminal JSON intact in the
review-guidance recovery, but does not guarantee suppression of every stderr
message or repair denied conversation/auth/cache persistence. Never edit raw
chunks to make an inspection pass.

Capture stdout and stderr through the execution tool; save captured output in a
separate permitted file-write operation. Do not append shell redirection to the
`agy` invocation; see the persistent-approval instructions below. Collect the
terminal `result` event and inspect the process exit code and its result payload
fields `status`, `response`, `error`, `finished_reason`, and `denied_actions` when
present. Treat timeouts,
interruptions, errors, and an empty `response` as incomplete reviews, even with
exit code zero and `status: SUCCESS`. Require substantive category responses,
including explicit no-items statements where appropriate; resolve scope-blocking
denials or record incomplete coverage. A bare no-findings verdict without the
requested coverage and categories is insufficient for acceptance. Missing
required guides or categories uses the same single bounded-recovery allowance
as other incomplete reviews, even when the terminal status says SUCCESS.

Save the returned `conversation_id` and use it for follow-ups, replacing the
placeholder below. Prefer an explicit ID over `--continue` when multiple tasks
may be running:

```sh
agy --model gemini-4-carbon-high --mode plan --output-format stream-json \
  --print-timeout 20m --log-file /tmp/pi-MILESTONE-followup-cli.log \
  --conversation '<conversation_id>' \
  -p 'Read and apply AGENTS.md, docs/gemini-review.md, and <applicable adversarial guide paths> using read-only file tools; do not assume a resumed conversation retained them. Recheck <prior item IDs and dispositions> against <exact fix diff, baseline/hash, and evidence>. Do not modify files or invoke shell/Bash tools. Give periodic progress updates at meaningful inspection boundaries and before long analysis; identify any blocker. Do not split useful work solely to simulate a timed heartbeat. Report resolved, remaining, and new items separately as defects, nonblocking improvements, and open questions. Preserve earlier suggestions in the review history and state coverage and uncertainty, including guides used and reviewer checks versus caller receipts.'
```

## Response categories and caller disposition

After the guide's brief mathematical or strategic verdict, require these
separate categories, each explicitly empty when appropriate:

1. **Defects:** supported correctness, mathematical-meaning, trust, status,
   or consequential design failures. State severity and the affected claim.
2. **Nonblocking improvements:** concrete simplifications, stronger tests,
   better interfaces, workflow/tool opportunities, or documentation repairs
   with a stated benefit even when current behavior is correct. Identify cost
   or tradeoffs when material. Nonblocking does not mean nonactionable.
3. **Open questions or missing evidence:** unresolved uncertainties, the
   smallest check that would resolve them, and which conclusion depends on it.
   Do not present an unverified suspicion as a confirmed defect.

Use stable item IDs such as D1/I1/Q1. For each item give its location, evidence
and reasoning, consequence or benefit, proposed change/investigation, and scope
(current task or possible later work). Distinguish confidence in the finding
from confidence in an untested repair. A necessary fix without a known repair
is still a finding. Keep the guide's useful obligation tables and investment
decisions proportional to the task, rather than repeating the entire roadmap.
Close with scope examined, guides used, actual checks versus caller receipts,
and limitations. Positive coverage notes are not improvement suggestions.
Use the shortest response that supports the assessment; do not repeat supplied
instructions, the full scope inventory, or unrelated roadmap history.

The caller must inspect the **whole response**, including suggestions in
coverage or limitation paragraphs. Record every distinct recommendation or
question in the existing milestone review report, with its original category
and one of these dispositions:

| Disposition | Required record |
| --- | --- |
| Implemented | Change/evidence location and the affected validation or follow-up result |
| Deferred | Reason and reconsideration trigger in the report; for a later milestone, also a short pointer in its active plan, or in the restart handoff for the immediately next session |
| Declined | Specific reasoning or counterevidence; preserve the original recommendation |
| Unresolved | Missing evidence or decision, next check, and whether it blocks acceptance |

Use these records instead of a new status ledger. Merge duplicate items by
cross-reference. Report-only deferral is sufficient within the same milestone;
cross-milestone pointers make later work discoverable without duplicating its
full record. Update or remove the pointer when resolved. If the caller changes
a category or severity, preserve the
reviewer's original assessment and explain the change. "Out of scope" explains
deferral, not why an item disappears. Evaluate recommendations independently:
reviewer advice is not permission to expand the authorized task.

Do not finalize with a confirmed defect or unresolved question that undermines
the required acceptance claim. Deferral cannot waive a required check, review,
trust rule, or missing mathematical obligation. Obtain focused Carbon follow-up
for substantive fixes as required by the proof plan; retain the existing
bounded recovery rules for failed invocations.

Summarize the **review cycle**, not just its final clean snapshot. Separate
defects found/fixed/remaining, improvement dispositions, and unresolved questions.
For example: "One defect fixed; one improvement implemented; one improvement
deferred; no acceptance-blocking questions remain." Use "no remaining defects"
when earlier issues were corrected; do not turn that into "no findings."
If all three categories are empty, say so and retain the verification limits.
Neither a low finding count nor a second model establishes review effectiveness;
no detection-rate or productivity claim is warranted without an evaluation.

## Progress, timeouts, and bounded retries

Ask Carbon for periodic short updates at meaningful inspection boundaries and
before long analysis: completed work, next step, and any blocker. These are
useful observations, not timed heartbeats; do not split work just to emit them.
B3 had analysis intervals longer than two minutes without updates. Caller
polling provides the regular clock; silence alone never justifies a restart.

Default to `--output-format stream-json --print-timeout 20m` for initial reviews
and follow-ups. One successful review took about eight minutes twenty seconds;
a later run reached a three-minute deadline without a response. Twenty minutes
is a starting operational limit, not a completion guarantee. Do not use
`--print-timeout 0` for unattended reviews: it removes the CLI deadline without
solving a stall. Let the execution tool yield and retain its running session;
poll that session in waits of at most sixty seconds, rather than treating an
individual tool wait as the review deadline or launching a replacement process.
Generally poll every 30–60 seconds; avoid repeated short polls with no new
information. Display concise summaries while retaining complete raw captures.

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
  --print-timeout 20m --log-file /tmp/pi-MILESTONE-initial-cli.log \
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

Keep the durable receipt compact: baseline/diff hash and scope, model and
conversation, per-invocation wall time, capture completeness/inspector result,
CLI-log outcome, guide paths with their reviewed revision, and D/I/Q dispositions.
An unchanged tracked guide may use the baseline revision; use a content hash
for uncommitted guide edits. Keep the raw capture paths and retention limits.
Detailed event timestamps and token budgets stay in the raw captures/inspection
report. Summarize them in Markdown only when an anomaly, retry or explicit
evaluation makes them material. Always capture and inspect them; this reduces
transcription, not verification or required scope.

Use the [process tools](process-tools.md) to prepare an explicitly scoped
index diff with baseline/hash and to inspect separately saved execution chunks.
They do not invoke `agy` or automate retries; the literal command above stays
outside scripts. Request adequate tool capture budgets (recent local runs used
50,000 tokens initially and 60,000 per poll), save full results separately, and
display concise summaries. Mark any truncation or missing capture explicitly.

Capture completeness, terminal review completion, and the caller's assessment
of correctness are distinct. Utility exit zero is only a candidate for human
acceptance; inspect the response, coverage, diagnostics, and findings yourself.
Apply the category/disposition requirements above even when the utility passes;
it does not judge recommendation quality or validate the review's output format.
“No findings” is not proof. Record actual capture and per-invocation CLI-log locations and retention limits
in the review report. Inspect the separate log for authentication, permission,
service, and persistence failures as well as the JSON result. Retain diagnostics
with the same lifetime as the raw captures; summarize consequential messages
in the durable report without copying credentials or unrelated host details. Temporary files and saved conversation IDs are not durable
archives; loss of context must be recorded, not assumed away.

Distinguish runtime persistence errors from reviewer tool denials and failed
reviews. If conversation save/resume fails, report the affected paths and the
effective sandbox constraint; preserve captures and resupply full context.
After an authorized environment fix, a short two-invocation save/recall test
can check persistence without rerunning a completed review. The second prompt
must not repeat the marker; check the same conversation ID, actual exits and
both logs. This establishes save/resume only for that test, not durable storage
or future availability. It is not a required preflight for every review and
does not authorize permission changes or bypasses.
