---
kind: os
os_id: OS-nixos
rules:
  - rule_id: VAL-os-nixos-01
    assertion: Nix package tooling is available.
    method: Run nix --version.
    pass_condition: Command succeeds.
    severity: blocker
  - rule_id: VAL-os-nixos-02
    assertion: Core packages resolve via nixpkgs or documented exception mapping.
    method: For each mapped package, verify package attribute mapping or binary presence with documented exception evidence.
    pass_condition: All required core capabilities are satisfied.
    severity: blocker
  - rule_id: VAL-os-nixos-03
    assertion: Fish startup preserves runtime manager and path behavior.
    method: Run fish noninteractive probes.
    pass_condition: Runtime manager and required binaries resolve in fish context.
    severity: warn
known_exceptions:
  - id: EXC-os-nixos-01
    statement: If a native nixpkgs source is unavailable for a required CLI, an alternate distribution source may be used when rationale and smoke-probe evidence are documented.
    compliance_impact: warn
---
# NixOS Platform Constraints

Defines NixOS-specific package, source-selection, and fish-shell integration expectations.
