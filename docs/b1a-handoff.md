# B1a coefficient and single-term integral handoff

Implementation checked 2026-11-25 on `feature/attempt-02`, in
`/Users/adam/personal/proj/pi-disjunctivity/pi-disjunctivity`.

**B1a is checked and its Gemini review is complete. Local commit and
post-commit necessity records are being finalized.**
The full B1 identity and π disjunctivity conjecture remain unproved.

## Checked result and scope

[Series.lean](../PiDisjunctivity/BBP/Series.lean) independently defines the real
`bbpCoeff` with denominators `8*j+1`, `8*j+4`, `8*j+5`, `8*j+6` and signed
numerators `4`, `-2`, `-1`, `-1`. It proves, for every `j : ℕ` without hypotheses:

```lean
(∫ x in (0 : ℝ)..1,
  (x ^ 8 / 16) ^ j * (4 - 2 * x ^ 3 - x ^ 4 - x ^ 5)) =
  bbpCoeff j / (16 : ℝ) ^ j
```

The proof expands four monomials, obtains interval integrability by continuity,
applies integral linearity and Mathlib's `integral_pow`, and normalizes casts
and algebra. Only these two public declarations were added. A local fact reuses
monomial integrability; no public helper or separate summand API was needed.
The root exports the module. The coefficient body is exposed for importers.
No external proof scripts were copied, translated, imported, or rebuilt.

`Test.lean` preserves all nineteen earlier type/axiom guards and both π
expanded-definition checks. It adds the full unconditional theorem type and
actual exact axiom guard, a coefficient expansion check, and `bbpCoeff 0 = 47/15`.
Twenty theorem audits now pass; every list is exactly `propext`,
`Classical.choice`, `Quot.sound`.

## Validation and permissions

The actual starting HEAD was `ab43f71285be84d92952765c4b67990866fed6f0`, following
`2b7a745`; their completed B1 source review was not repeated. A concurrent user
commit, `855bb40f340ce7f70946975d2e017016291aa293`, subsequently committed only
the existing permission configuration. It was preserved. The snapshot/review
diff used `855bb40`; its task-owned diff is identical against `ab43f71`. No nested
`AGENTS.md` was found in the task paths. The saved command-rule check reported
`decision: allow` for the exact required `agy` prefix. The active execution
profile permits workspace/temporary writes, restricts other filesystem writes,
and provides no escalation. No permission configuration was changed.

Commands from the correct root with `$HOME/.elan/bin` on `PATH`:

| Check | Actual result |
| --- | --- |
| `lean --version` | `4.37.0-rc1` |
| Baseline `lake build` / `lake env lean Test.lean` | Pass: 6655 jobs, nineteen theorem audits and two definition checks |
| `lake env lean PiDisjunctivity/BBP/Series.lean` | Pass on first proof attempt |
| Integrated `lake build` | Pass: 7201 jobs, no warnings |
| Final `lake env lean Test.lean` | Pass: twenty guarded theorem audits plus definition/value checks |
| Actual `#print axioms` probe | New theorem and coefficient report only the three permitted axioms |
| `git diff --check` | Pass |

The first root-import audit found the coefficient body was not exposed. Adding
`@[expose]` fixed the export issue; the rebuilt root and audits passed. This was
a compiler/export issue, not a mathematical gap. Dependency pins, original
proofs/definitions, CI, and `AGENTS.md` are unchanged. Preservation checks passed for sixteen unrelated files, the config index blob,
archived prompts, sixteen protected source/configuration files, and all nineteen
old axiom-guard blocks. Task-scoped staged whitespace passed; pre-review local
Markdown links/anchors passed (156 checks). Final links are checked again with
the saved review record and compatibility anchor. No clean-environment rebuild,
external axiom audit, or remote CI result is claimed.

## Review and finalization

Gemini Carbon High returned **no actionable correctness findings** on all
thirteen supplied task-owned files. Conversation:
`97aef234-10e0-4246-a752-904553cb1ce9`. The [saved review](agy-reports/b1a-review.md)
records the exact diff hash, full response, progress, terminal fields, and limits.
One invocation completed in about 6 min 46 s, exit 0, `SUCCESS`, nonempty
response, and no terminal error/finished-reason/denied-action fields. No retry
or substantive-fix follow-up was needed. The reviewer used inline content only;
it did not run builds or independently inspect excluded files.

CLI-owned log/conversation persistence was denied by the sandbox. Authentication,
service access, and the full review response succeeded; the caller saved the
stream/result separately. Continuation from the CLI's own storage is unverified.
No permission setting was changed. The two nonblocking finalization checks were
resolved: document the concurrent permissions commit and retain the former
prompt anchor for one historical entry-point link. Neither changes the proof.

The initial local milestone commit and post-commit necessity review are pending
at this pre-commit snapshot; their actual IDs and results follow in finalization.

## Remaining obligations and next proposed task

T1 is now proved. Pointwise summation (T2), domination/measurability and
sum/integral interchange (T3), rational algebra (T4), derivative, integrability,
endpoints, and final `HasSum ... Real.pi` assembly remain unproved locally.
B2's orbit bridge and B3's tails remain unimplemented. V's independent
arbitrarily late visitation, Hπ, T, and π disjunctivity remain open. B4 assumes
vanishing error and arbitrarily late visits; P3 assumes open-interval visits.
None of those premises is supplied by this term-integral result.

The next proposed task, requiring separate authorization, is
[B1b pointwise series and domination](proof-plan.md#next-bounded-task-b1b-pointwise-series-and-domination).
It would prove the geometric `HasSum` on `[0,1]` and the bound `8*(1/16)^j`,
stopping before infinite interchange and integral evaluation. Neither statement
has been implemented here. The integral route, direct `HasSum` plan,
B1-before-B3 order, and Viewpoint cadence are unchanged. No new tooling is needed.

## Preserved work and stop

Initially staged `.codex/config.toml` and untracked `.codex/rules/` were committed
concurrently by the user as `855bb40`; this task did not alter them. Obsidian/notes
changes and `papers/` remain excluded. The original config blob remains
`f26b0af1c41298dc2e43bd7637febe853ecfa800`. Historical archived prompts remain
byte-identical. Task paths are the thirteen reviewed paths listed in the saved
review plus `docs/agy-reports/b1a-review.md`. Only those paths enter task commits.

No push or history rewrite is authorized. Stop after the B1a review,
validation, local commits, necessity review, and completed handoff; pause before
any further milestone.
