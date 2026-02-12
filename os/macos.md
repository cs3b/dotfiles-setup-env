---
kind: os
os_id: OS-macos
rules:
  - rule_id: VAL-os-macos-01
    assertion: Homebrew is available.
    method: Run brew --version.
    pass_condition: Command succeeds.
    severity: blocker
  - rule_id: VAL-os-macos-02
    assertion: Homebrew prefix matches intended default.
    method: Run brew --prefix.
    pass_condition: Output is /opt/homebrew unless documented exception exists.
    severity: warn
  - rule_id: VAL-os-macos-03
    assertion: Managed shell config exports expected Homebrew paths.
    method: Inspect shell startup environment.
    pass_condition: PATH contains Homebrew bin and sbin entries.
    severity: warn
known_exceptions:
  - id: EXC-os-macos-01
    statement: Intel macOS hosts may use /usr/local and must record architecture context.
    compliance_impact: warn
---
# macOS Platform Constraints

Defines macOS-specific capability checks and path assumptions.
