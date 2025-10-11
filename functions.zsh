swap_git_gpg_key() {
    # Swap git signing key based on YubiKey serial number
    # Currently, there is no built-in way to do this
    #
    # Usage:
    #   swap_git_gpg_key

    local serial
    serial=$(gpg --card-status --with-colons | awk -F: '/^serial:/{print $2; exit}')

    case "$serial" in
        "16812796") # at-home key
            git config --global user.signingKey A59F54B8ED0C57D7
            ;;
        "18686886") # carry-on key
            git config --global user.signingKey 09D60BDAEA3B8634
            ;;
        *)
            print "No known YubiKey inserted"
            return 1
            ;;
    esac
}

pdfs_light() {
    # Reduce pdf size using PDF Squeezer with a light compression profile
    #
    # Usage:
    #   pdfs_light <file1.pdf> [file2.pdf] ...

    if (( ! $+commands[pdfs] )); then
        print "The 'pdfs' command is required" >&2
        return 1
    fi

    if (( $# == 0 )); then
        print "Usage: pdfs_light <file1.pdf> [file2.pdf] ..." >&2
        return 1
    fi

    pdfs "$@" --profile "$XDG_CONFIG_HOME/pdfs_light.pdfscp" --replace
}

print_path_var() {
    # Print the contents of 'path' or 'fpath' (lowercase only) in a column
    #
    # Usage:
    #   print_path_var path
    #   print_path_var fpath

    if [[ -n $1 ]]; then
        print -rl -- ${(P)1} | bat --language=zsh --style=numbers
    else
        print "No variable provided"
        return 1
    fi
}
