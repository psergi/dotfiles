#!/bin/bash

if [[ ! -f ~/.gitconfig_local ]]; then
  echo
  echo "Git user configuration (this will be saved in ~/.gitconfig_local)"
  echo "---"
  read -p "Name: " full_name
  read -p "Email: " email
fi

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
latest_ruby_version=$(rbenv install -l | grep -v - | tail -1)
rbenv install -s ${latest_ruby_version}

# Install Go and related tools
brew install goenv
latest_go_version=$(goenv install -l | grep -v - | tail -1)
goenv install -s ${latest_go_version}
goenv global ${latest_go_version}
go install mvdan.cc/gofumpt@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.54.1

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
# Set the default profile
defaults write com.googlecode.iterm2.plist "Default Bookmark Guid" -string 6F5D68B4-00E5-4B1E-9A3F-E77798EF1561
# Set the iterm window theme to "Minimal"
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

if [[ ! -f ~/.gitconfig_local ]]; then
  # Git local config
  git config -f ~/.gitconfig_local user.email "$email"
  git config -f ~/.gitconfig_local user.name "$full_name"
fi

# Finish
echo
echo "Install successful!"
echo
