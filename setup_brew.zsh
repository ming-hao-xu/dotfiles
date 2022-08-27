#!/usr/bin/env zsh

# Install Homebrew non-interactively without prompting for passwords
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval $(/opt/homebrew/bin/brew shellenv)

brew analytics off
brew bundle --verbose && brew cleanup && brew autoremove