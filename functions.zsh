function update(){
  echo -e "🤖 $fg_bold[red]Updating brew...$reset_color"
  brew update && brew upgrade && brew upgrade --cask && brew cleanup # cleanup calls autoremove

  echo -e "🤖 $fg_bold[red]Updating App Store Apps...$reset_color"
  mas upgrade

  # echo -e "🤖 $fg_bold[red]Updating npm and pnpm packages...$reset_color"
  # npm update -g
  # pnpm update -g

  # echo -e "🤖  $fg[red]Updating omz...$reset_color"
  # upgrade_oh_my_zsh_all # * this function comes from autoupdate plugin, update all plugins and themes

  echo -e "📦 $fg[red]Document brew packages to Brewfile...$reset_color"
  brew bundle dump --force --describe --file="$HOME/.dotfiles/Brewfile"

  echo "🍰 ✨ All done!"
}

function note(){
  # create and open a new markdown file
  if [[ -f "$1.md" ]]; then
    open "$1.md"
  else
    touch "$1.md" && open "$1.md"
  fi
}
