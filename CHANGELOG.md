# Changelog

All notable changes to this repository are documented in this file.

## 2026-02-12 (shell recommendation policy)
- Removed fixed fish-package recommendation from shell capability mapping.
- Updated shell validation semantics to probe whichever shells are installed (`bash`, `zsh`, `fish`) without requiring fish installation.
- Updated shell scenarios and contribution verification rules to match installed-shell probing policy.

## 2026-02-12 (gh and git identity checks)
- Added core validation for `gh auth status` under SSH/Git access capability.
- Added core validation for GitHub credential helper integration from `gh auth setup-git` semantics.
- Added core validation for global git identity (`user.name` and `user.email`).
- Updated checklist and scenarios to include these new SSH/Git compliance checks.

## 2026-02-12 (lazyvim templates)
- Added `templates/lazyvim/plugins/` drop-in templates for:
  - hidden and gitignored files visible by default
  - `yp*` path-yank keymaps (`ypf`, `ypl`, `ypd`, `ypF`, `ypL`, `ypD`)
  - insert-mode relative path insertion
  - markdown preview plugin with headless-safe build command
- Documented template usage in `templates/lazyvim/README.md`.
- Added template mention to `README.md` and contribution guidance.

## 2026-02-12 (git pager compatibility)
- Added `less` recommendation in package tooling capability to prevent `git log`/`gl` pager failures.
- Added `gl` no-pager fallback mapping when pager tooling is intentionally absent.

## 2026-02-12 (session 2 hardening)
- Added mandatory post-install smoke probes (`<command> --version` or equivalent).
- Added native-first CLI sourcing for core tools (including Arch Codex mapping to `openai-codex-bin`).
- Added Bun global CLI shebang/runtime compatibility checks before considering installs successful.

## 2026-02-12
- Big-bang rewrite to Markdown + YAML-frontmatter contract model.
- Added `CONTRACT.md` invariants and contract-first README.
- Added contract schemas under `schemas/`.
- Added contract tooling: `tools/validate-contract.sh`, `tools/build-index.sh`.
- Added CI gate workflow `.github/workflows/contract.yml`.
- Added generated contract index `contracts/index.yaml`.
- Added runner interface definition `contracts/runner-contract.yaml`.
- Added structured waiver registry `validation/waivers.yaml`.
- Added missing capability contract `capabilities/deploy-firebase.md`.
- Reworked capability/profile/os/validation docs to frontmatter-backed contracts.
- Added retrospective hardening workflow to skills and `CONTRIBUTION.md`:
  - mandatory preflight checks
  - risk-batched execution rules
  - probe concurrency and retry guidance
- Hardened shell contracts with explicit fish runtime probe and bash init-chain checks.
- Clarified package-name vs command-name mapping semantics for Bun global CLIs (including `opencode-ai` -> `opencode`).
- Hardened markdown preview contract for headless-safe build method.
- Refined security scan contract to exclude contract docs from token-pattern matching.

## 2026-02-12 (earlier)
- Initialized independent git repository in `setup-env`.
- Added baseline spec structure for intention- and validation-based environment definitions.
- Added `AGENT.md` with agent operating instructions for this repo.
