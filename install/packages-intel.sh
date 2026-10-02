#!/bin/bash

install_intel_packages() {
  if ! command -v git >/dev/null 2>&1; then
    echo "git is required; install the Xcode Command Line Tools with xcode-select --install" >&2
    return 1
  fi

  # mise's Aqua backend downloads release binaries instead of compiling
  # current Homebrew formulae from source on Intel macOS.
  local tools=(
    age@latest
    'awscli[symlink_bins=true]@latest'
    colima@latest
    docker-cli@latest
    aqua:docker/buildx@latest
    aqua:docker/compose@latest
    task@latest
    helm@latest
    kubectl@latest
    lima@latest
    aqua:neovim/neovim@latest
    ripgrep@latest
    sops@latest
    starship@latest
    tmux@latest
    tree-sitter@latest
  )

  echo "Installing/updating Intel command-line tools from release binaries..."
  "$MISE_BIN" use -g "${tools[@]}"
  eval "$("$MISE_BIN" hook-env -s bash)"

  # Docker discovers buildx as a CLI plugin, not as a regular PATH command.
  local buildx_bin plugin_dir
  buildx_bin="$("$MISE_BIN" which docker-cli-plugin-docker-buildx)"
  plugin_dir="$HOME/.docker/cli-plugins"
  mkdir -p "$plugin_dir"
  ln -sfn "$buildx_bin" "$plugin_dir/docker-buildx"
}
