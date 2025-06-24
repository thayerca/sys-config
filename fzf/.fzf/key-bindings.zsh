# ------------------------------------------------------------------------------
# 🔌 key-bindings.zsh — Loads all FZF widgets
# ------------------------------------------------------------------------------

[[ -o interactive ]] || return 0

# Load all widgets from ~/.fzf/widgets
for file in "$HOME/.fzf/widgets/"*.zsh; do
  source "$file"
done
