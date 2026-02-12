---
kind: capability
capability_id: CAP-shell
status: required
intentions:
  - Primary interactive shell is configured and usable (fish, zsh, or bash).
  - Shell startup is noninteractive-safe.
  - Runtime manager activation is available in shell sessions.
  - Smart directory jump capability is available.
  - Prompt customization capability is available.
  - Cross-shell shortcut behavior parity exists for required Claude shortcuts.
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
  - rule_id: VAL-shell-05
    assertion: Core Claude shortcut cc resolves to claude invocation with permissions flag.
    method: Inspect shell abbreviation/alias/function registry.
    pass_condition: cc expands to claude --dangerously-skip-permissions equivalent.
    severity: blocker
  - rule_id: VAL-shell-06
    assertion: Extended Claude task shortcuts are defined.
    method: Verify cc-on, cc-lcp, cc-wt, cc-rt, cc-pt, cc-ft definitions.
    pass_condition: All listed shortcuts resolve to intended claude invocation text.
    severity: warn
  - rule_id: VAL-shell-07
    assertion: Cross-shell shortcut behavior parity exists for required cc shortcuts.
    method: Inspect alias/function/abbr/readline mappings for active shell.
    pass_condition: Required shortcuts are reachable and behaviorally equivalent.
    severity: blocker
  - rule_id: VAL-shell-08
    assertion: Smart directory-jump behavior works in shell context.
    method: Verify zoxide integration or equivalent smart-jump behavior.
    pass_condition: Smart-jump capability is callable from shell session.
    severity: warn
os_package_mapping:
  - canonical_capability: Primary shell
    macos_package_id: fish
    arch_package_id: fish
    notes: zsh or bash are acceptable if rules still pass.
  - canonical_capability: Prompt engine
    macos_package_id: starship
    arch_package_id: starship
    notes: Optional if equivalent prompt customization exists.
  - canonical_capability: Directory jumper
    macos_package_id: zoxide
    arch_package_id: zoxide
    notes: Optional but recommended.
  - canonical_capability: Claude CLI
    macos_package_id: claude-code
    arch_package_id: claude-code-bin
    notes: Distribution name may vary on Arch.
known_exceptions:
  - id: EXC-shell-01
    statement: If Claude CLI is intentionally absent, VAL-shell-05 may be waived only when AI workflow profile is disabled.
    compliance_impact: blocker-waivable
---
# Shell Capability

This capability defines interactive shell behavior and shortcut parity requirements across fish, zsh, and bash.
