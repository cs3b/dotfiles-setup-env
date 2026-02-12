# Optional AI Coding Profile

## Profile ID
`PROFILE-optional-ai-coding`

## Purpose
Defines extra capabilities for AI-assisted coding workflows.

## Included Capabilities
- `CAP-deploy-firebase`
- `CAP-ai-auth`

## Additional Expectations
- Claude CLI command availability.
- Shell shortcuts for Claude task workflows are enabled (`cc-*`).
- Optional local helper tools (for example `ace-git`, `ace-taskflow`, `ace-git-worktree`) may be present and can define extra abbreviations.
- Authentication readiness checks are available for `gh`, `codex`, `claude`, `gemini`, `opencode`, and `pi-mono`.

## Validation Policy
- All rules here are `warn` severity by default unless this profile is declared mandatory by consumer policy.
