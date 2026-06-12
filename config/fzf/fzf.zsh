# Set up fzf key bindings and fuzzy completion
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

clipboard_cmd="pbcopy"

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
