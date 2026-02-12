---
kind: capability
capability_id: CAP-package-tooling
status: required
intentions:
  - Core CLI toolchain exists for search, file inspection, structured data, git workflows, HTTP requests, benchmarking, and process/system inspection.
  - Tool names are discoverable on PATH.
  - Equivalent alternatives are acceptable only when they preserve operational capability.
  - Native-installed AI coding CLIs are present for codex and claude.
  - Git bootstrap helper command gh-init is available.
rules:
  - rule_id: VAL-package-tooling-01
    assertion: Search and file-discovery tools exist.
    method: Verify rg and fd binaries.
    pass_condition: Both commands are available.
    severity: blocker
  - rule_id: VAL-package-tooling-02
    assertion: Structured data tooling exists.
    method: Verify jq and yq binaries.
    pass_condition: Both commands are available.
    severity: blocker
  - rule_id: VAL-package-tooling-03
    assertion: Git workflow helpers exist.
    method: Verify git, gh, delta, lazygit, and git-lfs binaries.
    pass_condition: All commands are available.
    severity: blocker
  - rule_id: VAL-package-tooling-04
    assertion: Terminal productivity tools exist.
    method: Verify bat, eza, dust, bottom or btm, procs, hyperfine, xh, tldr, and bandwhich.
    pass_condition: Listed capabilities are present with noted name variants.
    severity: warn
  - rule_id: VAL-package-tooling-05
    assertion: Native AI coding CLIs are installed.
    method: Verify codex --version and claude --version or equivalent version/help probes.
    pass_condition: Both commands are available from native system install paths.
    severity: blocker
  - rule_id: VAL-package-tooling-06
    assertion: Git bootstrap helper gh-init is available.
    method: Verify command -v gh-init.
    pass_condition: Command resolves on PATH.
    severity: warn
os_package_mapping:
  - canonical_capability: ripgrep
    macos_package_id: ripgrep
    arch_package_id: ripgrep
    notes: Required.
  - canonical_capability: fd
    macos_package_id: fd
    arch_package_id: fd
    notes: Required.
  - canonical_capability: bat
    macos_package_id: bat
    arch_package_id: bat
    notes: Recommended.
  - canonical_capability: eza
    macos_package_id: eza
    arch_package_id: eza
    notes: Recommended.
  - canonical_capability: dust
    macos_package_id: dust
    arch_package_id: dust
    notes: Recommended.
  - canonical_capability: bottom
    macos_package_id: bottom
    arch_package_id: bottom
    notes: Binary may be btm.
  - canonical_capability: jq
    macos_package_id: jq
    arch_package_id: jq
    notes: Required.
  - canonical_capability: yq
    macos_package_id: yq
    arch_package_id: yq
    notes: Required.
  - canonical_capability: procs
    macos_package_id: procs
    arch_package_id: procs
    notes: Recommended.
  - canonical_capability: hyperfine
    macos_package_id: hyperfine
    arch_package_id: hyperfine
    notes: Recommended.
  - canonical_capability: zoxide
    macos_package_id: zoxide
    arch_package_id: zoxide
    notes: Recommended.
  - canonical_capability: starship
    macos_package_id: starship
    arch_package_id: starship
    notes: Recommended.
  - canonical_capability: git-delta
    macos_package_id: git-delta
    arch_package_id: git-delta
    notes: Required for enhanced diff ergonomics.
  - canonical_capability: xh
    macos_package_id: xh
    arch_package_id: xh
    notes: Recommended.
  - canonical_capability: tealdeer
    macos_package_id: tealdeer
    arch_package_id: tealdeer
    notes: Recommended.
  - canonical_capability: bandwhich
    macos_package_id: bandwhich
    arch_package_id: bandwhich
    notes: Recommended.
  - canonical_capability: lazygit
    macos_package_id: lazygit
    arch_package_id: lazygit
    notes: Required.
  - canonical_capability: github-cli
    macos_package_id: gh
    arch_package_id: github-cli
    notes: Required.
  - canonical_capability: git-lfs
    macos_package_id: git-lfs
    arch_package_id: git-lfs
    notes: Required.
  - canonical_capability: codex-cli
    macos_package_id: codex
    arch_package_id: codex
    notes: Required native install.
  - canonical_capability: claude-cli
    macos_package_id: claude-code
    arch_package_id: claude-code-bin
    notes: Required native install.
  - canonical_capability: gh-init-helper
    macos_package_id: custom-tooling
    arch_package_id: custom-tooling
    notes: Recommended for repository bootstrap flow.
known_exceptions:
  - id: EXC-package-tooling-01
    statement: Functionally equivalent binaries may replace listed tools if validation probes are updated.
    compliance_impact: warn
---
# Package Tooling Capability

This capability defines required and recommended command-line tooling outcomes.
