# ------------------------------------------------------------------------------
# 📁 fzf-cd-widget — Alt-C Directory CD
# ------------------------------------------------------------------------------

fzf-cd-widget() {
  local dir=$(fd --type d --hidden --follow --exclude .git | \
    fzf --preview='tree -L 2 {}' --height=40% --reverse --prompt='Directories ❯ ')
  [[ -n "$dir" ]] && BUFFER="cd ${(q)dir}" && zle accept-line
  zle reset-prompt
}
zle -N fzf-cd-widget
bindkey -M emacs '\ec' fzf-cd-widget
bindkey -M vicmd '\ec' fzf-cd-widget
bindkey -M viins '\ec' fzf-cd-widget
