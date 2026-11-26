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

The generating/phase checkpoint was committed locally as
`9b6ca1b63f21be4f57ff195a36effa09255384c0`. Post-commit inspection verified its
four documentation paths, unchanged protected sources and preserved unrelated
work. No unused API, tool change or substantive simplification was found.

## Logarithmic-constraint intermediate review

Reviewer `/root/generating_review` completed a separate intermediate review of
the initial `docs/m4-logarithmic-constraints.md`, baseline
`9b6ca1b63f21be4f57ff195a36effa09255384c0`, frozen diff SHA-256
`9fc35cf67dc5208d2f86836c1c343e72b864c3e375f686b23d2ab21e6e032819`.
The packet and complete response are retained in
`/tmp/pi-m4-logarithmic-initial-review-20261126/`, response `review.md`.
Both required guides were applied with their unchanged hashes above. The
reviewer independently reconstructed the four-/eight-pole kernel arguments and
the Bernoulli-dimension counterexample, and inspected supplied source images.

**D/I/Q outcome:** no defects or remaining diagnostic questions; one improvement:
I1 requested that the local exclusion of the zero polynomial be distinguished
from Breuillard–Varjú's implicit source convention. Applied in the source-contract
paragraph, after parent comparison with printed pp.2–3. The requested definition
pages were supplied during the same review, without a failed-review retry.
No recommendation was dropped or deferred. Combined checkpoint review remains
pending as the next mathematical investigations are integrated.

Execution remains caller evidence: the four-pole, eight-pole and Bernoulli exact
checkers were inspected and rerun successfully. External source theorems and
universal analytic arguments remain paper mathematics. The reviewer used only
read-only inspection, with no execution, mutations, services, Carbon or delegation.

## Arithmetic-cost combined review

Reviewer `/root/generating_review` completed the six-path review against
`9b6ca1b63f21be4f57ff195a36effa09255384c0`. The frozen diff SHA-256 is
`30649da07ee39234c3dabbf60d88e7080cf1eac45269bb5eac7e1cdaa91baee7`.
The packet `/tmp/pi-m4-arithmetic-cost-review-20261126/` retains `scope.json`,
`diff.patch`, source/report hashes, caller receipts and the full `review.md`.
Scope: the logarithmic and approximation assessments, Fourier extension,
research log, M4 handoff and this review record. Both required guides were
applied with the unchanged hashes recorded above.

The reviewer reconstructed the four-/eight-pole, polynomial interpolation,
holonomy, dihedral primitive-denominator, multibase and all-order tail
arguments and inspected relevant primary source images. It used read-only
inspection without executing checks, mutations, services, Carbon or delegation.

**Whole-cycle D/I/Q dispositions:** no defects or blocking questions. I1
verified the already applied source-notation clarification. I2 requested
explicit rational BBP recurrence samples and weights for the finite empirical
transform claim; applied, with the real/circle distinction retained. Parent
inspection of `Series.lean` and `Orbit.lean` confirms the rational-arithmetic
induction. I3 requested that the completed dihedral test leave the active
handoff list; applied. No recommendation was omitted or deferred.

The focused I2/I3 follow-up inspected exact two-path delta SHA-256
`941eae27dcb22f6aae3e1e0ec19294eb55504d0af726e7a61a3bee1b2ca690cd`,
retained as `clarification.patch`. Its full `clarification-review.md` resolves
both items with no new D/I/Q findings. This was a requested clarification
follow-up, not recovery from a failed review. Later edits record factual
review/check outcomes only.

Caller validation: all scoped exact arithmetic checkers passed, including
30 tail orders/245 anchor-order pairs and the dihedral degree-48 composition,
240-index valuation and 2,795 prime checks. The 38 offline process tests,
77-file documentation check and both whitespace checks passed. Production
Lean, audits and pins are unchanged from the successful baseline build and
Test.lean run; no production rebuild is claimed for documentation-only work.
External source theorems and universal analytic/arithmetic arguments remain
paper mathematics. This review does not certify V or complete M4. Subsequent
scratch-only inquiries lie outside this frozen checkpoint.

The reviewed six-path checkpoint was committed locally as
`b102ab3dde2820203e1c064f43f38f459a885a32`. Final staged diff SHA-256
`386d49172ca9f6968b3fc6d1a4bc3791b19d3368eb696639b296398e991eef92`
and final validation/post-commit receipts are retained in that packet.
Post-commit inspection found the exact owned paths, unchanged protected sources,
an empty index and preserved unrelated work; no unused infrastructure or
substantive simplification was found. Nothing was pushed and no PR was opened.

## Transform/period combined review

Reviewer `/root/generating_review` completed the four-path checkpoint review
against `b102ab3dde2820203e1c064f43f38f459a885a32`. The frozen diff SHA-256 is
`f6302c6eacc7c5dfd3c27a9b8a846ea97286076532a4751c731f78c634cd7566`.
The packet `/tmp/pi-m4-transforms-periods-review-20261126/` retains the exact
scope, diff, evidence manifest, caller receipts and complete `review.md`.
Scope: the new transform/period assessment, research log, M4 handoff and this
record. Both adversarial guides were applied with their unchanged hashes above.

The initial review covered the exact Borel coefficients/poles, avoiding model,
Stoneham–Wallis period and prefix bounds, full-three-phase replacement and
actual numerator, both Ramanujan normalizations and shifted period windows,
and Long's single-prime supercongruence with its first consumer. The reviewer
read all five reports/checkers, the earlier window erratum and primary source
images, and reconstructed the paper arguments.

**Whole-cycle D/I/Q dispositions:** one defect, D1, concerned the source's
strict discrepancy bound at open endpoints. The parent reproduced the q=81
counterexample and repaired the contract to use half-open intervals, explaining
why hexadecimal cells are unaffected. The original report was preserved with
a versioned correction and erratum. The focused follow-up resolves D1; neither
review identified other defects, nonblocking improvements or additional open
questions within the diagnostic scope. No recommendation was deferred.

The follow-up also reviews the subsequently added combined prime-window proof,
prime-endpoint precision, exact low-bit modulus and all-five-prefix construction.
Its exact three-path delta SHA-256 is
`93469c7ba62294f6cf3684e1d5dd36ad0918e0f13bd98b91a4a2db15a44fb00e`,
retained as `followup.patch` with `followup-scope.json` and the full
`followup-review.md`. It inspected the corrected/new reports, both new checker
sources, erratum, parent receipt and the supplied Sutherland PNT slide. No
findings remain. This was a substantive addition and requested repair follow-up,
not recovery from a failed review. Later edits record factual outcomes only.

Both passes were read-only: no builds, probes, checker execution, mutations,
services, Carbon or delegation. Successful checker executions remain caller
evidence. All six scoped arithmetic checkers and the endpoint check passed;
the combined-prime run includes 5,903 prime-window pairs and 244 prefix cases.
These finite checks and independent review do not certify universal source
results or substitute for kernel proofs. No production Lean, audit, dependency
or pin changed; the previously successful baseline build/Test.lean and 38
process tests apply to unchanged sources/tooling, with no new run claimed.
M4 and V remain incomplete. Subsequent recovery research lies outside this
checkpoint, and no Carbon, push or PR occurred.

Final caller validation passed the 78-file documentation check and both
unstaged/staged whitespace checks. Protected Lean sources, audits and pins
remain unchanged. The selected diff contains exactly the four reviewed paths;
unrelated Obsidian, notes and papers work is excluded.

That four-path checkpoint was committed locally as
`5b431a35e07427503e85f03c2a7ccdb33666863f`. Its final staged diff SHA-256 is
`8cab5b31c95f88a603e17e3916c86f38efe4603e13064d10a8d3081b82789713`.
The packet retains `final-validation.json` and `postcommit.json`: exact scope,
empty index after commit, unchanged protected sources and preserved unrelated
work. No unused infrastructure or substantive simplification was found.

## Positive-transform recovery review

Reviewer `/root/generating_review` completed the exact four-path review against
`5b431a35e07427503e85f03c2a7ccdb33666863f`. The frozen diff SHA-256 is
`cb3c6a50adea7f76b23aefab9383a85f4d09bf9c763079a120767a2a40d605f0`.
Packet `/tmp/pi-m4-catalan-review-20261126/` retains `diff.patch`, `scope.json`,
all evidence hashes and the full `review.md`. Scope: the new Catalan assessment,
research log, handoff and this record. Both required guides were applied with
unchanged hashes above, under the user-directed Codex replacement procedure.

**Whole-cycle D/I/Q dispositions:** no defects or additional open questions.
I1 requested updating the handoff's latest-continuation pointer; applied to
the positive-transform section. The reviewer explicitly classified this as
navigation only, needing no mathematical revalidation. No recommendation was
omitted or deferred. Subsequent changes record factual outcomes and the next
bounded discovery question, without altering reviewed mathematical claims.

Coverage included the exact finite block identity, primitive valuations,
strict enclosure and BBP margin consumer, arbitrary-order integrality and
both integer recurrences, uniform accuracy/height bound and diagonal benchmark.
The reviewer inspected the full worker report, both checker sources, parent
receipt and Guillera page, and distinguished the supplementary model from
the actual coefficient and pi enclosure. All evidence hashes matched.

Review was read-only, without builds, probes, checkers, services, mutations,
Carbon or delegation. Executions remain caller evidence: both exact checkers,
the 79-file documentation check and whitespace checks passed. Production Lean,
audits, dependencies and pins remain unchanged from the successful baseline;
no new build or kernel certification is claimed. These paper results do not
prove V or complete M4. The subsequent source-connection inquiry is outside
the mathematical scope of this checkpoint.

The positive-transform checkpoint was committed locally as
`1bb8bffc41a6f00f0047eaeb55dc66f2ff821b4d`. Final staged diff SHA-256
`da71f443cbf367e5c0e854712ea1467377825ea796b9802c3c5365dcb31f6b38`
and final validation/post-commit receipts are retained in the packet. The exact
four reviewed paths, empty index and unchanged protected sources were verified;
unrelated work remains preserved. No unused infrastructure or substantive
simplification was found, and nothing was pushed or published.

## Arbitrary finite-jet intermediate sketch review

Reviewer `/root/generating_review` independently reconstructed the immutable
parent report `/tmp/pi-m4-finite-jet-report-v1.md`, SHA-256
`5291b4e375954e793ddaf0c3f46586360d712a48c4790713fc98bae0ce76576f`,
against local baseline `1bb8bffc41a6f00f0047eaeb55dc66f2ff821b4d` before
integration. Scope comprised that report, the exact checker and its receipt;
the complete response is `/tmp/pi-m4-finite-jet-review-v1.md`. Both adversarial
guides and the argument-critic limits were applied, with unchanged guide hashes.

**D/I/Q outcome:** none. The reviewer checked the separate-for-each-K
quantifiers, positivity and jet-preserving cutoff, two rational moment
corrections, rational poles/complete monotonicity, beta-integral error bound
and actual recurrence indexing. It explicitly retained the loss of irrationality
and exact four-pole structure. Review was read-only without execution or
mutation; the successful finite checks remain caller evidence. The result is
approval of a paper sketch, not changed-file integration, a kernel proof or
M4 acceptance. Combined integration/source review remains pending.

## Finite-data combined review

Reviewer `/root/generating_review` completed the five-path review against
`1bb8bffc41a6f00f0047eaeb55dc66f2ff821b4d`, frozen diff SHA-256
`3522096da528bc766309ab519433c0edda766e77de1968cc035368c80f759d59`.
Scope: the rational-forcing assessment, proof plan, research log, handoff and
this record. Packet `/tmp/pi-m4-finite-data-review-20261126/` retains the exact
diff, manifest and full `review.md`. Both required guides were applied with
unchanged hashes above.

**Whole-cycle D/I/Q dispositions:** D1 identified a kernel-name collision in
the integrated finite-jet proof: P already denoted the null-series polynomial.
The parent repaired the section to recall and use the actual P_A throughout.
The reviewer inspected exact delta `symbol-repair.patch`, SHA-256
`0fa9eb749665a958255ef9a2824389cab7acf5169ee1870dfd59298df9a1af2c`,
during the same review and explicitly resolved D1. No other defects,
nonblocking improvements or additional open questions were found. Nothing
was omitted or deferred; this focused repair was not a failed-review retry.

Coverage included all five paths, both immutable reports/checker sources and
receipts, the source's actual theorem/coefficient/system/constant pages, every
specified rescaling, the Machin branch, and the all-B separating proof with
its fixed-cutoff limitation. The finite-jet integration retains its exact
quantifiers and missing irrationality. Subsequent edits record factual
review outcomes only; the active Pade test is outside this checkpoint.

All reviewer work was read-only inspection and mathematical reconstruction,
without checker execution, builds, probes, services, mutations, Carbon or
delegation. Parent exact checkers passed, including 33,792 rational-grid cases
and K=1,...,8 finite-jet constructions. The 79-file documentation and both
whitespace checks passed. Production Lean, audits and pins are unchanged;
no new build or universal kernel certification is claimed. M4 remains incomplete.

The finite-data checkpoint was committed locally as
`1dba613b5b9ba39143ca419db59b3a198be3c5a3`. Its final staged diff SHA-256 is
`c1a5f380315bb955e276c34837937a8e39063f5f6857da2cb4e80d82ba92d234`.
Final validation and post-commit receipts remain in the packet: exact five
paths, empty index, protected sources unchanged and unrelated work preserved.
No unused infrastructure or substantive simplification was found; no push or
PR occurred. The next residual investigation is outside that reviewed checkpoint.

## Digit-sensitive Pade review

Reviewer `/root/generating_review` completed the four-path review against
`1dba613b5b9ba39143ca419db59b3a198be3c5a3`, frozen diff SHA-256
`07c457288607d31609fa85dbf04d59005c1ba06cedba0c52f042323aa20dcff7`.
Scope: the new Pade assessment, research log, handoff and this record. Packet
`/tmp/pi-m4-pade-review-20261126/` retains the manifest, exact diff, caller
receipt and full `review.md`. Both required adversarial guides were applied
with unchanged hashes above, using the Codex replacement procedure.

**Whole-cycle D/I/Q dispositions:** no defects or additional open questions.
I1 requested explicit parameter domains in the general residual interface:
n integer, B positive integer, and q,m,L natural. Applied as requested; the
actual family already fixed B=1. No recommendation was omitted or deferred.
Other subsequent edits only record the review outcome.

Coverage included the exact residual identities, modulo-power-of-two
surjectivity, suffix indexing, height and remainder budgets, elementary
alpha-cost obstruction, primitive coefficient clearing and its distinction
from evaluated cancellation, positive determinant, inverse and exact
interpolation cost. The reviewer inspected the frozen report, full checker
source, immutable data and caller receipt, and source pp.11-12. All recorded
hashes matched. These are paper results and finite checks, not Lean proofs.

Review was read-only without execution, builds, probes, mutation, services,
Carbon or delegation. Exact-checker execution remains caller evidence. The
80-file documentation and whitespace checks passed before review; production
Lean, audits and pins are unchanged from the successful baseline. No new
kernel certification or M4 acceptance is claimed. The fresh signed-remainder
inquiry remains outside this checkpoint's mathematical scope.

The Pade checkpoint was committed locally as
`01ec415732a529930d32414ed153415171a0bfbc`. Final staged diff SHA-256
`7dd8f8d49abf20b3263c6e0549886b9b41596521600f564ba09b983bb3ff78e2`
and final-validation/post-commit receipts remain in its packet. The final
80-file documentation check passed using the permitted `/tmp` uv cache after
the default cache was inaccessible. Both whitespace checks passed. Exact paths,
empty index and unchanged protected sources were verified; unrelated work was
preserved. No unused infrastructure or substantive simplification was found.
Nothing was pushed or published.

## Signed-evaluation review

Reviewer `/root/generating_review` completed the five-path review against
`01ec415732a529930d32414ed153415171a0bfbc`, exact diff SHA-256
`bb156122e59eb312d64c3a07e5494aaf85e5d53e05b58c71000c6360fddeb8be`.
Scope: the new signed-evaluation assessment, proof plan, log, handoff and this
record. Packet `/tmp/pi-m4-signed-review-20261126/` retains its manifest,
full diff, caller receipt and complete `review.md`.

**Whole-cycle D/I/Q dispositions:** no items. The reviewer also confirmed the
prior Pade parameter-domain clarification and found no further substantive
simplification. Nothing was omitted or deferred. Subsequent changes only record
this completed outcome; the new 2-adic work remains outside the mathematical
scope of this checkpoint.

Coverage included all three full reports/checker sources and evidence hashes,
orthogonal-moment normalization and sign, rational derivative and image interval,
primitive rays/gcd factors, prime exclusions and evaluated denominator tradeoff,
and the periodic-gap argument with its precise weakened-certificate limitation.
Sutherland's PNT slide was visually rechecked. Both full adversarial guides
were retained and their unchanged hashes verified under the replacement procedure.

Review was read-only inspection and mathematical reconstruction, without
execution, edits, builds, probes, services, installations, Git mutations,
Carbon or delegation. Exact finite checks remain caller evidence, with no
universal certification inferred. The 81-file documentation and whitespace
checks passed before review. Production Lean, audits and pins remain unchanged;
V and M4 remain incomplete.
