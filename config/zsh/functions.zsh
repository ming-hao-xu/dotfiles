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
    # Skips files already processed.
    #
    # Usage:
    #   pdfs_light <file1.pdf> [file2.pdf] ...
    #   pdfs_light *.pdf

    if (( ! $+commands[pdfs] )); then
        print "The 'pdfs' command is required" >&2
        return 1
    fi
    if (( ! $+commands[pdfinfo] )); then
        print "The 'pdfinfo' command is required for checking metadata" >&2
        return 1
    fi

    if (( $# == 0 )); then
        print "Usage: pdfs_light <file1.pdf> [file2.pdf] ..." >&2
        return 1
    fi

    local file
    local -a files_to_process=()

    for file in "$@"; do
        if [[ ! -f "$file" ]]; then
            print "Skipping (not a regular file): $file" >&2
            continue
        fi

        if pdfinfo -- "$file" 2>/dev/null | rg -i -m1 '^(Producer|Creator):.*PDF Squeezer' >/dev/null; then
            print "Skipping (already processed): $file"
        else
            if (( pipestatus[1] == 0 )); then
                 files_to_process+=("$file")
            else
                 print "Skipping (not a valid PDF): $file" >&2
            fi
        fi
    done

    if (( ${#files_to_process[@]} > 0 )); then
        print
        print "Compressing ${#files_to_process[@]} file(s)..."
        pdfs "${files_to_process[@]}" --profile "$XDG_CONFIG_HOME/pdfs_light.pdfscp" --replace
        print "Done."
    else
        print "All valid files have already been processed or skipped."
    fi
}

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

gemini() {
    # Run Gemini CLI with the appropriate git signing key for the current YubiKey
    # Calls `swap_git_gpg_key` before delegating to the real `gemini` command
    #
    # Usage:
    #   gemini [args...]

    local reply

    if ! swap_git_gpg_key >/dev/null 2>&1; then
        print "swap_git_gpg_key failed (no known YubiKey or gpg error?)" >&2
        printf "Continue without switching git signing key? [y/N] "
        read -k 1 reply
        [[ "$reply" == [yY] ]] || return 1
    fi

    command gemini "$@"
}
