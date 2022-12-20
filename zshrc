### Fig pre block. Keep at the top of this file ###
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

autoload U colors && colors

### oh-my-zsh config ###
# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="" # now using starship 🚀

# Update oh-my-zsh
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 30 # update omz every 30 days
export UPDATE_ZSH_DAYS=30         # update plugins and themes using autoupdate plugin every 30 days

# Disable marking untracked files under VCS as dirty
# This makes repository status check for large repositories much, much faster
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins to load
plugins=(
  autoupdate
  you-should-use
  git
  zsh-autosuggestions
  sudo # press <ESC> twice to run the last command with sudo
  extract
  gpg-agent
  command-not-found
  zsh-syntax-highlighting
)

# zsh-completions config
# adding it as a regular omz plugin will not work properly
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080"

# compinit is called here
builtin source "$ZSH/oh-my-zsh.sh"

### normal config ###
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/kevin/miniconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/Users/kevin/miniconda3/etc/profile.d/conda.sh" ]; then
    . "/Users/kevin/miniconda3/etc/profile.d/conda.sh"
  else
    export PATH="/Users/kevin/miniconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<

# nvm config
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
# call nvm use automatically whenever entering a directory that contains an .nvmrc file with a string telling nvm which node to use
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# pnpm config
export PNPM_HOME="$HOME/Library/pnpm"
[[ ":$PATH:" == *":$PNPM_HOME:"* ]] || export PATH="$PNPM_HOME:$PATH" # corepack
# command -v pnpm >/dev/null || export PATH="$PNPM_HOME:$PATH" # standalone

# bat config
export BAT_CONFIG_PATH="$HOME/bat.conf"
export MANPAGER="sh -c 'col -bx | bat -l man -p'" # set syntax-highlighting for man
alias bathelp='bat --plain --language=help'       # set syntax-highlighting for help
help() {
  "$@" --help 2>&1 | bathelp
}

# fzf config
[ -f "$HOME/.fzf.zsh" ] && builtin source "$HOME/.fzf.zsh"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--exact --cycle'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--no-height --preview-window wrap --preview 'bat --color=always --style="plain" --line-range :100 {}'"

export FZF_CTRL_R_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="--height 50% --reverse"

export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS="--height 100% --preview 'tree -C {} | head -50'"

# Homebrew config
export HOMEBREW_CASK_OPTS="--no-quarantine" # disable macOS's Gatekeeper
export HOMEBREW_AUTOREMOVE="true"
export HOMEBREW_BAT="true"
export HOMEBREW_NO_ENV_HINTS="true"
export HOMEBREW_NO_ANALYTICS="true"

# zoxide initalization
eval "$(zoxide init zsh --cmd cd)" # override cd

### Aliases ###
[[ -f "$HOME/.dotfiles/aliases.zsh" ]] && builtin source "$HOME/.dotfiles/aliases.zsh"

### Functions ###
[[ -f "$HOME/.dotfiles/functions.zsh" ]] && builtin source "$HOME/.dotfiles/functions.zsh"

# remove duplicates, preserves the ordering of paths, and doesn't add a colon at the end
# PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"

# Init startship prompt, keep at the bottom of this file
eval "$(starship init zsh)"

### Fig post block. Keep at the bottom of this file ###
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
