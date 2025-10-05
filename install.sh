#!/bin/bash

if [[ ! -f ~/.gitconfig_local ]]; then
  echo
  echo "Git user configuration (this will be saved in ~/.gitconfig_local)"
  echo "---"
  read -p "Name: " full_name
  read -p "Email: " email
fi

# Install/Update Homebrew
which -s brew
if [[ $? != 0 ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ "$(arch)" = "arm64" ]; then
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> ~/.zprofile
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  brew update
fi

# Install packages using Brewfile
brew bundle

# Ensure fonts are installed (migration assistant workaround)
if [[ ! -f ~/Library/Fonts/JetBrainsMonoNerdFont-Regular.ttf ]]; then
  brew reinstall --cask font-jetbrains-mono-nerd-font
fi

# Install latest version of ruby
mise install ruby@latest
mise use -g ruby@latest

# Install latest version of go and dev tools
mise install go@latest
mise use -g go@latest
go install mvdan.cc/gofumpt@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install golang.org/x/tools/gopls@latest

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# iterm2 profile
mkdir -p ~/Library/Application\ Support/iTerm2/DynamicProfiles
cp -f ${BASEDIR}/iterm2/Profiles.json ~/Library/Application\ Support/iTerm2/DynamicProfiles
# Set the default profile
defaults write com.googlecode.iterm2.plist "Default Bookmark Guid" -string 6F5D68B4-00E5-4B1E-9A3F-E77798EF1561
# Set the iterm window theme to "Minimal"
defaults write com.googlecode.iterm2.plist "TabStyleWithAutomaticOption" -integer 5

# Terminal.app settings
osascript ${BASEDIR}/terminal/settings.scpt

# starship
ln -sf ${BASEDIR}/starship/starship.toml ~/.config/starship.toml

# nvim
ln -sfn ${BASEDIR}/nvim ~/.config/nvim

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
  git config -f ~/.gitconfig_local user.email "$email"
  git config -f ~/.gitconfig_local user.name "$full_name"
fi

echo
echo "Install Successful!"
echo
