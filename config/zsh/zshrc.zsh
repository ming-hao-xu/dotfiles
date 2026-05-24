### OMZ config ###
export ZSH="$HOME/.oh-my-zsh"

# Auto-update OMZ
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 14

# Parallelize custom plugin and theme updates
ZSH_CUSTOM_AUTOUPDATE_NUM_WORKERS=8

# Prevent OMZ from overriding eza theme colors
DISABLE_LS_COLORS=true
# Work around eza's macOS config lookup with the XDG config directory
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"

# Show timestamps in history output
HIST_STAMPS='%y/%m/%d %H:%M'

plugins=(
    # Third-party plugins
    autoupdate              # Auto-update custom OMZ plugins and themes
    you-should-use          # Remind when an alias exists
    zsh-autosuggestions     # Fish-like autosuggestions

    # Bundled plugins
    extract                 # Extract many archive formats
    git                     # Git aliases and functions
    vi-mode                 # Vi keybindings for the shell
    tmux                    # Tmux aliases
    colored-man-pages       # Use colored man pages

    # Third-party plugins loaded last
    zsh-syntax-highlighting # Must be the last plugin!
)

# zsh-completions must be in fpath before OMZ runs compinit
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Enable tab completion for hidden files
_comp_options+=(globdots)

# OMZ runs compinit during initialization
source "$ZSH/oh-my-zsh.sh"

# Keep history order for zsh-autosuggestion's match_prev_cmd strategy
unsetopt HIST_EXPIRE_DUPS_FIRST
unsetopt HIST_IGNORE_ALL_DUPS
# Limit zsh-autosuggestion triggering for long strings
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
# Prefer previous-command-aware suggestions first
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)

# Change cursor style in different vi modes
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true

# Override colors set by colored-man-pages
# Bold and blinking mode
less_termcap[mb]="${fg[green]}"
less_termcap[md]="${fg[green]}"
less_termcap[me]="${reset_color}"
# Standout mode
less_termcap[so]="${fg_bold[black]}${bg[blue]}"
less_termcap[se]="${reset_color}"
# Underlining
less_termcap[us]="${fg[magenta]}"
less_termcap[ue]="${reset_color}"
# Show less status information in man pages
export MANPAGER='less --squeeze-blank-lines --long-prompt +Gg'

### general config ###
# fzf
[[ -f "$HOME/.dotfiles/config/fzf.zsh" ]] && source "$HOME/.dotfiles/config/fzf.zsh"

# Initialize zoxide as cd
eval "$(zoxide init zsh --cmd cd)"

# `cdi`: enter a directory interactively using fzf
export _ZO_FZF_OPTS="
    $FZF_DEFAULT_OPTS
    --height=10%
    --layout=reverse"

### Secrets ###
# Load ignored local secrets
[[ -f "$HOME/.dotfiles/config/zsh/secrets.zsh" ]] && source "$HOME/.dotfiles/config/zsh/secrets.zsh"

### Aliases ###
[[ -f "$HOME/.dotfiles/config/zsh/aliases.zsh" ]] && source "$HOME/.dotfiles/config/zsh/aliases.zsh"

### Functions ###
[[ -f "$HOME/.dotfiles/config/zsh/functions.zsh" ]] && source "$HOME/.dotfiles/config/zsh/functions.zsh"

### Key bindings ###
[[ -f "$HOME/.dotfiles/config/zsh/keybindings.zsh" ]] && source "$HOME/.dotfiles/config/zsh/keybindings.zsh"

### Local config ###
# Load ignored machine-local config
[[ -f "$HOME/.dotfiles/config/zsh/local.zsh" ]] && source "$HOME/.dotfiles/config/zsh/local.zsh"

# Starship prompt
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
eval "$(starship init zsh)"
