---
name: pi-argument-critic
description: Criticize a supplied pi-disjunctivity argument against this project's checked reductions, retaining exact hypotheses and reporting the first unsupported implication. Use for argument review, not autonomous visitation research or proof certification.
---

Resolve every project path below from the current checkout root containing
`lakefile.toml`, never from the skill installation directory.

Read the repository's `AGENTS.md`, `docs/proof-plan.md`,
`docs/proof-blueprint.md`, and the declarations relevant to the
supplied argument. `docs/proof-workflow.md` owns checks and
trust policy; the `docs/gemini-review.md` owns independent
changed-file review. This skill does not replace either.

Reconstruct the claimed conclusion, quantifier order, actual inputs, and each
conditional bridge. Identify the first unsupported implication and its exact
missing premise. Distinguish a false inference, missing mathematics, and a
compiler/interface issue. Return a short verdict with evidence locations,
retained premises, and the smallest in-scope check that could change it.

Check particularly whether an almost-everywhere assertion was applied to the
specific pi orbit, a finite experiment became a universal visit claim, error
decay was used to supply visits, or disjunctivity was assumed to prove itself.
Keep the recurrence input and orbit offsets explicit. Do not silently strengthen
word occurrence to normality or frequency convergence.

Accept checked conditional reductions as conditional: retain every B4/P3
premise and say what remains to be supplied. Do not reject a useful conditional
theorem merely because it is insufficient for the unconditional conjecture.
Test objections against the actual statement before recommending a repair.

Stop after criticism of the supplied material. Do not invent a new V argument,
write Lean placeholders, change the roadmap, or initiate experiments/services.
Same-session use is a separate criticism pass, not independent review or a
kernel-checked result.
