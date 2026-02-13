# Evidence Collection

## Requirements
- Use command outputs relevant to pass condition.
- Keep evidence concise.
- Never expose secrets.
- For runtime/config checks, collect evidence from active system paths first (for example `~/.config/...`).
- When searching repo files, exclude `.git/`.

## Normalization
- Trim noisy output.
- Include exit code when relevant.
- Use the same probe for repeatability.
