# DOTFILES BEGIN
alias vim="nvim"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export SOPS_AGE_KEY_FILE="$HOME/.sops/keys.txt"
eval "$(starship init zsh)"
eval "$(mise activate zsh)"
# DOTFILES END
