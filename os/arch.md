---
kind: os
os_id: OS-arch
rules:
  - rule_id: VAL-os-arch-01
    assertion: Arch package tooling is available.
    method: Run pacman --version.
    pass_condition: Command succeeds.
    severity: blocker
  - rule_id: VAL-os-arch-02
    assertion: Core packages resolve via pacman or AUR mapping.
    method: For each mapped package, verify install state or binary presence.
    pass_condition: All required core capabilities are satisfied.
    severity: blocker
  - rule_id: VAL-os-arch-03
    assertion: Shell startup preserves runtime manager and path behavior.
    method: Run shell noninteractive probes.
    pass_condition: Runtime manager and required binaries resolve in shell context.
    severity: warn
known_exceptions:
  - id: EXC-os-arch-01
    statement: cask-only macOS tools may require AUR or community alternatives; validate capability outcome over exact source.
    compliance_impact: warn
---
# Arch Linux Platform Constraints

Defines Arch-specific package and shell integration expectations.
