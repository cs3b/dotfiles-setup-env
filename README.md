# Setup Environment Spec

## Purpose
This folder defines environment requirements as:
1. Intentions (what must be true).
2. Validation rules (how to verify truth).

It is implementation-agnostic. It does not prescribe installation or configuration procedures.

## Scope
- Platforms: macOS and Arch Linux.
- Shells: fish, zsh, bash.
- Editor baseline: LazyVim-based Neovim behavior.
- Tooling baseline: CLI capabilities required for daily workflows.

## Reading Order
1. `SPEC_CONTRACT.md`
2. `profiles/core.md`
3. `capabilities/*.md`
4. `os/macos.md` or `os/arch.md`
5. `validation/scenarios.md`
6. `validation/checklist.md`

## Compliance Policy
- `core` profile rules are mandatory.
- `optional:*` profile rules are evaluated only when that profile is enabled.
- `blocker` failures mean environment is not compliant.
- `warn` failures mean environment is compliant with caveats.

## Non-Goals
- No step-by-step setup instructions.
- No secret management instructions.
- No implementation-specific plugin manager or package manager scripts.
