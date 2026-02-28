---
kind: capability
capability_id: CAP-abbreviations-git
status: required
intentions:
- Core git abbreviations are defined as fish shell abbreviations.
rules:
- rule_id: VAL-abbreviations-git-01
  assertion: Core git abbreviations are defined with explicit mappings.
  method: Inspect fish abbreviation registry for gs, ga, gaa, gd, gds, gl, gll, gb,
    gco, gsw, gr, gri, grom, gpl, gp, gpf, gpfl, and gc.
  pass_condition: gs -> git status -sb; ga -> git add; gaa -> git add --all; gd ->
    git diff; gds -> git diff --staged; gl -> git log --oneline --graph --decorate;
    gll -> git pull; gb -> git branch; gco -> git checkout; gsw -> git switch; gr
    -> git rebase; gri -> git rebase -i; grom -> git rebase origin/main; gpl -> git
    pull --ff-only; gp -> git push; gpf -> git push --force-with-lease; gpfl -> git
    add && git push --force-with-lease; gc -> git commit.
  severity: warn
os_package_mapping:
- canonical_capability: git-abbreviations
  notes: Capability is config-based; implemented as fish abbreviations.
  os_package_ids:
    OS-macos: shell-config
    OS-arch: shell-config
    OS-nixos: shell-config
known_exceptions:
- id: EXC-abbreviations-git-01
  statement: Shell-specific implementation details may differ if resulting behavior
    is equivalent.
  compliance_impact: warn
---

# Git Abbreviations Capability

This capability defines required git shortcut behavior as fish shell abbreviations.
