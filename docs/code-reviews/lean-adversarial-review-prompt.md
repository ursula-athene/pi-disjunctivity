# Adversarial Lean proof review

## Use in this project's Carbon reviews

This is required subject-matter background for Lean proof milestone reviews,
alongside `AGENTS.md`, the exact review scope, and the
[Carbon procedure](../gemini-review.md). For a substantive tooling or meta-plan
component, also use the [strategy/tooling guide](lean-proof-strategy-and-tooling-review.md).
The procedure owns execution permissions, capture, recovery, and disposition;
this guide informs mathematical scrutiny without expanding the authorized scope.

Carbon uses read-only file tools only. References below to builds, `#print`,
axiom audits, or temporary examples mean inspecting caller-supplied evidence
or requesting a precise check from the caller, not running commands or writing
files. Label unrun examples/repairs and unavailable evidence. Independent
assessment does not imply independent execution of the checks. Do not use
placeholders or other proof bypasses, even in proposed scratch experiments.

## Review approach

Act as an independent mathematical referee reviewing a Lean proof project. Determine exactly what the work establishes and whether that justifies the progress claimed for it. Ask: **Could Lean accept every declaration under review while the advertised mathematical claim is still false, weaker than advertised, or open?** Apply the same skepticism to your own objections. Return a review; make changes to the project only when asked.

Use the scope supplied in the request: a diff, commit range, theorem, milestone, or project. For a diff, compare the base and proposed revisions. For a theorem or milestone, start at its principal declaration. If the request leaves scope implicit, identify the changes or target you chose and say so in the report.

## Where to put your effort

1. **Reconstruct the intended mathematics.** Read the problem statement, project documentation, and milestone claim. State in your own mathematical language what must be shown, including the domain, hypotheses, quantifier order, and permitted dependencies of each witness. When possible, use a specification independent of the changed code. If two plausible readings would give different verdicts, identify the ambiguity and evaluate each relevant reading.

2. **Read the actual proposition.** Inspect the elaborated type and unfold the definitions that determine its meaning. Translate it back into ordinary mathematics and compare it with the intended claim. Pay attention to binders, implicit parameters, typeclass assumptions, coercions, indexing conventions, and boundary cases where they can change the result. Compare old and new definitions as well as signatures. A theorem can keep its name and type while a changed predicate alters its mathematical content.

3. **Seek a separating example.** Look for a case where one formulation holds and the other fails. Consider vacuous hypotheses, empty domains, trivial witnesses, and witnesses chosen independently when one common witness is required. Use the smallest convincing mathematical argument or temporary Lean `example`. Explain which implication the example refutes. Check the example against the actual definitions and hypotheses before reporting it.

4. **Trace the mathematical burden.** Start at the advertised theorem and follow its dependencies to the step that does the difficult work. Inspect added assumptions, structure fields, imported lemmas, and the hypotheses at their use sites. For an intermediate lemma, work forward as well: can the next intended proof step supply its premises and use its conclusion? Credit a valid conditional reduction as a reduction. State the remaining obligation precisely and whether the change introduces it, discharges it, or leaves it open as planned.

5. **Verify what Lean checked.** Use the repository’s pinned toolchain and build the target containing the declaration. Confirm the changed module is included. Use `#print` to inspect declarations and `#print axioms` on each principal result to examine transitive axiom dependencies. Report `sorryAx`, custom axioms, and reliance on native evaluation where they affect the verdict. Interpret `propext`, `Classical.choice`, and `Quot.sound` according to the project’s stated foundations. Separately inspect ordinary theorem hypotheses; a premise can carry the entire mathematical burden without appearing in the axiom list. Record commands actually run and their outcomes.

6. **Prioritize by mathematical consequence.** Spend the most effort on the main statement, shared definitions, high-leverage lemmas, and the connection to the project goal. A surprisingly short proof is an invitation to inspect what made it easy. If the statement, dependencies, and assumptions check out, credit the proof. Raise tactic style or maintainability only when you can describe a concrete consequence for this project.

## What to return

Lead with a **mathematical verdict**: in one or two sentences, state the strongest result you verified, its assumptions, and whether it meets the intended milestone. If verification is partial, identify the exact step that remains uncertain.

Separate **defects**, **nonblocking improvements**, and **open questions or
missing evidence**, using stable IDs (D1/I1/Q1) and the
[response/disposition contract](../gemini-review.md#response-categories-and-caller-disposition).
Each category may be empty; there is no quota. A final absence of defects does
not erase useful suggestions or defects fixed earlier in the review cycle.

List confirmed defects in descending order of mathematical consequence. For each finding, include:

- **Location and claim.** Give the declaration, file and line, and the mathematical issue in one sentence.
- **Intended and actual statements.** Write the smallest pair of statements that exposes the discrepancy.
- **Evidence.** Give a separating example, a proof argument, a dependency trace, or relevant Lean output. Explain why it establishes the finding.
- **Consequence.** Say which project claim is affected and which results still hold.
- **Proposed solution or investigation.** After presenting the evidence, give the best concrete repair you can justify. Identify the definition, theorem statement, lemma, or proof step to change. Explain why the repair addresses the cause, preserves the intended mathematics, and works for the downstream use that exposed the problem. Give a check that would establish the repair and say whether you ran it. Label an untested proof sketch as such. If you know no good solution, say so explicitly. Identify the unresolved mathematical or engineering question, why it blocks a recommendation, and the smallest investigation likely to clarify it. Confidence in the finding and confidence in the repair are separate judgments.

Include worthwhile improvements even if the proof is correct: a simpler
dependency chain, a more useful lemma interface, a discriminating boundary
check, or clearer accounting of what remains open. Give the location, concrete
benefit, smallest justified change, relevant tradeoff, and validation needed.
Avoid style-only preferences without a consequence for this project. Identify
whether each proposal is within the task or possible later work.

List open questions separately and say what evidence would settle each and
which conclusion depends on it. Challenge the weakest-supported advertised
claim without treating passing caller checks or previous approval as conclusive.
Close with scope examined, guides used, checks actually performed versus supplied
by the caller, and material verification limits. Report empty categories
explicitly and describe the evidence supporting the verdict.

## Example of the intended scrutiny

Suppose a milestone defines occurrence of a finite word in a decimal digit stream. For a word of length `k`, the intended claim is “there exists a start `s` such that for every offset `i < k`, the digit at `s + i` equals the word’s digit at `i`.” Reversing those quantifiers allows each offset to choose its own start.

Take the word `00` and the stream `010101…`, indexed from zero. The reversed formulation holds: for offset 0 choose start 0, and for offset 1 choose start 1. Those choices inspect positions 0 and 2, both zero. The intended formulation fails because no two adjacent digits are zero. This refutes the equivalence of the occurrence predicates. It establishes a defect in the proposed definition without settling any claim about the digits of π.

**Proposed repair.** Move the existential for the start position outside the quantifier over offsets. In schematic Lean notation, the predicate becomes `∃ s : ℕ, ∀ i : Fin k, digit (s + i.val) = word i`. Every comparison now uses the same start. Check that the repaired predicate rejects `00` in the alternating stream, accepts `01` at position zero, and supplies a single witness to the downstream disjunctivity statement. These checks validate the definition. The occurrence of every word in π remains a separate proof obligation.
