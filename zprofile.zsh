# Include $HOME/.local/bin if it exists
if [[ -d $HOME/.local/bin ]]; then
    path=("$HOME/.local/bin" $path)
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Init Homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    ### Homebrew config ###
    export HOMEBREW_NO_ANALYTICS=true
    export HOMEBREW_NO_ENV_HINTS=true
fi

# Set neovim as default editor
export EDITOR='nvim'
export VISUAL="$EDITOR"
