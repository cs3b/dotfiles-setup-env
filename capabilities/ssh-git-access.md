# SSH Git Access Capability

## Capability ID
`CAP-ssh-git-access`

## Status
`required`

## Intentions
- Git operations to GitHub work over SSH using port 443 compatibility routing.
- SSH config supports `github.com` host mapping to `ssh.github.com:443`.
- Key-agent integration is enabled where platform supports it.
- GitHub CLI (`gh`) is installed for authenticated GitHub operations beyond raw git transport.

## Validation Rules
- `Rule ID`: `VAL-ssh-git-access-01`
  - `Assertion`: SSH config contains GitHub-over-443 host mapping.
  - `Method`: inspect SSH config host stanza.
  - `Pass`: `Host github.com`, `Hostname ssh.github.com`, `Port 443` are defined.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-ssh-git-access-02`
  - `Assertion`: SSH key path for Git operations is configured.
  - `Method`: inspect `IdentityFile` in GitHub host stanza.
  - `Pass`: identity path is declared.
  - `Severity`: `warn`
- `Rule ID`: `VAL-ssh-git-access-03`
  - `Assertion`: SSH handshake to GitHub endpoint succeeds.
  - `Method`: run `ssh -T git@github.com`.
  - `Pass`: returns authenticated/denied-with-recognized-account message, not network failure.
  - `Severity`: `warn`
- `Rule ID`: `VAL-ssh-git-access-04`
  - `Assertion`: GitHub CLI is available.
  - `Method`: run `gh --version`.
  - `Pass`: command succeeds and reports a version.
  - `Severity`: `blocker`

## OS Package Mapping
| Canonical Capability | macOS Package ID | Arch Package ID | Notes |
| --- | --- | --- | --- |
| OpenSSH client | system/default | `openssh` | Usually preinstalled on macOS |
| Git over SSH transport | `git` | `git` | Required |
| GitHub CLI | `gh` | `github-cli` | Required |

## Known Exceptions
- Enterprise SSH policies may require alternate host alias; if so, equivalent 443 transport must still validate.
