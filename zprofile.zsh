# Include $HOME/.local/bin if it exists
if [[ -d "$HOME/.local/bin" ]]; then
    path=("$HOME/.local/bin" $path)
fi

### Homebrew ###
if [[ "$OSTYPE" == darwin* ]]; then
    # Init
    eval "$(/opt/homebrew/bin/brew shellenv)"
    # config
    export HOMEBREW_NO_ANALYTICS=true
    export HOMEBREW_NO_ENV_HINTS=true
fi

# Set neovim as default editor
export EDITOR='nvim'
export VISUAL="$EDITOR"
