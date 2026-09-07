#!/bin/bash

set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mise_download=""

cleanup() {
  if [[ -n "$mise_download" ]]; then
    rm -f "$mise_download"
  fi
}
trap cleanup EXIT

if [[ ! -f "$HOME/.gitconfig_local" ]]; then
  echo
  echo "Git user configuration (this will be saved in ~/.gitconfig_local)"
  echo "---"
  read -r -p "Name: " full_name
  read -r -p "Email: " email
fi

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.config"

# Install/Update Homebrew
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ "$(uname -m)" = "arm64" ]]; then
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> "$HOME/.zprofile"
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  brew update
fi

# Install packages using Brewfile
brew bundle --file="$BASEDIR/Brewfile"

# Use Homebrew's bottled mise on Apple Silicon. Homebrew no longer publishes
# Intel macOS bottles, so use mise's official precompiled binary there.
case "$(uname -m)" in
  arm64)
    MISE_BIN="$(brew --prefix mise)/bin/mise"
    ;;
  x86_64)
    MISE_BIN="$HOME/.local/bin/mise"
    mise_download="$(mktemp "$HOME/.local/bin/mise.XXXXXX")"
    if ! curl -fsSL "https://mise.jdx.dev/mise-latest-macos-x64" -o "$mise_download"; then
      rm -f "$mise_download"
      exit 1
    fi
    chmod +x "$mise_download"
    mv "$mise_download" "$MISE_BIN"
    mise_download=""
    export PATH="$HOME/.local/bin:$PATH"
    ;;
  *) echo "Unsupported architecture: $(uname -m)" >&2; exit 1 ;;
esac
eval "$("$MISE_BIN" activate bash)"

# Ensure fonts are installed (migration assistant workaround)
if [[ ! -f "$HOME/Library/Fonts/JetBrainsMonoNerdFont-Regular.ttf" ]]; then
  brew reinstall --cask font-jetbrains-mono-nerd-font
fi

# Disable MacOS quarantine
if command -v alacritty >/dev/null 2>&1; then
  xattr -d com.apple.quarantine "$(command -v alacritty)" 2>/dev/null || true
fi
if command -v claude >/dev/null 2>&1; then
  xattr -d com.apple.quarantine "$(command -v claude)" 2>/dev/null || true
fi

# Install latest version of ruby and dev tools
"$MISE_BIN" install ruby@latest
"$MISE_BIN" use -g ruby@latest
"$MISE_BIN" settings add idiomatic_version_file_enable_tools ruby
gem install ruby-lsp

# Install latest version of go and dev tools
"$MISE_BIN" install go@latest
"$MISE_BIN" use -g go@latest
"$MISE_BIN" settings add idiomatic_version_file_enable_tools go
go install mvdan.cc/gofumpt@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install golang.org/x/tools/gopls@latest

# Install latest LTS version of node
"$MISE_BIN" install node@lts
"$MISE_BIN" use -g node@lts
"$MISE_BIN" settings add idiomatic_version_file_enable_tools node
npm install -g @playwright/cli@latest

# Terminal.app settings
osascript "$BASEDIR/terminal/settings.scpt"

# alacritty
ln -sfn "$BASEDIR/alacritty" "$HOME/.config/alacritty"

# starship
ln -sf "$BASEDIR/starship/starship.toml" "$HOME/.config/starship.toml"

# neovim
ln -sfn "$BASEDIR/nvim" "$HOME/.config/nvim"

# tmux
ln -sfn "$BASEDIR/tmux" "$HOME/.config/tmux"

# tmuxifier
if [[ -d "$HOME/.tmuxifier" ]]; then
  git -C "$HOME/.tmuxifier" pull
else
  git clone https://github.com/jimeh/tmuxifier.git "$HOME/.tmuxifier"
fi

# ripgrep
ln -sf "$BASEDIR/ripgreprc" "$HOME/.ripgreprc"

# git
ln -sf "$BASEDIR/gitconfig" "$HOME/.gitconfig"

# rails
ln -sf "$BASEDIR/railsrc" "$HOME/.railsrc"

# zsh
if ! grep -qF "# DOTFILES BEGIN" "$HOME/.zshrc" 2>/dev/null; then
  cat "$BASEDIR/zshrc" >> "$HOME/.zshrc"
else
  sed -i '' -e "/# DOTFILES BEGIN/r $BASEDIR/zshrc" -e "/# DOTFILES BEGIN/,/# DOTFILES END/d" "$HOME/.zshrc"
fi

if [[ ! -f "$HOME/.gitconfig_local" ]]; then
  git config -f "$HOME/.gitconfig_local" user.email "$email"
  git config -f "$HOME/.gitconfig_local" user.name "$full_name"
fi

echo
echo "Install Successful!"
echo
