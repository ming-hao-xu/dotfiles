# Dotfiles Repository

![GitHub License](https://img.shields.io/github/license/xu-minghao317/dotfiles)
[![Issues](https://img.shields.io/github/issues/xu-minghao317/dotfiles)](https://github.com/xu-minghao317/dotfiles/issues)

Personal .dotfiles for macOS (Apple Silicon) and Manjaro (amd64) running zsh

> [!WARNING]  
> This repository is intended for personal use and should be run on a new machine. Do not use it directly without understanding its operations. Running `./install` will *overwrite* existing dotfiles!

> [!NOTE]  
> Ensure using a login shell.  
> Feel free to fork it and modify it to suit your needs or open issues/PRs to discuss 😌.

## Workflow for macOS (Apple Silicon)

1. Update system

    ```shell
    softwareupdate --install --all
    ```

1. Install `Command Line Tools`

    ```shell
    xcode-select --install
    ```

1. Install dotfiles

    **All packages listed in [`macos/Brewfile`](https://github.com/xu-minghao317/dotfiles/blob/main/macos/Brewfile) will be installed.**

    ```shell
    git clone https://github.com/xu-minghao317/dotfiles.git ~/.dotfiles --recursive
    cd ~/.dotfiles
    ./install macos
    ```

1. Install Nerd Fonts and themes

    Download and install [Nerd Fonts](https://www.nerdfonts.com/font-downloads). Use these fonts in your preferred terminal emulator. Note that JetBrains Mono is included in the Brewfile. Install missing [Catppuccin themes](https://github.com/catppuccin/catppuccin).

1. Restart your terminal, and you should be good to go! 🎉 

### Optional Steps for macOS

1. Enable Touch ID for `sudo`:

    macOS Sonoma adds support to permanently enable Touch ID for `sudo`. On Sonoma and above we do:

    ```shell
    sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
    sudo vim /etc/pam.d/sudo_local
    ```

    Uncomment the only line there:
    ```shell
    - #auth       sufficient     pam_tid.so
    +  auth       sufficient     pam_tid.so
    ```

## Workflow for Manjaro (amd64)

1. Update system

    ```shell
    sudo pacman -Syu
    ```

1. Install dotfiles

    **All packages listed in [`linux/pacman-packages.txt`](https://github.com/xu-minghao317/dotfiles/blob/main/linux/pacman-packages.txt) will be installed.**

    ```shell
    git clone https://github.com/xu-minghao317/dotfiles.git ~/.dotfiles --recursive
    cd ~/.dotfiles
    ./install manjaro
    ```

1. Install Nerd Fonts and themes

    Download and install [Nerd Fonts](https://www.nerdfonts.com/font-downloads). Use these fonts in your preferred terminal emulator. Install missing [Catppuccin themes](https://github.com/catppuccin/catppuccin).

1. Restart your terminal, and you should be good to go! 🎉 
