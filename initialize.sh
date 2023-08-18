#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
mkdir -p ~/Projects/dotfiles
cd ~/Projects/dotfiles
git clone https://github.com/psergi/dotfiles.git .
source install.sh
