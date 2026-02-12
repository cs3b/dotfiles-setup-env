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
1. Run mandatory preflight checks before planning any mutation:
   - verify package names exist before install commands are proposed
   - verify native distribution availability for required CLIs before proposing JS-wrapper installs
   - verify shell init chain coverage for login-noninteractive probes (`.bash_profile -> .bashrc`)
   - verify headless-safe plugin build methods for Neovim dependencies
   - verify Bun global install runtime assumptions (including shebang/runtime compatibility)
2. Evaluate rule status: pass, warn, fail, not-applicable.
3. Build prioritized remediation plan:
   - blocker failures first
   - warn failures second
4. Build execution batches by risk class:
   - safe local edits and reads in one batch
   - network installs in isolated batches
   - one global CLI package per install command
5. Pair every install step with an immediate smoke probe command (`<command> --version` or noninteractive help).
6. Provide command-level suggestions and risk notes.
7. Default behavior: proposal only.
8. If explicitly requested, execute selected steps and run two-pass verification:
   - pass 1: full probe run
   - pass 2: re-run probes that returned empty or ambiguous output

## Output Contract
- Ordered remediation steps.
- Expected impact per step.
- Safety flags (safe, manual, privileged, destructive).

## Guardrails
- Never mutate by default.
- Request confirmation before privileged or destructive actions.
- Re-check status after every executed batch.
- Never mix high-risk network installs with unrelated file writes in the same parallel batch.
- Treat package-name and command-name mismatches as blocking planning errors until clarified.
- Treat an install as incomplete until the immediate smoke probe passes.

## References
- Prioritization: `references/remediation-priority.md`
- Execution policy: `references/execution-guardrails.md`
