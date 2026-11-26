# B3 retrospective — 2026-11-25

Expanded after acceptance at the user's request. The [handoff](../b3-handoff.md)
owns contracts, validation and publication; the
[review report](../agy-reports/b3-review.md) owns review evidence and dispositions.
Recommendations below are proposals, not changes to the workflow or permission
to begin another milestone.

## What went well

- **The mathematical contract stayed fixed.** We proved both exact requested
  bounds and signed tail convergence for every natural index, including zero.
  No analytic, summability or visitation assumption was added. The preliminary
  criticism correctly identified positivity, indexing and geometric summation
  as obligations; no missing mathematics emerged during formalization.

- **B2 provided the right interface.** Reusing `hasSum_bbpTail` retained genuine
  convergence. Mathlib's `HasSum.norm_le_of_bounded` handled the comparison
  directly, and a reciprocal limit plus squeeze proved decay. The resulting
  86-line module exports exactly the three requested theorems; the majorant and
  term comparison remain local facts. Existing proofs were untouched.

- **Early interface checks paid off.** We checked the coefficient through the
  library root before composing the tail proof, then checked the tail before
  integrating decay. Full types, actual axiom guards and theorem-instantiating
  zero/one cases passed. The final build and audits had no warnings.

- **Review improved the tests.** Carbon found no defects, but suggested two
  concrete improvements: `|Real.pi - 47/15| ≤ 8/135`, which tests the BBP chain
  without project-defined symbols in the statement, and a B4 probe checking
  recurrence index `n+1` against orbit index `n`. Both were implemented and
  rechecked. The latter retains the complete late-visitation hypothesis.

- **Delegation and tools were useful within clear limits.** Two isolated
  workers returned compiled coefficient and tail/limit candidates. The parent
  integrated and checked them. Native search, hover, goals and diagnostics
  supplied useful evidence; pinned-source search and shell compilation covered
  gaps. The adapted skills encouraged explicit statements and small proofs.
  No installation, dependency or configuration change was needed.

- **Acceptance stayed disciplined.** Build, trust audits, 38 process tests,
  documentation and whitespace checks passed. Both review captures were complete.
  Only owned files were committed; both commits were pushed and verified. The
  necessity review found no justified substantive simplification. Unrelated
  work was preserved, including an Obsidian file that changed during the task.

## What was difficult or inefficient

- **The process was substantial relative to the proof.** The intermediate
  review took 8m43s and the full review 4m48s: about 13m31s of CLI runtime within
  the reported approximately 29-minute milestone. These are not an exclusive
  breakdown of working time: documentation work overlapped review waits, and
  proof time was not measured separately. Required assurance was useful, but
  repeated scope inventories and status prose added overhead.

- **My initial reads were too broad.** Several large batches of repository and
  tool documentation were truncated, requiring narrower rereads. That consumed
  context and delayed focused work. Delegation helped with proof details, but
  did not by itself keep the supervisor's context small.

- **Native tool behavior was uneven.** Search indexes were unavailable or
  warming. A norm-bound declaration lookup failed; a worker's lookup returned
  unrelated source. Diagnostics rejected `/tmp` probes without a Lean-project
  ancestor. Hover, direct source inspection and `lake env lean` resolved these
  issues, but the fallback should have been chosen earlier where predictable.

- **A worker handoff raced with integration.** The parent read a scratch file
  while the worker was renaming its theorem. The extraction script failed before
  changing production. This was a coordination error, not a mathematical one.
  Other repairs involved inequality orientation, explicit type arguments,
  cast/rational normalization and redundant tactic sequencing.

- **Progress updates were useful but not dependable heartbeats.** Carbon emitted
  inspection updates, yet analysis steps lasted about 187 and 134 seconds
  without the requested 45–60-second updates. Silence therefore remained
  ambiguous. Polling the same live handle and checking subsequent events avoided
  an unnecessary restart; some early polls were more frequent than useful.

- **Review persistence failed.** The CLI completed both reviews, but local
  conversation/summary persistence encountered sandbox restrictions. The final
  invocation could not restore its predecessor and used fully resupplied
  context. Captures preserved the evidence, but temporary files are not durable
  archives. No permissions were broadened to hide this limitation.

## What we can improve

1. **Read by dependency and question.** Locate relevant headings first, read
   bounded sections, and retrieve only the tool signature needed next. Keep a
   compact acceptance checklist and pointers to existing evidence. Read required
   review guides in full, but avoid repeated undirected context dumps.

2. **Make worker delivery explicit.** Ask for a final immutable scratch path,
   theorem name, exact verification command/result and a clear completion signal.
   Integrate only after that signal. Keep ownership of production edits with
   the parent; no additional orchestration framework is needed.

3. **Choose the proof-feedback route up front.** Use native goals and diagnostics
   for project files, and shell Lean for `/tmp` probes. Corroborate suspicious
   declaration results with hover and pinned source. Treat warming or empty
   searches as limited evidence, never proof of theorem nonexistence.

4. **Keep required reviews focused.** Retain the mandated intermediate and full
   reviews. Give each a precise question, exact diff, relevant signatures and
   concise caller receipts. Request a short verdict, D/I/Q categories and only
   material evidence; avoid repeating whole file inventories. The shorter final
   response still covered both improvements, but this is not a measured speedup
   because the review scopes differed.

5. **Monitor observable progress consistently.** Request updates at inspection
   boundaries and before long analysis. Poll live sessions at roughly 30–60
   seconds, retain timestamps and distinguish silence from termination. Follow
   the existing deadline/recovery procedure. A prompt cannot guarantee a
   heartbeat; never restart merely because an update is late.

6. **Reuse the two stronger audit patterns.** Where relevant, add a result stated
   in established mathematical objects and a downstream interface check that
   fails on an index mismatch. Keep every unproved premise explicit. These tests
   protect meaning beyond checking that a theorem name has the expected type.

7. **Reduce repeated status prose.** Let the plan own contracts, the blueprint
   own dependencies, the report own findings and the handoff own acceptance.
   Keep the prompt-required `PROGRESS.md` as a short pointer. Preserve concise
   durable review summaries while recording the limits of temporary raw evidence.

## General comments

B3 was a successful formalization of an established argument. The main lesson
is that exact interfaces, mathematical criticism and kernel checks worked
well together; avoidable friction was mostly in context handling, coordination
and reporting. The native tools and skills were useful in specific cases, but
this single milestone does not establish general productivity gains.

The reviews justified their presence through stronger audits, even without
finding a defect. Conversely, a clean review does not measure reviewer
sensitivity or certify progress on the open conjecture. Keep the assurance
requirements and make their execution more economical.

B3 supplies vanishing error, not visits. V, Hπ, T and π disjunctivity remain
open. B4 still requires arbitrarily late visits, and P3 requires open-interval
visitation. Any separately authorized next research cycle should start by
examining a candidate mathematical argument and its failure modes before
investing heavily in Lean. This retrospective starts no such cycle.
