# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# mise shims for non-interactive shells and GUI apps (e.g. VS Code)
eval "$(mise activate zsh --shims)"

# Add user-local binaries
if [[ -d "$HOME/.local/bin" ]]; then
    path=("$HOME/.local/bin" $path)
fi

# Set neovim as default editor
export EDITOR='nvim'
export VISUAL="$EDITOR"
