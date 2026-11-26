# pi-disjunctivity

An independent Lean 4 and Mathlib project studying **hexadecimal disjunctivity
of π**:

> Every finite string of hexadecimal digits occurs contiguously after the radix
> point in the base-16 expansion of π.

Words use the digits `0`–`9` and `A`–`F`, including leading zeros. Disjunctivity
requires every finite word to occur; it imposes no limiting frequency.

Base 16 aligns the research with the Bailey–Borwein–Plouffe (BBP) method for
extracting hexadecimal digits of π. The
[problem formulation](docs/problem-formulation.md) explains this motivation,
links to the BBP paper, and specifies the mathematical statement.

Wikipedia article on general sequences: [Disjunctive sequence](https://en.wikipedia.org/wiki/Disjunctive_sequence)

## Scope and current status

The formulation and its digit/interval/orbit equivalences are verified. The
unconditional BBP series and exact recurrence-to-orbit bridge are checked.
B3 tail control and universal visitation remain unproved, and the conditional
transfer results retain their hypotheses. See [the B2 handoff](docs/b2-handoff.md)
for final acceptance and publication evidence. This
repository does not establish π disjunctivity.

Use the [proof plan](docs/proof-plan.md) for the mathematical roadmap and exact
milestone contracts, the [blueprint](docs/proof-blueprint.md) for declarations
and hypotheses, and the [research log](docs/research-log.md) for dated evidence
and handoffs. The [formulation review](docs/formulation-review.md) and
[follow-up](docs/review-follow-up.md) record the semantic review of the problem.

Next session: <!-- current-prompt --> [Current prompt](docs/session-prompts.md#current-prompt-b2-workflow-and-lean-tooling)
is invoked only at the user's request. Read [AGENTS.md](AGENTS.md) and the
[workflow](docs/proof-workflow.md) before implementation.

## Installation

Install Git and `curl`, then install the Lean toolchain manager, **Elan**. On
macOS or Linux, run the command from the
[official Elan installation instructions](https://github.com/leanprover/elan#manual-installation):

```sh
curl -sSf https://elan.lean-lang.org/elan-init.sh | sh
```

Elan installs the `elan`, `lean`, and `lake` commands in **`$HOME/.elan/bin`**
(`~/.elan/bin`) by default. Add that directory to your current shell's `$PATH`:

```sh
export PATH="$HOME/.elan/bin:$PATH"
elan --version
```

To retain this setting in new terminals, add the same `export PATH=...` line to
your shell startup file if the installer has not already configured it. Use
`~/.zshrc` for Zsh, `~/.bashrc` for interactive Bash, or `~/.bash_profile` for a
macOS Bash login shell. If you set a custom `ELAN_HOME`, use `$ELAN_HOME/bin`
instead of `$HOME/.elan/bin`.

Elan selects and downloads the project's pinned Lean version when you first run
`lean` or `lake` inside the repository. For Windows or an editor-based setup, see
the [official Lean installation guide](https://lean-lang.org/install/). VS Code
with the Lean 4 extension is recommended for interactive development.

Clone the repository, then run the remaining commands from its root directory
(the directory containing `lakefile.toml`):

```sh
git clone https://github.com/ursula-athene/pi-disjunctivity.git
cd pi-disjunctivity
lake exe cache get
```

The cache command downloads precompiled Mathlib artifacts for the pinned
dependencies. Initial setup requires internet access. See the
[Mathlib project guide](https://leanprover-community.github.io/install/project.html#working-on-an-existing-project)
for additional setup guidance.

The current pins are:

- **Lean:** `leanprover/lean4:v4.37.0-rc1`, in [lean-toolchain](lean-toolchain).
- **Mathlib:** `v4.37.0-rc1`, declared in [lakefile.toml](lakefile.toml).
- **Exact dependency revisions:** recorded in [lake-manifest.json](lake-manifest.json).

Keep these files together when reproducing a build. `lake update` is for
intentional dependency updates and is not required for routine setup.

## Build and check

Build the library, including the hexadecimal examples:

```sh
lake build
```

Check the exported statements and axiom dependencies for the foundations and
both formulation equivalences:

```sh
lake env lean Test.lean
```

[Test.lean](Test.lean) is the executable inventory of full theorem types,
root-import definition/boundary checks, and guarded actual axiom lists. An
unexpected axiom such as `sorryAx` fails the audit; the permitted dependencies
are `propext`, `Classical.choice`, and `Quot.sound`. CI runs this after the build.
For process tooling and local documentation checks, also run:

```sh
uv run --locked --offline python -m unittest discover -s tests -v
uv run --locked --offline python tools/check_docs.py
```

See [process tools](docs/process-tools.md) for scope and limitations.

To build selected modules explicitly:

```sh
lake build PiDisjunctivity.Definitions PiDisjunctivity.BlockValue \
  PiDisjunctivity.Digits PiDisjunctivity.Disjunctivity PiDisjunctivity.Cylinders \
  PiDisjunctivity.Conjectures PiDisjunctivity.OrbitEquivalence PiDisjunctivity.OrbitCriteria \
  PiDisjunctivity.BBP.Series PiDisjunctivity.BBP.Orbit PiDisjunctivity.Examples
```

For a quick check of one source file, or to inspect the selected Lean version:

```sh
lake env lean PiDisjunctivity/Definitions.lean
lake env lean --version
```

Open the repository root in VS Code to work with Lean's interactive proof state.
A successful build checks the definitions, theorems, and examples included. The
[implementation status](docs/problem-formulation.md#implementation-status)
records the completed foundations and milestones A, B, and C. The
[review report](docs/formulation-review.md) records the semantic review, actual
axiom lists, dependency inspection, validation results, and remaining limitations.

## Repository guide

- [Document responsibilities](docs/proof-workflow.md#records-and-project-memory):
  authoritative records, project memory, and handoff conventions.
- [Session entry point](docs/proof-attempt-session-prompt.md): current instructions
  and historical prompt archive.
- [Dependencies and trust](docs/dependencies-and-trust.md): permitted libraries,
  pins, proof checking, and statement-review boundaries.
- [Problem formulation](docs/problem-formulation.md) and
  [foundations plan](docs/foundations-plan.md): original problem and verification.
- [Library root](PiDisjunctivity.lean) and [Test.lean](Test.lean): exported modules
  and executable type/axiom audits; declaration details are in the blueprint.

## License

This project is licensed under the [MIT License](LICENSE).
Lean source files use `SPDX-License-Identifier: MIT` with copyright and author
headers. The header style linter is enabled and configured to check that license
line.
