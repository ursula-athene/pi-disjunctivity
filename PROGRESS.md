# Proof-session continuation pointer

[Current session entry](docs/proof-attempt-session-prompt.md),
[proof plan](docs/proof-plan.md), [blueprint](docs/proof-blueprint.md),
and [research log](docs/research-log.md) own the current scope and evidence.
The [B3 handoff](docs/b3-handoff.md) records the last accepted proof milestone.
The M4 prompt is prepared, not invoked; V remains open. Follow that prompt only
when the user starts it. Verify live checkout state and preserve unrelated work.

During authorized research, keep this file to restart/evidence pointers rather
than a second status ledger. Read the owning records and actual target after
compaction before continuing.
