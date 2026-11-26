# Milestone handoff template

Copy this structure into a milestone-specific handoff. Keep it concise and
dated; link evidence instead of copying logs or the whole roadmap. A historical
handoff describes its checkout at that time, not a future authorization.

## Baseline and authorized endpoint

- Date, milestone/substeps, branch, starting commit, and preserved unrelated work.
- Complete authorized endpoint and exclusions; actual completed/partial status.
- Local commit IDs (or a command to identify the handoff's own commit), and
  publication state: local only, pushed, or verified PR URL as applicable.

## Contracts and indexing

- Exact checked theorem types, hypotheses, dependencies, and root visibility.
- Index origin, inclusive/exclusive boundaries, casts/division, convergence,
  and recurrence/orbit offsets where relevant; link the authoritative contract.
- For a process-only milestone, state that mathematical contracts and indices
  are unchanged.

## Acceptance evidence and limitations

- Actual validation commands/results, axiom inspection, and semantic checks.
- Review report link: baseline/hash, model/conversation, attempts and elapsed
  time, capture completeness, findings/disposition, denied or omitted coverage.
- Whole-cycle summary: defects found/fixed/remaining, improvement dispositions,
  open questions, and acceptance-relevant limits. Link to the review report
  owning guide revisions/read evidence and per-item reasons, rather than
  duplicating them; include those details here only if no separate report exists.
  Distinguish caller checks from reviewer-performed verification.
- Post-commit necessity review and any actual follow-up commits.
- For tool evaluations, distinguish installed, configured, protocol-tested, and
  available-and-tested in the actual host; record the source/version, measured
  case benefit and cost, adopt/defer/reject decision, rollback/tested fallback,
  and any exact pending activation step.
- Explicit limitations: checks not run, unavailable tooling, incomplete review,
  temporary capture retention, remote CI or clean-environment status.

## Restart and remaining obligations

- All remaining obligations and unproved hypotheses, including conditional ones.
- Implementation pitfalls and repairs; distinguish compiler errors from missing
  mathematics. Interface failures, compiler repairs, review attempts/time,
  capture gaps, and stale-entry incidents may be short measured counts or
  "not measured" with evidence links. Do not invent historical measurements.
- Link [the current session entry point](proof-attempt-session-prompt.md),
  [proof plan](proof-plan.md), [blueprint](proof-blueprint.md), and supporting
  evidence. Verify checkout state before resuming; do not copy a mutable next
  task into agent memory. Stop at the authorized endpoint.
