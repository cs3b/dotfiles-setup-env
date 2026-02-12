---
kind: profile
profile_id: PROFILE-core
included_capabilities:
  - CAP-shell
  - CAP-package-tooling
  - CAP-editor-neovim
  - CAP-version-manager
  - CAP-ssh-git-access
  - CAP-fonts-terminal
  - CAP-terminal-multiplexer
  - CAP-security-hygiene
validation_policy:
  blockers_required: true
  warns_should_pass: true
  warn_failure_requires_ack: true
---
# Core Profile

Defines the minimum environment contract required on both macOS and Arch Linux.
