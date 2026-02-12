# setup-env

Specification-first environment contract for developer setup on macOS and Arch Linux.

This repository stores:
1. Human-readable intentions in Markdown.
2. Machine-readable contract data in YAML frontmatter.
3. Deterministic validation rules and policy waivers.

It does not store provisioning scripts or secret values.

## Reading Order
1. `CONTRACT.md`
2. `profiles/*.md`
3. `capabilities/*.md`
4. `os/*.md`
5. `validation/scenarios.md`
6. `validation/checklist.md`
7. `contracts/runner-contract.yaml`

## Authoring Model
- Every contract markdown file starts with YAML frontmatter.
- Frontmatter is canonical for tooling.
- Markdown body explains intent and operational notes.

## Validation
Run local contract checks:

```bash
tools/validate-contract.sh
```

What is enforced:
- schema/shape validity
- ID uniqueness
- cross-file reference integrity
- checklist coverage for every rule
- waiver correctness and expiry policy
- generated index parity (`contracts/index.yaml`)

## Non-Goals
- No installation or bootstrap scripts.
- No secret distribution flow.
- No implementation-specific plugin manager instructions.
