# ------------------------------------------------------------------------------
# 📜 fzf-history-widget — Ctrl-R Command History
# ------------------------------------------------------------------------------

fzf-history-widget() {
  local selected num
  selected=( $(fc -rl 1 | awk '!seen[$0]++' | \
    fzf --height=40% --reverse --prompt='History ❯ ' --preview-window=hidden) )
  [[ -n "$selected" ]] && LBUFFER="${selected}"
  zle reset-prompt
}
zle -N fzf-history-widget
bindkey -M emacs '^R' fzf-history-widget
bindkey -M vicmd '^R' fzf-history-widget
bindkey -M viins '^R' fzf-history-widget
