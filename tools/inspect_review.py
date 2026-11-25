# Copyright (c) 2026 Ursula Athene. All rights reserved.
# SPDX-License-Identifier: MIT
"""Inspect saved execution chunks, without invoking or retrying a reviewer."""

import argparse
import json
from pathlib import Path
import re


def inspect(chunks, attested=False):
    """Transport evidence and terminal success are distinct from human acceptance.

    Each chunk is the execution tool's complete JSON result plus sequence,
    requested_max_tokens, captured_at, and (on chunk zero) started_at.
    Caller attestation is necessary: missing unsaved output cannot be inferred.
    """
    capture_issues, errors, denials, diagnostics, progress = [], [], [], [], []
    events = []
    exits = []
    pending_text = ""
    for index, chunk in enumerate(chunks):
        if chunk.get("sequence") != index:
            capture_issues.append(f"Chunk {index}: missing/out-of-order sequence")
        if not chunk.get("captured_at") or (index == 0 and not chunk.get("started_at")):
            capture_issues.append(f"Chunk {index}: missing caller timestamp")
        budget, count = chunk.get("requested_max_tokens"), chunk.get("original_token_count")
        if not isinstance(budget, int) or not isinstance(count, int):
            capture_issues.append(f"Chunk {index}: missing token budget/count")
        elif count > budget:
            capture_issues.append(f"Chunk {index}: output exceeds capture budget")
        output = chunk.get("output", "")
        if chunk.get("truncated") or re.search(r"(?:Warning: truncated output|tokens truncated|Output truncated)", output, re.I):
            capture_issues.append(f"Chunk {index}: reported truncation")
        if chunk.get("exit_code") is not None:
            exits.append(chunk["exit_code"])
            if index != len(chunks) - 1:
                capture_issues.append("Output chunks appear after process exit")
        lines = (pending_text + output).splitlines(keepends=True)
        pending_text = ""
        if lines and not lines[-1].endswith("\n") and index < len(chunks) - 1:
            pending_text = lines.pop()
        for line in lines:
            if not line.strip():
                continue
            try:
                event = json.loads(line)
            except ValueError:
                if line.lstrip().startswith("{"):
                    capture_issues.append(f"Chunk {index}: incomplete/malformed JSON event")
                else:
                    diagnostics.append(line)
                continue
            if not isinstance(event, dict) or "event" not in event:
                diagnostics.append(line)
                continue
            events.append(event)
            kind = event["event"]
            payload = event.get(kind, {})
            if not isinstance(payload, dict):
                capture_issues.append(f"Malformed {kind} payload")
                continue
            if kind == "error" or payload.get("error"):
                errors.append(event)
            if payload.get("denied_actions"):
                denials.append(payload["denied_actions"])
            if kind == "step_update":
                # Keep structured tool failures visible for caller coverage triage.
                if payload.get("state") in ("ERROR", "FAILED", "DENIED"):
                    errors.append(event)
                if payload.get("tool_name") or payload.get("text_delta") or payload.get("usage"):
                    progress.append({"captured_at": chunk.get("captured_at"),
                                     "step_index": payload.get("step_index"),
                                     "tool_name": payload.get("tool_name"),
                                     "state": payload.get("state"),
                                     "text_delta": bool(payload.get("text_delta")),
                                     "usage": payload.get("usage")})
    inits = [e for e in events if e["event"] == "init"]
    results = [e.get("result", {}) for e in events if e["event"] == "result"]
    if len(inits) != 1:
        capture_issues.append("Expected one init event")
    if len(results) != 1 or not events or events[-1]["event"] != "result":
        capture_issues.append("Expected one terminal result event")
    if len(exits) != 1:
        capture_issues.append("Expected one observed process exit")
    result = results[-1] if results and isinstance(results[-1], dict) else {}
    response = result.get("response")
    exit_code = exits[-1] if exits else None
    reasons = []
    if exit_code != 0:
        reasons.append("Process exit missing or nonzero")
    if result.get("status") != "SUCCESS":
        reasons.append("Terminal status is not SUCCESS")
    if not isinstance(response, str) or not response.strip():
        reasons.append("Empty/missing response")
    # Unrecognized finished reasons are conservative failures, not success.
    if result.get("finished_reason") not in (None, "", "stop", "completed"):
        reasons.append("Terminal finished_reason requires investigation")
    if errors:
        reasons.append("Structured errors/tool failures reported")
    if denials:
        reasons.append("Denied actions require coverage assessment")
    completeness = "incomplete" if capture_issues else "complete" if attested else "unverified"
    candidate = not reasons and completeness == "complete"
    return {"capture_completeness": completeness, "capture_issues": capture_issues,
            "process_exit": exit_code, "init": inits[0] if inits else None,
            "terminal_result": result, "errors": errors, "denials": denials,
            "diagnostics": diagnostics, "progress": progress,
            "review_completion": "candidate_for_human_acceptance" if candidate else "incomplete_or_unverified",
            "reasons": reasons,
            "human_assessment": "Required: substantive findings or explicit no-findings, scope coverage, "
                                "diagnostics/denials, and correctness. No findings is not proof."}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("chunks", nargs="+", type=Path, help="Execution chunk JSON files in capture order")
    parser.add_argument("--attest-complete", action="store_true",
                        help="Caller verified every execution chunk was saved losslessly")
    parser.add_argument("--report", type=Path, required=True, help="New full inspection report")
    args = parser.parse_args()
    try:
        chunks = [json.loads(path.read_text()) for path in args.chunks]
        result = inspect(chunks, args.attest_complete)
        with args.report.open("x") as output:
            json.dump(result, output, indent=2)
            output.write("\n")
    except (OSError, ValueError, TypeError, AttributeError) as error:
        parser.exit(1, f"Capture inspection failed: {error}\n")
    summary = {key: result[key] for key in ("capture_completeness", "process_exit", "review_completion", "reasons")}
    summary["capture_issues"] = result["capture_issues"]
    summary["diagnostic_lines_to_inspect"] = len(result["diagnostics"])
    summary["full_report"] = str(args.report)
    print(json.dumps(summary, indent=2))
    print(result["human_assessment"])
    return result["review_completion"] != "candidate_for_human_acceptance"


if __name__ == "__main__":
    raise SystemExit(main())
