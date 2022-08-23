# Quick setup of development environment

1. Upgrade `macOS`
2. Install `Xcode` from App Store
3. Install `Command Line Tools`
   ```shell
   xcode-select --install
   ```
4. Run `dotbot`
   ```shell
   git clone https://github.com/xu-minghao317/dotfiles.git ~/.dotfiles --depth=1
   ~/.dotfiles/install
   ```
5. Install `homebrew`
   ```shell
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   eval $(/opt/homebrew/bin/brew shellenv)
   brew analytics off
   ```
6. Install `tap` `formula` `cask`
   ```shell
   brew bundle --verbose
   brew cleanup && brew autoremove
   ```
7. Restart terminal or source changes to confirm if all work
   ```shell
   source ~/.zshrc
   ```