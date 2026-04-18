precmd() { precmd() { echo "" } }

HISTFILE=$HOME/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

eval "$(mise activate zsh)"
eval "$(starship init zsh)"

# binds
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^H" backward-kill-word
bindkey "^[[3;5~" kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# alias
alias ls='ls --color=auto'
alias ll='ls -lah'
alias clear="precmd() { precmd() { echo } } && clear"
alias cat="bat"
alias vim="nvim"
alias vi="nvim"

alias ubuntu="distrobox enter ubuntu"
alias kali="distrobox enter kali"

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
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

source <(fzf --zsh) 

# disable beep
unsetopt beep
unsetopt list_beep
export NO_BEEP=1
export PATH=$HOME/.local/bin:$PATH
