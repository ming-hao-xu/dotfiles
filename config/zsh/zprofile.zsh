### Homebrew ###
if [[ "$OSTYPE" == darwin* && -d /opt/homebrew ]]; then
    export HOMEBREW_PREFIX="/opt/homebrew"
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
    export HOMEBREW_REPOSITORY="/opt/homebrew"
    path=("$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $path)
    fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
    [[ -n "${MANPATH-}" ]] && export MANPATH=":${MANPATH#:}"
    export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}"
fi

# Include $HOME/.local/bin if it exists
if [[ -d "$HOME/.local/bin" ]]; then
    path=("$HOME/.local/bin" $path)
fi

# Set neovim as default editor
export EDITOR='nvim'
export VISUAL="$EDITOR"
