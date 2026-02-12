# Probe Catalog

## Common Probes
- Binary presence: `command -v <name>`
- Version probe: `<name> --version`
- Post-install smoke probe: run `<name> --version` (or noninteractive help) immediately after each install or upgrade step
- Runtime probe: shell noninteractive checks
- Config probe: inspect expected config files and key entries
- Entrypoint probe (script CLIs): inspect first shebang line for runtime dependency mismatches

## Probe Batching
- Cap parallel probe groups to 8-10 commands.
- Avoid very large fan-out probe batches that can cause empty output capture.

## Evidence Rules
- Keep command and output snippets short.
- Redact secrets.
- Prefer deterministic probes.
- If output is empty, re-run that probe in a focused second pass.
- Do not mark install success until the smoke probe passes.
