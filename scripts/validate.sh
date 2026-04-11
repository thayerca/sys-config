#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# validate.sh — Config validation (symlinks and basic tooling)
# ------------------------------------------------------------------------------
# What it does:
#   Verifies that key symlinks point into the repo, that starship/fzf config
#   is present, and that git and Neovim are configured. Run after setup.sh or
#   after pulling config changes.
#
# Usage:
#   bash scripts/validate.sh
#
# Interpreting output:
#   - "✓" — good.
#   - "✗" — fix symlinks or re-run setup.sh; see docs/DEBUG.md.
#   - Neovim checkhealth may show warnings; fix only if you use that feature.
#
# See: docs/DEBUG.md (troubleshooting), docs/INDEX.md (all docs).
# ------------------------------------------------------------------------------

set -e

PASS="✓"
FAIL="✗"

ok()   { echo "  $PASS $*"; }
warn() { echo "  $FAIL $*" >&2; }

# ------------------------------------------------------------------------------
echo "=== Shell ==="
# ------------------------------------------------------------------------------
echo "SHELL=$SHELL"
command -v starship &>/dev/null && ok "starship: found" || warn "starship: not in PATH"
[[ -f ~/.config/starship.toml ]] && ok "starship config: present" || warn "starship config: MISSING"

# fzf key-bindings live inside the .fzf symlink (setup.sh: ~/.fzf -> repo/fzf/.fzf)
if [[ -f "$HOME/.fzf/key-bindings.zsh" ]]; then
  ok "fzf key-bindings: present ($HOME/.fzf/key-bindings.zsh)"
else
  warn "fzf key-bindings: MISSING — run setup.sh or: ln -sf \$REPO/fzf/.fzf ~/.fzf"
fi
command -v fzf &>/dev/null && ok "fzf binary: found" || warn "fzf binary: not in PATH"

# ------------------------------------------------------------------------------
echo ""
echo "=== Symlinks (should point into repo) ==="
# ------------------------------------------------------------------------------
for f in ~/.zshrc ~/.zprofile ~/.tmux.conf ~/.config/nvim ~/.fzf ~/.config/starship.toml \
          ~/.aliases.shrc ~/.functions.shrc ~/.gitconfig; do
  if [[ -L "$f" ]]; then
    ok "$f -> $(readlink "$f")"
  elif [[ -e "$f" ]]; then
    warn "$f (exists but is NOT a symlink — may shadow repo version)"
  else
    warn "$f MISSING"
  fi
done

# ------------------------------------------------------------------------------
echo ""
echo "=== Required tools ==="
# ------------------------------------------------------------------------------
for cmd in git nvim tmux zsh starship brew; do
  command -v "$cmd" &>/dev/null && ok "$cmd: found" || warn "$cmd: not in PATH"
done

# Optional power tools
echo "  (optional tools)"
for cmd in zoxide atuin lazydocker lazygit; do
  command -v "$cmd" &>/dev/null && ok "$cmd: found" || echo "  - $cmd: not installed (optional)"
done

# ------------------------------------------------------------------------------
echo ""
echo "=== Git ==="
# ------------------------------------------------------------------------------
pager=$(git config --global core.pager 2>/dev/null) && ok "core.pager: $pager" || warn "core.pager not set"
gname=$(git config --global user.name 2>/dev/null) && ok "user.name: $gname" || warn "user.name not set"
gemail=$(git config --global user.email 2>/dev/null) && ok "user.email: $gemail" || warn "user.email not set"

# ------------------------------------------------------------------------------
echo ""
echo "=== Neovim ==="
# ------------------------------------------------------------------------------
if command -v nvim &>/dev/null; then
  ok "nvim: $(nvim --version | head -1)"
else
  warn "nvim not in PATH — skipping checkhealth"
fi

# ------------------------------------------------------------------------------
echo ""
echo "=== tmux ==="
# ------------------------------------------------------------------------------
if command -v tmux &>/dev/null; then
  ok "tmux: $(tmux -V)"
  if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
    ok "TPM: installed"
  else
    warn "TPM: not found — run: git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"
  fi
else
  warn "tmux not in PATH"
fi

# ------------------------------------------------------------------------------
echo ""
echo "Done. Fix any $FAIL items above; see docs/DEBUG.md."
