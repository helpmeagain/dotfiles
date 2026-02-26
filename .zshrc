precmd() { precmd() { echo "" } }

HISTFILE=$HOME/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

eval "$(mise activate zsh)"
eval "$(starship init zsh)"

# bind
bindkey "^H" backward-delete-word
bindkey '^[[3;5~' kill-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# alias
alias ls='ls --color=auto'
alias ll='ls -lah'
alias clear="precmd() { precmd() { echo } } && clear"

# Yazi
export EDITOR="code"
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20