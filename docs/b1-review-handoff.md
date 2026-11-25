# B1 source and proof review handoff

Completed 2026-11-25 on `feature/attempt-02`, in
`/Users/adam/personal/proj/pi-disjunctivity/pi-disjunctivity`.

**The bounded documentation review is complete. B1 and the π disjunctivity
conjecture remain unproved in this project. No implementation slice was begun.**

## Results and remaining obligations

[The report](b1-source-proof-review.md) verifies the original BBP identity and
external Lean source at `e5376424f932afdbf529c696f985e516836e6601`, records license
and attribution constraints, gives the full classical integral argument, maps
its premises to pinned Mathlib, and specifies exact B1a statements/checks.
The external code is Apache 2.0; its paper text is CC BY 4.0. Future local proofs
should be independently written under the present policy, with source citations.
No external code was added, imported, adapted, or rebuilt.

The route integrates the single BBP term, uses a summable geometric majorant on
`[0,1]`, retains `HasSum` from dominated convergence, and evaluates the rational
integral with logarithms/arctangent and Mathlib's `Real.pi`. Every application
proof remains to be written locally: term integral, pointwise series,
domination/measurability, interchange, rational algebra, derivative,
integrability, endpoints, and final `HasSum` assembly.

B2's orbit bridge, B3's tail control, and V's independent arbitrarily late
visitation remain unfinished. Hπ and T remain unproved. B4 retains vanishing
error and arbitrarily late open-interval visits as premises; P3 retains
open-interval visits. No supporting conditional theorem proves those premises.

## Validation and Gemini review

Actual checks from the correct root, with `$HOME/.elan/bin` on `PATH`:

```text
lean --version                      4.37.0-rc1
lake build                          PASS: 6655 jobs, no warnings
lake env lean Test.lean              PASS: 19 theorem audits + 2 definition checks
signature-only /tmp Lean probe      PASS after correcting API-name guesses
git diff --check                     PASS
task-scoped staged whitespace        PASS
Markdown links/anchors               PASS
18 protected files vs a3feb6b         BYTE-IDENTICAL
archived prompts                     PRESERVED
```

The build/audit is the baseline run: no Lean-related input changed afterward.
All project Lean files, audits, pins, dependency files, CI, and `AGENTS.md` are
unchanged. There was no external axiom audit, clean rebuild, or remote CI run.

Gemini Carbon High returned **no findings** on the full supplied seven-file
substantive diff. Conversation: `a8f04fb2-eee8-4285-873b-cfcda7b64149`.
The first attempt's headless file denial and empty response were treated as
incomplete; one recovery supplied the material inline and completed with
exit 0, `SUCCESS`, a substantive response, and no error/denial fields.
Both runs used twenty-minute deadlines. The recovery took 5 min 47 s by caller
observations. It reviewed supplied evidence, without independent retrieval or
builds. [The saved review](agy-reports/b1-source-proof-review.md) records both
attempts, progress, terminal fields, response, and coverage limits.

## Retrospective and post-commit necessity review

After the initial milestone commit, reread the committed proof proposal.
The coefficient identifies the intended series; the one-term integral connects
it to the kernel. Domination justifies interchange, and the derivative/FTC/
endpoint calculation identifies the sum with `Real.pi`. Each piece is needed.
Retaining `HasSum` already removes the external proof's unnecessary preliminary
tail layer for our purpose. No separate summand definition, public monomial API,
or additional generic analytic theorem is needed in B1a. No further substantive
simplification was justified, so no fix-review follow-up or empty code commit
was manufactured. This handoff and the log are actual follow-up records.

Both plans and the blueprint point to B1a. The route, B1-before-B3 order, pins,
trust boundary, and Viewpoint cadence are unchanged. API-name lookup failures
were compiler feedback, not mathematical gaps. The reviewer permission obstacle
was resolved by the single supplied-input recovery; no permission was bypassed.

## Files, commits, and stop

Task-owned files: `README.md`; `docs/b1-source-proof-review.md`;
`docs/agy-reports/b1-source-proof-review.md`; `docs/proof-plan.md`;
`docs/meta-proof-plan.md`; `docs/proof-blueprint.md`; `docs/research-log.md`;
`docs/session-prompts.md`; and this handoff.

- Starting commit: `a3feb6bf02cea0aafdba29331e551d9e8173477d`.
- Reviewed milestone: `2b7a74529c47df66c7beb4f0218cbb1f0e3cb0a2`.
- Handoff/necessity-record commit: the commit introducing this file; retrieve
  with `git log -1 --format=%H -- docs/b1-review-handoff.md`. Its resulting ID
  is printed with the terminal handoff. No push or history rewrite was made.

Unrelated Obsidian/notes work, a staged `.codex/config.toml`, and untracked
`papers/` are preserved and excluded. The global cached whitespace check flags
an existing trailing blank line in that unrelated config; task-scoped checks
pass. The config's staged blob remained `f26b0af1c41298dc2e43bd7637febe853ecfa800`.

**Next task proposed for authorization:**
[B1a coefficient and one-term integral](b1-source-proof-review.md#smallest-implementation-slice-proposed-for-authorization),
with only `bbpCoeff` and the unconditional `integral_bbpTerm (j : ℕ)`, root
export and audits. Stop that future slice before infinite interchange,
integral evaluation, B2/B3, or V.

**Paused for the user's questions and decision.**
