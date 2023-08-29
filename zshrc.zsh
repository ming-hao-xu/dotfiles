# Init color support
autoload U colors && colors

### oh-my-zsh config ###
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 30 # Update oh-my-zsh every 30 days

# Enable auto updates for plugins and themes using the autoupdate plugin
export UPDATE_ZSH_DAYS=30

# Speed up status checks for large repos by ignoring untracked files
DISABLE_UNTRACKED_FILES_DIRTY="true"

# List plugins to be loaded
plugins=(
    autoupdate
    you-should-use # Suggest aliases for entered commands
    git
    zsh-autosuggestions
    extract
    ssh-agent
    gpg-agent
    vi-mode
    tmux
    zsh-syntax-highlighting # Must be the last plugin
)

# Add zsh-completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Add Homebrew completions
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Limit zsh-autosuggestion triggering for long strings
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Load oh-my-zsh; compinit is called within this
source "$ZSH/oh-my-zsh.sh"

# Add ssh completions manually, ignoring github.com
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(rg "^Host" ~/.ssh/config | rg -v "[?*]" | rg -v "github.com" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh rsync

# Change cursor style in different vi modes (looks like this need to be after compinit)
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true
VI_MODE_CURSOR_VISUAL=5 # blinking line
VI_MODE_CURSOR_INSERT=5 # blinking line

### general config ###
# conda
__conda_setup="$(/opt/homebrew/Caskroom/miniconda/base/bin/conda shell.zsh hook 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
elif [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
    source "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
else
    export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
fi
unset __conda_setup

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Load nvm version specified in .nvmrc automatically, if present
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

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"

# bat
export BAT_CONFIG_PATH="$HOME/bat.conf"
export BAT_PAGER="less -RF"
export MANPAGER="sh -c 'col -bx | bat -l man -p'" # Set syntax-highlighting for man pages
export NULLCMD=bat

# Overwrite help command to provide syntax-highlighting for --help
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}

# fzf
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# Config default fzf command and options
export FZF_DEFAULT_COMMAND="fd --type file --color=always --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS="
    --cycle
    --color=dark
    --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
    --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"

# Config fzf for CTRL-R (Command history)
export FZF_CTRL_R_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="
    --ansi
    --height=30%
    --layout=reverse
    --bind='ctrl-e:execute-silent(echo -n {2..} | pbcopy)+abort'
    --header='Press CTRL-E to copy command into clipboard'"

# Config fzf for CTRL-T (Ripgrep)
RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
INITIAL_QUERY="${*:-}"
export FZF_CTRL_T_OPTS="
    --ansi
    --height=100%
    --preview='bat --color=always {1} --highlight-line {2} --style=auto'
    --preview-window='right,65%,+{2}+3/3,~3'
    --disabled --query \"$INITIAL_QUERY\"
    --bind='start:reload:$RG_PREFIX {q}'
    --bind='change:reload:sleep 0.1; $RG_PREFIX {q} || true'
    --delimiter :
    --bind='enter:become(nvim +{2} {1} > /dev/tty)+abort'"

# Config fzf for ALT-C (View file)
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_OPTS="
    --ansi
    --height=100%
    --preview='bat --color=always --line-range :200 {} --style=changes'
    --preview-window=right:65%
    --bind='enter:become(nvim {} > /dev/tty)+abort'
    --bind='ctrl-e:execute(code {})+abort'
    --header='Press CTRL-E to open in VSCode instead'"

# Init zoxide
eval "$(zoxide init zsh --cmd cd)" # Overwrite cd
# cdi to enter a directory interactively using fzf
export _ZO_FZF_OPTS="
    --height=50%
    --layout=reverse
    --preview-window=down:50%
    --preview='exa --all --classify --icons --group-directories-first {2..}'"

### Aliases ###
[[ -f "$HOME/.dotfiles/aliases.zsh" ]] && source "$HOME/.dotfiles/aliases.zsh"

### Functions ###
[[ -f "$HOME/.dotfiles/functions.zsh" ]] && source "$HOME/.dotfiles/functions.zsh"

# Init iterm2 shell integration
[[ -f "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh"

# Remove duplicate entries from PATH and sort
export PATH=$(echo "$PATH" | tr ':' '\n' | sort -u | tr '\n' ':')

# Init starship prompt
eval "$(starship init zsh)"
