# B2 retrospective — 2026-11-25

The authorized endpoint is the complete convergent split, independently recursive
BBP sequence, range/finite-sum identity, and exact π-orbit bridge. B2 is checked,
reviewed, committed, pushed, and reviewed for necessity; evidence is recorded in
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

Final review confirmed the documentation correction and returned no actionable
findings. Post-commit necessity review retained the small proof chain without
substantive changes. Both reviews completed with full captures; no recovery
retry was needed. No process expansion is warranted by this cycle.

## Post-milestone discussion — 2026-11-25

Requested after B2 completion, at `1e78ad6` on
`feature/attempt-07-b2-orbit`. The original completion notes above are preserved.
This discussion includes the subsequent assessment of optional Lean tools.
Recommendations below are proposals: no tooling was installed, no policy or
review requirement changed, and B3 was not begun. Milestone evidence is in the
linked handoff and review report; observations about reading, polling, and
communication also come from the implementation session.

### What went well

- **The mathematical decomposition stayed small and direct.** B1 supplied the
  convergent series; splitting and scaling supplied the tail; induction and an
  explicit integer-floor witness supplied the recurrence identity. The final
  orbit theorem followed directly. No missing mathematics emerged within B2,
  and no extra convergence or visitation assumptions were introduced.
- **The B1 process lessons were applied successfully.** Definitions and
  equations were checked through the library root before dependent layers.
  Boundary checks instantiated the intended theorems, including orbit indices
  zero and one. The earlier visibility and ineffective-boundary-check problems
  did not recur. This is encouraging evidence from one cycle, not a measured
  comparison of productivity.
- **The proof stayed maintainable.** The new module is 109 lines, with three
  definitions, six public theorems, and two private prefix lemmas. Post-commit
  inspection found each piece served a requested contract or proof consumer.
- **Validation and review complemented one another.** Kernel checks, complete
  types, actual axiom guards, semantic review, and theorem-instantiating examples
  covered different failure modes. Carbon High caught a documentation mistake
  that the automated checks could not detect. Both review captures were complete,
  and neither run required recovery.
- **Scope and publication were controlled.** All authorized B2 work finished
  without fresh permission requests between checkpoints. Reviewed commits were
  pushed regularly, unrelated work and existing branches were preserved, and
  work stopped before B3 without opening a PR. Independent scratch work during
  the checkpoint review made progress while leaving the submitted diff fixed.

### What was harder or could have gone better

- **Small Lean details still caused avoidable iterations.** A guessed API name,
  an explicit argument to `pow_sub₀`, natural-subtraction rewrite orientation,
  residual powers after field normalization, and boundary simplification each
  needed attention. Finding the generated additive declaration
  `hasSum_nat_add_iff'` required tracing its multiplicative source. Index
  arithmetic needed deliberate care, but these were formalization repairs
  rather than missing mathematics.
- **Documentation consistency remained a weak point.** The proof plan still
  called the split unimplemented and listed an outdated live audit count when
  B2a went to review. Valid links did not make those statements current. Despite
  the clearer document responsibilities adopted after B1, repeated status prose
  still created maintenance work.
- **Review handling had a noticeable cost.** The two invocations took 322.675
  and 395.930 seconds: about twelve minutes combined. This measures review
  elapsed time, not total session time or time lost. Conversation persistence
  failed, so the final review needed the complete supplied context in a new
  conversation. Full diff coverage survived; a conversation ID alone was
  insufficient for continuity.
- **My tool use and updates could have been quieter.** Some repository reads
  were batched too broadly, causing truncated displayed output and rereads.
  During reviews I used too many short polls and repeated similar waiting
  messages. These added noise without establishing new progress. This concerns
  ordinary reading and presentation; the saved reviewer captures were complete.

### Improvements to carry forward

1. **Inspect exact API signatures before composing proofs.** Keep the early
   root-import probe, and make natural-index equalities explicit before field
   or ring normalization. Prefer a small compiler-guided repair over expanding
   automation or increasing tactic limits.
2. **Add a focused semantic status pass before review.** Read the active
   overview, milestone status, blueprint row, and current prompt together.
   Check what is proved, what is pending, and which hypotheses remain. Continue
   linking to the executable audit inventory instead of repeating live counts;
   do not turn the link checker into an unreliable semantic checker.
3. **Use smaller reads and less frequent polls.** Read relevant sections in
   bounded batches. During long reviews, generally poll at 30–60-second
   intervals, retain full capture budgets, and give concise updates that
   distinguish new reviewer activity from silence or runtime logging. Preserve
   the required deadline, progress reporting, and bounded recovery procedure.
4. **Keep review inputs self-contained and clearly indexed.** Supply the exact
   diff, baseline, contract list, relevant API locations, and prior findings even
   when requesting continuation. Ask for findings first and concise coverage
   notes. Preserve full milestone scope, Carbon High, and read-only tools;
   efficiency should come from presentation, not weaker review.
5. **Keep durable records concise.** Put detailed acceptance evidence in the
   handoff and review report, and use short links elsewhere. Record genuine
   process changes in the meta-plan when adopted. The optional tooling proposal
   below addresses specific search and feedback friction; it does not justify
   replacing the proof workflow or adding Lean library dependencies.

### Optional tooling assessment

Inspected the local sibling clones of `lean-lsp-mcp` at
`7932203d79db213852db215835bd79c943bb99b0` (version 0.33.0) and
`LeanAutoformalizationSkills` at `1837b95b3d5a9fd8d311367603902ad7fe261adf`.
The links below pin the inspected revisions. This was source and documentation
inspection, not an installation, compatibility test, or performance benchmark.

**Prioritize a bounded `lean-lsp-mcp` pilot.** Its documented tools expose live
proof goals, diagnostics, hover information, and declaration locations. Local
search includes the language server's symbol index, covering declarations
generated by `@[to_additive]` that plain source search can miss. That is a
concrete fit for the B2 search above. Inspecting goals and signatures in place
could also shorten compiler-repair cycles; the size of that benefit is unmeasured.
See the [tool documentation][lsp-tools].

Normal LSP operation runs the project's `lake serve` and need not add a Lean
library. Keep the optional REPL disabled: its documented setup adds
`leanprover-community/repl` to the Lake dependencies, contrary to our policy.
The inspected test project uses Lean 4.35.0, so compatibility with our pinned
4.37.0-rc1 remains unverified. See the [setup instructions][lsp-setup] and
[test toolchain][lsp-toolchain].

**Use selected skills when relevant.** `lean-search-discovery` gives a
systematic local-first search process and requires checking actual signatures;
`lean-proof-patterns` emphasizes explicit proof structure, controlled rewriting,
and replacing exploratory searches with stable proofs. These reinforce much
of our existing workflow, so their incremental benefit is likely smaller.
Consider `lean-elaboration` when a measured performance problem appears. The
collection's [workflow router][skills-workflow] explicitly defers to repository
instructions and supports selecting focused skills.

The full [statement-audit procedure][skills-audit] assumes manifests, frozen
declarations, additional approvals, and quarantined `sorry` drafts. Adopting it
would require substantial adaptation to our process and prohibition on
placeholders. Do not import that machinery wholesale. The current evidence
also does not justify multi-agent orchestration or a new dependency graph.

The tools are complementary: LSP supplies compiler feedback and discovery;
skills guide how to use that evidence. A useful pilot would exercise completed
B2 only: locate the generated sum lemma, inspect exact signatures such as
`pow_sub₀`, and retrieve goals and diagnostics. Compare the effort and latency
with the current shell workflow before adopting it. Preserve the pins, build
checks, guarded axiom audits, and Carbon reviews. This proposal neither starts
B3 nor establishes that the tooling is compatible or faster.

Neither tool directly fixes stale documentation, review latency, or the missing
visitation mathematics. Their plausible benefit is reducing formalization
friction, not changing the mathematical status of the project.

[lsp-tools]: https://github.com/oOo0oOo/lean-lsp-mcp/blob/7932203d79db213852db215835bd79c943bb99b0/docs/tools.md
[lsp-setup]: https://github.com/oOo0oOo/lean-lsp-mcp/blob/7932203d79db213852db215835bd79c943bb99b0/README.md
[lsp-toolchain]: https://github.com/oOo0oOo/lean-lsp-mcp/blob/7932203d79db213852db215835bd79c943bb99b0/tests/test_project/lean-toolchain
[skills-workflow]: https://github.com/scottnarmstrong/LeanAutoformalizationSkills/blob/1837b95b3d5a9fd8d311367603902ad7fe261adf/skills/lean-workflow/SKILL.md
[skills-audit]: https://github.com/scottnarmstrong/LeanAutoformalizationSkills/blob/1837b95b3d5a9fd8d311367603902ad7fe261adf/skills/lean-statement-audit/SKILL.md

### General comments

B2 is a useful completed bridge: it ties the independently defined recurrence
to the actual hexadecimal orbit of Mathlib's π, with convergence and indexing
checked. It also shows that the current local Lean workflow is adequate for
this established piece of mathematics.

That success does not make the visitation problem easier by itself. B3 tail
control is the next bounded proposal, not work begun here. V, Hπ, T, and π
disjunctivity remain open; B4 still needs vanishing error and arbitrarily late
visits, and P3 still needs open-interval visits. Keep the distinction between
formalizing established mathematics and discovering the missing argument.
