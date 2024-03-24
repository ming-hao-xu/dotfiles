### omz config ###
export ZSH="$HOME/.oh-my-zsh"

# Self-upgrade
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 14

# autoupgrade plugin upgrades omz plugins and themes
export UPDATE_ZSH_DAYS=14
export ZSH_CUSTOM_AUTOUPDATE_NUM_WORKERS=8

# Speed up status checks for large repos by ignoring untracked files
DISABLE_UNTRACKED_FILES_DIRTY=true

# Disable omz logic to set LS_COLORS since vivid is used
DISABLE_LS_COLORS=true

# omz plugins to be loaded
plugins=(
    # custom plugins from here...
    autoupdate     # autoupgrade omz plugins and themes
    you-should-use # So you don't forget aliases
    conda-zsh-completion
    zsh-autosuggestions # Fish-like autosuggestions
    # plugins from omz from here...
    extract   # Extract archives easily
    ssh-agent # Autostart ssh-agent
    gpg-agent # Autostart gpg-agent, and fix tty issue
    git       # Git aliases
    vi-mode
    tmux
    colored-man-pages
    nvm                     # Add autocompletions, and source nvm
    zsh-syntax-highlighting # Must be the last plugin!
)

# zsh-completions plugin need to be add here rather than in the plugin array
# this provides addtional zsh completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

if [[ "$OS_TYPE" == "Darwin" ]]; then
    # Add Homebrew formula completions, remember to call `brew completions link`
    fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi

# Limit zsh-autosuggestion triggering for long strings
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
# Use completion engine as a fallback
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Slient ssh-agent
zstyle :omz:plugins:ssh-agent quiet yes

# Lazy load some plugins to boost shell startup speed
zstyle ':omz:plugins:extract' lazy yes
zstyle ':omz:plugins:tmux' lazy yes

if [[ "$OS_TYPE" == "Darwin" ]]; then
    # This need nvm plugin to properly work
    zstyle ':omz:plugins:nvm' lazy yes
fi

# Init omz (compinit is called within this)
source "$ZSH/oh-my-zsh.sh"

# Change cursor style in different vi modes
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true

# Generate themed LS_COLORS
export LS_COLORS="$(vivid generate catppuccin-mocha)"

# Overwrite colors set in colored-man-pages
# bold & blinking mode
less_termcap[mb]="${fg_bold[green]}"
less_termcap[md]="${fg_bold[green]}"
less_termcap[me]="${reset_color}"
# standout mode
less_termcap[so]="${fg_bold[black]}${bg[blue]}"
less_termcap[se]="${reset_color}"
# underlining
less_termcap[us]="${fg_bold[magenta]}"
less_termcap[ue]="${reset_color}"
# then add a progress bar by hacking less
export MANPAGER='less --squeeze-blank-lines --long-prompt +Gg'

### general config ###
# miniconda
if [[ "$OS_TYPE" == "Darwin" ]]; then
    __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
            . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
        else
            export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
        fi
    fi
    unset __conda_setup

elif [[ "$OS_TYPE" == "Linux" ]]; then
    __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
            . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
        else
            export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
        fi
    fi
    unset __conda_setup
fi

# bat
export BAT_CONFIG_PATH="$HOME/.config/bat/bat.conf"
export BAT_PAGER='less --RAW-CONTROL-CHARS --quit-if-one-screen'

# fzf
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# Default fzf command and options
export FZF_DEFAULT_COMMAND='fd --type file --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='
    --cycle
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8'

# ctrl-r (command history)
export FZF_CTRL_R_COMMAND="$FZF_DEFAULT_COMMAND"

if [[ "$OS_TYPE" == "Darwin" ]]; then
    clipboard_cmd="pbcopy"
else
    clipboard_cmd="xclip -selection clipboard"
fi

export FZF_CTRL_R_OPTS="
    --height=25%
    --layout=reverse
    --header='Press CTRL-E to copy command into clipboard 󰅍'
    --no-scrollbar
    --no-info
    --prompt='  '
    --preview='echo {2..} | bat --color=always --language=zsh --style=plain'
    --preview-window='down,40%,wrap'
    --bind='ctrl-e:execute-silent(echo -n {2..} | $clipboard_cmd)+abort'"

# ctrl-t (ripgrep)
RG_PREFIX='rg --column --line-number --no-heading --color=always --smart-case'
export FZF_CTRL_T_OPTS="
    --disabled
    --ansi
    --height=100%
    --preview='bat --color=always {1} --highlight-line {2} --style=plain'
    --preview-window='right,60%,+{2}+3/3'
    --info=inline-right
    --delimiter :
    --bind='start:reload:$RG_PREFIX {q}'
    --bind='change:reload:sleep 0.1; $RG_PREFIX {q} || true'
    --bind='enter:become(nvim {1} +\"call cursor({2},{3})\" > /dev/tty)'"

# option-c / alt-c (view file)
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_OPTS="
    --height=100%
    --preview='bat --color=always --line-range :200 {} --style=plain'
    --preview-window='right,60%'
    --info=inline-right
    --header='Press CTRL-E to open in VSCode 󰨞 '
    --bind='enter:become(nvim {} > /dev/tty)'
    --bind='ctrl-e:execute(code {})+abort'"

# Init zoxide and overwrite cd
eval "$(zoxide init zsh --cmd cd)"

# `cdi`: enter a directory interactively using fzf
export _ZO_FZF_OPTS="
    $FZF_DEFAULT_OPTS
    --height=10%
    --layout=reverse"

### Aliases ###
[[ -f "$HOME/.dotfiles/aliases.zsh" ]] && source "$HOME/.dotfiles/aliases.zsh"

### Functions ###
[[ -f "$HOME/.dotfiles/functions.zsh" ]] && source "$HOME/.dotfiles/functions.zsh"

### Key bindings ###
[[ -f "$HOME/.dotfiles/keybindings.zsh" ]] && source "$HOME/.dotfiles/keybindings.zsh"

# Init iterm2 shell integration
[[ -f "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh"

# Build $PATH
export PATH

# Init starship prompt
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"
