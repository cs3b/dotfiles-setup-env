# Package Tooling Capability

## Capability ID
`CAP-package-tooling`

## Status
`required`

## Intentions
- Core command-line toolchain exists for search, file inspection, JSON/YAML processing, git ergonomics, HTTP requests, benchmarking, process/system inspection.
- Tool names are discoverable on `PATH`.
- Equivalent alternatives are acceptable only if they satisfy the same operational capability.
- Native-installed AI coding CLIs are present for `codex` and `claude`.
- Git bootstrap helper command `gh-init` is available for initializing repositories with a baseline `.gitignore`.

## Validation Rules
- `Rule ID`: `VAL-package-tooling-01`
  - `Assertion`: Search and file-discovery tools exist.
  - `Method`: verify `rg` and `fd` binaries.
  - `Pass`: both commands are available.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-package-tooling-02`
  - `Assertion`: Structured data tooling exists.
  - `Method`: verify `jq` and `yq` binaries.
  - `Pass`: both commands are available.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-package-tooling-03`
  - `Assertion`: Git workflow helpers exist.
  - `Method`: verify `git`, `gh`, `delta`, `lazygit`, `git-lfs`.
  - `Pass`: all commands are available.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-package-tooling-04`
  - `Assertion`: Terminal productivity tools exist.
  - `Method`: verify `bat`, `eza`, `dust`, `bottom`/`btm`, `procs`, `hyperfine`, `xh`, `tldr`, `bandwhich`.
  - `Pass`: all listed capabilities are present (name variants allowed where noted).
  - `Severity`: `warn`
- `Rule ID`: `VAL-package-tooling-05`
  - `Assertion`: Native AI coding CLIs are installed.
  - `Method`: verify `codex --version` and `claude --version` (or equivalent version/help probe).
  - `Pass`: both commands are available from native system install paths.
  - `Severity`: `blocker`
- `Rule ID`: `VAL-package-tooling-06`
  - `Assertion`: Git bootstrap helper `gh-init` is available.
  - `Method`: verify `command -v gh-init`.
  - `Pass`: command resolves on `PATH`.
  - `Severity`: `warn`

## OS Package Mapping
| Canonical Capability | macOS Package ID | Arch Package ID | Notes |
| --- | --- | --- | --- |
| ripgrep | `ripgrep` | `ripgrep` | Required |
| fd | `fd` | `fd` | Required |
| bat | `bat` | `bat` | Recommended |
| eza | `eza` | `eza` | Recommended |
| dust | `dust` | `dust` | Recommended |
| bottom | `bottom` | `bottom` | Binary may be `btm` |
| jq | `jq` | `jq` | Required |
| yq | `yq` | `yq` | Required |
| procs | `procs` | `procs` | Recommended |
| hyperfine | `hyperfine` | `hyperfine` | Recommended |
| zoxide | `zoxide` | `zoxide` | Recommended |
| starship | `starship` | `starship` | Recommended |
| git delta | `git-delta` | `git-delta` | Required for enhanced diff ergonomics |
| xh | `xh` | `xh` | Recommended |
| tealdeer | `tealdeer` | `tealdeer` | Recommended |
| bandwhich | `bandwhich` | `bandwhich` | Recommended |
| lazygit | `lazygit` | `lazygit` | Required |
| github cli | `gh` | `github-cli` | Required |
| git lfs | `git-lfs` | `git-lfs` | Required |
| Codex CLI | `codex` (cask/formula as distributed) | `codex` (AUR/community package name may vary) | Required; native install |
| Claude Code CLI | `claude-code` (cask) | `claude-code`/`claude-code-bin` (AUR name may vary) | Required; native install |
| gh-init helper | custom script/tooling | custom script/tooling | Recommended; validates repository bootstrap workflow |

## Known Exceptions
- If a tool is replaced by a functionally equivalent binary, record equivalence rationale and update validation probe accordingly.
