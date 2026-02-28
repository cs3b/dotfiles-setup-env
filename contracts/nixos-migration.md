# NixOS Migration Blueprint (Outcome Parity)

## Scope
- Target parity model: NixOS + Home Manager.
- Rollout mode: add NixOS alongside existing Arch and macOS contracts.
- Priority architecture: `aarch64-linux` first; `x86_64-linux` tracked as follow-up.
- Repository constraint: specification-only, no provisioning scripts.

## Inputs and Contract Decisions
- Keep current blocker/warn severities unchanged.
- Keep runtime-manager outcome centered on `mise`.
- Prefer nixpkgs-native package sources; use alternate source only with documented exception and smoke probe evidence.
- Allow unfree packages when required and explicitly documented.

## Ownership Model
- NixOS modules own system-level package/service expectations.
- Home Manager owns user-level CLI presentation and dotfile placement.
- Capability compliance is measured by command/runtime outcomes, not installer mechanism.

## Dotfile Mapping for Home Manager
- `fish/.config/fish/config.fish` -> `~/.config/fish/config.fish`
- `fish/.config/fish/conf.d/*.fish` -> `~/.config/fish/conf.d/*.fish`
- `nvim/.config/nvim/lua/plugins/*.lua` -> `~/.config/nvim/lua/plugins/*.lua`
- `tmux/.tmux.conf` -> `~/.tmux.conf`

## Flakes Target Layout
- `flake.nix` pins nixpkgs and home-manager inputs.
- `nixosConfigurations.<host>` defines system modules.
- `homeConfigurations.<user@host>` defines user module composition.
- Capability mappings use verified nix attr names or an explicit exception marker.

## Capability Mapping Workflow
1. For each capability `os_package_mapping` entry, verify a concrete `OS-nixos` package/source value.
2. If nixpkgs provides a native package, record that attr.
3. If unavailable, record approved alternate source marker and rationale linkage.
4. Validate command-level smoke probe semantics remain aligned with current rule methods.

## Required Exception and Waiver Handling
- Any non-native source for required tooling must reference a known exception narrative in the owning capability or OS contract.
- If environment-specific constraints block compliance, record scoped waivers in `validation/waivers.yaml` with expiry and owner.

## Acceptance Criteria
- `OS-nixos` present with three platform rules (`VAL-os-nixos-01..03`).
- `SCN-fresh-nixos-core` present and references `OS-nixos`.
- Checklist categorizes all NixOS rule IDs exactly once.
- Every capability mapping entry contains `OS-macos`, `OS-arch`, and `OS-nixos` keys.
- `tools/build-index.sh` and `tools/validate-contract.sh` pass.

## Follow-up Track (`x86_64-linux`)
- Re-run package/source verification for `x86_64-linux`.
- Document any architecture-specific divergences in capability notes or waivers without changing shared rule IDs unless behavior semantics differ.
