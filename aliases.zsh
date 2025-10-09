# Enable Hardcore mode for enforcing alias usage
# this comes from omz plugin 'you-should-use'
# export YSU_HARDCORE=1

# Substitute `ls` with `eza`
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias eza_base='eza --icons --group-directories-first --ignore-glob=".DS_Store|.localized" --no-quotes --hyperlink'
elif [[ "$OSTYPE" == "linux"* ]]; then
    alias eza_base='eza --icons --group-directories-first --no-quotes --hyperlink'
fi
alias l='eza_base --classify --all'
alias ll='eza_base --classify --all --long --git --time-style=+"%y/%m/%d, %H:%M"'

# Substitute `cat` with `bat`
alias cat=bat

# Print path variables
alias path='print_path_var path'
alias fpath='print_path_var fpath'

# Substitute `top` with `btop`
alias top=btop

# Substitute `vim` `vi` with `nvim`
alias vim=nvim
alias vi=nvim

# Show apparent and block sizes of files, sorted in reverse by size
# Block sizes are actual disk usage; 0 when iCloud files not downloaded
# Use `-L` or `--level=` to adjust tree depth
alias du='eza_base --all --classify --long --header --blocksize --total-size --sort=size --no-user --no-time --no-permissions --reverse --tree --level=1'

# Clear screen
alias cl=clear

# Use `r` for sourcing 'zshrc'
# Do not use `source ~/.zshrc`!
# Refer: https://github.com/ohmyzsh/ohmyzsh/wiki/FAQ#how-do-i-reload-the-zshrc-file
alias r='exec zsh'

# Allow aliases to be sudo'ed
alias sudo='sudo '

# Overwrite `--help` to provide syntax-highlighting usig `bat`
# In some cases, `-h` may not be a shorthand of `--help` (for example with ls), so we do not set `-h` here
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# Show Nvidia GPU usage with a 2s update frequency
if command -v nvidia-smi &>/dev/null; then
    alias gpustat='watch -n 2 nvidia-smi'
fi

# Quickly open `lazygit`
alias lg=lazygit

# Quickly start developing graduation research project
if [[ "$OSTYPE" == darwin* ]]; then
    alias ligencam2='code --folder-uri "vscode-remote://ssh-remote+manjaro/mnt/ssd/code/ligencam2"'
fi
