---
kind: profile
profile_id: PROFILE-optional-ai-coding
included_capabilities:
  - CAP-deploy-firebase
  - CAP-ai-auth
validation_policy:
  blockers_required: false
  warns_should_pass: true
  warn_failure_requires_ack: true
---
# Optional AI Coding Profile

Defines additional non-blocking capabilities for AI-assisted coding workflows.
