# Dependencies and trust

## Dependency policy

The formulation uses **Mathlib as its only direct external Lean library**.
Our own Lean definitions and proofs are allowed, provided they depend only on
Mathlib, Lean's core/standard libraries, and other project modules following
this policy. Do not introduce additional external Lean libraries through Lake,
vendoring, or imports.

Mathlib brings its own transitive dependencies. These remain part of the
permitted Mathlib stack at the revisions recorded in the manifest; they are not
independently selected project libraries. Their presence does not authorize new
direct dependencies or direct imports of those packages. Repository instructions
record this policy in [AGENTS.md](../AGENTS.md).

## Current dependency stack

| Component | Role and source |
| --- | --- |
| Lean `v4.37.0-rc1` | The foundational logic, proof-checking kernel, core/standard libraries, and toolchain, pinned in [lean-toolchain](../lean-toolchain). |
| Mathlib `v4.37.0-rc1` | The only direct external library in [lakefile.toml](../lakefile.toml). It supplies the mathematics used by the formulation, including real numbers, floors, intervals, topology, and `Real.pi`. |
| Mathlib's transitive dependencies | The current [lake-manifest.json](../lake-manifest.json) includes `plausible`, `LeanSearchClient`, `importGraph`, `proofwidgets`, `aesop`, `Qq`, `batteries`, and `Cli`, all marked as inherited dependencies. Exact revisions are recorded there. |
| Project code | Definitions of digits, finite words, disjunctivity, and the hexadecimal orbit, plus proved foundational lemmas and formulation equivalences. All explicit imports in the current project Lean source are from Mathlib or this project. |

The presence of a package in the manifest is not itself a mathematical
assumption, nor does it show that every theorem uses that package. Dependency
review must inspect the Lake configuration, manifest, and source imports;
the axiom audit below checks a different property.

The two pi conjecture names in
[Conjectures.lean](../PiDisjunctivity/Conjectures.lean) are definitions of
propositions using Mathlib's `Real.pi`. They are not axioms asserting those
propositions. The proved equivalence connects them without asserting either one.

## Proof checking and logical assumptions

Mathlib provides established definitions and a widely reviewed library of
theorems. Our local proofs receive Lean's kernel checks as well: being outside
Mathlib does not exempt a proof from checking. Ordinary tactics construct proof
terms that the kernel checks, so their use does not by itself introduce new
mathematical axioms. See the official
[Lean explanation of tactic proofs](https://lean-lang.org/doc/reference/latest/Tactic-Proofs/).

The current [Test.lean](../Test.lean) preserves all thirteen milestone C theorem-type
checks and adds infinite-series reconstruction and arbitrarily late occurrence,
for fifteen foundational audited theorems. The bounded interval pilot adds a
general interval-hitting equivalence and a conditional π reduction; B4/P3 add
general interior-margin transfer and open-interval-to-cell conversion, bringing
the subtotal to nineteen. B1a adds the unconditional BBP term integral, for
twenty through the root library import. It guards their
`#print axioms` results and also checks both named π definitions against their
expanded statements, as well as the BBP coefficient expansion and zero-index
value. The
[consolidated review](formulation-review.md#axiom-audit) records the original lists;
the [follow-up review](review-follow-up.md) records its two additions, and the
[research log](research-log.md) records the interval-pilot, B4/P3, and B1a additions.
Every audited theorem currently reports exactly these three axioms:

| Axiom | Meaning |
| --- | --- |
| `propext` | Logically equivalent propositions are equal. |
| `Classical.choice` | An element can be selected from a nonempty type. |
| `Quot.sound` | Related representatives are equal in the corresponding quotient. |

These are standard foundational axioms of Lean mathematics, not theorems
established by Mathlib. See
[Lean's axiom documentation](https://lean-lang.org/doc/reference/latest/Axioms/).
An individual theorem may use fewer of them; no other axioms are permitted by
this project's proof policy. The current exact-output guards fail if an audited
theorem acquires an unexpected axiom, including `sorryAx` or a project-specific
axiom. Future audit changes must preserve this restriction.

There are no `sorry`, `admit`, project-specific axioms, or `native_decide` proof
bypasses in the current project Lean source. Continue to use kernel-checked
proofs without unsafe shortcuts. The logical basis remains Lean's type theory
and the permitted axioms; using the software also relies on the correctness of
Lean's implementation and the imported build artifacts.

Run the existing checks from the repository root:

```sh
lake build
lake env lean Test.lean
git diff --check
```

CI runs the theorem-type and axiom audit after the build. These checks do not
automatically enforce the external-library policy; configuration and import
review remain necessary.

## Completed formulation review and trust boundary

Kernel checking establishes that formal proofs follow from their formal
statements and assumptions. It cannot establish that our definitions and
statements accurately express the intended English problem. That comparison
requires mathematical review, especially for digit indexing, leading zeros,
terminating expansions, interval boundaries, and quantification.

Milestone C of the
[verification roadmap](problem-formulation.md#remaining-lean-verification-roadmap)
is complete. The [review report](formulation-review.md) compares the definitions
and both equivalences with the intended problem, including the general arguments
for termination and closure endpoints. It records successful compilation and
audits as distinct from the mathematical review of meaning.

The separate dependency inspection confirmed one direct Mathlib dependency,
unchanged Lean/Mathlib `v4.37.0-rc1` pins, eight inherited entries matching the
pinned Mathlib manifest, and nine package checkouts at the recorded revisions
with no tracked changes. Every explicit project import is from Mathlib or this
project; no vendored or additional library was introduced. CI retains its
build-then-audit sequence. See the report for commands, results, and limitations.

Formulation verification is complete. The pi disjunctivity conjecture itself
remains unproved; work on proving it or formalizing BBP requires separate
authorization.
