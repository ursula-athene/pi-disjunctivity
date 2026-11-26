# M4 universal visitation handoff — 2026-11-26

This records the initial attempt. Its stopping/restart proposals were superseded
by the [persistence follow-up](#persistence-follow-up--2026-11-26) below; its
mathematical results and validation receipts remain historical evidence.
The [continued research checkpoint](#continued-research-checkpoint--2026-11-26)
records subsequent work during the user's absence; that checkpoint does not
terminate the ongoing M4 effort.

## Baseline and authorized endpoint

Started at `b7c3bca2af60c2ea8d2a8bf06c086709a79fd15f` on
`feature/attempt-09-b4`; created `feature/m4-universal-visitation` from that
checkout. The index was empty. Unrelated Obsidian workspace/hotkeys, notes and
papers are preserved. The invoked prompt authorizes all M4 research, necessary
formalization, reviews and local commits; it excludes M5 assembly, push and PR.

**M4 incomplete: the unconditional visitation theorem was not proved.**
The bounded stopping outcome is a reviewed obstruction, not milestone acceptance.
No production Lean, audit, pin, dependency, permission or tool configuration is
changed. The strongest new kernel result is a diagnostic counterexample to a
generic proposed mechanism, not a theorem about BBP visitation.

## Contracts and indexing

The [unchanged target and bounded sequence](proof-plan.md#m4-research-sequence--2026-11-26)
require all `0 ≤ a < b ≤ 1`, all natural `N`, and a visit of
`bbpRecurrence (n+1)` for some `n ≥ N`. Its initialization is zero. No
conditional, finite-search, density or normality assumption can discharge V.
The exact B2 bridge matches recurrence `n+1` with orbit `n`; the source's
one-based forcing `A(m-1)` instead represents `theta=pi/16`.

[The argument assessment](m4-visitation-obstruction.md) records the source
contracts, three avoidance candidates, two recovery candidates, exact models,
and first unsupported implications. The proof frontier for π remains B1–B3
and conditional B4/P3. Source theorem extraction and paper mathematics are
distinguished from local kernel checking.

## Acceptance evidence and limitations

This checklist tracks the authorized partial handoff; the first item blocks
M4 acceptance regardless of the documentation/review result.

- [ ] Unconditional V, export, axiom guard, boundary instantiations and its
  unconditional B4 consumer: unavailable because the central mathematics is open.
- [x] Baseline and final Lean `4.37.0-rc1`, `lake build` (7205 jobs),
  `lake env lean Test.lean`, and `git diff --check`: exit 0.
- [x] Source translation and exact countermodel probes: parent compilation
  exits 0; no warnings in final versions; only the three permitted axioms.
- [x] Offline process tests (38), documentation checker (68 tracked Markdown
  files), working/staged whitespace, and exact owned staging: exit 0 (initial
  ten-file review, eleven files after the minor entry-link improvement).
- [x] Carbon High criticism/full task-owned-diff review completed: no defects
  or open review questions; both nonblocking documentation improvements applied.
- [x] Local research commit and post-commit necessity inspection; no publication.

The source probe `/tmp/pi-m4-source-probe.lean`, SHA-256
`0e68e22a8857dbc1eec41618c03093ced766e5e3096770129a3137435e082c7e`, checks
`M4SourceProbe.coeff_rational_form`, `shifted_irrational`, and `orbit_index`.
The immutable model probe `/tmp/pi-m4-avoidance-probe-final.lean`, SHA-256
`1104b7bdde856a4fbfdf035d262dc7eb453e0dbcc41e1fbf51c8dc74bd74dc25`, checks
`M4AvoidanceProbe.initial`, `recurrence`, `avoids`, `forcing_pos`,
`t_tendsto`, `forcing_tendsto`, and `not_visitation`. The
[review report](agy-reports/m4-review.md#diagnostic-contract-inventory) retains
their exact definitions and principal signatures; the temporary packet retains
complete proof bodies. The model has forcing `16/(8*n+1)^2-1/(8*n+9)^2` and orbit
`1-1/(8*n+1)^2`; it permanently misses `(0,1/2)`.
Every printed axiom list is exactly `propext`, `Classical.choice`, `Quot.sound`.
These scratch probes are not production exports or additions to `Test.lean`.

One parent probe first used the wrong namespace `Real.irrational_pi`; pinned
source showed the root declaration `irrational_pi`, and the corrected probe
passed. One worker probe needed an explicit function shape under `Tendsto`.
Failed versions are discarded evidence, not proofs. Native search reported
an unavailable symbol index; source search and shell Lean supplied the fallback.
The adapted search/proof skills supported these checks. The argument/source
skills supplied same-session criticism, not independent certification.

[The Carbon report](agy-reports/m4-review.md) owns exact scope/hash, model,
conversation, guide coverage, captures/logs, findings and dispositions.
The single successful invocation took 831.263 seconds CLI runtime (856.972
seconds through the final caller capture); no retry or capture loss occurred.
The review reconstructed the mathematical arguments and inspected source/code;
kernel executions and external-source readings remained caller receipts.
Its two improvements retain exact diagnostic contracts/hashes and align the
second entry link. Neither changes a proof or mathematical claim. Final review
receipts and these minor documentation edits receive caller checks; no
substantive fix requires another Carbon invocation.
No substantial downstream proof block was implemented, so the full-diff
mathematical review also scrutinizes the central argument assessment.
Temporary `/tmp` probes/captures may disappear. Primary PDF text was read;
usable PDF screenshots were unavailable. No clean rebuild, remote CI,
exhaustive literature search or productivity comparison is claimed.

## Local commit and necessity inspection

Research commit: `7cc5bd38e45315348aa7580ee83f68011971f025`, local only on
`feature/m4-universal-visitation`. No push or PR was performed. This factual
handoff receipt is a separate documentation commit, identifiable with
`git log -1 --format=%H -- docs/m4-handoff.md`.

Inspected the committed eleven-file scope and matched every postimage to the
reviewed/checked working content. The assessment preserves failed arguments
and their precise separating examples; the plan owns the contract and bounds;
the blueprint owns dependency status; the log, retrospective, review and
handoff own their distinct evidence roles. Entry pages contain links, not a
second roadmap. No production helper, theorem wrapper, modular-sum machinery
or duplicate proof API was introduced. No justified substantive simplification
was found, so no proof follow-up or empty commit was made.

Final documentation (68 files), working/staged whitespace, exact owned scope,
and protected-source preservation checks passed. Archived prompts are unchanged.
The eleven unrelated files in the preservation snapshot remain unchanged;
the original Obsidian/notes/papers work stays unstaged. Final factual receipts
receive documentation and whitespace checks; unchanged Lean needs no further
build or substantive-fix review.

## Restart and remaining obligations

**First missing step:** exclude an infinite proper avoidance/limit set for
this particular rational-function BBP forcing, or prove its weak dichotomy.
The rational-or-dense dichotomy is not refuted by the rational countermodel;
the transcendental perturbation loses fixed rational-function forcing.
Maximal complexity and residue coverage restate the missing burden. The
Thue–Morse example prevents a generic rational-approximation argument.

B4 retains vanishing error and arbitrarily late visits; B3 supplies only the
former for `bbpTail`. P3 retains open-interval visits. V, Hπ, T and π
disjunctivity remain unproved. Source finite-limit arguments are not exported
as new Lean theorems, and no missing hypothesis is hidden in a wrapper.

Suspend the tested generic routes after bounded recovery. A useful restart
needs a concrete BBP-specific estimate or applicable theorem that survives
the recorded countermodels and changes the missing implication. No justified
such test emerged in this cycle; this is a limit of the attempt, not proof of
impossibility. The [retrospective](retrospectives/retrospective-2026-11-26-m4.md)
records the decision. No process-policy rewrite is warranted by these results.

Read the [current entry](proof-attempt-session-prompt.md),
[proof plan](proof-plan.md), [blueprint](proof-blueprint.md) and
[research log](research-log.md), then verify the actual checkout. The current
prompt remains M4 with this restart pointer; M5 has not begun.

## Persistence follow-up — 2026-11-26

The user reaffirmed continued M4 work and requested durable instructions against
premature stopping. The earlier decision to end after agent-selected cycle
bounds was not forced by permissions or an observed execution limit. It fell
short of that persistence instruction. The negative mathematical results stand;
they do not exhaust the authorized research.

The [current prompt](session-prompts.md#current-prompt-m4-universal-visitation)
and [persistence protocol](meta-proof-plan.md#persistence-and-stopping-conditions)
now require another bounded investigation or discovery cycle after an
unsuccessful route. A new estimate is something to seek, not a prerequisite
for resuming. At a real interruption, preserve the next investigable question
and actual stopping cause. M4 acceptance, theorem contracts, indices, trust
rules, tool retry limits and M5 exclusion are unchanged.

This process correction starts at `b20e1b34f08e73ce16389637ebcf52700b8f452a` on
`feature/m4-universal-visitation`, with unrelated Obsidian/notes/papers preserved.
The [process retrospective](retrospectives/retrospective-2026-11-26-m4-persistence.md)
records the lesson; the [review report](agy-reports/m4-persistence-review.md)
owns correction-scope validation and review receipts. No new V proof is claimed.

The correction is committed locally as
`dacbd3c0ce44313afe405d8efdccdcbbe6dfe2a9`; no push or PR was performed.
Post-commit necessity inspection found no unneeded proof/tool infrastructure or
substantive simplification. The report records complete subagent review, the
user-directed Carbon stop, checks and the separate factual receipt commit.
This checkpoint does not end M4 research.

## Continued research checkpoint — 2026-11-26

Baseline `050e025aa6d1b4f65fb268add815d388255abebc`; branch remains
`feature/m4-universal-visitation`. The user directed continued proof work while
away and replacement of Carbon with Codex reviewers. The process correction
was followed by further mathematical cycles, with failed approaches changed
at their checkpoints. This is a partial research checkpoint, not a stopping
decision or M4 acceptance.

The exact V statement, initialization and recurrence/orbit offset are unchanged.
B1–B3 and conditional B4/P3 remain the checked frontier. V and its unconditional
B4 consumer remain missing; Hπ, T and final-conjecture assembly are still open.
No production Lean, audit, dependency, pin, permission or tool configuration
changed. M5, push and PR remain outside the invoked scope.

New evidence is retained in three assessments:

- [Rational forcing](m4-rational-forcing.md): a stronger avoiding model defeats
  the proposed non-coboundary/simple-pole shortcut; null-series changes expose
  representation-dependent features. G-function source hypotheses and a
  separate repetition counterexample prevent an unsupported visitation inference.
- [Arithmetic windows](m4-fourier-windows.md): a concrete fixed-modulus theorem
  needs windows unavailable from the BBP freezing estimate. Every fixed rational
  tail correction retains a finite nonzero algebraic error; a source-dependent
  PNT argument gives exponential corrected odd denominators at every large anchor.
- [Auxiliary products](m4-auxiliary-products.md): a valid interval detector does
  not overcome the height cost of separate factors. Two-prefix resultants remove
  a scale but eliminate the pi-specific information as well.

The universal new claims in those notes are paper mathematics. The parent
inspected and reran their exact-rational checkers, all exit 0. The small pinned
Dirichlet specialization also compiled with only the three allowed axioms; it
does not formalize the PNT or denominator/asymptotic arguments. Baseline Lean
build and Test.lean audits passed on the unchanged production sources.
The [continuation review](agy-reports/m4-continuation-review.md) owns review
scope, dispositions, final documentation checks and the local checkpoint receipt.
Verify current Git state rather than treating this dated snapshot as live status.
Unrelated Obsidian configuration, notes and papers remain outside the work.

**Continuation question at this checkpoint:** investigate the generating
functions of the actual recurrence and integer carries. Derive their exact
identity, inspect a precise natural-boundary theorem, and test whether interval
avoidance adds any analytic restriction that rational BBP forcing can contradict.
Do not assume carries are ordinary digits, that a forbidden word makes a sequence
automatic, or that an analytic forcing makes the solution D-finite. The first
endpoint is the actual analytic consequence and a separating model or an exact
remaining bridge. This investigation is already authorized and underway;
the user need not supply a new estimate or renew permission. Consult the latest
research-log entry for subsequent findings before resuming.
