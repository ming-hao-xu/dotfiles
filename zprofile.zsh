# Determine the platform
export OS_TYPE=$(uname -s)

# Include $HOME/.local/bin if it exists and is not empty
if [[ -d "$HOME/.local/bin" ]] && [[ -n "$HOME/.local/bin/*(N)" ]]; then
    path=("$HOME/.local/bin" "${path[@]}")
fi

if [[ "$OS_TYPE" == "Darwin" ]]; then
    # Init Homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    ### Homebrew config ###
    # Avoid Gatekeeper checks on macOS
    export HOMEBREW_CASK_OPTS='--no-quarantine'
    # Suppress environment hints, providing a cleaner terminal output
    export HOMEBREW_NO_ENV_HINTS=true
    # Opt-out analytics
    export HOMEBREW_NO_ANALYTICS=true
    # Speed up repeated brew calls
    export HOMEBREW_BOOTSNAP=true
fi

# Set neovim as default editor
export EDITOR='nvim'
export VISUAL="$EDITOR"
