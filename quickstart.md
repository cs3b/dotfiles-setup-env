# Quick Start (TL;DR)

## Minimum Requirements
- `git`
- `claude` (Claude Code CLI)

### Arch 

```
pacman -Syu --needed git
```

```
curl -fsSL https://claude.ai/install.sh | bash
```

### MacOS

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```bash
brew install git
brew install --cask claude-code
```

## 1) Clone to `~/.dotfiles`
```bash
git clone https://github.com/cs3b/dotfiles-setup-env.git .dotfiles
```

## 2) Start the Agent in This Folder
```bash
cd ~/.dotfiles
claude
```

## 3) Optional: Shared Clipboard Over SSH (iTerm2 + tmux + Neovim)
1. Ensure host terminal supports OSC52 and allows app clipboard access (iTerm2 setting).
2. Load tmux config from this repo:
```bash
tmux source-file ~/.dotfiles/tmux/.tmux.conf
```
3. Ensure Neovim loads plugin files from `~/.config/nvim/lua/plugins/`, including:
   - `~/.dotfiles/nvim/.config/nvim/lua/plugins/clipboard-osc52.lua`
4. In SSH Neovim sessions, regular yanks (`y`, `yy`) copy to host clipboard via OSC52.
5. Host-to-remote direction uses normal terminal paste (`Cmd+V`).

That is the minimum setup to start working.
