# setup-env

System setup as a product:
- Markdown + YAML contracts for machine setup intent and verification.
- Agent skills that work across tools, prewired for Codex and Claude.

## Why this exists
Most dotfiles repos are scripts and one-off shell tweaks. This repo is different:
- Define setup as a clear contract (what must be true).
- Verify compliance deterministically (what passes and fails).
- Keep instructions portable across machines and agents.

## Value
- Single source of truth for environment requirements.
- Contract-first model: human-readable docs + machine-validated structure.
- Repeatable verification via `tools/validate-contract.sh`.
- Shared skill catalog under `.agent/skills` with repo-local links:
  - `.codex/skills -> ../.agent/skills`
  - `.claude/skills -> ../.agent/skills`

## Quick Start
Start here: [`STARTHERE.MD`](STARTHERE.MD)

## Demo
![setup-env demo](assets/setup-env-demo.gif)

## What is in this repo
- `capabilities/`: capability contracts and rule definitions.
- `profiles/`: composed capability sets (core and optional).
- `os/`: platform-specific constraints.
- `validation/`: scenarios, checklist, and waivers.
- `schemas/`: contract schema definitions.
- `contracts/`: generated contract index and runner contract.
- `tools/`: validation and index-generation scripts.
- `.agent/skills/`: reusable cross-agent skills.

## Authoring Model
- Every contract markdown file starts with YAML frontmatter.
- YAML frontmatter is canonical for tooling.
- Markdown body carries explanation and operational context.

## Validation
```bash
tools/validate-contract.sh
```

Enforced checks:
- schema validity
- unique IDs
- cross-file references
- rule coverage in checklist
- waiver integrity and expiry
- generated index parity (`contracts/index.yaml`)

## Non-Goals
- Provisioning/bootstrap scripts in this repo.
- Secret values in tracked files.
