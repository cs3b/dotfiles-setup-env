---
kind: scenarios
scenarios:
  - scenario_id: SCN-fresh-macos-core
    profiles:
      - PROFILE-core
    platform: OS-macos
    expected: all non-waived core blockers pass
  - scenario_id: SCN-fresh-arch-core
    profiles:
      - PROFILE-core
    platform: OS-arch
    expected: all non-waived core blockers pass
  - scenario_id: SCN-shell-portability
    profiles:
      - PROFILE-core
    platform: any
    expected: shell shortcut and smart-jump parity holds across fish zsh bash
  - scenario_id: SCN-shell-init-chain
    profiles:
      - PROFILE-core
    platform: any
    expected: fish -lc probes succeed and bash login-noninteractive init chain preserves runtime activation
  - scenario_id: SCN-neovim-behavior
    profiles:
      - PROFILE-core
    platform: any
    expected: LazyVim baseline plus hidden-file visibility markdown-preview and path-yank behavior pass
  - scenario_id: SCN-headless-markdown-preview-build
    profiles:
      - PROFILE-core
    platform: any
    expected: markdown-preview build method is headless-safe and does not depend on interactive Neovim runtime functions
  - scenario_id: SCN-optional-profile-disabled
    profiles:
      - PROFILE-core
    platform: any
    expected: optional capabilities are not evaluated as blockers
  - scenario_id: SCN-optional-ai-coding-enabled
    profiles:
      - PROFILE-core
      - PROFILE-optional-ai-coding
    platform: any
    expected: optional profile rules pass or are accepted as documented warnings
  - scenario_id: SCN-tmux-baseline
    profiles:
      - PROFILE-core
    platform: any
    expected: tmux binary exists and reports version
  - scenario_id: SCN-security-hygiene-scan
    profiles:
      - PROFILE-core
    platform: any
    expected: no token-like plaintext secrets in tracked files
  - scenario_id: SCN-install-smoke-after-mutation
    profiles:
      - PROFILE-core
    platform: any
    expected: every installed or upgraded CLI is immediately followed by a passing version or help smoke probe
  - scenario_id: SCN-native-cli-source-selection
    profiles:
      - PROFILE-core
    platform: any
    expected: core AI CLIs use native distribution sources by default and only use wrapper-based alternatives with explicit documented exception
  - scenario_id: SCN-bun-global-shebang-compatibility
    profiles:
      - PROFILE-core
    platform: any
    expected: Bun global CLI entrypoints execute successfully in the target runtime environment without hidden node runtime dependency failures
---
# Validation Scenarios

Defines portable scenarios that consumers should evaluate against this contract.
