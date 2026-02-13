---
kind: capability
capability_id: CAP-version-manager
status: required
intentions:
  - A runtime manager controls language runtime versions consistently across shells.
  - Ruby and Bun runtimes are managed declaratively as default environments.
  - Shim or equivalent indirection makes managed binaries resolvable on PATH.
  - Home-level runtime manager config is source of truth for default runtimes.
  - Bun-managed global AI CLIs include gemini, opencode, and pi.
  - When package and command names differ, both are documented (for example package opencode-ai and command opencode).
  - Bun-managed CLI installs are verified for executable shebang/runtime compatibility, not only package install success.
rules:
  - rule_id: VAL-version-manager-01
    assertion: Runtime manager binary exists.
    method: Verify mise command or declared equivalent.
    pass_condition: Runtime manager command is available.
    severity: blocker
  - rule_id: VAL-version-manager-02
    assertion: Ruby runtime is managed and available.
    method: Check manager tool list and ruby --version.
    pass_condition: Ruby is declared and executable.
    severity: blocker
  - rule_id: VAL-version-manager-03
    assertion: Bun runtime is managed and available.
    method: Check manager tool list and bun --version.
    pass_condition: Bun is declared and executable.
    severity: blocker
  - rule_id: VAL-version-manager-04
    assertion: Shell sessions expose managed shims.
    method: Probe login-noninteractive shell initialization chain and inspect PATH for manager shim directory.
    pass_condition: Managed runtime binaries resolve in bash -lc and active shell contexts, including setups where .bash_profile sources .bashrc.
    severity: warn
  - rule_id: VAL-version-manager-05
    assertion: Home-level mise global config exists and declares default runtimes.
    method: Inspect ~/.config/mise/config.toml.
    pass_condition: Config exists and includes ruby and bun runtime entries.
    severity: blocker
  - rule_id: VAL-version-manager-06
    assertion: Bun-managed global AI CLIs are available and executable.
    method: Verify gemini, opencode, and pi commands and resolution paths; run immediate smoke probes after install; confirm opencode package mapping uses opencode-ai and pi package mapping uses @mariozechner/pi-coding-agent; verify generated script entrypoints do not fail due to missing shebang runtime dependencies.
    pass_condition: All commands resolve from bun or mise managed runtime paths, pass version/help smoke probes, and package-to-command mapping is documented.
    severity: blocker
os_package_mapping:
  - canonical_capability: runtime-manager
    macos_package_id: mise
    arch_package_id: mise
    notes: Equivalent manager allowed if declared.
  - canonical_capability: ruby-runtime
    macos_package_id: manager-provisioned
    arch_package_id: manager-provisioned
    notes: Validate by runtime availability.
  - canonical_capability: bun-runtime
    macos_package_id: manager-provisioned
    arch_package_id: manager-provisioned
    notes: Validate by runtime availability.
  - canonical_capability: gemini-cli
    macos_package_id: bun-global
    arch_package_id: bun-global
    notes: Validate command capability, not registry name.
  - canonical_capability: opencode-cli
    macos_package_id: bun-global
    arch_package_id: bun-global
    notes: Package name is opencode-ai; runtime command is opencode.
  - canonical_capability: pi-cli
    macos_package_id: bun-global
    arch_package_id: bun-global
    notes: Package name is @mariozechner/pi-coding-agent; runtime command is pi.
known_exceptions:
  - id: EXC-version-manager-01
    statement: Alternative runtime managers are allowed if replacement is declared and validation semantics are preserved.
    compliance_impact: warn
  - id: EXC-version-manager-02
    statement: If a CLI lacks a version subcommand, a noninteractive help probe may be used as the smoke test.
    compliance_impact: warn
---
# Runtime Version Manager Capability

This capability defines runtime management outcomes and global CLI availability.
