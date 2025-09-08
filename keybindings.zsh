# ctrl-l to accept zsh-autosuggestions
bindkey '^l' autosuggest-accept

# fzf option-c / alt-c (view file)
if [[ "$OSTYPE" == "darwin"* ]]; then
    # in iterm2, this is a workaround to use meta-c without esc-c or change key behaviors
    bindkey "ç" fzf-cd-widget
fi
