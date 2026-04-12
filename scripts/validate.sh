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
#   - "linked" / "present" / "found" — OK.
#   - "MISSING" or wrong paths — fix symlinks or re-run setup.sh; see docs/DEBUG.md.
#   - Neovim checkhealth may show warnings; fix only if you use that feature.
#
# See: docs/DEBUG.md (troubleshooting), docs/INDEX.md (all docs).
# ------------------------------------------------------------------------------

set -e

echo "=== Shell ==="
echo "SHELL=$SHELL"
command -v starship &>/dev/null && echo "starship: found" || echo "starship: not in PATH"
[[ -f ~/.config/starship.toml ]] && echo "starship config: linked" || echo "starship config: MISSING"
[[ -f ~/.fzf/key-bindings.zsh ]] && echo "fzf key-bindings: present" || echo "fzf key-bindings: MISSING"

echo ""
echo "=== Symlinks (should point into repo) ==="
for f in ~/.zshrc ~/.zprofile ~/.tmux.conf ~/.config/nvim ~/.fzf ~/.config/starship.toml; do
  if [[ -L "$f" ]]; then
    echo "$f -> $(readlink "$f")"
  elif [[ -e "$f" ]]; then
    echo "$f (not a symlink)"
  else
    echo "$f MISSING"
  fi
done

echo ""
echo "=== Git ==="
git config --global core.pager 2>/dev/null || true
git config --global difftool.nvimdiff.path 2>/dev/null || true

echo ""
echo "=== Neovim (run in normal env; may fail in sandbox) ==="
if command -v nvim &>/dev/null; then
  nvim --headless +"checkhealth" +qa 2>&1 | tail -20 || true
else
  echo "nvim not in PATH"
fi

echo ""
echo "Done. Fix any MISSING or wrong paths; see docs/DEBUG.md."
