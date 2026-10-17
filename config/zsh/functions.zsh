# Print path or fpath one entry per line, numbered
print_path_var() {
    if [[ "$1" != path && "$1" != fpath ]]; then
        print -u2 "Usage: print_path_var path|fpath"
        return 1
    fi

    print -rl -- ${(P)1} | bat --style=numbers
}
