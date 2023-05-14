update() {
    # Update everything, and log brew packages to Brewfile

    echo -e "$fg_bold[red]Updating brew...$reset_color"
    # cleanup calls autoremove
    brew update && brew upgrade && brew cleanup

    # Disabling App Store updates temporarily due to a bug with 'flow' app
    # echo -e "\n${fg_bold_red}Updating App Store Apps...${reset_color}"
    # mas upgrade

    echo -e "\n$fg_bold[red]Updating pnpm global packages...$reset_color"
    pnpm update -g

    echo "\n"
    # Update oh-my-zsh, its plugins and themes
    upgrade_oh_my_zsh_all

    echo -e "\n$fg[red]Logging brew packages to Brewfile...$reset_color"
    brew bundle dump -f --describe --file="$HOME/.dotfiles/Brewfile"

    echo "\nAll done!"
    $HOME/.iterm2/it2attention fireworks
}

mdnote() {
    # Create a markdown file if it doesn't exist, and open with Typora

    local filename="$1.md"
    if [[ ! -f $filename ]]; then
        touch $filename
    fi
    open -a Typora.app $filename
}

swap_git_gpg_key() {
    # Swap git signing key based on YubiKey serial number
    # Currently, there is no built-in way to do this in git

    serial=$(gpg --card-status | grep "^Serial number" | cut -d ":" -f 2 | tr -d ' ')
    if [ "$serial" = "16812796" ]; then
        git config --global user.signingKey 7330C1A308E26864
    elif [ "$serial" = "18686886" ]; then
        git config --global user.signingKey CE3E58885D9C10AF
    else
        echo "No known YubiKey inserted"
    fi
}

pdfs_light() {
    # Reduce pdf size using PDF Squeezer with a light compression profile

    pdfs "$1" --profile "$HOME/.config/pdfs_light.pdfscp" --verbose --replace
}
