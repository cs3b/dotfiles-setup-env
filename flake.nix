{
  description = "NixOS + Home Manager configuration aligned with the setup-env contracts.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        homeCfg = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          modules = [ ./home/mc.nix ];
        };
      in {
        nixosConfigurations.archione = pkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./nixos/archione.nix homeCfg.nixosModules.home-manager ];
        };
        homeConfigurations.mc = homeCfg;
      });
}
