### Homebrew on Linux ###
if [[ "$OSTYPE" == linux-gnu* ]]; then
    if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
fi

### omz config ###
export ZSH="$HOME/.oh-my-zsh"

# omz self-upgrade
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 14

# omz plugins and themes upgrade by autoupgrade plugin
ZSH_CUSTOM_AUTOUPDATE_NUM_WORKERS=8

# Disable omz logic for setting LS_COLORS to allow the eza theme to work
DISABLE_LS_COLORS=true
# Set eza config path explicitly; this fixes an issue where eza does not pick up the config on macOS
# https://github.com/eza-community/eza/issues/1224
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"

# History has 2-digit year, minute precision
HIST_STAMPS='%y/%m/%d %H:%M'

# omz plugins to be loaded
plugins=(
    # third-party plugins start here ↓
    autoupdate              # autoupgrade omz plugins and themes
    you-should-use          # So you don't forget aliases
    zsh-autosuggestions     # Fish-like autosuggestions
    # bundled plugins start here ↓
    extract                 # Extract archives easily
    gpg-agent               # Autostart gpg-agent, and fix tty issue
    git                     # Git aliases and functions
    vi-mode                 # Basic vim-like editing
    tmux                    # Tmux aliases
    colored-man-pages       # Use colored man pages
    #
    zsh-syntax-highlighting # Must be the last plugin!
)

# zsh-completions plugin need to be add here rather than in the plugin array
# this provides addtional zsh completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Lazy load some plugins to boost shell startup speed

# Enable tab completion for hidden files
_comp_options+=(globdots)

# asdf
# case "${HOST%%.*}" in
#   D394J047WT|ip-172-29-32-153)
#     path=("$HOME/.asdf/shims" $path)
#     fpath=("$HOME/.asdf/completions" $fpath)
#     ;;
# esac

# Init omz (compinit is called within this)
source "$ZSH/oh-my-zsh.sh"

# Keep history order for zsh-autosuggestion's match_prev_cmd strategy
unsetopt HIST_EXPIRE_DUPS_FIRST
unsetopt HIST_IGNORE_ALL_DUPS
# Limit zsh-autosuggestion triggering for long strings
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
# Better suggestion strategies
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)

# Change cursor style in different vi modes
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true

# Overwrite colors set in colored-man-pages
# bold & blinking mode
less_termcap[mb]="${fg[green]}"
less_termcap[md]="${fg[green]}"
less_termcap[me]="${reset_color}"
# standout mode
less_termcap[so]="${fg_bold[black]}${bg[blue]}"
less_termcap[se]="${reset_color}"
# underlining
less_termcap[us]="${fg[magenta]}"
less_termcap[ue]="${reset_color}"
# then add a progress bar to man pages by hacking less
export MANPAGER='less --squeeze-blank-lines --long-prompt +Gg'

### general config ###
# uv
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# fzf
[[ -f "$HOME/.dotfiles/config/fzf.zsh" ]] && source "$HOME/.dotfiles/config/fzf.zsh"

# Init zoxide and overwrite cd
eval "$(zoxide init zsh --cmd cd)"

# `cdi`: enter a directory interactively using fzf
export _ZO_FZF_OPTS="
    $FZF_DEFAULT_OPTS
    --height=10%
    --layout=reverse"

# Android
if [[ "$OSTYPE" == darwin* ]]; then
    if [[ -d "$HOME/Library/Android/sdk" ]]; then
        export ANDROID_HOME="$HOME/Library/Android/sdk"
        path=("$ANDROID_HOME/platform-tools" $path)
    fi

    if [[ -d "/Applications/Android Studio.app/Contents/jbr/Contents/Home" ]]; then
        export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
    fi
fi

### freee ###
# if [[ "$SHORT_HOST" == 'D394J047WT' ]]; then
#     # AWS
#     export AWS_PROFILE='freee-dev'
#     export ONELOGIN_MFA_IP_ADDRESS="$(curl -fsS --max-time 2 https://checkip.amazonaws.com)"
# fi

### Secrets ###
# This file is not committed to git
[[ -f "$HOME/.dotfiles/config/zsh/secrets.zsh" ]] && source "$HOME/.dotfiles/config/zsh/secrets.zsh"

### Aliases ###
[[ -f "$HOME/.dotfiles/config/zsh/aliases.zsh" ]] && source "$HOME/.dotfiles/config/zsh/aliases.zsh"

### Functions ###
[[ -f "$HOME/.dotfiles/config/zsh/functions.zsh" ]] && source "$HOME/.dotfiles/config/zsh/functions.zsh"

### Key bindings ###
[[ -f "$HOME/.dotfiles/config/zsh/keybindings.zsh" ]] && source "$HOME/.dotfiles/config/zsh/keybindings.zsh"

# Init starship prompt
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
eval "$(starship init zsh)"
