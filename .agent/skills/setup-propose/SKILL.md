---
name: setup-propose
description: Evaluate system compliance against setup instructions and propose concrete remediation steps, executing only on explicit request.
---

# setup-propose

Use this skill when the user wants to know what to change on the machine to match the instructions.

## Trigger Conditions
- "setup to match instructions"
- "what should I install or change"
- "generate remediation plan"

## Inputs
- Instruction contract.
- Current system status.

## Workflow
1. Evaluate rule status: pass, warn, fail, not-applicable.
2. Build prioritized remediation plan:
   - blocker failures first
   - warn failures second
3. Provide command-level suggestions and risk notes.
4. Default behavior: proposal only.
5. If explicitly requested, execute selected steps and re-verify.

## Output Contract
- Ordered remediation steps.
- Expected impact per step.
- Safety flags (safe, manual, privileged, destructive).

## Guardrails
- Never mutate by default.
- Request confirmation before privileged or destructive actions.
- Re-check status after every executed batch.

## References
- Prioritization: `references/remediation-priority.md`
- Execution policy: `references/execution-guardrails.md`
