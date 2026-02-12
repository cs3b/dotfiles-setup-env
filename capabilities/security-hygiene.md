---
kind: capability
capability_id: CAP-security-hygiene
status: required
intentions:
  - Tracked environment configuration does not contain plaintext API tokens or personal access tokens.
  - Token setup workflows avoid exposing secrets in inline shell commands.
  - Secrets are sourced from untracked local secret stores or secure prompts.
rules:
  - rule_id: VAL-security-hygiene-01
    assertion: No token-like secrets are present in tracked repository files.
    method: Scan tracked files for token prefixes and patterns such as github_pat_, ghp_, and sk-ant-.
    pass_condition: No matches in tracked files.
    severity: blocker
  - rule_id: VAL-security-hygiene-02
    assertion: Tracked shell startup files do not assign literal secret values.
    method: Inspect tracked shell init files for token-bearing variable assignments with inline literals.
    pass_condition: No inline literal token assignments are found.
    severity: blocker
  - rule_id: VAL-security-hygiene-03
    assertion: Shell-history secret handling policy is defined.
    method: Confirm documented policy exists for avoiding sensitive command leakage in shell history.
    pass_condition: Policy is documented in setup specs or referenced policy documents.
    severity: warn
os_package_mapping:
  - canonical_capability: secret-hygiene-policy
    macos_package_id: n-a
    arch_package_id: n-a
    notes: Policy and process capability, not package-managed.
known_exceptions:
  - id: EXC-security-hygiene-01
    statement: Token-like test fixtures may be committed only if clearly marked non-production and excluded from blocker scanning rules.
    compliance_impact: blocker-waivable
---
# Security Hygiene Capability

This capability defines secret-handling outcomes for tracked setup artifacts.
