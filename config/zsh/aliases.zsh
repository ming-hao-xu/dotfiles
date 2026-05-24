# you-should-use can make aliases mandatory
# export YSU_HARDCORE=1

# Shared eza options for ls-style aliases
alias eza_base='eza --icons --group-directories-first --no-quotes --hyperlink --classify --ignore-glob=".DS_Store|.localized"'
alias l='eza_base --all'
alias ll='eza_base --all --long --time-style=+"%y/%m/%d, %H:%M" --git'

alias cat=bat

# Inspect zsh path arrays
alias path='print_path_var path'
alias fpath='print_path_var fpath'

alias top=btop

alias vim=nvim
alias vi=nvim

# Show apparent sizes of files, sorted in reverse by size
# Use `-L` or `--level=` to adjust tree depth
alias du='eza_base --all --long --total-size --sort=size --no-user --no-time --no-permissions --reverse --tree --level=1'

alias cl=clear

# Reload zsh through exec so OMZ reloads cleanly
# Refer: https://github.com/ohmyzsh/ohmyzsh/wiki/FAQ#how-do-i-reload-the-zshrc-file
alias r='exec zsh'

# Trailing space lets aliases expand after sudo
alias sudo='sudo '

# Keep `-h` untouched because it is not always shorthand for `--help`
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

alias lg=lazygit
