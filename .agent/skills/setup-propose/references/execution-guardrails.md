# Execution Guardrails

## Mutations
- Execute only with explicit user request.
- Confirm when command is destructive, privileged, or external-network heavy.

## Verification
- Re-run relevant probes after mutation.
- Report residual failures explicitly.
