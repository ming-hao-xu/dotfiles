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
    #
    zsh-syntax-highlighting # Must be the last plugin!
)

# zsh-completions plugin need to be add here rather than in the plugin array
# this provides addtional zsh completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Cache generated completion files and let compinit autoload them on demand.
_cache_completion() {
    local completion_name="$1"
    local command_name="$2"
    shift 2

    local command_path="${commands[$command_name]}"
    [[ -n "$command_path" ]] || return 0

    local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions"
    local cache_file="$cache_dir/$completion_name"
    local tmp_file="$cache_file.$$"

    if [[ ! -r "$cache_file" || "$command_path" -nt "$cache_file" ]]; then
        mkdir -p "$cache_dir" 2>/dev/null || return 0

        if "$@" >| "$tmp_file" 2>/dev/null; then
            mv "$tmp_file" "$cache_file"
        else
            rm -f "$tmp_file"
            return 0
        fi
    fi

    fpath=("$cache_dir" $fpath)
}

_cache_completion _uv uv uv generate-shell-completion zsh
_cache_completion _uvx uvx uvx --generate-shell-completion zsh
unfunction _cache_completion

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

# Set colored man pages without loading the full colored-man-pages plugin.
autoload -Uz colors && colors
# bold & blinking mode
export LESS_TERMCAP_mb="${fg[green]}"
export LESS_TERMCAP_md="${fg[green]}"
export LESS_TERMCAP_me="${reset_color}"
# standout mode
export LESS_TERMCAP_so="${fg_bold[black]}${bg[blue]}"
export LESS_TERMCAP_se="${reset_color}"
# underlining
export LESS_TERMCAP_us="${fg[magenta]}"
export LESS_TERMCAP_ue="${reset_color}"
# then add a progress bar to man pages by hacking less
export GROFF_NO_SGR=1
export MANPAGER='less --squeeze-blank-lines --long-prompt +Gg'

### general config ###
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

### Secrets ###
# This file is not committed to git
[[ -f "$HOME/.dotfiles/config/zsh/secrets.zsh" ]] && source "$HOME/.dotfiles/config/zsh/secrets.zsh"

### Aliases ###
[[ -f "$HOME/.dotfiles/config/zsh/aliases.zsh" ]] && source "$HOME/.dotfiles/config/zsh/aliases.zsh"

### Functions ###
[[ -f "$HOME/.dotfiles/config/zsh/functions.zsh" ]] && source "$HOME/.dotfiles/config/zsh/functions.zsh"

### Key bindings ###
[[ -f "$HOME/.dotfiles/config/zsh/keybindings.zsh" ]] && source "$HOME/.dotfiles/config/zsh/keybindings.zsh"

### freee ###
if [[ "$SHORT_HOST" == 'M4R5H295L2' ]]; then
    # AWS
    export AWS_PROFILE='freee-dev'
    _set_onelogin_mfa_ip_address() {
        local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
        local cache_file="$cache_dir/onelogin_mfa_ip_address"
        local ip
        local -a expired=("$cache_file"(Nmh+1))

        if [[ -r "$cache_file" ]]; then
            export ONELOGIN_MFA_IP_ADDRESS="$(<"$cache_file")"
        fi

        if [[ ! -r "$cache_file" ]]; then
            if ip="$(curl -fsS --max-time 2 https://checkip.amazonaws.com 2>/dev/null)"; then
                ip="${ip//$'\n'/}"
                if [[ -n "$ip" ]]; then
                    export ONELOGIN_MFA_IP_ADDRESS="$ip"
                    mkdir -p "$cache_dir" 2>/dev/null && print -r -- "$ip" >| "$cache_file"
                fi
            fi
        elif (( ${#expired} > 0 )); then
            (
                if ip="$(curl -fsS --max-time 2 https://checkip.amazonaws.com 2>/dev/null)"; then
                    ip="${ip//$'\n'/}"
                    [[ -n "$ip" ]] && mkdir -p "$cache_dir" 2>/dev/null && print -r -- "$ip" >| "$cache_file"
                fi
            ) &!
        fi
    }
    _set_onelogin_mfa_ip_address
    unfunction _set_onelogin_mfa_ip_address
    # GitHub
    export BUNDLE_RUBYGEMS__PKG__GITHUB__COM="$GITHUB_TOKEN_FOR_GITHUB_PACKAGES"
    export GITHUB_USERNAME="ming-hao-xu"
    # asdf
    path=("$HOME/.asdf/shims" $path)
    # mysql-client (for bundle install of mysql2 gem)
    export LDFLAGS="-L/opt/homebrew/opt/mysql-client@8.0/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/mysql-client@8.0/include"
    # VPN
    export NODE_EXTRA_CA_CERTS="$HOMEBREW_PREFIX/etc/openssl@3/certs/palo-root.pem"
    export SSL_CERT_PATH="${HOMEBREW_PREFIX}/etc/openssl@3/certs"

    claude() {
        local claude_bin="${commands[claude]}"
        [[ -n "$claude_bin" ]] || {
            print "claude: command not found" >&2
            return 127
        }

        fdev secrets --enable-encryption exec claude-code-flugel-custom-header -- "$claude_bin" "$@"
    }
fi

# Init starship prompt
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
eval "$(starship init zsh)"
