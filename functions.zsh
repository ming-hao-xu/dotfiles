# Update all packages
update() {
  echo -e "$fg_bold[red]Updating brew...$reset_color"
  brew update && brew upgrade && brew cleanup # cleanup calls autoremove

  echo -e "\n$fg_bold[red]Updating App Store Apps...$reset_color"
  mas upgrade

  # echo -e "\n$fg_bold[red]Updating npm & pnpm packages...$reset_color"
  # npm update -g
  # pnpm update -g

  echo -e "\n$fg[red]Updating omz...$reset_color"
  upgrade_oh_my_zsh_all # update all plugins and themes using autoupdate plugin

  echo -e "\n$fg[red]Logging brew packages to Brewfile...$reset_color"
  brew bundle dump --force --describe --file="$HOME/.dotfiles/Brewfile"

  echo "\n✨ All done!"
}

# Create and open a markdown file
note() {
  if [[ -f "$1.md" ]]; then
    open "$1.md"
  else
    touch "$1.md" && open "$1.md"
  fi
}
