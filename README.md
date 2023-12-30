# Enviroment Setup

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)
[![Issues](https://img.shields.io/github/issues/xu-minghao317/dotfiles-macOS)](https://github.com/xu-minghao317/dotfiles-macOS/issues)

## Workflow

1. Update macOS

    ```shell
    softwareupdate --install -all
    ```

1. Install `Command Line Tools`.

    ```shell
    xcode-select --install
    ```

1. Bootstrap dotfiles.

    ```shell
    git clone https://github.com/xu-minghao317/dotfiles.git ~/.dotfiles --recursive --depth=1
    cd ~/.dotfiles && ./install
    ```

1. Install [Fira Code Nerd Font](https://www.nerdfonts.com/font-downloads).

1. Migrate keys securely.

## Optional Steps

1. Delete all `.DS_Store` files and set a default Finder view option:

    ```shell
    killall Finder && find . -name ".DS_Store" -type f -delete
    ```

1. Enable Touch ID for `sudo`:

    macOS Sonoma adds support to permanently enable Touch ID for `sudo`. macOS before Sonoma can edit `/etc/pam.d/sudo` instead.

    ```shell
    sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
    sudo vim /etc/pam.d/sudo_local
    ```
    Uncomment the only line there:
    ```shell
    - #auth       sufficient     pam_tid.so
    +  auth       sufficient     pam_tid.so
    ```
