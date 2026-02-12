# Runtime Version Manager Capability

## Capability ID
`CAP-version-manager`

## Status
`required`

## Intentions
- A runtime manager controls language runtime versions consistently across shells.
- Ruby and Bun runtimes are managed declaratively as default environments.
- Shim or equivalent indirection is available so runtime-selected binaries resolve on `PATH`.
- Home-level runtime manager config is the source of truth for default runtimes.
- Bun-managed global CLI tools include `gemini`, `opencode`, and `pi-mono`.

## Validation Rules
- `Rule ID`: `VAL-version-manager-01`
  - `Assertion`: Runtime manager binary exists.
  - `Method`: verify `mise` (or declared equivalent) command.
  - `Pass`: command is available.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-version-manager-02`
  - `Assertion`: Ruby runtime is managed and available.
  - `Method`: check runtime-manager tool list and `ruby --version`.
  - `Pass`: Ruby is declared and executable.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-version-manager-03`
  - `Assertion`: Bun runtime is managed and available.
  - `Method`: check runtime-manager tool list and `bun --version`.
  - `Pass`: Bun is declared and executable.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-version-manager-04`
  - `Assertion`: Shell sessions expose managed shims.
  - `Method`: inspect `PATH` for manager shim directory and resolve managed binaries.
  - `Pass`: managed runtime binaries resolve to shim/manager path.
  - `Severity`: `warn`
- `Rule ID`: `VAL-version-manager-05`
  - `Assertion`: Home-level mise global config exists and declares default runtimes.
  - `Method`: inspect `~/.config/mise/config.toml`.
  - `Pass`: config file exists and includes declarative runtime entries for `ruby` and `bun`.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-version-manager-06`
  - `Assertion`: Bun-managed global AI CLIs are available.
  - `Method`: verify `gemini`, `opencode`, and `pi-mono` commands; inspect command resolution path.
  - `Pass`: all three commands resolve from bun/mise-managed global runtime paths.
  - `Severity`: `blocker`

## OS Package Mapping
| Canonical Capability | macOS Package ID | Arch Package ID | Notes |
| --- | --- | --- | --- |
| Runtime manager | `mise` | `mise` | Equivalent manager allowed if declared |
| Ruby runtime | manager-provisioned | manager-provisioned | Validate via runtime availability |
| Bun runtime | manager-provisioned | manager-provisioned | Validate via runtime availability |
| Gemini CLI (bun global) | bun-managed global package | bun-managed global package | Validate command capability, not package registry naming |
| OpenCode CLI (bun global) | bun-managed global package | bun-managed global package | Validate command capability, not package registry naming |
| pi-mono CLI (bun global) | bun-managed global package | bun-managed global package | Validate command capability, not package registry naming |

## Known Exceptions
- If an alternative runtime manager is used, spec consumer must declare replacement and preserve validation semantics.
