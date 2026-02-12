# Agent Instructions

## Purpose
This repository defines environment requirements as outcome contracts.

## Operating Rules
- Keep this repository specification-only.
- Do not add provisioning/install scripts unless explicitly requested.
- Keep requirements outcome-based and testable.
- Keep YAML frontmatter canonical and Markdown body explanatory.

## Required Workflow
1. Read `CONTRACT.md` first.
2. Update contract frontmatter in relevant `capabilities/`, `profiles/`, `os/`, or `validation/` files.
3. Keep references synchronized across all contract files.
4. Run `tools/build-index.sh` and `tools/validate-contract.sh`.
5. Record meaningful changes in `CHANGELOG.md`.

## Scope Boundaries
- In scope: intentions, validation criteria, profile composition, OS constraints, waiver policy.
- Out of scope by default: installation scripts, provisioning commands, secret values.

## Security
- Never include plaintext credentials, API keys, or access tokens in tracked files.
- Keep secret handling guidance policy-level only.
