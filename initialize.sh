#!/bin/bash

xcode-select --install
mkdir -p ~/Projects/dotfiles
cd ~/Projects/dotfiles
git clone https://github.com/psergi/dotfiles.git .
source install.sh
