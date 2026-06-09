# === binds ===
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^H" backward-kill-word
bindkey "^[[3;5~" kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^\' autosuggest-toggle

# === alias ===
alias ll='ls -lah'
alias clear="precmd() { precmd() { echo } } && clear"
alias cat="bat"
alias vim="nvim"
alias vi="nvim"
alias ls="eza"
alias tree="eza -T"

alias ubuntu="distrobox enter ubuntu"
alias kali="distrobox enter kali"

# === function ===
cpr() {
    rsync \
        --archive \
        --human-readable \
        --partial \
        --info=stats1,progress2 \
        --modify-window=1 \
        "$@"
}

mvr() {
    rsync \
        --archive \
        --human-readable \
        --partial \
        --info=stats1,progress2 \
        --modify-window=1 \
        --remove-source-files \
        "$@"
}

if command -v batcat >/dev/null 2>&1; then
    alias bat='batcat'
    alias cat='batcat'
elif command -v bat >/dev/null 2>&1; then
    alias cat='bat'
fi