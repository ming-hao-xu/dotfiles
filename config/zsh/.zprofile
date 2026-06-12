# Homebrew
if [[ "$OSTYPE" == darwin* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Add user-local binaries
if [[ -d "$HOME/.local/bin" ]]; then
    path=("$HOME/.local/bin" $path)
fi

# Set neovim as default editor
export EDITOR='nvim'
export VISUAL="$EDITOR"
