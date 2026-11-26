# B2 tool and skill evaluation — 2026-11-25

Evaluation under the [sole P0–P5 specification](b2-process-tool-improvement-plan.md),
baseline `e83580e79923cd6672de8b7e6c6043321d0a26b6`. Acceptance/publication belongs
in the [handoff](b2-improvements-handoff.md); Carbon evidence belongs in the
[review report](agy-reports/b2-improvements-review.md). No production Lean,
audits, pins, or dependency manifests changed. B2 is fixed test material.

## P0/P1 baseline and process evidence

The user-prepared branch is `feature/b2-process-and-tooling-improvements`.
The index began empty; unrelated Obsidian, notes, and papers were preserved.
Lean `4.37.0-rc1` / Lake `5.0.0-src+0b77e12` were verified before the passing
baseline `lake build` and `lake env lean Test.lean` (each exit 0). uv is
`0.12.13`, Codex CLI `0.172.0`, agy `1.5.17`. The saved literal Carbon prefix
rule returned `allow`, including `--log-file`; permissions were not changed.

Before LSP startup, the shell baseline returned:

| Command/case | Seconds | Result |
| --- | ---: | --- |
| `rg -n "(theorem\|lemma) hasSum_nat_add_iff'" .lake/packages/mathlib/Mathlib` | 0.245 | Exit 1: no written declaration; not nonexistence. |
| `rg -n -B 2 -A 4 "theorem hasProd_nat_add_iff'" .lake/packages/mathlib/Mathlib/Topology/Algebra/InfiniteSum/NatInt.lean` | 0.003 | Exit 0: lines 227–230, `@[to_additive]`. |
| `lake env lean /tmp/pi-b2-tools-20261125/Replay.lean` | 4.698 | Exit 0: full signatures, goal, applications, root equations and boundaries. |

The disposable semantic fixture said “B2 remains unimplemented” with valid
current-entry links. The existing link checker returned no errors; manual
comparison with `Orbit.lean`, README, the roadmap, blueprint, and current prompt
identified the false status. An initial fixture used a standalone HTML marker;
adding the checker's documented inline prose fixed that fixture format. No
checker behavior changed. The real entry point's stale plan-writing sentence
was also corrected. This is a demonstrated semantic-check use, not automation.

## P2 installation, configuration, and capability states

Both sibling clones were clean at the specified revisions:

- `lean-lsp-mcp`: `7932203d79db213852db215835bd79c943bb99b0`, version `0.33.0`,
  MIT; inspected packaging, supported environment controls, tool registry,
  local-search/index logic, and file-access restrictions.
- `LeanAutoformalizationSkills`: `1837b95b3d5a9fd8d311367603902ad7fe261adf`;
  inspected both complete selected folders, installer, CC BY 4.0 license,
  provenance and third-party MIT/Apache notices. The bundled installer selects
  the whole suite, so it was not run.

A noneditable LSP source snapshot was produced with `git archive` at that commit.
`uv --no-cache tool install /tmp/pi-b2-tools-20261125/lsp-source` failed (exit 2):
creation of the normal user tool directory was denied. One focused fallback used
`uv --no-cache venv /tmp/pi-b2-tools-20261125/lsp-venv`, then
`uv --no-cache pip install --python /tmp/pi-b2-tools-20261125/lsp-venv/bin/python /tmp/pi-b2-tools-20261125/lsp-source`.
Both passed; Python `3.13.2`, 43 resolved packages, including `leanclient 0.13.2`,
`mcp 2.2.0`, and `lean-lsp-mcp 0.33.0`. `lsp-resolved.txt` retains the full freeze
outside the project lock. Source clones were not edited.

| State | Observed outcome |
| --- | --- |
| Installed | **Temporary isolated installation only.** Normal persistent user installation blocked. Launcher: `/tmp/pi-b2-tools-20261125/lsp-venv/bin/lean-lsp-mcp`. |
| Configured | Protocol client environment configured; **actual host configuration blocked**. Supported `codex mcp add pi-b2-lean-lsp ...` exited 1 when persisting user configuration. Existing `node_repl` and `computer-use` entries and config hash unchanged. |
| Protocol tested | Passed the replay below over local stdio against the exact checkout. |
| Available and tested in actual Codex host | **No.** No Lean MCP tools appear in the session tool inventory; terminal MCP calls are not host activation. |

The protocol environment set the explicit checkout root, `LEAN_REPL=false`,
`LEAN_LOG_LEVEL=NONE`, and the supported `LEAN_MCP_DISABLED_TOOLS` list. The
actual `tools/list` response contained exactly `lean_goal`,
`lean_diagnostic_messages`, `lean_hover_info`, `lean_declaration_file`, and
`lean_local_search`. All remote-search, build, code-action, snippet/attempt,
profiling, verification, widget, and other unneeded tools were absent. No REPL,
remote service, source-mutating tool, or additional Lean dependency was enabled.

Setup used one initial installation attempt and one focused temporary-environment
repair; no toolchain repair or upgrade. From recorded setup start through the
final protocol receipt was 142.517 seconds of wall time, below the 45-minute
active setup bound; earlier source-inspection effort was not separately timed. Host configuration denial was recorded without retrying another
configuration path or changing permissions.

## Replay details and measured observations

Temporary root files `B2ToolReplay20261125.lean` and
`B2ToolDiagnostic20261125.lean` were used because the server restricts file tools
to the project/dependency roots. Both were removed after the protocol run.
`Replay.lean` imports `PiDisjunctivity` and `Mathlib.Tactic`; its first checks are
`#check @hasSum_nat_add_iff'`, `#check @pow_sub₀`, and `#check @Nat.succ_sub`.
A complete proof uses `trace_state` followed by
`exact pow_sub₀ (16 : ℝ) (by norm_num) h`, with `h : j ≤ n`. The generated
sum application is:

```lean
example (n : ℕ) :
    HasSum (fun r : ℕ => (16 : ℝ)^n *
      (bbpCoeff (r+(n+1)) / (16 : ℝ)^(r+(n+1))))
      ((16 : ℝ)^n * Real.pi - ∑ j ∈ Finset.range (n+1),
        (16 : ℝ)^n * (bbpCoeff j / (16 : ℝ)^j)) :=
  (hasSum_nat_add_iff' (n+1)).2 (hasSum_bbpCoeff.mul_left ((16 : ℝ)^n))
```

The probe also replays the existing root definition equations and B2 contract
examples from baseline `Test.lean` lines 384–418 and 442–466, plus an explicit
`bbpRecurrence_succ_eq_fract_bbpPartialSum 1` application. Thus recurrence at
zero/one and orbit at zero/one instantiate their actual theorems. No boundary
claim is inferred from simplification that bypasses the theorem.

| Query | Response and interpretation |
| --- | --- |
| `lean_local_search(query="hasSum_nat_add_iff'")` before compiler startup | Empty source result, index `unavailable`; cannot establish absence. |
| Same query after opening the replay | All three trials found the declaration; `sources_searched` includes `symbol_index`, index `warming`. The index was queried, but full readiness/completeness was not established. |
| Hover at replay 6:9, 7:9, 8:9 (one-based) | Full types match local `#check`: additive topological-group `HasSum` split; `pow_sub₀` requires nonzero base and `n ≤ m`; `Nat.succ_sub` requires that same bound and the successor orientation. |
| Declaration query for generated name, context 2 | `NatInt.lean`, lines 226–230, multiplicative theorem with `@[to_additive]`; `source_declaration` field is null, so attribution comes from the returned source text. |
| Goal at replay line 13 | Before: `n j : ℕ`, `h : j ≤ n`, desired power equality; after: no goals. This is an already complete proof. |
| Diagnostic file: `import PiDisjunctivity`, then `example : (0 : ℕ) = 0 := by`, then `exact b2UnknownIdentifier20261125` | All trials report the unknown identifier at 3:9, `success=false`, `partial=false`. Replacing the identifier with `rfl` clears errors, `success=true`, `partial=false`. Shell exits are 1 then 0. No placeholder proof is used. |

Protocol initialization took 0.740 seconds; first compiler diagnostics took
5.158 seconds, separate from installation. After this startup, three trials
used shell/LSP, LSP/shell, shell/LSP order. Each shell trial used five processes
(two searches, replay compilation, bad/fixed diagnostic compilations). Each LSP
trial used eight calls (search, three hovers, declaration, goal, bad/fixed
diagnostics); root replay compilation was established on startup and by shell.

| Trial | Shell seconds | LSP seconds | Correct/useful result |
| --- | ---: | ---: | --- |
| 1 | 10.343 | 4.560 | Both returned the required facts and error/repair outcomes. |
| 2 | 9.747 | 5.182 | Same; LSP hover included about 4.48 seconds of compiler work. |
| 3 | 10.421 | 5.405 | Same; LSP hover included about 4.70 seconds of compiler work. |

These are elapsed times for different interfaces to known cases, not identical
amounts of work or a proving benchmark. The persistent LSP amortizes compiler
work; known answers, imports, caches, and run order affect the observations.
There were no application repairs; each diagnostic has one intentional fix.
Interactive inspection/thinking time and historical productivity were not
measured. The named benefit is generated-declaration discovery without manually
tracing the multiplicative name, plus before/after goals at a source position.
The shell already obtains the same types and checks the applications.

The client exited 0, but its stderr records an asyncio subprocess finalizer
warning, `RuntimeError: Event loop is closed`. Process inventory via `ps` was
host-denied, so descendant cleanup was not independently verified. No process
was killed speculatively. All query responses were inspected, including actual
`is_error` fields and structured diagnostics; none reported a tool error.
This warning is retained, not described as a fully clean shutdown.

There was no task-owned host entry to disable because configuration failed.
After the protocol client exited, the shell fallback replay passed (exit 0).
This tests independence from the protocol client, **not** the still-pending
host-entry disable/restore test. All protected and unrelated hashes matched
at that checkpoint. **Decision: defer LSP adoption**, keep the shell default;
actual host activation, disable/restore behavior, and cleanup remain untested.

## P3 focused skills

The normal selective installer was attempted at the pinned revision into a
permitted temporary destination; system Python failed certificate verification.
No TLS verification was disabled. The already verified clean local clone then
supplied only the two complete selected folders (four original resources each).
Both entrypoints, both UI metadata files, and all four references were inspected.
No sibling clone or existing skill was overwritten.

The temporary adaptation at `skill-package/skills/` under the capture directory
retains complete resources, CC BY license, third-party notices, Apache license,
and explicit source/revision/change notices. It adds the workflow's project
overrides before activation, removes the phrasebook's placeholder advice,
replaces the direct `Aesop` import with `Mathlib.Tactic`, and resolves selected
cross-links locally. Collection and unselected architecture/naming references
are pinned upstream reference-only URLs; architecture/module instructions route
to the project workflow. All remaining local links resolve. No missing companion
is silently installed. `prepare-skills.py` and `skill-package/changes.json`
retain the exact temporary adaptation recipe/list.

Copying the adapted selected folders to the normal user skill directory was
attempted and denied before the first target was created. No selected skill is
installed in either existing user catalog. Manual loading of the temporary
entrypoints/resources is distinct from catalog discovery/activation.

The guided B2 replay used the same full signature checks and compiled unchanged
applications (exit 0, 3.763 seconds). Search guidance directs a second strategy after an empty name
search; proof-pattern guidance classifies the power step as an explicit rewrite
with nonzero/order premises and the index step as natural arithmetic. Those
outputs already existed in the unguided baseline. All guided applications
passed without repairs; there was no reason to refactor B2. Reading eight
upstream resources and resolving unused companion links added setup work.
Incremental productivity benefit was not measured. **Defer both upstream skill
adoptions**: useful reference guidance, but marginal additional benefit on this
replay and blocked persistent installation/discovery. The workflow remains usable.

`lean-lemma-lab` is **rejected as a redundant wrapper**: this replay already
produces its specify/search/probe/check outputs through the workflow. No wrapper
was implemented or installed.

Two original, small project skill candidates are retained at
[pi-argument-critic](../skills/pi-argument-critic/SKILL.md) and
[paper-to-lean-contract](../skills/paper-to-lean-contract/SKILL.md). They route to
existing authoritative documents and return distinct argument/contract reports.
They were manually loaded and exercised in this session, not discovered in the
host skill catalog. **Defer catalog adoption/installation**; retain reviewed
sources for explicit manual use. No independent or blind skill evaluation is
claimed, and no additional agent/model was launched for these tests.

### Critic: one evaluation and one focused revision/retest

| Supplied argument | Actual initial and retest output |
| --- | --- |
| Almost every real has a dense orbit, hence π does. | Reject inference: missing membership of the fixed π orbit in the full-measure set. |
| Finite scan covers all words up to length six, hence all words. | Reject inference: arbitrary lengths and unbounded occurrence quantifiers remain. |
| Exact orbit identity plus shrinking error supplies visits. | Reject inference: B4's late visits are still required; generic `u=r=0` misses `(1/4,1/2)` despite zero error. This is not a counterexample to π disjunctivity. |
| Assume disjunctivity, derive late occurrences, then claim an independent proof. | Flag circularity: `isDisjunctive_occurs_ge` consumes the conclusion. |
| B2 identifies `t_n(π)` with `fract(y_n+R_n)`. | Flag lost offset: the actual theorem uses `y_(n+1)`, including `y_1` at orbit index zero. |
| Every word occurs, hence its limiting frequency is `16^(-k)`. | Flag unsupported strengthening to normality. |
| B4 with vanishing error **and** arbitrarily late open-interval visits. | Accept conditional result; retain both premises, `0 ≤ a < b ≤ 1`, `∀ N, ∃ n ≥ N`, and no global range assumption. |
| P3 with open-interval visitation, concluding all half-open cells. | Accept conditional result; retain visitation, `∀ k m`, `m < 16^k`, and length zero. |

The initial pass caught all six seeded errors and preserved both controls.
Inspection identified installation-relative document links as a portability
problem. The focused revision resolves project paths from the checkout root;
the retest verified all paths and repeated the eight verdicts. No case remained
failing. `quick_validate.py` passed. Known, explicitly seeded cases and the
same author/evaluator limit the evidence; these counts are not a detection rate.

### Source contract: one evaluation and one focused revision/retest

Inspected the existing author-hosted BBP PDF, Theorem 1, PDF page 3,
equations (1.2)–(1.4). SHA-256
`ee6c1f95f17ba7a7b9dcb09005c4f1d2d6a73d142694ac9af695811fa52ac9a2`
matches the [B1 source assessment](b1-source-proof-review.md). Existing PDFKit
extracted text and rendered the page for visual inspection; no PDF package was
installed. Formula (1.2) starts at zero; periodic-numerator formula (1.3) starts
at one and is not the local index convention.

The output maps (1.2) to
`HasSum (fun j : ℕ => bbpCoeff j / (16 : ℝ)^j) Real.pi`, with real division,
positive `8*j+d` for `d=1,4,5,6`, and positive `16^j`, including zero index.
It separates the paper's `[0,1/√2]` integral/substitution and abbreviated partial
fractions from the local `[0,1]` reconstruction: ratio `x^8/16 ≤ 1/16 < 1`,
summable majorant `8*(1/16)^j`, measurability, integrability, justified interchange,
positive denominators/log arguments, derivative, FTC, and endpoint evaluation.
These are discharged B1 proof obligations, not extra assumptions on its public
theorem. A `tsum` equality alone would not express convergence. Neither the
identity nor its discovery by PSLQ supplies visitation or normality.

The focused revision fixes path resolution and explicitly separates dated
assessment status from current checked declarations. Retest retained the source
locations, full `HasSum` type, all side conditions, and downstream limits;
`SkillContracts.lean` compiled the full B1/B4/P3 types (exit 0). `quick_validate.py`
passed. No external Lean development was rebuilt or copied. Distinct useful
output: a source-to-contract report that keeps proof obligations separate from
public premises; general benefit on fresh sources remains unmeasured.

## P4 decisions

- **Loogle/LeanSearch:** defer activation. Local index/source/compiler paths
  resolved the named case. A later authorized gap trial is limited to three
  public queries, with locally compiled hits and no upload/account/paid service.
- **SageMath:** defer installation. No named arithmetic experiment needs it;
  use existing exact rational tools first, with bounds and error enclosures.
- **Elaboration skill:** defer until profiling identifies a need and a reviewed
  no-placeholder adaptation exists. No companion suite or performance claim adopted.
- **Full frameworks/parallel orchestration:** reject for this endpoint; no new
  dependency graph, status ledger, proof service, or agent orchestration.

## Activation continuation and rollback

No existing host settings were changed; no persistent installation succeeded.
Do not change host permissions. In a user terminal with normal write access,
from the verified checkout, the bounded LSP continuation is:

```sh
# First inspect the target installation/entry for conflicts.
uv --no-cache tool list
codex mcp list
b2_source_dir="$(mktemp -d /tmp/pi-b2-lsp-source.XXXXXX)"
git -C ../lean-lsp-mcp archive --format=tar --output="$b2_source_dir/source.tar" 7932203d79db213852db215835bd79c943bb99b0
mkdir "$b2_source_dir/src"
tar -xf "$b2_source_dir/source.tar" -C "$b2_source_dir/src"
uv --no-cache tool install "$b2_source_dir/src"
codex mcp add pi-b2-lean-lsp \
  --env "LEAN_PROJECT_PATH=$PWD" --env LEAN_REPL=false --env LEAN_LOG_LEVEL=NONE \
  --env LEAN_MCP_DISABLED_TOOLS=lean_build,lean_code_actions,lean_completions,lean_file_outline,lean_get_widget_source,lean_get_widgets,lean_hammer_premise,lean_leanfinder,lean_leansearch,lean_loogle,lean_minimal_hypotheses,lean_multi_attempt,lean_profile_proof,lean_references,lean_run_code,lean_term_goal,lean_verify \
  -- "$HOME/.local/bin/lean-lsp-mcp"
```

First verify no conflicting installation/entry appeared. Preserve existing MCP
entries; inspect with `codex mcp get pi-b2-lean-lsp`. Restart/reload the actual
host as supported, then verify its exposed tool list and call the five local
tools on the replay above. Disable **only** that entry (`enabled=false`), rerun
the shell replay, then restore only that setting if adoption is earned. Verify
shutdown/descendant cleanup in that permitted host. Until these pass, adoption
remains deferred; a successful CLI configuration alone is insufficient.

For the two original candidates, a permitted user can selectively link the
complete `skills/<name>` folders from this checkout into the host's supported
user skill directory, after conflict checks. For upstream candidates, preserve
the complete adapted temporary package and notices if considering later use;
if it expires, reapply the documented adaptations to the pinned clean source
and recheck all resources before installation. Their marginal-benefit decision
should be revisited on a named fresh obligation, not by installing the suite.
Skills copied into a catalog require a subsequent host discovery/use check;
this session does not claim that transition.

Rollback of a future task-owned LSP install: `codex mcp remove pi-b2-lean-lsp`,
then `uv tool uninstall lean-lsp-mcp`, after confirming they are the task-owned
entry/version. Remove only newly created skill folders/symlinks for the named
candidates after verifying their targets; preserve every pre-existing skill.
For this session, rollback is removal of the task-owned temporary LSP environment
and skill package after retaining desired evidence; there is no config delta to
restore. Never remove sibling clones or the existing project environment.

## Evidence retention

Raw replay code, protocol query/response JSON, tool schemas, dependency freeze,
source snapshot, prepared skill adaptations, initial/retest inputs and outputs,
PDF rendering, and baseline/protected/unrelated hashes are under
`/tmp/pi-b2-tools-20261125/`. They are temporary, not durable archives. The records
above retain commands, cases, outcomes, limits, and decisions; the baseline Git
commit anchors all protected tracked content. Machine-specific configuration
was not added to portable repository files. No remote CI or fresh-host test is
claimed. The handoff owns final validation and any remaining activation work.

<details>
<summary>Resolved temporary Python environment (observed freeze, not the project lock)</summary>

```text
annotated-doc==0.0.7
annotated-types==0.8.0
anyio==4.16.0
attrs==26.1.0
certifi==2026.11.20
cffi==2.1.1
click==8.5.1
cryptography==50.0.2
h11==0.16.0
httpcore2==2.16.2
httpx2==2.16.2
idna==3.20
jsonschema==4.26.0
jsonschema-specifications==2025.9.1
lean-lsp-mcp==0.33.0  # built from the pinned source revision above
leanclient==0.13.2
markdown-it-py==4.3.0
mcp==2.2.0
mcp-types==2.2.0
mdurl==0.1.2
opentelemetry-api==1.45.2
orjson==3.13.0
psutil==7.2.2
pycparser==3.12
pydantic==2.14.4
pydantic-core==2.50.5
pygments==2.21.0
pyjwt==2.15.1
python-dotenv==1.2.4
python-multipart==0.0.34
referencing==0.37.0
rich==15.0.0
rpds-py==2026.9.1
shellingham==1.5.4
sse-starlette==3.7.1
starlette==1.10.0
tqdm==4.70.1
truststore==0.10.5
typer==0.29.2
typing-extensions==4.16.0
typing-inspection==0.4.5
uvicorn==0.54.0
watchfiles==1.3.0
```

</details>
