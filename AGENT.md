# Agent Instructions

## Purpose
This repository defines environment requirements as **intentions** and **validation rules** for macOS and Arch Linux.

## Operating Rules
- Treat this repo as specification-only.
- Do not add implementation how-to steps unless explicitly requested.
- Keep requirements outcome-based and testable.
- Follow `SPEC_CONTRACT.md` for every capability file.

## Required Workflow
1. Read `README.md` and `SPEC_CONTRACT.md` first.
2. Update or add capability specs under `capabilities/` using the required section schema.
3. Keep profile membership accurate in `profiles/`.
4. Keep scenario and checklist coverage aligned in `validation/`.
5. Record every meaningful change in `CHANGELOG.md`.

## Validation Conventions
- Rule IDs use: `VAL-<capability>-NN`.
- Severities are only: `blocker` or `warn`.
- `core` profile blockers must pass for compliance.

## Scope Boundaries
- In scope: intentions, validation criteria, OS package mapping, compliance policy.
- Out of scope by default: installation scripts, provisioning commands, secret values.

## Security
- Never include plaintext credentials, API keys, or access tokens in tracked files.
- Keep secret handling guidance policy-level only.

## Change Quality Bar
- Ensure any new rule ID is referenced in `validation/checklist.md`.
- Ensure new capability/profile relationships are reflected in `profiles/*.md` and `validation/scenarios.md`.
- Prefer small, traceable spec changes with explicit rationale in changelog entries.
