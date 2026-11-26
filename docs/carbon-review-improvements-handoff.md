# Carbon review guidance handoff — 2026-11-25

## Baseline and authorized endpoint

Baseline `02c89a3b04ebf629d90ccfc5f694c923c6a8edcc` on
`feature/attempt-07-b2-orbit`. The user authorized incorporating the two new
adversarial review guides and the preceding review/reporting recommendations
into repository documentation, then committing and summarizing the changes.
The guides were already committed by the user; their substantive review
approaches are retained with Carbon-specific scope and reporting adapters.

Preserve unrelated Obsidian workspace/hotkey changes, personal notes, and
papers. This is the review-guidance subset of P1, not execution of the full
B2 improvement prompt. No tooling installation, proof work, or B3 is included.

## Contracts and indexing

All Lean definitions, proofs, theorem contracts, indices, imports, audits, and
dependency pins are unchanged. B2 is complete; B3, V, Hπ, T, and π disjunctivity
remain open. B4 retains vanishing-error and arbitrarily-late-visit premises;
P3 retains open-interval visitation. Carbon remains High, read-only, and
file-tool-only under the existing scope, capture, and recovery requirements.

## Acceptance evidence and limitations

The [review report](agy-reports/carbon-review-improvements-review.md) records
the selected guides, exact scope/hash, categorized items and dispositions,
capture inspection, and caller validation. All 23 process tests and the initial
52-file documentation check passed. Initial Carbon feedback found no defects,
five improvements, and two questions. The five improvements were implemented
and verified in the single focused recovery. It restored full diff coverage
after the initial malformed terminal capture; the recovery inspector passed.
Q1's receipts are recorded; effectiveness/cost observation Q2 and new template
improvement I6 are deferred with active-plan pointers. The report preserves
both runs, diagnostics, guide hashes, and all item dispositions. Final receipt
and deferral updates passed the doc and whitespace checks. No Lean build or installed
tool evaluation is claimed. Review effectiveness has not been measured.

## Restart and remaining obligations

Use the [Carbon procedure](gemini-review.md) for guide routing and the
response/disposition contract. Review the full cycle, including improvements
and earlier fixes; do not infer their absence from a final clean verdict.
The [B2 improvement plan](b2-process-tool-improvement-plan.md) records the
adopted subset, deferred I6 (`--log-file` template integration), and remaining
proposed work; the [meta-plan evaluation](meta-proof-plan.md#lightweight-evaluation)
keeps Q2 visible for later reviews. Invoke the
[current prompt](proof-attempt-session-prompt.md) only on the user's instruction.

## Publication and post-commit necessity review

Implementation commit: `f17a625de779df343e177afb86d75a3fdad53926`, local only.
Post-commit inspection confirmed exactly the 13 task-owned Markdown files;
unrelated Obsidian workspace/hotkeys, notes, and papers remain untouched.
No push or PR was requested or performed.

The necessity review retained the canonical procedure, subject-specific guide
adapters, short policy/template cross-references, scoped adoption/deferral
records, and review evidence. Each supports routing, acceptance, or the next
session; no further substantive change or removable implementation was found.
This receipt-only update records the observed commit and necessity review.
Identify its commit with
`git log -1 --format=%H -- docs/carbon-review-improvements-handoff.md`.
