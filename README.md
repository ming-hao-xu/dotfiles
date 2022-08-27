# Development Environment Quick Setup

## Minimal
1. Upgrade `macOS`
2. Install `Command Line Tools`
   ```shell
   xcode-select --install
   ```
3. Run `dotbot`
   > To save time, remove Xcode from mas
   ```shell
   git clone https://github.com/xu-minghao317/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles && ./install
   ```
4. Migrate `GPG` `SSH` keys manually

## If I have time
1. Delete all `.DS_Store` files and set a default view option
   ```shell
   find . -name ".DS_Store" -type f -delete
   ```