### Fig pre block. Keep at the top of this file ###
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# Define some colors
RED="\033[1;31m"
NOCOLOR="\033[0m"

### oh-my-zsh config ###
# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="spaceship" # now using starship in Rust

# Update oh-my-zsh
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 30 # update omz every 30 days
export UPDATE_ZSH_DAYS=30 # update plugins and themes using autoupdate plugin every 30 days

# Display red dots whilst waiting for completion
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty
# This makes repository status check for large repositories much, much faster
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins to load
# * keep zsh-syntax-highlighting at last
plugins=(
autoupdate
you-should-use
git
zsh-autosuggestions
zsh-syntax-highlighting
)

# zsh-completions config
# adding it as a regular omz plugin will not work properly
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

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
export PNPM_HOME="$HOME/Library/pnpm"
[[ ":$PATH:" == *":$PNPM_HOME:"* ]] || export PATH="$PNPM_HOME:$PATH" # corepack
# command -v pnpm >/dev/null || export PATH="$PNPM_HOME:$PATH" # normal

# bat config
export BAT_CONFIG_PATH="$HOME/bat.conf"
export MANPAGER="sh -c 'col -bx | bat -l man -p'" # Set syntax-highlighting for man using bat

# fzf config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--exact --cycle'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--height 100% --preview-window wrap --preview 'bat --force-colorization --style="plain" --line-range :100 {}'"

export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS="--height 100% --preview 'tree -C {} | head -50'"

# Disable macOS's Gatekeeper for homebrew
export HOMEBREW_CASK_OPTS="--no-quarantine"

# Default NULLCMD is cat, use bat when commands like `<<EOF` are used
export NULLCMD=bat

# zoxide initalization
eval "$(zoxide init zsh --cmd cd)" # override cd

# Aliases
alias exa='exa -laFh --git --icons' # Display a table of files with header, showing each file's metadata, Git status, and icons

alias cat='bat'
alias rm='echo "Use ${RED}trash-cli${NOCOLOR} instead"; false' # trash-cli is quite different from rm (e.g. no -r), better not to override it

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew' # Fix brew doctor's warning ""config" scripts exist outside your system or Homebrew directories"
alias path='<<<${(F)path}' # Print path in a column using bat (NULLCMD)

# Functions
function update_packages(){
  echo "⬆️  ${RED}Updating brew...${NOCOLOR}"
  brew update && brew upgrade && brew upgrade --cask && brew autoremove

  echo "⬆️  ${RED}Updating App Store Apps...${NOCOLOR}"
  mas upgrade

  echo "⬆️  ${RED}Updating pip packages...${NOCOLOR}"
  pipupgrade --self && pipupgrade --yes 2>/dev/null

  echo "⬆️  ${RED}Updating npm and pnpm packages...${NOCOLOR}"
  npm update -g
  pnpm update -g

  # echo "⬆️  ${RED}Updating omz...${NOCOLOR}"
  # upgrade_oh_my_zsh_all # * this function comes from autoupdate plugin, update all plugins and themes

  echo "📦  ${RED}Dumping packages to Brewfile...${NOCOLOR}"
  brew bundle dump --force --describe --file="$HOME/.dotfiles/Brewfile"
}

function new_md(){
  # create and open a new markdown file
  if [[ -f "$1.md" ]]; then
    open "$1.md"
  else
    touch "$1.md" && open "$1.md"
  fi
}

# remove duplicates, preserves the ordering of paths, and doesn't add a colon at the end
# PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"

# Init startship prompt, keep at the bottom of this file
eval "$(starship init zsh)"

### Fig post block. Keep at the bottom of this file ###
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"