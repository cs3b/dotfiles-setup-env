# Terminal Multiplexer Capability

## Capability ID
`CAP-terminal-multiplexer`

## Status
`required`

## Intentions
- A terminal multiplexer is available for session management.
- `tmux` is installed and launchable.
- tmux configuration (status bar, themes, layouts, tmuxp) is out of scope for baseline compliance.

## Validation Rules
- `Rule ID`: `VAL-terminal-multiplexer-01`
  - `Assertion`: tmux binary is available.
  - `Method`: run `command -v tmux`.
  - `Pass`: command returns a resolvable binary path.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-terminal-multiplexer-02`
  - `Assertion`: tmux reports a valid version.
  - `Method`: run `tmux -V`.
  - `Pass`: command succeeds and prints version text.
  - `Severity`: `warn`

## OS Package Mapping
| Canonical Capability | macOS Package ID | Arch Package ID | Notes |
| --- | --- | --- | --- |
| tmux | `tmux` | `tmux` | Required |

## Known Exceptions
- Headless or restricted shells may not permit starting a tmux server during validation; binary availability remains mandatory.
