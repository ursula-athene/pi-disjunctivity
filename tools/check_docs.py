# Copyright (c) 2026 Ursula Athene. All rights reserved.
# SPDX-License-Identifier: MIT
"""Check repository Markdown and explicitly marked current-prompt entry links."""

import argparse
from pathlib import Path
import re
import subprocess
from urllib.parse import unquote, urlsplit

from markdown_it import MarkdownIt

PROMPTS = Path("docs/session-prompts.md")
ENTRY_POINTS = (Path("README.md"), Path("docs/proof-attempt-session-prompt.md"))
MARKER = "<!-- current-prompt -->"
MARKDOWN = MarkdownIt("commonmark")
# A dated source review linked a sibling checkout. Do not require that external
# checkout in CI, or rewrite its historical evidence. No other escape is allowed.
HISTORICAL_SIBLING = Path("docs/agy-reports/literature-review-report.md")


def slug(text):
    # GitHub-style heading IDs for this repository's Markdown vocabulary.
    return re.sub(r"[^\w\- ]", "", text.lower()).replace(" ", "-")


def parse(text):
    """Return heading/HTML anchors, headings, links and marked destinations.

    MarkdownIt handles fences, reference links, titles and escaped destinations.
    The marker must immediately precede its link on the same line.
    """
    tokens = MARKDOWN.parse(text)
    anchors, headings, links, marked = set(), [], [], []
    counts = {}
    for i, token in enumerate(tokens):
        if token.type == "heading_open":
            inline = tokens[i + 1]
            title = "".join(t.content for t in inline.children or []
                            if t.type in ("text", "code_inline"))
            base = slug(title)
            suffix = counts.get(base, 0)
            anchor = base if suffix == 0 else f"{base}-{suffix}"
            while anchor in anchors:
                suffix += 1
                anchor = f"{base}-{suffix}"
            counts[base] = suffix + 1
            anchors.add(anchor)
            headings.append((token.tag, title, anchor))
        children = token.children or [token]
        pending = False
        for child in children:
            if child.type in ("html_inline", "html_block"):
                anchors.update(re.findall(r'<a\s+(?:id|name)=["\']([^"\']+)["\']',
                                          child.content))
                if child.content.strip() == MARKER:
                    pending = True
                    continue
            if child.type in ("link_open", "image"):
                target = child.attrGet("href" if child.type == "link_open" else "src")
                links.append(target)
                if pending:
                    marked.append(target)
                    pending = False
            elif pending and not (child.type == "text" and not child.content.strip()):
                marked.append(None)
                pending = False
        if pending:
            marked.append(None)
    return anchors, headings, links, marked


def local_target(root, source, href):
    url = urlsplit(href)
    if url.scheme or url.netloc:
        return None
    path = unquote(url.path)
    target = (root / path.lstrip("/") if path.startswith("/")
              else source.parent / path) if path else source
    return target.resolve(), unquote(url.fragment)


def check(root, files, entry_points=ENTRY_POINTS):
    root = root.resolve()
    errors = []
    parsed = {}

    def document(path):
        if path not in parsed:
            parsed[path] = parse(path.read_text(encoding="utf-8"))
        return parsed[path]

    prompt_path = root / PROMPTS
    if not prompt_path.is_file():
        return [f"Missing prompt file: {PROMPTS}"]
    current = [h for h in document(prompt_path)[1]
               if re.match(r"Current prompt(?:\s*:|$)", h[1], re.I)]
    if len(current) != 1 or current[0][0] != "h2":
        errors.append("Expected exactly one level-2 Current prompt section")
    current_anchor = current[0][2] if len(current) == 1 else None
    for relative in sorted(set(files) | set(entry_points) | {PROMPTS}):
        path = root / relative
        if not path.is_file():
            errors.append(f"{relative}: missing document")
            continue
        _, _, links, marked = document(path)
        if relative in entry_points and len(marked) != 1:
            errors.append(f"{relative}: expected one marked current-prompt link")
        for href in links:
            resolved = local_target(root, path, href)
            if resolved is None:
                continue
            target, anchor = resolved
            if not target.is_relative_to(root):
                if not (relative == HISTORICAL_SIBLING and
                        target.is_relative_to((root.parent / "deepmind-formal-conjectures").resolve())):
                    errors.append(f"{relative}: link escapes checkout: {href}")
            elif not target.exists():
                errors.append(f"{relative}: missing target: {href}")
            elif relative.parts[:2] == ("docs", "agy-reports") and re.fullmatch(r"L[1-9]\d*(?:-L[1-9]\d*)?", anchor):
                # Review line citations refer to the reviewed snapshot, not
                # current heading IDs or current line numbers.
                continue
            elif anchor and target.suffix == ".md" and anchor not in document(target)[0]:
                errors.append(f"{relative}: missing anchor: {href}")
        for href in marked:
            if href is None or local_target(root, path, href) != (prompt_path, current_anchor):
                errors.append(f"{relative}: active entry must select the Current prompt: {href}")
    return errors


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=Path(__file__).resolve().parents[1])
    args = parser.parse_args()
    paths = subprocess.check_output(["git", "ls-files", "-z", "--", "*.md"], cwd=args.root)
    files = [Path(p) for p in paths.decode().split("\0") if p]
    errors = check(args.root, files)
    print("\n".join(errors) if errors else f"Documentation OK: {len(files)} tracked Markdown files")
    return bool(errors)


if __name__ == "__main__":
    raise SystemExit(main())
