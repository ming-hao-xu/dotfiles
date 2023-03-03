update() {
  # Update brew, App Store apps, oh-my-zsh plugins and themes, and log brew packages to Brewfile

  echo -e "$fg_bold[red]Updating brew...$reset_color"
  brew update && brew upgrade && brew cleanup # cleanup calls autoremove

  echo -e "\n$fg_bold[red]Updating App Store Apps...$reset_color"
  mas upgrade

  upgrade_oh_my_zsh_all # update all plugins and themes using autoupdate plugin

  echo -e "\n$fg[red]Logging brew packages to Brewfile...$reset_color"
  brew bundle dump --force --describe --file="$HOME/.dotfiles/Brewfile"

  echo "\n🥳 All done!"
}

note() {
  # Create and open a markdown file

  if [[ -f "$1.md" ]]; then
    open "$1.md"
  else
    touch "$1.md" && open "$1.md"
  fi
}

add_mp4_extension() {
  # Add .mp4 extension to all files in a directory

  DEFAULT_DIR="$HOME/Downloads"
  DIRECTORY="${1:-$DEFAULT_DIR}"

  echo "The following files will be renamed in $DIRECTORY:"
  fd --type f '^[^.]+$' "$DIRECTORY" | while read -r file; do
    echo "$fg[red]${file} -> ${file}.mp4$reset_color"
  done

  echo -n "Do you want to continue? [y/N] "
  read REPLY
  case "${REPLY:l}" in [y] | [yes])
    fd --type f '^[^.]+$' "$DIRECTORY" -x mv {} {}.mp4
    echo "Renaming complete."
    ;;
  *)

    echo "Renaming cancelled."
    ;;
  esac
}
