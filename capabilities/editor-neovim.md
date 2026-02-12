# Neovim Editor Capability

## Capability ID
`CAP-editor-neovim`

## Status
`required`

## Intentions
- Neovim is present and usable as the default advanced editor.
- Configuration is LazyVim-based.
- File discovery UX includes hidden and ignored files by default in explorer/picker workflows.
- Markdown preview capability exists.
- Insert-mode path insertion capability exists for project-relative paths.
- Path yanking shortcuts exist for relative and absolute file/line/directory outputs.

## Validation Rules
- `Rule ID`: `VAL-editor-neovim-01`
  - `Assertion`: Neovim binary is installed and launches.
  - `Method`: run `nvim --version`.
  - `Pass`: command succeeds and reports a version.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-editor-neovim-02`
  - `Assertion`: LazyVim baseline is active.
  - `Method`: inspect config for LazyVim bootstrap/import.
  - `Pass`: config references LazyVim plugin set as base.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-editor-neovim-03`
  - `Assertion`: Hidden/ignored files are visible in picker/explorer workflows.
  - `Method`: inspect picker/explorer config state.
  - `Pass`: hidden and ignored visibility toggles default to enabled.
  - `Severity`: `warn`
- `Rule ID`: `VAL-editor-neovim-04`
  - `Assertion`: Markdown preview capability is available.
  - `Method`: validate markdown-preview plugin/command presence.
  - `Pass`: markdown preview command namespace is registered.
  - `Severity`: `warn`
- `Rule ID`: `VAL-editor-neovim-05`
  - `Assertion`: Insert-mode relative-path insertion exists.
  - `Method`: inspect keymap/plugin config for insert mapping.
  - `Pass`: mapping exists and inserts project-relative paths.
  - `Severity`: `warn`
- `Rule ID`: `VAL-editor-neovim-06`
  - `Assertion`: Path yank keymaps exist.
  - `Method`: inspect keymaps for `ypf`, `ypl`, `ypd`, `ypF`, `ypL`, `ypD` semantics.
  - `Pass`: all path yank actions are mapped and documented.
  - `Severity`: `warn`

## OS Package Mapping
| Canonical Capability | macOS Package ID | Arch Package ID | Notes |
| --- | --- | --- | --- |
| Neovim | `neovim` | `neovim` | Required |
| LazyVim baseline | N/A | N/A | Config-level capability, not package |
| Markdown preview backend deps | bundled/npm as plugin requires | bundled/npm as plugin requires | Validate behavior, not installer choice |

## Known Exceptions
- Temporary plugin-manager sync failures are noncompliant only if capability remains unavailable after retry.
