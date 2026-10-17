# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# Add user-local binaries
if [[ -d "$HOME/.local/bin" ]]; then
    path=("$HOME/.local/bin" $path)
fi

# Set neovim as default editor
export EDITOR='nvim'
export VISUAL="$EDITOR"

# Quit less when output fits on one screen; set before OMZ defaults LESS to -R,
# which stops git and gh from adding their own -F
export LESS='-FR'

# Load ignored machine-local config
[[ -f "$ZDOTDIR/.zprofile.local" ]] && source "$ZDOTDIR/.zprofile.local"
