---
kind: capability
capability_id: CAP-ai-auth
status: optional:PROFILE-optional-ai-coding
intentions:
  - Authentication readiness for installed developer CLIs is validated without exposing credentials.
  - Auth checks are optional and do not block baseline core compliance.
  - Tool-specific auth probes are non-destructive and non-interactive where possible.
rules:
  - rule_id: VAL-ai-auth-01
    assertion: GitHub CLI authentication status is verifiable.
    method: Run gh auth status.
    pass_condition: Authenticated status is reported, or unauthenticated state is recorded as warning.
    severity: warn
  - rule_id: VAL-ai-auth-02
    assertion: Codex CLI authentication status is verifiable.
    method: Run tool-supported noninteractive auth status, whoami, or help probe.
    pass_condition: Authenticated status is confirmed, or missing auth is recorded as warning.
    severity: warn
  - rule_id: VAL-ai-auth-03
    assertion: Claude CLI authentication status is verifiable.
    method: Run tool-supported noninteractive auth status, whoami, or help probe.
    pass_condition: Authenticated status is confirmed, or missing auth is recorded as warning.
    severity: warn
  - rule_id: VAL-ai-auth-04
    assertion: Gemini CLI authentication status is verifiable.
    method: Run tool-supported noninteractive auth status, whoami, or help probe.
    pass_condition: Authenticated status is confirmed, or missing auth is recorded as warning.
    severity: warn
  - rule_id: VAL-ai-auth-05
    assertion: OpenCode CLI authentication status is verifiable.
    method: Run tool-supported noninteractive auth status, whoami, or help probe.
    pass_condition: Authenticated status is confirmed, or missing auth is recorded as warning.
    severity: warn
  - rule_id: VAL-ai-auth-06
    assertion: pi-mono CLI authentication status is verifiable.
    method: Run tool-supported noninteractive auth status, whoami, or help probe.
    pass_condition: Authenticated status is confirmed, or missing auth is recorded as warning.
    severity: warn
os_package_mapping:
  - canonical_capability: github-cli-auth
    macos_package_id: gh
    arch_package_id: github-cli
    notes: Optional auth validation.
  - canonical_capability: codex-cli-auth
    macos_package_id: codex
    arch_package_id: openai-codex-bin
    notes: Optional auth validation.
  - canonical_capability: claude-cli-auth
    macos_package_id: claude-code
    arch_package_id: claude-code-bin
    notes: Optional auth validation.
  - canonical_capability: gemini-cli-auth
    macos_package_id: bun-global
    arch_package_id: bun-global
    notes: Optional auth validation.
  - canonical_capability: opencode-cli-auth
    macos_package_id: bun-global
    arch_package_id: bun-global
    notes: Optional auth validation.
  - canonical_capability: pi-mono-cli-auth
    macos_package_id: bun-global
    arch_package_id: bun-global
    notes: Optional auth validation.
known_exceptions:
  - id: EXC-ai-auth-01
    statement: Some CLIs do not expose direct auth-status commands; equivalent noninteractive probes may be used.
    compliance_impact: warn
---
# AI and Git Auth Capability

This capability defines optional authentication readiness checks for AI and git-related CLIs.
