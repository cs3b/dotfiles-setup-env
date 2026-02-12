# LazyVim Templates

Drop-in templates for common customizations referenced by this repo contract.

## Usage
1. Copy selected files from `templates/lazyvim/plugins/` into `~/.config/nvim/lua/plugins/`.
2. Start Neovim and sync plugins, or run:

```bash
nvim --headless "+Lazy! sync" +qa
```

## Included Templates
- `hidden-files-defaults.lua`: show hidden and gitignored files by default.
- `path-yank.lua`: `yp*` keymaps to copy file/dir paths (relative and absolute, with line variants).
- `insert-relative-path.lua`: insert-mode mapping to insert current file relative path.
- `markdown-preview.lua`: markdown preview plugin with headless-safe build command.
