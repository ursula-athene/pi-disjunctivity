# Meta-plan for improving the proving process

The [proof plan](proof-plan.md) says what mathematics is needed. This document
says how we evaluate that route and improve the process used to pursue it.
The [workflow](proof-workflow.md) owns execution; the
[blueprint](proof-blueprint.md) owns dependencies and unresolved hypotheses.
Keep observations in the [research log](research-log.md), retrospectives and
linked handoffs, rather than accumulating execution history here.

Next session: <!-- current-prompt --> [Current prompt](session-prompts.md#current-prompt-m4-universal-visitation).
A proposed next task becomes work only when authorized.

## Review the plan at each bounded endpoint

1. **Choose the uncertainty that matters.** Work backward from the target and
   name the first unsupported implication on the proposed route. Identify what
   the next task's result would enable. Separate missing mathematics from
   library, elaboration and environment problems. More checked infrastructure
   is useful only when its intended consumer is clear.
2. **Set a discriminating endpoint.** Before a cycle, state the exact claim,
   hypotheses, evidence sought, effort limit or stopping condition, and how
   success, failure or an inconclusive result would change the next decision.
   Test the central mathematical argument before extensive formalization.
   Use a small interface probe when the uncertainty is whether results compose.
3. **Monitor the actual obstacle.** During work, classify failures and record
   evidence that changes the assessment. If retries yield no new information,
   apply the [stuckness checkpoint](#recognizing-stuckness) and identify the
   obstruction. Keep compiler repairs separate from discoveries; a failed
   search is not a counterexample.
4. **Evaluate at checkpoints and completion.** Compare the result with the
   endpoint, including unsuccessful attempts and review findings. Ask whether
   the proof frontier moved, the next step became feasible, or a route was
   ruled out. Review the plan immediately if an assumption, dependency or
   theorem interface changes; otherwise use existing milestone checkpoints.
5. **Revise once, in the owning record.** Keep, narrow, reorder, replace or
   suspend the proposed route according to the evidence. Update mathematical
   contracts in the proof plan and dependencies in the blueprint; update
   execution rules in the workflow. Record the reason and next bounded test
   in the handoff/log. Preserve checked results and unresolved hypotheses.
   Changes beyond the authorized scope, including user-owned policy choices,
   require a user decision.

## Signals and decisions

| Observation | Decision it should inform |
| --- | --- |
| A checked result applies downstream and discharges or strictly weakens an open obligation | Continue the formalization route within scope. A new wrapper around an unproved premise is not movement of the proof frontier. |
| A candidate's central implication lacks an argument, has a counterexample, or merely restates the target | Revise or suspend that route; record the exact gap before further infrastructure work. |
| An effort bound is reached without a decisive result | Use the recovery protocol below to narrow the question or change approach; suspend unproductive infrastructure work. Inconclusive does not mean false. |
| Repeated library search, interface repair or feedback delays dominate a concrete obligation | Trial one small process/tool change against the working fallback. |
| Review finds a semantic or trust defect | Repair and recheck before acceptance; add a targeted guard when it would catch recurrence. |
| Documentation disagrees with declarations despite passing link checks | Reconcile the owning records and their active summaries manually. |
| Reviews or reporting repeat evidence without changing decisions | Shorten packets and summaries while preserving required scope, guides, checks and dispositions. |

For the current BBP route, the decisive uncertainty is
[universal visitation](proof-plan.md#5-prove-the-missing-universal-visitation-theorem).
B3 supplies vanishing error, not visits. B4 still needs arbitrarily late visits;
P3 still needs open-interval visits. V, Hπ, T and π disjunctivity remain open.
A future authorized research cycle should challenge a candidate implication
before investing in substantial Lean infrastructure. This document supplies
no new visitation argument and starts no such cycle.

## When mathematical progress stalls

### Recognizing stuckness

**Stuck:** We cannot identify a justified next step, and bounded exploration is
no longer changing our understanding of the mathematical obstruction.

Use these observable signs as heuristics, not a fixed failure quota:

- Different attempts repeatedly reach the same unproved implication.
- Changes are mostly notation, tactics or reformulation, without a new
  mathematical mechanism or insight into why the method fails.
- We cannot explain what the next experiment would distinguish or teach us.
- The agreed effort bound expires without a useful lemma, counterexample,
  source connection or sharper obstruction.

**Slow progress is not necessarily stuckness.** Eliminating a plausible
approach, exposing an essential hypothesis or explaining a failure can be
valuable progress even when no theorem has been proved. A failed library search
alone does not establish a mathematical gap; library, compiler and environment
obstacles use the workflow's corresponding repair loop.

**Checkpoint rule:** At each research checkpoint, and sooner when repeated
failures suggest a stall, state with evidence: **What did we learn? What changed?
What could the next attempt resolve?** Compare with the preceding attempts.
If the answers remain unchanged and no justified next step emerges, record
mathematical stuckness and activate the recovery protocol below. Reaching the
effort bound requires reassessment; it does not authorize extending the bound.
A bounded failure records the limits of the present attempt; it does not
establish impossibility.

The parent and any delegated agents use this same rule. Carry the latest
checkpoint answers, failed approaches and exact obstruction into handoffs, so
a fresh agent can recognize the stall without repeating it. Keep this evidence
in the existing research log/handoff rather than a separate status ledger.

### Recovery protocol

These are discovery heuristics, not a recipe guaranteeing a breakthrough.

1. **Expose the obstruction.** In the existing research log, state the smallest
   missing lemma, its consumer, established facts, and failed approaches with
   reasons. Identify which special property of π or the BBP coefficients the
   argument must use. Check whether the desired lemma is stronger than necessary.
2. **Change the question or representation.** Allow a short exploratory pass
   before choosing a test. Use a relevant technique below, not the whole menu
   every time. Keep conjectures and informal calculations explicitly speculative
   in Markdown; proof shortcuts remain prohibited even in scratch Lean.

   | Technique | Useful output |
   | --- | --- |
   | Specialize, simplify, or build a toy model | A case retaining the obstruction, plus a list of discarded assumptions and the bridge back to the original problem. |
   | Generalize or change representation | A formulation exposing structure: for example arithmetic, symbolic sequences or dynamics. Prove the translation or record it as another obligation. |
   | Work backward; argue from failure | A sufficient intermediate lemma, or consequences of permanent interval avoidance that could contradict a known property. |
   | Seek counterexamples and boundary cases | A rejected candidate or an essential hypothesis. Test whether the proposed method would also wrongly prove visits for a known nondense model. |
   | Compare with a solved neighbouring problem | The mechanism that makes its proof work, and the exact point where transfer fails here. |
   | TRIZ: expose conflicting requirements | A proposed transformation that removes a method's tradeoff, followed by an exact claim and test; see below. |

3. **Seek a precise connection.** Search by the obstruction's structure as well
   as by conjecture name. Map objects and hypotheses to a candidate source
   theorem; record the missing bridge and simplest applicability check. A list
   of promising fields is not a connection. Almost-everywhere or random-model
   results still need a justified passage to this particular π orbit.
4. **Discriminate between ideas.** For materially different candidates, choose
   a small check that could refute a step or expose why one method applies.
   Set its effort bound and expected interpretations first. Use exact or
   certified computations for claimed counterexamples; numerical patterns only
   suggest conjectures. Finite experiments cannot establish universal visits.
   Conditional/interface probes may diagnose a route but do not discharge it.
5. **Reset and criticize.** Reconstruct the best candidate from the obstruction
   note, then challenge it separately. A later fresh context may reveal fixation;
   it must receive the failed approaches so it does not repeat them. If outside
   expertise would help, prepare a precise question and minimal example for the
   user; contacting people or launching extra agents needs authorization.
6. **Keep learning or change course.** At the bound, retain a checked lemma,
   counterexample, precise source bridge, or sharper obstruction. Otherwise
   suspend the approach and state what new evidence would justify reopening it.
   Switch to another useful authorized subproblem or hand back a bounded next
   proposal. Do not manufacture activity or silently weaken the target.

The model/counterexample approach follows [Tao's research advice](https://terrytao.wordpress.com/career-advice/be-sceptical-of-your-own-work/)
and [controlled extensions of known methods](https://terrytao.wordpress.com/career-advice/continually-aim-just-beyond-your-current-range/).
Comparing alternatives adapts [Platt's strong inference](https://worthylab.org/wp-content/uploads/2019/05/platt1964.pdf)
to mathematical exploration, where experimental support never replaces proof.
These are methodological recommendations, not measured gains for this agent.
[Human incubation studies](https://pubmed.ncbi.nlm.nih.gov/19210055/) report
task-dependent benefits; they do not establish that waiting improves an AI's
reasoning. Here a reset means a deliberate change of task/context, not idle time.

### TRIZ for generating and improving approaches

[TRIZ](https://aitriz.org/pages/triz), the Theory of Inventive Problem Solving,
offers contradiction analysis, an ideal final result, resource analysis and
inventive/separation principles. Its [Body of Knowledge](https://aitriz.org/documents/articles/TRIZ_Body_of_Knowledge.pdf)
primarily addresses technological systems; the following is our mathematical
adaptation, not a validated theorem-discovery algorithm or full ARIZ procedure.

- State the method's tension: improving one requirement obstructs another.
  For example, a useful bound might need to be both easy to prove and sharp
  enough downstream. This is a design conflict, not an assumed logical contradiction.
- Describe the ideal result under the unchanged theorem contract and inventory
  available resources: checked lemmas, hypotheses, structure and representations.
- Try a few relevant transformations: separate cases/scales, invert the approach,
  introduce an intermediate object, or remove an unnecessary component. Explain
  how each addresses the tension. Do not force mathematics into the engineering
  contradiction matrix or treat a principle's name as an argument.
- Convert the promising idea into an explicit lemma or process change, with
  preserved assumptions and the smallest discriminating check. Retain it only
  for concrete progress or informative failure under the cycle's effort bound.

When research and delegation are authorized, distinct subagents can formulate
the tension/resources and propose alternative transformations or connections.
Carbon can independently criticize the resulting candidates under the
[review procedure](gemini-review.md); the caller runs any proposed checks.
Give each the exact contract and failed attempts, use bounded roles and explicit
handoffs. Ideation workers return an exact candidate, the special structure it
uses, a nondense-model/counterexample check, and its first unproved bridge;
unknowns remain explicit. The parent filters these before sending a focused
candidate to Carbon, using both guides for a mathematical argument as required
by the procedure. The parent integrates checked results; agent agreement is
not proof. This strategy does not launch a research or agent campaign.

## Lightweight evaluation

Use the existing handoff and review report, not a separate metrics ledger.
Record the result, exact remaining obstruction and evidence that affected a
decision. Include observed interface/semantic failures, compiler repairs
separately from mathematical gaps, review attempts and elapsed time, capture
limits, and stale-status incidents. Use “not measured” when appropriate.
Separate proof and review/finalization time only when timestamps support it;
overlapping work and cumulative model usage are not elapsed-time breakdowns.

Evaluate a proposed tool or skill on a real obligation, with the same revision,
acceptance criteria and comparable budget as the existing method. State the
adoption criterion, setup/maintenance cost, fallback and rollback before the
trial. Check its result at the intended call site and include a failure case.
Prefer fresh cases when feasible; known replays establish functionality with
learning/cache effects, not general productivity. Distinguish installed,
configured, protocol-tested and tested in the actual host.

After a trial, adopt, revise, defer with a trigger, or drop it. Successful
installation or a larger candidate list is insufficient. Keep optional tooling
only where observed benefit justifies its cost. No tooling change supplies
missing mathematics or relaxes the dependency/trust policy.

The two-milestone observation requested by
[Carbon Q2](agy-reports/carbon-review-improvements-review.md#items-and-dispositions)
is now available in the [B2 evaluation review](agy-reports/b2-improvements-review.md#cost-and-usefulness-observations)
and [B3 review](agy-reports/b3-review.md). They support focused reporting:
B3's reviews produced two useful audit improvements, while repeated inventories
added bulk. Retain required reviews and concise D/I/Q dispositions. Different
scopes prevent a causal speed or detection-rate claim. Continue ordinary review
receipts; no additional benchmark reviews or permanent reporting trial is needed.
Use the [compact receipt](gemini-review.md#evidence-utilities-and-retention);
raw telemetry is captured and inspected without routine Markdown transcription.

## Maintained decisions and evidence

The [B3 adoption handoff](b3-process-improvements-handoff.md) maps retrospective
lessons to the workflow and review procedure. The [tool evaluation](b2-tool-evaluation.md#persistent-installation-and-native-host-follow-up)
owns actual capabilities and remaining limits; the [workflow](proof-workflow.md#source-adaptations)
records source adaptations. Evaluate benefits on subsequent work, without
repeating completed pilots or obsolete installation proposals.

<!-- Preserve historical incoming anchors without restoring old execution plans. -->
<a id="b1-completion-and-next-bounded-task"></a>
<a id="b1-process-adoption--2026-11-25"></a>

The [B1 process handoff](process-improvements-handoff.md) records early root
probes, exact audits, record ownership and capture checks.

<a id="carbon-review-guidance-adoption--2026-11-25"></a>

The [Carbon guidance handoff](carbon-review-improvements-handoff.md) records
adversarial guides and whole-cycle dispositions. The
[current procedure](gemini-review.md) owns their operational requirements.
