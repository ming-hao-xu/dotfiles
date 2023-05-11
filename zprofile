# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zprofile.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.pre.zsh"

# Set language and character encoding to US English
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

# Initialize Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
# Set Homebrew options
export HOMEBREW_CASK_OPTS='--no-quarantine'
export HOMEBREW_AUTOREMOVE='true'
export HOMEBREW_BAT='true'
export HOMEBREW_NO_ENV_HINTS='true'
export HOMEBREW_NO_ANALYTICS='true'

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zprofile.post.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.post.zsh"
