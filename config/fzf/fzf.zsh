# Keep fzf history/completion; file actions use dedicated widgets below.
export FZF_CTRL_T_COMMAND= FZF_ALT_C_COMMAND=
source <(fzf --zsh)

# Default fzf command and options
export FZF_DEFAULT_COMMAND='fd --type file --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='
    --cycle
    --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8
    --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC
    --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8
    --color=selected-bg:#45475A
    --color=border:#6C7086,label:#CDD6F4'

export FZF_CTRL_R_OPTS="
    --height=25%
    --layout=reverse
    --header='Press CTRL-E to copy command into clipboard 󰅍'
    --no-scrollbar
    --no-info
    --prompt='  '
    --preview='echo {2..} | bat --color=always --language=zsh --style=plain'
    --preview-window='down,40%,wrap'
    --bind='ctrl-e:execute-silent(printf %s {2..} | pbcopy)+abort'"

# Search file contents and open the selected match.
fzf-grep-widget() {
    emulate -L zsh
    local rg_prefix='rg --column --line-number --no-heading --color=always --smart-case --'
    command fzf \
        --disabled --ansi --no-multi --height=100% --layout=reverse \
        --preview='bat --color=always --highlight-line {2} --style=plain -- {1}' \
        --preview-window='right,60%,+{2}+3/3' \
        --info=inline-right --delimiter : \
        --bind="start:reload:$rg_prefix {q} || true" \
        --bind="change:reload:sleep 0.1; $rg_prefix {q} || true" \
        --bind='enter:become(nvim +"call cursor({2},{3})" -- {1})' < /dev/null
    local ret=$?
    zle reset-prompt
    return $ret
}

# Open a file without inserting its name or changing the shell directory.
fzf-edit-widget() {
    emulate -L zsh
    command fzf \
        --no-multi --height=100% --layout=reverse \
        --preview='bat --color=always --line-range :200 --style=plain -- {}' \
        --preview-window='right,60%' \
        --info=inline-right \
        --header='Press CTRL-E to open in VSCode 󰨞 ' \
        --bind='enter:become(nvim -- {})' \
        --bind='ctrl-e:execute(code -- {})+abort' < /dev/tty
    local ret=$?
    zle reset-prompt
    return $ret
}

zle -N fzf-grep-widget
zle -N fzf-edit-widget
bindkey -M emacs '^T' fzf-grep-widget
bindkey -M vicmd '^T' fzf-grep-widget
bindkey -M viins '^T' fzf-grep-widget
bindkey -M emacs '\ec' fzf-edit-widget
bindkey -M vicmd '\ec' fzf-edit-widget
bindkey -M viins '\ec' fzf-edit-widget
