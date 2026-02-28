{ config, pkgs, ... }:

{
  home.username = "mc";
  home.homeDirectory = "/home/mc";
  home.stateVersion = "25.11";

  programs.fish.enable = true;
  programs.tmux.enable = true;
  programs.neovim.enable = true;

  home.packages = with pkgs; [
    fish
    starship
    zoxide
    tmux
    neovim
    git
    git-delta
    lazygit
    bat
    fd
    ripgrep
  ];

  home.file = {
    ".config/fish/config.fish".source = ./fish/.config/fish/config.fish;
    ".config/fish/conf.d/abbreviations-git.fish".source = ./fish/.config/fish/conf.d/abbreviations-git.fish;
    ".config/fish/conf.d/abbreviations-claude.fish".source = ./fish/.config/fish/conf.d/abbreviations-claude.fish;
    ".config/fish/conf.d/abbreviations-ace-taskflow.fish".source = ./fish/.config/fish/conf.d/abbreviations-ace-taskflow.fish;
    ".config/nvim/lua/plugins/clipboard-osc52.lua".source = ./nvim/.config/nvim/lua/plugins/clipboard-osc52.lua;
    ".config/nvim/lua/plugins/snacks-visible.lua".source = ./nvim/.config/nvim/lua/plugins/snacks-visible.lua;
    ".tmux.conf".source = ./tmux/.tmux.conf;
  };

  home.sessionVariables = {
    COLORTERM = "truecolor";
  };
}
