---
kind: capability
capability_id: CAP-fonts-terminal
status: required
intentions:
  - A Nerd Font v3 or newer is installed for icon-rich terminal and editor UI.
  - Terminal emulator is configured to use a Nerd Font compatible face.
  - Truecolor rendering is enabled for consistent theme output.
rules:
  - rule_id: VAL-fonts-terminal-01
    assertion: Nerd Font is installed.
    method: Inspect system font list.
    pass_condition: At least one Nerd Font v3 or newer family is available.
    severity: blocker
  - rule_id: VAL-fonts-terminal-02
    assertion: Terminal or editor references Nerd Font capable face.
    method: Inspect terminal and Neovim UI font settings.
    pass_condition: Configured font includes a Nerd Font family.
    severity: warn
  - rule_id: VAL-fonts-terminal-03
    assertion: Truecolor is enabled in shell or terminal session.
    method: Inspect environment for COLORTERM=truecolor or equivalent terminal support.
    pass_condition: Truecolor signal is present.
    severity: warn
os_package_mapping:
  - canonical_capability: nerd-font-family
    macos_package_id: manual-or-font-package
    arch_package_id: ttf-jetbrains-mono-nerd
    notes: Any Nerd Font v3 or newer is acceptable.
  - canonical_capability: terminal-emulator
    macos_package_id: user-choice
    arch_package_id: user-choice
    notes: Validate behavior, not specific application.
known_exceptions:
  - id: EXC-fonts-terminal-01
    statement: Headless servers may skip this capability if no interactive terminal UI is in scope.
    compliance_impact: warn
---
# Fonts and Terminal Rendering Capability

This capability defines font and rendering outcomes for terminal and editor display quality.
