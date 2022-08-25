# Quick setup of development environment

## Basic
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
5. Setup Spaceship Prompt
   ```shell
   git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
   ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
   ```
6. Install `homebrew`
   ```shell
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   eval $(/opt/homebrew/bin/brew shellenv)
   brew analytics off
   ```
7. Install `tap` `formula` `cask` `mas`
   ```shell
   brew bundle --verbose
   brew cleanup && brew autoremove
   ```

## Advanced
1. Delete all `.DS_Store` files and set a default view option
   ```shell
   find . -name ".DS_Store" -type f -delete
   ```
2. Migrate `GPG` `SSH` keys