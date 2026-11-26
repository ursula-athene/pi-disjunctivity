# B2 retrospective — 2026-11-25

The authorized endpoint is the complete convergent split, independently recursive
BBP sequence, range/finite-sum identity, and exact π-orbit bridge. All mathematical
obligations are checked; final acceptance and publication are recorded in
[the handoff](../b2-handoff.md), with [review evidence](../agy-reports/b2-review.md).
B3 and visitation are outside this cycle and remain open. B4/P3 retain their
vanishing-error/late-visit and open-interval-visit premises respectively.

The decomposition worked: scale B1 and split at `n+1`, normalize the finite
prefix under `j ≤ n`, retain `HasSum`, then prove recurrence induction with an
explicit integer-floor witness. Private prefix lemmas avoid an unnecessary
public API. Root definition/equation probes succeeded before dependent layers.
The theorem-instantiating zero/first-index checks exercise the intended offsets.

Observed feedback was local formalization work, not missing mathematics: an
explicit `pow_sub₀` argument, remaining powers after field normalization,
`Nat.succ_sub` rather than the differently oriented addition/subtraction lemma,
`Nat.zero_add` in a boundary simplification, and one line-length warning. An
early diagnostic queried the nonexistent `HasSum.congr`; it was removed.
No visibility failure, new import beyond the existing project/Mathlib stack,
heartbeat increase, proof bypass, or optional infrastructure was needed.

The B2a Carbon review found stale overview status and a duplicated live count.
The link checker correctly passed valid links but cannot detect stale mathematical
status prose. Corrected the status, replaced the count with the executable
inventory, and retained caller semantic review. No semantic document checker or
workflow expansion is justified by this one observation. Review invocation
counts, elapsed time, capture completeness, and limitations live in the linked
report; no historical productivity or clean-environment comparison is claimed.

Keep the existing proof/review/necessity workflow and B1/B2/B3 ordering. The next
bounded proposal is [B3 tail control](../proof-plan.md#next-bounded-task-b3-tail-control),
ending at quantitative bounds and tail convergence with audits and review.
This does not begin B3 or provide a route through the unresolved visitation gap.
