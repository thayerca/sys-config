# ------------------------------------------------------------------------------
# 🧠 .zshrc — Zsh Interactive Configuration
# ------------------------------------------------------------------------------
# Description:
#   Loaded for interactive zsh sessions. Sets up:
#   - Oh My Zsh + plugins (vi-mode and zsh-autocomplete removed: conflict with fzf-tab)
#   - fzf-tab: fzf-powered Tab completion (replaces native menu)
#   - Starship prompt (single init after OMZ)
#   - PATH and env (single brew shellenv; avoid duplicate inits)
#   - Tool integrations: direnv, fzf, zoxide, atuin, pyenv, kubectl, gcloud
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

# compdump per host to avoid conflicts.
export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST"

# Plugin list: add/remove here; then run setup or clone custom plugins as needed.
# Note: vi-mode removed — conflicts with fzf keybindings (Ctrl+R, Ctrl+T, Alt+C)
# Note: zsh-autocomplete removed — conflicts with fzf-tab; use fzf-tab instead
plugins=(
  docker
  docker-compose
  fast-syntax-highlighting
  git
  macos
  virtualenv
  zsh-autosuggestions
)

source "$ZSH/oh-my-zsh.sh"

# fzf-tab: fzf-powered Tab completion (load after compinit, before other completion wrappers)
# setup.sh clones it automatically; or manually:
#   git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
if [[ -f ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab/fzf-tab.plugin.zsh ]]; then
  source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab/fzf-tab.plugin.zsh

  # Required: disable zsh's native menu so fzf-tab owns Tab entirely.
  # Without this, the native menu and fzf-tab both activate simultaneously and fight.
  zstyle ':completion:*' menu no

  # Preview: show directory contents when completing cd / zoxide z
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always $realpath 2>/dev/null'
  zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color=always $realpath 2>/dev/null'

  # Consistent fzf appearance across all completions
  zstyle ':fzf-tab:*' fzf-flags '--height=50%' '--reverse' '--border=rounded'

  # Switch between completion groups (e.g. files vs flags) with , and .
  zstyle ':fzf-tab:*' switch-group ',' '.'
fi

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

# zoxide: smarter cd — jump to frecently visited dirs with `z` and `zi` (interactive)
# Install: brew install zoxide  |  Usage: z <partial-path>, zi (fzf picker)
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# atuin: shell history with fuzzy TUI, per-directory filtering, timestamps, exit codes
# Install: brew install atuin && atuin import auto
# Ctrl+R opens atuin TUI; --disable-up-arrow keeps up-arrow for sequential cycling
if command -v atuin &>/dev/null; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

# fzf: fuzzy finder key bindings (sourced from repo: ~/.fzf → repo/fzf/.fzf)
# fzf's native key-bindings.zsh provides correct Ctrl+R/Ctrl+T/Alt+C via ZLE
if [[ -f "$HOME/.fzf/key-bindings.zsh" ]]; then
  source "$HOME/.fzf/key-bindings.zsh"
fi
export FZF_TMUX=1
export FZF_TMUX_HEIGHT=40%

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

# fnm: Node version manager — preferred over nvm (faster, no shell slowdown)
FNM_PATH="/opt/homebrew/opt/fnm/bin"
if [[ -d "$FNM_PATH" ]]; then
  eval "$(fnm env)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
