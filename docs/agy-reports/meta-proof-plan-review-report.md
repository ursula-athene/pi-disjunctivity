# Independent Review: `docs/meta-proof-plan.md` and Alignment with `docs/proof-plan.md`

- **Review date:** 2026-11-24
- **Repository audited:** [`pi-disjunctivity/`](../../) (branch `feature/attempt-02`, HEAD commit `6be3b0e6ce28ed9463bdb86a4ffd465ef8f5b09e`)
- **Toolchain verified:** Lean `4.37.0-rc1` (`0b77e12952ad39077d80d8bd6b66d601f225c321`) + Mathlib `v4.37.0-rc1` (`31ce06eaadf4a200c0e1407c5f10953cf606b8f8`)
- **Scope:** Read-only independent review of [`docs/meta-proof-plan.md`](../meta-proof-plan.md), [`docs/proof-plan.md`](../proof-plan.md), [`docs/proof-workflow.md`](../proof-workflow.md), [`docs/proof-blueprint.md`](../proof-blueprint.md), [`docs/research-log.md`](../research-log.md), governance/formulation docs, and the checked Lean implementation through commit `6be3b0e`.

---

## Bottom Line Up Front (BLUF)

- **Overall verdict:** The meta-plan ([`docs/meta-proof-plan.md`](../meta-proof-plan.md)) and its executed workflow artifacts ([`docs/proof-workflow.md`](../proof-workflow.md), [`docs/proof-blueprint.md`](../proof-blueprint.md), [`docs/research-log.md`](../research-log.md)) establish a **disciplined, proportionate, and mathematically honest** research-and-formalization loop around [`docs/proof-plan.md`](../proof-plan.md), which is consistently maintained as the sole mathematical roadmap.
- **Execution & trust verification:** Commit `6be3b0e` genuinely substantiates completion of the meta-plan and the bounded Step 2 interval-hitting pilot. [`OrbitCriteria.lean`](../../PiDisjunctivity/OrbitCriteria.lean) proves the exact nonnegative equivalence `isDisjunctive_iff_hitsHexadecimalIntervals` and conditional reduction `piHexadecimalDisjunctivity_of_hitsHexadecimalIntervals`, exported publicly and audited in [`Test.lean`](../../Test.lean) (17 theorems total, zero warnings across `6655` Lake build jobs, Mathlib as sole direct dependency, pins unchanged at `v4.37.0-rc1`, and axioms strictly `[propext, Classical.choice, Quot.sound]`).
- **Mathematical boundaries:** No circular reasoning, hidden assumptions, or conflation of conditional infrastructure with solving `PiHexadecimalDisjunctivity` was found. Almost-everywhere results, finite digit checks, BBP digit extraction, and vanishing tails are explicitly separated from the open universal-visitation problem (`V`). All candidate formulas, index shifts (`y_{n+1} = fract(S_n)`, `t_n(π) = fract(y_{n+1} + R_n)`), and tail constants (`|A(j)| ≤ 8/(8j+1)`, `|R_n| ≤ 8/(15*(8n+9))`) in `proof-plan.md` Steps 3–4 were independently checked by hand and are mathematically sound.
- **Defects found (none invalidate existing Lean proofs):**
  1. **Specification defect in Next Bounded Task (Medium):** Hypothesis 1 (`∀ n, 0 ≤ u n ∧ u n < 1`) in the Step 4 interior-margin transfer specification (`proof-plan.md:230`, `proof-blueprint.md:76`) is **mathematically redundant**—assumption 3 already places the chosen late visit strictly inside `(0, 1)`—so naming that binder triggers Lean's `unusedVariables` warning while weakening the theorem and conflicting with `proof-plan.md`'s proof-minimality rule.
  2. **Missing blueprint node (Low–Medium):** `proof-blueprint.md:76-78` has no distinct node for the general open-interval-to-hexadecimal-cell conversion lemma (bundling it only into the prose of the **Blocked** unconditional π node `Hπ`), leaving nowhere clean to mark that deliverable **Checked** after the next task completes.
  3. **Minor stale status prose (Low):** `docs/foundations-plan.md:15-16` still states in the present tense that the root audit covers 15 theorems (now 17), and `README.md:78-80` omits the interval-hitting reduction from its default-build summary sentence.
- **Verdict on Next Bounded Task:** **Ready with specified corrections.** The mathematical idea, quantifier order, signed-error margin (`±δ`), fractional-part boundary avoidance (`a = 0`, `b = 1`), and `k = 0` cell coverage are completely sound and well-sized (~30–45 lines of Lean), provided Hypothesis 1 (`0 ≤ u n < 1`) is dropped (or explicitly marked optional), a separate cell-conversion node is added to `proof-blueprint.md`, and the open-interval predicate spelling is harmonized.

---

## Concise Overall Assessment

The central risk when applying AI theorem-proving workflows to an open conjecture is confusing formalization velocity or conditional reductions with mathematical progress on the unsolved core. Across [`AGENTS.md`](../../AGENTS.md), [`docs/meta-proof-plan.md`](../meta-proof-plan.md), [`docs/proof-plan.md`](../proof-plan.md), [`docs/proof-workflow.md`](../proof-workflow.md), [`docs/proof-blueprint.md`](../proof-blueprint.md), and [`docs/research-log.md`](../research-log.md), this repository handles that boundary unusually well:

1. **Clear architectural division:** `proof-plan.md` owns the mathematical strategy (Steps 1–7); `proof-blueprint.md` indexes exact node statements, hypotheses, and statuses as an acyclic DAG; `proof-workflow.md` defines the repeatable local compiler-and-audit loop; and `research-log.md` records dated attempts, commands, and criticisms.
2. **Sound source adaptation:** External agent papers (`AxProverBase`, `mini-Lean-agent`, `Goedel-Architect`, `Aletheia`) and tooling repositories (`lean4-skills`, `lean-lsp-mcp`) are accurately represented without overclaiming benchmark transfer, and incompatible dependencies (`LeanArchitect`, `sorry_using`, `Comparator`, `leanprover-community/repl`) were rightly excluded to preserve the Mathlib-only and zero-`sorry` trust policy.
3. **Targeted maintenance needs:** A few targeted adjustments—removing an unneeded hypothesis in `B4`, adding a blueprint node for open-interval-to-cell conversion, reconciling `proof-plan.md`'s `# Viewpoint` commit/testing instructions with `proof-workflow.md`, and documenting an `elan` working-directory toolchain trap encountered during this review—will tighten the system without restructuring it.

---

## Question-by-Question Evaluation

### 1. Purpose and Alignment

- **Roadmap authority:** `proof-plan.md` is unambiguously established as the sole mathematical roadmap across `AGENTS.md:40`, `meta-proof-plan.md:17-18,107`, `proof-workflow.md:4`, `proof-blueprint.md:4`, and `research-log.md:4`.
- **Usefulness of the two-loop design:** Separating the *mathematical research loop* (specify, sketch, criticize, classify missing math vs. false claim) from the *Lean formalization loop* (search, scratch compile, kernel check, axiom guard) directly matches the mixed nature of `proof-plan.md`, where Steps 2–4 are established mathematics and Step 5 (`V`) is an open research problem.
- **Identified alignment frictions (detailed in Findings below):**
  - `proof-blueprint.md` lacks a separate node for the general open-interval-to-cell conversion lemma (`Finding D2`).
  - `docs/foundations-plan.md:15-16` and `README.md:78-80` have minor stale status text from before commit `6be3b0e` (`Finding D3`).
  - `proof-plan.md:67-71` (`# Viewpoint`) mandates an unconditional two-commit sequence per step and thorough per-block testing that conflicts with `meta-proof-plan.md:188` ("Commit or publish only within the user's instructions") and diverges from `proof-workflow.md` (`Finding R1`).
  - `proof-plan.md:364-370` (`Suggested implementation order`) reuses the label `Step Number` (`1–5`) alongside the main roadmap's `Steps 1–7`, and `Next bounded task` is now duplicated across three files (`meta-proof-plan.md`, `proof-plan.md`, `proof-blueprint.md`) (`Finding R1`).

### 2. Source-Method Adaptation

External sources cited in `meta-proof-plan.md:79-83`, `proof-workflow.md:18-23`, and `proof-plan.md:156,204,292,298` were checked independently (see [Verification Limitations](#material-verification-limitations-and-commands-run)):

| Source | Accuracy of representation & adaptation assessment |
| --- | --- |
| **Requena et al., *A Minimal Agent for Automated Theorem Proving* (`arXiv:2602.24273v1`, §3, §4.1)** | **Accurate.** §3 defines `AxProverBase` (Proposer, Compiler + LLM Reviewer, lab-notebook Memory, Search tools); §4.1's bottom-up ablations identify iterative compiler feedback and concise failure memory as the primary gains. `proof-workflow.md:18` adopts those core elements while explicitly refusing to extrapolate competition-benchmark ablations to an open conjecture or individual prompt lines. |
| **Ortega et al., *mini-Lean-agent* (`arXiv:2610.17331v1`, §2)** | **Accurate.** §2 pairs a minimal bash-only Lean coding harness with an isolated clean-environment evaluator using LeanFRO's `Comparator`. `proof-workflow.md:19` adopts bash search, scratch experiments, and pinned compilation, omits `Comparator`, and honestly distinguishes local `Test.lean` + diff review from an isolated clean-room evaluator. Adding an explicit read-only `git diff` command to `proof-workflow.md` (`Finding R2`) would further harden local statement preservation. |
| **Chung et al., *Goedel-Architect* (`arXiv:2606.06468v1`, §2; repo `goedel-architect`)** | **Accurate and well adapted.** Upstream uses `LeanArchitect`, `sorry_using` DAG macros, parallel provers, and global refinement distinguishing `statement_wrong` from `proof_too_hard`. Replacing `LeanArchitect` + `sorry_using` with `proof-blueprint.md` preserves global dependency tracking and failure triage without violating the Mathlib-only or zero-`sorry` policies. |
| **Feng et al., *Towards Autonomous Mathematics Research* (`Aletheia`, `arXiv:2602.10177v2`, §2.2–2.3)** | **Represented honestly; context-isolation caveat applies to Step 5.** §2.2 decouples the Verifier from the Generator's intermediate reasoning trace to prevent self-justifying bluffs; §2.3 grounds external citations via tool search. `proof-workflow.md:21` candidly notes that sequential criticism in one session is *not* a fresh context. That tradeoff is benign for kernel-checked lemmas in Steps 2–4, but fresh-session review should be required before formalizing any Step 5 natural-language research claim (`Finding R3`). |
| **`cameronfreer/lean4-skills` (`SKILL.md`)** | **Accurate, with one omitted local tactic practice.** Extracting search-before-prove, contract preservation, incremental builds, and blocked-goal triage while omitting slash-command suites and helper scripts is proportionate. However, `proof-workflow.md:47-54` relies only on `rg` text search and omits built-in elaborator search (`exact?`, `apply?`, `rw?`) in disposable `/tmp` scratch files (`Finding R3`). |
| **`oOo0oOo/lean-lsp-mcp` (`README.md`)** | **Accurate and policy-aware.** Upstream provides LSP goal/diagnostic tools and an optional `--repl` fast path requiring `leanprover-community/repl` in `lakefile.toml`. `proof-workflow.md:23` correctly identifies that adding `repl` would violate the Mathlib-only direct-dependency rule and keeps shell compilation + `trace_state` as the zero-dependency baseline. |
| **BBP (1997), Bailey (`bbp-alg.pdf` §3), Bailey–Crandall (2001), Lagarias (`math/0101055` §§3–4)** | **Accurate.** BBP Theorem 1, §3 modular reduction $16^{n-j} \bmod (8j+d)$, Bailey–Crandall Hypothesis A (uniform distribution vs. finite attractor), and Lagarias Theorem 4.1 (Weak Dichotomy $\implies$ rational or digit-dense; Strong Dichotomy $\implies$ rational or normal) are all represented faithfully with conditional hypotheses kept explicit. |

### 3. Execution Evidence

Direct inspection of the Lean declarations and independent compilation confirm that the claimed Step 2 pilot and meta-plan execution are substantiated by checked mathematical content, not merely status labels:

- **[`PiDisjunctivity/OrbitCriteria.lean`](../../PiDisjunctivity/OrbitCriteria.lean) (`L19-32`):**
  `isDisjunctive_iff_hitsHexadecimalIntervals` proves, for all `x : ℝ` with `hx : 0 ≤ x`:
  ```lean
  IsDisjunctive 16 x ↔
    ∀ (k m : ℕ), m < 16 ^ k → ∃ n : ℕ,
      Int.fract ((16 : ℝ) ^ n * x) ∈
        Set.Ico ((m : ℝ) / (16 : ℝ) ^ k) (((m : ℝ) + 1) / (16 : ℝ) ^ k)
  ```
  - *Domain:* `0 ≤ x` is necessary and sufficient for `baseDigit` (`Nat.floor`) to match positional digits; negative reals make `IsDisjunctive 16 x` false while `Int.fract` orbits remain nontrivial.
  - *Leading zeros and empty word:* Independent natural quantification over `(k m : ℕ)` with `m < 16 ^ k` preserves word length (distinguishing `k = 1, m = 10` from `k = 3, m = 10`) and includes `k = 0` (`m = 0`, `[0, 1)`).
  - *Contiguity and boundaries:* `∃ n` sits inside `∀ k m`, requiring a single offset `n` for the entire length-`k` block; `Set.Ico` includes the left endpoint and excludes `(m + 1) / 16^k` (including `1` at `m = 16^k - 1`).
- **[`PiDisjunctivity/OrbitCriteria.lean`](../../PiDisjunctivity/OrbitCriteria.lean) (`L35-40`):**
  `piHexadecimalDisjunctivity_of_hitsHexadecimalIntervals` specializes `.mpr` to `Real.pi` via `Real.pi_pos.le`, keeping the full cell-hitting predicate as an explicit hypothesis `h` and concluding the unchanged target `PiHexadecimalDisjunctivity`.
- **Exports and guarded audits:** [`PiDisjunctivity.lean:15`](../../PiDisjunctivity.lean#L15) publicly exports `PiDisjunctivity.OrbitCriteria`. [`Test.lean:13-21,101-114,209-221`](../../Test.lean#L101-L114) verifies the unfolded conjecture definitions (`Iff.rfl`), the exact exported types of all 17 theorems through `import PiDisjunctivity`, and `#guard_msgs`-guarded `#print axioms` outputs (`[propext, Classical.choice, Quot.sound]`).

### 4. Mathematical Boundaries

The dependency graph and narrative maintain strict mathematical hygiene throughout:

- **Explicit open node & acyclicity:** `proof-blueprint.md:77,85-97` isolates `V` (late open-interval visitation of `y_{n+1}`) as an **Open mathematical gap** and explicitly forbids back-edges from `T` (`PiHexadecimalDisjunctivity`) or `F4` (`isDisjunctive_occurs_ge`) to `V` or `Hπ`.
- **Rejection of invalid shortcuts:** Almost-everywhere normality/density, finite prefix verification (`243F` in `Examples.lean:21-38`), BBP spigot extraction (`metasecdev/math-proofs`), rational irrationality/transcendence of $\pi$ alone, and vanishing perturbations (`A(n) → 0`, `R_n → 0`) are consistently excluded as standalone proofs of visitation (`meta-proof-plan.md:153-158`, `proof-plan.md:46-52,302-309`, `proof-blueprint.md:101-106`).
- **Independent verification of Steps 3–4 formulas:**
  - *BBP summand and integral (`proof-plan.md:143,149`):* $A(j) = \frac{4}{8j+1} - \frac{2}{8j+4} - \frac{1}{8j+5} - \frac{1}{8j+6}$ sums as $\sum_{j=0}^\infty A(j)/16^j = \pi$.
  - *Series split and off-by-one recurrence indexing (`proof-plan.md:175-190`, `proof-blueprint.md:59-64,74`):* With $S_n = \sum_{j=0}^n 16^{n-j} A(j)$, $y_0 = 0$, and $y_{n+1} = \operatorname{fract}(16 y_n + A(n))$, induction gives $y_1 = \operatorname{fract}(A(0)) = \operatorname{fract}(S_0)$ and $y_{n+2} = \operatorname{fract}(16 y_{n+1} + A(n+1)) = \operatorname{fract}(16 S_n + A(n+1)) = \operatorname{fract}(S_{n+1})$. Since $S_n - y_{n+1} \in \mathbb{Z}$, $t_n(\pi) = \operatorname{fract}(S_n + R_n) = \operatorname{fract}(y_{n+1} + R_n)$. Instantiating `B4` with $u_n := y_{n+1}$ and $r_n := R_n$ aligns with `V` without any index shift error.
  - *Candidate tail bounds (`proof-plan.md:197-198`, `proof-blueprint.md:75`):* $|A(j)| \le \frac{4+2+1+1}{8j+1} = \frac{8}{8j+1}$, and for $n \ge 0$, $|R_n| \le \sum_{r=1}^\infty \frac{8}{(8(n+r)+1)16^r} \le \frac{8}{8n+9}\sum_{r=1}^\infty 16^{-r} = \frac{8}{15(8n+9)} \to 0$. Both bounds hold for all $j, n \in \mathbb{N}$.

### 5. Next Bounded Task Assessment

See [Verdict on the Next Bounded Task](#verdict-on-the-next-bounded-task) below for the complete mathematical and boundary check (`r_n` of either sign, `Int.fract` discontinuities at `0` and `1`, `a = 0`, `b = 1`, and `k = 0`).

### 6. Practicality and Trust

- **Policy & dependency compliance:** Verified clean. `lean-toolchain` pins `leanprover/lean4:v4.37.0-rc1`; `lakefile.toml` requires only `mathlib` at `v4.37.0-rc1` with `weak.linter.mathlibStandardSet = true` and MIT SPDX header checks; all 9 `.lake/packages/*` checkouts match `lake-manifest.json` (1 direct Mathlib + 8 inherited packages matching Mathlib's own manifest) with clean worktrees; all explicit source imports across all 10 `.lean` files come solely from `Mathlib` or `PiDisjunctivity`; zero forbidden tokens (`sorry`, `admit`, `axiom`, `native_decide`, `implemented_by`, `extern`, `unsafe`) appear anywhere in project Lean code.
- **Feedback loop proportionality:** Using Lake, `lean`, `trace_state` in `/tmp` scratch files, `rg`, and `Test.lean` without installing MCP daemons or multi-agent orchestrators is well-proportioned to the codebase size and current mathematical needs.
- **Operational gap discovered during verification:** Running `lake --dir pi-disjunctivity ...` from the parent workspace directory causes `elan` to pick the host's default Lean version (`4.36.0`) instead of `pi-disjunctivity/lean-toolchain` (`v4.37.0-rc1`), failing `Test.lean` with `incompatible header` and triggering a cache-clobbering rebuild under the wrong toolchain unless `cwd` is `pi-disjunctivity/` or `+leanprover/lean4:v4.37.0-rc1` is passed (`Finding R2`).

---

## Findings (Ordered by Severity and Category)

### I. Definite Errors and Specification Defects

#### D1. [Medium] Redundant hypothesis `∀ n, 0 ≤ u n ∧ u n < 1` in the Step 4 interior-margin transfer specification (`B4`)

- **References:** [`docs/proof-plan.md:228-234`](../proof-plan.md#L228-L234), [`docs/proof-blueprint.md:76`](../proof-blueprint.md#L76); interacts with [`lakefile.toml:10`](../../lakefile.toml#L10), [`AGENTS.md:35-36`](../../AGENTS.md#L35-L36), and [`docs/proof-plan.md:69-70,259-260`](../proof-plan.md#L69-L70).
- **Supporting evidence:**
  `proof-plan.md:228-234` and `proof-blueprint.md:76` specify three hypotheses on `u r : ℕ → ℝ`:
  1. `∀ n, 0 ≤ u n ∧ u n < 1`
  2. `Filter.Tendsto r Filter.atTop (nhds 0)`
  3. `∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 → ∀ N : ℕ, ∃ n ≥ N, a < u n ∧ u n < b`

  Given `0 ≤ a < b ≤ 1`, setting $\delta = (b - a)/4 > 0$, $a' = a + \delta$, and $b' = b - \delta$ gives $0 \le a < a' < b' < b \le 1$. Choosing $N$ from hypothesis 2 so that $\forall n \ge N, |r_n| < \delta$, and then choosing $n \ge N$ from hypothesis 3 with $a' < u_n < b'$, already yields $0 < a' < u_n < b' < 1$ and $0 \le a < u_n + r_n < b \le 1$, whence `Int.fract (u n + r n) = u n + r n` (`Int.fract_eq_self.mpr`). Hypothesis 1 (`∀ n, 0 ≤ u n ∧ u n < 1`) is **never used** at any point in the proof.
- **Consequences:**
  1. In Lean 4 with standard linters enabled (`AGENTS.md:36`), a named binder `(hu : ∀ n, 0 ≤ u n ∧ u n < 1)` triggers an `unusedVariables` compiler warning unless suppressed or artificially referenced.
  2. An agent strictly following `proof-plan.md:259-260` ("without weakening the statements" / exact specification adherence) faces an unnecessary conflict with `proof-plan.md:69-70` ("Remove unnecessary pieces that don't matter to the proof's line of reasoning") and clean-build linter rules.
  3. Retaining hypothesis 1 forces callers (and blueprint node `B2` at `proof-blueprint.md:74`) to supply `∀ n, 0 ≤ u n < 1` even though `B4` holds unconditionally without it (strengthening the theorem).
- **Proposed correction:**
  Remove assumption `1. ∀ n, 0 ≤ u n ∧ u n < 1` from `docs/proof-plan.md:230` and node `B4` in `docs/proof-blueprint.md:76` (noting in prose that `u_n = y_{n+1}` happens to lie in `[0, 1)`, though the transfer theorem itself needs only assumptions 2 and 3).

#### D2. [Low–Medium] Missing blueprint node for the general open-interval-to-hexadecimal-cell conversion lemma

- **References:** [`docs/proof-blueprint.md:76-78,85-93,108-111`](../proof-blueprint.md#L76-L78); compare [`docs/proof-plan.md:248-257`](../proof-plan.md#L248-L257) and [`docs/meta-proof-plan.md:13-19`](../meta-proof-plan.md#L13-L19).
- **Supporting evidence:**
  Both `meta-proof-plan.md:13-17` and `proof-plan.md:248-257` require the next bounded task to prove and audit **two** general lemmas: (1) interior-margin transfer (`B4`) and (2) elementary conversion from open-interval visitation of `t : ℕ → ℝ` to hexadecimal-cell visitation `∀ k m, m < 16^k → ∃ n, t n ∈ [m/16^k, (m+1)/16^k)`. In `proof-blueprint.md`, however, `B4` (`L76`) states only the open-interval transfer, while the cell-interior conversion is embedded inside the dependencies prose of `Hπ` (`L78`), whose claim is the unconditional π target `H(Real.pi)` (status: **Blocked**).
- **Consequences:**
  When the next bounded task succeeds, `B4` transitions to **Checked**, `Hπ` must stay **Blocked** (since `B1`, `B2`, `B3`, and `V` remain unproved), and the second newly audited Lean theorem in `OrbitCriteria.lean` has no corresponding **Checked** node in `proof-blueprint.md` or its ASCII dependency graph (`L85-93`).
- **Proposed correction:**
  Add an explicit general node (e.g., `P3` or `B5: open-interval to cell conversion`, for arbitrary `t : ℕ → ℝ`) to `docs/proof-blueprint.md` between `B4` and `Hπ`, and route `B2 + B3 + B4 + V + B5 ──> Hπ` in the dependency diagram.

#### D3. [Low] Stale theorem count in `docs/foundations-plan.md` and incomplete default-build summary in `README.md`

- **References:** [`docs/foundations-plan.md:15-16`](../foundations-plan.md#L15-L16), [`README.md:78-80`](../../README.md#L78-L80); compare [`Test.lean:101-114,209-221`](../../Test.lean#L101-L114) and [`docs/research-log.md:151`](../research-log.md#L151).
- **Supporting evidence:**
  `docs/foundations-plan.md:15-16` states in the present tense: *"the current root audit covers fifteen theorems including these additions."* Commit `6be3b0e` expanded `Test.lean` to **17** audited theorems and reconciled the count in `README.md:152`, `problem-formulation.md:23,465`, `dependencies-and-trust.md:49`, `proof-plan.md:92`, and `proof-blueprint.md:50`, but missed `foundations-plan.md:15-16`. Similarly, `README.md:78-80` lists what `lake build` checks by default without mentioning the Step 2 interval-hitting reduction now imported in `PiDisjunctivity.lean:15`.
- **Consequences:**
  Minor factual drift across status summaries for new sessions reading the repository documentation.
- **Proposed correction:**
  Update `docs/foundations-plan.md:15-16` to say either *"covered fifteen theorems at follow-up completion (seventeen after the Step 2 interval pilot)"* or *"covers seventeen theorems"*, and add *"the interval-hitting reduction"* to `README.md:78-80`.

---

### II. Targeted Recommendations

#### R1. [Medium] Reconcile `# Viewpoint` workflow rules, step numbering, and triplicate next-task tracking across planning docs

- **References:** [`docs/proof-plan.md:67-71,222-262,364-370`](../proof-plan.md#L67-L71), [`docs/meta-proof-plan.md:11-25,188`](../meta-proof-plan.md#L11-L25), [`docs/proof-workflow.md:76-82`](../proof-workflow.md#L76-L82), [`docs/proof-blueprint.md:108-112`](../proof-blueprint.md#L108-L112).
- **Evidence & rationale:**
  1. `proof-plan.md:69-70` (`# Viewpoint`, also formatted as a second H1 heading) instructs agents to commit twice per milestone (*"commit code and documentation, then go through the proof... Remove unnecessary pieces... Commit the results"*), contradicting `meta-proof-plan.md:188` (*"Commit or publish only within the user's instructions"*) and `proof-workflow.md:76-82` (which simplifies before validation without auto-committing).
  2. `proof-plan.md:364` labels its 5-row implementation table `Step Number` (`1–5`), colliding with the main roadmap's `Steps 1–7` (already requiring manual disambiguation in `research-log.md:16-18`).
  3. `Next bounded task` is currently maintained in three files (`meta-proof-plan.md`, `proof-plan.md`, `proof-blueprint.md`), even though `AGENTS.md:40-43` directs ongoing sessions to `proof-plan.md`, `proof-workflow.md`, `proof-blueprint.md`, and `research-log.md`.
- **Proposed correction:**
  Demote `# Viewpoint` to `## Viewpoint` in `proof-plan.md:67`, perform proof-minimality cleanup *before* the final check/commit (deferring commit authorization to user instructions and `proof-workflow.md`), rename `Step Number` in `proof-plan.md:364` to `Milestone` (`M1–M5`), and keep `proof-plan.md` + `proof-blueprint.md` as the sole live locations for the next bounded task (leaving `meta-proof-plan.md`'s header as a static completion pointer to `proof-workflow.md` and `proof-plan.md`).

#### R2. [Medium] Guard against the parent-workspace `elan` CWD toolchain trap and codify preservation diff checks in `proof-workflow.md`

- **References:** [`docs/proof-workflow.md:32-41,78-80`](../proof-workflow.md#L32-L41); compare [`docs/session-prompts.md:26-27`](../session-prompts.md#L26-L27).
- **Evidence & rationale:**
  1. In workspaces where the repo is a subdirectory (`./pi-disjunctivity/` alongside `./deepmind-formal-conjectures/`), invoking `lake --dir pi-disjunctivity ...` from the parent directory causes `elan` to select the parent CWD's default toolchain (`Lean 4.36.0`) rather than `pi-disjunctivity/lean-toolchain` (`v4.37.0-rc1`). During this review, that exact invocation failed `Test.lean` with `incompatible header` and caused `lake build` to begin overwriting `.lake` precompiled `v4.37.0-rc1` artifacts under `4.36.0` (requiring cancellation and a `v4.37.0-rc1` rebuild to restore `.lake`).
  2. `proof-workflow.md:78-80` relies on prose instructions to check definition/pin preservation, whereas `research-log.md:148-150` ran explicit Git comparisons as its local counterpart to `mini-Lean-agent`'s `Comparator`.
- **Proposed correction:**
  1. Add a one-line warning in `proof-workflow.md:32-41`: verify `pwd` contains `lean-toolchain` (or pass `+leanprover/lean4:v4.37.0-rc1` to `lake`) and treat any `lean --version` other than `4.37.0-rc1` as an immediate stop before running `lake build`.
  2. Add an explicit read-only check to `proof-workflow.md:78`:
     ```sh
     git diff HEAD -- lean-toolchain lakefile.toml lake-manifest.json \
       PiDisjunctivity/Definitions.lean PiDisjunctivity/Conjectures.lean
     ```

#### R3. [Low–Medium] Add built-in scratch tactic search (`exact?`, `apply?`, `rw?`) and fresh-context Step 5 review guidance to `proof-workflow.md`

- **References:** [`docs/proof-workflow.md:21-22,47-70`](../proof-workflow.md#L47-L70), [`docs/meta-proof-plan.md:81-82,136-142`](../meta-proof-plan.md#L136-L142).
- **Evidence & rationale:**
  1. `proof-workflow.md:47-54` demonstrates only `rg` regex search over `.lake/packages/mathlib/Mathlib`. For Steps 3–4 (`Filter.Tendsto`, `Metric.tendsto_atTop`, `Int.fract_eq_self`, `HasSum`, `intervalIntegral`), type-directed search via Mathlib's built-in `exact?`, `apply?`, and `rw?` inside the disposable `/tmp/*.lean` scratch file finds polymorphic lemmas much more reliably than `rg` with zero external dependencies (and is stripped before production per `L76`).
  2. While single-session criticism (`proof-workflow.md:21`) is sufficient for kernel-checked infrastructure in Steps 2–4, `Aletheia` (`arXiv:2602.10177v2` §2.2) specifically demonstrates that same-context verification retains reasoning-trace bias on open research proofs (Step 5).
- **Proposed correction:**
  Mention `exact?` / `apply?` / `rw?` in `proof-workflow.md` Step 4's `/tmp` scratch recipe, and specify that any candidate mathematical proof for Step 5 (`V`) should receive a fresh-context criticism pass (seeing only statement, proof text, and cited sources) prior to large-scale Lean formalization.

#### R4. [Low] Harmonize open-interval predicate notation in the Next Bounded Task specification

- **References:** [`docs/proof-plan.md:232-240,248-253`](../proof-plan.md#L232-L240), [`PiDisjunctivity/OrbitEquivalence.lean:85-86`](../../PiDisjunctivity/OrbitEquivalence.lean#L85-L86).
- **Evidence & rationale:**
  `proof-plan.md:233,239` writes open-interval membership as `a < u n ∧ u n < b`, whereas `L248-250` phrases the cell-conversion premise in prose (*"visits every such open interval"*) and `OrbitEquivalence.lean:85-86` uses `Set.Ioo`. Although `x ∈ Set.Ioo a b` is definitionally `a < x ∧ x < b`, choosing one consistent spelling across the transfer conclusion and cell-conversion premise (and noting whether `OrbitCriteria.lean` should also export their 3-line composition or keep just the two modular lemmas) avoids minor signature friction. *(Optional note: replacing `N` by `max M N` in the transfer proof even yields arbitrarily late perturbed visits `∀ M : ℕ, ∃ n ≥ M, ...` at virtually zero extra cost, though a single visit `∃ n` already suffices for `P2`.)*

---

### III. Open Questions

1. **Role of `PiDisjunctivity/Examples.lean` in proof-research milestones:** `OrbitCriteria.lean` has full universal proofs and `Test.lean` type/axiom audits, but `Examples.lean` was not extended to import or exercise `OrbitCriteria` (unlike earlier formulation modules, and potentially in tension with `proof-plan.md:71`). Should `Examples.lean` remain frozen to formulation sanity checks, or should new proof-research modules include concrete rational/counterexample checks there?
2. **Ordering of `B1` (BBP integral identity) vs. `B3` (elementary tail bounds) after `B4`:** `proof-plan.md:367-368` schedules `B1` (`HasSum` to `Real.pi` via sum-integral exchange) immediately after `OrbitCriteria.lean`. Would proving `A(j)` summability, the finite-sum recurrence `y_{n+1} = fract(S_n)`, and the elementary geometric tail bound `B3` first provide a smaller, self-contained milestone before formalizing the definite integral for `Real.pi`?

---

## Verdict on the Next Bounded Task

**Verdict: READY WITH SPECIFIED CORRECTIONS.**

### Mathematical Audit of the Specification ([`docs/proof-plan.md:222-262`](../proof-plan.md#L222-L262))

1. **Lemma 1 — Conditional interior-margin transfer (`B4`):**
   - *Target:* Given `u r : ℕ → ℝ` with `Filter.Tendsto r Filter.atTop (nhds 0)` and `∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 → ∀ N : ℕ, ∃ n ≥ N, a < u n ∧ u n < b`, prove that for all `a b : ℝ` with `0 ≤ a < b ≤ 1`, `∃ n : ℕ, a < Int.fract (u n + r n) ∧ Int.fract (u n + r n) < b`. *(Drop hypothesis 1, `∀ n, 0 ≤ u n ∧ u n < 1`, per Finding D1.)*
   - *Proof sketch & quantifier order:* Let $\delta = (b - a)/4 > 0$, $a' = a + \delta$, $b' = b - \delta$. Then $0 \le a < a' < b' < b \le 1$. By `Metric.tendsto_atTop` applied to `r → 0` and $\delta > 0$, obtain $N : \mathbb{N}$ such that $\forall n \ge N,\ |r_n| < \delta$. Apply late visitation to $(a', b')$ and threshold $N$ to obtain $n \ge N$ with $a + \delta < u_n < b - \delta$. Quantifier order is valid because $(a', b')$ and $\delta$ depend only on $(a, b)$, $N$ depends on $\delta$, and $n \ge N$ is chosen after $N$ is fixed.
   - *Signed errors (`r_n > 0`, `r_n = 0`, `r_n < 0`):* `|r_n| < \delta` (`abs_lt`) gives $-\delta < r_n < \delta$, handling both signs symmetrically: $u_n + r_n > (a + \delta) - \delta = a$ and $u_n + r_n < (b - \delta) + \delta = b$.
   - *Fractional-part discontinuities & boundary targets (`a = 0`, `b = 1`):*
     - At `a = 0` with `r_n < 0`: $u_n > \delta$ and $r_n > -\delta$ force $u_n + r_n > 0$, preventing wraparound below $0$ (`Int.fract (-ε) = 1 - ε`).
     - At `b = 1` with `r_n > 0`: $u_n < 1 - \delta$ and $r_n < \delta$ force $u_n + r_n < 1$, preventing wraparound at or above $1$ (`Int.fract 1 = 0`).
     - In all cases, $0 \le a < u_n + r_n < b \le 1 \implies u_n + r_n \in [0, 1)$, so `Int.fract (u n + r n) = u n + r n` by `Int.fract_eq_self`.
2. **Lemma 2 — Open-interval-to-hexadecimal-cell conversion:**
   - *Target:* Given `t : ℕ → ℝ` such that `∀ a b : ℝ, 0 ≤ a → a < b → b ≤ 1 → ∃ n : ℕ, a < t n ∧ t n < b`, prove `∀ (k m : ℕ), m < 16 ^ k → ∃ n : ℕ, t n ∈ Set.Ico ((m : ℝ) / (16 : ℝ) ^ k) (((m : ℝ) + 1) / (16 : ℝ) ^ k)`.
   - *Edge cases (`k = 0`, `m = 0`, `m = 16^k - 1`):*
     - Since `(16 : ℝ) ^ k > 0` for all `k : ℕ`, `a = m / 16^k ≥ 0` (equal to `0` when `m = 0`), `a < (m + 1) / 16^k = b`, and `m < 16^k` in `ℕ` implies `m + 1 ≤ 16^k`, hence `b ≤ 1` (equal to `1` when `m = 16^k - 1`).
     - At `k = 0`: `m < 16^0 = 1` forces `m = 0`, giving `(a, b) = (0, 1)`, which satisfies `0 ≤ 0 < 1 ≤ 1` with no special case.
     - Because `B4` allows both `a = 0` and `b = 1` (`0 ≤ a < b ≤ 1`), applying open-interval visitation to `(m / 16^k, (m + 1) / 16^k)` directly yields `t n ∈ Set.Ioo a b ⊆ Set.Ico a b`.
3. **Sizing, prerequisites, and stopping conditions:**
   - No smaller prerequisite is needed: `Filter.Tendsto`, `nhds`, `Set.Ico`, and `Int.fract` are already available in the transitively imported Mathlib stack of `OrbitCriteria.lean` (adding only a private `import Mathlib.Tactic` for `linarith` / metric lemmas).
   - Stopping before BBP series/recurrence definitions and keeping late visitation explicit as a hypothesis are crisp, well-bounded stopping rules.
   - **Required pre-execution corrections:** Apply **Finding D1** (drop unused hypothesis `∀ n, 0 ≤ u n ∧ u n < 1`), **Finding D2** (add a separate cell-conversion node in `proof-blueprint.md`), and **Recommendation R4** (align open-interval notation across both signatures).

---

## Recommended Action Items

- [ ] **1. Drop the unused `0 ≤ u n < 1` hypothesis from `B4`** in [`docs/proof-plan.md:230`](../proof-plan.md#L230) and [`docs/proof-blueprint.md:76`](../proof-blueprint.md#L76) before implementing the next bounded task (`Finding D1`).
- [ ] **2. Add a distinct blueprint node for open-interval-to-cell conversion** (e.g., `B5` or `P3`) in [`docs/proof-blueprint.md:76-93`](../proof-blueprint.md#L76-L93) so it can be marked **Checked** independently of the blocked π node `Hπ` (`Finding D2`).
- [ ] **3. Fix minor stale status text** in [`docs/foundations-plan.md:15-16`](../foundations-plan.md#L15-L16) (15 vs. 17 audited theorems) and [`README.md:78-80`](../../README.md#L78-L80) (mention interval-hitting reduction in default build) (`Finding D3`).
- [ ] **4. Align `# Viewpoint` and numbering in `docs/proof-plan.md`** (`L67-71`, `L364`) with `proof-workflow.md` and `meta-proof-plan.md:188`, and avoid maintaining duplicate copies of `Next bounded task` across three documents (`Recommendation R1`).
- [ ] **5. Harden `docs/proof-workflow.md`** (`L32-41`, `L58-70`, `L78-80`) by adding: (a) a cwd/`+leanprover/lean4:v4.37.0-rc1` guard against the `elan` parent-directory toolchain trap, (b) an explicit `git diff` statement/pin preservation command, (c) `exact?` / `apply?` / `rw?` scratch-file search guidance, and (d) fresh-context review guidance before any Step 5 proof attempt (`Recommendations R2, R3`).

---

## Material Verification Limitations and Commands Run

### Verification Limitations

1. **External web sources and pinned GitHub blob SHAs:** Standard sandbox execution had no direct outbound network socket or raw URL downloader; external references were verified through grounded web search queries against `arxiv.org`, `github.com`, `openreview.net`, and `davidhbailey.com`. This confirmed the paper titles, authors, architectural designs, theorem statements, and cited section contents for `arXiv:2602.24273`, `arXiv:2610.17331`, `arXiv:2606.06468`, `arXiv:2602.10177`, `math/0101055`, BBP (1997), Bailey (`bbp-alg.pdf`), Bailey–Crandall (2001), `goedel-architect`, `lean4-skills`, and `lean-lsp-mcp`, but did not fetch verbatim full-text blobs at the three pinned GitHub commit SHAs (`300d69e9...`, `3f913c66...`, `7932203d...`) recorded in `proof-workflow.md:20,22,23`.
2. **Disposable pilot scratch file:** `/tmp/pi-disjunctivity-interval-pilot.lean` referenced in `research-log.md:114` is a disposable `/tmp` experiment not tracked in Git (`proof-workflow.md:68`), so only the integrated production module [`OrbitCriteria.lean`](../../PiDisjunctivity/OrbitCriteria.lean) and [`Test.lean`](../../Test.lean) were inspected and compiled.
3. **Trusted local toolchain and Mathlib cache:** Verification compiled project modules and `Test.lean` on the local `leanprover/lean4:v4.37.0-rc1` toolchain and local `.lake` package checkouts rather than performing a clean-room remote rebuild of all 6,655 Mathlib build jobs from scratch.

### Commands Actually Run

All repository files and pre-existing untracked/modified notes (`docs/.obsidian/*`, `docs/notes/`) were preserved untouched:

| Command | Outcome |
| --- | --- |
| `GIT_CONFIG_GLOBAL=/dev/null git -C pi-disjunctivity status --short --branch` | Branch `feature/attempt-02...origin/feature/attempt-02 [ahead 1]`; only pre-existing unrelated work (`M docs/.obsidian/workspace.json`, `?? docs/.obsidian/hotkeys.json`, `?? docs/notes/`) present. |
| `GIT_CONFIG_GLOBAL=/dev/null git -C pi-disjunctivity log -n 10 --oneline` | Confirmed `6be3b0e` (`Execute meta-proof workflow and interval-hitting pilot`), `990cd13` (`added meta-proof-plan.md`), `45020c6` (`Document the hexadecimal pi proof strategy and supporting research`), and `56ca22e` baseline. |
| `GIT_CONFIG_GLOBAL=/dev/null git -C pi-disjunctivity -c core.excludesfile=/dev/null show --stat 6be3b0e` (and full diff inspection) | Confirmed exact 12-file diff (`626` insertions, `15` deletions); pre-existing Lean modules untouched. |
| `rg -n 'sorry\|admit\|axiom \|native_decide\|implemented_by\|extern\|unsafe' PiDisjunctivity PiDisjunctivity.lean Test.lean` | Exit status `1` (zero matches across all 10 Lean files). |
| `rg -n '^public import\|^import' PiDisjunctivity PiDisjunctivity.lean Test.lean` | Confirmed every explicit import is from `PiDisjunctivity` or `Mathlib`. |
| `GIT_CONFIG_GLOBAL=/dev/null git -C pi-disjunctivity -c core.excludesfile=/dev/null diff --check` | Exit status `0` (clean). |
| Python manifest, package-HEAD, worktree, and Markdown link/anchor verification | Verified `mathlib` is the sole direct package (`31ce06ea...`), all 8 inherited packages match `.lake/packages/mathlib/lake-manifest.json`, all 9 `.lake/packages/*` HEAD commits match `lake-manifest.json` with clean git worktrees, and zero broken relative Markdown links or heading anchors exist across `AGENTS.md`, `README.md`, and `docs/**/*.md`. |
| `/Users/adam/.elan/bin/lake --dir .../pi-disjunctivity env lean --version` (from parent dir) | Returned `Lean 4.36.0` (exposing the `elan` parent-CWD toolchain hazard; `Test.lean` failed with `incompatible header`, and the `4.36.0` `lake build` task was cancelled immediately). |
| `/Users/adam/.elan/bin/lake +leanprover/lean4:v4.37.0-rc1 --dir .../pi-disjunctivity env lean --version` | Confirmed `Lean (version 4.37.0-rc1, arm64-apple-darwin24.6.0, commit 0b77e12952ad39077d80d8bd6b66d601f225c321, Release)`. |
| `/Users/adam/.elan/bin/lake +leanprover/lean4:v4.37.0-rc1 --dir .../pi-disjunctivity build` | Passed cleanly (`Build completed successfully (6655 jobs)`), zero compiler or linter warnings, restoring `.lake` artifacts cleanly to `v4.37.0-rc1`. |
| `/Users/adam/.elan/bin/lake +leanprover/lean4:v4.37.0-rc1 --dir .../pi-disjunctivity env lean .../pi-disjunctivity/Test.lean` | Passed with exit status `0` and zero output (all 17 theorem types, 17 `#guard_msgs` axiom checks `[propext, Classical.choice, Quot.sound]`, and 2 `Iff.rfl` conjecture-definition checks verified). |
