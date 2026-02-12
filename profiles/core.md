# Core Profile

## Profile ID
`PROFILE-core`

## Purpose
Defines the minimum environment contract required on both macOS and Arch.

## Included Capabilities
- `CAP-shell`
- `CAP-package-tooling`
- `CAP-editor-neovim`
- `CAP-version-manager`
- `CAP-ssh-git-access`
- `CAP-fonts-terminal`
- `CAP-terminal-multiplexer`
- `CAP-security-hygiene`

## Validation Policy
- All `blocker` rules in included capabilities must pass.
- `warn` rules should pass; failures must be documented as accepted risk.

## Explicitly Excluded
- `CAP-deploy-firebase`
- AI-specific helper toolchains beyond baseline shell shortcuts
