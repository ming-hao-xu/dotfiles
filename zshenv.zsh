# Ensure important arrays have unique entries
typeset -U path PATH fpath FPATH manpath MANPATH

# Configure proxy settings
# export https_proxy=''
# export http_proxy=''
# export all_proxy=''

# Set LOCALE
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
