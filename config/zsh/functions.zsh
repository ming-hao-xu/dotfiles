print_path_var() {
    # Print the contents of 'path' or 'fpath' (lowercase only) in a column
    #
    # Usage:
    #   print_path_var path
    #   print_path_var fpath

    if [[ "$1" != path && "$1" != fpath ]]; then
        print "Usage: print_path_var path|fpath"
        return 1
    fi

    print -rl -- ${(P)1} | bat --language=zsh --style=numbers
}
