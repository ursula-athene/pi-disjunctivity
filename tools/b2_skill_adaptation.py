# Copyright (c) 2026 Ursula Athene. All rights reserved.
# SPDX-License-Identifier: MIT
"""Reproduce the two evaluated skill adaptations from a pinned source archive."""
from pathlib import Path
import re
import shutil

REV = '1837b95b3d5a9fd8d311367603902ad7fe261adf'
URL = f'https://github.com/scottnarmstrong/LeanAutoformalizationSkills/blob/{REV}/'
OVERRIDE = '''## Pi-disjunctivity compatibility overrides

This adapted copy is for the pi-disjunctivity checkout. Read its `AGENTS.md`
and `docs/proof-workflow.md` from the actual checkout root before using it.
Those rules override every example in this folder: no placeholder proofs,
additional Lean libraries, direct transitive-package imports, frozen-manifest
approval workflow, automatic companion installation, or remote-search activation.
Local search failure, even after multiple methods or an index lookup, never
establishes nonexistence. Approved conditional B4/P3 reductions remain valid
with every premise visible; they do not prove the unconditional conjecture.
Preserve headers, complete milestone scope, root probes, pinned versions, audits,
and Carbon reviews. Do not refactor fixed B2 to demonstrate this guidance.
Unselected companion links below are attributed reference locations, not an
activation or instruction to install/read their broader workflows. Use the
project workflow for module conventions and architecture; use the selected
proof-patterns resources for tactics. Performance claims require local evidence.

'''

ADAPTATION = f'''# Local adaptation

LeanAutoformalizationSkills by Scott Armstrong, {URL}, revision `{REV}`,
licensed under CC BY 4.0; LICENSE and THIRD_PARTY_NOTICES.md retain notices,
including MIT and Apache material. Changes made 2026-11-25 for pi-disjunctivity:
project overrides added before guidance; placeholder example removed; direct
Aesop import replaced with Mathlib facade; collection/unselected links pinned;
module companion replaced by project workflow. All original folder resources
are retained. This temporary package is evaluation material, not a host
activation claim. Do not strip notices when relocating it.
'''


def replace_required(text, old, new):
    if text.count(old) != 1:
        raise ValueError("Pinned skill adaptation anchor changed; inspect the source before proceeding")
    return text.replace(old, new)


def prepare_skills(source: Path, output: Path) -> None:
    source = source.resolve()
    output.mkdir(parents=True, exist_ok=True)
    selected = ("lean-search-discovery", "lean-proof-patterns")
    for name in selected:
        target = output / name
        shutil.copytree(source / "skills" / name, target)
        for path in target.rglob("*.md"):
            text = path.read_text()

            def replace_link(match):
                ref = match.group(1)
                if not ref.startswith("../"):
                    return match.group(0)
                original = source / "skills" / name / path.relative_to(target).parent / ref
                relative = original.resolve().relative_to(source).as_posix()
                if relative.startswith(tuple(f"skills/{item}/" for item in selected)):
                    return match.group(0)
                return "](" + URL + relative + ")"

            text = re.sub(r"\]\(([^)]+)\)", replace_link, text)
            relative_path = path.relative_to(target).as_posix()
            if relative_path == "references/math-to-lean.md":
                text = replace_required(text, '| "Skip this for now" | `sorry` (development only — never in finished code) |',
                                        '| "Cannot close this step" | Stop and report the exact goal; no placeholder proof. |')
            if relative_path == "references/tactics-and-automation.md":
                text = replace_required(text, '| `aesop` | General-purpose automation | `Aesop` |',
                                        '| `aesop` | General-purpose automation | `Mathlib.Tactic` (project-approved facade) |')
            if path.name == "SKILL.md":
                end = text.index("---", 4) + 3
                text = text[:end] + "\n\n" + OVERRIDE + text[end:].lstrip()
                if name == "lean-proof-patterns":
                    text = replace_required(text, "See the `lean-project-architecture` skill's `references/module-system.md` for\nthe full rules.",
                                            "For module rules use the project workflow. The unselected architecture skill\nis not installed or required.")
            path.write_text(text)
        shutil.copyfile(source / "LICENSE", target / "LICENSE")
        notices = (source / "THIRD_PARTY_NOTICES.md").read_text()
        for name in ("SOURCES.md", "PROVENANCE.md"):
            notices = notices.replace("](" + name + ")", "](" + URL + name + ")")
        (target / "THIRD_PARTY_NOTICES.md").write_text(notices)
        (target / "LICENSES").mkdir()
        shutil.copyfile(source / "LICENSES/Apache-2.0.txt", target / "LICENSES/Apache-2.0.txt")
        (target / "ADAPTATION.md").write_text(ADAPTATION)
    for path in output.rglob("*.md"):
        for ref in re.findall(r"\]\(([^)]+)\)", path.read_text()):
            if "://" in ref or ref.startswith("#"):
                continue
            target = (path.parent / ref.split("#", 1)[0]).resolve()
            if not target.is_relative_to(output.resolve()) or not target.exists():
                raise ValueError(f"Missing or escaping adapted skill link: {ref}")
