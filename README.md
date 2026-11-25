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

## Scope and current status

Step 1 of the [foundational theorem plan](docs/foundations-plan.md) is implemented:
`PiDisjunctivity.blockValue_eq_sum` proves that the recursive hexadecimal word
value equals the specified big-endian finite sum, for every length and word.
The library also contains the problem definitions and exact examples.

The next steps are to prove the word-value bound and coverage of every integer
below $16^k$, then validate digit reconstruction in an arbitrary base. The earlier
cylinder and orbit-equivalence proofs remain removed.

A later milestone is to connect hexadecimal digit blocks to base-16 intervals
and prove the equivalence of disjunctivity with

$$
\overline{\{\operatorname{fract}(16^n x):n\in\mathbb N\}}=[0,1]
\qquad (x\ge 0).
$$

See the [validation plan](docs/problem-formulation.md#plan-for-validating-the-formulation)
for the proof strategy, audit criteria, and remaining validation tasks. Whether
π satisfies this property remains the research question; this repository does
not establish it.

The digit and disjunctivity definitions remain parameterized by the base. The
word value, orbit, conjecture definitions, and examples use base 16. The default
build checks the definitions, Step 1 theorem, and examples. Steps 2 and 3 and
the orbit equivalence are not yet implemented.

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

Check Step 1's exported statement and axiom dependencies:

```sh
lake env lean Test.lean
```

This check requires the exact reviewed theorem type and uses `#guard_msgs` to
verify that its only axioms are `propext`, `Classical.choice`, and `Quot.sound`.
An unexpected axiom such as `sorryAx` makes the check fail. CI runs it after the
library build.

To build selected modules explicitly:

```sh
lake build PiDisjunctivity.Definitions PiDisjunctivity.BlockValue \
  PiDisjunctivity.Conjectures PiDisjunctivity.Examples
```

For a quick check of one source file, or to inspect the selected Lean version:

```sh
lake env lean PiDisjunctivity/Definitions.lean
lake env lean --version
```

Open the repository root in VS Code to work with Lean's interactive proof state.
A successful build checks the definitions, theorem, and examples included. The
[implementation status](docs/problem-formulation.md#implementation-status)
records the remaining proof work. The current audit covers Step 1, and does not
reinstate the discarded equivalence proof.

## Repository guide

- [docs/problem-formulation.md](docs/problem-formulation.md): the hexadecimal
  problem statement and plan for validating its formalization.
- [docs/foundations-plan.md](docs/foundations-plan.md): reviewed theorem
  statements, proof methods, and completion status for the three foundations.
- [PiDisjunctivity/Definitions.lean](PiDisjunctivity/Definitions.lean): digit and
  disjunctivity definitions parameterized by the base, plus the hexadecimal orbit
  and recursive word value.
- [PiDisjunctivity/BlockValue.lean](PiDisjunctivity/BlockValue.lean): the Step 1
  proof that the recursive word value equals the finite sum.
- [PiDisjunctivity/Conjectures.lean](PiDisjunctivity/Conjectures.lean): proposition
  definitions naming the hexadecimal digit-block and orbit-closure conjectures.
- [PiDisjunctivity/Examples.lean](PiDisjunctivity/Examples.lean): exact rational
  examples for hexadecimal indexing, digits `A`–`F`, leading zeros, terminating
  expansions, interval boundaries, and the word-value sum formula.
- [PiDisjunctivity.lean](PiDisjunctivity.lean): the library's root imports.
- [Test.lean](Test.lean): the Step 1 statement and axiom checks.

## License

This project is licensed under the [MIT License](LICENSE).
Lean source files use `SPDX-License-Identifier: MIT` with copyright and author
headers. The header style linter is enabled and configured to check that license
line.
