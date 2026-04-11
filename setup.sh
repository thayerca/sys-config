#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# setup.sh — One-shot bootstrap for sys-config dotfiles
# ------------------------------------------------------------------------------
# What it does:
#   Run once after cloning. Installs dependencies, creates symlinks from your
#   home directory into the repo, and sets up optional tools. Safe to re-run;
#   existing dotfiles (that are not already repo symlinks) are backed up first.
#
# Execution flow (in order):
#   1. Resolve REPO path (script dir or REPO env).
#   2. Preflight: require git, curl, zsh.
#   3. Backup existing dotfiles to ~/.dotfiles-backup.YYYYMMDD (if present).
#   4. Install Homebrew if missing; run brew bundle (Brewfile).
#   5. Create symlinks: .zshrc, .zprofile, aliases, functions, tmux, fzf, git,
#      nvim, starship, kitty, optional p10k.
#   6. Optional: Powerline fonts, Oh My Zsh (KEEP_ZSHRC=yes), fzf install, TPM,
#      TPM plugin install, pyenv + Python.
#   7. Print next steps (exec $SHELL, prefix+I in tmux).
#
# Usage:
#   cd ~/sys-config && bash setup.sh
#   REPO=~/.config/dotfiles bash setup.sh   # if repo is elsewhere
#
# After running: exec $SHELL; then in tmux press prefix+I to install plugins.
# Full install guide: docs/INSTALL.md. Troubleshooting: docs/DEBUG.md.
# ------------------------------------------------------------------------------

set -e

# ------------------------------------------------------------------------------
# 📍 Repo root: use REPO env if set, else directory containing this script.
#    Lets you clone to ~/.config/dotfiles or ~/sys-config and run from anywhere.
# ------------------------------------------------------------------------------
REPO="${REPO:-$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)}"
export REPO

# ------------------------------------------------------------------------------
# 🔍 Preflight: required commands (avoid cryptic failures mid-run).
# ------------------------------------------------------------------------------
log() { echo "[setup] $*"; }
err() { echo "[setup] ERROR: $*" >&2; }

for cmd in git curl zsh; do
  if ! command -v "$cmd" &>/dev/null; then
    err "Missing required command: $cmd. Install it and re-run setup."
    exit 1
  fi
done

# ------------------------------------------------------------------------------
# 📦 Optional backup of existing dotfiles (non-destructive).
#    Only copies if the target exists and is not already a symlink into REPO.
# ------------------------------------------------------------------------------
BACKUP_DIR="${HOME}/.dotfiles-backup.$(date +%Y%m%d)"
backup_if_present() {
  local target="$1"
  if [[ -e "$target" ]]; then
    if [[ -L "$target" ]]; then
      local dest
      dest=$(readlink "$target")
      if [[ "$dest" == *"$REPO"* ]]; then
        log "Already managed by repo: $target"
        return
      fi
    fi
    mkdir -p "$BACKUP_DIR"
    log "Backing up $target to $BACKUP_DIR/"
    cp -a "$target" "$BACKUP_DIR/"
  fi
}

backup_if_present "$HOME/.zshrc"
backup_if_present "$HOME/.zprofile"
backup_if_present "$HOME/.tmux.conf"
if [[ -d "$HOME/.config/nvim" ]] && [[ ! -L "$HOME/.config/nvim" ]]; then
  backup_if_present "$HOME/.config/nvim"
fi

# ------------------------------------------------------------------------------
# 🍺 Homebrew: install if missing (macOS/Linux).
# ------------------------------------------------------------------------------
if ! command -v brew &>/dev/null; then
  log "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # After install, ensure brew is on PATH for this script (macOS typical paths)
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
else
  log "Homebrew already installed."
fi

# Ensure brew is in PATH for rest of script
if command -v brew &>/dev/null; then
  eval "$(brew shellenv)"
fi

# ------------------------------------------------------------------------------
# 📦 Brewfile: install formulas and casks (idempotent).
# ------------------------------------------------------------------------------
log "Installing packages from Brewfile..."
brew bundle --file="$REPO/Brewfile"

# ------------------------------------------------------------------------------
# 🔗 Symlinks: point home/config at repo files so edits stay in repo.
#    Order matters: we symlink .zshrc before Oh My Zsh so OMZ won't overwrite it
#    when we pass KEEP_ZSHRC=yes.
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# 🔗 Symlinks: point home/config at repo files so edits stay in repo.
# ------------------------------------------------------------------------------
log "Creating symlinks..."

link_file() {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"

  # Already correct
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    log "SKIP   $dst already linked -> $src"
    return 0
  fi

  # Wrong symlink
  if [ -L "$dst" ]; then
    log "FIX    Removing incorrect symlink: $dst"
    rm -f "$dst"

  # Existing real file/dir
  elif [ -e "$dst" ]; then
    local backup="${dst}.bak.$(date +%Y%m%d-%H%M%S)"
    log "BACKUP Moving existing $dst -> $backup"
    mv "$dst" "$backup"
  fi

  ln -s "$src" "$dst"
  log "LINK   $dst -> $src"
}

# Shell (zsh only; no bash config)
link_file "$REPO/zsh/.zshrc" "$HOME/.zshrc"
link_file "$REPO/zsh/.zprofile" "$HOME/.zshprofile"
link_file "$REPO/zsh/aliases.shrc" "$HOME/.aliases.shrc"
link_file "$REPO/zsh/functions.shrc" "$HOME/.functions.shrc"

# Tmux
link_file "$REPO/tmux/.tmux.conf" "$HOME/.tmux.conf"

# FZF
link_file "$REPO/fzf/.fzf" "$HOME/.fzf"

# Git
link_file "$REPO/git-configs/.gitconfig" "$HOME/.gitconfig"
link_file "$REPO/git-configs/.gitignore_global" "$HOME/.gitignore_global"

# Neovim
mkdir -p "$HOME/.config"
link_file "$REPO/nvim" "$HOME/.config/nvim"

# Prompt
link_file "$REPO/starship/starship.toml" "$HOME/.config/starship.toml"

# Terminals
link_file "$REPO/kitty" "$HOME/.config/kitty"

# Scripts
mkdir -p "$HOME/.local/bin"
link_file "$REPO/scripts/tmux-sessionizer" "$HOME/.local/bin/tmux-sessionizer"
# ------------------------------------------------------------------------------
# 🎨 Oh My Zsh: keep existing .zshrc (our symlink) — do not overwrite.
# ------------------------------------------------------------------------------
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  log "Installing Oh My Zsh..."
  export KEEP_ZSHRC=yes
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  log "Oh My Zsh already installed."
fi

# ------------------------------------------------------------------------------
# 🔍 FZF shell integration: key bindings + fuzzy completion (from Homebrew fzf).
# ------------------------------------------------------------------------------
if brew list fzf &>/dev/null 2>&1; then
  log "Setting up fzf shell integration..."
  # Our .zshrc already sources ~/.fzf/key-bindings.zsh (from repo symlink). Run install for completion/other shells if needed.
  "$(brew --prefix)/opt/fzf/install" --all || true
fi

# ------------------------------------------------------------------------------
# 🔌 TPM (Tmux Plugin Manager): clone so tmux can load plugins.
#    After first tmux attach, run: prefix + I (capital I) to install plugins.
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# 🔌 TPM (Tmux Plugin Manager): clone so tmux can load plugins.
# ------------------------------------------------------------------------------
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  log "Installing Tmux Plugin Manager (TPM)..."
  mkdir -p "$HOME/.tmux/plugins"
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

log "TPM ready. Start tmux and press prefix+I to install plugins."

# ------------------------------------------------------------------------------
# 🐍 pyenv: optional Python version manager + default 3.13.
# ------------------------------------------------------------------------------
if ! command -v pyenv &>/dev/null; then
  log "Installing pyenv..."
  curl -fsSL https://pyenv.run | bash
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  log "Installing Python 3.13..."
  pyenv install -s 3.13.0 2>/dev/null || true
  pyenv global 3.13.0
else
  log "pyenv already installed."
fi

# ------------------------------------------------------------------------------
# ✅ Done
# ------------------------------------------------------------------------------
log "Setup complete. Restart your shell or run: exec \$SHELL"
log "Next: start tmux and run prefix+I if plugins are not yet installed."
