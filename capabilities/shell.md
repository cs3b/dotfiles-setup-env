---
kind: capability
capability_id: CAP-shell
status: required
intentions:
  - Primary interactive shell is configured and usable (fish, zsh, or bash).
  - Shell choice is environment-driven; no specific shell package is required by default.
  - Shell startup is noninteractive-safe.
  - Login-noninteractive bash initialization chain keeps runtime activation reachable.
  - Runtime manager activation is available in shell sessions.
  - Smart directory jump capability is available.
  - Prompt customization capability is available.
rules:
  - rule_id: VAL-shell-01
    assertion: Primary shell launches and executes noninteractive command.
    method: Run <shell> -lc 'echo ok'.
    pass_condition: Output contains ok and exit code is 0.
    severity: blocker
  - rule_id: VAL-shell-02
    assertion: Runtime manager activation is effective in shell context.
    method: Run <shell> -lc 'command -v mise || command -v asdf || command -v rtx'.
    pass_condition: At least one runtime-manager binary is resolvable.
    severity: blocker
  - rule_id: VAL-shell-03
    assertion: Smart directory jump capability is available.
    method: Run <shell> -lc 'command -v zoxide || command -v z'.
    pass_condition: zoxide or equivalent jump command exists.
    severity: warn
  - rule_id: VAL-shell-04
    assertion: Prompt customization capability is present.
    method: Run <shell> -lc 'command -v starship || test -n "$PS1"'.
    pass_condition: Starship exists or prompt is explicitly customized.
    severity: warn
  - rule_id: VAL-shell-08
    assertion: Smart directory-jump behavior works in shell context.
    method: Verify zoxide integration or equivalent smart-jump behavior.
    pass_condition: Smart-jump capability is callable from shell session.
    severity: warn
  - rule_id: VAL-shell-10
    assertion: Runtime probes succeed for whichever supported shells are installed.
    method: Detect installed shells among bash zsh fish and run noninteractive probes for each available shell.
    pass_condition: Every installed supported shell executes probe commands successfully; missing supported shells do not fail this rule.
    severity: blocker
  - rule_id: VAL-shell-11
    assertion: Bash login-noninteractive initialization chain preserves runtime activation.
    method: Run bash -lc probes and inspect .bash_profile -> .bashrc sourcing behavior.
    pass_condition: When bash is installed, bash -lc resolves runtime manager and managed binaries even when .bashrc contains interactive guards.
    severity: warn
os_package_mapping:
  - canonical_capability: Primary shell
    macos_package_id: system-shell
    arch_package_id: system-shell
    notes: Do not recommend installing a specific shell by default; use bash, zsh, or fish as available.
  - canonical_capability: Prompt engine
    macos_package_id: starship
    arch_package_id: starship
    notes: Optional if equivalent prompt customization exists.
  - canonical_capability: Directory jumper
    macos_package_id: zoxide
    arch_package_id: zoxide
    notes: Optional but recommended.
known_exceptions:
  - id: EXC-shell-01
    statement: Environments that intentionally use unsupported shells still pass when at least one supported shell (bash, zsh, fish) satisfies runtime behavior rules.
    compliance_impact: warn
---
# Shell Capability

This capability defines interactive shell behavior and runtime initialization across fish, zsh, and bash.
