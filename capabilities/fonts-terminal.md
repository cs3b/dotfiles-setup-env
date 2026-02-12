# Fonts and Terminal Rendering Capability

## Capability ID
`CAP-fonts-terminal`

## Status
`required`

## Intentions
- A Nerd Font v3+ is installed to support icon-rich terminal/editor UI.
- Terminal emulator is configured to use Nerd Font-compatible face.
- Truecolor rendering is enabled for consistent theme output.

## Validation Rules
- `Rule ID`: `VAL-fonts-terminal-01`
  - `Assertion`: Nerd Font is installed.
  - `Method`: inspect system font list.
  - `Pass`: at least one Nerd Font v3+ family is available (JetBrains Mono Nerd Font preferred).
  - `Severity`: `blocker`
- `Rule ID`: `VAL-fonts-terminal-02`
  - `Assertion`: Terminal/editor references Nerd Font-capable face.
  - `Method`: inspect terminal and Neovim UI font settings.
  - `Pass`: configured font includes Nerd Font family.
  - `Severity`: `warn`
- `Rule ID`: `VAL-fonts-terminal-03`
  - `Assertion`: Truecolor is enabled in shell/terminal session.
  - `Method`: inspect environment for `COLORTERM=truecolor` or equivalent terminal truecolor support.
  - `Pass`: truecolor signal is present.
  - `Severity`: `warn`

## OS Package Mapping
| Canonical Capability | macOS Package ID | Arch Package ID | Notes |
| --- | --- | --- | --- |
| Nerd Font family | manual/font package | `ttf-jetbrains-mono-nerd` (AUR, typical) | Any Nerd Font v3+ is acceptable |
| Terminal emulator | user choice | user choice | Capability validated by behavior, not specific app |

## Known Exceptions
- Headless servers may skip this capability if no interactive terminal UI is in scope.
