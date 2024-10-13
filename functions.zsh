swap_git_gpg_key() {
    # Swap git signing key based on YubiKey serial number
    # Currently, there is no built-in way to do this

    # Usage:
    # swap_git_gpg_key

    local serial
    serial=$(gpg --card-status | rg --fixed-strings --max-count=1 "Serial number"  | cut -d ":" -f 2 | tr -d ' ')

    if [ "$serial" = "16812796" ]; then # at-home key
        git config --global user.signingKey A59F54B8ED0C57D7
    elif [ "$serial" = "18686886" ]; then # carry-on key
        git config --global user.signingKey CE3E58885D9C10AF
    else
        print "No known YubiKey inserted"
        return 1
    fi
}

pdfs_light() {
    # Reduce pdf size using PDF Squeezer with a light compression profile

    # Usage:
    # pdfs_light /path/to/file.pdf

    if ! command -v pdfs >/dev/null 2>&1; then
        print "The 'pdfs' command is required"
        return 1
    fi

    if [[ -z "$1" ]]; then
        print "No PDF file provided"
        return 1
    elif [[ ! -f "$1" ]]; then
        print "The provided file does not exist"
        return 1
    fi

    pdfs "$1" --profile "$HOME/.config/pdfs_light.pdfscp" --replace
}

print_path_var() {
    # Print the contents of a given path variable in a column

    # Usage:
    # print_path_var PATH
    # print_path_var MANPATH

    if [[ -n $1 ]]; then
        print -rl ${(P)1} | bat --language=zsh --style=numbers
    else
        print "No variable provided"
        return 1
    fi
}
