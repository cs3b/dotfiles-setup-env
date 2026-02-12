---
kind: capability
capability_id: CAP-deploy-firebase
status: optional:PROFILE-optional-ai-coding
intentions:
  - Firebase deployment tooling readiness is available for optional workflows.
  - Deployment checks remain non-blocking unless consumer policy promotes this profile.
  - Validation avoids destructive deployment actions.
rules:
  - rule_id: VAL-deploy-firebase-01
    assertion: Firebase CLI is available.
    method: Run firebase --version.
    pass_condition: Command succeeds and reports a version.
    severity: warn
  - rule_id: VAL-deploy-firebase-02
    assertion: Firebase authentication state is inspectable.
    method: Run firebase login:list or equivalent noninteractive auth probe.
    pass_condition: Auth state can be inspected, or missing auth is recorded as warning.
    severity: warn
os_package_mapping:
  - canonical_capability: firebase-cli
    macos_package_id: firebase-cli
    arch_package_id: firebase-cli
    notes: Optional profile capability.
known_exceptions:
  - id: EXC-deploy-firebase-01
    statement: Teams that do not use Firebase may keep this capability disabled by leaving optional profile unset.
    compliance_impact: none
---
# Firebase Deploy Capability

This capability defines optional Firebase deployment readiness checks.
