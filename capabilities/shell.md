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
  - Core git shortcuts are defined with explicit expansion semantics.
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
    assertion: Core Claude shortcuts are defined with explicit mappings.
    method: Inspect shell abbreviation/alias/function registry for cc, ccp, ccc, ccr, cct.
    pass_condition: cc -> claude --dangerously-skip-permissions; ccp -> claude --dangerously-skip-permissions -p; ccc -> claude --dangerously-skip-permissions --continue; ccr -> claude --dangerously-skip-permissions --resume; cct -> claude --dangerously-skip-permissions setup-token.
    severity: blocker
  - rule_id: VAL-shell-06
    assertion: Extended Claude task shortcuts are defined.
    method: Verify exact definitions for cc-on, cc-lcp, cc-wt, cc-rt, cc-pt, cc-ft.
    pass_condition: cc-on -> claude --dangerously-skip-permissions "/onboard"; cc-lcp -> claude --dangerously-skip-permissions "/onboard \n /ace:prompt"; cc-wt -> claude --dangerously-skip-permissions "/ace:work-on-task"; cc-rt -> claude --dangerously-skip-permissions "/ace:review-task"; cc-pt -> claude --dangerously-skip-permissions "/ace:plan-task"; cc-ft -> claude --dangerously-skip-permissions "/ace:fix-tests".
    severity: warn
  - rule_id: VAL-shell-07
    assertion: Cross-shell shortcut behavior parity exists for required cc shortcuts.
    method: Inspect alias/function/abbr/readline mappings for active shell.
    pass_condition: Required shortcuts cc, ccp, ccc, ccr, cct, cc-on, cc-lcp, cc-wt, cc-rt, cc-pt, cc-ft are reachable and behaviorally equivalent.
    severity: blocker
  - rule_id: VAL-shell-08
    assertion: Smart directory-jump behavior works in shell context.
    method: Verify zoxide integration or equivalent smart-jump behavior.
    pass_condition: Smart-jump capability is callable from shell session.
    severity: warn
  - rule_id: VAL-shell-09
    assertion: Core git shortcuts are defined with explicit mappings.
    method: Inspect alias/function/abbr/readline mappings for active shell.
    pass_condition: gs -> git status -sb; ga -> git add; gaa -> git add --all; gd -> git diff; gds -> git diff --staged; gl -> git log --oneline --graph --decorate; gll -> git pull; gb -> git branch; gco -> git checkout; gsw -> git switch; gr -> git rebase; gri -> git rebase -i; grom -> git rebase origin/main; gpl -> git pull --ff-only; gp -> git push; gpf -> git push --force-with-lease; gpfl -> git add && git push --force-with-lease; gc resolves to ace-git-commit when available, otherwise git commit.
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
