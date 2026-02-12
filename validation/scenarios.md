# Validation Scenarios

## Scenario 1: Fresh macOS Core
- Profile: `PROFILE-core`
- Platform: `OS-macos`
- Expected result: all `blocker` rules pass across core capabilities.

## Scenario 2: Fresh Arch Core
- Profile: `PROFILE-core`
- Platform: `OS-arch`
- Expected result: all `blocker` rules pass with Arch package mappings.

## Scenario 3: Shell Portability
- Profile: `PROFILE-core`
- Platform: any
- Variation: switch primary shell between fish, zsh, bash.
- Expected result: shell capability rules still pass with equivalent abbreviations/aliases/functions and smart-jump behavior in each shell.

## Scenario 4: Neovim Behavior
- Profile: `PROFILE-core`
- Platform: any
- Expected result: LazyVim baseline plus hidden-file visibility, markdown preview, and path-yank behavior pass validation.

## Scenario 5: Optional Profile Disabled
- Profile: `PROFILE-core`
- Platform: any
- Expected result: optional capabilities are not evaluated as blockers.

## Scenario 6: Optional AI Coding Enabled
- Profile: `PROFILE-core` + `PROFILE-optional-ai-coding`
- Platform: any
- Expected result: optional profile rules pass or are documented as accepted warnings, including auth-readiness checks for installed AI CLIs.

## Scenario 7: tmux Baseline
- Profile: `PROFILE-core`
- Platform: any
- Expected result: tmux binary exists and reports version; tmux configuration details are not required for pass.

## Scenario 8: Security Hygiene Scan
- Profile: `PROFILE-core`
- Platform: any
- Expected result: no token-like plaintext secrets in tracked files; no inline literal secrets in tracked shell startup configs.
