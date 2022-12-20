# display with hidden files, icons, git status
alias ls='exa -aFh --icons --git'

alias cat='bat'

# print path in a column using bat (NULLCMD)
alias path='<<<${(F)path}'

alias top='btop'

alias vim='lvim'
alias vi='lvim'

# disk usage with reverse sort
alias du='dust -r'
# disk free at root
alias df='duf /'
