# Arch Linux Platform Constraints

## OS ID
`OS-arch`

## Intentions
- Package source of record is pacman for official packages and AUR for missing tools.
- Runtime manager and shell capabilities match macOS behavior expectations.
- Any macOS-specific assumptions are replaced with Arch equivalents.

## Validation Rules
- `Rule ID`: `VAL-os-arch-01`
  - `Assertion`: Arch package tooling is available.
  - `Method`: run `pacman --version`.
  - `Pass`: command succeeds.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-os-arch-02`
  - `Assertion`: Core packages resolve via pacman or AUR mapping.
  - `Method`: for each mapped package, verify install state or binary presence.
  - `Pass`: all required core capabilities are satisfied.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-os-arch-03`
  - `Assertion`: Shell startup preserves runtime manager and path behavior.
  - `Method`: run shell noninteractive probes.
  - `Pass`: runtime manager and required binaries resolve in shell context.
  - `Severity`: `warn`

## Known Exceptions
- Package IDs for cask-only macOS tools may require AUR/community alternatives; validate capability outcome rather than exact source.
