# Development Environment Quick Setup

## Minimal
1. Upgrade `macOS`
2. Install `Command Line Tools`
   ```shell
   xcode-select --install
   ```
3. Surpass Homebrew sudo check. (even with `NONINTERACTIVE=1` prefix, Homebrew prompt for password. Run `sudo` ver. first
   to make `brew` know you have access. This should be safe because `brew` will stop you with root)
   ```shell
   git clone https://github.com/xu-minghao317/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles && ./setup_brew.zsh
   ```
4. Run `dotbot`
   > To save time, remove Xcode from mas
   ```shell
   ./install
   ```
5. Migrate `GPG` `SSH` keys manually

## If I have time
1. Delete all `.DS_Store` files and set a default view option
   ```shell
   find . -name ".DS_Store" -type f -delete
   ```