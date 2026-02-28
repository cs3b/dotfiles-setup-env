---
kind: capability
capability_id: CAP-ai-auth
status: optional:PROFILE-optional-ai-coding
intentions:
- Authentication readiness for installed developer CLIs is validated without exposing
  credentials.
- Auth checks are optional and do not block baseline core compliance.
- Tool-specific auth probes are non-destructive and non-interactive where possible.
rules:
- rule_id: VAL-ai-auth-01
  assertion: GitHub CLI authentication status is verifiable.
  method: Run gh auth status.
  pass_condition: Authenticated status is reported, or unauthenticated state is recorded
    as warning.
  severity: warn
- rule_id: VAL-ai-auth-02
  assertion: Codex CLI authentication status is verifiable.
  method: Run tool-supported noninteractive auth status, whoami, or help probe.
  pass_condition: Authenticated status is confirmed, or missing auth is recorded as
    warning.
  severity: warn
- rule_id: VAL-ai-auth-03
  assertion: Claude CLI authentication status is verifiable.
  method: Run tool-supported noninteractive auth status, whoami, or help probe.
  pass_condition: Authenticated status is confirmed, or missing auth is recorded as
    warning.
  severity: warn
- rule_id: VAL-ai-auth-04
  assertion: Gemini CLI authentication status is verifiable.
  method: Run tool-supported noninteractive auth status, whoami, or help probe.
  pass_condition: Authenticated status is confirmed, or missing auth is recorded as
    warning.
  severity: warn
- rule_id: VAL-ai-auth-05
  assertion: OpenCode CLI authentication status is verifiable.
  method: Run tool-supported noninteractive auth status, whoami, or help probe.
  pass_condition: Authenticated status is confirmed, or missing auth is recorded as
    warning.
  severity: warn
- rule_id: VAL-ai-auth-06
  assertion: pi CLI authentication status is verifiable.
  method: Run tool-supported noninteractive auth status, whoami, or help probe.
  pass_condition: Authenticated status is confirmed, or missing auth is recorded as
    warning.
  severity: warn
os_package_mapping:
- canonical_capability: github-cli-auth
  notes: Optional auth validation.
  os_package_ids:
    OS-macos: gh
    OS-arch: github-cli
    OS-nixos: todo-verify-nix-attr-or-exception
- canonical_capability: codex-cli-auth
  notes: Optional auth validation.
  os_package_ids:
    OS-macos: codex
    OS-arch: openai-codex-bin
    OS-nixos: todo-verify-nix-attr-or-exception
- canonical_capability: claude-cli-auth
  notes: Optional auth validation.
  os_package_ids:
    OS-macos: claude-code
    OS-arch: claude-code-bin
    OS-nixos: todo-verify-nix-attr-or-exception
- canonical_capability: gemini-cli-auth
  notes: Optional auth validation.
  os_package_ids:
    OS-macos: bun-global
    OS-arch: bun-global
    OS-nixos: todo-verify-nix-attr-or-exception
- canonical_capability: opencode-cli-auth
  notes: Optional auth validation.
  os_package_ids:
    OS-macos: bun-global
    OS-arch: bun-global
    OS-nixos: todo-verify-nix-attr-or-exception
- canonical_capability: pi-cli-auth
  notes: Package name is @mariozechner/pi-coding-agent; runtime command is pi.
  os_package_ids:
    OS-macos: bun-global
    OS-arch: bun-global
    OS-nixos: todo-verify-nix-attr-or-exception
known_exceptions:
- id: EXC-ai-auth-01
  statement: Some CLIs do not expose direct auth-status commands; equivalent noninteractive
    probes may be used.
  compliance_impact: warn
---
# AI and Git Auth Capability

This capability defines optional authentication readiness checks for AI and git-related CLIs.
