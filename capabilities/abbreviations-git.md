---
kind: capability
capability_id: CAP-abbreviations-git
status: required
intentions:
  - Core git abbreviations are defined as portable shell shortcuts.
  - Abbreviation behavior is consistent across installed shells among bash, zsh, and fish.
rules:
  - rule_id: VAL-abbreviations-git-01
    assertion: Core git abbreviations are defined with explicit mappings.
    method: Inspect shell abbreviation/alias/function registry for gs, ga, gaa, gd, gds, gl, gll, gb, gco, gsw, gr, gri, grom, gpl, gp, gpf, gpfl, and gc.
    pass_condition: gs -> git status -sb; ga -> git add; gaa -> git add --all; gd -> git diff; gds -> git diff --staged; gl -> git log --oneline --graph --decorate (or git --no-pager log --oneline --graph --decorate when pager tooling is unavailable); gll -> git pull; gb -> git branch; gco -> git checkout; gsw -> git switch; gr -> git rebase; gri -> git rebase -i; grom -> git rebase origin/main; gpl -> git pull --ff-only; gp -> git push; gpf -> git push --force-with-lease; gpfl -> git add && git push --force-with-lease; gc resolves to ace-git-commit when available, otherwise git commit.
    severity: warn
  - rule_id: VAL-abbreviations-git-02
    assertion: Core git abbreviations maintain parity across installed shells.
    method: Compare alias/function/abbr mappings for installed shells among bash zsh fish.
    pass_condition: Installed shells expose equivalent behavior for required git abbreviations.
    severity: warn
os_package_mapping:
  - canonical_capability: git-abbreviations
    macos_package_id: shell-config
    arch_package_id: shell-config
    notes: Capability is config-based and shell-agnostic.
known_exceptions:
  - id: EXC-abbreviations-git-01
    statement: Shell-specific implementation details may differ if resulting behavior is equivalent.
    compliance_impact: warn
---
# Git Abbreviations Capability

This capability defines required git shortcut behavior independent from core shell runtime rules.
