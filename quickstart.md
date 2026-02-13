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

That is the minimum setup to start working.
