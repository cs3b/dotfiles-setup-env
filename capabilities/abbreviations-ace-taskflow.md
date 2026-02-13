---
kind: capability
capability_id: CAP-abbreviations-ace-taskflow
status: required
intentions:
  - ace-taskflow shortcut mapping is defined for active-shell usage.
  - Shortcut implementation is shell-native (fish abbreviations; bash/zsh aliases or functions).
  - No extra manual per-shell step is needed after setup for the selected shell.
rules:
  - rule_id: VAL-abbreviations-ace-taskflow-01
    assertion: ace-taskflow command is available.
    method: Run command -v ace-taskflow.
    pass_condition: Command resolves on PATH.
    severity: warn
  - rule_id: VAL-abbreviations-ace-taskflow-02
    assertion: Required ace-taskflow shortcut mapping exists in active shell.
    method: Detect active shell and inspect shell-native shortcut registry for tfts.
    pass_condition: tfts expands to ace-taskflow tasks in active shell context (fish abbr or equivalent alias/function in bash/zsh).
    severity: blocker
  - rule_id: VAL-abbreviations-ace-taskflow-03
    assertion: Shell-native fallback is present for non-fish shells.
    method: Inspect bash/zsh alias or function mappings when bash or zsh is the active shell.
    pass_condition: Active bash/zsh sessions resolve tfts through alias/function mapping to ace-taskflow tasks.
    severity: warn
os_package_mapping:
  - canonical_capability: ace-taskflow-cli
    macos_package_id: custom-tooling
    arch_package_id: custom-tooling
    notes: Command distribution may be internal; validate behavior by command probes.
  - canonical_capability: ace-taskflow-shortcuts
    macos_package_id: shell-config
    arch_package_id: shell-config
    notes: Capability is config-based and shell-agnostic.
known_exceptions:
  - id: EXC-abbreviations-ace-taskflow-01
    statement: If ace-taskflow is intentionally omitted, shortcut checks may be acknowledged only as non-blocking warnings.
    compliance_impact: blocker-waivable
---
# ace-taskflow Abbreviations Capability

This capability defines taskflow shortcut expectations independently from shell runtime and other shortcut groups.
