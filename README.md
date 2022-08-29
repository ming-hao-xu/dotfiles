# Development Environment Quick Setup

## Minimal
1. Upgrade `macOS`.
2. Install `Command Line Tools`.
   ```shell
   xcode-select --install
   ```
3. Surpass brew sudo check.  
   Run `sudo` version first
   to make `brew` know you have access. This is safe because `brew` refuse installing under :root (see
   [issue #3](https://github.com/xu-minghao317/dotfiles/issues/3#issue-1353082809))
   ```shell
   git clone https://github.com/xu-minghao317/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles && sudo ./setup_brew.zsh
   ```
4. Run `dotbot`.  
   Remove `Xcode` from `Brewfile` if in hurry.
   ```shell
   ./install
   ```
   Install [Fira Code](https://github.com/tonsky/FiraCode/releases) and restart terminal.

5. Migrate `GPG` `SSH` keys safely.

## If I have time
1. Delete all `.DS_Store` files and set a default view option.
   ```shell
   find . -name ".DS_Store" -type f -delete
   ```