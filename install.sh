#!/bin/bash

read -p "Installing will overwrite any existing files, continue? (y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  exit 1
fi

# Install Homebrew: https://brew.sh/
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/philsergi/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install oh my zsh: https://ohmyz.sh/#install
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install iterm2
brew install --cask iterm2

# Install Git
brew install git

# Install Fonts
brew tap homebrew/cask-fonts && brew install --cask font-jetbrains-mono-nerd-font

# Install go tools
brew install go
brew install gofumpt
brew install golangci-lint

# Install ripgrep
brew install ripgrep

# Install Neovim
brew install neovim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

# Install Docker
brew install --cask docker

# Install Ruby (rbenv)
brew install rbenv ruby-build
rbenv init
rbenv install -l

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# vim
rm -rf ~/.config/nvim/lua/custom
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
