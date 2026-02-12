# Execution Guardrails

## Mutations
- Execute only with explicit user request.
- Confirm when command is destructive, privileged, or external-network heavy.
- Do not run network installs in the same parallel batch as unrelated safe file writes.
- Install global CLI packages one at a time to isolate failures.

## Verification
- Re-run relevant probes after mutation.
- Report residual failures explicitly.
- If any probe returns empty output, run a second focused verification pass before concluding fail.
