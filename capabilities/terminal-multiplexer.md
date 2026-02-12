---
kind: capability
capability_id: CAP-terminal-multiplexer
status: required
intentions:
  - A terminal multiplexer is available for session management.
  - tmux is installed and launchable.
  - tmux configuration details are out of scope for baseline compliance.
rules:
  - rule_id: VAL-terminal-multiplexer-01
    assertion: tmux binary is available.
    method: Run command -v tmux.
    pass_condition: Command returns a resolvable binary path.
    severity: blocker
  - rule_id: VAL-terminal-multiplexer-02
    assertion: tmux reports a valid version.
    method: Run tmux -V.
    pass_condition: Command succeeds and prints version text.
    severity: warn
os_package_mapping:
  - canonical_capability: tmux
    macos_package_id: tmux
    arch_package_id: tmux
    notes: Required.
known_exceptions:
  - id: EXC-terminal-multiplexer-01
    statement: Restricted shells may not permit starting a tmux server during validation; binary availability remains mandatory.
    compliance_impact: warn
---
# Terminal Multiplexer Capability

This capability defines baseline tmux availability and version observability.
