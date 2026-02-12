# Contribution Guide

## Scope
This repository is contract-first configuration for developer environments.
Contributions should improve:
- capability contracts
- profile composition
- OS constraints
- validation and waiver policy
- agent skills under `.agent/skills`

## Authoring Rules
- Contract files are Markdown with YAML frontmatter.
- YAML frontmatter is canonical for tooling.
- Markdown body should explain intent, not duplicate machine fields.
- Keep IDs stable unless a rename is explicitly required.
- Do not add provisioning scripts or secrets.

## Required Checks
Before opening a PR, run:

```bash
tools/build-index.sh contracts/index.yaml
tools/validate-contract.sh
```

Validation enforces:
- schema validity
- unique IDs
- cross-file reference integrity
- checklist coverage for all rules
- waiver integrity and expiry policy
- generated index parity

## Mandatory Preflight (Before Execution Plans)
1. Validate package names before proposing install commands.
2. Validate shell initialization chain for login-noninteractive contexts:
   - `.bash_profile -> .bashrc`
   - at least one `bash -lc` probe and one `fish -lc` probe
3. Validate headless-safe Neovim plugin build methods when plugin bootstrap is in scope.
4. Separate package name and command name when they differ (for example package `opencode-ai`, command `opencode`).
5. Prefer native binary distributions for core CLIs before JS wrapper installs.

## Mandatory Execution Batching Rules
1. Do not combine high-risk network installs with unrelated safe file writes in the same parallel batch.
2. Install global CLI packages one at a time.
3. Group probes in parallel batches of at most 8-10 commands.
4. If probe output is empty, run a second focused verification pass before concluding failure.
5. After every install or upgrade command, run an immediate smoke probe (`<command> --version` or noninteractive help) before continuing.

## Mandatory Verification Rules
1. Shell parity checks must include runtime probes for both bash and fish, not only static file inspection.
2. Security token scans must exclude contract documentation files from match scope.
3. Headless plugin installation checks must use noninteractive-safe build methods.
4. Bun global CLI verification must include entrypoint runtime compatibility checks (avoid hidden `#!/usr/bin/env node` failures).

## Typical Change Flow
1. Update relevant files (`capabilities/`, `profiles/`, `os/`, `validation/`).
2. Ensure checklist and scenarios remain aligned.
3. Rebuild `contracts/index.yaml`.
4. Run validation.
5. Update `CHANGELOG.md` with meaningful summary.

## Skills
Skill source of truth is `.agent/skills`.
Repo-local links are:
- `.codex/skills -> ../.agent/skills`
- `.claude/skills -> ../.agent/skills`

When adding a skill:
- include `SKILL.md` with `name` and `description` frontmatter
- keep instructions concise and procedural
- put deep details into `references/`
