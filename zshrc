# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"

### Oh-my-zsh ###
# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="spaceship"

# Update oh-my-zsh
zstyle ':omz:update' mode auto # update automatically without asking
zstyle ':omz:update' frequency 14 # every 14 days
# Update plugins and themes (autoupdate plugin config)
export UPDATE_ZSH_DAYS=14 # every 14 days

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins
# keep zsh-syntax-highlighting at last
plugins=(
you-should-use
autoupdate
zsh-autosuggestions
zsh-syntax-highlighting
)

# zsh-completions config
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Manually set language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR="code -w"

source $ZSH/oh-my-zsh.sh

### normal config ###
# Aliases
alias exa="exa -laF" # Override default exa
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew' # Fix brew doctor's warning ""config" scripts exist outside your system or Homebrew directories"

# pyenv config
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# nvm config
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# batman, syntax-highlighting for man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Disable macOS's Gatekeeper for homebrew
export HOMEBREW_CASK_OPTS="--no-quarantine"

# Functions
function update_package(){
  brew update && brew upgrade && brew upgrade --cask && brew cleanup && brew autoremove
  mas upgrade # upgrade mac app store apps through mas
}

function update_zsh(){
  upgrade_oh_my_zsh_all # call zsh autoupdate manually (include plugins and themes)
}

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"
