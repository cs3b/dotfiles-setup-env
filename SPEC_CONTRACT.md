# Spec Contract

Every capability spec in `setup-env/capabilities/` must use this section schema exactly:

1. `Capability ID`
2. `Status`
3. `Intentions`
4. `Validation Rules`
5. `OS Package Mapping`
6. `Known Exceptions`

## Field Rules

### Capability ID
- Format: `CAP-<slug>`
- Example: `CAP-shell`

### Status
- Allowed values:
  - `required`
  - `optional:<profile-name>`

### Intentions
- Describe outcomes only.
- Do not include setup steps.
- Statements must be testable.

### Validation Rules
Each rule must include:
- `Rule ID`: `VAL-<capability>-NN`
- `Assertion`: one objective statement
- `Method`: validation probe (command or observable state)
- `Pass`: explicit expected condition
- `Severity`: `blocker` or `warn`

### OS Package Mapping
Each row must include:
- `Canonical Capability`
- `macOS Package ID`
- `Arch Package ID`
- `Notes`

Package IDs are advisory mapping metadata. Validation of compliance is based on capability outcomes (for example, binary availability and behavior), not package source.

### Known Exceptions
- Document accepted deviations and their impact.
- Must state whether exception affects compliance.
