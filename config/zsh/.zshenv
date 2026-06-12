# Keep PATH and FPATH entries unique
typeset -U PATH path FPATH fpath

# Set default locale
export LANG='en_US.UTF-8'
# Uncomment only if every locale category must be forced
# export LC_ALL='en_US.UTF-8'

# Set XDG base directories
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Store zsh startup files under XDG_CONFIG_HOME.
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
