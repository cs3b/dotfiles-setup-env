---
kind: capability
capability_id: CAP-abbreviations-claude
status: required
intentions:
  - Core Claude shortcuts are defined with explicit, reviewable expansions.
  - Extended Claude task shortcuts are available for common workflows.
  - Claude shortcut behavior is consistent across installed shells among bash, zsh, and fish.
rules:
  - rule_id: VAL-abbreviations-claude-01
    assertion: Core Claude shortcuts are defined with explicit mappings.
    method: Inspect shell abbreviation/alias/function registry for cc, ccp, ccc, ccr, cct.
    pass_condition: cc -> claude --dangerously-skip-permissions; ccp -> claude --dangerously-skip-permissions -p; ccc -> claude --dangerously-skip-permissions --continue; ccr -> claude --dangerously-skip-permissions --resume; cct -> claude --dangerously-skip-permissions setup-token.
    severity: blocker
  - rule_id: VAL-abbreviations-claude-02
    assertion: Extended Claude task shortcuts are defined.
    method: Verify exact definitions for cc-on, cc-lcp, cc-wt, cc-rt, cc-pt, cc-ft.
    pass_condition: cc-on -> claude --dangerously-skip-permissions "/onboard"; cc-lcp -> claude --dangerously-skip-permissions "/onboard \n /ace:prompt"; cc-wt -> claude --dangerously-skip-permissions "/ace:work-on-task"; cc-rt -> claude --dangerously-skip-permissions "/ace:review-task"; cc-pt -> claude --dangerously-skip-permissions "/ace:plan-task"; cc-ft -> claude --dangerously-skip-permissions "/ace:fix-tests".
    severity: warn
  - rule_id: VAL-abbreviations-claude-03
    assertion: Claude shortcut behavior parity exists across installed shells.
    method: Compare alias/function/abbr mappings for installed shells among bash zsh fish.
    pass_condition: Required shortcuts cc, ccp, ccc, ccr, cct, cc-on, cc-lcp, cc-wt, cc-rt, cc-pt, cc-ft are reachable and behaviorally equivalent.
    severity: blocker
os_package_mapping:
  - canonical_capability: claude-cli
    macos_package_id: claude-code
    arch_package_id: claude-code-bin
    notes: Runtime command behavior depends on Claude CLI presence.
  - canonical_capability: claude-shortcuts
    macos_package_id: shell-config
    arch_package_id: shell-config
    notes: Capability is config-based and shell-agnostic.
known_exceptions:
  - id: EXC-abbreviations-claude-01
    statement: If Claude CLI is intentionally absent, blocker rules may be waived only when AI workflow profile is disabled.
    compliance_impact: blocker-waivable
---
# Claude Abbreviations Capability

This capability isolates Claude-specific shortcut requirements from general shell runtime checks.
