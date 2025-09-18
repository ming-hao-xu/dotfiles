### Homebrew on Linux ###
if [[ "$OSTYPE" == linux-gnu* ]]; then
    if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
        # Init
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        # config
        export HOMEBREW_NO_ANALYTICS=true
        export HOMEBREW_NO_ENV_HINTS=true
    fi
fi

### omz config ###
export ZSH="$HOME/.oh-my-zsh"

# omz self-upgrade
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 14

# omz plugins and themes upgrade by autoupgrade plugin
ZSH_CUSTOM_AUTOUPDATE_NUM_WORKERS=8

# Speed up status checks for large repos by ignoring untracked files
DISABLE_UNTRACKED_FILES_DIRTY=true

# Disable omz logic to set LS_COLORS since vivid is being used
DISABLE_LS_COLORS=true

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
    ssh-agent               # Autostart ssh-agent
    gpg-agent               # Autostart gpg-agent, and fix tty issue
    git                     # Git aliases and functions
    vi-mode                 # Basic vim-like editing
    tmux                    # Tmux aliases
    colored-man-pages       # This and vivid provide catppuccin-mocha flavor man pages
    nvm                     # nvm completions, and source nvm
    #
    zsh-syntax-highlighting # Must be the last plugin!
)

# zsh-completions plugin need to be add here rather than in the plugin array
# this provides addtional zsh completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Add Homebrew formula completions, remember to call `brew completions link`
if [[ "$OSTYPE" == darwin* ]]; then
    fpath=("$(brew --prefix)/share/zsh/site-functions" "${fpath[@]}")
fi

# Slient ssh-agent
zstyle :omz:plugins:ssh-agent quiet yes

# Lazy load some plugins to boost shell startup speed
zstyle ':omz:plugins:extract' lazy yes
# autoload (load node version described in .nvmrc)
zstyle ':omz:plugins:nvm' autoload yes

# Enable tab completion for hidden files
_comp_options+=(globdots)

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

# Generate themed LS_COLORS
export LS_COLORS="$(vivid generate catppuccin-mocha)"

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

# bat
export BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat/bat.conf"

# fzf
[[ -f "$HOME/.dotfiles/config/fzf.zsh" ]] && source "$HOME/.dotfiles/config/fzf.zsh"

# Init zoxide and overwrite cd
eval "$(zoxide init zsh --cmd cd)"

# `cdi`: enter a directory interactively using fzf
export _ZO_FZF_OPTS="
    $FZF_DEFAULT_OPTS
    --height=10%
    --layout=reverse"

### freee ###
# MacBookPro M4 max
if [[ "$SHORT_HOST" == 'D394J047WT' ]]; then
    # AWS
    export AWS_REGION='ap-northeast-1'
    export AWS_PROFILE='freee'
    export ONELOGIN_MFA_IP_ADDRESS="$(curl -SsL http://checkip.amazonaws.com/)"
    # asdf
    path=("$HOME/.asdf/shims" $path)
    # Android
    export JAVA_HOME='/Applications/Android Studio.app/Contents/jbr/Contents/Home'
    path=("$HOME/Library/Android/sdk/platform-tools" $path)
fi

### Secrets ###
# This file is not committed to git
[[ -f "$HOME/.dotfiles/secrets.zsh" ]] && source "$HOME/.dotfiles/secrets.zsh"

### Aliases ###
[[ -f "$HOME/.dotfiles/aliases.zsh" ]] && source "$HOME/.dotfiles/aliases.zsh"

### Functions ###
[[ -f "$HOME/.dotfiles/functions.zsh" ]] && source "$HOME/.dotfiles/functions.zsh"

### Key bindings ###
[[ -f "$HOME/.dotfiles/keybindings.zsh" ]] && source "$HOME/.dotfiles/keybindings.zsh"

# Init iterm2 shell integration
if [[ "$OSTYPE" == darwin* ]]; then
    [[ -f "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh"
fi

# Init starship prompt
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
eval "$(starship init zsh)"
