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
    method: Scan tracked non-contract files for token prefixes and patterns such as github_pat_, ghp_, and sk-ant-; exclude contract documentation paths.
    pass_condition: No matches are found outside excluded contract docs (for example capabilities/, profiles/, os/, validation/ markdown docs).
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

## Shell-History Secret Handling Policy

To satisfy VAL-security-hygiene-03, the following conventions apply:

- Prefix sensitive commands with a leading space to exclude them from history (requires HISTCONTROL=ignorespace or ignoreboth in bash; fish uses `--private` mode).
- Never pass tokens, passwords, or API keys as inline command arguments; use environment variables sourced from untracked files or secure prompts instead.
- Avoid persisting authentication commands (e.g., `export API_KEY=...`) in shell history; use tool-native auth flows (e.g., `gh auth login`, `claude setup-token`) which handle credential storage securely.
- Periodically audit `~/.bash_history` and `~/.local/share/fish/fish_history` for accidental secret leakage.
