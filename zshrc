# Fig pre block. Keep at the top of this file
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"

# Define some colors
YELLOW="\033[1;33m"
NOCOLOR="\033[0m"

### oh-my-zsh config ###
# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="spaceship"

# Update oh-my-zsh
zstyle ':omz:update' mode auto # update omz every 30 days
zstyle ':omz:update' frequency 30
export UPDATE_ZSH_DAYS=30 # update plugins and themes using autoupdate plugin every 30 days

# Display red dots whilst waiting for completion
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty
# This makes repository status check for large repositories much, much faster
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
# Call nvm use automatically whenever entering a directory that contains an .nvmrc file with a string telling nvm which node to use
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# pnpm config
export PNPM_HOME="/Users/kevin/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# set syntax-highlighting for man using bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Disable macOS's Gatekeeper for homebrew
export HOMEBREW_CASK_OPTS="--no-quarantine"

# Default NULLCMD is cat, use bat when commands like `<<EOF` are used
export NULLCMD=bat

# Aliases
alias exa="exa -laFh --git --icons" # Display a table of files with header, showing each file's metadata, Git status, and icons

alias cat="bat"
alias rm='echo "Use ${YELLOW}trash${NOCOLOR} instead"; false' # trash-cli is quite different from rm (e.g. -r), better no to override rm

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew' # Fix brew doctor's warning ""config" scripts exist outside your system or Homebrew directories"
alias path='<<<${(F)path}' # Print path in a column

# Functions
function update_packages(){
  echo "${YELLOW}Updating brew...${NOCOLOR}"
  brew update && brew upgrade && brew upgrade --cask && brew autoremove

  echo "${YELLOW}Updating AppStore Apps...${NOCOLOR}"
  mas upgrade

  echo "${YELLOW}Updating pip packages...${NOCOLOR}"
  pipupgrade --self && pipupgrade --yes 2>/dev/null # discard stderr
}

function update_zsh(){
  echo "Wait until Spaceship prompt is fixed"
  # upgrade_oh_my_zsh_all # * this function is from autoupdate plugin, update all plugins and themes
}

# one-liner to remove duplicates, preserves the ordering of paths, and doesn't add a colon at the end
PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"
