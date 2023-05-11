# Enviroment Setup

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)
[![Issues](https://img.shields.io/github/issues/xu-minghao317/dotfiles-macOS)](https://github.com/xu-minghao317/dotfiles-macOS/issues)

## Workflow

1. Update macOS

   ```shell
   softwareupdate --install -all
   ```

2. Install `Command Line Tools`.

   ```shell
   xcode-select --install
   ```

3. Bootstrap dotfiles. Remove `Xcode` and `mactex-no-gui` from Brewfile if you're in a rush.

   ```shell
   git clone https://github.com/xu-minghao317/dotfiles.git ~/.dotfiles --recursive --depth=1
   cd ~/.dotfiles && ./install
   ```

4. Install [Fira Code Nerd Font](https://www.nerdfonts.com/font-downloads).

5. Migrate keys securely.

## Optional Steps

1. Delete all `.DS_Store` files and set a default Finder view option:

   ```shell
   killall Finder && find . -name ".DS_Store" -type f -delete
   ```

2. Enable Touch ID for `sudo`:

   ```shell
   sudo chmod u+w /etc/pam.d/sudo
   sudo nvim /etc/pam.d/sudo
   ```

   Update the file to:

   ```shell
   # sudo: auth account password session
   auth       sufficient     pam_tid.so
   auth       sufficient     pam_smartcard.so
   auth       required       pam_opendirectory.so
   account    required       pam_permit.so
   password   required       pam_deny.so
   session    required       pam_permit.so
   ```

   Finally, restore the file permissions:

   ```shell
   sudo chmod u-w /etc/pam.d/sudo
   ```
