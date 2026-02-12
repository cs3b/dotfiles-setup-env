# Security Hygiene Capability

## Capability ID
`CAP-security-hygiene`

## Status
`required`

## Intentions
- Tracked environment configuration must not contain plaintext API tokens or personal access tokens.
- Token setup workflows should avoid exposing secrets in inline shell commands.
- Secrets should be sourced from untracked/local secret stores or interactive secure prompts.

## Validation Rules
- `Rule ID`: `VAL-security-hygiene-01`
  - `Assertion`: No token-like secrets are present in tracked repository files.
  - `Method`: scan tracked files for known token prefixes/patterns (for example `github_pat_`, `ghp_`, `sk-ant-`).
  - `Pass`: no matches in tracked files.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-security-hygiene-02`
  - `Assertion`: Tracked shell startup files do not assign literal secret values.
  - `Method`: inspect tracked shell init files for assignments of token-bearing vars (for example `*_API_KEY=`, `*_TOKEN=`) with inline literals.
  - `Pass`: no inline literal token assignments are found.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-security-hygiene-03`
  - `Assertion`: Shell-history secret handling policy is defined.
  - `Method`: confirm documented policy exists for avoiding sensitive command leakage in shell history.
  - `Pass`: policy is documented in setup specs or referenced policy docs.
  - `Severity`: `warn`

## OS Package Mapping
| Canonical Capability | macOS Package ID | Arch Package ID | Notes |
| --- | --- | --- | --- |
| Secret hygiene policy | N/A | N/A | Policy/process capability, not package-managed |

## Known Exceptions
- If token-like test fixtures are intentionally committed, they must be clearly marked as non-production and excluded from blocker scanning rules.
