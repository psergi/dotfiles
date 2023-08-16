#!/bin/bash

read -p "Installing will overwrite any existing files, continue? (y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  exit 1
fi

# Install Homebrew: https://brew.sh/
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install oh my zsh: https://ohmyz.sh/#install
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install iterm2
brew install --cask iterm2

# Install Git
brew install git

# Install Fonts
brew tap homebrew/cask-fonts && brew install --cask font-jetbrains-mono-nerd-font

# Install go tools
brew install gofumpt
brew install golangci-lint

# Install ripgrep
brew install ripgrep

# Install Neovim
brew install neovim

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# vim
ln -sf ${BASEDIR}/nvchad-custom ~/.config/nvim/lua/custom

# ripgrep
ln -sf ${BASEDIR}/ripgreprc ~/.ripgreprc

# git
ln -sf ${BASEDIR}/gitconfig ~/.gitconfig

# rails
ln -sf ${BASEDIR}/railsrc ~/.railsrc

# zsh
cat ${BASEDIR}/zshrc >> ~/.zshrc

# Finish
echo -e "\nInstall successful!\n"
