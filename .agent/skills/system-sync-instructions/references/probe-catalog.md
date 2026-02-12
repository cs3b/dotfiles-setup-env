# Probe Catalog

## Common Probes
- Binary presence: `command -v <name>`
- Version probe: `<name> --version`
- Runtime probe: shell noninteractive checks
- Config probe: inspect expected config files and key entries

## Evidence Rules
- Keep command and output snippets short.
- Redact secrets.
- Prefer deterministic probes.
