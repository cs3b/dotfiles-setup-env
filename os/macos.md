# macOS Platform Constraints

## OS ID
`OS-macos`

## Intentions
- Package source of record is Homebrew for most userland CLI tools.
- Homebrew prefix follows Apple Silicon default (`/opt/homebrew`) unless intentionally overridden.
- Shell and runtime manager integration work in login and noninteractive contexts.

## Validation Rules
- `Rule ID`: `VAL-os-macos-01`
  - `Assertion`: Homebrew is available.
  - `Method`: run `brew --version`.
  - `Pass`: command succeeds.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-os-macos-02`
  - `Assertion`: Homebrew prefix matches intended default.
  - `Method`: run `brew --prefix`.
  - `Pass`: output is `/opt/homebrew` unless documented exception exists.
  - `Severity`: `warn`
- `Rule ID`: `VAL-os-macos-03`
  - `Assertion`: Managed shell config exports expected Homebrew paths.
  - `Method`: inspect shell startup environment.
  - `Pass`: `PATH` contains Homebrew bin/sbin entries.
  - `Severity`: `warn`

## Known Exceptions
- Intel macOS hosts may use `/usr/local`; mark as explicit exception with architecture note.
