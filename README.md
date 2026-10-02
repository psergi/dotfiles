# dotfiles

## Install

```bash
git clone https://github.com/psergi/dotfiles.git
cd dotfiles
./install.sh
```

Run `./install.sh` again to update the installed tools. On Apple Silicon,
command-line packages come from `Brewfile`. On Intel Macs, Homebrew installs
the apps in `Brewfile.intel`, while mise installs current macOS x86_64 release
binaries for the command-line tools in `install/packages-intel.sh`. Intel uses
the system Git provided by the Xcode Command Line Tools.

## Initialize (New Laptop)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/psergi/dotfiles/master/initialize.sh)"
```
