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
