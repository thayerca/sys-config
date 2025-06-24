# ------------------------------------------------------------------------------
# 📦 .zprofile — Login Shell Environment (macOS)
# ------------------------------------------------------------------------------
# Description:
#   One-time environment setup for login shells and GUI apps (VS Code, PyCharm).
#   Paths and env vars defined here will apply outside interactive terminals.
#
# Author: Casey A. Thayer
# Location: ~/.zprofile
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
