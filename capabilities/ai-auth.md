# AI and Git Auth Capability

## Capability ID
`CAP-ai-auth`

## Status
`optional:optional-ai-coding`

## Intentions
- Authentication readiness for installed developer CLIs is validated without exposing credentials.
- Auth checks are optional validations and do not block baseline core compliance.
- Tool-specific auth probes should be non-destructive and non-interactive where possible.

## Validation Rules
- `Rule ID`: `VAL-ai-auth-01`
  - `Assertion`: GitHub CLI authentication status is verifiable.
  - `Method`: run `gh auth status`.
  - `Pass`: authenticated status is reported, or unauthenticated state is explicitly recorded as warning.
  - `Severity`: `warn`
- `Rule ID`: `VAL-ai-auth-02`
  - `Assertion`: Codex CLI authentication status is verifiable.
  - `Method`: run tool-supported noninteractive auth status/whoami/help probe.
  - `Pass`: authenticated status is confirmed, or missing auth is recorded as warning.
  - `Severity`: `warn`
- `Rule ID`: `VAL-ai-auth-03`
  - `Assertion`: Claude CLI authentication status is verifiable.
  - `Method`: run tool-supported noninteractive auth status/whoami/help probe.
  - `Pass`: authenticated status is confirmed, or missing auth is recorded as warning.
  - `Severity`: `warn`
- `Rule ID`: `VAL-ai-auth-04`
  - `Assertion`: Gemini CLI authentication status is verifiable.
  - `Method`: run tool-supported noninteractive auth status/whoami/help probe.
  - `Pass`: authenticated status is confirmed, or missing auth is recorded as warning.
  - `Severity`: `warn`
- `Rule ID`: `VAL-ai-auth-05`
  - `Assertion`: OpenCode CLI authentication status is verifiable.
  - `Method`: run tool-supported noninteractive auth status/whoami/help probe.
  - `Pass`: authenticated status is confirmed, or missing auth is recorded as warning.
  - `Severity`: `warn`
- `Rule ID`: `VAL-ai-auth-06`
  - `Assertion`: pi-mono CLI authentication status is verifiable.
  - `Method`: run tool-supported noninteractive auth status/whoami/help probe.
  - `Pass`: authenticated status is confirmed, or missing auth is recorded as warning.
  - `Severity`: `warn`

## OS Package Mapping
| Canonical Capability | macOS Package ID | Arch Package ID | Notes |
| --- | --- | --- | --- |
| GitHub CLI auth | `gh` | `github-cli` | Optional auth validation |
| Codex CLI auth | `codex` | `codex` | Optional auth validation |
| Claude CLI auth | `claude-code` | `claude-code`/`claude-code-bin` | Optional auth validation |
| Gemini CLI auth | bun-managed global package | bun-managed global package | Optional auth validation |
| OpenCode CLI auth | bun-managed global package | bun-managed global package | Optional auth validation |
| pi-mono CLI auth | bun-managed global package | bun-managed global package | Optional auth validation |

## Known Exceptions
- Some CLIs do not expose a direct auth-status command; equivalent noninteractive probe may be used and recorded.
