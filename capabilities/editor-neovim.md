---
kind: capability
capability_id: CAP-editor-neovim
status: required
intentions:
  - Neovim is present and usable as a default advanced editor.
  - Configuration is LazyVim-based.
  - File discovery UX includes hidden and ignored files by default.
  - Markdown preview capability exists.
  - Insert-mode relative path insertion capability exists.
  - Path yanking shortcuts exist for relative and absolute outputs.
rules:
  - rule_id: VAL-editor-neovim-01
    assertion: Neovim binary is installed and launchable.
    method: Run nvim --version.
    pass_condition: Command succeeds and reports a version.
    severity: blocker
  - rule_id: VAL-editor-neovim-02
    assertion: LazyVim baseline is active.
    method: Inspect config for LazyVim bootstrap or import.
    pass_condition: Config references LazyVim plugin set as base.
    severity: blocker
  - rule_id: VAL-editor-neovim-03
    assertion: Hidden and ignored files are visible in picker and explorer workflows.
    method: Inspect picker and explorer config state and effective defaults.
    pass_condition: Hidden and ignored visibility toggles default to enabled (for example Telescope hidden=true and no_ignore=true; explorer hide_dotfiles=false and hide_gitignored=false).
    severity: warn
  - rule_id: VAL-editor-neovim-04
    assertion: Markdown preview capability is available.
    method: Validate markdown-preview plugin presence and inspect build command for headless-safe install semantics.
    pass_condition: Markdown preview command namespace is registered and plugin build uses a noninteractive-safe command (for example cd app && npx --yes yarn install).
    severity: warn
  - rule_id: VAL-editor-neovim-05
    assertion: Insert-mode relative-path insertion exists.
    method: Inspect keymap or plugin config for insert mapping.
    pass_condition: Mapping exists and inserts project-relative paths.
    severity: warn
  - rule_id: VAL-editor-neovim-06
    assertion: Path yank keymaps exist.
    method: Inspect keymaps for ypf, ypl, ypd, ypF, ypL, and ypD semantics.
    pass_condition: All path yank actions are mapped and documented.
    severity: warn
os_package_mapping:
  - canonical_capability: neovim
    macos_package_id: neovim
    arch_package_id: neovim
    notes: Required.
  - canonical_capability: lazyvim-baseline
    macos_package_id: n-a
    arch_package_id: n-a
    notes: Config-level capability.
  - canonical_capability: markdown-preview-backend
    macos_package_id: plugin-managed
    arch_package_id: plugin-managed
    notes: Validate behavior, not installer choice.
known_exceptions:
  - id: EXC-editor-neovim-01
    statement: Temporary plugin sync failures are noncompliant only if capability remains unavailable after retry.
    compliance_impact: warn
---
# Neovim Editor Capability

This capability defines observable Neovim behavior outcomes rather than a specific plugin manager workflow.
