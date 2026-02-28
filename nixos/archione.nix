{ config, pkgs, lib, ... }:

{
  imports = [];

  system.stateVersion = "25.11";

  users.users.mc = {
    isNormalUser = true;
    home = "/home/mc";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "audio" "video" ];
  };

  environment.systemPackages = with pkgs; [
    fish
    starship
    zoxide
    tmux
    neovim
    ripgrep
    fd
    bat
    eza
    dust
    bottom
    jq
    yq
    procs
    hyperfine
    xh
    git-delta
    lazygit
    github-cli
    git-lfs
    openssh
    bun
  ];

  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;

  programs.fish.enable = true;
  programs.fish.shellAliases = {
    gc = "git commit";
  };

  programs.tmux.enable = true;

  security.sudo.wheelNeedsPassword = false;
}
