# M4 continued research review — 2026-11-26

This records internal research checkpoints after `050e025`, not M4 acceptance.
The user explicitly replaced Carbon with Codex subagents. No Carbon invocation
occurred in these research reviews. The exact unconditional V theorem is still
missing; all new universal arguments under review are paper mathematics.

## Initial intermediate review

Reviewer: `/root/persistence_review`. Baseline:
`050e025aa6d1b4f65fb268add815d388255abebc`. Exact scope: the initial new
`docs/m4-rational-forcing.md`; frozen diff SHA-256
`9d71c8aa74794a84eed735f30811fc4390331dbab7a3340187ccae4bffcfcc72`.
The full response, diff, scope, source extracts and caller receipts are in
`/tmp/pi-m4-rational-forcing-review-20261126/`; `review.md` retains the complete
returned review. The reviewer independently matched hashes and read both guides
in full, the relevant actual declarations, and supplied source passages.

The completed verdict found no defects and no remaining diagnostic questions.
The initially missing Lagarias 5.2–5.3 extracts were supplied and inspected
during the same review; this was evidence completion, not a failed review retry.

| Item | Disposition |
| --- | --- |
| I1: discharge H's nonrational-function premise explicitly | Applied: analyticity and the irrational special value at the rational point `1/16` contradict membership in `Q(z)`. The separate large-base threshold remains unverified. |
| I2: identify the exponential sum and avoid silently targeting normality | Applied: the exact prefix and normalized sum are displayed, including frequency 21 for the rational model; finite-frequency interval testing is distinguished from all-frequency equidistribution. |

The review accepted the diagnostic claims at paper-proof level, not as kernel
results. It distinguished worker/parent checker receipts from its own read-only
inspection. No reviewer build, probe, mutation, service or delegation occurred.
Source review used supplied parsed text, with rendering limits retained.

## Combined checkpoint review

Reviewer `/root/persistence_review` completed the full seven-path checkpoint
against the same baseline. Frozen diff SHA-256:
`4a2ee7c28a231ec0b1be13ee379e125568001601adb26e48c0fc7374f4472a83`.
The scope was this report, `docs/m4-rational-forcing.md`,
`docs/m4-fourier-windows.md`, `docs/m4-auxiliary-products.md`,
`docs/m4-handoff.md`, `docs/proof-blueprint.md`, and `docs/research-log.md`.
The packet `/tmp/pi-m4-continuation-review-20261126/` retains the diff, hashes,
source extracts, caller checks and complete returned response in `review.md`.

**Completed outcome:** no defects, additional improvements or remaining
diagnostic questions. I1 and I2 above were verified as resolved. The supplemental
B&C Corollary 4.9(i) excerpt closed a source-coverage detail during the same
review. No retry or incomplete response was accepted. Both guides were verified
against unchanged copies previously read in full.

The review checked the corrected-denominator quantifiers, PNT's fixed modulus,
the residual's nonzero leading coefficient and domination for both degree signs,
and the limited conclusion of the Fourier comparison. It also checked the
detector sign, logarithmic integral, height/content argument, resultant scaling,
and the loss of pi-specific information in the Bézout identity. All mathematical
and publication boundaries remain explicit. No substantive repair was needed.
Post-review additions are factual completion/validation receipts only.

Guide SHA-256 identities:

- `docs/code-reviews/lean-adversarial-review-prompt.md`:
  `798c3cc974c5296453f510ea9264aa8b5d17c813c8dc217a430de9b68b7d667c`.
- `docs/code-reviews/lean-proof-strategy-and-tooling-review.md`:
  `c4a04d75a297c6ec361d31ab11e465e3c3e74a6c89eb590bddb03d95c243ad3b`.

## Caller validation and limits

The parent inspected and reran all four exact-rational checkers cited in the
three assessments; all exited 0. The Dirichlet scratch specialization compiled
with only `propext`, `Classical.choice`, `Quot.sound`. None of the countermodel,
PNT-based denominator, residual-asymptotic or auxiliary-product arguments is
claimed as a new kernel theorem. Their universal reasoning is presented in the
assessments, separately from finite arithmetic sanity checks.

Baseline Lean `4.37.0-rc1`, `lake build` (7205 jobs), and `lake env lean Test.lean`
passed; production Lean, audits and pinned dependencies have not changed.
Offline process tests (38), documentation checking (74 tracked Markdown files),
working/staged whitespace and protected-source preservation checks passed.
The seven task-owned documentation paths were committed locally as
`052234d83834b898125f0a9f9223572975526576`
(`Record M4 arithmetic and auxiliary-method investigations`). Final staged
whitespace and documentation checks passed after factual review receipts were
added. Post-commit inspection verified the exact seven paths, unchanged
production/pin/audit scope, and preservation of unrelated work. The three
assessments retain distinct arguments and their necessary side conditions;
no unused proof API, tooling, or substantive simplification was found.

The follow-up factual receipt is identifiable by
`git log --all --oneline --grep='Record M4 continuation checkpoint receipt'`.
No push or PR was performed. This checkpoint does not end the ongoing research.

## Generating-function and phase checkpoint

The next review baseline is `7b73048c1671cb598d33f917ae8e04bcf3fbab46`.
Scope: `docs/m4-generating-functions.md`, the appended continuation in
`docs/research-log.md` and `docs/m4-handoff.md`, and this review record.
The mathematical assessment includes a scratch carry interface, natural-boundary
arguments, phase-correction sharpness, and the null-family averaging test.
Production Lean, pins, audits, the V contract and publication scope are unchanged.

Reviewer `/root/generating_review` completed the independent review of frozen
diff SHA-256 `a4f2723eaea0830709a3b344fdab9f4e0d7fef56ed94b81e487f18f59093115b`.
The exact packet and complete response are retained in
`/tmp/pi-m4-generating-review-20261126/`, with the response in `review.md`.
Both guides were read in full and their unchanged hashes verified. The reviewer
independently matched scope and scratch hashes, inspected the supplied primary
source passage and three worker reports, and reconstructed the mathematical
arguments. It performed read-only inspection, without builds, probes, mutations,
services or delegation. No Carbon was used.

**Completed D/I/Q outcome:** no defects, no nonblocking improvements requiring
a change, and no missing evidence blocking this diagnostic checkpoint. There
are no undisposed recommendations. The review explicitly retains the unresolved
V argument, the unformalized analytic/probability claims, caller-only execution
receipts and parsed-text source limitations. No repair or retry was required.

Caller validation passed: the five scratch carry declarations with the permitted
axioms, both exact arithmetic checkers, 38 offline process tests, the 75-file
documentation checker, working/staged whitespace, and unchanged production/pin/
audit scope. Production Lean was not rebuilt for these documentation-only
changes; the successful unchanged baseline and the separate scratch compilation
are distinguished. Post-review changes record these factual outcomes only.
