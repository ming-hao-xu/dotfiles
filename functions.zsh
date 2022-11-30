function update(){
  echo -e "🤖 $fg_bold[red]Updating brew...$reset_color\n️"
  brew update && brew upgrade && brew upgrade --cask && brew cleanup # cleanup calls autoremove

  echo -e "🤖 $fg_bold[red]Updating App Store Apps...$reset_color\n️"
  mas upgrade

  echo -e "🤖 $fg_bold[red]Updating pip packages...$reset_color\n️"
  pipupgrade --self && pipupgrade --yes 2>/dev/null

  echo -e "🤖 $fg_bold[red]Updating npm and pnpm packages...$reset_color\n️"
  npm update -g
  pnpm update -g

  # echo -e "🤖  $fg[red]Updating omz...$reset_color\n️"
  # upgrade_oh_my_zsh_all # * this function comes from autoupdate plugin, update all plugins and themes

  echo -e "📦 $fg[red]Document brew packages to Brewfile...$reset_color\n️"
  brew bundle dump --force --describe --file="$HOME/.dotfiles/Brewfile"

  echo -e "📦 $fg[red]Document python global packages to requirements.txt...$reset_color\n️"
  pip-chill --no-chill --no-version > $HOME/.dotfiles/config/requirements.txt

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