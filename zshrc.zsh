### omz config ###
export ZSH="$HOME/.oh-my-zsh"

# omz self-upgrade
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 14

# omz plugins and themes upgrade by autoupgrade plugin
export UPDATE_ZSH_DAYS=14
export ZSH_CUSTOM_AUTOUPDATE_NUM_WORKERS=8

# Speed up status checks for large repos by ignoring untracked files
DISABLE_UNTRACKED_FILES_DIRTY=true

# Disable omz logic to set LS_COLORS since vivid is being used
DISABLE_LS_COLORS=true

# omz plugins to be loaded
plugins=(
    # third-party plugins start here...
    autoupdate           # autoupgrade omz plugins and themes
    you-should-use       # So you don't forget aliases
    conda-zsh-completion # conda completions
    zsh-autosuggestions  # Fish-like autosuggestions
    #
    # bundled plugins start here...
    extract           # Extract archives easily
    ssh-agent         # Autostart ssh-agent
    gpg-agent         # Autostart gpg-agent, and fix tty issue
    git               # Git aliases and functions
    vi-mode           # Basic vim-like editing
    tmux              # Tmux aliases
    colored-man-pages # This and vivid provide catppuccin-mocha flavor man pages
    nvm               # nvm completions, and source nvm
    #
    zsh-syntax-highlighting # Must be the last plugin!
)

# zsh-completions plugin need to be add here rather than in the plugin array
# this provides addtional zsh completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Add Homebrew formula completions, remember to call `brew completions link`
if [[ "$OS_TYPE" == "Darwin" ]]; then
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
# You may want to turn this off if using any npm global packages
if [[ "$OS_TYPE" == "Darwin" ]]; then
    zstyle ':omz:plugins:nvm' lazy yes
    # autoload (load node version described in .nvmrc)
    # will start working only after nvm has been lazy-loaded
    zstyle ':omz:plugins:nvm' autoload yes
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
# miniconda
if [[ "$OS_TYPE" == "Darwin" ]]; then
    __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
            source "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
        else
            path=("/opt/homebrew/Caskroom/miniconda/base/bin" $path)
        fi
    fi
    unset __conda_setup
fi

# bat
export BAT_CONFIG_PATH="$HOME/.config/bat/bat.conf"
export BAT_PAGER='less --RAW-CONTROL-CHARS --quit-if-one-screen'

# fzf
[[ -f "$HOME/.dotfiles/fzf.zsh" ]] && source "$HOME/.dotfiles/fzf.zsh"

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
