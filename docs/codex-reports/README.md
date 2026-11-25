# Literature and comparison reports

Reports prepared on 2026-11-24 for the hexadecimal formulation in
`ursula-athene/pi-disjunctivity`, reviewed at commit
`ae2ba3ffdd391bb9c5312de1a54668facdf09653`.

- [Lean literature review](2026-11-24-lean-literature-review.md): related
  formalizations, proof status, source snapshots, and search limitations.
- [DeepMind and linked proof comparison](2026-11-24-deepmind-comparison.md):
  detailed comparison of digit definitions, word quantifiers, interval
  correspondence, orbit density, and trust boundaries.

The closest external proof source covers the same general equivalence as this
project's milestones A and B, with arbitrary bases and a circle-valued orbit.
No proof of pi disjunctivity was found in the inspected sources. External proof
bodies were inspected but were not independently rebuilt or axiom-audited in
this literature-review session.

These reports supplement the [milestone C formulation review](../formulation-review.md).
They introduce no Lean code, dependencies, or changes to the pinned versions.

Validation: relative Markdown links and new-file whitespace were checked
directly, and `git diff --check` passed. No tracked source or configuration file
changed. The Lean build and axiom audit were not rerun for this documentation-only
addition; their prior results are recorded in the milestone C review.
