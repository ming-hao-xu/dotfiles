# Ensure important arrays have unique entries
typeset -U PATH path FPATH fpath

# Set LOCALE
export LANG='en_US.UTF-8'
# Generally, setting LANG is sufficient. If you need to enforce it for all locale categories, uncomment the following line:
# export LC_ALL='en_US.UTF-8'

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
