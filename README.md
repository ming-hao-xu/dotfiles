[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)

# Development Environment Quick Setup

## Minimal
1. Upgrade macOS.
2. Install `Command Line Tools`.
   ```shell
   xcode-select --install
   ```
3. Surpass `sudo` check from `brew`.  
   Run `sudo` version first. This is safe because `brew` refuse installing under root  
   (view [issue #5](https://github.com/xu-minghao317/dotfiles/issues/5#issue-1359849454))
   ```shell
   git clone https://github.com/xu-minghao317/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles && sudo ./setup_brew.zsh
   ```
4. Run `dotbot`.  
   Remove `Xcode` from `Brewfile` if in hurry.
   ```shell
   ./install
   ```
5. Install [Fira Code](https://github.com/tonsky/FiraCode/releases) and restart terminal.

6. Migrate `GPG` `SSH` keys safely.

## Optional
1. Delete all `.DS_Store` files and set a default Finder view option.
   ```shell
   find . -name ".DS_Store" -type f -delete
   ```
2. Hack Touch ID for `sudo`.
   ```shell
   sudo chmod +w /etc/pam.d/sudo
   sudo code /etc/pam.d/sudo
   ```

   Change it to

   ```shell
   # sudo: auth account password session
   auth       sufficient     pam_tid.so
   auth       sufficient     pam_smartcard.so
   auth       required       pam_opendirectory.so
   account    required       pam_permit.so
   password   required       pam_deny.so
   session    required       pam_permit.so
   ```

   **Remember to restore permissions**

   ```shell
   sudo chmod -w /etc/pam.d/sudo
   ```