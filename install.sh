#!/bin/bash

read -p "Installing will overwrite any existing files, continue? (y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  exit 1
fi


BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# vim
ln -sf ${BASEDIR}/vimrc ~/.vimrc
ln -sf ${BASEDIR}/gvimrc ~/.gvimrc
rm -rf ~/.vim
ln -sf ${BASEDIR}/vim ~/.vim
ln -sf ${BASEDIR}/nvchad-custom ~/.config/nvim/lua/custom

# git
ln -sf ${BASEDIR}/gitconfig ~/.gitconfig

# rails
ln -sf ${BASEDIR}/railsrc ~/.railsrc

# zsh
cat ${BASEDIR}/zshrc >> ~/.zshrc

# Install vim plugins
vim +'PlugInstall --sync' +qa

# Finish
echo -e "\nInstall successful!\n"
echo "Run 'source ~/.zshrc' to complete setup"
