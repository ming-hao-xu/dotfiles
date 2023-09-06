# Enable Hardcore mode for enforcing alias usage
# Uncomment below line to activate
# export YSU_HARDCORE=1

# List all files/directories with icons and Git status
alias l='exa -aF --icons --group-directories-first'
alias ll='exa -alF --icons --group-directories-first --git'

# Substitute 'cat' with 'bat' for syntax highlighting
alias cat='bat'

# Print system path in a column for improved readability
alias path='<<<${(F)path}'

# Use 'btop' instead of 'top'
alias top='btop'

# Substitute 'vi' or 'vim' with 'neovim'
alias vi='nvim'
alias vim='nvim'

# Show directory usage and free space, reverse sorted
alias du='dust -r'

# Show disk usage and free space
alias df='duf / /Volumes/TimeMachine\ *'

# Clear screen shortcut
alias cl='clear'

# Use latest version of gpg
alias gpg='gpg2'

# Use 'reload' for sourcing ~/.zshrc
# Refer: https://github.com/ohmyzsh/ohmyzsh/wiki/FAQ#how-do-i-reload-the-zshrc-file
alias r='omz reload'

# Allow aliases to be sudo'ed
alias sudo='sudo '
