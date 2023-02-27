# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zprofile.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.pre.zsh"

# Locale settings for language and character encoding
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Homebrew initialization
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_CASK_OPTS="--no-quarantine" # disable macOS's Gatekeeper
export HOMEBREW_AUTOREMOVE="true"
export HOMEBREW_BAT="true"
export HOMEBREW_NO_ENV_HINTS="true"
export HOMEBREW_NO_ANALYTICS="true"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zprofile.post.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.post.zsh"
