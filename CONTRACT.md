# Contract Invariants (v0 Snapshot)

## Purpose
This file defines non-negotiable invariants for `setup-env` contract data.

## Invariants
1. Contract data is authored in Markdown with YAML frontmatter.
2. Frontmatter is canonical for machine validation.
3. Rule severities are only `blocker` or `warn`.
4. Capability status is only `required` or `optional:<profile-id>`.
5. Every referenced ID must resolve to an existing entity.
6. Every declared rule must be categorized in `validation/checklist.md`.
7. Waivers are centralized in `validation/waivers.yaml`.
8. Active waivers must have non-expired `expires_on` dates.
9. `contracts/index.yaml` is generated and must match source contracts.

## Compliance Decision
A run is compliant when all non-waived `blocker` rules pass.

A run is compliant with caveats when only `warn` rules fail.

A run is non-compliant when any non-waived `blocker` fails.

## Scope
In scope:
- intentions
- validation rules
- profile composition
- os constraints
- scenario and checklist contracts
- waiver policy

Out of scope:
- provisioning scripts
- platform bootstrap automation
- secret values
