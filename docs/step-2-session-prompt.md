# Prompt for a new session: Step 2 of the Lean foundations

**Historical prompt: Step 2 is complete.** Use the current
[session prompts](session-prompts.md) for the next milestone.

Implement and validate **Step 2 of `docs/foundations-plan.md`** in this repository:
prove that hexadecimal words of length `k` have values below `16 ^ k`, and that
every natural number below `16 ^ k` is represented by such a word.

Proceed with the Lean implementation and validation autonomously within this
scope. This prompt authorizes implementation, not just another plan. Leave the
changes uncommitted; do not push or rewrite Git history.

## Read the current project first

Locate the repository root containing `lakefile.toml`; it may be the
`pi-disjunctivity/` subdirectory of the initial workspace. Inspect applicable
`AGENTS.md` instructions and Git status, and preserve any existing changes.
The working branch at handoff is `feature/attempt-01` in
`ursula-athene/pi-disjunctivity`.

Read these files before editing:

- `README.md`
- `docs/problem-formulation.md`
- `docs/foundations-plan.md`
- `PiDisjunctivity/Definitions.lean`
- `PiDisjunctivity/BlockValue.lean`
- `PiDisjunctivity/Examples.lean`
- `PiDisjunctivity.lean`
- `Test.lean`
- `lakefile.toml`, `lean-toolchain`, and `.github/workflows/lean_action_ci.yml`

`docs/pi-disjunctivity-codex-handoff.md` preserves an older, base-10 plan. The
current formulation and foundations plan govern this task.

## Context and exact scope

The project formulates hexadecimal disjunctivity of pi: every finite hexadecimal
word occurs after its radix point, including words with leading zeros. That
conjecture remains open; this task validates part of the formulation.

Step 1 is complete: `PiDisjunctivity.blockValue_eq_sum` proves that the recursive
word value agrees with its big-endian positional finite sum for every length and
word. Its proof, examples, exported statement, and axiom audit have passed.

This task is the **second foundational step**, not the entire section titled
“Connect finite words to hexadecimal intervals” in the broader problem
formulation. Do not implement Step 3's arbitrary-base digit reconstruction, the
word–interval correspondence, the orbit equivalence, BBP, or a proof of pi
disjunctivity. Earlier interval and orbit proofs were deliberately discarded;
do not restore them from history.

## Required theorems

Add these exact statements to `PiDisjunctivity/BlockValue.lean`, in the existing
`PiDisjunctivity` namespace, and export them through `PiDisjunctivity.lean`:

```lean
theorem blockValue_lt (k : ℕ) (s : Fin k → Fin 16) :
    blockValue k s < 16 ^ k

theorem exists_blockValue_eq (k m : ℕ) (hm : m < 16 ^ k) :
    ∃ s : Fin k → Fin 16, blockValue k s = m
```

Keep the existing definitions and reviewed theorem statements unchanged. Length
zero is included, and a word's length must remain explicit so leading zeros are
preserved. Necessary helper lemmas are within scope.

Use the proof approach already reviewed in `docs/foundations-plan.md`:

- For the bound, induct on `k`. Combine the bound on the prefix with the final
  digit's bound below 16. The empty word has value zero and satisfies `0 < 1`.
- For coverage, induct on `k`, allowing `m` to vary. At length zero, `m < 1`
  forces `m = 0`. At length `k + 1`, apply induction to `m / 16`, append the
  digit `m % 16`, and use the quotient–remainder identity. Check the quotient
  bound and the prefix/last-digit indexing explicitly.

Choose suitable local Mathlib lemmas and tactics. Explain how the resulting
proofs establish precisely the intended range of word values.

## Validation and documentation

- Preserve the Step 1 proof and checks. Extend `Test.lean` with checks of both
  new exported theorem types and guarded `#print axioms` results. Allow only
  axioms among `propext`, `Classical.choice`, and `Quot.sound`; an individual
  theorem may use fewer. The audit must fail on unexpected dependencies.
- Leave no `sorry`, `admit`, project-specific axioms, or unsafe proof shortcuts.
  Do not use `native_decide` to bypass the intended kernel-checked proof work.
- Extend the existing examples where useful to exercise the new results at
  lengths zero and one, zero values, leading-zero padding such as `00A`, and
  maximum values such as `FF`. Examples supplement the universal proofs.
- Ensure CI still runs the expanded audit after the build. Update its label and
  descriptions if they currently refer only to Step 1.
- After successful validation, update `README.md`, `docs/foundations-plan.md`,
  and `docs/problem-formulation.md` to mark Step 2 complete and describe the
  expanded checks. Keep Step 3 and the later equivalences marked as pending.

Use the pinned Lean `v4.37.0-rc1` and Mathlib `v4.37.0-rc1`; do not upgrade them.
Follow the existing `module`, import, and `public section` conventions. The
project uses MIT licensing, and all copyright and author attribution must use
only **Ursula Athene**. Preserve the SPDX headers and enabled header linter.

Run these commands from the repository root:

```sh
lake build
lake env lean Test.lean
git diff --check
```

If Elan is installed but `lake` is missing from the shell's path, use
`export PATH="$HOME/.elan/bin:$PATH"`. Resolve build and linter warnings without
disabling checks. Keep the existing Step 1 regression checks passing.

Finish by reporting the theorems proved, the proof reasoning, the validation
results and axiom dependencies, and the files changed. State the remaining
foundational work accurately, and leave the changes ready for review without
committing or pushing.
