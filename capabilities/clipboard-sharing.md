---
kind: capability
capability_id: CAP-clipboard-sharing
status: required
intentions:
  - Clipboard copy operations from remote Neovim and tmux can reach host clipboard over SSH.
  - OSC52 is the transport for remote-to-host clipboard copy path.
  - Configuration is copy-oriented for remote workflows and avoids requiring remote GUI clipboard tools.
  - Active system configuration defines both tmux forwarding and Neovim clipboard provider behavior.
rules:
  - rule_id: VAL-clipboard-sharing-01
    assertion: OSC52-capable terminal workflow is declared.
    method: Inspect setup documentation for terminal support and host permission notes.
    pass_condition: Documentation explicitly states OSC52 requirement and host terminal permission step.
    severity: warn
  - rule_id: VAL-clipboard-sharing-02
    assertion: tmux is configured to forward clipboard escape sequences.
    method: Inspect active tmux config for clipboard forwarding options.
    pass_condition: tmux config enables allow-passthrough, set-clipboard, and terminal clipboard feature mapping.
    severity: blocker
  - rule_id: VAL-clipboard-sharing-03
    assertion: Neovim uses OSC52 copy provider in SSH workflow.
    method: Inspect active Neovim config for vim.ui.clipboard.osc52 provider wiring.
    pass_condition: Active config sets an OSC52 clipboard provider for + and * copy targets when running over SSH.
    severity: blocker
  - rule_id: VAL-clipboard-sharing-04
    assertion: Default yank path targets clipboard in SSH workflow.
    method: Inspect active Neovim clipboard option handling.
    pass_condition: Active SSH Neovim config enables unnamedplus so regular yanks copy to host clipboard transport path.
    severity: blocker
  - rule_id: VAL-clipboard-sharing-05
    assertion: Copy-only policy is documented for remote clipboard flow.
    method: Inspect setup docs for inbound paste guidance.
    pass_condition: Documentation states OSC52 copy path and terminal-paste fallback for host-to-remote direction.
    severity: warn
os_package_mapping:
  - canonical_capability: neovim-osc52-provider
    macos_package_id: n-a
    arch_package_id: n-a
    notes: Config-level capability using built-in Neovim OSC52 provider.
  - canonical_capability: tmux-clipboard-forwarding
    macos_package_id: tmux
    arch_package_id: tmux
    notes: Requires tmux option configuration for passthrough and clipboard features.
  - canonical_capability: terminal-osc52-support
    macos_package_id: iterm2
    arch_package_id: n-a
    notes: Host terminal must support and allow OSC52 clipboard access.
known_exceptions:
  - id: EXC-clipboard-sharing-01
    statement: Hosts without OSC52-capable terminals may acknowledge clipboard sharing as warn-level degraded behavior.
    compliance_impact: warn
---
# Clipboard Sharing Capability

This capability defines remote-to-host clipboard sharing behavior across SSH, tmux, and Neovim.
