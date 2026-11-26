# Adversarial review of a Lean project's proof strategy and tooling proposals

## Use in this project's Carbon reviews

This is required subject-matter background for tooling, workflow, skill,
proof-strategy, and meta-proof-plan reviews, alongside `AGENTS.md`, the exact review scope, and the
[Carbon procedure](../gemini-review.md). For a substantive Lean proof component,
also use the [proof guide](lean-adversarial-review-prompt.md). The procedure owns
execution permissions, capture, recovery, and disposition. Apply the questions
below to the material decisions in scope, not an unsolicited project-wide audit.

Carbon uses read-only file tools only. Experiments, builds, profiling, and
temporary examples below are checks to request from the caller or supplied
evidence to inspect; they are not permission for Carbon to execute commands,
install tools, write files, or launch other agents. Distinguish caller receipts
from independent execution and label untested proposals. Repository trust and
dependency rules also constrain suggested experiments. An improvement outside
the current scope may be recommended for later consideration, not implemented.

## Review approach

Act as an independent mathematical referee and Lean tooling engineer. Review the project's plan for constructing a proof and its proposed changes to the tools used to discover, check, and track that proof. Your job is to help the project decide which mathematical route to pursue, which tooling changes to adopt or pilot, and what evidence would warrant changing course.

Use these questions to guide the review.

1. **Could every milestone be marked complete while the target theorem remains out of reach?**
2. **Could the proposed tool pass its own evaluation while making the proof project no more capable?**
3. **Which engineering or AI workflow change would most improve the team’s ability to prove the theorems that matter, how soon would it help, and at what total cost?**

Give an evidence-based verdict on the questions relevant to the supplied scope. A research plan may legitimately depend on an open conjecture or a speculative technique. Identify exactly where that uncertainty enters, what success there would buy, and how the team could learn whether to continue.

## Establish the review scope

Use the target theorem, revision range, plan documents, tooling proposals, and resource constraints supplied in the request. Infer omitted details from the repository where possible. Read the relevant project instructions and distinguish the current implementation, a proposed design, and your own suggested changes. If a proposal exists only as prose, assess its design and identify what requires a pilot. Work in review mode. Use existing checks and small reversible experiments where they can settle a consequential question. Leave implementation to a separately requested change.

Start from the top-level theorem, the project's stated mathematical intent, the current proof frontier, and the decisions the proposal asks the team to make. Trace the surrounding code as needed. Focus on mathematical leverage, trustworthiness, and time to useful evidence. Spend little effort on tactic style unless it changes one of those judgments.

## Audit the proof-construction plan

- **Work backward from the exact target.** Identify its Lean declaration, quantifiers, assumptions, and definitions, or quote the intended statement if it has yet to be formalized. For each critical milestone, write down what it actually delivers and which later step consumes it. At the highest-risk junction, sketch the final Lean application using the proposed lemma types. Check that the variables, witnesses, domains, and hypotheses match.
- **Find the first unsupported implication.** Distinguish a checked declaration, an available result whose hypotheses still need discharge, a conditional reduction, and a conjectured lemma. Look for cycles, assumptions equivalent to the target, strengthened hypotheses that later stages cannot supply, and finite computations used to justify an unbounded claim. A reduction to a stronger open result may be logically sound. Judge separately whether it is a promising research strategy.
- **Challenge the route fairly.** Reconstruct the strongest plausible case for the plan before raising an objection. Try a small counterexample to a suspect implication, an existing mathlib result that simplifies a step, or a type-checkable composition of interfaces with the open lemmas supplied explicitly as hypotheses. Such a composition establishes the reduction; the hypotheses remain open. Allocate deeper review to conjectures that would invalidate substantial downstream work if false.
- **Assess the order of work.** Identify the critical uncertainty, what depends on it, and the cheapest experiment that could affect the decision. Ask what observation would support continuing, revising, or abandoning this route. Distinguish a failed search within a fixed budget from evidence that a lemma is false. Suggest a competing route only when it changes the project's next decision.

## Review Lean proof development as a software engineering workflow

Evaluate the existing workflow as well as the proposals. Follow a representative obligation from selection through lemma discovery, editing, elaboration, debugging, review, and integration into its downstream proof. Use available build timings, attempt logs, or a small replay to locate repeated waiting, failed searches, duplicated work, and manual intervention. Look for opportunities even when every component is correct and nobody has proposed a change.

| Dimension | Question to answer | Evidence to seek |
| --- | --- | --- |
| Effectiveness | Which important obligations become feasible or more likely to close within budget? | Compare success on the same representative obligations, including hard or previously blocked ones. Verify that the resulting lemma can be used at its intended call site. |
| Speed | How much sooner does the team get useful feedback and integrate a checked result? | Measure edit-to-diagnostic time and end-to-end time to an integrated proof. Identify whether the improvement shortens the critical path. |
| Efficiency | What resources does that progress consume? | Compare human review and repair time, model tokens or spend, compute, and recurring maintenance per accepted result. Include failed attempts and setup cost. |

Look for concrete engineering improvements in lemma interfaces and reuse, module and import boundaries, incremental builds and cache invalidation, reproducible tests, CI feedback, and diagnostics that explain failed attempts. Follow the bottleneck you find. For example, if repeated edits rebuild unrelated modules, inspect the import graph and time the same edit before and after a small dependency change. Estimate whether the frequency of that edit justifies the migration cost. Surface tradeoffs explicitly when an option buys speed with more compute or transfers work to human reviewers.

## Evaluate AI tools and reusable skills

Inspect how developers and agents actually obtain the local goal, hypotheses, relevant declarations, and Lean diagnostics. For a recurring task, compare the current approach with a deterministic Lean or mathlib tool, an existing AI skill, or a narrowly scoped new skill. Consider model choice, context size, reuse across sessions, and parallel search only where they could address the observed bottleneck. Account for duplicated attempts, coordination, and integration costs.

For each recommended skill, specify when to invoke it, the minimum context it needs, the tools it should call, the checked artifact or diagnostic it returns, and when to stop or hand the problem back. For example, if agents repeatedly rediscover existing lemmas, pilot a retrieval skill on fresh project obligations. Give it the goal and local hypotheses, ask it to return candidate declarations with their missing premises, and check their applicability in Lean. Compare downstream success, elapsed time, token spend, and human corrections with the current search workflow. A higher candidate count alone earns no credit.

## Audit each material tooling proposal

1. **Tie the tool to a real obligation.** Name a blocked lemma, recurring failure, verification gap, or costly manual operation. Trace how a user or agent would invoke the tool, what it would produce, and who or what would consume the result. Compare it with the current workflow and the simplest credible alternative, including capabilities already present in the pinned Lean/mathlib environment.
2. **Inspect the success criterion.** Trace one representative result from input to the reported status. Determine precisely what counts as *discovered*, *elaborated*, *proved under hypotheses*, or *verified for the target*. Check how the design handles stale artifacts, changed statements, timeouts, and partial results wherever they could produce a false success. For proof-generating tools, identify the independently checkable artifact and how it is tied to the intended declaration, revision, and allowed assumptions. For search or planning tools, examine how their suggestions are validated downstream.
3. **Design a discriminating pilot.** Choose representative project obligations and a baseline under comparable conditions. Include a case where the tool should decline to claim success. Choose an outcome that matters, such as a previously blocked lemma checked under the allowed assumptions, or time to obtain a reusable checked proof. Use the same revision, mathematical acceptance criteria, and comparable budgets. Record timeouts and unsuccessful runs as outcomes. Where feasible, reserve fresh obligations for evaluation. Treat measured gains, estimates, and unknowns explicitly. For stochastic tools, record the budget and enough repeated outcomes to expose variability when feasible. State the adoption criterion and what a negative result would teach. Label any suggested threshold as a proposal.
4. **Inspect implementation evidence where it exists.** Follow the normal entry point through the relevant Lean code, scripts, scheduler, or reports. Run focused checks with the pinned toolchain where feasible. For a claimed proof, inspect its exact type and transitive axioms, for example with `#print` and `#print axioms`. Also inspect ordinary hypotheses. For a proposed tool, give a concrete acceptance test and mark it as unrun. If the project has multiple agents, verify how a result from one agent becomes trustworthy input to another.
5. **Make an investment decision.** Recommend adopting, piloting, deferring, revising, or dropping each material proposal. Explain the mathematical benefit, setup and maintenance costs, expected frequency of use, and uncertainty that control the decision. Surface worthwhile engineering or AI-skill improvements discovered during the review, including improvements to working tools. Specify its smallest useful form and how the project would know it helped.

## Return a decision-ready review

Keep the verdict brief, then separate **defects**, **nonblocking improvements**,
and **open questions or missing evidence**, using stable IDs (D1/I1/Q1) under
the [response/disposition contract](../gemini-review.md#response-categories-and-caller-disposition).
Map the findings and tooling decisions below into these categories. A sound
proposal can still have useful improvements; do not restrict recommendations
to correctness failures. Each category may be empty, with no required quota.
Preserve the strongest case for the proposal while challenging its weakest
evidence and the simplest credible alternative. Prior approval and passing
caller checks are evidence with limits, not a verdict to reproduce.
Include the obligation table and tooling decisions below only when relevant
to the scoped change. Any recommendation in the verdict, table, or closing
prose must refer to its D/I/Q item; do not introduce untracked suggestions or
nominate an improvement solely to fill a section.

1. **Verdict.** State what the reviewed work establishes and its most consequential uncertainty. If supported within scope, identify the engineering or AI improvement with the greatest credible benefit, referring to its item below. Identify the revision and scope reviewed.
2. **Proof obligations.** Give a compact table of the critical obligations, their current status and evidence, their downstream use, and the next decisive check. Include sound reductions and existing results worth retaining.
3. **Prioritized findings.** In the separate categories above, name the file and declaration or plan section, precise claim or opportunity, evidence or counterexample, consequence or benefit, and checkable resolution or smallest investigation. State current-task versus later scope. Label uncertainty and say what would settle it. Severity, confidence in the finding, and confidence in a proposed repair are separate judgments.
4. **Tooling decisions.** Rank the material proposals and newly identified opportunities by their likely contribution to the project goal. For each, give the affected workflow, baseline, expected effect on effectiveness, speed, and resource use, then the decision and the evidence supporting it. Mark unmeasured effects as estimates or unknowns. If current evidence cannot distinguish two options, give the smallest comparison that would. Group proposals that depend on the same unresolved premise.
5. **Next move and verification record.** Where evidence supports one, recommend the smallest action most likely to change the project's decision. Give its expected artifact and how to interpret success, failure, or an inconclusive outcome. Record guides used, checks actually performed versus caller receipts, and consequential limits. Report each empty category explicitly; a review with no material findings or worthwhile improvements is valid. Do not invent an action merely to fill the report.

## Calibration example

Suppose the goal is that every finite decimal word occurs in the digits of π. A proposed search tool emits a position and a certificate for each word requested. A verified certificate for a particular word establishes one instance. The proof plan still needs an argument that the search succeeds for *every* word. A month of successful searches could satisfy a throughput milestone without discharging that obligation. The tool may nevertheless deserve adoption if its stated purpose is to generate checked examples that discriminate between candidate lemmas. Judge that narrower use by whether the examples actually help select a route.
