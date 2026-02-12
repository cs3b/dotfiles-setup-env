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
