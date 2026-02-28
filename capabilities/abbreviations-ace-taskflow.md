---
kind: capability
capability_id: CAP-abbreviations-ace-taskflow
status: required
intentions:
- ace-taskflow shortcut mapping is defined as a fish abbreviation.
- Shortcut implementation uses fish abbreviations.
- No extra manual step is needed after setup.
rules:
- rule_id: VAL-abbreviations-ace-taskflow-01
  assertion: ace-taskflow command is available.
  method: Run command -v ace-taskflow.
  pass_condition: Command resolves on PATH.
  severity: warn
- rule_id: VAL-abbreviations-ace-taskflow-02
  assertion: Required ace-taskflow shortcut mapping exists in fish.
  method: Inspect fish abbreviation registry for tfts.
  pass_condition: tfts expands to ace-taskflow tasks via fish abbreviation.
  severity: blocker
os_package_mapping:
- canonical_capability: ace-taskflow-cli
  notes: Command distribution may be internal; validate behavior by command probes.
  os_package_ids:
    OS-macos: custom-tooling
    OS-arch: custom-tooling
    OS-nixos: custom-tooling
- canonical_capability: ace-taskflow-shortcuts
  notes: Capability is config-based; implemented as fish abbreviations.
  os_package_ids:
    OS-macos: shell-config
    OS-arch: shell-config
    OS-nixos: shell-config
known_exceptions:
- id: EXC-abbreviations-ace-taskflow-01
  statement: If ace-taskflow is intentionally omitted, shortcut checks may be acknowledged
    only as non-blocking warnings.
  compliance_impact: blocker-waivable
---

# ace-taskflow Abbreviations Capability

This capability defines taskflow shortcut expectations as fish shell abbreviations.
