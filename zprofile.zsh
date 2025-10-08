# Include $HOME/.local/bin if it exists
if [[ -d "$HOME/.local/bin" ]]; then
    path=("$HOME/.local/bin" $path)
fi

### Homebrew ###
if [[ "$OSTYPE" == darwin* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set neovim as default editor
export EDITOR='nvim'
export VISUAL="$EDITOR"
