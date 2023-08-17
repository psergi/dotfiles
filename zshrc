# DOTFILES BEGIN
eval "$(rbenv init - zsh)"
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
alias vim="nvim"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
# DOTFILES END
