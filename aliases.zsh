# Enable Hardcore mode to enforce the use of aliases
# export YSU_HARDCORE=1

# Display a list of all files and directories, including hidden ones, with icons and Git status
alias l='exa --all --classify --git --icons --group-directories-first'
alias ll='exa --long --all --classify --git --icons --group-directories-first'

# Use bat instead of cat for syntax highlighting and paging
alias cat='bat'

# Print the system path in a column for better readability
alias path='<<<${(F)path}'

# Use btop instead of top
alias top='btop'

# Use lunar vim instead of vim or vi
alias vim='lvim'
alias vi='lvim'

# Show directory usage and free space, sorted in reverse order
alias du='dust --reverse'

# Show disk usage and free space at the root directory
alias df='duf /'

# Too lazy to type 'clear'
alias c='clear'
