# Offline process tools

These tools prepare/check evidence; they do not invoke `agy`, retry reviews,
change permissions, or assess proof correctness. Follow the mandatory
[Gemini procedure](gemini-review.md) and [workflow](proof-workflow.md).

## Setup and checks

The repository root is a `uv` project. Install its locked Python dependencies
once with `uv sync --locked`, then run offline:

```sh
uv run --locked --offline python -m unittest discover -s tests -v
uv run --locked --offline python tools/check_docs.py
```

In a restricted environment, `uv --no-cache run ...` uses temporary cache storage
without changing global configuration. The checks themselves use no network.
CI installs Python/dependencies first, then runs both offline commands in a
separate job, preserving the existing Lean build and axiom audit.
[setup-uv](https://github.com/astral-sh/setup-uv) is pinned to a release commit.

The Python-only dependencies are `markdown-it-py` (Markdown parsing), its
transitive `mdurl`, and PyYAML (CI structure tests), all MIT licensed according
to installed package metadata. They are locked in `uv.lock`; they introduce no
Lean dependency or import. Markdown parsing uses the
[documented token API](https://markdown-it-py.readthedocs.io/en/latest/using.html).

## Documentation scope and active entries

`tools/check_docs.py` reads Git-tracked Markdown, including staged additions,
from the working tree. Stage explicitly owned new documents before the final
check. Untracked personal notes/papers are excluded. It verifies local file
targets, Markdown heading/explicit HTML anchors, exactly one level-2 Current
prompt in `docs/session-prompts.md`, and explicitly marked active links.

README and the session entry point must each have exactly one marked link.
Other maintained documents may mark their current-entry link too. Put the
marker immediately before the link within a paragraph, on the same line:

```markdown
Next session: <!-- current-prompt --> [Current prompt](session-prompts.md#current-prompt-b2-complete-orbit-bridge)
```

Marked links must target the actual current section, not a bare file or an
archived but valid anchor. Ordinary links to archived instructions remain valid
historical references. Markdown reference links and fenced examples are parsed,
not classified with blanket searches for old milestone names. The checker is
not a general website crawler: remote URLs, generated Lean API anchors, raw
HTML hyperlinks, and a full GitHub renderer are outside its scope. Heading IDs
support the repository's heading vocabulary and duplicate-heading suffixes.
Dated review reports may cite source lines (`#L…`) from their reviewed snapshot;
these are not current heading IDs and their historical line numbers are not
revalidated. One named exception preserves the literature review's links into
its then-inspected sibling `deepmind-formal-conjectures` checkout. All other
out-of-checkout relative links fail. These exceptions still check in-repository
target existence and cannot satisfy an active entry marker.
Fixtures exercise stale valid anchors, missing targets/anchors, multiple current
sections, valid history, and reference links/fences.

## Prepare an explicitly scoped review

Stage only the owned changes and inspect the index first. The helper never
stages files and rejects unstaged/untracked scope, directories, nonexistent or
unchanged paths. Unrelated staged files are excluded by the explicit file list.
Keep `git add` separate from `uv` checks when using a saved Git approval rule;
a mixed shell command may not match that rule. No permission change is needed
when the existing approved execution path suffices.
Use a new temporary output directory; existing captures are never overwritten:

```sh
uv run --locked --offline python tools/prepare_review.py \
  --baseline BASELINE_COMMIT --output /tmp/pi-MILESTONE-review \
  AGENTS.md docs/proof-workflow.md
```

Replace the baseline and paths with the actual review scope. The output contains
`diff.patch` (index versus resolved baseline, including new/deleted files) and
`scope.json` (baseline, HEAD, exact path list, SHA-256, bytes, preparation time).
Check the scope and hash again if files change. This is file-level selection:
split mixed-ownership edits deliberately before preparing; the helper cannot
infer ownership of hunks. Capture files belong outside the scoped diff.

Supply that exact diff inline in the literal `agy` command or in a reviewer-readable
file, together with baseline/hash/scope and the review question. Keep the actual
invocation outside scripts/wrappers, as prescribed in the Gemini procedure.
The helper does not execute a command or grant authorization.

## Save and inspect review capture

Request an adequate execution-tool output budget (the recent local runs used
50,000 tokens initially and 60,000 per poll). Save the full returned object after
each call using a separate permitted file-write operation; display only concise
summaries. A display budget and an execution capture budget are distinct.
Wait at most sixty seconds per poll and record meaningful event changes.

Save one JSON file per execution-tool chunk, in order, including stdout/stderr
as returned in `output`, `original_token_count`, and the observed `exit_code`
on the final chunk. Add these caller fields without altering the raw output:

```json
{
  "sequence": 0,
  "started_at": "2026-11-25T00:00:00Z",
  "captured_at": "2026-11-25T00:00:01Z",
  "requested_max_tokens": 50000,
  "original_token_count": 100,
  "output": "...full execution output...",
  "exit_code": 0
}
```

`sequence` starts at zero; `started_at` is required on the first chunk. Preserve
session/chunk identifiers and all other returned fields too. Do not fabricate
an exit for a running process. If the transport truncates, preserve that fact
(`truncated: true`) and any warning; a surviving terminal response does not
restore the missing intermediate stream. Then inspect, for example:

```sh
uv run --locked --offline python tools/inspect_review.py \
  /tmp/pi-MILESTONE-capture-000.json /tmp/pi-MILESTONE-capture-001.json \
  --attest-complete --report /tmp/pi-MILESTONE-inspection.json
```

Use `--attest-complete` only after checking every execution chunk was saved
losslessly. Missing output cannot always be detected from the surviving files.
Without attestation, completeness is unverified. The report retains the full
terminal result (`status`, `response`, `error`, `finished_reason`,
`denied_actions` when present), init/model/conversation, errors, denials,
diagnostics, and progress observations. It checks sequence, budget/truncation,
JSON events, terminal result, and observed exit. Startup stderr is retained
for human inspection: persistence/auth initialization messages need not mean
that the review itself failed. Missing or malformed events fail conservatively.

Exit zero means only **candidate for human acceptance**: transport checks passed,
the process exited zero and the response is nonempty SUCCESS without detected
errors/denials. The caller must still require substantive findings or explicit
no-findings, assess coverage and all diagnostics, and evaluate correctness.
An arbitrary nonempty response is not sufficient; “no findings” is not proof.
Unresolved denials, unknown termination reasons, errors/timeouts, missing results,
or capture gaps fail the utility. This never authorizes automatic recovery;
use the mandatory bounded-recovery procedure after investigation.

## Retention

Raw prompts, diffs, chunk JSON, and full inspection reports normally live in
milestone-specific `/tmp/pi-...` paths. Record the actual locations, invocation
timestamps, hash, conversation, findings/disposition, capture gaps, and review
limitations in `docs/agy-reports/` and link from the handoff/log. Temporary
files may disappear and persisted conversations may be unavailable; neither is
guaranteed archival storage. Commit concise evidence summaries, not large raw
streams. If durable raw retention is needed, choose an explicitly authorized
destination; do not silently upload captures or create a new service.
