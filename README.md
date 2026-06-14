# Dotfiles Repository

![GitHub License](https://img.shields.io/github/license/ming-hao-xu/dotfiles)
[![Issues](https://img.shields.io/github/issues/ming-hao-xu/dotfiles)](https://github.com/ming-hao-xu/dotfiles/issues)

Personal .dotfiles for macOS (Apple Silicon) running zsh

> [!WARNING]  
> This repository is intended for personal use. Do not run it without understanding its operations. `./install` manages the configured dotfiles paths, relinks managed symlinks, removes stale repo-managed links, and may back up conflicting files or directories as `.dotbot-backup.<timestamp>`.

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

    [`macos/Brewfile`](https://github.com/ming-hao-xu/dotfiles/blob/main/macos/Brewfile) intentionally contains only the core CLI runtime required by this dotfiles setup. GUI apps, Casks, VS Code extensions, and broader personal-machine restore items are managed outside this install path.

    ```shell
    git clone https://github.com/ming-hao-xu/dotfiles.git ~/.dotfiles --recursive
    cd ~/.dotfiles
    ./install -x
    ```

1. Restart your terminal, and you should be good to go! 🎉  
   (This repo links Ghostty config, but it does not install Ghostty. For other terminals, manually install a Nerd Font and apply a Catppuccin Mocha theme.)

## Updating an Existing Machine

```shell
cd ~/.dotfiles
git status
git pull --ff-only
./install -x
```

If `git status` shows local changes, review them before pulling. Running `./install -x` will update managed symlinks and install missing core CLI packages, but it will not uninstall old GUI apps, Casks, VS Code extensions, or other machine-local software.

## CI Coverage

CI runs the real installer on macOS 26 with a clean temporary `$HOME`, then reruns it to check idempotency and stale managed-link cleanup. It validates Homebrew bundle installation, Dotbot links, Oh My Zsh plugins, Catppuccin bat/tmux resources, core CLI tools, tmux config loading, and interactive/login zsh startup.

GitHub-hosted macOS runners already provide Homebrew, so the cold Homebrew bootstrap branch remains best-effort and should be manually checked on a truly fresh machine when needed.

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
