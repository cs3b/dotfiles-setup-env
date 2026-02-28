---
kind: capability
capability_id: CAP-package-tooling
status: required
intentions:
- Core CLI toolchain exists for search, file inspection, structured data, git workflows,
  HTTP requests, benchmarking, and process/system inspection.
- Tool names are discoverable on PATH.
- Equivalent alternatives are acceptable only when they preserve operational capability.
- Native-installed AI coding CLIs are present for codex and claude.
- Git bootstrap helper command gh-init is available.
- Package names and command names are documented separately when they differ.
- Install steps are not considered complete until an immediate command smoke probe
  succeeds.
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
  method: Verify bat, eza, dust, bottom or btm, procs, hyperfine, xh, tldr, bandwhich,
    and less.
  pass_condition: Listed capabilities are present with noted name variants.
  severity: warn
- rule_id: VAL-package-tooling-05
  assertion: Native AI coding CLIs are installed.
  method: Verify native package source selection for codex and claude, then run codex
    --version and claude --version or equivalent version/help probes.
  pass_condition: Both commands are available from native system install paths and
    pass immediate post-install smoke probes.
  severity: blocker
- rule_id: VAL-package-tooling-06
  assertion: Git bootstrap helper gh-init is available.
  method: Verify command -v gh-init.
  pass_condition: Command resolves on PATH.
  severity: warn
os_package_mapping:
- canonical_capability: ripgrep
  notes: Required.
  os_package_ids:
    OS-macos: ripgrep
    OS-arch: ripgrep
    OS-nixos: ripgrep
- canonical_capability: fd
  notes: Required.
  os_package_ids:
    OS-macos: fd
    OS-arch: fd
    OS-nixos: fd
- canonical_capability: bat
  notes: Recommended.
  os_package_ids:
    OS-macos: bat
    OS-arch: bat
    OS-nixos: bat
- canonical_capability: eza
  notes: Recommended.
  os_package_ids:
    OS-macos: eza
    OS-arch: eza
    OS-nixos: eza
- canonical_capability: dust
  notes: Recommended.
  os_package_ids:
    OS-macos: dust
    OS-arch: dust
    OS-nixos: dust
- canonical_capability: bottom
  notes: Binary may be btm.
  os_package_ids:
    OS-macos: bottom
    OS-arch: bottom
    OS-nixos: bottom
- canonical_capability: jq
  notes: Required.
  os_package_ids:
    OS-macos: jq
    OS-arch: jq
    OS-nixos: jq
- canonical_capability: yq
  notes: Required.
  os_package_ids:
    OS-macos: yq
    OS-arch: yq
    OS-nixos: yq
- canonical_capability: procs
  notes: Recommended.
  os_package_ids:
    OS-macos: procs
    OS-arch: procs
    OS-nixos: procs
- canonical_capability: hyperfine
  notes: Recommended.
  os_package_ids:
    OS-macos: hyperfine
    OS-arch: hyperfine
    OS-nixos: hyperfine
- canonical_capability: zoxide
  notes: Recommended.
  os_package_ids:
    OS-macos: zoxide
    OS-arch: zoxide
    OS-nixos: zoxide
- canonical_capability: starship
  notes: Recommended.
  os_package_ids:
    OS-macos: starship
    OS-arch: starship
    OS-nixos: starship
- canonical_capability: git-delta
  notes: Required for enhanced diff ergonomics.
  os_package_ids:
    OS-macos: git-delta
    OS-arch: git-delta
    OS-nixos: git-delta
- canonical_capability: xh
  notes: Recommended.
  os_package_ids:
    OS-macos: xh
    OS-arch: xh
    OS-nixos: xh
- canonical_capability: tealdeer
  notes: Recommended.
  os_package_ids:
    OS-macos: tealdeer
    OS-arch: tealdeer
    OS-nixos: tealdeer
- canonical_capability: bandwhich
  notes: Recommended.
  os_package_ids:
    OS-macos: bandwhich
    OS-arch: bandwhich
    OS-nixos: bandwhich
- canonical_capability: less-pager
  notes: Recommended for git pager compatibility (for example git log and shortcut
    gl).
  os_package_ids:
    OS-macos: less
    OS-arch: less
    OS-nixos: less
- canonical_capability: lazygit
  notes: Required.
  os_package_ids:
    OS-macos: lazygit
    OS-arch: lazygit
    OS-nixos: lazygit
- canonical_capability: github-cli
  notes: Required.
  os_package_ids:
    OS-macos: gh
    OS-arch: github-cli
    OS-nixos: github-cli
- canonical_capability: git-lfs
  notes: Required.
  os_package_ids:
    OS-macos: git-lfs
    OS-arch: git-lfs
    OS-nixos: git-lfs
- canonical_capability: codex-cli
  notes: Required native install.
  os_package_ids:
    OS-macos: codex
    OS-arch: openai-codex-bin
    OS-nixos: openai-codex
- canonical_capability: claude-cli
  notes: Required native install.
  os_package_ids:
    OS-macos: claude-code
    OS-arch: claude-code-bin
    OS-nixos: claude-code
- canonical_capability: gh-init-helper
  notes: Recommended for repository bootstrap flow.
  os_package_ids:
    OS-macos: custom-tooling
    OS-arch: custom-tooling
    OS-nixos: custom-tooling
known_exceptions:
- id: EXC-package-tooling-01
  statement: Functionally equivalent binaries may replace listed tools if validation
    probes are updated.
  compliance_impact: warn
- id: EXC-package-tooling-02
  statement: Registry package names may differ from runtime command names and must
    be documented explicitly (for example opencode-ai package provides opencode command).
  compliance_impact: warn
- id: EXC-package-tooling-03
  statement: If a native package is unavailable on a platform, an alternate distribution
    may be used only with documented rationale and passing smoke probes.
  compliance_impact: warn
---

# Package Tooling Capability

This capability defines required and recommended command-line tooling outcomes.
