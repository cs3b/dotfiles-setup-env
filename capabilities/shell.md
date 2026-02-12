# Shell Capability

## Capability ID
`CAP-shell`

## Status
`required`

## Intentions
- A primary interactive shell is configured and usable (`fish`, `zsh`, or `bash`).
- Shell startup is noninteractive-safe (no blocking prompts or interactive-only failures in noninteractive runs).
- Runtime manager activation is available in shell sessions.
- Smart directory jump capability is available.
- Prompt customization capability is available.
- Cross-shell behavior parity is required: Bash/Zsh/Fish must provide equivalent shortcut behavior even if implementation differs (alias/function/abbr/readline).
- Claude workflow abbreviations are available independent of shell implementation style (alias/function/abbr), with equivalent behavior:
  - `cc`, `ccp`, `ccc`, `ccr`, `cct`
  - `cc-on`, `cc-lcp`, `cc-wt`, `cc-rt`, `cc-pt`, `cc-ft`

## Validation Rules
- `Rule ID`: `VAL-shell-01`
  - `Assertion`: Primary shell launches and executes noninteractive command.
  - `Method`: run `<shell> -lc 'echo ok'`.
  - `Pass`: output contains `ok`, exit code `0`.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-shell-02`
  - `Assertion`: Runtime manager activation is effective in shell context.
  - `Method`: run `<shell> -lc 'command -v mise || command -v asdf || command -v rtx'`.
  - `Pass`: at least one runtime-manager binary is resolvable.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-shell-03`
  - `Assertion`: Smart directory jump capability is available.
  - `Method`: run `<shell> -lc 'command -v zoxide || command -v z'`.
  - `Pass`: `zoxide` or equivalent jump command exists.
  - `Severity`: `warn`
- `Rule ID`: `VAL-shell-04`
  - `Assertion`: Prompt customization capability is present.
  - `Method`: run `<shell> -lc 'command -v starship || test -n "$PS1"'`.
  - `Pass`: starship exists or prompt is explicitly customized.
  - `Severity`: `warn`
- `Rule ID`: `VAL-shell-05`
  - `Assertion`: Core Claude abbreviation `cc` resolves to `claude` invocation with permission flag.
  - `Method`: inspect shell abbreviation/alias/function registry.
  - `Pass`: `cc` expands to `claude --dangerously-skip-permissions ...` equivalent.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-shell-06`
  - `Assertion`: Extended Claude task shortcuts are all defined.
  - `Method`: verify definitions for `cc-on`, `cc-lcp`, `cc-wt`, `cc-rt`, `cc-pt`, `cc-ft`.
  - `Pass`: all listed shortcuts resolve to `claude --dangerously-skip-permissions` with intended task text.
  - `Severity`: `warn`
- `Rule ID`: `VAL-shell-07`
  - `Assertion`: Cross-shell shortcut behavior parity exists for required `cc*` shortcuts.
  - `Method`: inspect alias/function/abbr/readline mappings for active shell.
  - `Pass`: all required shortcuts are reachable and behaviorally equivalent on the active shell.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-shell-08`
  - `Assertion`: Smart directory-jump behavior works in shell context.
  - `Method`: verify `zoxide` integration or equivalent smart-jump command behavior.
  - `Pass`: smart-jump capability is callable from shell session.
  - `Severity`: `warn`

## OS Package Mapping
| Canonical Capability | macOS Package ID | Arch Package ID | Notes |
| --- | --- | --- | --- |
| Primary shell | `fish` (brew) | `fish` (pacman) | zsh/bash acceptable as primary if rules still pass |
| Prompt engine | `starship` (brew) | `starship` (pacman) | Optional if equivalent prompt customizations exist |
| Directory jumper | `zoxide` (brew) | `zoxide` (pacman) | Optional but recommended |
| Claude CLI | `claude-code` (cask) | `claude-code-bin` (AUR, typical) | May be distributed under different AUR name |

## Known Exceptions
- If Claude CLI is intentionally absent, `VAL-shell-05` may be waived only when AI workflow profile is disabled.
