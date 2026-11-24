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

The Lean library proves the correspondence between hexadecimal digit blocks and
base-16 intervals, and the equivalence of disjunctivity with

$$
\overline{\{\operatorname{fract}(16^n x):n\in\mathbb N\}}=[0,1]
\qquad (x\ge 0).
$$

See the [validation plan](docs/problem-formulation.md#plan-for-validating-the-formulation)
for the proof strategy, audit criteria, and remaining validation tasks. Whether
π satisfies this property remains the research question; this repository does
not establish it.

The digit and disjunctivity definitions remain parameterized by the base. The
orbit, equivalence theorems, conjecture definitions, and examples use base 16.
The main theorem is `PiDisjunctivity.hexadecimal_disjunctive_iff_orbit_closure`;
`PiDisjunctivity.pi_hexadecimal_disjunctivity_iff_orbit_closure` specializes it to
the two open statements about π.

The default build includes every project library module and the hexadecimal
examples. The axiom audit checks that both equivalence theorems depend only on
`propext`, `Classical.choice`, and `Quot.sound`, with no `sorryAx` or
project-specific axioms.

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

Run the axiom audit:

```sh
lake env lean Test.lean
```

The audit uses `#guard_msgs` to check the output of `#print axioms`; an unexpected
axiom makes the command fail. CI runs this check after the build.

To build selected modules explicitly:

```sh
lake build PiDisjunctivity.Definitions PiDisjunctivity.Equivalences \
  PiDisjunctivity.Conjectures PiDisjunctivity.Examples
```

For a quick check of one source file, or to inspect the selected Lean version:

```sh
lake env lean PiDisjunctivity/Definitions.lean
lake env lean --version
```

Open the repository root in VS Code to work with Lean's interactive proof state.
A successful build and axiom audit verify the included declarations; the
[validation plan](docs/problem-formulation.md#implementation-status) records which
parts of the broader formulation review are complete and which remain planned.

## Repository guide

- [docs/problem-formulation.md](docs/problem-formulation.md): the hexadecimal
  problem statement and plan for validating its formalization.
- [PiDisjunctivity/Definitions.lean](PiDisjunctivity/Definitions.lean): digit and
  disjunctivity definitions parameterized by the base, plus the hexadecimal orbit.
- [PiDisjunctivity/Equivalences.lean](PiDisjunctivity/Equivalences.lean): hexadecimal
  word, interval, and orbit-closure results.
- [PiDisjunctivity/Conjectures.lean](PiDisjunctivity/Conjectures.lean): proposition
  definitions naming the hexadecimal conjectures and a theorem equating them.
- [PiDisjunctivity/Examples.lean](PiDisjunctivity/Examples.lean): exact rational
  examples for hexadecimal indexing, digits `A`–`F`, leading zeros, terminating
  expansions, and interval boundaries.
- [PiDisjunctivity.lean](PiDisjunctivity.lean): the library's root imports.
- [Test.lean](Test.lean): a checked axiom audit of the two equivalence theorems.
