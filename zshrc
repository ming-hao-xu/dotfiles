# Use fig only for completion, not for dotfiles management
# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"

# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="spaceship"
SPACESHIP_TIME_SHOW=true # Show time in spaceship prompt

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
autoupdate
you-should-use
zsh-autosuggestions
zsh-syntax-highlighting
)

# zsh-completions config
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# you-should-use config (customize prompt)
export YSU_MESSAGE_FORMAT="$(tput setaf 1)Found %alias_type for %command: %alias$(tput sgr0)"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="code -w"
else
  export EDITOR="code -w"
fi

## Aliases
# Override default exa
alias exa="exa -laF"
# To fix brew doctor's warning ""config" scripts exist outside your system or Homebrew directories"
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

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

## Functions
function update(){
  upgrade_oh_my_zsh_all # call autoupdate manually
  brew update && brew upgrade && brew upgrade --cask && brew cleanup && brew autoremove
}

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"
