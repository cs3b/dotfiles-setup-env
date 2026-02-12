---
name: system-manage
description: Manage setup instruction definitions by adding, updating, or removing capabilities, rules, profiles, and mappings with consistency checks.
---

# system-manage

Use this skill when the user wants to change the instruction contract itself.

## Trigger Conditions
- Add, update, or remove system definition entries.
- Refactor capability/profile/os contracts.
- Modify validation/checklist/scenario structure.

## Inputs
- Current instruction contracts (markdown + yaml frontmatter).
- Explicit requested change.

## Workflow
1. Locate all impacted definition files.
2. Propose exact contract edits and affected IDs.
3. Check referential integrity impact (rules, profiles, checklists, scenarios, waivers).
4. Default behavior: propose patch only.
5. If user explicitly asks to execute, apply edits and re-run contract checks.

## Output Contract
- Change summary by file.
- Added, removed, and changed IDs.
- Integrity impact list.
- Validation result after change (if executed).

## Guardrails
- Do not mutate system state outside instruction files unless explicitly asked.
- Never remove IDs without reporting downstream references.
- Preserve deterministic contract structure.

## References
- Decision policy: `references/decision-rules.md`
- Safety policy: `references/change-safety.md`
