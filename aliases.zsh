alias ls='exa -aFh --icons' # display a table of files with header, showing each file's metadata, and icons

alias cat='bat'

alias rm='echo "Use $fg_bold[red]trash-cli$reset_color instead"; false' # trash-cli is quite different from rm (e.g. no -r), better not to override it

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew' # fix brew doctor's warning ""config" scripts exist outside your system or Homebrew directories"
alias path='<<<${(F)path}' # print path in a column using bat (NULLCMD)

alias diff='echo "Use $fg_bold[red]delta$reset_color instead"; false'

alias top='htop'

alias vim='lvim'
alias vi='lvim'
