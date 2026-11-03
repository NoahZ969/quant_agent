# quant_agent

A learning project: build an AI agent from scratch, then grow it into a small
research loop that proposes, implements, and scores equity factors.

## Design

| Piece | What it is | Status |
|---|---|---|
| `agent/` | One agent loop (Messages API + tools), reused for every role | stage 1 |
| `prompts/` | System prompts for the planner and researcher roles | stage 3 |
| `evaluator/` | Backtester + holdout scoring. Plain Python, no LLM | stage 2 |
| `orchestrator/` | Runs a cycle: planner → researchers → evaluator → report | stage 3 |
| `docker/` | Sandbox image for the researcher (no holdout data mounted) | stage 2 |
| `scripts/` | Data fetching, cycle entry point, scheduler files | ongoing |

Rules:
- The researcher never sees holdout data. Enforced by what the container mounts, not by instructions.
- The evaluator decides pass/fail in code. An LLM may add commentary, never the verdict.
- Researcher and evaluator use the same backtester.

## Setup (any machine)

```bash
git clone git@github.com:NoahZ969/quant_agent.git
cd quant_agent
uv sync                      # installs pinned dependencies into .venv
cp .env.example .env         # then add your API key
```

Keep the project in the Linux home folder (WSL: `~/...`, not `/mnt/c/...`).

## Machine notes

- **Windows (current):** run inside WSL2 Ubuntu; Docker Desktop with WSL integration on.
  Scheduler: Task Scheduler calling `wsl.exe -d Ubuntu -- <repo>/scripts/run_cycle.sh`.
- **macOS (later):** same steps; scheduler via a launchd plist in `scripts/schedule/`.
