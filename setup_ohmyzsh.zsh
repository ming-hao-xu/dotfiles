#!/usr/bin/env zsh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Source oh-my-zsh to get variables
source "$ZSH"/oh-my-zsh.sh

# Install spaceship prompt
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM"/themes/spaceship-prompt --depth=1 && \
ln -s "$ZSH_CUSTOM"/themes/spaceship-prompt/spaceship.zsh-theme "$ZSH_CUSTOM"/themes/spaceship.zsh-theme
# Install plugins
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "$ZSH_CUSTOM"/plugins/you-should-use --depth=1
git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins "$ZSH_CUSTOM"/plugins/autoupdate --depth=1
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM"/plugins/zsh-autosuggestions --depth=1
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM"/plugins/zsh-syntax-highlighting --depth=1

# Remove archieved zshrc
rm -f "$HOME"/.zshrc.pre-oh-my-zsh