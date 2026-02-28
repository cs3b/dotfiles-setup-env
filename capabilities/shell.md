---
kind: capability
capability_id: CAP-shell
status: required
intentions:
- Fish is the default interactive shell.
- Shell startup is noninteractive-safe.
- Runtime manager activation is available in shell sessions.
- Smart directory jump capability is available.
- Prompt customization capability is available.
rules:
- rule_id: VAL-shell-01
  assertion: Fish shell launches and executes noninteractive command.
  method: Run fish -c 'echo ok'.
  pass_condition: Output contains ok and exit code is 0.
  severity: blocker
- rule_id: VAL-shell-02
  assertion: Runtime manager activation is effective in fish context.
  method: Run fish -c 'command -v mise'.
  pass_condition: mise binary is resolvable.
  severity: blocker
- rule_id: VAL-shell-03
  assertion: Smart directory jump capability is available.
  method: Run fish -c 'command -v zoxide'.
  pass_condition: zoxide or equivalent jump command exists.
  severity: warn
- rule_id: VAL-shell-04
  assertion: Prompt customization capability is present.
  method: Run fish -c 'command -v starship'.
  pass_condition: Starship exists or prompt is explicitly customized.
  severity: warn
- rule_id: VAL-shell-08
  assertion: Smart directory-jump behavior works in fish context.
  method: Verify zoxide integration or equivalent smart-jump behavior.
  pass_condition: Smart-jump capability is callable from fish session.
  severity: warn
os_package_mapping:
- canonical_capability: Fish shell
  notes: Fish is the required default shell.
  os_package_ids:
    OS-macos: fish
    OS-arch: fish
    OS-nixos: fish
- canonical_capability: Prompt engine
  notes: Optional if equivalent prompt customization exists.
  os_package_ids:
    OS-macos: starship
    OS-arch: starship
    OS-nixos: starship
- canonical_capability: Directory jumper
  notes: Optional but recommended.
  os_package_ids:
    OS-macos: zoxide
    OS-arch: zoxide
    OS-nixos: zoxide
known_exceptions: []
---

# Shell Capability

This capability defines fish as the default interactive shell with runtime initialization, prompt customization, and directory jump integration.
