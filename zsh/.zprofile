# ------------------------------------------------------------------------------
# .zprofile — Login shell environment
# ------------------------------------------------------------------------------
# What it does:
#   Loaded once for login shells and for GUI apps (e.g. VS Code, Spotlight).
#   Sets Homebrew path, pyenv shims, EDITOR/VISUAL, and optional $HOME/bin.
#   For interactive-only settings (prompt, aliases, keybindings) see .zshrc.
#
# How to interact: Edit in repo (zsh/.zprofile). Symlink: ~/.zprofile → repo.
#   Changes apply on next login or when GUI apps are restarted.
#
# Author: Casey A. Thayer
# Location: ~/.zprofile (symlinked from repo)
# ------------------------------------------------------------------------------

# 🍺 Homebrew path setup (Apple Silicon, macOS)
eval "$(/opt/homebrew/bin/brew shellenv)"

# 🐍 pyenv setup for GUI apps (e.g., VS Code launched via Spotlight)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PATH"

# ✍️ Default editor (optional)
export EDITOR="nvim"
export VISUAL="nvim"

# 📦 Add user bin path (optional)
export PATH="$HOME/bin:$PATH"
