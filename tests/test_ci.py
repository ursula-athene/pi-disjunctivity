# Copyright (c) 2026 Ursula Athene. All rights reserved.
# SPDX-License-Identifier: MIT
"""Guard the build/audit and offline process-check wiring, not remote execution."""
from pathlib import Path
import unittest

import yaml


class CIContract(unittest.TestCase):
    def test_required_jobs_and_checks(self):
        root = Path(__file__).resolve().parents[1]
        workflow = yaml.load((root / ".github/workflows/lean_action_ci.yml").read_text(),
                             Loader=yaml.BaseLoader)
        self.assertEqual(set(workflow["on"]), {"push", "pull_request", "workflow_dispatch"})
        self.assertEqual(workflow["permissions"], {"contents": "read"})
        jobs = workflow["jobs"]
        self.assertEqual(jobs["build"], {
            "runs-on": "ubuntu-24.04",
            "steps": [{"uses": "actions/checkout@v7"},
                      {"uses": "leanprover/lean-action@v1"},
                      {"name": "Check formulation statements and axioms",
                       "run": "lake env lean Test.lean"}]})
        process = jobs["process"]
        self.assertNotIn("if", process)
        self.assertNotIn("continue-on-error", process)
        commands = [step["run"] for step in process["steps"] if "run" in step]
        self.assertEqual(commands, ["uv sync --locked",
                         "uv run --locked --offline python -m unittest discover -s tests -v",
                         "uv run --locked --offline python tools/check_docs.py"])
        for step in process["steps"]:
            self.assertNotIn("continue-on-error", step)
            self.assertNotIn("if", step)
        self.assertEqual(jobs["docs"]["needs"], "build")


if __name__ == "__main__":
    unittest.main()
