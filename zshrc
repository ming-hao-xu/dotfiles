# Initialize color support
autoload U colors && colors

### oh-my-zsh configuration ###
# Define path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Enable automatic updates for oh-my-zsh
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 30 # Update oh-my-zsh every 30 days

# Set the same frequency for plugin and theme updates using the autoupdate plugin
export UPDATE_ZSH_DAYS=30

# Speed up repository status checks for large repositories by ignoring untracked files
DISABLE_UNTRACKED_FILES_DIRTY="true"

# List plugins to be loaded
plugins=(
    autoupdate     # Auto-update oh-my-zsh, plugins, and themes
    you-should-use # Suggest aliases for entered commands
    git
    zsh-autosuggestions
    extract
    ssh-agent
    gpg-agent
    vi-mode
    zsh-syntax-highlighting # Must be the last plugin
)

# Change cursor style in different vi modes
VI_MODE_SET_CURSOR=true

# zsh-completions config
# Add zsh-completions source to fpath; regular omz plugin addition doesn't work correctly
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# homebrew completions
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Limit autosuggestion triggering for long strings
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Load oh-my-zsh; compinit is called within this
builtin source "$ZSH/oh-my-zsh.sh"

### general config ###
# conda configuration
__conda_setup="$(/opt/homebrew/Caskroom/miniconda/base/bin/conda shell.zsh hook 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
elif [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
    builtin source "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
else
    export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
fi
unset __conda_setup

# nvm configuration
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # Load nvm

# Load nvm version specified in .nvmrc, if present
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

# pnpm configuration
export PNPM_HOME="$HOME/Library/pnpm"
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"

# bat config
export BAT_CONFIG_PATH="$HOME/bat.conf"
export BAT_PAGER="less -RF"
export MANPAGER="sh -c 'col -bx | bat -l man -p'" # Set syntax-highlighting for man pages
export NULLCMD=bat
# Overwrite help command to provide syntax-highlighting for --help
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}

# fzf configuration
[ -f "$HOME/.fzf.zsh" ] && builtin source "$HOME/.fzf.zsh"

# Set default fzf command and options
export FZF_DEFAULT_COMMAND="fd --type file --color=always --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS="
    --exact
    --cycle
    --ansi
    --color=header:#6ef2f1:italic"

# Set fzf configuration for CTRL-T and CTRL-R
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
    --height=100%
    --preview='bat --color=always --line-range :200 {}'
    --preview-window=right:60%
    --bind='enter:become(nvim {} > /dev/tty)+abort'
    --bind='ctrl-e:execute(code {})+abort'
    --header='Press CTRL-E to open in VSCode instead'"
export FZF_CTRL_R_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="
    --height=30%
    --layout=reverse
    --bind='ctrl-e:execute-silent(echo -n {2..} | pbcopy)+abort'
    --header='Press CTRL-E to copy command into clipboard'"

# Switch between Ripgrep launcher mode (CTRL-R) and fzf filtering mode (CTRL-F)
rm -f /tmp/rg-fzf-{r,f} # clear previous query
RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
INITIAL_QUERY="${*:-}"
export FZF_ALT_C_COMMAND="$RG_PREFIX$(printf %q "$INITIAL_QUERY")"
export FZF_ALT_C_OPTS="
    --height=100%
    --preview='bat --color=always {1} --highlight-line {2}'
    --preview-window='right,60%,+{2}+3/3,~3'
    --disabled --query \"$INITIAL_QUERY\"
    --bind='change:reload:sleep 0.1; $RG_PREFIX {q} || true'
    --delimiter :
    --bind='enter:become(nvim {1} > /dev/tty)+abort'
    --header 'CTRL-R (ripgrep mode) | CTRL-F (fzf mode)'
    --bind='ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)'
    --bind='ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)'
    --bind='start:unbind(ctrl-r)'
    --prompt='1. ripgrep> '"

# Initialize zoxide
eval "$(zoxide init zsh --cmd cd)" # Overwrite cd
# cdi to enter a directory interactively using fzf
export _ZO_FZF_OPTS="
    --height=50%
    --layout=reverse
    --preview-window=down:50%
    --preview='exa --all --classify --icons --group-directories-first {2..}'"

# Add completion for ssh, ignoring github.com
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(rg "^Host" ~/.ssh/config | rg -v "[?*]" | rg -v "github.com" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh rsync

### Aliases ###
[[ -f "$HOME/.dotfiles/aliases.zsh" ]] && builtin source "$HOME/.dotfiles/aliases.zsh"

### Functions ###
[[ -f "$HOME/.dotfiles/functions.zsh" ]] && builtin source "$HOME/.dotfiles/functions.zsh"

# Init iterm2 shell integration
[[ -f "$HOME/.iterm2_shell_integration.zsh" ]] && builtin source "$HOME/.iterm2_shell_integration.zsh"

# Initialize starship prompt
eval "$(starship init zsh)"

# Remove duplicate entries from PATH and sort
export PATH=$(echo "$PATH" | tr ':' '\n' | sort -u | tr '\n' ':')
