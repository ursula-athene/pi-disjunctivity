# M4 argument and partial-result review — 2026-11-26

The reviewed claim is an incomplete M4 research outcome, not universal
visitation. The [argument assessment](../m4-visitation-obstruction.md) records
the mathematical scope; the [handoff](../m4-handoff.md) owns acceptance and
publication state. Baseline `b7c3bca2af60c2ea8d2a8bf06c086709a79fd15f`.

Required background: `AGENTS.md`, `docs/gemini-review.md`, and both complete
guides, `docs/code-reviews/lean-adversarial-review-prompt.md` and
`docs/code-reviews/lean-proof-strategy-and-tooling-review.md`, unchanged at the
baseline revision. Carbon must use High effort and read-only file tools;
it must not execute commands or alter files. Caller kernel/process checks are
receipts, not reviewer-performed checks. No downstream proof block requires an
additional intermediate review; this review covers the central mathematical
assessment and the complete owned diff before any local commit.

## Review receipt and coverage

Exact initial ten-file diff SHA-256:
`5cb58adc90262fed23e4a185563f2c6214120435633eb515821371430b164bce`.
Scope is enumerated in `/tmp/pi-m4-review-20261126/scope.json`; full diff,
prompt, both diagnostic proof bodies, execution chunks, response, inspection
and separate `cli.log` are retained under that directory. These are temporary,
not a durable archive. Both complete guides were supplied inline and read from
disk with `AGENTS.md` and the procedure. The proof guide informed target,
countermodel and probe scrutiny; the strategy guide informed the assessment
of mathematical gaps, recovery and whether more infrastructure was justified.

Invocation: literal `agy --model gemini-4-carbon-high --mode plan`, streaming
JSON, twenty-minute deadline, conversation
`02a2d2f1-b64e-42b1-846a-7ea50235c573`. Exit 0, substantive `SUCCESS`;
`error`, `finished_reason`, and `denied_actions` absent. CLI runtime was
831.263 seconds, caller start-to-final-capture 856.972 seconds. All execution
chunks were saved losslessly and passed complete-attestation inspection
(exit 0, no capture issues). Only `read_file` was used. Initial boundary
updates were followed by a 711.779-second analysis/response step without an
intervening progress update; the caller kept polling the same live session.
Silence was not treated as a hang and no retry was launched.

Separate CLI-log inspection found initialization authentication warnings,
then successful silent authentication; optional `cs`/plugin and relative
Gemini-directory fallback messages did not deny coverage. No persistence,
review-tool permission, service or terminal failure was found. The raw log
is retained with the captures; no credential or unrelated host details are
copied here. A saved conversation ID does not guarantee future availability.

Carbon reconstructed the countermodels, polynomial/offset translation,
residue equivalence and recovery arguments and inspected the actual B2/B3/B4
interfaces and both supplied scratch proofs. It found the incomplete-M4
conclusion justified and no concrete overlooked in-scope implication. External
papers were assessed from supplied extracted contracts, not independently
retrieved by Carbon. Kernel, axiom and process executions were caller receipts.
Reviewer mathematical agreement does not replace kernel proofs or prove V.
The additional omega-limit description volunteered in its reconstruction of
the Liouville model is not needed or adopted as a new project claim.

## Findings and dispositions

Defects: none. Open review questions: none. The mathematical V obligation
remains open and prevents M4 acceptance, despite a completed review of this
partial outcome.

| Item | Original recommendation | Disposition |
| --- | --- | --- |
| I1, nonblocking | Retain the source-probe hash and exact diagnostic definitions/signatures in tracked documentation, since temporary probes/captures can disappear. | Implemented: the handoff has both hashes and links to the inventory below. Statements were compared with the reviewed immutable probe bodies; full proofs remain temporary. No new production theorem or audit is claimed. Documentation and whitespace checks cover the edit. |
| I2, nonblocking | Link the M4 handoff from the second active entry, optionally also the proof-plan introduction. Existing text was not false but lacked the direct restart pointer. | Implemented in both locations. This adds `docs/proof-attempt-session-prompt.md` to the owned scope (eleven files total); Carbon had already inspected it as surrounding context. Local link and working/staged whitespace checks cover these one-line changes. |

**Whole cycle:** one completed Carbon High review, no failed invocation/retry,
no defects or open review questions, and two nonblocking improvements applied.
The exact mathematical assessment and diagnostic proof bodies are unchanged
after review. The signature inventory, entry links and factual receipts are
minor documentation updates checked by the caller, not a second Carbon review.
There is no substantive proof or strategy fix requiring focused follow-up.

## Diagnostic contract inventory

This is a textual inventory of the compiled scratch declarations, not added
Lean declarations, assumptions or production exports. Full proof bodies were
supplied in the reviewed packet; hashes and temporary retention limits are in
the handoff. Each principal theorem's observed axiom list is exactly
`[propext, Classical.choice, Quot.sound]`.

```text
namespace M4SourceProbe
coeff_rational_form (n : ℕ) : PiDisjunctivity.bbpCoeff n =
  (120 * (n : ℝ)^2 + 151 * n + 47) /
    ((8 * n + 1) * (2 * n + 1) * (8 * n + 5) * (4 * n + 3))
shifted_irrational : Irrational (Real.pi / 16)
orbit_index (n : ℕ) :
  Int.fract ((16 : ℝ) ^ (n + 1) * (Real.pi / 16)) =
    Int.fract ((16 : ℝ) ^ n * Real.pi)
end M4SourceProbe

namespace M4AvoidanceProbe
noncomputable def t (n : ℕ) : ℝ := 1 / (8 * (n : ℝ) + 1)^2
noncomputable def forcing (n : ℕ) : ℝ := 16 * t n - t (n + 1)
noncomputable def orbit (n : ℕ) : ℝ := 1 - t n
initial : orbit 0 = 0
recurrence (n : ℕ) :
  orbit (n + 1) = Int.fract (16 * orbit n + forcing n)
avoids (n : ℕ) : orbit (n + 1) ∉ Set.Ioo (0 : ℝ) (1/2)
forcing_pos (n : ℕ) : 0 < forcing n
t_tendsto : Filter.Tendsto t Filter.atTop (nhds 0)
forcing_tendsto : Filter.Tendsto forcing Filter.atTop (nhds 0)
not_visitation : ¬ (∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 →
  ∀ N : ℕ, ∃ n ≥ N, orbit (n + 1) ∈ Set.Ioo a b)
end M4AvoidanceProbe
```
