# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"

#define colors
YELLOW="\033[1;33m"
NOCOLOR="\033[0m"

### oh-my-zsh ###
# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="spaceship"

# Update oh-my-zsh
zstyle ':omz:update' mode auto # update automatically without asking
zstyle ':omz:update' frequency 30 # every 30 days
# Update plugins and themes (autoupdate plugin config)
export UPDATE_ZSH_DAYS=30 # every 30 days

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins
# * keep zsh-syntax-highlighting at last
plugins=(
autoupdate
you-should-use
git
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
# pyenv config
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# nvm config
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# pnpm config
export PNPM_HOME="/Users/kevin/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# set syntax-highlighting for man using bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Disable macOS's Gatekeeper for homebrew, some package may fail to get permissons (e.g Avira)
export HOMEBREW_CASK_OPTS="--no-quarantine"

# Default NULLCMD is cat, use bat when commands like `<<EOF` are used
export NULLCMD=bat

# Aliases
alias exa="exa -laFh --git" # Override default exa

alias cat='echo "Use ${YELLOW}bat${NOCOLOR} instead"; false'
alias rm='echo "Use ${YELLOW}trash${NOCOLOR} instead"; false'

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew' # Fix brew doctor's warning ""config" scripts exist outside your system or Homebrew directories"
alias path='<<<${(F)path}' # Print path in a column

# Functions
function update_package(){
  brew update && brew upgrade && brew upgrade --cask && brew cleanup && brew autoremove
  mas upgrade # upgrade mac app store apps through mas
}

function update_zsh(){
  upgrade_oh_my_zsh_all # call zsh autoupdate manually (include plugins and themes)
  # this function is from autoupdate plugin
}

# magic one-liner to remove duplicates, preserves the ordering of paths,
# and doesn't add a colon at the end
PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"
