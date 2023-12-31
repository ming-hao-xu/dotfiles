# Dotfiles Repository

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)
[![Issues](https://img.shields.io/github/issues/xu-minghao317/dotfiles-macOS)](https://github.com/xu-minghao317/dotfiles-macOS/issues)

> [!CAUTION]  
> This repository is for personal use only. Do not use it directly without understanding what it does.

> [!NOTE]  
> Feel free to fork it and modify it to suit your needs or open issues/PRs to discuss 🤗.

## Workflow for macOS (Apple Silicon)

1. **Update macOS**

    ```shell
    softwareupdate --install -all
    ```

1. **Install `Command Line Tools`**

    ```shell
    xcode-select --install
    ```

1. **Bootstrap dotfiles**

    ```shell
    git clone https://github.com/xu-minghao317/dotfiles.git ~/.dotfiles --recursive --depth=1
    cd ~/.dotfiles && ./install
    ```

1. **Install Packages**

    ```shell
    brew bundle --file ~/.dotfiles/Brewfile
    ```

2. **Install a nerd font like [Fira Code Nerd Font](https://www.nerdfonts.com/font-downloads)**

3. **Migrate GPG/SSH keys securely**

## Workflow for Ubuntu (amd64)

1. **Update and Upgrade Packages**

    ```shell
    sudo apt update && sudo apt upgrade -y
    ```

1. **Install Zsh and Essential Packages**

    ```shell
    sudo apt install zsh git curl build-essential -y
    ```

    Switch default shell to Zsh:

    ```shell
    chsh -s $(which zsh)
    ```

1. **Bootstrap Dotfiles**

    ```shell
    git clone https://github.com/xu-minghao317/dotfiles.git ~/.dotfiles --recursive --depth=1
    cd ~/.dotfiles && ./install
    ```

1. **Install a nerd font like [Fira Code Nerd Font](https://www.nerdfonts.com/font-downloads)**

1. **Install Packages** (apt packages are usually outdated, double check packages versions)

1. **Migrate GPG/SSH Keys Securely**

## Optional Steps for macOS

1. Enable Touch ID for `sudo`:

    macOS Sonoma adds support to permanently enable Touch ID for `sudo`. macOS before Sonoma can edit `/etc/pam.d/sudo` instead.

    On Sonoma we do:

    ```shell
    sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
    sudo vim /etc/pam.d/sudo_local
    ```
    Uncomment the only line there:
    ```shell
    - #auth       sufficient     pam_tid.so
    +  auth       sufficient     pam_tid.so
    ```
