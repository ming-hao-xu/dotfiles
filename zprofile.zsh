# Determine the platform
export OS_TYPE=$(uname -s)

# Include $HOME/.local/bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    path=("$HOME/.local/bin" $path)
fi

if [[ "$OS_TYPE" == "Darwin" ]]; then
    # Init Homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    ### Homebrew config ###
    # Avoid Gatekeeper checks on macOS
    export HOMEBREW_CASK_OPTS='--no-quarantine'
    # Make `brew cleanup` and `brew uninstall` autoremove unneed dependencies
    export HOMEBREW_AUTOREMOVE=true
    # Suppress environment hints, providing a cleaner terminal output
    export HOMEBREW_NO_ENV_HINTS=true
    # Opt-out analytics
    export HOMEBREW_NO_ANALYTICS=true

    # miniconda
    __conda_setup="$(/opt/homebrew/Caskroom/miniconda/base/bin/conda shell.zsh hook 2>/dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    elif [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        source "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        path=("/opt/homebrew/Caskroom/miniconda/base/bin" $path)
    fi
    unset __conda_setup

elif [[ "$OS_TYPE" == "Linux" ]]; then
    # miniconda
    __conda_setup="$("$HOME/miniconda3/bin/conda" 'shell.zsh' 'hook' 2>/dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    elif [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        source "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        path=("$HOME/miniconda3/bin" $path)
    fi
    unset __conda_setup
fi

# Set neovim as default editor
export EDITOR='nvim'
export VISUAL=$EDITOR
