# ------------------------------------------------------------------------------
# 📄 fzf-file-widget — Ctrl-E File Search
# ------------------------------------------------------------------------------

fzf-file-widget() {
  LBUFFER="${LBUFFER}$(fd --type f --hidden --follow --exclude .git | \
    fzf --preview='bat --style=plain --color=always {} || head -n 100 {}' \
        --height=40% --reverse --multi --prompt='Files ❯ ')"
  zle reset-prompt
}
zle -N fzf-file-widget
bindkey -M emacs '^E' fzf-file-widget
bindkey -M vicmd '^E' fzf-file-widget
bindkey -M viins '^E' fzf-file-widget
