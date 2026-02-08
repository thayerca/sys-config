# ------------------------------------------------------------------------------
# 🧠 .zshrc — Zsh Interactive Configuration
# ------------------------------------------------------------------------------
# Description:
#   Loaded for interactive zsh sessions. Sets up:
#   - Oh My Zsh + plugins
#   - Starship prompt (single init after OMZ)
#   - PATH and env (single brew shellenv; avoid duplicate inits)
#   - Tool integrations: direnv, fzf, pyenv, kubectl, gcloud
#   - Custom aliases and functions from .aliases.shrc / .functions.shrc
#
# Load order: .zprofile (login) → .zshrc (interactive).
# To tweak: edit files in repo (zsh/); symlinks point ~/.zshrc here.
# Reload after changes: source ~/.zshrc (or exec $SHELL).
#
# Author: Casey A. Thayer
# Location: ~/.zshrc (symlinked from repo)
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# 🎨 Oh My Zsh: framework and plugins (must come before Starship so prompt works).
# ------------------------------------------------------------------------------
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"

# Single source for Homebrew PATH and vars (used by OMZ and rest of rc).
# On Linux or non-Homebrew installs, ensure brew is on PATH or skip.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif command -v brew &>/dev/null; then
  eval "$(brew shellenv)"
fi

# OMZ plugin dir for syntax highlighting; compdump per host to avoid conflicts.
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="$ZSH/custom/plugins/zsh-syntax-highlighting/highlighters"
export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST"

# Plugin list: add/remove here; then run setup or clone custom plugins as needed.
plugins=(
  docker
  docker-compose
  fast-syntax-highlighting
  git
  macos
  virtualenv
  vi-mode
  zsh-autosuggestions
  zsh-autocomplete
)

source "$ZSH/oh-my-zsh.sh"

# ------------------------------------------------------------------------------
# 💅 Prompt: Starship (single init — config from ~/.config/starship.toml).
# ------------------------------------------------------------------------------
eval "$(starship init zsh)"

# ------------------------------------------------------------------------------
# 🧭 Environment: PATH and shell options (one block to avoid duplication).
# ------------------------------------------------------------------------------
export SHELL=zsh
export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/.local/bin:$PATH"
# Optional: Homebrew formula paths (uncomment if you use these)
# export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
# export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="${PATH:+$PATH:}$HOME/.dagger/bin"
export PYTHON_BUILD_HOMEBREW_OPENSSL_FORMULA=openssl@3

# History: size and append-every-command (Bash-style timestamps in HISTTIMEFORMAT).
export HISTTIMEFORMAT="%F %T "
export HISTSIZE=10000
export HISTFILESIZE=20000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

# ------------------------------------------------------------------------------
# 🛠 CLI tool initialization (guarded so missing tools don't break shell).
# ------------------------------------------------------------------------------

# direnv: auto-load .envrc in directories
if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

# fzf: fuzzy finder key bindings (sourced from repo: ~/.fzf → repo/fzf/.fzf)
if [[ -f "$HOME/.fzf/key-bindings.zsh" ]]; then
  source "$HOME/.fzf/key-bindings.zsh"
fi
export FZF_TMUX=1
export FZF_TMUX_HEIGHT=40%

# Ctrl+R: search history with fzf and put result on command line
fzf-history() {
  local selected
  selected=$(history | fzf | awk '{$1=""; print substr($0,2)}')
  if [[ -n "$selected" ]]; then
    READLINE_LINE=$selected
    READLINE_POINT=${#selected}
  fi
}
zle -N fzf-history
bindkey '^R' fzf-history

# pyenv + pyenv-virtualenv: Python version and venv switching
if command -v pyenv &>/dev/null; then
  eval "$(pyenv init -)"
  if command -v pyenv-virtualenv-init &>/dev/null; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi

# kubectl: shell completion
if command -v kubectl &>/dev/null; then
  source <(kubectl completion zsh)
fi

# Google Cloud SDK: PATH and completion (macOS Homebrew cask path)
if [[ -f "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" ]]; then
  source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
fi

# ------------------------------------------------------------------------------
# 🐍 Python / uv: optional aliases (requires uv installed).
# ------------------------------------------------------------------------------
alias uvp="uv pip install -r pyproject.toml"
alias uvr="uv pip uninstall -y -r <(uv pip freeze)"

# ------------------------------------------------------------------------------
# 🔧 Custom aliases and functions (sourced from repo symlinks).
# ------------------------------------------------------------------------------
[[ -f "$HOME/.aliases.shrc" ]] && source "$HOME/.aliases.shrc"
[[ -f "$HOME/.functions.shrc" ]] && source "$HOME/.functions.shrc"

# ------------------------------------------------------------------------------
# 🎛 Zsh behavior: colors and compinit (skip_global_compinit for OMZ).
# ------------------------------------------------------------------------------
autoload -U colors && colors
skip_global_compinit=1

# fnm: Node version manager (faster alternative to nvm)
FNM_PATH="/opt/homebrew/opt/fnm/bin"
if [[ -d "$FNM_PATH" ]]; then
  eval "$(fnm env)"
fi

# nvm: Node version manager (optional; comment out if using only fnm)
export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  \. "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"
fi
