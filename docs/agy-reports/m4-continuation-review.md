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

The signed-evaluation checkpoint was committed locally as
`d53f350bd786671c1ceb621593ccb86a21b37b26`. Final staged diff SHA-256
`b7316b7a0de83dd63ac79a06804f820e1cfc8fbfb5da6d3bd8642e81bf46389e`
and final-validation/post-commit receipts remain in its packet. The final
81-file documentation and both whitespace checks passed. Exact reviewed paths,
empty index and unchanged protected sources were verified, with unrelated work
preserved. No unused infrastructure or substantive simplification was found;
all commits remain local, with no push or PR.

## 2-adic invariant and models review

Reviewer `/root/generating_review` completed the six-path review against
`d53f350bd786671c1ceb621593ccb86a21b37b26`, frozen diff SHA-256
`e0179116f69afa1eb30527a6baa7376494bb4cf50915ed2823166ce698c94e0b`.
Scope: both new 2-adic assessments, proof plan, log, handoff and this record.
Packet `/tmp/pi-m4-two-adic-review-20261126/` retains the full diff, manifest,
caller evidence and complete `review.md`.

**Whole-cycle D/I/Q dispositions:** D1 identified an overbroad Newton-basis
vanishing statement. The parent repaired k<n to 0<=k<n, keeping the separate
root at -1. The reviewer inspected the exact one-line delta, SHA-256
`9f3476ab33f93d679dab7acb91f647196086a079558952fcac09e138ff989967`,
and explicitly resolved D1. The frozen original analytic report retains the
historical sentence and must be read with this correction. No other defects,
improvements or additional open questions were found. No item was omitted
or deferred; subsequent changes record factual outcomes only.

Coverage included all three full reports and checker sources, manifest hashes,
actual 2-adic analyticity and the convergent reflected-zero primitive, exact
prefix and reflected valuations, both distinct model constructions and their
real avoidance/height claims. Cohen's printed p.117 was visually inspected;
its role is confined to the final logarithm cancellation. Both full adversarial
guides and their unchanged hashes were retained under the replacement procedure.

Review was read-only without checker execution, builds, probes, edits, services,
installations, Git mutations, delegation or Carbon. The successful exact runs
remain caller evidence; finite cases do not prove the universal statements.
The 83-file documentation and whitespace checks passed before review. No Lean
export, changed trust assumption, visitation theorem or M4 acceptance is claimed.

The initial 2-adic checkpoint was committed locally as
`906eff1c527c145b9993f71eff49c08ff71b9b6a`. Final staged diff SHA-256
`e0964e728fb08e3a84cacafe0ad3cae62bd9f2c2464a52c805733a40e14dbbbd`
and final-validation/post-commit receipts remain in its packet. The final
83-file documentation and both whitespace checks passed; exact six paths,
empty index and unchanged protected sources were verified. Unrelated work
remains preserved. No unused infrastructure or substantive simplification
was found; no push or PR occurred.

## Forward-branch and all-jets extension review

Reviewer `/root/generating_review` completed the six-path extension review
against `906eff1c527c145b9993f71eff49c08ff71b9b6a`, frozen diff SHA-256
`487a757006b1625d9e4f33b46e4790d4086474b5a44b9e81738a6ffbbf027880`.
Scope: both 2-adic assessments, proof plan, log, handoff and this record.
Packet `/tmp/pi-m4-forward-review-20261126/` retains exact scope, full diff,
caller evidence and complete `review.md`.

**Whole-cycle D/I/Q dispositions:** no defects or additional open questions.
I1 clarified that 16^n*xi-E_n is the unscaled rounding target; I2 retained the
rational mesh denominators and real bounds needed for the height proof, beyond
the 2-adic valuation argument. The reviewer inspected the exact clarification
patch, SHA-256 `88d375e27afce14373bebd0c03b5d345b439608cfc6abfc0f64e1975f4f52d5d`,
and resolved both. I3 corrected two report-only phrases: exponential growth
concerns the product/conductor of fresh primes, not their count. The frozen
report remains preserved with `evidence-wording-erratum.md`, SHA-256
`529b259be25726a18ad337817c55e30d4ab42ea0689b39317c0f64f83219b168`.
The reviewer inspected and resolved I3. No item was omitted or deferred.

Coverage included both full reports and checker sources, all evidence hashes,
CRT and floor identities, fresh-prime factors/conductors, the actual negative
branch and its orientation limit, all-jets bounds and fixed-tie construction,
and the proof excluding eventual rational forcing and polynomial denominator
height. Both full adversarial guides and their unchanged hashes were retained;
the previous primary PNT inspection supports the fixed-modulus applications.

The review was read-only inspection and reconstruction, without execution,
edits, probes, builds, services, installations, Git mutations, delegation or
Carbon. Successful finite runs remain caller evidence. The 83-file documentation
and whitespace checks passed before review; no production Lean, audit or pin
changed. The forward visitation estimate and V/M4 remain open. Subsequent edits
only record this outcome; the new multi-anchor inquiry is outside this scope.

The forward-branch extension is committed locally as
`823844ed30fbf9ea738c830b7a6d5533e64cc4af`. Final staged diff SHA-256
`363419e376a8ebac1a38dfc727a2d44d9b2e9cc1c1d2c957c7bf8ca87ac2a2d2`
and final-validation/post-commit receipts remain in its packet. The final
83-file documentation and whitespace checks passed; exact scope, empty index
and unchanged protected sources were verified. Unrelated work was preserved;
no unused infrastructure or substantive simplification was found. No push or PR.

## Joint forward and prime-compression review

Reviewer `/root/generating_review` completed the six-path review against
`823844ed30fbf9ea738c830b7a6d5533e64cc4af`, frozen diff SHA-256
`8828dfc0d9d8165268987ea73a08d8eb12f7c2bac9ede0b7256b60211712329b`.
Scope: the two new arithmetic assessments, proof plan, research log, handoff
and this record. Packet `/tmp/pi-m4-prime-review-20261126/` retains scope,
full diff, caller evidence and the complete returned `review.md`.

**Whole-cycle D/I/Q dispositions:** no defects or additional open questions.
I1 corrected the handoff's latest-continuation pointer. The reviewer inspected
and resolved the one-line delta, SHA-256
`232e205cae3504b16948e44421821f6a3f4b3fe1cf1f97ecfb7cf082829a9dc0`.
No item was omitted or deferred. Subsequent edits record factual review outcomes.

Coverage included the full reports/checker sources, manifests and receipts,
exact endpoint compression, fixed-sign coefficients, the fixed-H limiting
argument, support and prime-power bounds, the actual p=19 cancellation, and
evaluated primitive divisibility with its restricted consumer. The forward
polynomial height/valuation argument, Hankel signs and carry-equation limit
were reconstructed. Sutherland's PNT page was visually checked; only fixed
modulus 4 is used. Both full adversarial guides were retained and their unchanged
hashes verified under the replacement procedure and argument-critic limits.

Review was read-only inspection and mathematical reconstruction; exact checker
executions, the 85-file documentation check and both whitespace checks are
caller evidence. No reviewer edits, builds, probes, execution, installations,
services, Git mutations, delegation or Carbon occurred. No production Lean,
audit or pin changed; no paper result is a Lean export or M4 acceptance.
The ongoing shared-tail and negative-branch tests are outside this frozen scope.

The forward arithmetic checkpoint is committed locally as
`1e079c1ac9adff4169d1506c87b5528968546468`. Final staged diff SHA-256
`85f9374a4051387fe824aaeabc66dd1d53050bd05d36136c6818e2da8edf9abc`
and final-validation/post-commit receipts remain in its packet. The final
85-file documentation and both whitespace checks passed; exact six paths,
empty index and unchanged protected sources were verified. Unrelated work
remains preserved; no unused infrastructure or substantive simplification
was found, and no push or PR occurred.

## Shared-tail and negative-branch extension review

Reviewer `/root/generating_review` completed the exact six-path review against
`1e079c1ac9adff4169d1506c87b5528968546468`, frozen diff SHA-256
`d78db395b99d00cf0ab6d506676dd082d17ff18dd95fe5ba833ce8414b20cbfc`.
Scope: the shared-residual assessment, prime-compression extension, proof plan,
log, handoff and this record. Packet `/tmp/pi-m4-shared-review-20261126/`
retains the complete diff, scope/evidence hashes, caller checks and verbatim
returned `review.md`. **Whole-cycle D/I/Q:** none; no item omitted or deferred.

The reviewer reconstructed safe interval costs, whole-prime-power partition,
prime selection, full dyadic/odd congruence, actual numerator dependence,
matrix inversion and height control, primitive reduction and gcd-one lattice
consumer. Pair moment dependence and fixed-order limits were checked without
extending their conclusions to full congruences or stronger analytic bounds.
The pair report v3 preserves v2 with only an ambiguity corrected: the allowed
point lies inside the hull, not the topological interior of the Cantor set.

Coverage also included the negative compression states and exact zero strip,
dyadic cancellation, support and fixed-H exponent argument, isolated modular
exception, and the model's adjusted mesh and denominator exponent. All three
reports and checker sources were read fully and their evidence hashes checked.
The pinned Bertrand theorem was inspected; the prior visually checked PNT
source and unchanged hashes were retained. Both full adversarial guides were
retained and verified under AGENTS, the replacement procedure and argument-critic
limits. No review recovery or substantive repair was needed.

Review was read-only mathematical reconstruction and inspection. Three checker
replays, the 86-file documentation check and both whitespace checks are caller
evidence. No reviewer checker/probe/build, edits, Git mutations, installation,
services, delegation or Carbon occurred. Subsequent edits record this outcome
only. No Lean export, universal computational certification or V acceptance
follows; the analytic discovery pass is outside this review scope.

The shared-tail checkpoint is committed locally as
`bea51f569ca53ee687c9106cd65395b3a54968a3`. Final staged diff SHA-256
`0aea98493a1fb4effce3d705d7561746c890b90b82510ad9e40eca5b5a8c4c25`
and final-validation/post-commit receipts remain in its packet. Final
86-file documentation and both whitespace checks passed; exact six paths,
empty index and unchanged protected sources were verified. Unrelated work was
preserved; no unused infrastructure or substantive simplification was found.
No push or PR occurred.

## Analytic sampling and complementary recurrence review

Reviewer `/root/generating_review` completed the exact five-path review against
`bea51f569ca53ee687c9106cd65395b3a54968a3`, frozen diff SHA-256
`4f3a133fb4fe12c67c3949f1ad862bdc0b2b200d7ed148d772c6d241a79ea4be`.
Scope: generating-function/entry extensions, proof plan, log, handoff and this
record. Packet `/tmp/pi-m4-sampling-review-20261126/` retains the full diff,
scope/evidence hashes, caller checks and complete returned `review.md`.
**Whole-cycle D/I/Q:** none; no item omitted or deferred.

Coverage included the contour and growth majorants, finite-alphabet hypotheses,
carry indexing and late tails, Newton transform, exact complementary recurrence,
and the finite entry construction. The reviewer reconstructed the denominator
sieve including open endpoints and nonzero perturbation, propagated congruences,
strict real bounds and loss of both zero-initialization conditions. Both reports
and checker sources, receipts, manifests and erratum were inspected with matching
hashes. Breuer--Simon source pages 12--13 were visually inspected. The `isqrt`
correction and later source-rendering evidence are accurately retained.

Both full adversarial guides and their unchanged hashes were retained under
AGENTS, the replacement procedure and argument-critic limits. Review was
read-only inspection and mathematical reconstruction. Exact checker executions,
the 86-file documentation check and both whitespace checks remain caller
evidence. No reviewer execution, probe, build, edit, Git mutation, installation,
service, delegation or Carbon occurred. Subsequent edits only record this
outcome; no substantive repair was needed. No new Lean export or V follows.
The Mellin/Poisson and conjugate-state investigations are outside this scope.

The sampling/entry checkpoint is committed locally as
`a1550277d0bb54bbb49b0377efb812297ee29a24`. Final staged diff SHA-256
`dd084e1a8bcd0e929b34d38c0b733e7bf4092e3dedbe24448f001bd6ce0724c7`
and final-validation/post-commit receipts remain in its packet. Final
86-file documentation and both whitespace checks passed; exact five paths,
empty index and unchanged protected sources were verified. Unrelated work was
preserved; no unused infrastructure or substantive simplification was found.
No push or PR occurred.

## Transform and conjugate-state review

Reviewer `/root/generating_review` completed the exact six-path review against
`a1550277d0bb54bbb49b0377efb812297ee29a24`, frozen diff SHA-256
`3c91e048b63d4bbf84c040236786d74f4698226aef7c8dd7bc9deb9c83eb9258`.
Scope: transform assessment, prime-compression extension, proof plan, log,
handoff and this record. Packet `/tmp/pi-m4-transform-review-20261126/`
retains full diff, scope/evidence hashes, caller checks and verbatim review.

**Whole-cycle dispositions:** D1 repaired the missing p-integral coefficient
hypothesis in generalized compression. The counterexample p=7,n=0,c_1=1/7
gives residues 1 versus 0. Production now restricts to the actual three dyadic
vectors; the preserved report has a domain erratum. The reviewer inspected and
resolved `domain-fix.patch`, SHA-256
`cd1325e614bfd2bc1e4861d5d98341f3f05f50ab74cd6f3e997b0288d9298534`,
and erratum SHA-256
`771d56e27b55bb8b776f1a043526f277d747cca2c4d835f508636bbac5b03f39`.
D2 repaired the minorant's integer domain to positive integers; negative m
can satisfy the ratio condition. The inspected patch SHA-256 is
`aaf98a335146ecd07cb70ad8dd6a94cd9e7d479dbc5c499d9211a3746265e1ba`.
I1 clarified the frozen Mellin report's coincident endpoint convention using
the inspected erratum SHA-256
`cc309de16ddde496ae42d790b21a2d03aca5930f4c146779ba76a919461b79f2`.
All three items are resolved; no open questions, omissions or deferrals remain
for these diagnostic claims. CANC and V stay open.

Coverage included both full reports/checkers, receipts/manifests, official
formula extracts and null-kernel context, with matching hashes. The reviewer
reconstructed strict minorant transfer, all contour residues and branches,
uniformity limits, theta normalization and dual length, null-prefix integral
and asymptotics, local transforms/endpoints/cofactors and paired-entry limits.
Both full adversarial guides and unchanged hashes were retained under AGENTS,
the replacement procedure and argument-critic limits.

Review was read-only inspection and mathematical reconstruction; checker runs,
the 87-file documentation check, whitespace checks and official HTML condition
inspection remain caller evidence. No reviewer executions, probes, builds,
edits, Git mutations, installations, services, delegation or Carbon occurred.
Subsequent edits record these outcomes only. No new Lean theorem or M4
acceptance follows. Sparse-completion and variable-telescoper research were
outside this exact scope.

The transform/conjugate checkpoint is committed locally as
`623d1bffa1a2991e16c0190eafdf338ef650eac2`. Final staged diff SHA-256
`af5234c92f1e4740e1423e843e1f87bd382e410c2efbc20a8f4c722de4ed4438`
and final-validation/post-commit receipts remain in its packet. Final
87-file documentation and both whitespace checks passed; exact six paths,
empty index and unchanged protected sources were verified. Unrelated work
was preserved; no unused infrastructure or substantive simplification was
found. No push or PR occurred.

## Gauge, sparse completion and antisymmetric-state review

Reviewer `/root/generating_review` completed the exact seven-path review against
`623d1bffa1a2991e16c0190eafdf338ef650eac2`, frozen diff SHA-256
`506ca8955200676f597255e691eaa581094e9ad6c40aafc66ba37f57fc94b162`.
Scope: rational-correction note, transform and prime-compression extensions,
proof plan, log, handoff and this record. Packet
`/tmp/pi-m4-gauge-review-20261126/` retains full diff, scope/evidence hashes,
caller checks and complete returned review. **Whole-cycle D/I/Q:** none;
no item omitted or deferred. Subsequent edits only record this outcome.

Coverage included all four full reports and checker sources, original/revised
root-checker difference, receipts/manifests and existing compression context,
with matching hashes. The reviewer visually inspected the irrationality source
at PDF pages 1 and 13. The preserved integer-square-root, degree-zero and
earlier endpoint clarifications are consistent. No substantive repair was needed.

The reviewer reconstructed Gauss normalization/character duality, aliases and
parity exceptions, approximation error and effective-modulus quantifiers;
the exact null-gauge construction, pole and tail claims, circular lifting,
occupation/content bounds, fixed-parameter survival and limit order; and the
antisymmetric kernel, CRT/sign/endpoint identities, Gauss information loss and
actual backward bound. All unresolved real-phase and uniform-shadowing premises
remain explicit; no all-method impossibility or V theorem is inferred.

Both full adversarial guides and unchanged hashes were retained under AGENTS,
the replacement procedure and argument-critic limits. Review was read-only
inspection and mathematical reconstruction. Checker runs, the 88-file
documentation check and whitespace checks remain caller evidence. No reviewer
execution, probe, build, edits, Git mutations, installations, services,
delegation or Carbon occurred. The ongoing p^2 lift is outside this scope;
no new Lean theorem or M4 acceptance follows.

The gauge/Gauss/antisymmetric checkpoint is committed locally as
`804138d0b5cde2cce5666eeb79bcef5642504946`. Final staged diff SHA-256
`4a6c3791b6c48e1e0e1527c934b7889d4bb3180684c58af8b133656302e35fbb`
and final-validation/post-commit receipts remain in its packet. Final
88-file documentation and both whitespace checks passed; exact seven paths,
empty index and unchanged protected sources were verified. Unrelated work
was preserved; no unused infrastructure or substantive simplification was
found. No push or PR occurred.

## Prime-square compression review

The separate `/root/generating_review` reviewer completed the exact five-path
review against `804138d0b5cde2cce5666eeb79bcef5642504946`: the new prime-square
assessment, proof plan, log, handoff and this record. The frozen diff hash is
`f92123b2e419271453672265ebe11592252d015336a81678eb17763819cdfd4d`.
The full returned review is `/tmp/pi-m4-square-review-20261126/review.md`,
SHA-256 `30244fa3684820ca774b7ab0274b3a7f01d653901c30c85ea6d4d7adb9adf64d`.
Both adversarial guides, their unchanged hashes, AGENTS, the replacement
procedure and argument-critic limits were retained. Inspection was read-only;
the reviewer ran no checker, probe or build and made no edits.

**Defects:** none. **Nonblocking improvements:** I1 requested an explicit
prime hypothesis at the opening definition of q2. It was implemented exactly;
the focused patch hash is
`635c03c387e0eaa2af13eb5b3c0aba609802ace32760ed5a0bc93f7fa102bfac`.
The reviewer verified the patch and working file and marked I1 resolved in
`focused-review.md` in the same packet. **Open questions/missing evidence:**
none blocking the stated paper results. The real-phase consumer remains open.

The reviewer reconstructed the unit domains in the quadratic algebra, both
finite-log pair identities, complete/partial root-filter normalization, exact
regular/pole cancellation, initialized exponents, prime-entry cofactor quotient,
precision counterexamples and endpoint dependence. The fixed-extra-digit sieve
was checked with its initialization limit. Parent independent derivation,
full evidence inspection and both exact checker replays passed; these execution
receipts and the 89-file documentation/whitespace checks remain caller evidence.
The original report, precision and normalization addenda and manifest chain
are retained. The complete-block congruence does not control the initialized
real phase. The E-function-zero connection is outside this review scope;
V and M4 remain open. No Lean export, audit, dependency, pin or trust change
is included. Final exact-diff, validation and post-commit receipts belong in
the same packet; publication is local only.

The resulting checkpoint is local commit `ccb24d0ef081bbcc7f7b5ff3a05cc97fa7853170`.
Its final patch hash is
`fa0943ce9794e466b0602144c934dba835865c4a182249175c8065e1963f28ce`.
The packet's final-validation and postcommit receipts verify the exact five
paths, empty index, unchanged protected files and preservation of unrelated
work. No unused infrastructure or substantive simplification was found.
No push or PR occurred.

## Initialized reconstruction and language-auxiliary review

The separate `/root/generating_review` reviewer completed the exact six-path review against
`ccb24d0ef081bbcc7f7b5ff3a05cc97fa7853170`: the prime-square reconstruction
extension, new language-auxiliary assessment, proof plan, log, handoff and
this record. Frozen diff SHA-256:
`362af10691eac625743a34a5ddcc7d0beb5c2f02a012d63595535155df61eac7`.
Full returned review: `/tmp/pi-m4-initialized-review-20261126/review.md`,
SHA-256 `a2e6c6d2ed6db2e0f2ce9dfffd05c4f539fbbc7692882558218b65d894ad694d`.
**Defects:** none. **Nonblocking improvements:** none requested.
**Open questions/missing evidence:** none blocking this checkpoint; V remains
unresolved. Both adversarial guides and their unchanged hashes were verified,
with AGENTS, the replacement procedure and argument-critic limits retained.
The reviewer used read-only file, hash and image inspection and mathematical
reconstruction; no checks were executed, files changed or services contacted.

Parent full reports/checkers, source theorem pages and manifests
were inspected; all three checker replays passed with matching receipts,
preserving frozen originals. The parent independently reconstructed the
valuation lattice and PNT costs, null-state discriminator, primitive content,
signed/simplex cancellations, resolvent poles and root-detector degree bound.
These are paper results, not Lean certificates or a visitation estimate.
The new CRT-consumer investigation is outside this review scope.

The reviewer specifically reconstructed the individual-factor lcm and prime
support, exact difference lattice, fixed-modulus PNT constants, strict interior
height/equality case, and null-state half-denominator cancellation. Language
coverage includes the product/content calculation, source argument domains,
tensor phase, simplex factorial and reflection, resolvent pole multiplicities,
and restricted cyclotomic claim. All scoped hashes matched; original and
adapted replay evidence was distinguished. The first missing V implication
remains escaping the avoidance set, which uniqueness does not prove.

The 90-file documentation and both whitespace checks passed as caller evidence.
Final exact-diff, validation and post-commit receipts are retained in the same
packet. No new Lean, audit, pin, dependency or trust change is included.
Publication remains local only.

## Exact CRT phase and unrestricted-lift review

Reviewer `/root/generating_review` completed the six-path checkpoint against
`213003555254a8f3ea8639533f397576814e7b3d`: the new CRT-phase assessment,
prime-square extension, proof plan, research log, handoff and this record.
Frozen diff SHA-256:
`f0976f003e10c1ffca9cbc384d428e7b688dc4b7908e9473a93fba310a87520b`.
The full returned review is
`/tmp/pi-m4-crt-lift-review-20261127/review.md`, SHA-256
`7120dc289d0bd1e30fbd3abf9d014f9ff26d68d6f02dd40271f4dec133bec395`.
**Defects:** none. **Nonblocking improvements:** none requested.
**Open questions/missing evidence:** none blocking this checkpoint; the
stronger precision and real estimate remain unproved. No recommendation was
omitted or deferred, and no substantive fix needed focused follow-up.

Caller evidence includes full reports/checkers, immutable manifests and
unchanged-copy replays for `/tmp/pi-m4-crt-word-20261126/` and
`/tmp/pi-m4-unrestricted-lift-20261127/`. Both replays exited 0 with identical
receipts and preserved original hashes. The parent reconstructed the CRT
inversion/carry/height and absolute-certificate arguments, and the divided
binomial, unrestricted cancellation, twisted tower and mixed-prime arguments.
The reviewer independently reconstructed these arguments, including all unit
domains, tower indexing, p=7 exception, signs, scaling, minorant quantifiers
and certificate-versus-actual-sum distinction. All scoped file and evidence
hashes matched. The actual null-state comparison preserves the missing
A-specific implication. No universal claim received a new kernel certificate.

AGENTS, the replacement procedure and argument-critic instructions were read;
both retained full adversarial guides had their unchanged hashes verified.
Review used read-only file inspection and mathematical reconstruction. Checker
executions, the 91-file documentation check and both whitespace checks remain
caller evidence. No reviewer build, probe, checker execution, file edit, Git
mutation, service contact or delegation occurred; Carbon remains disabled.
Later precision and real-consumer investigations were excluded. Final exact
diff, validation and post-commit receipts belong in the same packet. This
checkpoint remains local and does not accept V/M4 or end ongoing research.

## Boundary argument checkpoint and complete integration review

Reviewer `/root/generating_review` completed an intermediate argument review
against baseline `8a50efa27368f8052890b53fa7e06cc2b24716a5`. The exact 27-input
scope is `/tmp/pi-m4-boundary-argument-review-20261127/scope.json`; primary
report SHA-256 is
`eff6c0d8d1e09a86a19524df3ac98d4773f46f2e2ea4bc5cd0da0943c64a2c13`.
The full returned response is retained in that packet's `review.md`, SHA-256
`d58b24717e440a0d52734406086b1aa45441ac665004ecb00ba30d4d97bae24e`.
**Defects:** none. **Nonblocking improvements:** none requested.
**Open questions/missing evidence:** none blocking the argument checkpoint;
formalization and the real visitation estimate remain outstanding. No item
was omitted or deferred and no substantive repair was required.

The reviewer independently reconstructed the single-annulus principle, finite
horizontal-kernel stabilization, flat base change and natural subobject
transport. The Leibniz term disappears in the successive quotient, preserving
linearity of the kernel maps; whole-product injectivity was not substituted
for the required single-annulus conclusion. It checked Newton convergence,
deleted-disc domains, zero-normalized iterated primitives, comparison scalars,
the de Jeu convention, initialization, all-k quantifiers, tower gains and the
p=7 exception. Both full supporting reports/checkers, manifests, source text
and supplied page images were covered. All scoped hashes matched at review.
The earlier draft production note was context, not integration acceptance.

AGENTS, the reviewer replacement, argument-critic limits and both retained
full adversarial guides were applied with unchanged guide hashes verified.
The reviewer used only read-only inspection and mathematical reconstruction;
no checker, probe, build, extractor, service, Git mutation or delegation ran.
Executions remain caller evidence: analytic-inverse replay is byte-identical,
and the boundary-comparison receipt differs only in timestamp. Source review
and exact finite checks are not kernel certification.

The broader integration also includes the mixed-consumer barrier and three
positive-certificate packets. The parent read their full reports/checkers,
reconstructed their arguments, and replayed unchanged copies with matching
receipts and preserved originals. Same-session critic passes are retained:
the longer-determinant pass fixed the domain of its Q/p collision-height bound;
circle criticism retained the diagonal cost, singular-kernel limit and the
clustered-grid countertest. Their open actual-numerator questions remain open.
The intermediate verdict did not waive the separate integration review or
establish V/M4 acceptance.

Reviewer `/root/generating_review` then completed that seven-path integration
against the same baseline. Exact packet:
`/tmp/pi-m4-boundary-products-review-20261127/`; diff SHA-256
`1975ff0147550a42e65a1af71497091da4c28714d7659e83afc358997b83b71c`.
Full returned `review.md` SHA-256:
`1089d5f06b92ec0bdbe4c77ba55e77b7f27ebf83a7a81581254c45b34219422a`.
**Defects:** none. **Nonblocking improvements:** none requiring a scope change.
**Open questions/missing evidence:** no additional gap in the advertised paper
results; the actual V estimate is still missing. No recommendation was omitted,
deferred or treated as resolved by a finite check. No substantive fix required
focused follow-up.

The reviewer reconstructed all integrated inequalities and their domains,
checked all seven file hashes and 61 evidence hashes, read the four new full
supporting reports/checkers and available critics, and rechecked the boundary
integration against the earlier source inspection. Coverage includes canonical
floors, square-root uniformity, long-block collision costs, the singular
convolution and diagonal, parameter order, grid formulas and the exact missing
numerator inequality. Both adversarial guides were retained in full with
unchanged hashes verified. Read-only inspection and reconstruction were the
reviewer's only checks; no checker/build/probe/extractor, edit or service ran.

Caller documentation validation reports 93 tracked Markdown files, and both
whitespace checks exit 0. Final exact-diff, preservation and post-commit
receipts belong to the same packet. The newer precision-consumer, Bernoulli
energy and source-connection investigations are excluded. These reviews accept
the scoped paper assessment only; no new Lean proof, V/M4 acceptance, push or
PR is claimed, and ongoing research continues.

## Precision consumers and bounded energy integration — 2026-11-27 UTC

Baseline is local commit `dd4476039dc0aa0677a5dae14d8bc3bce79b6e47`.
The eight-path documentation scope consists of `m4-prime-defect-boundary.md`,
`m4-positive-certificates.md`, `m4-transform-phases.md`,
`m4-language-auxiliaries.md`, `proof-plan.md`, `research-log.md`,
`m4-handoff.md` and this record, all under `docs/` (this record under
`docs/agy-reports/`). No Lean, tooling, pin or unrelated workspace change
belongs to the scope. The user-directed Codex replacement remains in effect.

Five immutable packets supply the paper arguments: precision consumer,
balanced multiprime (manifest v2), Bernoulli consumer, short-sum sources and
fresh polygon phase, all dated `20261127` under `/tmp/pi-m4-*` as linked in
the respective mathematical notes. The parent read the complete reports,
checkers and separate critic passes, reconstructed their conclusions and
inspected primary source pages. Unchanged-copy replays for the four checkers
exited 0 and preserved originals. The precision and multiprime receipts match
apart from UTC; Bernoulli and polygon receipts are byte-identical. Source-only
claims have direct theorem/inequality inspection rather than numerical checks.
Documentation validation reports 93 tracked Markdown files; working whitespace
check exits 0. No new Lean verification is claimed for these paper results.

Reviewer `/root/generating_review` completed the independent review in
`/tmp/pi-m4-consumers-review-20261127/`. Frozen diff SHA-256 is
`cc22301a8cf820ba2cca06d291c162d64516696ec6ee0bfd96af8e7b552ccdcf`;
the full returned `review.md` has SHA-256
`c7d3573df44979b4e5101fde26e132ddafa0d6411a98edd695487eb3eb80d38e`.
**Defects:** none. **Nonblocking improvements:** none requiring a checkpoint
change. **Open questions/missing evidence:** no additional gap in the advertised
results; the actual canonical numerator estimate for V remains open.
No recommendation was omitted or deferred, and no substantive fix required
focused follow-up.

The reviewer reconstructed the primitive coefficient/carry costs, infinite
initialized pole subsequence, sharp energy bound, source parameter restrictions
and isolated-root height comparison. It read all five full reports, four
checkers, additional probe, critics and reassessment, and verified all eight
file hashes and 58 evidence hashes. At its request the caller rendered/extracted
Section 5, pages 10--11 of the frozen sliding-sum PDF, exit 0. The reviewer
inspected that supplement and verified its four hashes; the source contract
needed no correction. The source, command and hashes are retained in
`supplemental-source.json`. Both full adversarial guides and their unchanged
hashes were applied. Review consisted only of read-only inspection and
mathematical reconstruction; no checker, probe, build, extraction, edit, service
or delegation ran in the reviewer. All execution receipts are caller evidence.

Final validation and post-commit inspection are retained in the same packet.
Active positive-kernel and height work is outside this integration. This accepts
the scoped paper assessments, not a Lean theorem or M4. No remote publication
is authorized; research continues.

## Positive kernels, null height and pole classification — 2026-11-27 UTC

Baseline is local commit `c9f4fb7a310196a7f2dda949520883f86cf4a94f`.
The eight-path documentation scope is `m4-rational-forcing.md`,
`m4-prime-compression.md`, `m4-positive-certificates.md`,
`m4-logarithmic-constraints.md`, `proof-plan.md`, `research-log.md`,
`m4-handoff.md` and this record. No Lean, dependency, tool, pin or unrelated
workspace change is included. Carbon remains disabled by the user's override.

The frozen positive-kernel, adelic-height and rational-period-classification
packets under `/tmp/pi-m4-*-20261127/` retain the complete reports, checkers,
critic passes, source contracts and original manifests. Parent reconstruction
and unchanged-copy replays passed, preserving originals. Positive-kernel and
classification receipts differ only in UTC; the height receipt is identical.
The first positive replay harness expected a written receipt, while its checker
prints JSON. Corrected stdout capture and one repeat retained the child exit 0;
the failure and recovery are recorded, with no frozen checker modification.
The parent inspected Baker's original theorem page and Baker--Petsche v1
pages 9, 11, 13 and 14. The latter's unqualified Proposition 9 is not used;
the weighted Theorem 8 and exact kernel are the source inputs.

The classification manifest's input paths were hashed after concurrent draft
integration began. Exact committed copies under its `parent-source/` retain
the pre-existing eight-pole/Baker calculation and F model actually needed;
new draft conclusions are not inputs to themselves. The mathematical inputs
and this provenance distinction are explicit. The three same-session critics
are not independent review. Classification critic improvements I1--I3 were
applied before freezing: old versus new result, source-based status, and no
visitation claim. Its Q1--Q3 retain the missing word-to-rational-period bridge,
uncontrolled canonical floors and pending independent review respectively.

Reviewer `/root/generating_review` completed the required independent review
in `/tmp/pi-m4-positive-height-review-20261127/`. Frozen diff SHA-256 is
`15c8e40b0957736681a4f658536423b5f52da5b5e28f0f2a1f3c0977a3e64093`;
the full returned `review.md` has SHA-256
`c42c67440ad63457810e2b5560c06b1c17b4f7837e1aeddb3d9bfe3a48b07922`.
**Defects:** none. **Nonblocking improvements:** none requiring a checkpoint
change. **Open questions/missing evidence:** no additional gap in the advertised
results; the actual canonical phase/carry estimate remains absent. No finding
was omitted or deferred and no substantive repair required focused follow-up.

Both full adversarial guides were applied with unchanged hashes verified.
The reviewer reconstructed the sharp filter norm, uniform moment/Gram
comparisons, actual model carries, fixed-H prime survival, height normalization,
local field weight, Baker rational-value consequence and shifted-pole denominator
comparison. It read all three reports/checkers/critics/contracts and verified
all eight production and 60 evidence hashes. The pre-existing input copies
make the classification dependency noncircular.

At the reviewer's request the caller rendered/extracted Baker--Petsche pages
7--8, exit 0, supplying the positive archimedean discrepancy and Tate retraction.
The reviewer inspected the supplement and verified all four hashes, retained
with the command/source in `supplemental-source.json`. No contract correction
was needed. Review used only read-only inspection, hashing, receipt comparison
and mathematical reconstruction; no checker, probe, build, extraction, edit,
service or delegation ran. Execution receipts remain caller evidence.

Documentation and working/staged whitespace checks, exact scope, preservation
and post-commit necessity inspection are retained in the same packet. The newer
fractal Fourier and word-carry investigations are excluded. These paper reviews
do not establish a Lean theorem or V/M4 acceptance. Research continues.

## Forced propagation and uniform word-carry polynomials — 2026-11-27 UTC

Baseline is local commit `16f8735acd27bd0f0ebc774c0bdf012db4631536`.
The six-path documentation scope is `m4-crt-phase.md`,
`m4-language-auxiliaries.md`, `proof-plan.md`, `research-log.md`,
`m4-handoff.md` and this record. No Lean, dependency, tool, pin or unrelated
workspace change is included. The Codex replacement remains mandatory.

The frozen `/tmp/pi-m4-fractal-phase-20261127/` and
`/tmp/pi-m4-word-carry-20261127/` packets retain full reports, source/input
contracts, checker sources, critics, receipts and manifests. The parent read
and reconstructed them, visually inspected Dyatlov--Jin v3 pages 1, 2 and 4,
and replayed unchanged checker copies. Both child exits were 0; propagation
receipt is identical, word-carry differs only in UTC, and originals are
preserved. The Cantor strengthening was proposed by the parent, then
reconstructed by the worker; that is not independent acceptance review.
The worker's separate criticism applied I1--I3 before freezing: distinguish
the superseded finite-cell bound, retain the actual versus relaxed structure,
and label the synthetic terminal-tail checks correctly. The infinite
logarithmic integral remains a paper proof, not a numerical certificate.

Reviewer `/root/generating_review` completed the initial six-path review in
`/tmp/pi-m4-propagation-carry-review-20261127/`, against diff SHA-256
`09a753cabe0018e9d2acbd36a9869946cd122e847d3edec6db4527f7f0eca573`.
Its full `review-initial.md` has SHA-256
`31305f7400643036523702bce137f0d87c960685d1a3e0e8a5af2755a4ea75c8`.
It reconstructed the principal operator and Cantor arguments but found two
narrow defects and one nonblocking improvement:

- **D1, resolved by focused review:** Q now explicitly denotes the
  least common multiple of the entry and forcing reduced denominators.
  An arbitrary clearing multiple would not justify oddness or exponent 6.
- **D2, resolved by focused review:** the immutable word-carry
  `correction-v2.md` restricts the superseded finite-cell Chebyshev formula to
  d>=1 and gives the constant case separately. The main Cantor bound and
  checker domain are unchanged. `manifest-v2.json` preserves all original
  hashes and adds the supplement, SHA-256
  `e829f61331550aedd8a23233d0ad8f531d881f1967d410e9b6642387b73545ad`.
- **I1, resolved by focused review:** production explicitly declares
  b to be a positive integer clearing the rational polynomial coefficients.

No additional source or evidence gap was found. The actual numerator and
independently constrained Fourier-amplitude estimates remain unproved.
Both full guides were applied; all six file and 35 evidence hashes matched.
Review covered full reports/checkers/critics/contracts, source images and
checked Orbit/Tail interfaces through read-only inspection and reconstruction.
No checker, probe, build, extractor, edit, service or delegation ran in review;
execution receipts remain caller evidence.

The focused review inspected diff SHA-256
`40e9a66696f35f4e2aff87cf1e22c203981d90c71f44a08a0a63de285b8ee64f`,
all six current files, the correction supplement and its manifest, and all
35 original evidence hashes. Its full `review-followup.md` has SHA-256
`6a2cb3c9a24c461ef3e1d4503002881ca0d490b6b7959b58a9fec95727a8d423`.
Both defects and the improvement are resolved; there are no new findings or
unresolved review items. The principal operator and Cantor conclusions are
unchanged. The checker already restricts its Chebyshev section to positive
degree, so the prose correction requires no broader replay. Documentation,
whitespace, exact scope and preservation are checked by the caller before the
local checkpoint. The rational-entry investigation is excluded. No V/M4
acceptance is claimed; the parent continues authorized research.

## Rational-entry equivalence and fixed-family quantifiers — 2026-11-27 UTC

Baseline is local commit `c9a9c4646def554e5a5005534098fc496f6458dc`.
The five-path documentation scope is `m4-generating-functions.md`,
`proof-plan.md`, `research-log.md`, `m4-handoff.md` and this record. No Lean,
dependency, tool, pin or unrelated workspace change is included. The latest
handoff pointer is reconciled with its new dated section.

The frozen `/tmp/pi-m4-rational-entry-20261127/` packet retains the full report,
input contract, same-session critic, checker, receipts and manifest. The parent
read and reconstructed the circle omega-limit and finite-cover arguments,
fixed-family quantifiers and complete-grid identities; checked the actual
Orbit/Tail interfaces; and replayed an unchanged checker copy. Exit was 0,
all 5,369 checks passed, the receipt was identical and originals were preserved.
These checks do not establish the universal topological claims. The critic's
six improvements were applied before freezing: individual versus universal
visits, rational division through a real lift, transient offsets/endpoints,
exact indexing/diagonals, equivalence rather than a weaker proven premise, and
the irrational model's limited scope. Its missing fixed-entry estimate remains
open; same-session criticism is not independent review.

Reviewer `/root/generating_review` completed independent changed-file review
under the Codex replacement procedure in
`/tmp/pi-m4-rational-entry-review-20261127/`. The frozen diff SHA-256 is
`c7420b16771fc5abb72845de9e28982fba27dfd9dc344151da8e7c761059aa85`;
the full returned `review.md` has SHA-256
`f9f00b5d95f01803584b348830bb6d3e84f0252f85e5e1b15ca9d8d4dddf6348`.
**Defects:** none. **Nonblocking improvements:** none requested.
**Open questions/missing evidence:** none additional for the stated results;
the fixed-entry/family all-target estimate remains unproved and equivalent to V.
No finding was omitted or deferred, and no substantive repair required follow-up.

The reviewer reconstructed the invariant, exact entry transfer, fixed-family
argument, grid normalization and irrational countermodel. It inspected the full
report, critic, source contract, checker, manifests and receipts, surrounding
finite-entry claims and actual Orbit/Tail interfaces. All five file and 19
evidence hashes matched. Both fully read adversarial guides were retained with
unchanged hashes verified. Review was read-only inspection, hashing and
mathematical reconstruction: no checker, probe, build, extractor, mutation,
service or delegation ran. Execution results remain caller evidence.
Documentation, working/staged whitespace and post-commit scope/preservation
checks are retained with the packet. The entry-precision and quantitative-entropy
investigations are excluded. No V/M4 acceptance or new Lean theorem is claimed.

## Entry precision and quantitative hole transport — 2026-11-27 UTC

Baseline is local commit `358c9401e0e0a3d24050982613a92f9840bb904d`.
The six-path documentation scope is `m4-prime-defect-boundary.md`,
`m4-generating-functions.md`, `proof-plan.md`, `research-log.md`,
`m4-handoff.md` and this record. No Lean, dependency, tool, pin or unrelated
workspace change is included. The handoff's latest pointer is updated.

The frozen entry-precision and entry-entropy packets retain full reports,
input contracts, same-session critics, checkers, receipts and manifests.
Parent full reconstruction checked the raw shift matrix, exact valuation
criteria, canonical gauges and budget, finite-cover counts, actual order
bound, dimension argument, Stieltjes constants and diagonal countermodel.
Unchanged-copy replays passed: precision 1,507 checks with identical receipt;
entropy v2 3,791 checks with UTC-only difference; both child exits 0 and all
frozen originals preserved. These checks do not prove universal assertions.

Precision v2 corrects a signed-floor linearity sentence and clarifies which
normalized residual its bound measures. V3 contains a parent-proposed budget
corollary reconstructed by the worker. Entropy v2 changes only the checker
square-root endpoint to integer isqrt and restricts the countermodel's
finite-omega claim explicitly to rational entries. The parent inspected these
supplements; this is not independent review. Same-session critics retain the
unknown epsilon stencil and missing hole-address/fixed-family estimate.
Their stated scope/quantifier improvements were applied before freezing;
the additive corrections qualify their earlier no-defect wording.

Reviewer `/root/generating_review` completed the initial independent review
with both adversarial guides under the Codex replacement procedure. The packet
is `/tmp/pi-m4-entry-costs-review-20261127/`; frozen diff SHA-256 is
`4400c78045614d518a67dc4dc02fc3f26ba6ac8d76391ca2110eaccce9174c06`.
The full `review-initial.md` has SHA-256
`9ae502251237340659383403a808dc2161b77fb486496b49a481ad09df077df1`.

**D1, resolved by focused review:** production now requires the strong
simultaneous precision for all sufficiently large admissible k, so v_p(k)
is unbounded. Merely unbounded k was insufficient: r=s=p^2 retains level 2
at arbitrarily large p-coprime k. The frozen worker report already had the
correct condition; this is a production quantifier repair, requiring no new
checker execution. **Nonblocking improvements:** none requested.
**Open questions/missing evidence:** none additional for the scoped claims.
The actual epsilon estimate and moving-hole/fixed-family bridge remain open.

The reviewer reconstructed both complete arguments and their scope limits,
read reports, critics, contracts, all supplements and complete checker sources,
and verified six file and 46 evidence hashes. Both fully read guides retained
their verified hashes. Review was read-only inspection and reconstruction;
no executable check, extraction, mutation, service or delegation ran. Caller
receipts and previously assessed paper inputs retain their stated limits.
Focused follow-up inspected diff SHA-256
`654da61ff243cd65dff2cac5b5637dca4ff85c4adf3941dd33799147bc9a6493`,
all six file and 46 original evidence hashes, and the unchanged guide hashes.
Its full `review-followup.md` has SHA-256
`2b0dfb3ac6ce6441d5886ba600a3f81caed26ac8a62a8a8fbee53b248b094fb2`.
D1 is resolved with no new findings; no review item was omitted or deferred.
The stronger quantifier admits k=p^j for arbitrarily large j, which forces
both shifts to zero. No executable check was needed for that repair.
Caller documentation, working/staged whitespace and post-commit scope and
preservation checks are retained with the packet. The quadrature investigation
is excluded. No V/M4 acceptance or new Lean theorem is claimed.

## Gaussian prefixes and irrational analytic moment models — 2026-11-27 UTC

Baseline is local commit `ae152090219c118fa8fe8a59813f64d43a1852a8`.
The five-path documentation scope is `m4-rational-forcing.md`,
`proof-plan.md`, `research-log.md`, `m4-handoff.md` and this record. No Lean,
dependency, tool, pin or unrelated workspace change is included.

The frozen `/tmp/pi-m4-fresh-mechanism-reset-20261127/` and
`/tmp/pi-m4-analytic-moment-model-20261127/` packets retain full reports,
source/input contracts, critics, checker sources, receipts and manifests.
The parent reconstructed their orthogonality, rationality, positive error,
comparison-window and nondensity arguments, and the infinite rational greedy
construction with its exact finite moment sums, common analytic neighborhood
and endpoint constants. The latter was parent-proposed and worker-reconstructed;
neither that agreement nor the same-session critics is independent review.

Unchanged-copy replays passed, Gaussian 444 and analytic 150 checks, both
exit 0 with identical JSON receipts and preserved originals. They do not
instantiate the infinite choices or prove universal claims. The parent opened
the primary publisher PDF and visually inspected rendered Theorem 1 pages
65–66; `parent-source-inspection.json` retains command, exit and hashes.
This resolves Gaussian critic Q2's worker image limitation without altering
its frozen record. Its I1–I2 and analytic I1–I3 were incorporated before
freezing: rational-valued versus rational-function forcing, the valid diagonal
consumer, relative analyticity, finite-versus-infinite period relations and
uncontrolled heights. Their missing early-window/global arithmetic estimate
and finite-diagnostic limits remain explicit.

Independent changed-file review by `/root/generating_review` is complete under
the Codex replacement procedure, with both full adversarial guides and their
unchanged hashes verified. The frozen packet is
`/tmp/pi-m4-moment-models-review-20261127/`; its diff SHA-256 is
`e9c3a76190dd9c4346ffe561f190c7f610eeffca4cfbfc70484e9d7a6c15ae98`.
The complete response is retained as `review-full.txt`, SHA-256
`8ae1eac7d4d42a1112c742f5037eb0fff40b1ab2f8bdc535321c8fe42701b13e`.
All five scoped file hashes and 34 evidence hashes matched. **D/I/Q: no
defects, no requested improvements, and no additional evidence gaps.** The
reviewer independently reconstructed the Gaussian/error and infinite analytic
arguments, checked the actual Series/Orbit/Tail interfaces, and visually
inspected both primary theorem pages, resolving the worker's Q2 limitation.

The missing actual early-window visit remains explicit; fixed-model nondensity
does not refute the growing-order consumer. The analytic construction loses
finite rational-function forcing and denominator control. Review was read-only
inspection, hashing, source-image inspection and mathematical reconstruction;
no checker, probe, build, extractor, mutation, service or delegation ran.
Finite executions remain caller evidence and do not certify the infinite
construction. Subsequent changes record this result only. The controlled-
denominator follow-up is excluded. No V/M4 acceptance or new Lean theorem is
claimed; B4/P3 premises remain unchanged.

## Arithmetic moment models and the analytic-family limit — 2026-11-27 UTC

Baseline is local commit `9a4b896a96d8d00f5d8a7804d3a7479013ca2d48`.
The six-path scope is `m4-rational-forcing.md`, `m4-prime-defect-boundary.md`,
`proof-plan.md`, `research-log.md`, `m4-handoff.md` and this record. No Lean,
dependency, tool, pin, audit or unrelated workspace change is included.

The four frozen packets are `/tmp/pi-m4-controlled-moment-model-20261127/`,
`/tmp/pi-m4-exact-envelope-model-20261127/`,
`/tmp/pi-m4-congruence-moment-model-20261127/` and
`/tmp/pi-m4-analytic-congruence-cost-20261127/`. They retain complete reports,
input/source contracts, separate same-session critics, exact checker sources,
receipts and immutable manifests. The last is parent-generated. The parent
read and reconstructed all four, including the universal-history interface
needed to assemble the analytic and pointwise-congruence model. This is not
independent review. The official DLMF Jacobi conditions and Chebyshev formula
were inspected; no source supplies a visitation theorem.

Unchanged-copy replays passed 42,823, 28,412 and 10,757 checks for the first
three packets, all exit 0; receipts are identical except the arithmetic
packet's UTC. Frozen originals are unchanged. The parent's cost checker and
replay passed 24,118 checks, exit 0, identical receipts. All are finite algebra,
synthetic perturbation/sieve and exact enclosure diagnostics. They do not
instantiate the infinite choices or certify analytic/PNT conclusions.

Worker improvements were incorporated before freezing: natural versus actual
reduced denominators, precise analytic variable, changed finite-period relation,
uniform coefficient intervals, two-residue sieve for both companions, exact
initialization and the restriction to pointwise laws. Parent criticism retains
the necessary-versus-sufficient Newton distinction and the possibility of
correlated constructions despite the excessive modulus. Missing actual
visitation and finite-check limits remain explicit.

Independent combined review by `/root/generating_review` is complete under
the Codex replacement procedure, with retained full readings and unchanged
hashes of both adversarial guides. The frozen scope is
`/tmp/pi-m4-arithmetic-models-review-20261127/`, diff SHA-256
`8309a439749a05fa31c6651778d74fd2e3ca25a2b19f4bd1712625e846b51311`.
The complete returned review is `review-full.txt`, SHA-256
`c55c56440bccef069b89a10754613e0457667e1d4b0be32cdc5a4e7b96bbf40b`.
All six production hashes and 57 evidence hashes matched. **D/I/Q: no defects,
no requested improvements, and no missing evidence blocking the scoped claims.**
The possibility of correlated full-family models remains explicitly open.

The reviewer independently reconstructed the uniform analytic interval and
perturbation-grid transfer, both-companion sieve and pole survival, and the
Newton factorial/clearing/primorial calculation. Initialization, target order,
source conditions and the pointwise/full-family distinction were checked.
The actual real-phase/canonical-floor implication remains missing. Work was
read-only inspection, hashing and mathematical reconstruction; no checker,
probe, build or mutation ran. Execution and preservation remain caller evidence,
and prior Coleman/PNT results remain paper inputs. Subsequent edits record
this result only. The fresh analytic-family consumer inquiry is excluded.
No V/M4 acceptance or new Lean theorem is claimed.

## Continuous p=17 defect and the fixed eight-pole family — 2026-11-27 UTC

Baseline is local commit `868a092c7797065f90b5a73d5d0222d69d0f7a88`.
The five-path scope is `m4-logarithmic-constraints.md`, `proof-plan.md`,
`research-log.md`, `m4-handoff.md` and this record. No Lean, dependency, pin,
audit, tool or unrelated workspace change is included.

Frozen evidence is `/tmp/pi-m4-analytic-family-consumer-20261127/`, including
the complete report, exact source contract, same-session critic, checker,
receipt, source image, input snapshots and immutable manifest. The parent
read and reconstructed the argument, including its linear constant-boundary
extension to r=8 and its retained Coleman input. The original Brumer Theorem 1
and definitions were visually inspected on the publisher's p.121 image;
the complete source proof was not accessed. Unchanged-copy replay passed 825
finite algebra checks, exit 0, identical receipt and preserved originals.
Those checks do not prove Brumer, analytic convergence, Coleman continuation
or any visitation claim.

Worker I1 was incorporated before freezing by giving the primitive identity
and its domain/exponent justification. I2 is retained by suspending further
same-family classification without a real consumer. Q1–Q2 remain open:
infinite full-family models and reconstruction from actual avoiding carries.
The parent additionally clarifies that raw seed continuity is not invariant
under integer shifts preserving all canonical orbit values. This agrees with
the earlier reviewed rational-entry calculation.

Independent changed-file review by `/root/generating_review` is complete under
the Codex replacement procedure, with retained full readings and verified
unchanged hashes of both adversarial guides. Frozen scope is
`/tmp/pi-m4-p17-family-review-20261127/`, diff SHA-256
`cc9c219611e72345aeee50774f856f20c54d06d3f9e8ec642b94c9d9d20e51c2`.
The complete returned response is `review-full.txt`, SHA-256
`f928cf818206c54ebc002237381813dbfb7a0938485a28abecd16b4770231d17`.
All five production hashes and 28 evidence hashes matched. **D: none. I: no
new improvements; worker I1–I2 incorporated. Q1–Q2 retained; Q3 resolved for
paper review.** The generic constant-boundary extension, including r=8,
survived independent reconstruction; that is not kernel certification.

The reviewer visually inspected the original source theorem and reconstructed
the log-basis application, rank-six kernel, primitive normalization, continuity,
asymptotics and raw-seed qualification. Read-only inspection, hashing, image
inspection and mathematics were performed; no checker, probe, build or mutation
ran. Execution/preservation remain caller evidence, and Brumer's full proof
was not accessed. Earlier Coleman results remain paper inputs. Subsequent
edits record this outcome only. The active adelic inquiry is excluded.
No V/M4 acceptance or new Lean theorem is claimed.

## Analytic classes, rationality and global period covering — 2026-11-27 UTC

Baseline is local commit `9a9a0403686f235a1c862cd4743a61b12835e3e4`.
The six-path scope is `m4-generating-functions.md`,
`m4-prime-defect-boundary.md`, `proof-plan.md`, `research-log.md`,
`m4-handoff.md` and this record. No Lean, dependency, pin, audit, tool or
unrelated workspace change is included.

Frozen evidence comprises `/tmp/pi-m4-adelic-rationality-test-20261127/`,
`/tmp/pi-m4-fixed-prime-analytic-model-20261127/` and
`/tmp/pi-m4-global-analytic-lattice-20261127/`: reports, input/source
contracts, separate same-session critics, checker sources, receipts and
manifests. Parent full reconstruction covered the common-function criterion,
Newton sufficiency, uniform analytic/arithmetic construction, exact lattice
index, coordinate determinant and the volume-to-covering counterexample.
Dwork's original printed pp.41–42 were visually inspected, including the
theorem's hypotheses; no broader adelic criterion or full zeta proof is claimed.

Unchanged-copy replays passed 1,181 source/identity diagnostics, the fixed-prime
diagnostics including 1,202 synthetic CRT stages, and 12,890 global-lattice
checks, all exit 0. Receipts match except the fixed-prime UTC; originals are
preserved. These finite calculations do not prove Dwork, analytic convergence,
the infinite moment construction, asymptotics, compactness or visitation.
Earlier analytic/arithmetic and PNT inputs remain explicitly paper results.

Worker improvements were incorporated before freezing: exact same-function
and continuation domains, finite rational sums for moments, fixed precision
versus equality, separate perturbation/total radii, the full coordinate map,
uniform cost summation and a toy with collapsing period projection. Missing
all-prime models, denominator noncancellation in the lattice result, actual
period covering and avoidance-dependent carry continuation remain open.
Independent changed-file review by `/root/generating_review` is complete under
the Codex replacement procedure. Both adversarial guides were retained in full
and their unchanged hashes verified. Frozen scope is
`/tmp/pi-m4-analytic-covering-review-20261127/`, diff SHA-256
`68623c8323ce2c55a3d68420cd0c1c8349d82aa137957e063b20dc9883049243`.
The complete returned response is `review-full.txt`, SHA-256
`ffec638b0b547837774f7bda3332c4f193d067297a6a81df5207324681c3d4c0`.
All six production hashes and 41 evidence hashes matched. **D: none. I: no
new improvements. Q1–Q3 retained:** canonical carry continuation, actual period
covering, and the omitted global denominator sieve. These are disclosed
mathematical limits, not evidence failures for the scoped diagnostic claims.

The reviewer inspected the original theorem pages and independently
reconstructed the central arguments, including small-prime radius cases and
closedness/rationality in the conditional compactness argument. Its work was
read-only file, hash and image inspection plus mathematics; no checker, probe,
build, extractor or mutation ran. Execution and preservation remain caller
evidence. An initial read used incorrect packet filenames; corrected reads
completed without a missing packet or recovery invocation. Subsequent edits
record this outcome only. The two follow-up inquiries are excluded from this
checkpoint. V/Hpi/T/M4 remain open; no Lean theorem or acceptance is claimed.

## Canonical borrows and actual dual estimates — 2026-11-27 UTC

Baseline is local commit `088fa55b625b2c58d3bc5b8bd3017a359601e19e`.
The six-path scope is `m4-generating-functions.md`,
`m4-prime-defect-boundary.md`, `proof-plan.md`, `research-log.md`,
`m4-handoff.md` and this record. No Lean, dependency, pin, audit, tool or
unrelated workspace change is included.

Frozen evidence is `/tmp/pi-m4-canonical-carry-reset-20261127/` and
`/tmp/pi-m4-actual-period-projection-20261127/`, including complete reports,
contracts, separate same-session critics, checker sources, receipts and
manifests. The parent reconstructed the borrow endpoints, transition spacing,
sentinel transfer, changed-phase discriminator and Hadamard distinction; and
the orthogonal Wronskian, endpoint integrals, optimized determinant lower
bounds and primitive-row scope. No new external source was introduced.
Prior analytic/PNT results and the referenced finite-alphabet theorem retain
their earlier paper status.

Unchanged-copy replays passed 31,883 and 613 exact checks, both exit 0,
identical receipts and preserved originals. They are synthetic or symbolic
diagnostics, not actual pi phases, universal asymptotic proofs or kernel
certificates. Worker improvements retain the canonical range beyond boundedness,
whole corrections versus transitions, ordinary versus Hadamard multiplication,
optimal versus natural period alignment, primitive witnesses versus bounded
ones, and full-box versus feasible-subset norms. No V consumer is established.

Independent changed-file review by `/root/generating_review` is complete under
the Codex replacement procedure, retaining full readings and verified unchanged
hashes of both adversarial guides. Frozen scope is
`/tmp/pi-m4-borrows-duals-review-20261127/`, diff SHA-256
`f3f760faa4ae12df246efc0b09355423b973ea3d414e4c1b734fc985435f4f87`.
The full returned response is `review-full.txt`, SHA-256
`f7612769ec3a6fa2d012778c8c5e0c56fa488d447e23e3255570443b7feffc90`.
All six production hashes and 25 evidence hashes matched. **D: none. I: no
new improvements. Q1–Q2 retained:** the missing word-indicator estimate and
full-lattice geometry. Neither blocks the scoped diagnostic claims.

The reviewer independently reconstructed the critical arguments, including
the optimized lower bounds and primitive-witness scope. Work was read-only
inspection, hashing and mathematics; no checker, probe, build, extractor or
mutation ran. Execution and preservation remain caller evidence; prior analytic,
PNT and finite-alphabet results retain their paper status. Subsequent edits
record this outcome only. The two-series investigation is excluded. V/Hpi/T/M4
remain open, B4/P3 retain visitation premises, and M5 is excluded.

## Growing stencils, prefix content and native carries — 2026-11-27 UTC

Baseline is local commit `f7a2d22080a80f5dbd08068cc119079924005257`.
The six-path scope is `m4-approximation-interfaces.md`,
`m4-prime-defect-boundary.md`, `proof-plan.md`, `research-log.md`,
`m4-handoff.md` and this record. No Lean, dependency, pin, audit, tool or
unrelated workspace change is included.

Frozen evidence is `/tmp/pi-m4-two-series-coupling-20261127/`,
`/tmp/pi-m4-growing-stencil-test-20261127/` and
`/tmp/pi-m4-prefix-content-test-20261127/`, each with complete report,
contract, same-session critic, checker source, receipt and immutable manifest.
The parent generated the prefix-content candidate; a separate research worker
verified it. That is not the independent integration review. Parent full
reconstruction covered the native carry/omega-set distinction and additive
countertest, uniform optimized stencil error including actual content, and
both polynomial-witness chain regimes with finite other-prime clearing.

The production zero-order conclusion explicitly combines the content bound
with the already reconstructed raw-prefix norm. The arithmetic report leaves
that norm as an external premise; the earlier exact prefix-tail identity and
two-coordinate determinant discharge it at arbitrary large cutoffs. No small
content-to-bounded-feasibility inference is made.

Unchanged-copy replays passed 2,078, 16,660 and 32,679 exact checks, all exit 0.
The first and third receipts differ only in UTC; the second is identical.
Frozen originals are preserved. All are coefficient, symbolic or synthetic
diagnostics, not actual pi phases or certificates for the universal proofs.
No new external source is introduced; earlier analytic/PNT inputs retain
their paper status.

Same-session corrections retain principal angle branches, omega rather than
finite-orbit equality, full trajectory versus marginal information, and
actual forcing lost by the additive countertest. The stencil proof accounts
for nonprimitive rows and interior concentration. The prefix construction
states the strict zero-prefix convention, minimal threshold and finite
clearing horizon. Its attempted matching lower bound was withdrawn with an
exact full-lattice counterexample; only the upper bound survives.
Independent changed-file review by `/root/generating_review` is complete under
the Codex replacement procedure. Full readings of both adversarial guides
were retained and unchanged hashes verified. Frozen scope is
`/tmp/pi-m4-stencil-content-review-20261127/`, diff SHA-256
`cffe8845fee7be76bbe392d7a9fabe7558c717f9f2fdb6f396825e4baf1e0f95`.
The complete returned response is `review-full.txt`, SHA-256
`d5e556ace7e75191b4ee5791dd287d04a73444b205a44f74750f0d8d96540223`.
All six production hashes and 32 evidence hashes matched. **D: no unresolved
defects. I: none required. Q1–Q2 retained:** bounded feasible-lattice geometry
and actual joint-carry distribution. The withdrawn lower bound remains excluded.

The reviewer independently reconstructed all three arguments and the new
zero-order norm interface, rereading the prior tail/determinant report. It
also confirmed receipt equality with UTC fields removed where applicable.
Its work was read-only inspection, hashing and mathematics; no checker, probe,
build, extractor, mutation or service call ran. Execution and preservation
remain caller evidence. Prior analytic, orthogonal-polynomial and PNT inputs
retain their paper status. Subsequent edits record this outcome only. The
fresh positive-consumer inquiry is excluded. V/Hpi/T/M4 remain open, with
B4/P3 visitation premises unchanged.

## Carry density and source bridges — 2026-11-27 UTC

Baseline is local commit `062667e49a715e9c3e89d42b3d7857fa62ec4698`.
Scope: `m4-generating-functions.md`, `proof-plan.md`, `research-log.md`,
`m4-handoff.md` and this record. No Lean, dependency, pin, audit, tool or
unrelated workspace change is included. Independent integration review by
`/root/generating_review` is complete under the Codex replacement procedure,
with both adversarial guides.

The parent supplied the base-16 Kempner carry-density candidate; a separate
research worker verified its all-prefix estimate and source map. This does not
replace independent integration review. The original Shallit paper was
retrieved from its author's site and pages 2--5 and 7 of that version rendered
and visually read. The claim uses the folding recursion only from v=1 and
retains the changed initial state. No rationality claim about that state is
made. The new source-to-contract limit is a comparison example, not V.

The frozen report, source contract and separate same-session criticism are in
`/tmp/pi-m4-bounded-quotient-borrows-check-20261127/`. The parent fully read
them and the checker and reconstructed the argument. An unchanged-copy replay
passed 5,692 exact finite checks, exit 0, with UTC-only receipt differences
and all seven original files preserved. These cover constructed continued
fractions, coefficient bounds, prefix counting and synthetic borrow algebra;
they compute no actual pi phase or tail and do not certify the universal proof.
Same-session I1--I3 retain the folding restriction, all-prefix count and optional
model premises. The optional model consequence is not integrated in production;
its scratch applicability alone is not a new visitation consumer.

The separate logarithmic-determinant bridge packet is
`/tmp/pi-m4-logarithmic-determinant-bridge-20261127/`. The parent read its
complete assessment and criticism, verified all four Git blob/byte identities,
and checked the required approximation and parameter-gap statements in the
source. It does not accept or refute the preprint's claimed theorem, or review
its geometric proof. Avoidance does not supply the determinant's approximation
input; counting allowed numerators does not change its transverse-index count.
Same-session D1--D4 are retained as rejected application steps; I1 is implemented
by stopping that unnecessary proof audit, and Q1 (a new content or cancellation
estimate) remains unsupported. These are application limits, not alleged
defects in the source theorem.

The preceding fresh pass had no positive result. Its optional geometric-sample
interpolation diagnosis is not integrated as a reviewed mathematical claim;
its checker has not been replayed. Documentation and whitespace checks passed
before review preparation. All 17 protected Lean/pin files and 11 unrelated
files match the preceding preservation receipt. Frozen scope is
`/tmp/pi-m4-carry-source-review-20261127/`, diff SHA-256
`9cdac694432154a8d6dc0f06e38df5abe10a7766f7c386b2ec12e3139e8d45dd`.
The complete returned response is `review-full.txt`, SHA-256
`ae759389ac3622ab3c2041d255f3f461933e9a33c1157aa54dde96d4ad20e356`.
All five production hashes and 35 evidence hashes matched. **D: none.
I: none required. Q1--Q2 retained:** the actual zero initialization and the
missing determinant approximation/cancellation input. Neither blocks the
scoped negative assessment; both prevent inferring V.

The reviewer reconstructed the carry bounds, continued-fraction specialization
and source-application limits, visually read the source pages, inspected the
local Lean interfaces, and confirmed UTC-only receipt differences. Its work
was read-only inspection and mathematics, with no checker, probe, build,
extractor, mutation or service call. Execution remains caller evidence.
Both full guide readings were retained and their unchanged hashes verified.
Subsequent changes record this outcome only. Research continues; V/Hpi/T/M4
remain open, B4/P3 retain visitation premises, and M5 is excluded.

## Sparse block source comparison — 2026-11-27 UTC

Baseline is local commit `0c666a0c335d84c25895c7565ea42dd6e4de7be4`.
Scope is the new research-log and handoff entries plus this record. No Lean,
dependency, audit, tool or unrelated workspace change is included. Independent
Codex review by `/root/generating_review` with both guides is complete.
The supplied source bridge report
is `/tmp/pi-m4-fermat-bridge-20261127/report-v1.md`; the research log records
its hash and the inspected source. Parent reconstruction covers the integer
Lambert coefficients, polynomial residue mesh and fixed-lattice obstruction.
The source's external Lean archive and its separate frequency/nonnormality
claims are not verification evidence for this application.

The rational-prefix pass found no new consumer, and the determinant variation
duplicates an existing assessment. No new result is claimed for either.
Documentation and whitespace checks passed, and the 17 protected plus 11
unrelated file hashes match the preceding preservation receipt. A separate
global-dual investigation is ongoing and excluded from this review scope.
No actual pi digits or phases were searched. V/Hpi/T/M4 remain open.

Frozen scope is `/tmp/pi-m4-sparse-source-review-20261127/`, diff SHA-256
`2a549dbccac131b5337154099c30f2047c5ce1d95b288f25ff821eaf52f48458`.
The complete response is `review-full.txt`, SHA-256
`8dccc623a1fceb2f379bc6d245d4e94e0221a5eb07b4ee343a80125d0387b09e`.
**D: none. I1: implemented** by updating the handoff's latest-continuation
link. **Q1: retained open**, the missing actual-pi integer-residue identity;
it blocks a visitation inference, not this scoped negative application.
The reviewer reconstructed the argument, read all four source-page texts,
visually inspected pp.1--3 and verified all three production and eleven
evidence hashes. Both retained full guides have unchanged verified hashes.
Checks and preservation remain caller evidence; the reviewer performed no
checker, build, extractor, probe, mutation or service call. Subsequent edits
implement I1 and record this outcome only. The global-dual inquiry continues
separately, with no result integrated here.

## Finite covering and rational functional — 2026-11-27 UTC

Baseline is local commit `b114f4bd2fd46cecf8bf26bdb81d7d0015c8c44f`.
Scope: `m4-prime-defect-boundary.md`, `proof-plan.md`, `research-log.md`,
`m4-handoff.md` and this record. No Lean, tool, dependency, pin or unrelated
workspace change is included. Independent exact-diff Codex review by
`/root/generating_review` is complete, using both adversarial guides; the
separate research verifications below do not replace it.

The N50 verifier independently reconstructed the original moments, every
orthogonality equation, both full-lattice bases, original uncleared Newton
conditions and all-target rounding argument. Its D1--D5 are resolved by those
checks and the finite-only statement. I1's simpler direct-coordinate bounds
are used. Q1--Q2 remain open: uniform future covering and subsequent infinite
model/denominator obligations. The parent read the full report, criticism and
checker, then replayed it with only the output-directory line changed:
2,680 checks, exit 0, identical receipt/certificate and 11 frozen files intact.
The original report's "unchanged-copy" phrase is inaccurate about that path
change; the production assessment explicitly corrects it. No search heuristic
was replayed or accepted as proof. The exact independent verifier is
`/tmp/pi-m4-n50-certificate-verification-20261127/verify-v1.py`, SHA-256
`a859f37de557dc0f31be69f74b29eb22a37fea141fe2b2cd82ff60746ee7887f`.

The single-functional sketch received separate read-only criticism from
`/root/fermat_neighbor_bridge`, captured in full at
`/tmp/pi-m4-one-functional-review-20261127.txt`. D1 (rationality of B) and D2
(determinant sign) were corrected; I1 explicitly defines the zero-prefix
lattice. Q1 retains the unproved uniform basis family. The reviewer reconstructed
the general bounds and found no remaining defect, with no checker execution.
These are sufficient conditions, not a successful infinite construction.

The earlier rational slice and thin projection remain diagnostics. Parent
unchanged-copy replay of the slice passed 2,547 exact checks with an identical
receipt; the projection's 2,460 exact assertions are caller evidence, not an
independent verification. The original forced-prefix/reduction packet's
180-second cap was not rerun. Only its elementary K=1 obstruction and measured
timeout enter the mathematical assessment. No asymptotic conclusion is inferred
from finite thresholds or volumes. The current uniform-dual investigation is
excluded from this checkpoint's mathematical claims. V/Hpi/T/M4 remain open.

Frozen scope is `/tmp/pi-m4-finite-cover-review-20261127/`, diff SHA-256
`31741eeaedad9e47618df153f540034576f88562c21ab95d37f8a4d1ef0c5656`.
The complete response is `review-full.txt`, SHA-256
`8dd7b37905322c3b0982eecfc56eee3b8fbaa1084500a4d105fdb5d376777a5d`.
**D: none. I: none required. Q1: resolved:** the reviewer requested an explicit
matrix dimensions/types check; the caller confirmed 19 rows of 19 Python
integers, with source hash unchanged. The supplemental receipt is
`integer-transform-check.json`. **Q2--Q3: retained open:** uniform future
covering, infinite realization/denominator obligations and the absent actual-V
bridge. No search rerun or frozen artifact modification was needed.

The reviewer reconstructed both arguments, verified all five production and
54 evidence hashes, and confirmed the output-path-only replay difference.
The retained full guides have unchanged verified hashes. Binary artifacts were
hash-inspected; exact execution and preservation are caller evidence. The
reviewer ran no build, checker, probe, extractor, mutation or service call.
Documentation (93 files), process tests (38), whitespace and preservation of
17 protected plus 11 unrelated files passed. Subsequent edits record this
review outcome only. No Lean files changed or build was repeated.

## Global arithmetic and integer sampling — 2026-11-27 UTC

Baseline is local commit `8155234c34be6aed22d33b6f45e0392f64ec886a`.
Scope: `m4-prime-defect-boundary.md`, `m4-generating-functions.md`,
`m4-transforms-and-periods.md`, `proof-plan.md`, `research-log.md`,
`m4-handoff.md` and this record. No Lean, tool, pin, dependency, audit or
unrelated workspace change is included. The final exact-diff Codex integration
review is complete, with the scope and outcome recorded below.

The parent read the five complete reports, critics/checkers and reconstructed
their mathematical claims. Byte-unchanged checker replays passed with identical
receipts: uniform dual 1,477 checks, adaptive window 3,288 original prime/order
conditions, continuous sampling 1,137 checks, Poisson 2,589 normalization checks,
and arcsine 36,484 coefficient/synthetic checks. All originals were preserved
(six, six, three, four and six manifest-bound files respectively). The tests
compute no actual pi phases and do not certify universal paper arguments.
The parent verified DLMF 4.24.1 at the interior real point 1/2 and visually
read Tao's original pp.6--8, including the stationary-phase proof. Its
fixed-phase source theorem is supplemented by the explicit uniformity argument.

Separate read-only paper criticism used both adversarial guides:

- `/root/fermat_neighbor_bridge` reviewed the uniform-dual packet. D: none;
  I1's uniform error-constant clarification is implemented; Q1 retains the
  missing full-coordinate norm/value bound. Full response:
  `/tmp/pi-m4-uniform-dual-paper-review-20261127.txt`.
- `/root/generating_review` reviewed continuous sampling and Poisson. D: none;
  sampling I1's integer frequency/window domains are explicit; Poisson has no
  required improvement. Q items retain actual initialization-sensitive sampling
  and cross-scale cancellation. Full responses:
  `/tmp/pi-m4-sampling-paper-review-20261127.txt` and
  `/tmp/pi-m4-poisson-paper-review-20261127.txt`.
- `/root/actual_forcing_recovery` reviewed arcsine and the adaptive window.
  D: none; arcsine I1's direct-to-V offset/error interface is implemented.
  Adaptive I1 requested integer-only prime enumeration: the parent created
  `/tmp/pi-m4-adaptive-window-isqrt-20261127/check-v2.py`, changing only the
  import and square-root operation. Its identical receipt passed, exit 0,
  with originals preserved. Q items retain the actual coupled arcsine remainder,
  global older-coordinate control and period-line covering inside local fibers.
  Full responses: `/tmp/pi-m4-arcsin-paper-review-20261127.txt` and
  `/tmp/pi-m4-adaptive-window-paper-review-20261127.txt`.

The critics inspected evidence and reconstructed arguments without running
checkers, builds, probes, mutations or services. The Poisson critic also
visually read the source; the arcsine critic treated page verification as
caller evidence. Captures and raw packets remain temporary, not durable
archives. The current global-support and fresh strategy inquiries are excluded
from this checkpoint's results. V/Hpi/T/M4 remain open; B4/P3 retain visits.

The frozen integration packet is
`/tmp/pi-m4-global-sampling-review-20261127/`, diff SHA-256
`3b3d7444aca90f436225898159b433b10a5766e5fbb57ad15b9a24e9fdd788ce`.
The complete response is `review-full.txt`, SHA-256
`52f9a4fba2ee6d843e43ae7a40282b7b1b4d071843a6e2171f29d882e1ca8f3f`.
Reviewer `/root/generating_review` found **D: none; I: no new recommendations**.
UD-I1, AW-I1, CS-I1 and AS-I1 are resolved as described above. **Q1 remains
open:** global bounded covering and period-line covering inside local fibers.
**Q2 remains open:** an actual-initialization estimate yielding arbitrarily
late inner-interval hits. These prevent V/M4 acceptance, not this diagnostic
checkpoint. No additional finite replay would discharge either question.

The reviewer independently reconstructed the new arguments, read the complete
diff and relevant evidence, and verified all seven production, 73 evidence
and two guide hashes. Sampling/Poisson packets from the preceding criticism
were confirmed unchanged. Earlier envelope/orthogonal-polynomial contracts
remain paper inputs; source verification and execution limits are retained
above. The reviewer ran no checker, probe, build, extractor, mutation, service
or delegation. Subsequent edits record this outcome only. Documentation
(93 files), process tests (38) and whitespace passed before review; final
validation and preservation are checked again before the local commit.

## Discrete entries and source applicability — 2026-11-27 UTC

Baseline is local commit `0d8b849176116446acdd8edb320656256009ca4b`.
The discrete-grid argument received independent read-only criticism from
`/root/generating_review`, captured in full at
`/tmp/pi-m4-strategy-reset-paper-review-20261127.txt`. **D: none. I1: resolved**
in production: the opposite-parity character pair separates replacement
numerators only, and refutes no actual-sequence rule, universal or eventual.
**Q1--Q2: retained open:** actual canonical-numerator parity and methods that
use additional actual history to select one entry. The critic read all four
manifest-bound artifacts and the parent replay receipt and reconstructed
the interval, count, polynomial-height and raw-congruence arguments.

The parent read the complete report/checker/criticism and reconstructed its
claims, then replayed the byte-unchanged checker in
`/tmp/pi-m4-strategy-reset-parent-replay-20261127/`: exit 0, identical receipt,
all four originals preserved. It passed 575 interval counts, 7,554 entries,
14,988 carry steps, 99 coefficient checks, 460 progression checks, three
primitive products, 288 raw-precision steps, one character pair and 54
actual-denominator cases. Synthetic rational tails retain exact future A;
these checks do not certify the actual irrational-tail construction or
universal asymptotics, and evaluate no actual canonical numerator or pi digit.

The separate source screen received criticism from the same reviewer,
captured at `/tmp/pi-m4-rigidity-source-paper-review-20261127.txt`.
**D: none; I: none required; Q1--Q2: retained open:** a qualifying rational
generating function with actual canonical information, and sufficiently many
rational members of one infinite missing-digit set. Parent and reviewer both
visually inspected Gauss pp.1/18 and Cantor pp.2--3; all 11 evidence hashes
matched. The scope is statement/application inspection, not an audit of the
complete source proofs. Retrieval/rendering are caller evidence.

Both reviews reused full readings of the two unchanged adversarial guides.
The reviewer ran no checker, probe, build, extractor, mutation, service or
delegation. Raw captures remain temporary. Ongoing global/sparse-support
inquiries are not accepted by these paper reviews. No Lean, trust, dependency
or visitation contract changed.

Final integration packet `/tmp/pi-m4-discrete-source-review-20261127/` has
diff SHA-256
`4bfed9e745f6abedbed579d691963cfceb05f13891bced7d8e15ce1939ba1d77`.
The complete response is `review-full.txt`, SHA-256
`b842fa10b276b7bf87c5e3d007087891cd4e325407ba006dd96fa8d59fc85292`.
Reviewer `/root/generating_review` verified all five production, 24 evidence
and two guide hashes and completed the exact-diff review. **D: none; I1:
resolved** as above. **I2: resolved:** the handoff's opening now links to
its latest appended continuation. Focused inspection confirmed the navigation
fix and no substantive drift; the full response is `followup-full.txt` in
the packet. **Q1--Q2: retained open:** actual selection, source application
bridges and global covering. Subsequent edits record outcomes and that link
correction only. Documentation (93 files), process tests (38), whitespace and
preservation of 17 protected plus 11 unrelated files passed before review.
No Lean build was repeated for these documentation-only changes.

## Global support and sparse conductors — 2026-11-27 UTC

Baseline is local commit `1d1410fd3e844d01f91ad2c6427bba6f6830e77a`.
The global-support packet received independent read-only criticism from
`/root/generating_review`, captured at
`/tmp/pi-m4-global-support-paper-review-20261127.txt`. **D1: resolved:**
the exact singleton requires max(K,floor(N/7))<=i<N; the original statement
admitted forbidden zero-prefix indices. **I1: resolved:** the homogeneous
content test only needs possible content primes r>=7. Both repairs were
inspected in immutable report v3, with no other mathematical change.
**Q1--Q2: open:** arbitrary exceptional-support cancellations and the distinct
actual-V bridge. The explicit primitive CRT family is not a short dual.

The parent read and reconstructed the complete report, checker and criticism.
Its byte-unchanged replay in `/tmp/pi-m4-global-support-parent-replay-20261127/`
passed 7,047 exact checks, identical receipt, all eight originals preserved.
The new `/tmp/pi-m4-global-support-isqrt-20261127/check-v3.py` only replaces
floating prime enumeration by isqrt; its identical receipt passed, and the
reviewer inspected that exact delta. Finite Q11 checks concern original
rows, primitive values and coordinate identities; Q11 is not exceptional.
The large fixed Q and universal bounds remain paper mathematics.

The sharp sparse-support packet is
`/tmp/pi-m4-sparse-newton-support-20261127/`. Parent full reconstruction and
byte-unchanged replay passed, exit 0, identical receipt and four preserved
manifest-bound originals. It includes 154 independent conductor-minor checks,
101 global-dual denominator checks, all root/globalization tests and 808
complete-tail scalar minimizations. These finite results do not certify
universal localization or asymptotic sparsity. Independent criticism by
`/root/generating_review` completed, captured verbatim at
`/tmp/pi-m4-sparse-newton-paper-review-20261127.txt`. **D: none; I: none
required. Q1--Q3: retained open:** dense-support cancellation, attainment for
prescribed global a-support, and the separate global-covering/actual-V bridges.
The reviewer reconstructed the local sharpness, complete root interface,
denominator bound and full-tail asymptotic consumer, and verified all four
manifest-bound hashes and replay identity. Executions remain caller evidence.
Final exact task-owned-diff review and focused repairs completed as below.

Both adversarial guides and the replacement procedure govern these reviews.
The completed reviewer performed read-only inspection, hashing and mathematical
reconstruction, with no checker, probe, build, extractor, mutation, service
or delegation. Earlier envelope/orthogonal/Newton estimates remain paper
inputs. No Lean theorem or V acceptance is claimed. The negative-anchor
inquiry is excluded from this checkpoint's mathematical scope.

The frozen five-path integration packet is
`/tmp/pi-m4-global-sparse-review-20261127/`, diff SHA-256
`7e7cf5c5a08903223717765bc80bb2aef3905fe02d79121721d035b32f17d90e`.
Full initial response `review-full.txt` has SHA-256
`9d73183b53db4afcdc9bfe716ef807b0b19ae81df2da2825d424124a16bcc902`.
Reviewer `/root/generating_review` verified all five production, 33 evidence,
two guide and 28 preservation hashes and inspected the entire diff.
**D1/I1: resolved** as above. **D2: resolved:** production now requires m>1,
prime factors at least 7 outside Q, and products of all eligible primes up to
a growing bound for the divergent limit. **D3: resolved:** local chain
coefficients are gamma_m; b_j remains the positive budget. The exact repair
diff has SHA-256
`4056d00fbecc03a6431959dcd004eeaded4a94294295e862567ec332d61b998a`.
Focused response `followup-full.txt` confirms both repairs and no other drift.
**Q1--Q3: retained open:** larger-support cancellation, prescribed global
support attainment, and global covering versus actual V. Documentation
(93 files), process tests (38), whitespace and protected/unrelated preservation
passed. No arithmetic rerun was requested for the domain/notation repairs;
no Lean build was repeated for these documentation-only changes. Subsequent
edits record review outcomes only. This accepts a local research checkpoint,
not V or M4.

## Actual negative history and canonical selection — 2026-11-27 UTC

Baseline is local commit `7268e5525e60106246ebf2160ae4aa29049b9da4`.
Independent reviewer `/root/m4_strategy_reset` completed read-only criticism of
`/tmp/pi-m4-negative-anchor-consumer-20261127/report-v1.md`, SHA-256
`a30351d15e259db56fea364551888437b589f0f07918db7ad423f4897620e7c0`,
its checker, receipt, manifest and completion signal. The full response is
`/tmp/pi-m4-negative-anchor-paper-review-20261127.txt`. **D: none. I1:
resolved:** the new immutable report v2 explicitly states
f_n=bbpRecurrence(n+1) for n>=0 and the quantifiers of C_odd, distinguishing
the raw anchor from the inclusive prefix. Focused response
`/tmp/pi-m4-negative-anchor-followup-20261127.txt` confirms that sole delta
and all five preserved original hashes. **Q1: retained open:** actual lower-even
remainders cannot yet be shown to leave [0,1) arbitrarily late.

The reviewer reconstructed the backward recurrence, strict negative-cell bound,
anchor carry, Q_2 cancellation, both rounding constructions and initial
transition, parity equivalences and continuity witnesses. Both adversarial
guides were read in full and retain their earlier hashes. No checker, probe,
build, extractor, mutation, service or delegation was performed by the reviewer.
Parent unchanged-copy replay at
`/tmp/pi-m4-negative-anchor-parent-replay-20261127/` passed, exit 0, identical
receipt and five preserved originals. Its negative samples and synthetic
rounding checks do not prove the universal identities. Only initialization
and its first transition were checked among actual nonnegative states.
The reflected-graph input and new identities remain paper mathematics.
Final changed-file review completed; ongoing descendant and fresh-selection
inquiries are excluded from mathematical acceptance here.

The exact five-path packet is
`/tmp/pi-m4-negative-anchor-integration-review-20261127/`, diff SHA-256
`910e646b97b77bead4d201045a689b5f50a96555c41c47d62945ace7a4646033`.
The full response is `review-full.txt` in that packet. Independent reviewer
`/root/generating_review` verified all five production, 15 evidence, two guide
and 28 preservation hashes, inspected the entire diff and reconstructed the
identities against the actual recurrence. **D: none. I1: resolved; no new
recommendation. Q1: retained open:** actual canonical parity remains unproved.
Documentation (93 files), process tests (38), whitespace and preservation
checks passed as caller evidence. No Lean build was repeated for these
documentation-only changes. Subsequent edits record review outcomes only;
the checkpoint does not accept C_odd, V or M4.

## Descendant costs and relative forcing — 2026-11-27 UTC

Baseline is local commit `974a8f17f0693156f027ade70552356a3b639626`.
Independent reviewer `/root/m4_strategy_reset` reconstructed the descendant
packet: envelope divisibility, original source rows, completion-independent
norm bound, fixed-prime infinite conclusion and full-tail consumer. Full
response `/tmp/pi-m4-descendant-paper-review-20261127.txt` records **D1:
resolved before review:** the strict certificate needs a nonzero witness.
**I1: resolved:** its strict integer bound permits a certificate at most 1.
The sole follow-up delta is captured in
`/tmp/pi-m4-descendant-followup-20261127.txt`; corrected report v3 has SHA-256
`deaec85f92fdfbd3ce6cc5d08fe1973f5793b4009beeb3b69e5424c7eaadf182`.
**Q1: retained open:** realize the normalized difference using nonzero
admissible defects within all budgets. Exact zero-defect collapse does not
imply full-lattice collapse. Parent unchanged-copy replay passed 1,144 checks,
identical receipt and six preserved originals.

Independent reviewer `/root/generating_review` reconstructed the relative
cyclotomic image, parity fixtures, interval counting, tail-shifted cells and
finite/all-future stabilizer collapse. Full response
`/tmp/pi-m4-canonical-selection-paper-review-20261127.txt` records **D: none.
I1: resolved:** automorphisms fix rational prefixes; the chosen exponential
relation and replacement lifts need separate treatment. The sole clarification
passed follow-up at `/tmp/pi-m4-canonical-selection-followup-20261127.txt`.
Corrected report v2 has SHA-256
`f501be5671dc1f7ef543d8cc92e284e3fd3c367d97eac5cb55520b635e358338`.
**Q1: retained open:** select the actual initialized phase. Parent replay
passed 8,076 checks, identical receipt and four preserved originals; these
finite checks do not prove the growing-block or asymptotic arguments.

Both reviewers reused full unchanged adversarial guides, the replacement
procedure and critic skill. They inspected sources, hashes and receipts but
ran no checker, probe, build, extractor, mutation, service or delegation.
Universal claims retain their paper status. The ongoing grid-escape test and
any optional shorter field-collapse bound are excluded. Final exact task-owned
integration review completed as below; no V/M4 or Lean acceptance is claimed.

The frozen six-path packet is `/tmp/pi-m4-descendant-relative-review-20261127/`,
diff SHA-256
`8450567174caaeade9756dd891826907cd688d2004b16f6f6177991d589d5405`.
Full initial response `review-full.txt` has SHA-256
`34c6639a3c77c74abd68ca9b18f714a48a72dadaec126799f00ae9c5ff03fa28`.
Reviewer `/root/generating_review` verified six production, 31 evidence, two
guide and 28 preservation hashes, and reconstructed the complete integration.
**D1 and both I1 items: resolved** as above. **I2: resolved:** the counting
window is an interval, while each lifted divisor residue class is an arithmetic
progression. The sole repair delta has SHA-256
`f300f93123ecfad6a4e0370ca93c63fb006b244cc92a405dcee1eadf9d247f02`;
`followup-full.txt` confirms it and no other drift. **Q1--Q2: retained open:**
bounded nonzero-defect realization and actual phase selection, with global
covering and V still separate. Documentation (93 files), process tests (38),
whitespace and preservation checks passed as caller evidence. No arithmetic
rerun or Lean build was required for the wording repair. Subsequent edits
record outcomes only; the current grid inquiry remains excluded.

## Finite-grid escape and source limits — 2026-11-27 UTC

Baseline is local commit `c25b65627b8757fc6b10bcef67177feb633fdfba`.
Independent reviewer `/root/generating_review` reconstructed the completed
grid packet, report SHA-256
`33b49c60163ad2a1b3441b332a97d1c23b757d7086e54ffa822f32c6404fd162`.
Full response `/tmp/pi-m4-finite-grid-paper-review-20261127.txt` records
**D/I: none. Q1: retained open:** the particular threshold covering estimate.
**Q2: retained open:** the capped N=3 search is inconclusive. Its completion
is not required to validate the finite claim. C<5 is excluded only for the
stated bound uniform in every N, not an eventual bound with small exceptions.
The reviewer inspected both checker sources and six bound hashes but did
not execute them. Parent unchanged-copy replays subsequently passed with
matching mathematical receipts and originals preserved.

Independent reviewer `/root/m4_strategy_reset` inspected the source packet,
report v1 SHA-256
`00faba698d020c2c1b8eae804fe09cc89b66941093b4ff0b3b391df6e676ef77`.
Full response `/tmp/pi-m4-fractal-separation-paper-review-20261127.txt`
records **D: none. I1: implemented:** explicit b>=3, xi in (0,1), positive
r,q and digit range. Corrected immutable report v2 has SHA-256
`dfae78226ab0ad1e2b6cc4d74140639ccbdb96a645d357ea7888ab685f71ddb8`.
**Q1--Q3: retained open:** canonical-language identification, reduced
replacement denominators, and actual uniform escape/C_odd/V. The reviewer
independently viewed all four rendered source pages and checked thirteen
packet hashes; retrieval/rendering remained caller evidence. The source
proofs and full literature were not audited.

Both reviewers read the required unchanged adversarial guides and replacement
procedure. Neither ran a checker, probe, extractor, build, mutation, service
or delegation. Parent PDF rendering recovered by using a writable temporary
cache; this was a tooling issue, not a mathematical obstruction. The ongoing
shifted-coefficient inquiry is excluded. No universal estimate, Lean result
or M4 acceptance is claimed.

Initial exact integration review completed against the frozen five-path diff
`59b47914b2442223c93c238d6383339630fa021568c47d3125e6c0a1dd5e98b4`
in `/tmp/pi-m4-grid-source-review-20261127/`. Full response is retained as
`review-full.txt`. Reviewer `/root/generating_review` verified five production,
33 evidence, two guide and 28 preservation hashes, reconstructed the integration
and compared parent replay receipts. **D: none. I1: resolved** as above.
**I2: resolved:** explicitly retain 2<=|W|<b from the source's p.1
definition and Delta>0 in the local separation contract. Report v3 preserves
the originals and the additional rendered page; the eight-digit application
is unchanged. **Q1--Q2: retained open:** universal escape and source-to-actual
orbit bridges. The focused repair review passed. Publication-ref changes
and the newly bounded meta-plan pass are recorded separately from mathematics.

The complete repaired diff has SHA-256
`63748ae9d7e2fdd98e91293080d0d0853aeadc793e97cafb8bf0dbb56a315cac`;
its diff-of-diffs against the original has SHA-256
`3c11f210664a8c828d629951200c6d059094c4c45b78087f5c23bb635e9c60a2`.
Full initial and focused responses have SHA-256, respectively,
`8eca58d145a32908eb5da043c6f62f9584dd1fbc15fd98c2bbd58c407873b830`
and `bdea12a0417f83314c9b9712178acbc97c29145da78cacb3419499385f1e3bf0`.
The focused review verified all revised production/extra-evidence hashes and
the unchanged originals, with no further finding. Documentation (93 files),
process tests (38), whitespace and preservation checks passed as caller
evidence. No Lean build was repeated for this documentation-only checkpoint.
Subsequent edits record review outcomes only; the ongoing research is excluded.

## Rational gauges and conditioned endpoints — 2026-11-27 UTC

Baseline is local commit `890a4e0f2a390998c423c2235e0ee3287c24ea41`.
Independent reviewer `/root/global_dual_recovery` reconstructed the original
lag packet, report SHA-256
`64a6243355fdecfe31e598c9680b18e06d20188282fe5f86c9ca567935f93344`.
Full initial response `/tmp/pi-m4-rational-lag-paper-review-20261127.txt`
records three defects. **D1: resolved:** require nonzero W in the ancillary
coefficient-norm bound. **D2: resolved:** specialize truncation signed errors
to beta=0; even beta preserves parity but changes the signed error.
**D3: resolved:** withdraw the overbroad survivor limitation and retain the
exact matched-endpoint correlation and its finite-grid estimate.

The authoritative correction/extension is
`/tmp/pi-m4-endpoint-conditioned-clarification-20261127/report-v2.md`,
SHA-256 `606c85e7b81ace8ef89882a46c7769b79198481e76e4bf959849969c874bb604`.
The original lag packet and the worker's first extension remain immutable.
Full focused response `/tmp/pi-m4-rational-lag-followup-20261127.txt`
reconstructs the endpoint interval, uniform parity-word pushforward,
component/Mobius count, fixed-horizon exponent, growing-truncation range
and exact resonance-bound negativity. It finds all D1--D3 resolved and no
new defect or required improvement. **Q1: retained, narrowed:** long-horizon
estimates, actual-seed selection and intermediate model-carry transfer remain
unproved. None supplies actual escape, C_odd or V.

Both reviews applied the two required adversarial guides and the current
replacement procedure. The reviewer inspected source/checkers/receipts and
parent reconstruction but ran no checker, probe, build, extractor, service,
mutation or delegation. Parent unchanged-copy replays passed 1,971 initial
cases and 1,400 complete synthetic set comparisons with identical receipts;
all bound originals were preserved. Those finite checks do not establish
the universal or asymptotic paper claims. Final exact changed-file review
completed as below. The separate meta-plan pass and any subsequent research are
excluded; no Lean or M4 acceptance is claimed.

The frozen five-path diff is retained in
`/tmp/pi-m4-gauge-endpoint-review-20261127/`, SHA-256
`05a69aae6e6d952285b9e1f00ab4f4e4f8a20d5e52ac93c26f4d6c9b3d0b4c78`.
Full response `review-full.txt`, SHA-256
`6916edfb0b61636a00366c287d7a2f109219173b437208c6698d415dde734fc3`,
is retained with the manifest and caller receipts.
Reviewer `/root/generating_review` independently reconstructed the
integrated argument and checked all five production, 24 evidence, two guide
and 28 preservation hashes. **D1--D3: resolved. New D/I: none. Q1: retained**
as the narrowed mathematical obligations above. Documentation (93 files),
process tests (38), whitespace and preservation checks passed as caller
evidence; no Lean build was repeated for these documentation-only changes.
Subsequent edits record outcomes only. The new bounded recovery is excluded.

## Progression conductors and recovered ideation — 2026-11-27 UTC

Baseline is local commit `390730c8b88922a55dd0306e1f49ce6e9b06029c`.
Independent reviewer `/root/generating_review` reviewed the completed packet
`/tmp/pi-m4-progression-dual-support-20261127/`, report SHA-256
`81f529634d63eb7650a2a0daa58f83c65ff6b1857ba63399c49e0a2dd45b4166`,
and the compact recovered meta screen, SHA-256
`a083329fa7f9644c347b2029a66da3bdba0322c537e569b57788d5cdbc8c4ad6`.
Full response is `/tmp/pi-m4-progression-paper-review-20261127.txt`.

**D: none. I1: deferred:** determining the exact conductor when extra prefix
zeros remain would improve a finite interface, but is unnecessary for the
proved sandwich/asymptotics and does not remove the primorial barrier.
**Q1: retained open:** a complete-norm bound for arbitrary cancellations at
exceptional progression tops. **Q2: retained open:** comparison-class results
do not select the fixed initialized BBP trajectory or establish V. These are
limits of the claimed result, not missing validation of its conditional math.

The reviewer reconstructed the root adjustment, all-prime localization,
finite-prefix isolator, p|Q sampled row, exact-conductor primitivity,
asymptotic/full-tail consumer and exposed-coefficient normalization. It also
checked the raw homogenization and quadratic-norm counterfixture in the meta
screen. Both required adversarial guides and the critic skill were applied.
The worker's self-criticism was explicitly not treated as independent review.

Parent unchanged-copy replay passed 8,430 checks, including 2,968 original
uncleared rows, with a byte-identical receipt and all six original artifacts
preserved. The meta receipt covers only the symbolic polynomial identity and
A(1) counterfixture, not the worker's unstored checks. The reviewer inspected
the sources and hashes but ran no checker, probe, build, extractor, service,
mutation or delegation. No Lean, actual phase, covering or V claim follows.
Final exact changed-file review completed as below. The two new bounded inquiries
are excluded from the accepted mathematical scope.

Documentation (93 tracked Markdown files), process tests (38) and working
whitespace checks passed. No Lean build was repeated for this documentation-only
checkpoint; protected Lean, audit and dependency files remain unchanged.

Initial exact integration review completed against the five-path frozen diff
`03c6269b3842c3f6e1ebbea75b63bd3a18b4de78a6ed4334f51772da191013bf`
in `/tmp/pi-m4-progression-review-20261127/`; full response is
`review-full.txt`. All 22 manifest-bound and 28 preservation hashes matched.
**D1: resolved in focused review:** restore fixed K,Q,B and actual tops
ell tending to infinity in the liminf consequence. Merely increasing the
ambient cutoff permits a fixed short small-top dual; the authoritative paper
report already retained the growing-top hypothesis. **I2: implemented:** update
the handoff's latest-continuation link. **I1: deferred; Q1--Q2: retained** as
above. No original scratch artifact changed. Focused repair review passed with
no further finding. Its full response is `focused-review-full.txt` in the same
packet. The repaired full diff has SHA-256
`caed1d6eeea7d1a7ac0e8e76493c0f50fed03caa61aa89b51640e9380ccae239`;
the diff-of-diffs has SHA-256
`e2ce3f415f5bcaddc7f6bd17da05ddaf664387c03ad6b0d6ae05188f1b4f70ab`.
All revised production, original evidence and guide hashes matched. The
documentation and whitespace reruns passed; the process tests remained
unaffected. Subsequent changes record review outcomes only.

## Polynomial norms and logarithmic source limits — 2026-11-27 UTC

Baseline is local commit `f18bcb21d09dbbfc3d14f32f7361d780749b3c9e`.
Independent critic `/root/generating_review` reviewed the full polynomial
packet, original report SHA-256
`d1071452795ecd5bbffefaeb7f7735d5feebbb400be031ad2a4f85e0b7e7ad41`.
Full initial and focused responses are
`/tmp/pi-m4-dual-polynomial-paper-review-20261127.txt` and
`/tmp/pi-m4-dual-polynomial-focused-review-20261127.txt`.
**D: none. I1: implemented and verified:** the retained normalized row
requires K<=ph-1<N; untruncated identities have broader scope. Immutable v2
has SHA-256 `5b06f6a56ffb7827ece1b301ce0d490829dea2fb5d30ac737b05315666290c66`.
**Q1: retained open:** coupled arithmetic control of the complete quadratic
ratio. **Q2: retained open:** target-sensitive covering and actual selection.

The critic reconstructed the full-tail polynomial representation, corrected
zero-index row, period-zero test, positivity, weighted inequality, scaling,
homogeneous leading-only counterexample and target-phase guard. Parent replay
passed 353 exact checks with a byte-identical receipt and six originals
preserved. The mixed fixture's large integer weights are not a primitive or
optimality claim. The critic inspected the checker but did not execute it;
the worker's self-criticism was not accepted as independent review.

Independent `/root/logarithmic_source_review` reviewed the two source contracts,
original report SHA-256
`3324fb0c56db9ebe29ae2d155f963d799d1418d9720c68ae71ba83f88bf03ade`.
Full responses are `/tmp/pi-m4-logarithmic-source-review-20261127.txt` and
`/tmp/pi-m4-logarithmic-source-focused-review-20261127.txt`.
**D: none. I1--I2: implemented and verified:** explicit positive word length
and late-start domains; reverse late-transfer identity and margin, distinct
from direct forward B4 use. Authoritative v2 SHA-256 is
`82e071fd0256c36287d4d1760542731039fc970ebdb371dde0658ddfbd241862`.
**Q: no blocking source-screen question; mathematical bridges remain open.**
Complexity does not imply full language, and point membership does not give
the required nontrivial embedding. Both full external proofs remain unaudited.

Parent and source reviewer inspected all six source PNGs and relevant local
types. All 18 original artifacts were preserved. Publisher theorem text was
retained separately; retrieval, date and rendering provenance remain caller
evidence. Both reviewers applied the two required full adversarial guides,
replacement procedure and relevant skills. Neither ran checkers, probes,
builds, extractors, services, mutations or delegation. No result supplies
covering, actual C_odd/V or M4 acceptance. Final changed-file review completed;
the fresh actual-seed research is outside the accepted mathematical scope.

Documentation (93 tracked Markdown files), process tests (38), working
whitespace and preservation checks passed. No Lean build was repeated for
this documentation-only checkpoint; no protected mathematical input changed.

Initial complete integration review by `/root/logarithmic_source_review`
examined the frozen six-path diff in
`/tmp/pi-m4-polynomial-source-review-20261127/`, SHA-256
`aaf3ac6d608e4598eaa603c843b611a2123322ae3ee3aef3c73f4c1c0141fb8a`.
Full response is `review-full.txt`. **D: none. I1: implemented and verified
in focused review:** state dist(theta*delta,Z)>E_N(w,theta) explicitly in the
roadmap, retaining that absence of a certificate does not prove covering.
**Q1--Q2: retained** as the coupled arithmetic and target/actual-selection
obligations. Source-domain and pointwise/embedding gaps remain explicit.
The reviewer independently reconstructed the mathematical integration,
verified all six production hashes and checked the authoritative report and
replay identities. The complete 39-evidence and 28-file preservation hash
inventories remain parent execution evidence; the reviewer inspected them
without independently recomputing every entry. No ongoing reset result was
adopted. Focused clarification review passed; full response is
`focused-review-full.txt` in the same packet. The repaired six-path diff has
SHA-256 `515d976f88f43cd6a7e93b498631db3fc88c8773a6182ddf1a67cc01b43d8eaa`,
and the diff-of-diffs has SHA-256
`8e876d114edffb433e765c756398ac3e4859599300f0575bc79ada9339c2731e`.
The reviewer verified the actual diff and all revised production hashes.
Documentation and whitespace reruns passed; process tests remained unaffected.
Subsequent edits record review outcomes only. The cycle has no remaining
defect or required improvement; its mathematical obligations remain open.

## Ordered reciprocity and exact affine updates — 2026-11-27 UTC

Baseline is `73dd5cae0f7799b35aa5c75bd7027b43360c899d`.
Independent `/root/generating_review` inspected the completed reset packet,
original report SHA-256
`24870f47aa46145999dcd0f3df2fd3f58522a98e20eed34bdf6a86cd61b774f5`.
Full initial and focused responses are
`/tmp/pi-m4-reciprocity-paper-review-20261127.txt` and
`/tmp/pi-m4-reciprocity-focused-review-20261127.txt`.
**D1--D2: repaired and verified:** the finite sum is defined beyond coprime
pairs; the collision requires odd q>1 and canonical inverse units.
**I1: implemented and verified:** replacements share the sum with each other,
without asserting agreement with the actual statistic. Authoritative v2 has
SHA-256 `8c1c0ffd96cc5889f96bc6501ebc515e37d759529455ca3776497d771746bd5a`.
**Q1--Q2: retained open:** actual-history selection and richer shifted-sum
consumers. The specified sign-rule failure does not settle those questions.

The reviewer reconstructed inversion, the modular lift/floor argument and
the even-numerator half-shift identity, and inspected every original artifact
hash. Parent replay passed 160 exact checks, identical receipt and five
preserved originals. Finite executions remain caller evidence; universal
identities are paper results. Original packets were not overwritten by fixes.

The separate affine packet's report SHA-256 is
`7c083ca4a3bc6884644b214cd71d1969c65954b2f7e84b02a717ef420d3da2fe`.
Parent reconstruction and unchanged-copy replay passed 78 exact checks,
with an identical receipt and seven original artifacts preserved, recorded
in `/tmp/pi-m4-affine-reciprocity-parent-20261127/replay.json`.
The parent opened the primary source and visually inspected printed p.389.
Its classical reciprocity statement is used; no full source-proof audit or
application of the general three-variable theorem is claimed. Independent
affine paper review by `/root/generating_review` completed; full response is
`/tmp/pi-m4-affine-reciprocity-paper-review-20261127.txt`.
**D/I: none. Q1: retained open:** control of the weighted correlation at the
actual initialized entries. The reviewer reconstructed reduction for every
positive g, endpoint cancellation, the bound, synthetic outputs and precision
lifts, both reciprocal formulas and raw/canonical parity. It inspected the
primary page and all six manifest-bound hashes. Executions remain caller
evidence. Final exact changed-file review completed as recorded below.

Both adversarial guides and the user-directed replacement procedure apply.
No new Lean declaration, audit, pin, dependency or trust assumption is added.
No calculation supplies actual C_odd/V or M4 acceptance. The new exact-function
recovery is outside this packet's accepted mathematical scope.

Documentation (93 tracked Markdown files), process tests (38) and working
whitespace passed. The 17 protected and 11 unrelated hashes are preserved.
No Lean build was repeated for this documentation-only checkpoint.

Full integration review by `/root/logarithmic_source_review` completed on
the frozen five-path diff, SHA-256
`53b14d4603b2bfe3e789247523f72a85437bfb62f06458804248cdbf5ab2078a`.
Packet `/tmp/pi-m4-ordered-affine-review-20261127/` retains `initial.diff`,
the 5-production/25-evidence manifest, preservation inventory and full
`review-full.txt` response. **D/I: none newly identified. Q1--Q2: retained
open:** actual initialized control and richer history-dependent consumers.
The earlier D1/D2/I1 repairs remain correctly integrated. The reviewer
reconstructed the mathematical arguments, inspected the primary page and
verified the actual diff, five production hashes and authoritative reports.
Complete evidence/preservation inventories remain parent execution evidence;
the reviewer did not independently recompute all entries. No checker, probe,
build, extractor, mutation, service or delegation occurred. No substantive
repair was required; subsequent changes record outcomes only. The review
cycle is complete, with its mathematical obligations unchanged.

## Finite algebraic and tail profiles — 2026-11-27 UTC

Baseline is `f09cf5d382d16078118f97659d5cceb67ed872ef`.
Independent `/root/generating_review` reviewed the complete worker packet and
parent extension, with full combined/focused response retained in
`/tmp/pi-m4-finite-profile-paper-review-20261127.txt`.
The original report SHA-256 is
`aaaf45bc62a7f2f22992a223e1f8a99dd3f3efa1e869a8f2b1c9f4fb8abf3699`;
the extension v1 is
`e987bb2baf3cebfa941b5e25d2dd8c513ee24e97496a1fdf83b1b1fa5e15fb67`.
Authoritative extension v2 is
`/tmp/pi-m4-tail-profile-zero-clarification-20261127/report-v2.md`, SHA-256
`47c47e0caa7e1b0bb7a3206b509cea324e26b79ff71b5c3af279494054644e37`.

**D1: repaired and verified:** the zero theorem annihilates the complete
algebraic remainder, including -sum c_(t,r)/(8x+r), not its first line alone.
**I1: implemented and verified:** the source supplement retains the already
read finite negative-power paragraphs omitted from the first capture.
**Q1: retained open:** avoidance does not produce a finite profile family.
No effective or parameter-uniform zero threshold is claimed. Fixed branches,
constant tail coefficients and finite families are retained throughout.

The critic reconstructed the recurrent graph and pole proofs, minimal
polynomial coefficient argument, F carries and weighted residue, Laplace
interchange/remainders, uncancelled pole, Puiseux comparison, complete sampled
residual and initialized lift. It checked both full reports/checkers, manifests,
receipts, source extracts and exact correction. All bound hashes matched.
Parent worker replay passed 492 checks with an identical receipt and five
preserved originals; 136 separate coefficient comparisons passed. These
executions remain caller evidence and do not certify the analytic arguments.

The source application after w=1/x and inversion for a pole was checked;
the full Newton--Puiseux proof was not audited. No external Lean theorem was
imported or new project theorem claimed. The reviewer applied AGENTS, the
replacement procedure, critic skill and both previously fully read adversarial
guides with unchanged hashes. No checker, probe, build, extractor, mutation,
service or delegation occurred. Production integration review completed as
recorded below; the ongoing language inquiry supplies no adopted result.

Full integration review by `/root/logarithmic_source_review` completed on
the frozen five-path diff, SHA-256
`d9195fc7aa7c492822f1dd0146bb428d27155bba0e2e1488f2641daedbff531d`.
Packet `/tmp/pi-m4-finite-profile-review-20261127/` retains `initial.diff`,
the 5-production/18-evidence manifest, preservation inventory and full
`review-full.txt`. **D/I: none newly identified. Q1: retained open:**
avoidance supplies no finite profile family. Earlier D1/I1 repairs remain
correctly integrated. The reviewer reconstructed both arguments and their
consumer, checked the source application and verified the actual diff,
five production hashes and authoritative reports. Complete artifact and
preservation inventories remain caller evidence, not an independently
recomputed inventory. No prohibited execution, mutation or service occurred.
Documentation (93), process tests (38), whitespace and preservation checks
passed. No unchanged Lean build was repeated. Subsequent edits record review
outcomes only; no substantive repair or further focused review was needed.
This diagnostic review cycle is complete; its V obligation remains open.

## Polynomial telescopes and integer-path cuts — 2026-11-27 UTC

Baseline is `7b7f83589bb3e9c85932a4a250460e1079b933b3`.
Independent `/root/generating_review` completed both paper reviews, with
the polynomial focused repair included. Full returned responses are retained
in `/tmp/pi-m4-polynomial-telescope-paper-review-20261127.txt` and
`/tmp/pi-m4-integer-path-cut-paper-review-20261127.txt`.

The polynomial original report has SHA-256
`0671f002789e7ecd05469028aae1594267a69dab8196d09db8ed0ae5c79ccf30`;
authoritative v2 is
`/tmp/pi-m4-language-consumer-clarification-20261127/report-v2.md`, SHA-256
`e15d546d3ad8203d4c9af55636b90064f78f8bbbb74abd4cc0964eb3511a2b12`.
**D1: repaired and verified:** the multiplicative sign factor equals 1,
rather than vanishing, under even carries. **I1: implemented and verified:**
the prospective integer-path contract explicitly starts at N>=1.
**Q1: retained open:** a symbolic actual-numerator separating certificate.
The reviewer reconstructed the branch-identity argument, affine/parity
obstruction, weighted boundary terms and geometric specialization, and
integer-path equivalence. It did not extend sampled equalities to intervals
or reject all analytic/automaton potentials.

The integer-cut report is
`/tmp/pi-m4-integer-path-cut-test-20261127/report-v1.md`, SHA-256
`46c21cbe72ebc43ed11de29d9321f03af948337833d7bbd5b17ab088e3a9214a`;
manifest SHA-256 is
`d4502a718e6d3866b1010fb5c578d0a7604687d6d318ab88ed6d1346094b07b1`.
**D/I: none. Q1: retained open:** the actual residual-window estimate.
The reviewer reconstructed strict-grid closure including integral coordinates,
integer-only increment redundancy, primitive width and sharp exact-cancellation
bounds, both open pair windows and modular resonances, the equal-envelope
parity corollary and both synthetic fixtures. It retained the distinction
between one projection and simultaneous/stronger constraints. All bound
original artifact hashes matched in both reviews.

Parent unchanged-copy replays passed 380 and 4,136 checks, with identical
receipts and preserved originals. The finite executions remain caller
evidence, not certification of universal paper arguments. The reviewer read
complete reports/checkers/receipts and the scoped clarification, applying
AGENTS, the replacement procedure, critic skill and both full adversarial
guides. It executed no checker, probe, build or extractor and made no change,
service call or delegation. No external theorem was needed.

Full five-path integration review by `/root/logarithmic_source_review`
completed on frozen diff SHA-256
`06c3a79e5486cf90b7db6e3294f89bd29fe0ace4d3f19097ad53e3a0f649d1f4`.
Packet `/tmp/pi-m4-polynomial-cuts-review-20261127/` retains `initial.diff`,
manifest, preservation inventory and full `review-full.txt` response.
**D/I: none newly identified. Q1: retained open:** the actual separating
estimate beyond every anchor. The earlier sign-factor/domain repairs remain
correctly integrated. The reviewer reconstructed both arguments and fixtures,
verified the actual diff byte for byte, and verified all 5 production,
22 evidence, 2 guide, 17 protected and 11 unrelated hashes. Caller executions
remain distinct from its read-only inspection; no prohibited execution,
mutation, service or delegation occurred.

Documentation (93), process tests (38), whitespace and preservation checks
passed. No unchanged Lean build was repeated. Subsequent edits record review
outcomes only; no substantive repair or focused review was needed. This
diagnostic review cycle is complete, with no M4 acceptance. The coupled-resonant
inquiry remains outside this packet's accepted mathematical scope.

## Coupled cycles and the failed order-scaled stencil — 2026-11-27 UTC

Baseline is `ed9c0d96679cf1ee4c197e8ca12be6074fa7d8d8`.
Independent `/root/generating_review` completed the coupled paper review;
its full response is
`/tmp/pi-m4-coupled-resonant-paper-review-20261127.txt`.
Report SHA-256 is
`55edc6090bf7f02bd39c99273412ae838451da1b31847f4a978850d2d845af60`;
manifest SHA-256 is
`7e73695d9714ba8fd6dc2eb19db8457737feba33243b0ec19a0c59cfdd6d3407`.
**D/I: none. Q1: retained open:** arbitrarily late incompatibility or
exclusion of the prescribed point from the common interval.

The reviewer reconstructed unique rounding, modular cancellation, balance
only for odd q>1, signed incidence and its integer cycle criterion, full
clique real intersection and the separate actual lattice lift. It checked
reflected endpoints, the synthetic positive cycle, the exact-A five-step
forcing certificate and archived index shift. It reconstructed the short
real solution, half-integer changed-entry fixture, and signed order30 at
q=765765 from its factorization. The finite certificate explains known
escape; it does not extend the arbitrary-late frontier.

The critic read the complete report/checker/fixed-anchor JSON/receipts and
verified all five bound artifact hashes. Parent unchanged-copy replay passed
6,889 checks, identical receipt and six preserved originals. These executions
and the earlier exhaustive grid census remain caller evidence. AGENTS,
the replacement procedure, critic skill and both full adversarial guides
were applied; unchanged retained guide readings were hash-verified. No
checker, probe, build, extractor, mutation, service or delegation occurred.
No external theorem was needed.

The extension packet's authoritative report is
`/tmp/pi-m4-actual-cycle-recovery-20261127/report-v2.md`, SHA-256
`aa7a30b30dea7173930dce8b2a046d6a11a687bec19a0a40daee1096fac2510d`.
Parent replay passed with an identical exact receipt and all eight originals
preserved. Its separate paper review by `/root/generating_review` completed;
full response is `/tmp/pi-m4-actual-cycle-paper-review-20261127.txt`.
**D/I: none. Q1: retained open:** other triangles, additional intermediate
constraints, an eventual variant allowing exceptional anchors, and actual
prescribed lattice exclusion. The finite falsifier rejects only the explicit
all-anchor stencil. The critic reconstructed the orders/indexing, strict
rounding and zero circulation, genuine common overlap and changed-entry
sampled lift. It verified v1/v2 and all manifest hashes, including the
separately recorded completion hash. The v2 hypothetical consumer retains
eventual q_N>1 from the archived denominator growth. The same guides and
read-only restrictions were applied; replay remains caller evidence.

Full integration review by `/root/logarithmic_source_review` completed on
the frozen five-path diff, SHA-256
`04a17f5e5a28f1095476910b50174d82b4a59db0d1082a86070ae634587b21c1`.
Packet `/tmp/pi-m4-coupled-cycle-review-20261127/` retains `initial.diff`,
manifest, preservation inventory and full `review-full.txt` response.
**D/I: none. Q1: retained open:** the arbitrary-late incompatibility or actual
lattice estimate, including eventual variants of the refuted all-anchor
stencil. The critic independently reconstructed both arguments and fixtures,
verified the current diff byte for byte, and verified all 5 production,
25 evidence, 2 guide, 17 protected and 11 unrelated hashes. No prohibited
execution, mutation, service or delegation occurred. Documentation (93),
process tests (38), whitespace and preservation checks passed. No unchanged
Lean build was repeated. Subsequent edits record outcomes only; no substantive
repair or focused review was needed. This diagnostic review cycle is complete.
The separate source inquiry supplies no adopted claim in this checkpoint.

## Finite-field conjugacy and its vanishing constant — 2026-11-27 UTC

Baseline `02efb999a5d24a8588cd120636590984d1f14079`. This five-path
documentation checkpoint adds an exact inverse-sum comparison, finite-field
conjugacy and a split-prime finite-logarithm identity in `m4-transform-phases.md`,
with plan/log/handoff/review updates. No Lean or protected interface changes.
V/M4 remain open; the new universal statements are paper mathematics.

The inverse-sum source packet received full separate review and a focused
comparability repair by `/root/generating_review`. The complete responses
are in `/tmp/pi-m4-bbp-sum-source-paper-review-20261127.txt`.
**D1: resolved:** `(log p)^A` is comparable to X, not asymptotically equal
to X. **I: none. Q1: retained open:** cancellation of the actual cumulative
phase across time. Authoritative v2 is
`/tmp/pi-m4-bbp-sum-source-clarification-20261127/report-v2.md`, SHA-256
`66ccc4a38f8c13eb0605524a3f7a4e6d7495c4ec66edef8f9722674a36cf53a5`.
The critic checked the exact objects, units, ranges and existential source
quantifiers; it inspected all five source page images and supplied context.
Parent unchanged-copy replay passed 3,612 checks with identical receipt and
15 original evidence files preserved. Full external proofs were not audited.

The finite-ring packet received full separate review and focused clarification
by `/root/generating_review`; complete responses are in
`/tmp/pi-m4-finite-ring-paper-review-20261127.txt`. **D: none. I1--I2:
resolved:** the real comparison explicitly uses the negative modular sign,
and B(t)=A(t) holds at every point outside A's pole set. Authoritative v2 is
`/tmp/pi-m4-finite-ring-clarification-20261127/report-v2.md`, SHA-256
`37c31e312c277b8f2ca9fdaa0d2c4f5e19653e42228e7c913db0727bef2cd074`.
The critic reconstructed all residue/support tables, boundary p=7, degrees,
finite-part recurrence, global extension bounds and source application.
All 13 manifest artifact hashes and four source page images were inspected.
Parent replay passed 618 checks with identical receipt and 15 originals
preserved. Deep conductor/Fourier proofs were not independently rebuilt.
**Q1: retained open:** selected short-prefix control. **Q2: addressed by
the separately reviewed extension below:** universal split-prime C(0)=0.
The original packet and its contemporaneous open question remain unchanged.

Independent `/root/finite_log_independent_review` completed the constant
review at 13:25:58 UTC. Complete response:
`/tmp/pi-m4-finite-log-paper-review-20261127.txt`. Report
`/tmp/pi-m4-finite-log-constant-20261127/report.md` has SHA-256
`24a1158d2b24a1fe5349d8380f51b4bf6462eb9da9136c5a11b1d9d62fbed5b3`.
**D/I: none. Q1: retained open:** the selected-prefix cancellation estimate.
The critic reconstructed the Laurent finite part, exact -1/128 root filter,
integer-polynomial four-term identity and both split classes modulo 8.
It verified every manifest-listed size/hash and read the full checker and
receipt. Parent replay passed the exact algebra and six previously declared
prime audits, with identical receipt and all five originals preserved.
The universal proof does not follow from these finite checks, and no
convergence of a p-adic infinite BBP series was assumed.

All reviewers used the current replacement procedure, critic skill and both
adversarial guides. They performed only read-only inspection and mathematics;
no checker/build/probe/extractor, mutation, service or delegation occurred.
Execution receipts remain caller evidence, not independent execution or Lean
verification. No actual digit/phase/orbit census was performed.

Full integration review by `/root/finite_log_independent_review` completed
at 13:33:13 UTC on the five-path diff SHA-256
`9bbef4398ffd8c460cbc7f6c2103473f834fece5c741900087a814581fb88315`.
Packet `/tmp/pi-m4-finite-field-review-20261127/` retains the initial and
revised diffs, manifests, preservation inventory, complete `review-full.txt`
and `review-focused.txt` responses. **D: none. I1: resolved:** the source's
normalized discrepancy is explicitly bounded below by a positive constant
depending on A. The focused review completed at 13:34:34 UTC, verifying
exactly that sentence change and the complete revised diff SHA-256
`e622d1f2b3024aebaa228443b760d425840eafb811cae35c177539c90ebf2961`.
**Q1: retained open:** actual selected-prefix cancellation. The critic
independently reconstructed the combined arguments, inspected all nine source
page images and verified every 5 production, 56 evidence, 2 guide, 17 protected
and 11 unrelated hash, plus the live exact diff. Documentation (93), process
tests (38), whitespace and preservation checks passed. Unchanged Lean was not
rebuilt. Subsequent edits record outcomes only. This paper/documentation
checkpoint's review is complete; V and M4 are not accepted.

## Restricted-prefix consumers and a fresh reset — 2026-11-27 UTC

Baseline `8938b680031fcb878481d915871eec734e6760dd`. Five documentation
paths extend the transform-phase owner and update plan/log/handoff/review.
The nonlinear-period reset is an inquiry only; no unfinished result is adopted.
No Lean, protected definition, pin or dependency changed; V/M4 remain open.

Independent `/root/generating_review` completed the original and focused
paper review at 13:39:50 UTC, within its 12-minute bound. Full response:
`/tmp/pi-m4-split-prefix-paper-review-20261127.txt`. **D: none. I1--I2:
resolved:** a uniform approximation margin is explicit, and residue
representatives change by multiples of p before division into angles.
Authoritative `/tmp/pi-m4-split-prefix-clarification-20261127/report-v3.md`
has SHA-256
`c4f312a9f3515c4095e58a5b533bb2c06a66b45213bdb80639d1aa16a92dd6fa`.
Original and intermediate v2 remain preserved; the original-to-v3 delta has
exactly these two clarifications. **Q1: retained open:** the selected time-sum
estimate; moving starts, growing degree, approximate rational functions and
collective cancellation remain outside the proved obstructions.

The critic reconstructed the local root counts, fixed-start finite-difference
and no-wrap argument, and actual residue-1/4 Taylor example in both split
classes. It checked all manifest-bound hashes, actual orbit/tail contracts,
checker source and caller receipts. Parent unchanged-copy replay passed 937
exact algebra checks with identical output and five preserved originals.
Finite checks do not prove the universal arguments. Both adversarial guides,
critic skill and current replacement procedure governed read-only criticism;
no execution, mutation, service or delegation occurred.

Full integration review by `/root/finite_log_independent_review` completed
at 13:45:26 UTC on diff SHA-256
`64d84d470eb5819ff7751bfb681eb171c7494118f2848520b20fecdec5dcc430`.
Packet `/tmp/pi-m4-restricted-prefix-review-20261127/` retains the frozen
diff, manifest, preservation inventory and complete `review-full.txt` response.
**D/I: none additional. Q1: retained open:** the actual selected time-sum
estimate, with all stated exceptions intact. The critic independently
reconstructed the arguments, checked live/frozen diff equality and all 5
production, 16 evidence, 2 guide, 17 protected and 11 unrelated hashes.
Documentation (93), process tests (38), whitespace and preservation checks
passed. No unchanged Lean build was repeated. Subsequent edits record outcomes
only; no substantive fix was needed. This checkpoint's review is complete,
with V/M4 still open and the nonlinear-period inquiry excluded.

## Quadratic-period enclosures and their cost — 2026-11-27 UTC

Baseline `fa00e24728bda3d391c16f8cf9dc6f4018e395ef`. The mathematical
owner is `m4-shared-residuals.md`, with plan/log/handoff/review updates.
No Lean, audit, pin or dependency changes; V/M4 remain open.

Independent `/root/generating_review` completed the reset packet's original
and focused review at 13:54:39 UTC, within its 15-minute bound. Full response:
`/tmp/pi-m4-quadratic-reset-paper-review-20261127.txt`. **D: none. I1--I2:
resolved:** theta_n=fract(S_n)=y_(n+1) preserves the recurrence offset, and
Cauchy square/convolution are distinguished from termwise squaring.
Authoritative report
`/tmp/pi-m4-quadratic-reset-clarification-20261127/report-v2.md` has SHA-256
`caf7a89f2798b8be3bc687d24836ba6b02e21bb340843eeaa7a532d61167ad37`.
Its delta contains only those clarifications; the original is preserved.

**Q1: retained open:** actual enclosure placement outside Z+C_w at selected
late scales. **Q2: retained open:** varying primitive quadratic costs and
possible factorization. The critic reconstructed the dilogarithm grouping,
sign, exact positive-kernel tail bound, equal-cutoff comparison, fresh-prime
cost and mixed cancellation. It checked the avoiding companion's normalization
and lost hypotheses, full checker/receipts and all bound hashes. The archived
source assessment was used as supplied context, not newly audited in full.
Parent unchanged-copy replay passed with identical receipt and all four
originals preserved. It includes one structural p=17 valuation fixture,
not a prime/digit/phase census; finite checks do not prove universal claims.
Both adversarial guides, critic skill and replacement procedure governed
read-only review. No execution, mutation, service or delegation occurred.
The primitive-cost inquiry then received separate criticism as follows.

Independent `/root/generating_review` completed its original and focused
cost review at 14:06:20 UTC. Full response:
`/tmp/pi-m4-primitive-quadratic-paper-review-20261127.txt`. **D: none. I1:
resolved:** branch selection distinguishes Q_prim'(x), x=16^s*pi, from
the normalized derivative at pi. Authoritative
`/tmp/pi-m4-primitive-quadratic-clarification-20261127/report-v2.md` has
SHA-256 `1df903ef7b080617df1a982a0649d97280ac4e475875a386dc026cea112d6a11`.
The critic reconstructed every valuation case, primitive content, W_m=0,
synthetic attainment, discriminant and normalized error formulas. **Q1--Q2:
retained open:** coupled accuracy/height and actual forbidden-set placement.
Parent replay passed all synthetic local cases, 16 normalization identities
and four zero-residual branch checks, with identical receipt and four preserved
originals. Fixed-modulus PNT was used as archived context, not re-audited.
Factorization and production integration were excluded from that paper review.

Independent `/root/finite_log_independent_review` completed the parent-generated
root-parametrization review at 14:06:23 UTC. Full response:
`/tmp/pi-m4-quadratic-root-paper-review-20261127.txt`. Sealed report
`/tmp/pi-m4-quadratic-root-consumer-20261127/report.md` has SHA-256
`fe3d28e07306711c245d4466c5f0098ee4b65a53993afa03c94491d5d6c90665`.
**D/I: none. Q1: retained open:** joint coefficient/root height, residual and
placement. The critic reconstructed the projective pair, second root,
positive-branch signs, zero-root boundary and residual factorization. It
verified all four manifest-bound hashes and inspected the caller's 96 exact
rational fixtures, including the 32 positive-branch and 16 zero-boundary
cases. No actual BBP prefix, digit or phase was evaluated in that test.
The independent mathematical assessment does not constitute independent
execution or a proof of the cost packet it used only as motivation.

All three review passes used both guides and the replacement procedure with
read-only tools; original and repaired packets remain preserved.

Full combined integration review by `/root/finite_log_independent_review`
completed at 14:17:20 UTC on the five-path diff SHA-256
`fbfeba5ea7f93a0a69f30f9329d3f5c804bd6247c04f67319d820f993817ed9b`.
Packet `/tmp/pi-m4-quadratic-family-review-20261127/` retains the frozen
diff, manifest, preservation inventory and complete `review-full.txt` response.
**D/I: none additional. Q1--Q2: retained open:** coupled accuracy/complete
height and actual forbidden-set placement. The critic independently reconstructed
all three arguments and verified the live exact diff, all 5 production,
30 evidence, 3 archived-context, 2 guide, 17 protected and 11 unrelated hashes.
Documentation (93), process tests (38), whitespace and preservation checks
passed. Unchanged Lean was not rebuilt. Subsequent edits record outcomes only;
no substantive repair was required. This checkpoint's review is complete,
with V/M4 open. The qualitative-dynamics inquiry contributes only its
scope/start record here, not an adopted source theorem or mathematical transfer.

## Qualitative density consumer and prime-7 transfer — 2026-11-27 UTC

Paper packet `/tmp/pi-m4-higher-rank-consumer-20261127/` completed at
14:20:18 UTC within its 20-minute bound. Its report has SHA-256
`3a69216322b811cb8783f2181855679103631fae03e0fc9a5acdc9e70b2f98a8`;
manifest SHA-256
`ff35122f7cfb5cee15e21d2c3cfc0d5ac06173cf2bf2e79a87bb4aee78a4dcef`.
It supplies a conditional consumer R7 implies V and tests the actual
prime-7 transfer without dropping its intervening block or canonical floors.
R7 and arbitrary late-index real matching remain unproved.

Independent `/root/generating_review` began at 14:24:12 and completed at
14:27:37 UTC within its 15-minute bound. Full returned response is
`/tmp/pi-m4-higher-rank-paper-review-20261127.txt`. **D/I: none. Q1: retained
open:** the complete late-index real matching estimate, with a witness m
allowed to depend on k and required to be arbitrarily late. The critic
reconstructed the infinite closed-set consumer, including rational-only
limit sets, the finite-K expansion contradiction, matching quantifiers and
residue-class reduction, all p7 block/floor/tail identities, and the exact
limsup obstruction to the naive common-index match.

Parent and critic read and visually inspected the primary scan's printed
pages 47--48: Furstenberg Definition IV.1 and Theorem IV.1. Earlier source
dependencies, including Proposition IV.1, were not fully audited. The
archived alternate-state and prime-defect results remain retained paper
inputs. All ten manifest-bound artifact hashes matched. Parent replay of
an unchanged checker copy passed 35 exact checks, exit 0, identical receipt
and eleven original packet files preserved; replay record
`/tmp/pi-m4-higher-rank-parent-replay-20261127/replay.json` has SHA-256
`d4a43f9237b5667f6a77b705bd88279adac60367cd2bec4abfc72a11a97846a9`.
The one p=7,k=1 fixture and finite algebra checks do not prove the infinite
claims. The critic inspected these as caller execution evidence, performed
no execution or mutation, contacted no service and did not delegate.

The critic used AGENTS, the replacement procedure, pi-argument-critic and
both adversarial guides, verified unchanged. Production integration and
the index-rule follow-up were excluded from this paper review. Full
integration review is pending; no Lean or M4 acceptance is claimed.

The off-index packet `/tmp/pi-m4-off-index-matching-20261127/` completed
at 14:35:15 UTC. Report SHA-256:
`7f453e32792f2627f0a489e5fc334f9e154540747f34e020eff86ce77b4dcf33`;
manifest SHA-256:
`511bef813c7ca5ef5addd2316556fb5089061f2771d5f202b0e49efa0a7ead7d`.
Independent `/root/finite_log_independent_review` began at 14:36:26 and
completed at 14:40:42 UTC, within its 12-minute bound. Full response:
`/tmp/pi-m4-off-index-paper-review-20261127.txt`. **D/I: none. Q1: retained
open:** the real matching estimate at selected returns to each first-coordinate
cluster point. The critic reconstructed both uniform-rule limsup bounds,
all sign/scale and block/floor identities, the fiber quantifiers, and the
P={7} model's applicability. It checked directly that the archived period
interval permits a nondense target different from pi, and verified the
loss of exact defect values under a nonzero period shift.

All four manifest-bound hashes and the prerequisite report matched. Parent
unchanged-copy replay passed 43 exact checks, exit 0, identical receipt and
five preserved originals; replay SHA-256
`bfb80509152e6b68c8bef047f6cc474eac1b324dccee1c4602d0c9fafd46681f`.
Those are caller execution evidence. The critic used both guides and the
replacement procedure with read-only inspection, no execution, mutation,
service or delegation. The full Furstenberg proof and infinite moment
construction were retained inputs, not freshly audited. Integration and
the separate exact-structure reset were excluded; V/M4 remain open.

The exact-coefficient packet completed at 14:38:59 UTC. Parent found a
scope-label error in its zero-seed algebra fixtures and requested an immutable
repair. Authoritative report
`/tmp/pi-m4-exact-structure-clarification-20261127/report.md` has SHA-256
`9a2d83c8d95ee3a8c3399be211d533f03ce420e416958d71dd25c512b2129c38`;
manifest SHA-256
`bdf7545571a58c6719c6068a1f14a6ef67062cf3bba39509af62162a68e63363`.
The repair removes only the zero seed and corrects the evidence count/label;
the original report, checker, receipt and completion remain preserved.

Independent `/root/finite_log_independent_review` began at 14:41:35 and
completed at 14:44:32 UTC within its 12-minute bound, inspecting both original
and corrected packets. Full response:
`/tmp/pi-m4-exact-structure-paper-review-20261127.txt`. **D1: resolved:**
the original blanket synthetic/no-actual-sampling label was inaccurate,
although the actual-prefix algebra fixtures were not a digit census. The
corrected checker removes 23 iterations times three tests and records
2,769 checks. **I: none. Q1: retained open:** no avoidance-to-small-residual
implication is supplied for the actual initialized sequence. The critic
reconstructed the coefficient identity, operator and carry algebra, primitive
content argument, universal carry-pair gap, actual limsup and both all-time
comparison trajectories with their explicit lost hypotheses.

The Bezout conclusion uses a full integer-polynomial certificate, not the
sampled gcd checks. The critic inspected its Euclidean/convolution source;
parent execution verified it. All five original and six repaired file hashes
matched. Parent unchanged-copy replay passed 2,769 checks, exit 0, identical
receipt and preservation of all eleven files; replay SHA-256
`24acf205aae9ff0daba98f50f54096f5983083a4b34792db3f00ca5fc0da5861`.
Both guides and the replacement procedure governed read-only review. No
checker, probe, build, extractor, mutation, service or delegation occurred.
Established tail facts, irrationality and elementary pi bounds remain
inputs; no Lean certification is claimed. Production integration was
excluded and remains pending for the combined six-path checkpoint.

Full combined integration review by `/root/generating_review` began at
14:47:40 and completed at 14:52:34 UTC, within its 15-minute bound.
Packet `/tmp/pi-m4-density-carry-review-20261127/` retains the complete
`review-full.txt` response, initial/focused/revised diffs and manifests.
Baseline: `fb800d8d599295c0cb76d3d865eab3516b47e894`.
Initial diff SHA-256:
`35c8dd47a67bec580e6dd699fc21e8b664244b0526252bec0b8c4d2bba44fd80`.
Revised diff SHA-256:
`24b73cbfede6e73196284f7c54c8629e794f0ec1ddfc6107af77e9dc70d7c7a0`.
**D1: remains resolved. I1: resolved:** the floor terms are an integer
contribution, not necessarily floor(R_sigma), because the remaining
fractional-part combination need not be canonical. **Q1--Q2: retained
open:** real matching/return selection and avoidance-to-small-residual.
No new mathematical defect was found.

The critic reconstructed all three integrated arguments and verified the
live baseline/diffs and all 83 bound files: six production, 44 evidence,
three context, two guides, 17 protected and 11 unrelated. The index was
empty. Source-proof and infinite-model limits remain explicit; all replay
and repository check results are caller execution evidence. Documentation
(93), process tests (38), whitespace and preservation checks passed; unchanged
Lean was not rebuilt. Subsequent edits record review outcomes only. Later
source research was excluded. V/M4 remain open.

## Rational recurrence source boundary — 2026-11-27 UTC

Packet `/tmp/pi-m4-recurrence-source-consumer-20261127/` completed at
14:52:51 UTC, within the 14:48:26--15:08:26 bound. Report SHA-256
`4d0926e7e1703f5cdbbe3e3176df6eb0b2b162e185d6db35f7c8fb7178fbc19b`;
manifest SHA-256
`bc526400cabe39846db830b98bcc8e6b5b6da29aa472a9d1d4b136f62a06dbee`.
Only Luca's publisher abstract and metadata were inspected; full theorem
retrieval failed, so no complete source contract/application is claimed.

Independent `/root/finite_log_independent_review` began at 14:57:30 and
completed at 14:58:56 UTC within an eight-minute bound. Full response:
`/tmp/pi-m4-recurrence-source-paper-review-20261127.txt`. **D/I: none.
Q1: retained open:** actual numerator placement. The critic reconstructed
the recurrence shift, the prime-support and height comparisons, and the
finite-prime-support observation for constant-coefficient recurrences. It
verified all four manifest-bound hashes and inspected the relevant retained
publisher results, XML and retrieval records. The full theorem's definitions
and proof remain uninspected; the prior denominator theorem is a supplied
reviewed input, not freshly source-audited. No checker was needed.

Both guides, critic skill and replacement procedure governed read-only
review, with no execution, mutation, service or delegation. No Lean proof
or literature-wide impossibility result is claimed. Production integration
remains pending; the separate nonlocal-avoidance reset is excluded.

## Rational automaton telescope boundary — 2026-11-27 UTC

Original packet `/tmp/pi-m4-nonlocal-avoidance-reset-20261127/` completed
at 15:15:29 UTC within its 15:00:53--15:20:53 bound. Report SHA-256
`f1ddeb065840b1759f186977216d7c22a5fd3a9baa97135926c889925b677abd`;
manifest SHA-256
`b034087fd281999a7bbcc0b30e3b150e227caaa56106ee54d845cf68ae95cc47`.
Parent unchanged-copy replay passed with identical evidence and five
originals preserved; replay SHA-256
`4b0feaccbc12b2ef827aa89014ec97fbc24d5752f62baa69ed40105415e205d3`.
The graph counts, translation differences and free-entry telescopes are
finite caller execution evidence, not a proof of the classification.

Independent `/root/generating_review` began at 15:19:19 and completed
at 15:21:31 UTC within a twelve-minute bound. Full original and focused
responses are captured in
`/tmp/pi-m4-automaton-telescope-paper-review-20261127.txt`.
**D: none. I1: resolved after clarification:** the full reward sum retains
the state endpoints and C, treats C=0 separately, and obtains the N=0
identity directly from the recurrence rather than extending the late
certificate premise. **Q1: retained open:** a new restriction on the
actual initialized path's discounted sum or boundary.

The authoritative immutable clarification is
`/tmp/pi-m4-automaton-telescope-clarification-20261127/report-v2.md`, SHA-256
`d7dd1f16e1470c2e501f68fcfa75454468ef851431eb6e9a474fcd9b44fce50b`;
exact-delta SHA-256
`bba0650ba1f496bd9984417885dd63e7996ddaee6ede8ff74e9fb87d44327519`;
manifest SHA-256
`19a331d34cd778e4e7d522559a784ecb04fb6ef79bb1e3a1880e92082d89655e`.
Focused review ran 15:22:27--15:22:31 UTC within six minutes, inspected
the full delta and surrounding argument, and resolved I1 without new D/I.
All five original files were unchanged; no checker rerun was needed.

The critic reconstructed the rational identity extension, pole-set and
degree arguments, time-slope equations, prefix propagation, inner-cylinder
index/margin and all period normalizations. It read the complete report,
checker, evidence, completion and parent replay, actual Lean contracts and
relevant archived bridge. Both adversarial guides were read in full, with
hashes `798c3cc974c5296453f510ea9264aa8b5d17c813c8dc217a430de9b68b7d667c`
and `c4a04d75a297c6ec361d31ab11e465e3c3e74a6c89eb590bddb03d95c243ad3b`.
AGENTS, replacement procedure and critic skill governed read-only review.
No checker, probe, build, mutation, service or delegation occurred. Broader
certificate classes and the subsequent inequality inquiry were excluded.
No Lean proof or M4 acceptance is claimed; integration review is pending.

Full six-path integration review by `/root/finite_log_independent_review`
ran 15:39:55--15:42:38 UTC within twelve minutes. Packet
`/tmp/pi-m4-boundary-source-review-20261127/` retains full and focused
responses in `review-full.txt` and `review-focused.txt`, frozen files,
diffs and manifests. Baseline
`d78b31e70a254bf90f192e676f14c79c0e713010`; original diff SHA-256
`69d95a77b27c89153cf0cb3d4ad07f326ce851a4e59914bce0805095fb9457b3`;
revised diff SHA-256
`4dcda5ed149faa3b17767960bb544927c31614bd475bbb1a9e37aa74ec62a658`.
**D: none. I1: remains resolved. I2: resolved after focused clarification:**
scalar v_s may contain A, for example v_s=A; only phase/entry dependence
is removed. The arbitrary scalar boundary supplies no new initialized
constraint. **Q1--Q2: retained open:** selected-path restriction and
source-consumer numerator placement.

The authoritative paper is now
`/tmp/pi-m4-automaton-scalar-boundary-clarification-20261127/report-v3.md`,
SHA-256 `30360e8fee4309e126cc39e336d7a55249d409c4d98fd519a36cfe1de5da7bff`.
Focused review ran 15:43:42--15:44:01 UTC within six minutes, inspected both
complete deltas and surrounding arguments, and found no new defect or scope
drift. It verified all 62 revised-manifest files: six production, 23 evidence,
three context, two guides, 17 protected and 11 unrelated. Original artifacts,
mathematics, checker and counts were unchanged. Manifest-v2 SHA-256
`4f8776506e87745e2be08a1d1032452d73b3636a4a82380c35ca07149dd12f2f`.

The full review reconstructed both arguments rather than inheriting their
verdicts. Both previously fully read guides, critic skill and replacement
procedure remained applicable and unchanged. Repository and replay checks
are caller evidence; no reviewer execution, mutation, service or delegation
occurred. Documentation (93), process tests (38), whitespace and preservation
checks passed; unchanged Lean was not rebuilt. Source-proof and denominator
input limits remain explicit. Subsequent edits record review outcomes only;
the unfinished inequality research is excluded. V/M4 remain open.

## Zero-entry quadratic inequality — 2026-11-27 UTC

Worker packet `/tmp/pi-m4-zero-entry-inequality-20261127/` completed at
15:44:58 UTC within its 15:32:01--15:52:01 bound. Original report SHA-256
`b6a5a9c9a49dace0cf9626fe2d71e5db8e9174fa91753dfc283d79068c1bb439`;
manifest SHA-256
`42f41b18a9796a25d242550beecfc1a132d3ec5d87123a33497da1b41435cd09`.
Parent unchanged-copy replay passed, with identical evidence and five original
files preserved; replay SHA-256
`549cdd0ae07060e864471908aeb4b4ec6902dece3968b3c24260fe23e9b33925`.
Finite counts are 192 synthetic branches, 384 drift identities, twelve formal
tail steps, ten comparison steps, 64 synthetic phases and seven boundary
assertions. No actual orbit or symbolic-ceiling value was computed.

Independent `/root/generating_review` ran 15:46:29--15:48:57 UTC within ten
minutes. Complete response:
`/tmp/pi-m4-zero-entry-inequality-paper-review-20261127.txt`.
**D: none. I1: resolved:** explicitly restrict finite/infinite telescopes
to N>=1, the domain where the quantities are defined. The immutable repair
`/tmp/pi-m4-zero-entry-domain-clarification-20261127/report-v2.md` has SHA-256
`2e2ea7e0b5bb91b711776cd555610a98896f2350636f9236b04a142e35e25532`;
delta SHA-256
`6a0545239dfd39365d8a55e622f859d81d39f65751f67fc5e104ff57e577fac2`;
manifest SHA-256
`a39a35bcf94d31074956ab9700c69788f53b355f333ff340f91a9f339990c98f`.
The critic separately inspected the entire repair during the full review;
formulas, checker and original artifacts were unchanged.
**Q1: retained open:** actual late boundary and low-even-branch contribution.

The critic reconstructed both drift identities, reference/countermodel cells,
all constants, the arbitrary-threshold boundary, and the near-zero family with
its m+1 carry threshold and explicit lost hypotheses. Both previously fully
read adversarial guides, critic skill and replacement procedure applied with
unchanged hashes. It inspected source and caller receipts without executing
checks, builds or probes, changing files, contacting services or delegating.
No external source theorem was required. Universal arguments remain paper
mathematics; full production integration is pending. C_odd/V/M4 remain open.

## Phase Hankel capacity test — 2026-11-27 UTC

Packet `/tmp/pi-m4-joint-structure-discovery-20261127/` completed at
15:56:53 UTC within its 15:40:47--16:00:47 bound. Original report SHA-256
`9519e2315f293668bbb834ca91ee31b731856bd7c7fd8aba204263d602743abb`;
SHA256SUMS hash
`506fdfc303051b7111ec6021382cd03793943aeabc1367600eba0d3b729b2359`.
Parent replay changed only the hardcoded receipt destination, passed sixteen
synthetic fixtures with identical receipt and five originals preserved;
replay SHA-256
`6eaa7cc143e3545bb29ce8594e1d519ad31806d9626b20ae0e815f719dd2a236`.
The exact destination-only delta is retained; this was not an unchanged copy.
The worker's pre-seal N=11 to N=12 fixture correction retained the condition
that the fixed prime 89 not divide the local denominator lcm.

Independent `/root/finite_log_independent_review` ran 15:58:13--16:01:06 UTC
within ten minutes. Full response:
`/tmp/pi-m4-hankel-capacity-paper-review-20261127.txt`.
**D: none. I1: resolved:** the determinant is affine in the old state with
its carry block fixed; no global affinity across changing canonical cells
is asserted. Authoritative immutable report
`/tmp/pi-m4-hankel-fixed-carry-clarification-20261127/report-v2.md` has SHA-256
`b8560c9e0492d40b033e9f9590a0b8c3b41851acf4cdb6c026f4e6d1100377a5`;
manifest SHA-256
`f058573e582191da78fa6a37ee31a9f209c19ec5b7a9af4e0149e3cd01925bfc`.
The critic separately inspected the full repair during the original review.
**Q1--Q2: retained open:** nonvanishing/subquadratic global denominator growth,
and actual-history quadratic decay. Old-prime exponent one requires the
stated valuation -1; it is not a global height result.

The critic reconstructed the rank-one formula, denominator bounds, bordered
matrix, circulant determinant, exact-A perturbation and carry stability. It
retained the countertest's varying entries and very large starting indices,
and the loss of the actual denominator. Both guides, critic skill and
replacement procedure were applied with unchanged hashes. Checks are caller
evidence; no reviewer checker/probe/build/extractor execution, mutation,
service or delegation occurred. Universal paper arguments are not kernel
proofs. Production integration and the linear-horizon follow-up were excluded;
V/M4 remain open.

The linear-horizon packet `/tmp/pi-m4-hankel-linear-horizon-20261127/`
completed at 16:06:08 UTC within its 16:00:00--16:15:00 bound. Report SHA-256
`bc6152079568b293c3996643397b8d427c4baf92e89302da1c589a9c602e4fc1`;
SHA256SUMS hash
`ca843cc764426f991cdef22d32086b413c8053ef97a4d5942d559631d10f7f83`.
Parent replay changed only the receipt destination and passed thirteen
synthetic fixtures with identical receipt and five originals preserved;
replay SHA-256
`cb91bdd2e3a15e11df896710011c99093facaab45183f39cbbb5e54c584e9b76`.
The seven matrix, three coprime-interval and three forced-block fixtures
use synthetic denominators, explicitly not actual Q_N values.

Independent `/root/generating_review` ran 16:07:05--16:09:24 UTC within
ten minutes. Complete response:
`/tmp/pi-m4-hankel-linear-horizon-paper-review-20261127.txt`.
**D/I: none. Q1--Q2: retained open:** actual-history decay and the complete
arithmetic contract. The construction does not supply nonzero actual
determinants with small full denominators or refute the combined conditional
consumer. The prior PNT-dependent denominator rate remains a retained paper
input, not a freshly audited source proof or Lean result.

The critic reconstructed the inverse norm, tail index and bound, two-choice
coprime count, exact reduced denominator, changed numerator, canonical cell
stability before matrix perturbation, strict singular-value bound and eventual
threshold. It verified all original and replay artifacts, including the
destination-only copy delta. Both guides, critic skill and replacement procedure
were applied with unchanged hashes. Caller checks were inspected without
execution; no mutation, service or delegation occurred. Universal asymptotic
claims remain paper mathematics. Production integration is pending; V/M4 open.

Full combined integration review by `/root/finite_log_independent_review`
ran 16:12:10--16:15:24 UTC within fifteen minutes. Complete response and
frozen scope are retained in `/tmp/pi-m4-inequality-hankel-review-20261127/`.
Baseline `dace798dd2c1fd77a766f89b063629afb9125b7e`; exact diff SHA-256
`b202c039f9ef38a9c3838c4130c2138aed64ee303a57b0a6036a888a0d403ae4`;
manifest SHA-256
`d5a7979aeef57c167d7bf22751787e0bff43049f6a3117a32f4ceb2846da73be`.
**D: none. Historical I items: remain resolved; no new improvements.**
**Q1--Q3: retained open:** actual late boundary/low-even contribution,
nonvanishing and complete subquadratic determinant-denominator growth, and
actual-history decay. No comparison result refutes the stronger conditional
contract or supplies actual visitation.

The critic reconstructed all three integrated arguments and checked the exact
live/frozen diff and all 79 bound files: six production, forty evidence, three
context, two guides, 17 protected and 11 unrelated. Both guides and the
replacement procedure remained applicable and unchanged. Replay scopes and
counts were verified as caller evidence; no reviewer execution, mutation,
service or delegation occurred. Documentation (93), process tests (38),
whitespace and preservation checks passed; unchanged Lean was not rebuilt.
The prior denominator asymptotic remains a paper input. Subsequent edits
record outcomes and research-start metadata only. The unfinished numerator
inquiry was excluded; C_odd/V/M4 remain open.

## Rational resets and holonomic source boundary — 2026-11-27 UTC

The reset packet `/tmp/pi-m4-selected-numerator-discovery-20261127/`
completed at 16:26:43 UTC within its 16:09:14--16:29:14 bound. Report
SHA-256 `f2fb793270b5182fe414d7f7a41e7fc37ba7a7969e8bf46296d8f9f9aaa699b0`;
SHA256SUMS hash
`91fcd8f064881599f31677f32112a7ef53dc2fac0f4ea2e5993fc985b65a93ed`.
Parent unchanged-copy replay passed 80 synthetic checks (63 conjugacies and
17 coefficient checks), with identical receipt and five originals preserved;
replay SHA-256
`d9063f2603a3ce9547b41f43c057d067ade064e1eff0731b92769ee0536b3fd3`.

Independent `/root/generating_review` ran 16:28:12--16:30:20 UTC within ten
minutes. Complete response:
`/tmp/pi-m4-reset-drift-paper-review-20261127.txt`.
**D/I: none. Q1: retained open:** actual signed o(N^(-2)) returns with
witnesses for every scale c>0. **Q2: retained open:** moving-center signed
residual placement. Rounding gives an upper error bound tending to 1/2,
not a lower bound or shrinking estimate. The critic reconstructed the
reset limit, R-to-V implication with the orbit offset, and the two distinct
measure arguments. Generic visitation fails to imply R; R is not refuted
for pi. Ancestry/gauge preliminaries were not adopted as new results.

The source packet `/tmp/pi-m4-holonomic-source-check-20261127/` completed
at 16:25:04 UTC within its 16:22:09--16:27:09 assessment bound, after a
preliminary three-query screen. Report SHA-256
`d8b222d167143140e1196e21df69738c238a5d82eeff8693f402d6f4fed710a8`;
SHA256SUMS hash
`15032bd8712ce8280085d34cd776ee4d51cd54360a579550d6ac46993e1c4f70`
binds nine files, including the full PDF and printed-page 19--20 text/images.
The caller used the existing Swift renderer after unavailable extraction
tools; nothing was installed. The full source proof was not audited.

Independent `/root/finite_log_independent_review` ran
16:25:47--16:27:21 UTC within six minutes. Complete response:
`/tmp/pi-m4-holonomic-source-paper-review-20261127.txt`.
**D/I: none. Q1: retained open:** an applicable integer-index exponential-phase
result or separate transfer. The critic read the retained text and images,
verified all nine artifacts and reconstructed the applicability mismatch.
The narrow rejection neither certifies all printed theorems nor makes a
literature-wide impossibility claim.

Both critics applied the unchanged replacement procedure, pi-argument-critic
and both fully read adversarial guides. They inspected caller execution
receipts without running checks, probes, builds or extraction, changing files,
contacting services or delegating. All universal arguments remain paper
mathematics. Production integration is pending; V/M4 remain open.

Full integration review by `/root/finite_log_independent_review` ran
16:40:24--16:42:46 UTC within twelve minutes. Complete response and frozen
scope are retained in `/tmp/pi-m4-reset-source-review-20261127/`.
Baseline `0a213cc0588dbd2fc0bf0eae28c13451e2286a12`; exact diff SHA-256
`c300ed8e30a9e501b62f8c1050ad53819f2594a4ec1c20e4026655b49bfcd2f0`;
manifest SHA-256
`9718a11bb83ee62c3d0fece332125b9d5f85de935e8b6d1816debeb8a3d3ec2c`.
**D/I: none. Q1--Q3: retained open:** actual quantified fine returns,
moving-center signed residuals, and an applicable exponential-phase result.
The critic reconstructed both integrated arguments and verified the exact
live/frozen diff and all 59 bound files: five production, 21 evidence,
three context, two guides, 17 protected and 11 unrelated. All review-cycle
findings remain open mathematical inputs, not accepted visitation premises.

Both guides, critic skill and replacement procedure were applied unchanged.
Documentation (93), process tests (38), whitespace and preservation checks
passed as caller evidence. No reviewer execution, mutation, service or
delegation occurred; unchanged Lean was not rebuilt. The full source proof
remains unaudited. Subsequent production edits record outcomes only; fresh
discovery metadata contains no adopted mathematics. V/M4 remain open.

## Initialized multiplicative history test — 2026-11-27 UTC

The short inconclusive packet `/tmp/pi-m4-history-interaction-reset-20261127/`
completed 16:54:07 UTC within its 16:39:12--16:59:12 bound. Report SHA-256
`32ce6b2a06e95ba81a1487d7d6af0f584eff78bdb37cd8ee7b49135023750727`;
manifest SHA-256
`fdc40c2cda42e57b7361fd4efc003feb6b521797102f30b23bc8d29f1a4afd69`.
Parent unchanged-copy replay SHA-256
`5196e390ea718f8431083b8251fe2c03166f077dfdf14f83b3d69b1f907145c3`
records exit 0, identical receipt and four originals preserved: 54 local
identities, 18 first steps, 36 products, 54 history monomials, three unit
checks, one initial coefficient and four synthetic sign pairs. These finite
algebra checks contain no actual future phase census.

Independent `/root/generating_review` ran 16:55:09--16:56:35 UTC within six
minutes. Complete response:
`/tmp/pi-m4-history-interaction-paper-review-20261127.txt`.
**D/I: none. Q1: retained open:** an independently controlled actual signed
history term beyond the endpoint. The critic reconstructed the complete
product domain (zero final endpoint allowed), initial factor, lift sign and
raw-floor relation. Sine at an integer is defined and zero, so its sign
cannot encode parity there. The result concerns only this failed candidate;
it does not exclude all products or algebraic-norm methods.

Both fully read guides, critic skill and replacement procedure applied with
unchanged hashes. The critic verified the four originals and parent replay,
inspecting caller execution without running checks, probes or builds,
mutating files, using services or delegating. No source theorem or Lean proof
was invoked. Production integration remains pending; V/M4 remain open.

## Rational-base source transfer — 2026-11-27 UTC

Packet `/tmp/pi-m4-rational-base-connection-20261127/` completed at
17:02:24 UTC within its 16:54:25--17:14:25 bound. Report SHA-256
`41ae15b9940680d0dea843ae2c1ca6231aba1aba05faec9c54df14f9febac1b7`;
manifest SHA-256
`95d6e87d8dc710840cc0fae1093085ffff4540aac2fc9a493fb0ff5da4212db5`.
Parent unchanged-copy replay SHA-256
`8e05c1763fb26750a92be71212df382d85ed3c561706f92661d5650234f89d57`
records exit 0, 31 checks and 23 preserved top-level originals. The original
packet has no saved stdout, so no receipt byte-identity comparison is claimed.
The retained DM source extract has SHA-256
`c46dc84bbc189eb340761b644f99a374784acfcebc270e54eb67929a78020d28`.

Independent `/root/finite_log_independent_review` ran
17:07:28--17:08:38 UTC within six minutes. Complete response:
`/tmp/pi-m4-rational-base-paper-review-20261127.txt`.
**D/I: none. Q1: retained open:** a fixed nonzero divisible integer from
actual word avoidance despite changing forcing/branches. **Q2: retained
open:** a distinction using actual rational raw initialization. The critic
reconstructed both divisibility arguments, the exact cleared recurrence,
variable-branch defect and same-carry residual, preserving all domains.

The source contract and elementary proof were inspected as text; the DM PDF
was not available locally or visually verified. The critic also viewed
Dubickas's printed pp.234,236,237 and read their proof passages. Full source
dependencies, Mahler's full proof and auxiliary Akiyama/2025 conjecture screens
were not audited or adopted as theorem inputs. Both fully read guides,
critic skill and replacement procedure were verified unchanged. Caller checks
were inspected without execution, mutation, network access or delegation.
Production integration remains pending; V/M4 remain open.

## Euclidean matrix consumer — 2026-11-27 UTC

Packet `/tmp/pi-m4-euclidean-history-discovery-20261127/` completed at
17:14:07 UTC within its 17:07:39--17:27:39 bound. Authoritative v2 report
SHA-256 `df49e77c7a319631c5127c8840f47f900bf0d0006776dd15df7abba4a4985785`;
active checksum-file SHA-256
`186cb21d9e531a7744a305d238f180d186f7186b50cfb04669e37d2adc414d39`.
Parent unchanged-copy replay SHA-256
`11373a61c4dc3d0a7849091bb27f122ce708f68a13178e693c94b3d303907665`
records exit 0, byte-identical receipt and six preserved originals: 10,030
synthetic updates and two collision fixtures. The original v1 and exact
v1-to-v2 notation-only delta remain available.

Independent `/root/generating_review` ran 17:15:13--17:16:57 UTC within six
minutes. Complete response:
`/tmp/pi-m4-euclidean-history-paper-review-20261127.txt`.
**D: none in authoritative v2; the pre-delivery notation correction was
verified. I: none. Q1: retained open:** actual-history selection beyond the
listed local data. The critic reconstructed the denominator-one conventions,
integer factorization, bounds, congruences and exact collision. It does not
exclude full input matrices, higher precision or other history constraints.

Both complete guides, critic skill and replacement procedure were applied
unchanged. The critic verified all originals and replay evidence without
executing checks, changing files, using services or delegating. The q=1 cases
were assessed algebraically; the finite input loop starts at q=3. No actual
future phase or source theorem was used. Production integration is pending;
V/M4 remain open.

Full combined integration review by `/root/finite_log_independent_review`
ran 17:19:54--17:21:26 UTC within twelve minutes. Complete response and
frozen scope are in `/tmp/pi-m4-history-source-matrix-review-20261127/`.
Baseline `13192550d5c9e6e47ce4bc412f396cb4473315e6`; exact diff SHA-256
`b0c3908506cb1d533036f04e1d29decab6b723dd1d9c92dfbca075f01f8e89f0`;
manifest SHA-256
`177fbe015664df8a13d2bacc27d437f7f034bf8939f9ac56a6f5456ca3a1077f`.
**D/I: none in the full review.** The author notation correction remains
verified. The parent then made the source's conditional Z-number hypotheses
explicit; focused review at 17:23:07--17:23:10 UTC verified that clarification
within two minutes, with no defect. Its sole delta has SHA-256
`63029a964e9bd2e7c5e53e845ad1493f4a88f457d2cb88ce3b08292b91a5ef61`.
**Q1--Q4: retained open:** actual signed history control, a divisible invariant
under omitted words, rational initialization selectivity, and a matrix-history
constraint on the selected representative. No new visitation premise is adopted.

The critic reconstructed all three integrated arguments and verified the
live/frozen scope and all 88 bound files: five production, fifty evidence,
three context, two guides, 17 protected and 11 unrelated. Both complete guides,
critic skill and replacement procedure were applied unchanged. Documentation
(93), process tests (38), whitespace and preservation checks passed as caller
evidence; unchanged Lean was not rebuilt. No reviewer execution, mutation,
service or delegation occurred. Source and replay limits remain as above.
Only the separately reviewed clarification, outcome records and dated discovery
metadata follow the frozen review; unfinished direct-pi work is excluded.

## Disk-count dissection — 2026-11-27 UTC

The worker packet `/tmp/pi-m4-direct-pi-discovery-20261127/` completed at
17:22:44 UTC within its 17:14:18--17:34:18 bound. Report SHA-256
`11e86f408768b08667aa58e1027c0ba1f34d9c5ac606bc70fbe66db0a07a29db`.
Parent source/replay packet `/tmp/pi-m4-disk-parent-review-20261127/` has
manifest SHA-256
`cf1d8f8562e3ce9809983fb3690870fa8577c7898343f7f6fd632af8d064f750`.
It binds eighteen source, report and execution files. Unchanged-copy replay
passed 256 scaling and five dyadic count cases, with byte-identical output
and all three worker originals preserved. Zero pi evaluations were used;
the finite checks establish no analytic theorem.

Independent `/root/generating_review` ran 17:32:58--17:35:52 UTC within six
minutes. Complete response: `/tmp/pi-m4-disk-paper-review-20261127.txt`,
SHA-256 `3aab69791d837295732c26cecb68368dd9efe8d61e35dfc715f055f620e8f768`.
**D/I: none. Q1: retained open:** control of the uncancelled expression with
absolute accuracy sufficient for a target interval, at the selected radii.
The critic reconstructed the smoothing, Poisson hypotheses, transform
normalization, scale identity, fixed-m asymptotic and limited countermodel.

Both full guides, critic/source skills and replacement procedure applied.
All eighteen manifest-bound files matched. The critic read supplied source
text and visually inspected Elkies pp.9--11, including Theorem 2. DLMF TeX
formulas were inspected; webpage domains were supplied by the parent's
source assessment, not independently retrieved. No whole-source dependency
audit or Lean verification is claimed. Caller checks were inspected without
execution, mutation, rendering, extraction, services or delegation. Production
integration is pending; V/M4 remain open.

Full four-path integration review by `/root/finite_log_independent_review`
ran 17:40:24--17:41:54 UTC within ten minutes. Baseline `5d25c546`;
exact diff SHA-256
`e9731ba95a1b8bd5cc51ea84d3a28d8f7860510cb782b29230e433335565b5f1`;
manifest SHA-256
`ea07e6e23cdf62cfa51132e44b1a20768204b4504eed16b52e7dd486e39e6cf4`.
Complete capture and frozen scope: `/tmp/pi-m4-disk-integration-review-20261127/`.
**D/I: none in either review. Q1: retained open.** The critic independently
reconstructed the argument and found no consequential duplication. All 58
bound files and the live diff matched; both complete guides and source/critic
skills applied. Source and caller-execution limits remain as above. No
checker execution, mutation, service or delegation occurred. Documentation
(93), process tests (38), whitespace and preservation checks passed; unchanged
Lean was not rebuilt. Only factual outcome records follow the frozen review.

## Concordance source and positive-index regularity — 2026-11-27 UTC

Worker `/root/m4_initialized_arithmetic_reset` completed at 17:47:21 UTC
within its 17:34:30--17:59:30 bound. Frozen report
`/tmp/pi-m4-initialized-arithmetic-reset-20261127/report.md`, SHA-256
`07d7b80acf797f6d8ad9e7fb6743b242e68287d307f8453149f8981d8ff4acd9`;
inventory SHA-256
`726ffea303c30171f971d336beeb4762c0bc44dcd105948427f00c87ec028661`.
Parent packet `/tmp/pi-m4-concordance-parent-review-20261127/` has manifest
SHA-256 `1ca43e4692ae773d8d9d09ef9966228e1653e5186e1764b2613542410d2ccef7`,
binding nineteen files. Unchanged-copy replay passed with identical stdout,
empty stderr and all seven worker originals preserved. Its finite synthetic
checks and rational threshold comparison do not certify universal claims.

Independent `/root/generating_review` ran 17:50:05--17:53:54 UTC within six
minutes. Complete capture: `/tmp/pi-m4-concordance-paper-review-20261127.txt`.
**D: none. I1/I2: implemented and verified:** separate the checker's threshold
comparison from the pi bound, and restrict odd denominators to integer
arguments. The independently inspected addendum `clarification-v2.md` has
SHA-256 `e29177dd1e93649bc8037cb454117d79689d796c015415e1c0225e837b97f038`;
originals remain unchanged. Production retains both corrections and explicitly
identifies the coefficient g as the isometry, not the initialized forward graph.
**Q1: retained open:** a new arithmetic implication from actual word avoidance.

The critic reconstructed the source contract, floor-concordance contradiction,
positive carry-tail continuity obstruction and synthetic comparison. Both full
guides, critic/source skills and replacement procedure applied. All nineteen
bound files matched. Pila's printed pp.2--4 were read and visually inspected;
the full source proof/dependencies were not audited. The pinned Mathlib pi
bound was inspected, with no new Lean execution. Caller evidence was inspected
without checker/probe/build execution, rendering, extraction, service, mutation
or delegation. Production integration is pending; V/M4 remain open.

Full four-path integration review by `/root/finite_log_independent_review`
ran 18:00:11--18:02:02 UTC within ten minutes. Baseline `ac9688f7`; exact
diff SHA-256 `0ef4fea97b92572d2deba6592f4a17ba99e9fd3ecc7067b5b3749568e4c61927`;
manifest SHA-256
`af316a5e0a0b22f18ee795f6727e17442558763aba197351718c771c0363a98e`.
All sixty bound files and the live scoped diff matched. **D: none. Source
I1/I2: verified implemented. Q1: retained open.** The critic reconstructed
the corrected arguments, found no consequential duplication, and preserved
all source/checker limits. Complete captures and frozen scope are in
`/tmp/pi-m4-concordance-integration-review-20261127/`.

The parent then corrected the stale opening navigation in the handoff,
without removing historical sections. Focused review ran
18:03:45--18:07:14 UTC within four minutes. **Focused I1/I2: implemented
and verified:** replace an overstatement about determining the canonical
cell with the absence of a visitation estimate, and preserve the former H1
anchor explicitly. These are separate from the source I1/I2 above. No
remaining defect or new mathematical question was reported. The final entry
delta `handoff-entry-fix-v3.diff` has SHA-256
`fe8626140d8483bd9f74cba434b63872bb81435b9fdf55dd88e544880e744e81`;
earlier versions are preserved. The rest of the handoff was unchanged at
focused review. Both full guides and replacement/critic context applied; no
reviewer execution, mutation, service or delegation occurred. Documentation
(93), process tests (38), whitespace and preservation checks passed; unchanged
Lean was not rebuilt. Only factual outcome records follow these reviews.

## Inverse selectors and nearby rational seeds — 2026-11-27 UTC

Contracted-rotation worker report:
`/tmp/pi-m4-contracted-rotation-connection-20261127/report.md`, SHA-256
`faaffdf470df01c9b18620748b85cbca1768bd56ed2b74cce89f70f4a0ecdcdd`.
Parent manifest SHA-256
`7850835f566aff95c32015599ed88d733a9aa6c74edd1ca37686041ad88d22a0`
binds 38 files. Unchanged replay passed with identical output and sixteen
originals preserved. Independent `/root/contracted_selector_review` ran
18:15:40--18:18:42 UTC within six minutes. Full capture:
`/tmp/pi-m4-contracted-paper-review-20261127.txt`, SHA-256
`784505d3ce73674ee0f9643312b6fc457f6a0e02f69dd01bd718560870261ff7`.
**D: none. I1: implemented:** the synthetic-history obstruction requires
continuity outside finitely many breakpoints. Focused review at
18:20:22--18:20:28 verified the immutable clarification; full capture
`/tmp/pi-m4-contracted-paper-review-focused-20261127.txt`, SHA-256
`5fbc34bd52ab5c622eab2536c9c4c9c6ccfc28982bac6c9a4a7192841bc7ef4f`.
**Q1/Q2: retained open:** actual-history-preserving selection, and a precise
backward-chain consumer for an algebraic alternative. The source's external
transcendence proof was not audited; the discontinuity qualification was
inspected in source text and rendered pages. No stronger draft claim is used.

Global-history worker report:
`/tmp/pi-m4-global-inverse-history-20261127/report.md`, SHA-256
`cd82c583b444e9dcb443465708f4ac9724acf50b981920f52efa2a187be091d0`.
Parent packet `/tmp/pi-m4-global-inverse-parent-review-20261127/` has manifest
SHA-256 `9e822a73b39f7ab47eb4d9ce3738bae6c992efaf91b5280bdac12c0af3416e3e`,
binding 41 files. Unchanged replay matched 4,848 exact assertions, empty
stderr and all 31 originals. The failed overly tight real bound is retained;
the corrected bound is `16^(1-j)`. Parent reconstruction clarifies that each
fixed rational competitor retains asymptotic denominator growth; exact
profiles and uniform-in-family controls are not retained. Independent paper
review by `/root/contracted_selector_review` ran 18:28:15--18:31:18 UTC
within six minutes. Complete capture:
`/tmp/pi-m4-global-inverse-paper-review-20261127.txt`. **D: none. I1/I2:
implemented:** the original 240-root count constrains times 1 and 2 (the
production summary omits that count); unwrapped state differences are exact,
while normalized differences include an integer. The immutable parent
`clarification.md` records both without editing the original evidence.
**Q1: retained open:** actual-history arithmetic regularity. The simultaneous
survivor-count question remains unproved and is not adopted as promising.

Both full adversarial guides and the replacement procedure apply. Source
and critic skills were applied to the assessed material. Finite checker
fixtures do not certify the universal arguments; no Lean theorem or M4
acceptance is claimed. The separately active AGM discovery is outside the
adopted scope.

Full four-path integration review by `/root/finite_log_independent_review`
ran 18:34:41--18:38:28 UTC within ten minutes. Baseline `ff5a5dbc`;
initial diff SHA-256
`a2dac1aac0075d1bb5503af5e024d0cdd5bb658095ee9a8e852ede5a3595a857`;
manifest SHA-256
`0382ada59add123dcdbe43a78f827ec8420c24fd5791196797fbb1d7abdc763a`.
All 132 bound files and the live diff matched. **D: none. Prior I items:
verified implemented. Integration I1: implemented and verified** in focused
review at 18:39:34--18:39:44 UTC: explicitly use circle sums and differences.
Its complete delta SHA-256 is
`aaf650671346bca7c1a0f6133045238ae14be2a50fc363dd2bc6cfa61a29142c`.
**Q1/Q2: retained open.** Complete captures, frozen scope and focused delta
are in `/tmp/pi-m4-inverse-integration-review-20261127/`. Both full guides,
critic/source skills and replacement procedure applied. Source/receipt limits
remain as above; no reviewer execution, mutation, service or delegation.
Documentation (93), process tests (38), whitespace and preservation checks
passed; unchanged Lean was not rebuilt. Only factual outcome records follow
the focused repair.

## AGM approximations and selected-root signs — 2026-11-27 UTC

The mathematical owner is the
[AGM assessment](../m4-approximation-interfaces.md#agm-units-smaller-fields-and-the-missing-interval-estimate).
All four investigations are paper mathematics with finite exact checks.
No new Lean result, V theorem, carry-parity theorem or M4 acceptance is claimed.
Brent's retained primary PDF has SHA-256
`d743c13afc9868f7795f1e8539943399d9aec70d2e656b07e24202a3bb512737`.
Printed pages 6, 8, 9 and 10 were inspected across the source reviews; the
complete theta/elliptic-integral dependency proof was not audited or formalized.

The first AGM packet is specifically `agm-report-v1.md` in
`/tmp/pi-m4-fresh-mechanism-reset-20261127/`, SHA-256
`cfa9582f6ac27912018d9ed3d0787b22873ae2ea0537e288287427d7bed4b8b6`.
The old unprefixed report there is a different Gaussian investigation.
Two accidentally overwritten historical scratch files were exactly restored;
all seven original manifest entries and later all 28 historical scratch
evidence hashes matched. No repository file was affected. The new packet
excludes old evidence; subsequent scratch directories were verified new.
Parent packet: `/tmp/pi-m4-agm-parent-review-20261127-183733/`, manifest
`68645ae81b9ec5c1d0bbb3ea22cb95835f5e8cfdd1f1c73a9ed5a071576347bc`.
Unchanged replay passed 773 exact checks, preserving eleven originals.
Independent `/root/agm_unit_review` ran 18:45:54--18:49:48 UTC within ten
minutes. **D1: corrected and verified:** the initial D/U comparison is
non-strict at m=1; its strict bound by 1/32 remains. **I1: implemented:**
the residual domains are natural m,n, integer p, |p|<=4Q and 4n>=m+1;
the odd-norm subcase additionally requires 4n>m+1 and odd p. The immutable
`residual-domain-clarification.md` and production owner retain these.
**Q1: unresolved:** actual window visits. **Q2: retained evidence limit:**
complete source dependencies. Full review is `paper-review.txt` in the parent
packet; the earlier correction is in its immutable assessment.

The compensated-F packet is
`/tmp/pi-m4-agm-compensated-trace-20261127-1845/report-v1.md`, SHA-256
`ce89ee91c8cbea7005ad0c6a1ea9796d5a75ae682b63916b8c6caeb524c933d5`.
Parent packet: `/tmp/pi-m4-agm-compensation-parent-20261127-185904/`, v2
manifest `cb102612b623c048419543329ddf3a59c891dc58f1615ef4a8bcba9fb08aa969`.
The readable assessment-v2 preserves the first assessment; no frozen evidence
was rewritten. Unchanged replay passed 132 checks, preserving eleven originals.
Independent `/root/agm_unit_review` ran 19:05:10--19:08:10 UTC within eight
minutes. **D/I: none. Q1: unresolved:** interval placement. **Q2: retained
source-audit limitation.** The reviewer distinguished the compensation
polynomial from the exact norm polynomial, the m>=3 signed result from its
m=1 fixture, absolute height from coefficient height, and precision gains
from visits. Full return: parent `paper-review.txt`.

The exact-norm Newton packet is
`/tmp/pi-m4-agm-exact-norm-newton-20261127-1858/report-v1.md`, SHA-256
`4db4bf0106688ed0e01d10d00128710cb1f88a3e0094768e77f5a43507e62ace`.
Parent packet: `/tmp/pi-m4-agm-newton-parent-20261127-1912/`, manifest
`aac709c903f2fe9c1c5490ef168f2e07615540471dfba1a030ca92828dc8ae2c`.
Unchanged replay passed 200 checks, preserving seven originals. Independent
`/root/agm_unit_review` ran 19:10:16--19:13:24 UTC within the assigned
19:10:00--19:20:00 bound, reassessing at 19:12:03. **D/I: none. Q1:
unresolved:** interval placement. **Q2: retained:** J!=0 must be proved or
the zero case handled at any norm application; universal irrationality is
not claimed. **Q3: retained source-audit limitation.** Cancellation, signs,
full-window constants, height and degree were independently reconstructed.
Full return: parent `paper-review.txt`. The positive sign relative to pi is
eventual; the all-m inequality is only Y_m>gamma_m.

The phase-consumer packet is
`/tmp/pi-m4-agm-phase-consumer-20261127-1855/report-v1.md`, SHA-256
`43a8938f10a9cf95fadb2fdeb775cab86f979cf8f320517b2fb6d48131899979`;
manifest `e9fd97aa224047a817891b20510637d957b2e4f2b8ee78b90ad9c2c6c37eeff1`.
Parent packet: `/tmp/pi-m4-agm-phase-parent-20261127-1915/`, manifest
`95954010e8a19f0c918053e8b0cf6558852baf2640b75174ea7d4e0097c391f1`.
Unchanged replay passed 143 checks, preserving seven originals. Independent
`/root/finite_log_independent_review` ran 19:13:12--19:16:22 UTC within ten
minutes, reassessing at 19:15:50. **D/I: none newly found.** Worker D1/D2
are rejected candidate inferences, not defects in the final argument; those
rejections are retained. Worker I1/I2 are implemented: distinguish field
signature from real polynomial roots, and finite-window seeds from a fixed
infinite avoiding seed, including all lost hypotheses. **Q1: unresolved:**
the sign-count lower bound for exact S_0=1. **Q2: retained source-audit
limitation.** Full return: parent `paper-review.txt`.

Both full adversarial guides, the replacement procedure and critic/source
skills applied to the respective scopes. Reviewers reconstructed arguments,
inspected files/hashes and retained source images, and distinguished caller
execution receipts from independent review. No reviewer executed a checker,
probe, build, rendering or extraction, wrote files, changed Git, contacted a
service, installed tools or delegated. Finite arithmetic does not prove the
universal arguments, and reviewer agreement is not a kernel certificate.
The open visit/sign-count questions block V/M4 acceptance.

Full four-path integration review by `/root/finite_log_independent_review`
ran 19:21:52--19:26:20 UTC within twelve minutes, with reassessment at
19:25:54. Baseline `116f072d`; exact diff SHA-256
`ef3b3df69edaefe21248ace2fa620f0f4c1db0e5fad0f90ad3fd0ffcc117b382`;
manifest `95225e719c0665ad4c4b08557c2b7d4e5957eb2b6c4e00ea7afba09f7cdb9ae7`
bound 81 files. The live diff and all bound files matched. **No new D/I
items. Prior D1 and I1: verified corrected/implemented in production.**
The finite-window distinctions were likewise verified; no consequential
duplication was found. **Q1--Q3 remain explicit:** actual sign counts,
nonzero Newton residuals at applications, and full analytic source dependencies.
All 28 preservation hashes and the historical scratch restoration were
independently checked. Complete capture and exact scope are retained in
`/tmp/pi-m4-agm-integration-review-20261127-1922/`. Documentation (93),
process tests (38) and whitespace checks passed; unchanged Lean was not
rebuilt. Only factual review/outcome records follow the reviewed diff.

## Finite word and parity radius extension — 2026-11-27 UTC

Frozen report `/tmp/pi-m4-post-agm-discovery-20261127-1914/report.md` has
SHA-256 `f9bad45e609e8c2921ba798fe21f6e13d28c5d9de4e1ca99425f4a40ae196477`;
manifest `3f7f789a162afd1b548636ffd369825df0b471a90bdd72fe624140dedd2adb29`.
It extends an archived sieve argument in its word and entry-index quantifiers;
it loses that argument's extra odd-prime component and supplies no new
visitation mechanism. The radius observation is elementary general evidence,
not an actual-specific advance. Previously reviewed denominator asymptotics
remain paper inputs; no fresh source proof or Lean certificate is claimed.

Parent packet `/tmp/pi-m4-half-carry-parent-20261127-1933/` has manifest
`5e941058288376045d4878e804b59b77a2276b8c8ff8e4241111307f4e8bbee4`.
Unchanged replay at 19:33:19 UTC passed 2,586 synthetic exact checks, exit
zero, identical stdout, empty stderr and six originals preserved. The parent
reconstructed the cylinder, open-interval sieve, uniform quantifiers, formal
mod-2 identity and root-test argument within its five-minute bound.

Independent `/root/finite_log_independent_review` ran
19:33:13--19:34:58 UTC within six minutes. **D: none. I1: implemented and
reviewed at packet level:** take the interior of the composed closed interval
as J. The production owner now uses that wording. **Q1: unresolved:** a
constraint on the same actual numerator over unbounded nested histories.
**Q2: unresolved:** parity does not supply analytic continuation or rigidity.
Neither question invalidates the finite extension; both leave V and the
odd-carry target open. Full return is parent `paper-review.txt`.

Both complete adversarial guides, replacement procedure and critic context
applied. The reviewer checked five worker artifacts, six parent entries,
replay identity and preservation; assertion counts/exits remain caller
execution evidence. No reviewer writes, checker/probe/build execution,
rendering/extraction, Git mutation, network, installation or delegation.
Production integration review remains pending.

## Prime-power column source test — 2026-11-27 UTC

Frozen report `/tmp/pi-m4-backward-structure-reset-20261127-1929/report.md`
has SHA-256 `b6bb6799938636f329b52125be89e6ea99499e3398c97bbb4713013f5f9b61e1`;
worker manifest `57abbd005c4aad7d42231aba4b9769df0209f799e8611d8e402f3dd6af66e306`.
The source PDF hash is
`9d1510fc72b6298295a3f10ca6d314936d083bc698982e0386e02bd8c9d9108f`.
The worker froze at 19:42:01 UTC within 19:27:48--19:47:48, reassessing
at 19:36:48. It distinguishes a different decomposition from the earlier
frozen-prefix source application, without claiming novelty or a new V proof.

Parent packet `/tmp/pi-m4-columns-parent-20261127-1946/` retains unchanged
replay, source pages and assessment. Replay at 19:45:00 exited zero with
1,208 synthetic exact assertions, identical stdout, empty stderr and all
five originals preserved. Parent reconstruction and visual source inspection
finished at 19:51 within its eight-minute bound. The v2 manifest is
`51d875e2a3350a8a0f054a2c4583cc3d2b196358dac848b8a6ae879fc3064076`.
It preserves the original manifest and normalized review transcription; the
full verbatim return is `paper-review-verbatim.txt`, SHA-256
`30980baa483d30d3972e2d337b54527eb08bc10dab190d5feaecc72afcda83da`.

Independent `/root/finite_log_independent_review` completed at 19:48:53 UTC,
with reassessment 19:48:30, before the communicated conservative 19:54 target.
Its initial clock output was lost during compaction; the first recovered
clock is 19:47:02, and the missing start time is not certified.
**D: none. I: none required. Q1: unresolved:** actual sum correlations.
**Q2: unresolved:** uniform early visits with the BBP tail margin.
**Q3: unresolved:** the exploratory insertion test has no proved real-visit
consumer. These do not invalidate the limited column calculation; they
prevent its use as an unconditional V argument.

The reviewer reconstructed all three paper claims, inspected the checker,
source text and rendered printed pages 530,533,535, and verified worker
hashes and parent replay identity/preservation. Both full adversarial guides,
replacement procedure and critic/source skills applied. Earlier analytic
source dependencies were not fully audited. The reviewer ran no checker,
probe, build, rendering or extraction and made no writes, Git mutations,
network calls, installations or delegations. Finite checks prove neither
normality nor universal visits; reviewer agreement is not kernel checking.
Full changed-file integration review and checks remain pending.

Full five-path integration review by `/root/finite_log_independent_review`
ran 19:54:16--19:56:41 UTC within twelve minutes, with early reassessment
at 19:56:24. Baseline `70666670`; exact diff SHA-256
`a14f97c72e67c214a689ff61039ed052cef7b91a8c76ab08a5108636c537177e`;
manifest `537e1b2b27e3e9aec374d6006adef8353ef2b9925aab032e3ee5562c0326f98a`
bound 52 files. Live scope, nested evidence and all 28 protected/unrelated
hashes matched. **No new D/I. Prior finite-word I1: verified implemented
in production.** All five open questions above remain explicit; none is
silently treated as a supplied hypothesis or a theorem. Full capture is
`/tmp/pi-m4-word-column-integration-20261127-1957/review-full.txt`.
Documentation (93), process tests (38), and working/staged whitespace checks
passed. Lean is unchanged and was not rebuilt. The corrected guide-filename
mistake occurred during packet preparation, before review; it was not a
failed review run. Only factual review-outcome records follow the reviewed
diff. This checkpoint does not accept V/M4 or end ongoing research.

## Column unit survival and profile rigidity — 2026-11-27 UTC

The unit/window report is
`/tmp/pi-m4-column-uniform-window-20261127-195029/report.md`, SHA-256
`be7a7cbc3d8f34eea64534bc9d4cd3c4e075f8ae528f8bb736a37d804fbfa93c`;
worker manifest `1371a4b2923ceb4fb567801c2e71a7fd6f8a0c739937bf1041f0420505974c20`.
Parent packet `/tmp/pi-m4-column-unit-parent-20261127-2006/` has manifest
`e983110faa41dd2de2ee769cb6ffb6303920b52d68ee59edfdddac9ad8f313ac`.
Unchanged replay at 20:05:42 UTC passed 87,596 local arithmetic checks,
preserving seven worker artifacts and five inputs. Parent completion was
20:06:44 within nine minutes; its rounded label is clarified separately.
Independent `/root/finite_log_independent_review` ran 20:07:10--20:10:04
within ten minutes, reassessing at 20:09:28. **D/I: none. Q1: unresolved:**
joint unscaled visits with both error margins. **Q2: unresolved:** the selected
inverse branch and correlations between kicks. The complete residue proof,
full-interval discrepancy convention, PNT dependency, varying comparison and
sufficient-only prefix shift were independently reconstructed. Full capture:
parent `review-full.txt`, SHA-256
`2cf0b1fede0c0859c7d78666e3b9a113824b14ee3f59014670c3a292c841560f`.

The fixed-prime source screen is
`/tmp/pi-m4-stoneham-sum-source-screen-20261127-1956/assessment.md`, SHA-256
`2a7dabc5343c0567ec413480e8c4619482227960f1afbed866bc5f88c6bb5551`.
Assessment finished at 20:01 within 19:55:31--20:04:31; later provenance
clarification was part of review. Independent review ran 20:03:03--20:06:17
within nine minutes, reassessing at 20:05:42. **D: none. I1: implemented:**
readable Stoneham copies have one added final LF; Xi also normalizes CRLF.
New exact-source copies match all four upstream Git blob IDs; no frozen
artifact was changed. Clarified manifest v3 is
`8a120a8dcd7dd09297f9208537126a15e7dc1f8853a6d02338807b9ec7edc526`.
**Q1: unresolved:** a consumer for the actual signed sum. **Q2: unresolved:**
uniformity under growing parameters. Full capture is `review-full.txt` in
that packet, SHA-256
`ba6f8e8ef852cc3c50e867a134e43487903e66920cfc5fa7d192d780277da240`.
The exact two-sum, localized-logarithm and Vandehey contracts were inspected;
the external developments were not built, fully audited or imported.

The coherent-profile/common-hole report is
`/tmp/pi-m4-initialized-history-discovery-20261127T195106Z/report.md`, SHA-256
`22e996cf1bc39dd6bd1a2a625a90f787b31db92fd2df5364b3416888812a94cc`;
worker manifest `f5c50cc4eb97d705260c3baba75c1ad27607288e33714db62a60b57d694d97f0`.
Parent packet `/tmp/pi-m4-history-source-parent-20261127-2009/` has manifest
`6efb02731eaef9a27020f0de4364451973c9d356c8ff5c8a4674b17da77a0491`.
Unchanged replay at 20:09:49 passed 41,747 checks, preserving nine originals.
Parent completed at 20:11:15 within ten minutes. Independent review ran
20:11:34--20:15:02 within ten minutes, reassessing at 20:14:39.
**D/I: none. Q1: unresolved:** the selected history's real placement.
**Q2: unresolved:** production of an infinite bounded fixed-support common-hole
family from actual avoidance. The raw/seed/canonical distinctions and fixed
quantifiers were independently checked. Full capture is parent `review-full.txt`.
Source pages 1–2 were visually inspected; the imported Schleischitz proof
and full dependency chain were not independently audited.

All three reviews used both complete adversarial guides, the replacement
procedure and applicable critic/source skills. Reviewers read files/images,
reconstructed arguments and verified hashes/receipt identity. No reviewer
executed checkers, probes, builds, rendering or extraction, wrote files,
contacted services, changed Git, installed tools or delegated. Finite counts
remain caller execution evidence, not universal proofs. No other-prime
exploratory pattern, new Lean theorem or V/M4 acceptance is adopted.
Full changed-file integration review and checks remain pending.

Full integration review by `/root/finite_log_independent_review` ran
20:20:35--20:26:34 UTC within twelve minutes, reassessing at 20:25:29.
Baseline `b98f4a45`; exact five-path diff SHA-256
`0afce9eb078b4b69a8a1f2d8b895964996daeb0a4d3f875ed8986c9dc7e5ffbd`;
manifest `1f84f047410449b464c1d569c4f8043f23259da71f8edfb2183186f8e8b2269f`
bound 82 files. All bound files, the live diff and 28 preservation hashes
matched. **D1: repaired, pending focused verification:** summary statements
omitted boundedness of the fixed-support common-hole seed family. Integer
translates of an avoiding seed form an unbounded counterexample. The log,
handoff and current Q2 summary now retain an infinite bounded family (or
fixed r D_p); the mathematical owner already fixed r D_p and boundedness.
The earlier paper review's abbreviated Q2 had the same omission, while its
reconstruction retained boundedness. Its original capture is preserved;
this paragraph supplies the clarification rather than rewriting that review.
**Prior I1: verified implemented. I2: implemented, pending verification:**
the production interval is now explicitly nonempty. **Q1--Q3 remain open:**
joint unscaled visits/branch control, the selected history and bounded seed
family, and actual signed-sum/uniform-parameter consumers. Full initial review
and exact repair evidence are in
`/tmp/pi-m4-unit-profile-integration-20261127-2020/`. Documentation (93),
process tests (38), and whitespace checks passed before the repair; affected
checks and focused review follow. No Lean changed. This review does not
accept V/M4 or interrupt the ongoing research.

Focused follow-up ran 20:28:45--20:29:31 UTC within six minutes, reassessing
at 20:29:21. **D1 and I2: verified resolved. Prior I1: remains resolved.**
No new defect or improvement. The repair diff SHA-256 is
`9f3236fe7edab7e837b20759755dfbd7fe6294a98e22f53ff43210a140ef2a2e`;
revised full diff `aed7f23eaf80e491192641d709cfa91b07f87bd2a29314934c9e3393dfa593f2`;
fix manifest `3cfa6617a5ae5820554a76b4ba03b1cf4e4e5ef64dffdcf99dbbf48fce03f967`
bound 91 entries. Live scope, original snapshots, 77 original non-production
entries and all 28 preservation hashes matched. Original review history is
preserved in `review-initial.txt`; complete follow-up is `review-followup.txt`.
Affected documentation and whitespace checks passed. The complete cycle found
and fixed one summary quantifier defect, implemented one domain clarification,
and verified the prior source-serialization improvement. Q1--Q3 remain open
and block V/M4, not this limited documentation checkpoint. Only factual outcome
records follow the reviewed repair; no new mathematical claim is added.

## Period division and point counting — 2026-11-27 UTC

Separate Codex reviewer `/root/finite_log_independent_review` examined the
immutable paper packet at
`/tmp/pi-m4-post-profile-reset-20261127T201220Z/`: report SHA-256
`b1fd31c7311eda76fe66af32444651d7558843bb972969195046d21f3b23b90a`,
manifest `b770f7d44c3f22e34a2314a73a437da5d23bb31906999dec40c84b5b31272dc6`.
Parent packet `/tmp/pi-m4-point-count-parent-20261127-2037/` contains assessment
`02789cba96a6564663f7c9711e55ba80508624c7ad4ef15128ed90a4453544e5`,
13-entry manifest `f653f465d80f09be2fcf5410031ab8873b9199406fccc796f292be0f14331675`
and complete return `review-full.txt`, SHA-256
`727511a576174e18020b1fae66fd203c5ef3672966f6ad84d73772a00d111b23`.
The exact scope is the division-family discriminator, actual sample heights,
Pila--Wilkie source contract, complete exponential fixture and floor/lift
obstructions. No production integration or Lean theorem was reviewed here.

Review ran 20:38:15--20:42:49 UTC within ten minutes, reassessing at 20:41:58.
Both adversarial guides were read in full, with unchanged SHA-256 identities
`798c3cc974c5296453f510ea9264aa8b5d17c813c8dc217a430de9b68b7d667c`
and `c4a04d75a297c6ec361d31ab11e465e3c3e74a6c89eb590bddb03d95c243ad3b`.
The replacement procedure, critic and source-contract skills applied. Review
was read-only: no checker, build, extraction, rendering, network or mutation.

**D: none. I: none requiring action.** The repaired fixture exception
H(1/4,2)=4 and initial failed check remain recorded. **Q1: retained open:**
actual avoidance supplies no additional witnesses contradicting an applicable
counting bound. **Q2: retained open:** the raw BBP graph's definability and
transcendental-part conditions remain unproved; granting them does not repair
Q1. **Q3: retained open:** no pi-specific common-hole division subfamily is
constructed, and the Cantor theorem's irrational-slope extension is not adopted.
All three block a visitation conclusion, not these scoped negative assessments.

The reviewer reconstructed the universal paper arguments and independently
inspected original Pila--Wilkie pages 2--5, including the R_exp example.
Source PDF SHA-256 is
`f00e482c9abce4bb9c2af51a79f5595d360fcd308fb9a261c13fcde5690c70ce`.
All eight worker artifacts plus manifest, 13 input hashes and 13 parent entries
matched. Parent unchanged replay exited zero, byte-identical to the original
257,126-check receipt with empty stderr. Checks exercise finite synthetic
arithmetic, not universal density, height asymptotics or o-minimality. The
complete source proof/dependencies, o-minimality proof and PNT source were not
independently audited. No actual phase/carry census was performed. V/M4 and
odd-carry infinitude remain open; production integration review follows.

## Fixed finite column normality — 2026-11-27 UTC

Reviewer `/root/finite_log_independent_review` independently reconstructed
this positive paper claim using both complete adversarial guides and the
unchanged replacement procedure. Exact worker packet:
`/tmp/pi-m4-fixed-column-normality-20261127T203933Z/`, report SHA-256
`d3be3ecd92e6f3ea4009a5ef366bcefabeb5a5a0660abe956acf9597abab0998`,
manifest `818c4da118e9b6ed4d02a4c25174937b9b69e4578bb31243c8218360708ff33d`.
Parent packet `/tmp/pi-m4-fixed-normality-parent-20261127-2055/` contains
assessment `6bb27fe2193055f0326425278c02f2f415687ab1fec46ca3b49558b298c193fe`,
five-entry manifest `1e73cb4b85fc46a40bc5f1da5720dfb44ba09b2782bd9b97bca6eea2ad8c65c9`,
and complete `review-full.txt`, SHA-256
`30c21ae9ed5a7274b41c92e58972bdb835cd9ec8b900e6d1a4bd431680b95295`.
Review ran 20:54:42--21:00:57 UTC within twelve minutes, with reassessment
at 21:00:02. Baseline HEAD remained `3f354d516832eb5970402696a61607cd193bb5c5`.

**D: none. I: none requiring correction.** Parent's elementary
s_M>=ceil(M/136) refinement was verified. **Q1: retained open:** every target
and starting threshold still needs a suitable growing M with an actual
unscaled visit before the sufficient approximation endpoint, absorbing both
errors. **Q2: retained open:** the qualitative fixed-number rational-affine
step supplies no uniform finite-window inverse-branch estimate. Neither
question blocks the limited fixed-M paper result; both block transfer to V.

Verified scope includes global unit survival, exact level/kick counting,
source domain and explicit constants, weighted level summation, real and
summable tails, circular endpoint treatment and qualitative unscaled transfer.
The reviewer independently inspected Bailey--Crandall printed pages
529,530,533,534. All 17 worker files plus manifest, five parent entries and
ten source-provenance originals matched. Parent unchanged replay exited zero,
empty stderr, byte-identical 103,494-check output. The checks are finite
structural fixtures, not an infinite proof or actual phase census.

Guide hashes remain the two full identities recorded immediately above.
Critic/source-contract skills applied. The reviewer ran no checker, probe,
build, extraction, rendering, service call or mutation. The classical source
proof chains were not fully audited. No kernel proof, production integration
or V/M4 acceptance is certified. Every fixed M>=6 actual T_M is normal at
paper level; growing-M visits and actual odd-carry infinitude remain open.

## Symbolic pumping and seed domains — 2026-11-27 UTC

Separate reviewer `/root/post_profile_mechanism_reset` assessed another
worker's packet under the read-only replacement procedure and both complete
adversarial guides, with the unchanged full hashes recorded above. Scope:
`/tmp/pi-m4-new-history-witness-20261127T203542Z/`, report SHA-256
`2a3423a5c1fc58e85e63cbbe288b8119b8b016a477d41a2dc2fd05b2ee44265a`,
original manifest `a752712d0a89bc3560aad4b42954cd6bea1a750ff6243e3c4e8a4f949d846593`,
separate clarification `7a2f11c34a7967eb742f9c017e5f5b1c70457e61a2078b40dd08b06b8484775e`.
Original frozen files were preserved. Parent packet
`/tmp/pi-m4-pumping-parent-20261127-2053/` contains assessment
`a36844d8d4850efbbc1079a765fbac30d8b885ca9574e2ca0fe4c842a2c20088`,
five-entry manifest `27db12880b07f229f8931e6b6d5727dc21cdd6de804b02ea2f0ea37c34919ae0`,
and complete `review-full.txt`, SHA-256
`c8e3eae4fe9813706b79557042f38da1a98e4e2ff81a63bb4fa40eb66fa071d0`.

Review ran 20:57:43--21:02:44 UTC within ten minutes, reassessing at 21:01:50.
**D: none remaining. Earlier same-session D1: verified resolved** by k>=1
for canonical periodic phases, excluding the all-15 endpoint.
**Earlier D2: verified resolved:** rational phases require irrational BBP
seeds before considering prime support. **Parent domain repair: verified:**
the fractional-prefix splice formula needs q+I(1-a) for the full period.
Equal-length dyadic and unequal-length irrational differences are unchanged.

**Independent I1: implemented in production, integration recheck pending.**
Nonzero dyadic seeds tending to zero have unbounded reduced powers-of-two
denominators. Every single fixed rational slope r with odd p allows only a
bounded power of two in rD_p denominators. Thus no fixed r accommodates the
infinite family; an individual dyadic seed can belong to a suitable rD_p.
This clarifies the family conclusion without a new execution test. The
separate earlier same-session I1, deferring peripheral formalization, remains
accepted. **Q1: retained open:** no infinite admissible-edit mechanism creates
the needed fixed-odd-support family coupled to actual initialization.
**Q2: unchanged:** V/M4 and odd-carry infinitude remain open.

The reviewer reconstructed the symbolic return-loop argument, bounded gcd
cancellation, repunit-specific lifting, finite swaps and uniform raw-hole
threshold. Parent unchanged replay passed 9,268 synthetic checks with identical
stdout and empty stderr; all six original files and the separate addendum
were preserved. The checker does not certify the universal arguments. The
reviewer inspected files, hashes, actual bridge/tail declarations and the
archived consumer; it ran no checks, writes, extraction, network or delegation.
No new audit of the Cantor source's external chain or kernel proof is claimed.
Concurrent production edits were excluded from this paper review.

## Finite normality, witnesses and point-count integration — 2026-11-27 UTC

Reviewer `/root/finite_log_independent_review` read the complete five-path
integration against `3f354d516832eb5970402696a61607cd193bb5c5`:
`m4-fourier-windows.md`, `m4-generating-functions.md`, `m4-handoff.md`,
`research-log.md` and this report. Packet
`/tmp/pi-m4-finite-normality-integration-20261127-2107/` retains
`scope.diff`, SHA-256 `8dfc7ae5fe8a6015d0620c5dfc727f25a59aff358e9144ebfe9b272be61a67d5`,
and 88-entry manifest `a15756a5107f4502c486d624fe6b24b4083fa53709b69db94f3e6fbc07b90f9a`.
Complete return `review-initial.txt` has SHA-256
`961c221731651e3260c9d923ab85beef636745fd7f4ebb666ca17563a56d12a9`.
The review ran 21:07:58--21:15:36 UTC within twelve minutes, reassessing
at 21:12:15. Both complete guides and the replacement/critic/source procedures
applied; no execution checks, service calls or writes were performed.

**D: no new blocking defect.** Earlier pumping D1/D2 and the full-period
clarification remain verified resolved. **Pumping I1: verified implemented.**
The owner distinguishes a family not contained in any one fixed scaled odd
localization from individual seeds. **Integration I2: implemented, focused
recheck pending.** The handoff now makes odd support explicit and uses the
same family-containment wording; support {2} alone is not the required odd
support. The separate earlier advice to defer formalization remains accepted.
All fixed-normality Q1--Q2, point-count Q1--Q3 and pumping Q1--Q2 remain open.
They block V/M4, not the limited paper results. No new proof dependency is
silently discharged.

All 88 entries, five baseline snapshots and 28 preservation hashes matched,
with unchanged HEAD and empty index. Historical source inputs matched the
specified baseline; legitimate owned-file changes were not mistaken for
scratch corruption. Three complete paper-review captures and caller replays
were verified. Documentation (93) and whitespace passed; process (38) passed
earlier with unchanged code. No Lean changed or was rebuilt. Classical
source chains and PNT were not fully audited. The fixed-M normality claim is
paper mathematics, not kernel certification. Fresh joint-early work is
excluded from this integration. The original frozen diff and all records
are preserved while the narrow handoff wording receives focused review.

Focused review completed 21:18:26--21:18:58 UTC within six minutes.
**Integration I2: verified resolved; pumping I1: remains resolved.** No new
defect, improvement or substantive drift was found. Every original Q remains
open. The reviewer verified all 98 current entries, all 88 original entries
through the five before-fix snapshots, the reconstructed repair delta, live
five-path diff, five baselines, 28 preservation hashes, unchanged HEAD and
empty index. Complete return `review-focused.txt` in the integration packet
has SHA-256 `e9c007252766491b11bc4a77f617697e16001027726ccd562f9d4e955019d537`.
The repair diff is `88f865faf67529df14fb0349da4df93fd4c69fcbcef441f35160b0a9f5f38538`,
revised diff `31e6eab6011f040c73ad2c5e8454c1c538168b3d595f457e504f4fe1d37bff72`,
and 98-entry manifest `bb9c383b46ecc306efbb737e05bf450b26ddd9814d795af887a54fcdb6eab5d9`.
The caller's post-fix documentation and whitespace success were inspected;
no checks were executed by the reviewer. This closes the integration review,
not V/M4 or the source/kernel evidence limits. Subsequent provenance searches
and the joint-branch report are outside this frozen mathematical integration.

## Fixed-column provenance and Lean search — 2026-11-27 UTC

Reviewer `/root/post_profile_mechanism_reset` reviewed the parent's complete
source comparison, pinned Lean definitions/statements/proof bodies, selected
search evidence and the literature worker's exact-versus-generic comparisons.
It ran 21:32:47--21:38:50 UTC within eight minutes, reassessing at 21:36:01.
Both complete guides, replacement procedure, argument-critic and source-contract
instructions applied. This was read-only source inspection, not external
kernel replay, exhaustive source-chain review or originality certification.

Parent packet `/tmp/pi-m4-fixed-truncation-provenance-20261127-2123/` retains
report SHA-256 `4fb2447068000eb458e0de71ab71fde5c704ab956784ffd33305ef58f2bb2467`,
query ledger `59c5765311c55c8daf66761a8e48b8b033f61a197a87d4c5d67fb2f8243ee074`,
30-entry manifest `5876f83cb0504ab1269c67f66f5823bc8280d70628457f5793ac0fe7a05fe1a9`,
and complete `review-full.txt`, SHA-256
`29d356897d75d6ab9a16b31affb0dc82fd77e4f266fdd01ebe59ed192ece0190`.
Supplemental `Basic.lean` is `14fa9eeb0430cba5706e962a092d454cad5f8ab4336cc2bb5e9323b9b4be1325`.
The literature packet `/tmp/pi-m4-fixed-truncation-literature-20261127T212426Z/`
has report `70e9c429bfd6ca75b5b62e572fd85ccaa03b99b3f98e07991f26640334ad5ccf`
and 24-entry manifest `b6372b664b90660d91ad4885e37b2b4bdb9e0df8501d6701d92d8ed3541fc6d7`.
It contains the query ledger, exact source identities, rendered theorem pages
and the prior commit-date record. Parent verified every entry unchanged.

**D: none found. I1: implemented, integration recheck pending.** Kano's synopsis
now retains coprime integer bases a,b>1; the separate immutable
`kano-hypotheses-addendum.md` has SHA-256
`b69780ea9045f5969196208fb084d76204cdc6d559d12817531597c33667a419`.
The correction needs no execution test. **Q1: resolved:** the previously
missing `NormalIn`, `shift` and `frequency` definitions were supplied and
verified as the full overlapping-word statement. **Q2: retained limit:**
the reported replay baseline e4809cf differs from inspected 062e66cf; no
external rebuild, full axiom audit, CI or local-pin compatibility claim.
**Q3: retained limit:** no located exact theorem is not proof of absence or
originality; the exact T_M theorem and arithmetic/application are not in Lean.

The reviewer reconstructed the b=16,c=17,L=B=2,d=3 certificate application,
including all denominator floors, zero error after finite integer insertions,
the exceptional-block fraction and final integer dilation. It checked the
same-prime theorem's base/weight mismatch and distinct-prime BBP hypothesis.
All 30 parent entries matched; the supplemental literature report was read,
but its searches and every cited proof were not independently repeated.
The original local proof's separate Codex review is not external human peer
review. V/M4 and the growing-M consumer remain open. The new meta-plan
checkpoint and production integration require their own changed-file review.

## Integer branch and projection tests — 2026-11-27 UTC

Reviewer `/root/finite_log_independent_review` read and reconstructed the full
joint-branch report, checker, parent assessment and centering addendum. Review
ran 21:35:38--21:38:36 UTC within ten minutes, reassessing at completion.
Both complete guides were reread; replacement, critic/source context and
relevant checked interfaces applied. No execution checks, network, writes,
extraction, builds or delegation were performed.

Worker packet `/tmp/pi-m4-joint-branch-cocycle-20261127T210201Z/` retains
report `eeba6e803b7e0c1c9459a13b67390512a517c960474276d620666d0a3a0715ad`
and manifest `20c0e71ffec6e3b8ee5a9a57eb8b1061579d21996d597ff29bd91894e12724e0`.
The separate centering addendum is
`ae31935f8400efffe3067442afed45d95cf760149c87e3510971fa25e97ceb3d`.
Parent packet `/tmp/pi-m4-joint-branch-parent-20261127-2134/` has assessment
`bb22af80b1c920579844dbdd4e8a9b0569aa2c81c4cc28f631642d73d3ac46ed`,
seven-entry manifest `8886e168800e6cf80dd795c188a6f5c4897087891ad53350e2031fb3aefd5c36`,
and complete return `review-full.txt`, SHA-256
`0b97891ab1bb39b8e1221d3673cf9e1146d30beb6797243325373d7b4b9685d4`.

**D1: verified resolved.** The original raw-state closeness statement was
false; subtracting the explicit integer K_n supplies the correct representative.
The addendum also tracks reducing j modulo D. Historical artifacts remain
unchanged. **I1: implemented, production verification pending.** Raw P_n/D
lies in the infinite lattice (1/D)Z; only its fractional part lies in the
D-point grid. Subsequent proofs did not use raw boundedness. **Q1: retained
open:** no argument forces the exact zero branch into every target cell at
the required early scale. Any proposed block identity must retain the
137-pole contribution and give an actual interval inequality.

The reviewer checked the nearest-seed kernel, D/2 branch count, integer
recurrence, unique 137 pole, rounded forcing and separate nonvanishing-tail
argument. All four worker artifacts, three input reports, seven parent
entries and preserved originals matched. The caller's unchanged replay had
exit zero, identical stdout, empty stderr and 53,682 structural checks;
the reviewer read but did not run it. No actual pi phases, T_M values or
initialized BBP prefixes were computed. Fixed-M normality and PNT-dependent
D growth remain supplied paper inputs with their previous limits. No new
source-chain or kernel audit is claimed. V/M4 and odd-carry infinitude remain
open; this paper review alone does not review production integration.


### Provenance, branch and prior-work checkpoint integration — 2026-11-27 UTC

Separate Codex reviewer `post_profile_mechanism_reset` reviewed the exact five-path
integration against `7867c2a80178f95f12ad9f91ef410dec7eae9886` from 21:53:32 to
21:59:45 UTC, reassessing at 21:58:17 before its midpoint and 22:05:32 deadline.
The packet `/tmp/pi-m4-provenance-branch-integration-20261127-2142/` retains
`scope.diff` SHA-256 `3b8efc605f39675a2213a9d017792dab096febd016775c04cee066343c7da64b`,
the 91-entry manifest `87f4720075fdcc6800d95a50d90fecd2bd9564fe086b5bdaa159c66d875034af`,
and full returned review `8a9e99d0f8c07a63c004f15f5be06a4454dfa8b29e97268b58faf5c260088434`.
Both full adversarial guides and the source-contract/critic skills were read.
The reviewer reconstructed the certificate specialization and branch arguments;
all frozen identities matched, including the historical owner's baseline snapshot.

No new D or I was found. Earlier branch D1 (explicit integer centering), branch
I1 (lattice versus fractional grid), provenance I1 (Kano base hypotheses) and
provenance Q1 (actual normality definitions) were verified resolved. Integration
Q1 retains the actual early visit gap; Q2 retains absent external rebuild, axiom
audit, compatibility and exact specialization; Q3 retains undetermined priority.
All are accepted limitations, not waived M4 obligations. Q4 identified missing
command text in the original validation JSON. Fresh command-bound whitespace
receipts at 21:59:16 show both working and staged checks exit zero; the original
93-document and 38-test outputs remain caller evidence. Their checks were not
rerun by the reviewer. The user-approved prior-work checkpoint preserves bounded
reassessment, small-refinement source reuse and explicit originality limits.

The reviewer disclosed one read-only Git status/HEAD inspection despite the
request's stricter no-Git wording; no state changed and no further Git calls
followed. No checker, build, network request or delegation was run. New signed-tail
research was excluded. The parent accepts the review with that disclosed
procedural deviation; no substantive repair is required. Subsequent edits here
record only this outcome. This is an intermediate documentation checkpoint,
not a Lean proof, external human review, V or M4 acceptance.


### Signed tail and full-prefix comparison — 2026-11-27 UTC

The first worker packet is `/tmp/pi-m4-signed-tail-modular-window-20261127T213937Z/`:
report SHA-256 `acf2f29479d3f485e02e750aa2a00e20b8bfa3776caf827facaabd7561b6540b`,
manifest `4659304538c9d937aa9e65a1e6939d4670384c5270ab7e129e3449ad723702cb`.
Parent assessment and unchanged148027-check replay are in
`/tmp/pi-m4-signed-tail-parent-20261127-2156/`; its assessment is
`328e34dbdf8e94255e2a6acc068c4aef1aefb383e7dc67c7812537c57b909923`,
and full returned review is
`8a1629052f4602bb2d30563a55666e55f59e7afb5e42347799ea50ae1aa6286f`.
Separate reviewer `finite_log_independent_review` ran21:55:31–21:57:48,
reassessing before its midpoint and22:05:31 deadline. No D/I was found.
The reviewer reconstructed the infinite mask/remainder, nonzero17 constants,
integer-centered rounding window and margined transfer; finite tests do not
prove those infinite claims. Q1 retains the absent visit; Q2 requested the
strongest simpler-prefix comparison. Both were accepted for investigation.

The resulting comparison packet is
`/tmp/pi-m4-window-prefix-comparison-20261127T215441Z/`, report
`9b3a69c8f650e27c2bc9141fcddfdee559a876b4fb4909a856fdc0da133d2c4a`, manifest
`f09766b919d5d16e04a4348851a1e4d59dad8be75f2900d5c2b953b6380c6e21`.
Parent complete proof/checker inspection and5983-check unchanged replay are in
`/tmp/pi-m4-prefix-comparison-parent-20261127-2204/`, assessment
`ac7f2279baf2d5d33a65c597740a4c271b4e0a14cbeefe368c51397a4fd8ce0c`, full review
`94ac4d0b5abe0ebb940e6decae8b2b9307fb228a64db0e0febea93620582543f`.
The same separate reviewer ran22:05:15–22:07:38, reassessing before its midpoint
and22:13:15 deadline. No D/I was found. Prior Q2 is resolved within the tested
scope: the selected cutoff window supplies no new transfer or finite-frequency
estimate beyond the actual full prefix; the existing first correction is stronger.
Q1 remains actual phase placement, not a failed compiler or missing library lemma.
The tested fixed-order recurrence exclusion retains the prior PNT input and does
not exclude nonlinear, floor-dependent or growing-order representations.

Both full adversarial guides and the critic/replacement procedure were applied.
Worker, input and parent hashes were verified: respectively6/5/17 and6/5/21;
the second review uses the frozen baseline Fourier-owner snapshot after legitimate
production edits. Both replays were byte-identical with empty stderr and caller
exit0. No actual pi period, cutoff value, raw prefix, digit or carry census was
computed. Reviewers read the checkers without running them; no writes, builds,
network, Git operations or delegation occurred. The q-holonomic primary record
was bibliographic context only. No full source audit, Lean proof, originality
claim, positive visit estimate or M4 acceptance follows. Production integration
has its own exact-diff review; these are the completed scratch-paper reviews.


### Tail-comparison integration and publication cadence — 2026-11-27 UTC

`post_profile_mechanism_reset` completed the exact four-path mathematical
integration review from22:12:02 to22:16:07, before its midpoint and22:24:02
deadline. Packet `/tmp/pi-m4-tail-comparison-integration-20261127-2206/` retains
diff `f3154be1b03fc2b4fabd867b6371de55f015f4e86caf301d2dd646e936689669`,
45-entry manifest `f06889d6bbce44a54f6e956e7775a61db5e0e8978643b3609ca4270c952bdcd1`,
and full review `4bddd2f2029116a8f033940a09b19659d5830140b0e21beb49dac51d3c39c33c`.
No D was found. I1 proposes deriving period34 directly from the defining
geometric denominator; the parent accepts its validity and defers optional
cleanup to retain correspondence with the already verified numerical-q proof
packets. Q1 remains actual phase placement; prior Q2 is resolved for this
comparison; Q3 retains source/PNT and representation limits. Q4 identifies the
new user-authorized push cadence, resolved by the separately reviewed policy.
Both full guides were read; all45 manifest and17 protected-file hashes matched.
No writes, checker execution, builds, network, Git or delegation occurred.

The user's regular-push request is implemented in AGENTS, the workflow, current
prompt and handoff. `finite_log_independent_review` reviewed their exact
prospective delta from22:15:39 to22:17:09, before its midpoint and22:23:39 deadline,
using the full strategy/tooling guide. Packet
`/tmp/pi-m4-push-cadence-policy-20261127-2215/` retains diff
`243de775ea1b773489850add37e51963a80db1b46077dad46467424374fca593`, nine-entry
manifest `6d0b5c901ab54f842f8929f6860468d7da2d22346103e6bdfa822cf7e8bca58f`,
and full review `ab67488203028b7851b0d3d44d6c49af9f3f67bb40b8d8425cd52a2c128398fe`.
No D/I was found. Q1, application validation, is resolved: the parent applied
the exact reviewed bytes, preserving the mathematical handoff content, and
observed93-document,38-process-test and whitespace checks exit0. No reviewer
ran checks or changed files. Neither review certifies the other's excluded scope.

The combined seven-path finalization is the verified composition of those two
reviewed deltas, followed only by outcome records. The cadence publishes ready
reviewed work every15 active minutes and at milestone/result/direction events;
no empty commit, force push, PR or background-service promise is introduced.
Mathematical acceptance gates and the open V obligation remain unchanged.

### Actual short-difference paper review — 2026-11-27 UTC

Separate Codex reviewer `post_profile_mechanism_reset` read the complete parent
paper, checker, original critique, dispositions and relevant owner arguments
from 22:26:43 to 22:30:16 UTC, reassessing before the 22:31:43 midpoint and
22:36:43 deadline. Packet `/tmp/pi-m4-short-differences-20261127-2222/` retains
report SHA-256 `ca4ad33d9017877e5c55716b744d819c1ede0c6a34c8f13da64577a8a46ad29f`,
17-entry manifest `dec046997e991b3df0d32f893aeab3e0f0d259d8b4295b217ebcb89696061ad8`,
checker `53d7d908b8565dce49e34d21152d04d5cb10eee8076aa74fc7a66972ea5e0da8`,
and full returned review `78bbe7079628c74b71839c62e0105c3e12eb3d4934023e70173284e3a53f3de5`.
The complete response was requested again after compaction and captured without
re-reviewing. Original frozen artifacts remain unchanged.

No new D was found. Parent D1, the critic's false singleton activation identity,
is verified resolved by summing all primes activating at the index; the
N=7,n=12 two-prime fixture distinguishes the repair. I1, the fixed nonzero
frequency denominator corollary, is implemented in the production proposal.
Critic I1's centered-CRT correction is accepted; critic I2's ordinary-difference
test and the parent's growing-depth extension were independently reconstructed.
Q1 retains the missing signed finite-minorant estimate. Q2 retains the exact
depth/total-shift restriction and permits other methods. Q3 retains the prior
PNT paper input, absent fresh source-proof/Lean audit and limited source screen.
None is waived as an M4 acceptance obligation.

All 17 identities matched at review time, before the production owner edit.
The integration baseline preserves that historical owner. The caller's replay
matched its original receipt byte-for-byte, with exit zero, empty stderr and
83,923 structural checks; the reviewer read but did not execute the checker.
The uniform asymptotic estimates were checked as arguments, not inferred from
finite tests. Both full adversarial guides were applied, with proof-guide hash
`798c3cc974c5296453f510ea9264aa8b5d17c813c8dc217a430de9b68b7d667c` and
strategy-guide hash `c4a04d75a297c6ec361d31ab11e465e3c3e74a6c89eb590bddb03d95c243ad3b`.
No reviewer writes, checks, builds, network, Git operations or delegation occurred.
The paper review excludes production integration and the operational publication
receipt. It establishes no Lean theorem, originality, character cancellation,
actual odd-carry infinitude, V or M4 acceptance.

### Short-difference integration review — 2026-11-27 UTC

`finite_log_independent_review` completed the exact four-path integration review
from 22:40:24 to 22:43:05 UTC, reassessing before its midpoint and 22:50:24
deadline. Packet `/tmp/pi-m4-short-difference-integration-20261127-2231/` retains
baseline `b5a6f2c1705102942e7c46b68a61ffb05bb9ac16`, diff SHA-256
`21c1b0cef153a4dc7d8fcc627dde290b0351bde0cda051e499a868a5e22ebc28`,
33-entry manifest `598c5715918b4126b52c88a4f77e3d7ec14fd19c8fc669c8f8573c5eb8920dfb`,
and full returned review `e296b48f94d2ff6f99cd7e609693411377781465c93ab7270d003d5a29594689`.
No new D/I was found. Prior D1 and all I dispositions were verified integrated;
Q1--Q3 retain the missing signed estimate, exact operator regime and source/Lean
limits. The parent accepts those limits without treating them as M4 acceptance.

Both complete guides were read. All 33 integration entries, 17 historical paper
entries, five paper inputs and 17 protected plus 11 unrelated-file hashes matched.
Live files matched the proposed snapshots and patch content/ranges/blob identities
matched the saved baselines. The historical CRT-owner mapping was checked.
The reviewer read command-bound caller receipts for 93-document, 38-process-test
and whitespace success, plus the structural replay; no checks were rerun.
Remote verification remains caller evidence. No reviewer writes, builds, network,
Git operations or delegation occurred. Only review-outcome records are appended
after this frozen review. No mathematical acceptance status changes.

### Chang and Wu--Xi contract assessment — 2026-11-27 UTC

The source researcher `fresh_visitation_consumer_critique` completed the bounded
primary-contract inquiry at 22:50:04 UTC. This was source research, not an
independent review. Packet `/tmp/pi-m4-chang-phase-contract-20261127T224045Z/`
retains full PDFs, text, rendered theorem pages, receipts, 16 input snapshots,
report SHA-256 `c48972be94c5f2fd2077b8c5124e32ff91a6a43889d6e1640aba24ff9ad3b609`,
and 50-entry manifest `d3c60cf6488ef9d5afecd548e52edc1283dcf849fa03f1577fda7967d1be894a`.
Its completion records the 22:40:45 start, midpoint reassessment and 22:52:45
deadline. No general search or originality determination is claimed.

The parent verified all artifacts and snapshots and read the complete report.
Chang pages 2/38 and Wu--Xi pages 19/23/32 were inspected visually, with the
remaining cited framework and convention passages read in primary extracted text.
Parent assessment is in `/tmp/pi-m4-smooth-source-integration-20261127-2254/`,
SHA-256 `f76f62375f90b29e67ceb688532505390b9c1e02ea3e250015c8d32b6f271454`.
The natural common-window modulus clarifies the scale comparison without
asserting a character representation. The parent found no source-mapping defect;
the independent exact-scope review remains separate.

The actual split-prime zero constant, growing natural conductors, restricted
interpolation limits and simultaneous activation sum are retained. The first
unsupported bridge is still a source-class representation and useful signed
estimate for the actual coupled phase. Full source proofs, hidden constants,
growing-width control, external Lean builds and axiom audits remain unexamined.
No actual pi, prefix, digit or carry census occurred. The initial Swift cache
failure was repaired with an existing scratch cache; no installation, dependency,
permission or production-code change occurred. This is neither V nor M4 acceptance.

The combined exact four-path source/integration review by
`post_profile_mechanism_reset` ran 22:53:58--22:58:42 UTC, reassessing at 22:57:31
before its midpoint and 23:03:58 deadline. The integration packet retains diff
`67edd710b23fb6a1d102702faf92ba212ee3e5dfc1166c1efda62598c654b9c2`,
74-entry manifest `2c0091e42f28c5e5e92f223aab64d0a466f56c9c264c669325353b24f0b754b2`,
and full returned review `44888195e99d5bcbb7426b3e21bfbfe2dd1a2fef76b768127d61f6c305bd14c1`.
No blocking D was found. I1 is implemented and verified: Wu--Xi's general
framework permits positive squarefree q, including primes; the smoothness
exclusion for a single prime belongs specifically to Theorem 4.3. The natural
lcm also needs a suitable squarefree/coprime separation with its remaining phase
controlled. Repair diff `8421720f0cbca5ca54a3038e7e3d8102c3aba72491d7f8b6fe102434b15a226c`
and repaired-owner hash `b9f510a8f72fe26edbfea60bcff207d02d49d39ec64eda519d516781c6038aa2`
preserve the original frozen artifacts. Q1 retains the actual class/period,
conductor, width and quantitative phase bridges; none is waived.

Both full guides and the complete reports/diff were read. All 74 integration,
50 worker and 28 preservation identities matched; the repaired live owner and
three unchanged proposed files were verified. The reviewer inspected Chang
pages 2/38 and Wu--Xi pages 11/19/20/23/28/32 visually, with remaining cited
passages read in supplied text. No reviewer writes, Git, network, builds,
checkers, rendering or delegation occurred. Caller checks after I1 passed
93-document and whitespace validation (b53858/b9f902); the earlier 38-process-test
result remains an unchanged-code receipt. Subsequent edits record this outcome
only. This is independent model review, not human peer review or a full source
proof/dependency audit. The exact phase estimate and M4 remain open.

### Actual-denominator grid and correction paper review — 2026-11-27 UTC

`finite_log_independent_review` independently reviewed the elementary grid
argument and separate natural-correction comparison from 23:09:14 to 23:16:06,
reassessing at 23:14:38 before its 23:21:14 deadline. The worker packet
`/tmp/pi-m4-selected-phase-discovery-20261127-224812/` retains report SHA-256
`87e7c6f67ef6e037b0ae9c6c6b719c1c703b0a256765e69211ae793be7b759e8` and
12-entry manifest `a003efdfc57d1bd39bc95181fe3418186b33ca963b9cdfe893e581cb7d91913e`.
Parent reconstruction and unchanged-copy replays are in
`/tmp/pi-m4-actual-grid-parent-20261127-2307/`, assessment
`0570f4c6d4f2c3777a0f082ee72408e45864089530558927ce53564cf85b4c1c`,
34-entry manifest `38774903b65f635d12af56b013a7a094d3276fd4a4bb00134046e732b3f48e8a`,
and complete returned review `c619b550c98e5a351504f552a6b9507604731112024db3ae0399b92c5802f541`.
The separate packet `/tmp/pi-m4-grid-correction-comparison-20261127-2310/`
retains report `fa956af6a6d7a6335e96d8f7b2b4bca5c17c41fc5d26f557f01603abdd92901c`
and eight-entry manifest `4f76a92f7f26a956d86c9577d9cc111602d0a79e8ec78dd19487a4c52d236b00`.

No D was found. I1 is implemented for integration verification: normalized
unit numerators, one complete period and fixed word length before choosing the
anchor prevent a normality or reversed-quantifier claim. I2 explicitly retains
Kominers's m>=3, 1<|D|<m and normalized coprime source domain. I3 puts the
moving-set toy on R/Z with every translation and recurrence modulo one. Frozen
reports remain unchanged. Q1 retains the actual early numerator/circular-tail
selection gap. Q2 retains the limited correction family and absolute-shadow
comparison; other cosets, initial hits, circular coincidences and other rational
approximants remain open. No improvement was requested for the comparison itself.

The reviewer reconstructed the actual unique pole, Euler covering, every other
prime-power order bound, LTE/CRT subgroup, unit permutation, grid counting and
fixed-word conclusion. The separate comparison's uniform high-prime divisor,
17-valuation, dyadic preperiod and two incompatible time scales were checked
against the owner arguments. All 12/34/8 identities and manifest digests matched.
The three caller replays exited zero with generated receipts byte-identical to
the originals; reviewer read but did not execute the checkers. The comparison
has no new finite test; its deductions are mathematical arguments from the
stated inputs. Primary Kominers and Lin--Wu--Yang contexts were inspected, but
the main elementary grid proof imports neither external estimate.

Both full adversarial guides and the critic/source-contract skills were applied;
guide hashes remain `798c3cc974c5296453f510ea9264aa8b5d17c813c8dc217a430de9b68b7d667c`
and `c4a04d75a297c6ec361d31ab11e465e3c3e74a6c89eb590bddb03d95c243ad3b`.
No writes, checker execution, network, Git or delegation occurred. No fresh
Korobov/PNT proof audit, external Lean certification or literature-wide novelty
determination is claimed. PNT dependence remains in the asymptotic chronology
and correction comparison. Production integration and I1--I3 verification have
their separate review. Actual visitation, odd-carry infinitude and M4 stay open.

### Actual-denominator grid integration review — 2026-11-27 UTC

`post_profile_mechanism_reset` completed the exact four-file review from
23:23:50 to 23:27:07 UTC, reassessing at 23:26:41 before the 23:35:50 deadline.
Packet `/tmp/pi-m4-actual-grid-integration-20261127-2313/` retains baseline
`dbba18d2cd3649bfb00392d26ac595b793fdc636`, frozen diff
`70a638787a6e1c249ffa620d7588ec74cee5ea74f2605791f819a9e1f6189843`,
50-entry manifest `062b5f9e72bd17ade6c7ffa27f91dc17a5bd66f2b489a9692c0e77893688d28f`,
and full returned review `ac5ee29f8efd9bcb76c2ff3d8e84eaebd7577bc335492fa703329dc67909f257`.
No D was found. I1--I3 were verified implemented. New I4 is accepted, implemented
and verified: the source-context bound explicitly requires a prime p not dividing
m. Repair diff `7bac0eff978befd7beec38f921e1bc1440eccdd00f8aec3f38f24289eed3a566`
and owner `50992a5ac5893b63461fb11d2ef505af821f1716e923699ecefef400e77c10af`
preserve the original frozen artifacts. Q1 and Q2 retain actual early selection
and the unexcluded alternative transfer mechanisms; neither blocks the stated
paper result, and neither is discharged by it.

Both full guides were read with the preceding hashes. All 50 integration,
12 worker, 34 parent, eight comparison, 17 protected and 11 unrelated identities
matched, using the explicit historical-owner mapping. The reviewer reconstructed
the elementary argument and separate PNT-dependent uniform comparison and
inspected caller receipts without executing checks. The final caller validation
must cover I4 and these outcome-only appends. No reviewer writes, Git, services,
builds, checker execution or delegation occurred. This is independent model
review, not kernel checking, human peer review, a fresh PNT/Korobov audit or a
novelty certification. No mathematical completion status changes.


### Full 17-coordinate discriminator — 2026-11-27 UTC

`finite_log_independent_review` reviewed the archived-sieve specialization from
23:25:27 to 23:27:35, reassessing at23:27:07 before its23:35:27 deadline. Worker
packet `/tmp/pi-m4-full17-coordinate-20261127-231627/` has report
`198841b38702a266c903001680bc867c3a6efd74145e6d877c40408ff6e68df6` and
five-entry manifest `72527eba59c588e9d95dd4b1cdddf1e663e7b2db89825d1fe33098cbca6f0583`.
Parent packet `/tmp/pi-m4-full17-parent-20261127-2327/` retains assessment
`fb50fdb66b357f03f934e7a30f883a9bcfe769b1e38784d483183cb7ef6c0bef`,
seven-entry manifest `9ac366367a0269928f3cae194869a411e801d3a28b9354b78fdf25c4957f2ea0`,
and full review `b0d1a37b105835977e17c64ced75ab4a5678a1f4672b2fe3240bc08c47f2dea1`.
The parent reconstructed the argument and replayed the unchanged synthetic
checker:84 progression and36 CRT fixtures, exit0, byte-identical receipt.

No D affected the eventual conclusions. I1 is accepted and implemented in the
concise production summary: require k>=1 for the unique-pole argument. I2 is
accepted and implemented: the complementary coordinate modulo M changes, while
individual complementary prime components are not controlled. Q1 retains the
missing actual complementary-numerator/history estimate. The archive-equivalence
recommendation is implemented by cross-reference rather than a duplicate proof.

Both full guides were read, with the preceding unchanged hashes. All worker and
parent identities matched; the historical prime-owner input matches the retained
proposed snapshot of the grid integration packet. Reviewer inspected caller
receipts without executing the checker. No reviewer writes, Git, network, builds
or delegation occurred. PNT remains an archived paper input. Production integration
is a separate review; no infinite avoidance, novelty, Lean or V claim follows.

### Elementary grid contract and first Lean boundary — 2026-11-27 UTC

`finite_log_independent_review` reviewed the contract and frozen first support
probe from23:37:02 to23:39:23, reassessing before midpoint and its23:47:02 deadline.
Packet `/tmp/pi-m4-grid-lean-start-20261127-2330/` retains the root-imported v6
probe `e6d24579ddf8e67f3aa860549913c0c53e66dbcd1ad4e7d64af73f222f4da551`,
repaired contract `1d2d2ec4a0d3757161ba20ef39e22f10b85203f6dd1f0d6033b370076d15b124`,
repair diff `feb3e36ed76cfa08cf00f1c27c0657d3bb0463e2c0a0b08a28bf4900f3cac399`,
compiler receipt `b83bf928c599f7ab2a0d6d85bdbff8ea1f4f57a4f564326934bccf862b2345e1`,
and full review `d29df8c7b159bbb1fb9014f3b95e4257e8d2f9ba40afb0ae6ee57683dbe8229c`.

No D was found. I1 is implemented and verified: the final complete-period count
quantifies every normalized unit numerator, positive period, real casts and the
half-open interval. I2 is implemented and verified: all anchor indices are natural
and the exact division identity must be proved. Q2's missing compiler evidence
is resolved by the retained exact exit0/stdout/hash receipt. Q1 retains all
unproved selected-valuation, covering, order/CRT, counting and anchor/word steps.
The first probe proves genuine rational-prefix and denominator lemmas, not a
wrapper around those missing conclusions.

Both full guides were read with the preceding hashes. The reviewer inspected
complete source, existing definitions, exact ten printed axiom lists and all
contract versions. Parent compiler exits included initial cast/lemma-interface
failures, followed by the clean accepted v6 run; failed elaborations were never
accepted. No reviewer writes, services, Git, builds or delegation occurred.
Production exports, guarded audits and exact changed-file review remain separate.


### Rational-prefix production integration — 2026-11-27 UTC

`post_profile_mechanism_reset` reviewed the exact nine-path change from
23:46:33 to 23:50:48 UTC, reassessing at 23:50:26 before its 23:58:33 deadline.
Packet `/tmp/pi-m4-rational-prefix-integration-20261127-2340/` retains baseline
`a5aaf53d59c081bf6da27ff7cce062dd3ab45ccd`, diff
`17ad977bb5638c6f025e68aa8a427acfb97d1b6fb9907b810a4dec196d5bdef8`,
51-entry manifest `91ca359d0f4d71202c7b270adf9633cbc392fed678134f8a4c5f525cd0912bdd`,
and full review `ee516e98bac23b24496c5409f9d12b6fbd46220a54ec3b302dda2d93724b2b01`.
No D was found. I1 is accepted, implemented and verified: supplemental exact
command bindings, hash `b9e5a644c4ed0c2093305cf7cdf66b34c55c8d2882180578474269c3fc7804d5`,
resolve caller-receipt provenance without claiming a rerun or replacing frozen
artifacts. The reviewer found no justified simplification of the product-based
denominator proof. Earlier full17 and contract I/Q dispositions were verified.
Q1 retains every unfinished full-grid production and actual-selection obligation.

All nine live/proposed, 51 manifest, 15 protected and 11 unrelated identities
matched, with both historical mappings. Both complete guides were read with
the unchanged hashes above. The reviewer inspected every public theorem, root
export, exact Test type/definition guards, all twelve measured axiom guards,
and the boundary example that actually instantiates the n=0 recurrence bridge.
Caller full build, Test, 93-document, 38-process-test and working/staged whitespace
checks passed; no pins or old problem definitions changed. No reviewer writes,
Git, network, build, probe, checker execution or delegation occurred.

Only review-outcome/status records change after this frozen review. Final affected
documentation/whitespace and exact staged identities are checked before commit.
Concurrent arithmetic and terminal-valuation proofs remain separate scratch
work; this review does not certify their production integration. The elementary
grid theorem, V and M4 remain incomplete.


## Elementary grid production integration — 2026-11-28 UTC

**Status:** complete elementary statement kernel checked and independently
reviewed; publication follows final affected checks. Baseline `a0597c124329e3a25b5c4c0b628c05da5187100e`. The task-owned
scope is eight new Lean modules (`PrimeDenominator`, `EulerCover`, `PrimeGrid17`,
`ShiftedGrid`, `RationalHexOrbit`, `FiniteWordDiscrepancy`, `RationalGridDiscrepancy`,
`DenominatorGrid`), the root export, Test, proof plan/blueprint, prime-compression
owner, M4 handoff, research log and this record. Unrelated files and the sixteen
protected source/pin identities are preserved. The exact baseline/proposed
files, diff, preservation identities and validation receipts are retained in
`/tmp/pi-m4-grid-production-20261128-0007/`.

The intended claim is the complete elementary contract: actual inclusive BBP
prefix, selected 17-valuation and prime-order bound, positive complete rational
period, every unit numerator, all grid translates within that period, normalized
Ico-count discrepancy strictly below17^(-d), and infinitely many actual prefix
indices containing every word of each fixed length. The actual result assumes
d>0, r>1 and the explicitly defined Euler-cover congruence; the arbitrary
numerator additionally retains coprimality with the full denominator. Neither
actual-prefix result assumes discrepancy, visitation or normality. Words start
inside the period and may cross its boundary. V and M4 remain open.

### Independent component review cycle

All reviews used the current replacement procedure and both full guides: Lean
`798c3cc974c5296453f510ea9264aa8b5d17c813c8dc217a430de9b68b7d667c`,
strategy/tooling `c4a04d75a297c6ec361d31ab11e465e3c3e74a6c89eb590bddb03d95c243ad3b`.
Reviewers inspected files/receipts read-only; they ran no builds, probes, network
or Git operations. Parent replays are caller evidence, not independent execution.

| Scope | Reviewer and completion | Disposition |
| --- | --- | --- |
| Earlier arithmetic and terminal valuation | `/root/finite_log_independent_review`, 23:46:23 | No D/I; assembly question carried forward. Full capture in the initial grid-start packet. |
| Euler covering | Same reviewer, 23:56:42 | No D/I; actual consumer and arbitrary anchors verified. Full capture in grid-assembly packet. |
| LTE/CRT/real grid, actual decomposition, local grid count | Same reviewer, 00:05:43–00:09:19, within12minutes | No D/I. Q1 full-period/actual composition subsequently supplied by the new consumers; subject to final integration review. |
| Finite averaging and period/index interface | Same reviewer, completed00:14:04 before conservative00:21:19 deadline | No D/I. Q1 closure/count composition supplied; literal coset partition unnecessary. Q2 historical compiled-root limitation documented below. |
| Fixed-word consumer | Same reviewer, 00:18:51–00:19:58, within8minutes | No D/I. Q1 actual discrepancy application is supplied by `bbpCover_prefix_words`; subject to integration review. |
| Five complete-period composition declarations | `/root/fresh_visitation_consumer_critique`, completed00:22:33 within10minutes | No D/I/Q. Reviewer authored counting helpers but reviewed only the other agent's new composition, using separately reviewed dependencies. |

Full returned successor reviews are preserved as `component-review-full.txt`,
`averaging-period-review-full.txt`, `word-review-full.txt` and
`composition-review-full.txt` in the integration packet; their exact identities
are in `component-review-capture-hashes.json`. Frozen worker manifests and
accepted source files are linked by the validation packet. No recommendation
is dropped: every D/I category was empty; the stated open application questions
are closed only by the separately checked consumers, and V remains open.

### Evidence and remaining acceptance

Parent replays of the accepted worker sources all exited zero with only the
permitted three axioms. Intermediate root source hashes were reconstructed
exactly where needed and explicitly labelled reconstructions. Some historical
root `.olean` files were overwritten by ongoing integration and are unavailable;
no claim of retained historical compiled-input verification is made. Fresh
replays and final production checks provide new kernel evidence. Failed
elaboration, transient missing-build-input and malformed test-fragment outputs
are excluded from acceptance. No placeholder or bypass was written.

The final root build and expanded Test passed. Test guards every new public
theorem's exact axiom list and type, the seven new definition bodies, and
actual theorem instantiations at endpoint/empty-word/zero-word/trivial-modulus
boundaries. Documentation/process/working and staged whitespace checks also passed. The
immutable changed-file review remains before final staged inspection, commit
and remote push.
The elementary proof uses no PNT or Korobov assumption. Timing comparisons stay
paper mathematics, and no π visitation or M5 assembly is claimed.


### Final review and dispositions

`/root/finite_log_independent_review` reviewed the immutable16-path diff from
00:27:01 to00:32:00 UTC, before its00:47:01 deadline. It reconstructed the full
statement and verified all72 manifest entries, exact diff application,49 public
type/axiom guards,seven definition checks, all ten actual-consumer theorems and
16+11 preservation identities. No mathematical, interface or trust defect was found.

The sole improvement I1 corrected the owner's obsolete “No Lean proof” sentence
while retaining originality as undetermined. The focused verification ran
00:33:33–00:33:38, before00:38:33, and confirmed the exact repair and unchanged
original packet. No new finding was raised. Q1 prior composition is resolved;
Q2 historical compiled-input limitations remain disclosed; Q3 final affected
documentation/whitespace validation is completed before committing; Q4 actual
early visitation remains open. This completes the elementary formalization
review, not M4.

Initial diff SHA-256:
`57bb4dcaec7cf8cf18b4eea42acd3b491e5c8b99989e7486895c5533e2e3f6d3`;
72-entry manifest:
`4a47148b4d7631e74c8e441a4a00de1ccf164799221221a935108b2309c9b7a8`.
Full review `integration-review-full.txt`:
`a6dc941a426ee0c549385ae7ae6c2022bffcb62be710f4ad163117fa6fb77fc3`.
I1 diff `fix-I1.diff`:
`4e41d53e5b8be5fe38edd3835ad317c62808070b8f051eca67958e78b422ac3d`;
repaired owner:
`01fbe0547478f4e19ffca4c4ebf60c987e30e2904db6aa865276dce8cee77420`.
The full focused return is `fix-I1-review-full.txt` in the same packet. Final
status edits describe these outcomes only; no Lean source changed after review.
Final scope/validation/publication receipts are retained separately without
altering the original manifest.
