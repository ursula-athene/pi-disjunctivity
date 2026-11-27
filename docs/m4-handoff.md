# M4 universal visitation handoff — 2026-11-26

This records the initial attempt. Its stopping/restart proposals were superseded
by the [persistence follow-up](#persistence-follow-up--2026-11-26) below; its
mathematical results and validation receipts remain historical evidence.
The [continued research checkpoint](#continued-research-checkpoint--2026-11-26)
records subsequent work during the user's absence; that checkpoint does not
terminate the ongoing M4 effort.
The latest dated continuation is the
[Finite covering and a rational period functional](#finite-covering-and-a-rational-period-functional--2026-11-27-utc); read the
research log and actual checkout for subsequent results and current state.

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

Local research checkpoint: `052234d83834b898125f0a9f9223572975526576`, seven
documentation paths, with complete independent subagent review. The four
arithmetic checkers, scratch Dirichlet compilation, 38 offline tests, 74-file
documentation check and working/staged whitespace checks passed. Post-commit
necessity/scope inspection found no unneeded API or substantive simplification;
unrelated work remains preserved. The separate factual receipt is identified
in the review report. Nothing was pushed and no PR was opened. Research
continued immediately with the generating-function and carry-interface inquiry.

## Generating and phase checkpoint — 2026-11-26

After local receipt `7b73048`, the
[generating-function assessment](m4-generating-functions.md) records actual
carry/recurrence natural boundaries, a sharp generic phase-correction estimate,
and the failure of null-family horizon averaging to select a fixed visiting
orbit. A scratch Lean probe verifies the actual carry's finite alphabet and
weighted sum pi through the library root. The analytic and probability arguments
are paper mathematics; no new production export or V theorem exists.

The current investigations test the original four-pole rational nullspace and
a separate pi-specific arithmetic connection. Their bounds require reassessment,
not stopping. Consult the latest research-log entry and checkout for subsequent
results. Its separate independent subagent review completed with no findings;
the scratch compilation, exact checkers, 38 process tests, 75-file documentation
check and whitespace checks passed. The review report retains full scope and
evidence limitations. No Carbon, push or PR was performed.

## Arithmetic-cost checkpoint — 2026-11-26

From local baseline `9b6ca1b`, the
[logarithmic assessment](m4-logarithmic-constraints.md) determines the original
four-pole kernel and the full eight-pole kernel, showing uniqueness after
retaining O(n^-2) decay. Its first independent review found no defect; the
one source-notation clarification was applied. The
[approximation assessment](m4-approximation-interfaces.md) retains the precise
polynomial height/value costs, holonomy applicability failures, and the missing
independent radix action. The
[Fourier extension](m4-fourier-windows.md#growing-order-corrections-a-uniform-obstruction)
now handles every finite natural truncation order, even when growing with n:
its prime denominator product survives and its absolute real-shadowing window
is at most n+O(log n). No modular cancellation conclusion follows.

These universal results are paper mathematics with source dependencies and
exact arithmetic sanity checks; no new Lean export, axiom audit or V theorem
is claimed. Combined checkpoint review and its focused follow-up are complete;
all review recommendations are resolved. Documentation and whitespace checks
passed, alongside the 38 offline process tests. The review report owns their
receipts. Unrelated work is
preserved, and no Carbon, push or PR is authorized by this checkpoint.

The specified dihedral pullback test is complete: its mod-eight regrouping is
the earlier arctangent representation plus an endpoint correction, and its
primitive denominator retains an exponential odd cost. Continuation seeks a
pi-specific prefix coupling and an exact tail transform suggested by dyadic
coefficients; read subsequent research-log entries before repeating either.
The log states each finite endpoint. A failed test changes the next
inquiry; it does not end M4. The accepted frontier remains B1–B3 and conditional
B4/P3; V, Hpi, T and M5 assembly remain open under the unchanged contracts.

## Transform/period checkpoint — 2026-11-26

The arithmetic-cost checkpoint is committed locally as `b102ab3`; its exact
scope, validation, review and post-commit inspection are recorded in the
continuation review. No publication occurred. Subsequent work is in the
[transform/period assessment](m4-transforms-and-periods.md): exact tail
coefficients and poles, a separating avoiding model, a genuine Wallis
rational-period application with its short-prefix mismatch, and an elementary
full-three-phase countertest. The actual Wallis numerator is a power of two;
that global property plus its full local phase uniquely determines it. None
of these facts supplies the missing word-distribution estimate.

These new results are paper mathematics with parent-inspected exact checkers
and primary source pages. Initial independent review found one source-contract
endpoint defect, now repaired and cleared in focused follow-up. The fresh test of
reciprocal series is also complete: inversion retains an exponential odd denominator,
and its finer congruence controls a seed-period ending whose useful alignment
is unproved. Long's single-prime supercongruence applies, but its extracted
arithmetic alone fails the proposed period/initial-window consumer. The combined
prime-window test is also complete: its full precision plus known low bits
still admits all-five prefixes through the transfer ceiling. Current meta-plan
recovery seeks a positive lemma retaining exact dependence across approximation
anchors; consult the subsequent log before repeating a completed test. No production
Lean, axiom audit, dependency or pin changed. V/M4 remain incomplete, and this
internal checkpoint does not stop the authorized research.

## Positive-transform recovery — 2026-11-26

The transform/period checkpoint is committed locally as `5b431a3`; exact
four-path and protected-source post-commit checks passed. No push or PR.
Fresh-context recovery then produced the
[positive Catalan transform](m4-catalan-transforms.md), its exact block identity
and a rational enclosure consumer. The parent extended it to arbitrary order
and recognized the resulting family in Guillera's published WZ formulas.
Both the order-one and growing-order exact checkers passed.

The new uniform accuracy/height bound shows that growing cancellation order
still cannot transfer a complete-period occurrence guarantee through the
shared prefix. Its best exponential ratio matches the already assessed M=12
series. Independent review is complete with no mathematical defect; its one
navigation improvement was applied. No new Lean theorem or V is claimed.
Further acceleration alone is suspended as a mechanism. Continuation must
seek an estimate for actual modular positions or change the avoidance argument;
consult the latest research log rather than repeat the completed family test.

## Finite-data assessment — 2026-11-26

The positive-transform checkpoint is committed locally as `1bb8bff`, with
all four reviewed paths and unchanged protected sources verified after commit.
The later [rational-forcing additions](m4-rational-forcing.md) close the stated
G-function rescaling test and extend the fixed-multiplier separating bound.
A separate construction matches every prescribed finite BBP tail jet and the
actual first coefficient with a rational avoiding model. The latter loses
irrationality and the exact four-pole function; it does not refute V or weak
dichotomy. Parent exact checks passed and sketch review accepted the construction;
combined changed-file review is complete after a kernel-notation correction.
No new production Lean or V exists.

The active changed question asks whether an actual auxiliary integer residual
can use forbidden-word transitions, with coefficient height and analytic error
both accounted for. Read the subsequent log before repeating completed source,
period or tail-jet tests. This is ongoing discovery under the unchanged M4
acceptance boundary, with no Carbon, push or PR.

## Pade residual assessment — 2026-11-26

The finite-data checkpoint is committed locally as `1dba613`; its five-path
scope, empty index and unchanged protected sources were verified after commit.
The [Pade assessment](m4-pade-residues.md) now supplies an actual digit-sensitive
residual gain and quantifies why its chosen symmetric consumer fails. It also
proves the exact point-evaluation freedom and its height cost, keeping zero
interpolation residuals separate from valid nonzero witnesses. Parent exact
checks passed; independent changed-file review is complete, with its parameter
domain clarification applied. V remains open.

Evaluated cancellation and signed remainder dependence remain possible
questions, without an established estimate. A fresh-context recovery pass is
attempting a positive lemma using exact structure beyond the failed-route map;
its bound and precise output belong in the research log. Completing these
internal diagnostics does not end M4 or authorize M5 assembly.

## Signed-evaluation assessment — 2026-11-26

The Pade checkpoint is committed locally as `01ec415`; exact reviewed paths,
empty index and protected sources were verified after commit. The subsequent
[signed-evaluation assessment](m4-signed-evaluation.md) supplies a rigorous signed
interface, an exact rational derivative, primitive evaluation classification
and a height/denominator tradeoff. The original residue certificate remains
insufficient even with sign information when only the tail interval is used.
Parent exact checks passed; independent review is complete with no D/I/Q items. No Lean export,
unconditional visit or M4 acceptance exists.

The new inquiry uses backward 2-adic interpolation of the actual rational
coefficient. Its first paper invariant and an analytic avoiding-model test
are ongoing and outside this checkpoint's mathematical scope. The research log
owns their bounds and next questions. No Carbon, push or PR has occurred.

## 2-adic assessment — 2026-11-26

The signed-evaluation checkpoint is committed locally as `d53f350`; all five
reviewed paths, empty index and unchanged protected sources were verified.
The [new actual invariant](m4-two-adic-reflection.md) proves a zero reflected
anchor and exact residue permutations of rational BBP prefixes. The companion
[models](m4-two-adic-models.md) show why those properties alone still cannot
supply real interval visits, preserving the stronger analytic model's losses
of rational forcing, polynomial coefficient height and negative rational values.
Parent exact checks passed; independent changed-file review is complete after
restricting the binomial vanishing statement to nonnegative prior inputs.

The active question is a local/global character comparison using the actual
four-pole formula to control odd-denominator factors. Its estimate is not yet
available. V, Hpi, T and M4 remain open; no production Lean was changed and M5
is excluded. This checkpoint does not terminate the ongoing research.

## Forward-branch assessment — 2026-11-26

The initial 2-adic checkpoint is committed locally as `906eff1`, with exact
six-path scope, empty index and protected sources verified. The subsequent
extensions strengthen the countertest to all algebraic BBP tail terms and
derive exact local/global character factors. An actual negative-branch
calculation shows why a distribution transfer must use the forward direction.
The [model](m4-two-adic-models.md#one-analytic-model-matching-every-algebraic-bbp-tail-term)
and [character](m4-two-adic-reflection.md#7-exact-real-characters-and-the-missing-odd-correction)
extensions have successful parent exact checks; combined independent review
is complete with all three wording clarifications resolved. No production Lean
or unconditional V is added.

A fresh-context recovery is examining a finite-cylinder consumer using global
rational forcing and forward iteration. The completed diagnostics must not be
repeated as if they supplied that consumer. Research remains authorized and
ongoing, with V/Hpi/T/M4 open and no push, PR or M5 assembly.

## Forward arithmetic assessment — 2026-11-26

The previous extensions are committed locally as `823844e`, with exact reviewed
scope, empty index and protected sources verified after commit. The new
[joint polynomial note](m4-forward-polynomials.md) proves an arithmetic
restriction on nonconstant forward expressions and identifies the floor
inequalities as the information lost by polynomial carry equations. The
[prime-compression note](m4-prime-compression.md) proves the actual reduced
denominator asymptotic log q_n=6n+o(n) at paper level. Its primitive evaluation
corollary closes only the specified degree-two interval/modulus argument in
the stated height range, with nonconvex and joint information left open.

Parent exact runs, paper reconstruction and PNT source-page inspection passed;
combined independent review completed with the stale summary pointer corrected.
No production Lean, audit, pin or
dependency changed. The [review record](agy-reports/m4-continuation-review.md)
owns exact scope, hashes and dispositions. Unrelated Obsidian/notes/papers
remain preserved; no push or PR occurred.

The ongoing bounded inquiry tests whether two primitive signed residuals with
one shared omitted-digit tail provide a stronger joint constraint. It must
retain their correlations and coefficient costs. The research log owns the
bound and outcome. This is an internal checkpoint, not an interruption or
acceptance: the unconditional V theorem, Hpi, T and M4 remain open; M5 is excluded.

## Shared-tail assessment — 2026-11-26

The forward arithmetic checkpoint is committed locally as `1e079c1`; exact
six-path scope, empty index and unchanged protected sources were verified.
The [shared-tail note](m4-shared-residuals.md) proves the pair's common-factor
constraint and constructs a conditioned triple with primitive gcd one and
heights exp(2L+o(L)). This is a positive removal of the false-grid obstruction,
with actual numerator dependence and full prime-power precision retained.
It leaves uniform separation from the nonconvex forbidden tail unproved.

The [prime-compression extension](m4-prime-compression.md#the-actual-backward-branch-has-a-different-exponent)
shows that the concentrating negative branch has exponent 29/5 rather than 6,
caused by an exact cancellation strip. Scalar exponent 6 alone still admits
an analytic avoiding model; no distribution criterion follows from the exponent.
Parent exact runs and paper reconstruction passed; combined independent review
completed with no D/I/Q items. The existing review record owns exact scope and
evidence limits.

A fresh-context analytic sampling investigation is ongoing under the meta-plan;
its bound and actual output belong in the research log. The established failed
second-action and generating-function arguments must not be repeated unchanged.
No production Lean, audit, dependency, pin or trust change has occurred. V, Hpi,
T and M4 remain open, M5 is excluded, and no push or PR was made. This checkpoint
continues the authorized research rather than ending it.

## Sampling assessment — 2026-11-26

The shared-tail and negative-branch checkpoint is committed locally as
`bea51f5`; exact six-path scope, empty index and unchanged protected sources
were verified after commit. The subsequent
[sampling extension](m4-generating-functions.md#analytic-sampling-finite-differences-and-the-complementary-phase)
locates a strict interpolation-growth obstruction at the floor operation.
The exact Newton transform supplies no original-cylinder transfer, and prime
removal leaves the complementary expanding recurrence and its actual entry
phase intact. Parent reconstruction, exact checks and source-page inspection
passed; independent changed-file review completed with no D/I/Q items.

The entry countertest constructs a finite avoiding block preserving the actual
initial denominator and floor, complete prime component and high dyadic
precision. It changes the entry and loses global zero initialization, so it
does not refute V or describe the actual orbit. This follow-up is included in
the completed review. A separate bounded Mellin/Poisson connection tests
pi-specific real transforms and their phase dependence. The research log owns
the bound and outcome;
the review record owns scope, evidence and limitations. No production Lean,
audit, dependency or pin changed. V/Hpi/T/M4 remain open, M5 is excluded, and
all commits remain local with no push or PR. Research continues.

## Transform and conjugate-state assessment — 2026-11-26

The sampling/entry checkpoint is committed locally as `a155027`; its exact
five paths, empty index and unchanged protected sources were verified. The
separate [transform assessment](m4-transform-phases.md) identifies a concrete
finite-frequency bound sufficient for the exact V contract. The bound remains
unproved. Mellin reflection, with residues and boundary branches retained,
counts floor(pi*16^n) again. Gaussian inversion does not transfer full-lattice
cancellation to the selected powers of four, and its prefactor is offset by
the dual length. The follow-up tests finite Fourier extraction costs explicitly.

The [conjugate-state extension](m4-prime-compression.md#the-alternate-state-is-a-reflected-real-phase)
proves sum Ahat(n)/16^n=-pi and Shat_n=-S_n+U_n with
0<U_n<1/(16n+18). It retains exact local state swaps and endpoint corrections.
The two phases are asymptotically inverse; paired entry perturbations preserve
their null sum while losing individual global initialization. This closes a
candidate independence inference, not V. Parent reconstruction and both exact
checker replays passed; independent review completed after two domain repairs
and an endpoint clarification. The review record retains every disposition.

The fresh meta-plan pass tests whether a variable rational telescoper can
cancel selected anchor denominators at a useful real error and height cost,
while preserving the weighted constant and zero initialization. Its finite
bound and actual outcome belong in the log. This is a test, not an assumed
route to visits. No Lean, audits, dependencies, pins or trust assumptions changed.
V/Hpi/T/M4 remain open; M5 is excluded. No push or PR occurred. Work continues.

## Gauge and Gauss assessment — 2026-11-26

The transform/conjugate checkpoint is committed locally as `623d1bf`; exact
six-path scope, empty index and unchanged protected sources were verified.
The [rational correction assessment](m4-null-gauges.md) constructs arbitrary
finite rational blocks while preserving pi and zero initialization. It changes
the forcing and supplies no uniform real shadow. Even small circular shadowing
requires exponentially accurate approximation of the original initialized phase.
Root counting across consecutive states gives a degree/content tradeoff;
uniform fixed-scale prime survival strengthens the combined content-and-seed
cost to exponent 6 for sublinear denominator degree. Finite p=19 cancellation
shows why the eventual uniformity hypothesis matters.

The [Gauss extension](m4-transform-phases.md#absolute-gauss-completion-cannot-help-at-odd-squarefree-moduli)
proves that absolute completion costs at least the trivial bound for every
odd squarefree effective modulus, including aliased geometric masks. It
retains prime-power counterexamples, even-modulus exceptions and the weakening
of the irrationality-measure bound when block starts move. The
[antisymmetric extension](m4-prime-compression.md#the-antisymmetric-sign-does-not-determine-the-real-crt-phase)
identifies a pure arctangent kernel and its prime sign, while preserving the
full CRT phase and division-by-two ambiguity. Its same-kernel backward branch
still concentrates at zero; prime signs alone cannot give the needed estimate.

Parent reconstructions, all exact checker replays and source-page inspection
passed. The original evidence is retained with the integer-square-root and
degree-zero clarifications. Independent combined review completed with no
D/I/Q items. The next
bounded arithmetic test lifts compression to p^2 and asks whether the actual
regular cofactor shortens or keeps a full-length endpoint sum. A finite lift
at one prime would still not settle the real phase. The log owns its bound
and outcome. V/Hpi/T/M4 remain open, M5 is excluded, and no Lean, audit,
dependency, pin or trust change occurred. All commits are local; no push or PR.

## Prime-square assessment — 2026-11-26

The gauge/Gauss/antisymmetric checkpoint is committed locally as `804138d`;
exact seven-path scope, empty index and unchanged protected sources were
verified. The subsequent [prime-square calculation](m4-prime-square-lift.md)
has a positive complete-block result. Finite-log identities reduce regular
blocks to q_p(2); their correction cancels the lifted pole correction exactly.
For the four actual states c and p^2>8kp-1,
p*S^c_(kp-1)=16^(k(p-1))*S^(T_p c)_(k-1) modulo p^2.

Arbitrary endpoints retain an explicit incomplete-log term, which literally
contains the initialized prefix S_s when p>8s+7. Nonzero examples rule out
discarding it. The actual p=11 examples also rule out upgrading the same
formula uniformly to p^3. Fixed extra p-adic precision remains compatible
with the finite entry countertest; no real phase estimate follows. Parent
independent derivation, checker replays and evidence inspection passed;
changed-file review found no substantive defect. Its sole opening-domain
clarification was applied and verified in focused follow-up. The report is
preserved with precision and
partial-root-filter normalization addenda.

A fresh bounded source investigation tests whether pi's being the first
positive sine zero, with rational Taylor coefficients, gives a restriction
on missing-word approximation numerators beyond the rejected generic height
arguments. Its question is exact applicability and cost, not transcendence
alone. The log owns the bound and outcome. No new Lean or audit changed;
V/Hpi/T/M4 remain open, M5 is excluded, and no push or PR occurred.

## Initialized reconstruction and language tests — 2026-11-26

The prime-square checkpoint is committed locally as `ccb24d0`. Its five-path
scope, empty index and unchanged protected files were verified; the packet
retains the full review, resolved I1, final validation and post-commit receipt.
No push or PR occurred. The subsequent paper mathematics passed independent
changed-file review with no D/I/Q items; the record retains its exact scope
and evidence limits.

The [two-anchor reconstruction](m4-prime-square-lift.md#two-anchor-reconstruction-from-many-prime-endpoints)
is the strongest new arithmetic discriminator. For primes N<p<=6N, impose
the complete-block p^2 identity at p-1 on a candidate driven by the actual
forcing. Only 47/15 and -65/21 occur as anchors. With explicit clearing
integer L_N, P the selected prime product and G=gcd(P,L_N), the exact
difference lattice is (PG/L_N)Z. Its spacing is exp(3N+o(N)), eventually
larger than the natural height interval of width 4*16^N. Thus the finite
conditions uniquely recover S_N without knowing its floor or dyadic class.
The parent reconstructed the proof and replayed the full checker with a
byte-identical receipt; the asymptotic argument remains paper mathematics.

This defeats the previously free finite-entry perturbation after adding
many coupled identities. It does not prove visits. The actual null state D
has an analogous reconstruction while its real values tend to zero. The next
question is an A-specific bound locating the reconstructed state outside
each proper word-avoidance set; a fresh bounded consumer investigation is
deriving its exact CRT and Fourier/digit-cell interface.

The [language tests](m4-language-auxiliaries.md) found explicit limitations
for the sine-zero connection. Product smallness retains the node-polynomial
cost; positive transfer sums forget the selected path; signed and maximal
moment differences have exact but path-independent cancellation. A resolvent
detects membership but has uncancelled poles at every allowed prefix, and
cyclotomic deduplication retains large forced degree in the specified class.
Parent source-page inspection, checker replays and manifest checks passed.
None of these results excludes all possible auxiliary constructions.

No new Lean declaration or audit is included. V/Hpi/T/M4 remain open and
M5 is excluded. The log owns the current bounds and outcomes; this checkpoint
continues the authorized research and does not mark an interruption.

## Exact phase and unrestricted arithmetic checkpoint — 2026-11-26

The initialized-reconstruction/language checkpoint is local commit `2130035`.
Its packet retains the complete review, final validation and post-commit
inspection; exact scope, empty index and unchanged protected sources were
verified. No push or PR occurred. The next integration is documentation-only
paper mathematics and passed independent review with no D/I/Q items.

The [CRT consumer](m4-crt-phase.md) supplies an exact formula for actual
finite character sums. It retains the forcing tails, residual denominator,
height selection and canonical carry. The required signed estimate is still
unproved. Uniform residues conflict with the selected height interval, and
absolute completion loses the initialized class. A grid seed shadowing the
zero phase gives a precise obstruction for combined absolute certificates
on windows J<=(2/log16-eta)N; this says nothing negative about actual visits.

The [unrestricted lift](m4-prime-square-lift.md#unrestricted-differences-and-multiplicative-indices)
proves v_p(E_p^c(k))>=2 for all k>=1, p>=7 by cancelling differences before
reducing poles. It yields twisted Cauchy towers and a full four-corner
mixed-prime relation. The p=7 integrality restriction, essential middle terms,
raw precision limit and null-state discriminator are explicit. Stronger
k-dependent bounds have passed finite tests but remain conjectural.
The parent independently reconstructed both reports and replayed unchanged
checker copies with matching receipts, preserving all frozen originals.

Current continuation: test a proof/counterexample for the stronger precision,
and independently test whether mixed-prime relations constrain real word
avoidance after retaining every corner and height cost. Each cycle has a
20-minute reassessment bound. V/Hpi/T/M4 remain open, no Lean theorem or audit
has been added, and M5 remains excluded. A review or checkpoint commit does
not interrupt the ongoing authorized research.

## Boundary precision and positive certificates — 2026-11-27 UTC

The preceding exact-phase/unrestricted-lift checkpoint is local commit
`8a50efa27368f8052890b53fa7e06cc2b24716a5`. Its exact six-path scope, empty
index, protected-file preservation and necessity inspection were verified.
No push or PR occurred. The present work remains documentation-only paper
mathematics. Both the central-argument checkpoint and the complete seven-path
changed-file integration passed separate review with no D/I/Q items.

The [boundary calculation](m4-prime-defect-boundary.md) constructs the unique
continuous analytic solution Phi of the raw-defect recurrence. The actual
initialized defect is Phi(k)-16^(pk)*Phi(0), so the boundary constant cannot
be silently discarded. Newton generating functions and a source-mapped
Coleman comparison prove Phi_c(0)=0; a normalized dilogarithm reflection
identity also gives Phi_D'(0)=0. Consequently the valuations are at least
2+v_p(k) for A/Ahat/R and 3+2v_p(k) for D, for every p>=7 and k>=1.
The separate reviewer reconstructed the delicate one-annulus identity
principle and found no D/I/Q items. This is not a Lean certificate or V.

The [mixed-consumer assessment](m4-crt-phase.md#full-mixed-differences-retain-the-largest-denominator)
retains all corners and proves why the tested period-cancelling difference
does not become small enough for its divisibility to force zero. Its reduced
dyadic denominator is exact, and independent word-cell relaxation loses the
joint forcing. The [positive certificates](m4-positive-certificates.md) expose
two different costs: ordinary consecutive determinants fail a uniform-model
test for narrow gaps; the circle product passes that test but is unstable
under an exceptionally close pair. A scalar denominator cap and finite
character cancellation do not repair the latter. Actual reduced denominator
costs persist; the required canonical-gap numerator bound remains open.

Parent full-report/checker inspection, source-page reconstruction and
unchanged-copy replays passed; the detailed record retains their limits.
No actual A fractional-state search was used as evidence for universal claims.
The next two bounded questions are whether the stronger prime precision
constrains actual canonical gaps, and whether the nonsingular Bernoulli
circle energy gives a useful arithmetic sum. The log owns their outcomes.
V/Hpi/T/M4 remain open, B4/P3 retain their visit premises, and M5 is excluded.
Research continues; this checkpoint is not an interruption.

## Precision consumers and a bounded visit energy — 2026-11-27 UTC

The boundary/product checkpoint is local commit
`dd4476039dc0aa0677a5dae14d8bc3bce79b6e47`, with its seven paths and unchanged
protected/unrelated files verified after commit. No push or PR occurred.
The present documentation-only integration records five completed paper cycles.

The [precision consumers](m4-prime-defect-boundary.md#precision-consumers-retain-the-canonical-carry)
retain actual canonical floors. A shared-multiplier construction escapes one
height cost but fails the proposed valuation transfer on an infinite actual
subsequence. More odd congruences alone do not restrict the dyadic carry image.
The [bounded Bernoulli energy](m4-positive-certificates.md#a-bounded-energy-removes-the-close-pair-instability)
gives a sharp avoidance bound without a close-pair singularity. Its actual
sorted numerator lower bound remains missing. The
[short-sum source contracts](m4-transform-phases.md#short-sum-source-tests-retain-their-size-and-phase-hypotheses)
fail concrete size/phase hypotheses in their tested applications, and the
[polygon branch](m4-language-auxiliaries.md#an-isolated-algebraic-approximation-still-has-a-height-cost)
retains a decisive degree/height cost despite good root conditioning.

The parent reconstructed all five reports, inspected source pages and replayed
the four finite checkers in unchanged copies, preserving frozen originals.
The source-only packet requires no numerical check. Independent changed-file
review is complete with no D/I/Q items; requested supplemental source pages
confirmed the contract. Documentation and whitespace checks passed. The existing
review record owns exact scope and limitations. No finite check or subagent
agreement is a Lean proof. V/Hpi/T/M4 remain open; B4/P3 retain visitation premises.

Current work tests a real inequality using the positive BBP moment density,
and the additional height information supplied by its nonzero real period.
The log records the 20-minute reassessment bounds and countermodel obligations.
Further congruence stencils are suspended without a new real consumer. This
checkpoint does not end the authorized research; M5 remains excluded.

## Positive kernels and exact height distinctions — 2026-11-27 UTC

The consumer checkpoint is local commit
`c9f4fb7a310196a7f2dda949520883f86cf4a94f`. Its eight paths, empty index,
protected/unrelated preservation and necessity review were verified. No push
or PR occurred. The next integration is again paper mathematics only.

The [positive-filter assessment](m4-rational-forcing.md#positive-filters-and-uniformly-close-eight-pole-models)
retains every integer carry and identifies a sharp norm limit for the tested
range argument. Its uniformly close rational-period models preserve positive
moment signs but lose A's denominator growth. The
[actual null-state theorem](m4-prime-compression.md#the-actual-null-state-has-denominator-exponent-eight)
gives rate 8, and the
[shifted-pole classification](m4-logarithmic-constraints.md#rational-periods-in-every-fixed-finite-eighth-grid-pole-family)
proves rate 0 or 8 for rational periods throughout that fixed finite family.
This distinguishes A's rate 6 but does not exclude irrational avoiding orbits.
The [elliptic energy comparison](m4-positive-certificates.md#height-retains-a-local-selection-weight)
retains an essential field weight; a torsion example rejects deleting it.

The parent reconstructed all three reports/checkers/critic passes and relevant
source pages; unchanged-copy replays passed with originals preserved. Independent
integration review completed with no D/I/Q items; requested supplemental source
pages confirmed the contract. Documentation and whitespace checks passed. The
existing review record retains full scope and limitations. No Lean export or
audit is added; V/Hpi/T/M4 remain open and M5 is excluded.

Current investigation tests a precise fractal Fourier connection against the
exact forced multi-step evolution. It must preserve the selected initialized
state, rather than use a quantum/full-orbit result without a bridge. The log
owns the reassessment bound and outcomes. Generic positivity, unweighted height
averaging and further same-family rational-period classification are suspended.
This checkpoint does not interrupt the authorized research.

## Exact propagation and word-carry filters — 2026-11-27 UTC

The positivity/height checkpoint is local commit
`16f8735acd27bd0f0ebc774c0bdf012db4631536`. Its eight paths, empty index,
protected/unrelated preservation and necessity inspection were verified.
Nothing was pushed. The next integration contains two paper assessments.

The [exact hole operator](m4-crt-phase.md#exact-hole-propagation-is-not-a-quantum-fourier-operator)
has norm 1 whenever a seed survives, including with transition phases.
The tested quantum uncertainty theorem does not apply to its commuting
entry projections. A two-coordinate classical Cantor lift does not supply
the missing position/Fourier amplitude. The
[uniform polynomial test](m4-language-auxiliaries.md#uniform-carry-polynomials-retain-an-entire-avoiding-cantor-set)
contains exact-forcing avoiding Cantor seeds after relaxing initialization.
Its logarithmic integral gives a degree-independent exponential constant,
defeating the proposed rational-lattice certificate for every window. This
does not cover a domain restricted to the selected rational numerator.

Parent full reconstruction, source inspection and unchanged-copy replays
passed with originals preserved; the word-carry receipt differs only in UTC,
and the propagation receipt is identical. Independent integration review and
focused follow-up resolved two narrow defects and one nonblocking improvement;
the review record retains the full cycle and evidence limits. No new Lean
theorem/audit or V result exists.

The current question is rational-entry invariance of full late visitation and
whether it supports a valid new consumer. Its finite-versus-global quantifiers
must survive a rational-grid averaging countertest. The log owns the bound and
current outcome. V/Hpi/T/M4 remain open; B4/P3 retain visitation premises and
M5 remains excluded. Research continues beyond this internal checkpoint.

## Rational entries and fixed families — 2026-11-27 UTC

The preceding propagation/carry checkpoint is local commit
`c9a9c4646def554e5a5005534098fc496f6458dc`; its six paths, empty index,
protected/unrelated preservation and necessity inspection were verified.
No push or PR occurred. The new
[rational-entry argument](m4-generating-functions.md#rational-entries-preserve-universal-late-visitation)
shows that full late visitation under exact future A from any one fixed
rational entry is equivalent to V. One fixed finite family whose union has
that property also suffices. It does not transfer an individual interval visit.

Growing rational-grid averaging is suspended. Its quantifiers fail even when
one seed per target is chosen before every time threshold. Parent reconstruction
and an unchanged-copy replay passed; universal assertions remain paper proofs.
Independent integration review completed with no findings requiring changes;
the continuation review record retains exact scope and evidence limits.
No production Lean, dependency, audit or target contract changed.

Two bounded follow-ups test the usable arithmetic precision of changed entries
and the quantitative hole cost under rational translation. The log owns their
bounds, scratch paths and outcomes. V/Hpi/T/M4 remain open, B4/P3 retain their
visitation premises, and M5 is excluded. This checkpoint does not stop research.

## Entry precision and quantitative holes — 2026-11-27 UTC

The rational-entry equivalence is local commit
`358c9401e0e0a3d24050982613a92f9840bb904d`; exact five-path scope, empty
index, protected/unrelated preservation and necessity inspection passed.
Nothing was pushed. The next two paper assessments separate usable entry
freedom from changes of representation and target-dependent sampling.

The [precision test](m4-prime-defect-boundary.md#rational-entries-change-raw-precision-but-may-preserve-every-orbit-value)
retains every fixed-shift exception and shows that raw precision can change
while the canonical orbit remains identical. Finite repairs retain a coupled
height/denominator/matching-threshold cost. The
[hole test](m4-generating-functions.md#quantitative-hole-transport-and-varying-entry-times)
uses the actual rational-offset order and proves uniform derivative bounds,
but its variable-N visits do not supply a fixed-family consumer or control the
associated hole address. Both have explicit rational countertests.

Parent full reconstruction, immutable corrections and unchanged-copy replays
passed. Independent integration review and focused follow-up resolved one
production quantifier defect; the continuation review record owns the full
scope and dispositions. No Lean file, pin, dependency, audit
or V contract changed. A fresh-context quadrature investigation is testing an
exact-prefix visit consumer; the log owns its bound and outcome. V/Hpi/T/M4
remain open, B4/P3 retain visits as premises, and M5 remains excluded.

## Moment models and exact prefixes — 2026-11-27 UTC

The entry-cost checkpoint is local commit
`ae152090219c118fa8fe8a59813f64d43a1852a8`. Its six paths, empty index,
protected/unrelated preservation and necessity inspection were verified.
Nothing was pushed. New paper assessments are in the
[Gaussian prefix](m4-rational-forcing.md#gaussian-moment-models-match-an-exact-bbp-prefix)
and [analytic moment](m4-rational-forcing.md#analytic-moment-perturbations-can-have-an-irrational-nondense-period)
sections. The former supplies exact/controlled comparison windows but no hit;
the latter gives an irrational nondense period with the claimed analytic
properties while losing finite rational-function forcing and denominator control.
Neither is a counterexample to actual A or a proof of V.

Parent reconstruction, primary-source visual inspection and unchanged-copy
replays passed, with originals preserved. Independent integration review is
complete with no D/I/Q findings; the continuation review record owns the exact
scope, full-response receipt and evidence limits. No Lean, dependency, pin, audit or
target contract changed. The next bounded inquiry tests whether the latter
countermodel can retain a denominator upper rate arbitrarily close to 6,
explicitly distinguishing that from the exact A theorem and prime identities.
The log owns the bound and current result. V/Hpi/T/M4 remain open, B4/P3
retain visitation premises, and M5 remains excluded. Research continues.

## Arithmetic moment models — 2026-11-27 UTC

The Gaussian/analytic checkpoint is local commit
`9a4b896a96d8d00f5d8a7804d3a7479013ca2d48`, with exact scope, empty index,
preservation and necessity inspection complete. Nothing was pushed. The new
[moment-grid construction](m4-rational-forcing.md#exact-natural-denominators-still-allow-a-nondense-period)
retains exact natural denominators and a nondense irrational period. Its
[arithmetic extension](m4-prime-defect-boundary.md#moment-models-can-retain-the-pointwise-prime-defect-laws)
also retains the specified pointwise A/H/R laws and unchanged D, with both
denominator rates 6. It does not retain the exact rational forcing, actual
reduced denominator sequence, or the common p-adic analytic family.

The [full-family cost test](m4-prime-defect-boundary.md#full-analytic-constraints-exceed-the-uniform-moment-grid-budget)
identifies a stronger necessary Newton family that exceeds this uniform
construction's interval budget along primorial endpoints. That is not a
nonexistence or visitation theorem. Parent reconstruction and finite replays
passed; independent combined integration review is complete with no D/I/Q
findings. The continuation review record owns its exact scope, full response
and evidence limits. No Lean, pin, dependency, audit or target contract changed.

A fresh-context bounded inquiry now asks whether the full family and exact
finite rational forcing have an actual visitation consumer or a useful
neighboring-theorem bridge. The research log owns its bound and outcome.
V/Hpi/T/M4 remain open, B4/P3 retain visitation premises, and M5 is excluded.

## One-prime finite-family classification — 2026-11-27 UTC

The preceding arithmetic-model checkpoint is local commit
`868a092c7797065f90b5a73d5d0222d69d0f7a88`; its exact six-path scope, empty
index, preservation and necessity checks passed. Nothing was pushed. The new
[p=17 classification](m4-logarithmic-constraints.md#one-p-adic-continuous-defect-selects-the-normalized-eight-pole-forcing)
identifies A inside the fixed normalized eight-pole family but supplies no
distinct vector or logarithmic relation from actual word avoidance. It does
not classify infinite analytic moment models. Same-family classification and
formalization are suspended without a real-position consumer.

The parent inspected the original Brumer theorem image, reconstructed the
argument and replayed 825 exact checks with identical receipt and unchanged
originals. Independent integration review is complete with no defects or new
improvements; Q1–Q2 remain open and Q3 passed paper review. The continuation
review record owns its scope and limits. No Lean, pin, dependency, audit or target
contract changed. The next bounded inquiry tests an adelic rationality
criterion, beginning with a common function and its exact local hypotheses.
The log owns that investigation. V/Hpi/T/M4 remain open, B4/P3 retain visits,
and M5 is excluded; research continues.

## Analytic classes and global period covering — 2026-11-27 UTC

The fixed-family checkpoint is local commit
`9a9a0403686f235a1c862cd4743a61b12835e3e4`; its exact five-path scope, empty
index, preservation and necessity checks passed. Nothing was pushed. The new
[Dwork source test](m4-generating-functions.md#a-rationality-criterion-needs-the-same-canonical-carry-series)
isolates a missing continuation theorem for the same canonical carry series.
Its integrality is available, but neither word avoidance alone nor the
prime-dependent defect interpolants supplies that continuation.

The [fixed-prime model](m4-prime-defect-boundary.md#fixed-prime-analytic-classes-still-admit-nondense-moment-models)
retains selected Taylor valuation classes under an explicit budget inequality,
including {13,17}, and all the preceding pointwise/denominator properties,
while retaining a nondense irrational period. It changes exact forcing and
Taylor coefficients. The [global lattice](m4-prime-defect-boundary.md#the-global-analytic-lattice-has-volume-but-no-proved-period-covering)
has positive averaged volume, but a separate toy proves why that is insufficient
for a prescribed period or infinite nonzero continuation. The actual projected
covering question remains open.

Parent reconstruction, Dwork primary-page inspection and unchanged-copy
replays passed. Independent integration review found no defects or new
improvements; Q1–Q3 remain the disclosed continuation, covering and sieve
obligations. The continuation review record owns exact scope and limits. No Lean, pin,
dependency, audit or target contract changed. Two bounded follow-ups test the
actual lattice projection and a canonical-carry restriction from avoidance;
the log owns their bounds and outcomes. V/Hpi/T/M4 remain open, B4/P3 retain
visitation premises, and M5 is excluded. Research continues.

## Borrow transitions and actual lattice duals — 2026-11-27 UTC

The preceding analytic-class checkpoint is local commit
`088fa55b625b2c58d3bc5b8bd3017a359601e19e`; exact six-path scope, empty
index, preservation and necessity checks passed. Nothing was pushed.
The [actual dual estimates](m4-prime-defect-boundary.md#two-actual-lattice-duals-fail-even-after-period-alignment)
fail even with optimized period alignment. Only those two certificate families
are suspended; full bounded covering remains open.

The [borrow calculation](m4-generating-functions.md#canonical-borrow-transitions-are-sparse-but-whole-corrections-need-not-be)
retains actual indexing and floors, proves sparse carry-16 transitions, and
transfers omitted carry words using a nonzero sentinel. A changed-phase example
shows why whole corrections need not be sparse. The nonlinear word relation
uses Hadamard multiplication and has no proved analytic consumer.

Parent reconstruction and unchanged-copy replays passed. Independent
integration review found no defects or new improvements; the word-indicator
and full-lattice questions remain open. The continuation review record owns
exact scope and limitations. No Lean, dependency, pin, audit or target
contract changed. A bounded two-series inquiry tests a distinct exact
arctangent coupling; the log owns its bound and outcome. V/Hpi/T/M4 remain
open, B4/P3 retain visitation premises, and M5 is excluded. Research continues.

## Growing stencils and native carries — 2026-11-27 UTC

The borrow/dual checkpoint is local commit
`f7a2d22080a80f5dbd08068cc119079924005257`; exact six-path scope, empty
index, preservation and necessity checks passed. Nothing was pushed. The
[uniform stencil result](m4-prime-defect-boundary.md#growing-binomial-stencils-cannot-overcome-the-clearing-cost)
includes growing order and actual integer content. The
[single-prefix content result](m4-prime-defect-boundary.md#single-prefix-content-remains-subexponential-on-the-full-finite-lattice)
handles zero order separately. Both reject the specified full-box certificate,
while general row combinations and actual bounded feasibility remain open.

The [arctangent split](m4-approximation-interfaces.md#two-arctangent-series-retain-an-integer-carry-obstruction)
retains canonical native integer carries and shows why fractional marginal
information is insufficient. Its additive countertest loses the actual
arctangent formulas. None of these results supplies a visitation argument.

Parent reconstruction and unchanged-copy replays passed. Independent
integration review found no unresolved defects or required improvements,
including in the zero-order norm interface; Q1–Q2 retain bounded feasibility
and actual joint-carry estimates. The continuation review record owns scope
and limits. A proposed content lower bound was withdrawn
with an exact counterexample; only the upper theorem is retained. No Lean,
dependency, pin, audit or target contract changed. A fresh-context bounded
pass seeks an actual positive V consumer; the log owns its bound and outcome.
V/Hpi/T/M4 remain open, B4/P3 retain visits, and M5 is excluded. Research continues.

## Carry density and source bridges — 2026-11-27 UTC

The preceding checkpoint is local commit
`062667e49a715e9c3e89d42b3d7857fa62ec4698`; nothing was pushed.
The fresh-context positive-consumer pass supplied no positive argument.
An inspected logarithmic determinant needs exceptional rational approximations;
word omission supplies no replacement. The source's claimed irrationality
exponent theorem is not adopted or refuted by this application check.

The [borrow assessment](m4-generating-functions.md#canonical-borrow-transitions-are-sparse-but-whole-corrections-need-not-be)
now gives a badly approximable comparison phase with density-one corrections,
retaining exact BBP forcing but changing initialization. This rules out a
specific attempted repair, not actual visitation. Its source and all-prefix
estimate are paper mathematics; no Lean declarations changed. Independent
integration review found no defects or required improvements; Q1--Q2 retain
the actual initialization and missing determinant input. Scope and evidence
limits belong to the continuation review record.

A new bounded pass examines exact rationality of the initialized prefixes and
their particular rational-coefficient recurrence. It must produce a genuinely
different implication or an informative applicability check, rather than
rename Hypothesis A. V/Hpi/T/M4 remain open; B4/P3 retain visits and M5 remains
excluded. Research continues under the existing authorization.

## Sparse block identities and global constraints — 2026-11-27 UTC

The reviewed carry/source checkpoint is local commit
`0c666a0c335d84c25895c7565ea42dd6e4de7be4`; nothing was pushed. The
rational-prefix inquiry found no new restriction on the actual carry defect.
A determinant variation duplicated the existing positive-certificate analysis
and was dropped. Neither is new progress toward V.

The [research log](research-log.md) records a targeted source screen and a
reciprocal-Fermat comparison. That source constructs individual word locations
from controlled integer residues at sparse divisibility times. A coefficientwise
BBP transplant into one fixed coefficient lattice is impossible; a different
identity at the actual value is not excluded. No such identity was obtained.
Independent integration review found no mathematical defects, with one
navigation correction implemented and the missing actual-pi identity retained
as open. There are no new Lean declarations or discharged visitation hypotheses.

A bounded inquiry now tests general combinations of the all-prime Newton
constraints, beyond the failed prefix/binomial families. It must address
actual period covering or a period-aligned dual; volume surplus alone does
not do so. The log owns the effort bound and evidence. V/Hpi/T/M4 remain open,
B4/P3 retain visits, M5 remains excluded, and authorized research continues.

## Finite covering and a rational period functional — 2026-11-27 UTC

The preceding checkpoint is local commit
`b114f4bd2fd46cecf8bf26bdb81d7d0015c8c44f`; nothing was pushed. The
[finite certificate](m4-prime-defect-boundary.md#a-finite-bounded-covering-certificate)
gives bounded perturbation-lattice vectors for an entire positive target
interval at K=31,N=50,B=1/4096. Independent reconstruction and the parent's
output-path-only replay passed 2,680 exact checks with identical artifacts.
Approximate basis search was used only to propose an exactly checked integer
transformation. This is paper mathematics with exact finite evidence, not Lean.

The [general consumer](m4-prime-defect-boundary.md#a-single-rational-functional-suffices-for-future-covering-certificates)
uses one rational functional and preserves a fixed positive target interval.
It retains the unproved basis-width hypotheses at arbitrarily large cutoffs.
The next bounded inquiry tests controlled duals/witnesses at many-prime stages;
no larger finite basis campaign is planned. The review record owns integration
status and all findings. There is no infinite all-prime model or actual
visitation result. V/Hpi/T/M4 remain open, B4/P3 retain visits and M5 is excluded.
This checkpoint does not end the authorized research.
