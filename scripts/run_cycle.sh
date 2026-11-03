#!/usr/bin/env bash
# Entry point that a scheduler (Windows Task Scheduler now, launchd later) calls.
# Runs one research cycle from the project root, whatever directory it's called from.
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

# Placeholder until the orchestrator exists (stage 3).
echo "run_cycle: orchestrator not implemented yet ($(date -Iseconds))"
