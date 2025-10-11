# DOTFILES BEGIN
autoload -Uz compinit
compinit
setopt auto_menu
setopt no_menu_complete
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

HISTFILE=$HOME/.zsh_history
SAVEHIST=1000
HISTSIZE=1000
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

alias vim="nvim"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export SOPS_AGE_KEY_FILE="$HOME/.sops/keys.txt"
eval "$(starship init zsh)"
eval "$(mise activate zsh)"
# DOTFILES END
