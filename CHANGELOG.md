# Changelog

All notable changes to this repository are documented in this file.

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
