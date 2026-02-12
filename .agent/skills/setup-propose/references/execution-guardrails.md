# Execution Guardrails

## Mutations
- Execute only with explicit user request.
- Confirm when command is destructive, privileged, or external-network heavy.
- Do not run network installs in the same parallel batch as unrelated safe file writes.
- Install global CLI packages one at a time to isolate failures.
- Prefer native package manager installs for core CLIs before JS wrapper distributions.
- Pair every install command with an immediate smoke probe (`<command> --version` or noninteractive help) before starting the next mutation.
- For Bun global installs, verify entrypoint shebang/runtime compatibility and avoid hardcoded runtime paths when remediating.

## Verification
- Re-run relevant probes after mutation.
- Report residual failures explicitly.
- If any probe returns empty output, run a second focused verification pass before concluding fail.
- Do not mark an install successful if the command exists but fails to execute.
