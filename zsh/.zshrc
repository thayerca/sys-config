# ------------------------------------------------------------------------------
# 🧠 .zshrc — Zsh Configuration
# ------------------------------------------------------------------------------
# Description:
#   Core shell configuration for local development. Handles:
#   - Powerlevel10k theme and Oh My Zsh
#   - Paths and environment setup
#   - Tool integrations (direnv, kubectl, pyenv, gcloud)
#   - Plugin configuration and shell enhancements
#
# Author: Casey A. Thayer
# Location: ~/.zshrc
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# ⚡️ Instant Prompt (Powerlevel10k)
# ------------------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------------------------------------------------------
# 🎨 Theme and Oh My Zsh
# ------------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="powerlevel10k/powerlevel10k"
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="$ZSH/custom/plugins/zsh-syntax-highlighting/highlighters"
export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST"

plugins=(
  git
  macos
  docker
  docker-compose
  virtualenv
  vi-mode
)

source "$ZSH/oh-my-zsh.sh"

# ------------------------------------------------------------------------------
# 💅 Prompt Configuration
# ------------------------------------------------------------------------------
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# ------------------------------------------------------------------------------
# 🧭 Shell Environment Variables & Paths
# ------------------------------------------------------------------------------
export SHELL=zsh
eval "$(/opt/homebrew/bin/brew shellenv)"  # Adds Homebrew to PATH and sets variables

export PATH="/usr/local/bin:$PATH"                            # Legacy tools
export PATH="$HOME/.local/bin:$PATH"                          # pipx / uv installs
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PYTHON_BUILD_HOMEBREW_OPENSSL_FORMULA=openssl@3

# ------------------------------------------------------------------------------
# 🛠 CLI Tool Initialization
# ------------------------------------------------------------------------------

# 📦 direnv
eval "$(direnv hook zsh)"

# 🔍 fzf
[[ -f "$HOME/.fzf/key-bindings.zsh" ]] && source "$HOME/.fzf/key-bindings.zsh"

# 📦 pyenv & virtualenv
if command -v pyenv > /dev/null; then
  eval "$(pyenv init -)"
  if command -v pyenv-virtualenv-init > /dev/null; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi

# 📦 kubectl autocompletion
if command -v kubectl > /dev/null; then
  source <(kubectl completion zsh)
fi

# 📦 Google Cloud SDK
if [[ -f "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" ]]; then
  source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
fi

# 📦 Bash completion (some tools rely on this)
[[ -f /opt/homebrew/etc/bash_completion ]] && source /opt/homebrew/etc/bash_completion


# ------------------------------------------------------------------------------
# 🐍 Python & uv (optional)
# ------------------------------------------------------------------------------
# If you're using Astral's `uv`, consider adding completions manually:
# mkdir -p ~/.zfunc && uv completion zsh > ~/.zfunc/_uv && fpath+=~/.zfunc

alias uvp="uv pip install -r pyproject.toml"
alias uvr="uv pip uninstall -y -r <(uv pip freeze)"

# ------------------------------------------------------------------------------
# 🔧 Custom Aliases & Functions
# ------------------------------------------------------------------------------
[[ -f "$HOME/.aliases.shrc" ]] && source "$HOME/.aliases.shrc"
[[ -f "$HOME/.functions.shrc" ]] && source "$HOME/.functions.shrc"

# ------------------------------------------------------------------------------
# 🎛 Zsh Visual & Prompt Enhancements
# ------------------------------------------------------------------------------
autoload -U colors && colors
skip_global_compinit=1  # Prevent Oh My Zsh from running compinit again unnecessarily

# zsh-autosuggestions (Homebrew)
[[ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && \
  source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh-syntax-highlighting (Homebrew) — must be last
[[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && \
  source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
