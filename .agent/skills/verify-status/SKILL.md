---
name: verify-status
description: Report current system vs instruction status with evidence, without applying changes.
---

# verify-status

Use this skill when the user wants a pure status report.

## Trigger Conditions
- "verify"
- "status"
- "compliance report"
- "show current drift"

## Inputs
- Instruction contract.
- Current system probes.

## Workflow
1. Run deterministic probes for defined rules.
2. Evaluate each rule status.
3. Produce summary and evidence.
4. Do not propose or execute changes unless explicitly requested.

## Output Contract
- Per-rule status list.
- Aggregated counts (pass, warn, fail, waived, not-applicable).
- Evidence snippets per failed or warned rule.

## Guardrails
- Read-only behavior by default.
- No mutation commands.
- Prefer live system evidence for runtime/config rules (for example `~/.config/...`); repo templates are reference material only.
- Exclude `.git/` from repository text-search probes.

## References
- Report format: `references/report-format.md`
- Evidence policy: `references/evidence-collection.md`
