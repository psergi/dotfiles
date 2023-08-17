#!/bin/bash

read -p "Installing will overwrite any existing files, continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 1
fi

echo
echo "Git user configuration (this will be saved in ~/.gitconfig_local)"
echo "---"
read -p "Name: " full_name
read -p "Email: " email

# Install/Update Homebrew: https://brew.sh/
which -s brew
if [[ $? != 0 ]]; then
  # Install
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  # Update
  brew update
fi

if [ "$(arch)" = "arm64" ]; then
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> ~/.zprofile
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Install oh my zsh: https://ohmyz.sh/#install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install Git
brew install git

# Install Fonts
brew tap homebrew/cask-fonts && brew install --cask font-jetbrains-mono-nerd-font
if [[ ! -f ~/Library/Fonts/JetBrainsMonoNerdFont-Regular.ttf ]]; then
  brew reinstall --cask font-jetbrains-mono-nerd-font
fi

# Install Ruby and related tools
brew install rbenv ruby-build
rbenv install -s $(rbenv install -l | grep -v - | tail -1)

# Install Go and related tools
brew install go
brew install gofumpt
brew install golangci-lint

# Install ripgrep
brew install ripgrep

# Install Neovim
brew install neovim
if [[ ! -d ~/.config/nvim ]]; then
  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
fi

# Install Docker
brew install --cask docker --no-quarantine

# Install iterm2
brew install --cask iterm2 --no-quarantine

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# iterm2 profile
mkdir -p ~/Library/Application\ Support/iTerm2/DynamicProfiles
cp -f ${BASEDIR}/iterm2/Profiles.json ~/Library/Application\ Support/iTerm2/DynamicProfiles
defaults write com.googlecode.iterm2.plist "Default Bookmark Guid" -string 6F5D68B4-00E5-4B1E-9A3F-E77798EF1561
defaults write com.googlecode.iterm2.plist "TabStyleWithAutomaticOption" -integer 5

# nvim
rm -rf ~/.config/nvim/lua/custom
ln -sf ${BASEDIR}/nvim/nvchad_custom ~/.config/nvim/lua/custom

# ripgrep
ln -sf ${BASEDIR}/ripgreprc ~/.ripgreprc

# git
ln -sf ${BASEDIR}/gitconfig ~/.gitconfig

# rails
ln -sf ${BASEDIR}/railsrc ~/.railsrc

# zsh
if [ $(grep -c "DOTFILES BEGIN" ~/.zshrc) == "0" ]; then
  cat ${BASEDIR}/zshrc >> ~/.zshrc
else
  sed -i '' -e "/# DOTFILES BEGIN/r ${BASEDIR}/zshrc" -e "/# DOTFILES BEGIN/,/# DOTFILES END/d" ~/.zshrc
fi

# Git local config
git config -f ~/.gitconfig_local user.email "$email"
git config -f ~/.gitconfig_local user.name "$full_name"

# Finish
echo
echo "Install successful!"
echo
