# PATH
fish_add_path $HOME/.local/bin $HOME/.bun/bin $HOME/ace-meta/bin

# Runtime manager
if command -q mise
    mise activate fish | source
end

# Shell integrations
if command -q fzf
    fzf --fish | source
end
if command -q zoxide
    zoxide init fish | source
end
if command -q starship
    starship init fish | source
end

# Environment
set -gx COLORTERM truecolor
