---
name: system-sync-instructions
description: Compare live system state to setup instructions and propose contract additions or corrections to remove drift.
---

# system-sync-instructions

Use this skill when the user wants to align instructions with what exists on the machine.

## Trigger Conditions
- "sync system with instructions"
- "what is missing in instructions"
- "detect instruction drift"

## Inputs
- Live system probes (commands, binaries, config files).
- Current instruction contract.

## Workflow
1. Collect evidence from system probes.
2. Map evidence to existing capability and rule definitions.
3. Classify findings:
   - system-present but instruction-missing
   - instruction-defined but system-not-found
   - semantic mismatch
   - package-name vs command-name canonicalization mismatch (for example `opencode-ai` package -> `opencode` command)
   - probe scope mismatch (for example security scan matching contract docs instead of runtime/config artifacts)
4. Produce proposal to update instructions.
5. Apply only if user explicitly asks.

## Output Contract
- Drift matrix table.
- Proposed instruction additions and edits by file.
- Priority order (blocker impact first).

## Guardrails
- Do not auto-edit contracts by default.
- Do not treat one-off local tools as baseline requirements without user confirmation.
- Record package-name and command-name separately when they differ.

## References
- Mapping model: `references/mapping-model.md`
- Probe catalog: `references/probe-catalog.md`
