# Copyright (c) 2026 Ursula Athene. All rights reserved.
# SPDX-License-Identifier: MIT
"""Five-tool smoke test using the installed Python module, not the console wrapper."""
import argparse
import asyncio
import json
import os
from pathlib import Path
import sys
import tempfile

from tools.install_b2_tools import ROOT, TOOLS, require, tool_environment

PROBE = """import PiDisjunctivity
import Mathlib.Tactic
#check @hasSum_nat_add_iff'
#check @pow_sub₀
example (n j : ℕ) (h : j ≤ n) :
    (16 : ℝ) ^ (n - j) = (16 : ℝ) ^ n * ((16 : ℝ) ^ j)⁻¹ := by
  exact pow_sub₀ (16 : ℝ) (by norm_num) h
example : Int.fract Real.pi =
    Int.fract (PiDisjunctivity.bbpRecurrence 1 + PiDisjunctivity.bbpTail 0) := by
  simpa only [pow_zero, one_mul] using
    PiDisjunctivity.fract_pow_mul_pi_eq_bbpRecurrence_add_bbpTail 0
"""
BAD = "import PiDisjunctivity\nexample : (0 : ℕ) = 0 := by\n  exact b2SmokeUnknownIdentifier\n"


async def generated_search(call, sleep=asyncio.sleep):
    """Allow bounded index startup; a negative result is not a nonexistence proof."""
    for delay in (0, 0.25, 0.5, 1, 2, 4):
        if delay:
            await sleep(delay)
        result = await call("lean_local_search", query="hasSum_nat_add", limit=10)
        if any(item["name"] == "hasSum_nat_add_iff'" for item in result["items"]):
            return
        if result.get("index") not in {"unavailable", "warming"}:
            break
    raise ValueError("Generated declaration was not found within the bounded index-startup check")


async def check(output):
    # MCP is installed with the optional tool, never added to the project's lock.
    from mcp import ClientSession
    from mcp.client.stdio import StdioServerParameters, stdio_client
    output.mkdir(parents=True, exist_ok=False)
    records, paths = [], []
    def scratch(text):
        fd, name = tempfile.mkstemp(prefix="B2McpSmoke", suffix=".lean", dir=ROOT)
        with os.fdopen(fd, "w") as stream:
            stream.write(text)
        path = Path(name)
        paths.append(path)
        return path
    def record(label, response):
        records.append({"label": label, "response": response})
        (output / "responses.json").write_text(json.dumps(records, indent=2, ensure_ascii=False) + "\n")
    try:
        probe, diagnostic = scratch(PROBE), scratch(BAD)
        params = StdioServerParameters(command=sys.executable, args=["-m", "lean_lsp_mcp"],
                                       cwd=str(ROOT), env={**os.environ, **tool_environment(ROOT)})
        with (output / "server.log").open("w") as log:
            async with stdio_client(params, errlog=log) as (read, write):
                async with ClientSession(read, write, read_timeout_seconds=90) as session:
                    await session.initialize()
                    listing = await session.list_tools()
                    require({t.name for t in listing.tools} == TOOLS, "Unexpected exposed tools")
                    record("tools", sorted(t.name for t in listing.tools))
                    async def call(name, **args):
                        result = (await session.call_tool(name, args)).model_dump(mode="json")
                        record(name, result)
                        require(not result.get("is_error", result.get("isError", False)), f"MCP failure: {result}")
                        return result.get("structured_content", result.get("structuredContent"))
                    d = (await call("lean_diagnostic_messages", file_path=str(probe), severity="error"))["result"]
                    require(d["success"] and not d["partial"], "Probe did not finish successfully")
                    await generated_search(call)
                    h = await call("lean_hover_info", file_path=str(probe), line=4, column=9)
                    require("pow_sub₀" in h["info"] and "≠ 0" in h["info"], "Hover lacks the expected signature")
                    source = await call("lean_declaration_file", file_path=str(probe), symbol="hasSum_nat_add_iff'", context_lines=2)
                    require("@[to_additive]" in source["content"] and "hasProd_nat_add_iff'" in source["content"], "Wrong generated source")
                    goal = await call("lean_goal", file_path=str(probe), line=7)
                    require(goal["goals_before"] and goal["goals_after"] == [], "Expected open then closed goal")
                    d = (await call("lean_diagnostic_messages", file_path=str(diagnostic), severity="error"))["result"]
                    require(not d["success"] and not d["partial"], "Intentional error was not detected")
                    require(any(i["line"] == 3 and i["column"] == 9 and "b2SmokeUnknownIdentifier" in i["message"] for i in d["items"]), "Wrong diagnostic location")
                    diagnostic.write_text(BAD.replace("b2SmokeUnknownIdentifier", "rfl"))
                    d = (await call("lean_diagnostic_messages", file_path=str(diagnostic), severity="error"))["result"]
                    require(d["success"] and not d["partial"] and not d["items"], "Corrected error did not clear")
        print("Five-tool module/protocol smoke test passed; native app discovery is separate.")
        if (output / "server.log").read_text().strip():
            print(f"Server diagnostics retained at {output / 'server.log'}; clean descendant shutdown is not certified.")
    finally:
        for path in paths:
            path.unlink(missing_ok=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", required=True, type=Path, help="new evidence directory")
    args = parser.parse_args()
    asyncio.run(asyncio.wait_for(check(args.output), timeout=180))
