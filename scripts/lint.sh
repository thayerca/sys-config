#!/usr/bin/env bash
# lint.sh — validate config files for syntax errors
# Run locally: bash scripts/lint.sh
# Run in CI: automatically via .github/workflows/lint.yml

set -euo pipefail

ERRORS=0

pass() { echo "  ✓ $1"; }
fail() { echo "  ✗ $1"; ERRORS=$((ERRORS + 1)); }
section() { echo ""; echo "── $1 ──"; }

# ── Zsh syntax ──────────────────────────────────────────────────────────────
section "Zsh syntax"
if command -v zsh &>/dev/null; then
  for f in zsh/.zshrc zsh/.zprofile zsh/aliases.shrc zsh/functions.shrc; do
    if [ -f "$f" ]; then
      if zsh -n "$f" 2>/dev/null; then
        pass "$f"
      else
        fail "$f — zsh syntax error"
      fi
    fi
  done
else
  echo "  (skipped — zsh not available)"
fi

# ── Bash syntax ──────────────────────────────────────────────────────────────
section "Bash syntax"
for f in setup.sh scripts/*.sh; do
  if [ -f "$f" ]; then
    if bash -n "$f" 2>/dev/null; then
      pass "$f"
    else
      fail "$f — bash syntax error"
    fi
  fi
done

# ── Lua syntax (Neovim config) ───────────────────────────────────────────────
section "Lua syntax"
if command -v luac &>/dev/null; then
  while IFS= read -r -d '' f; do
    if luac -p "$f" 2>/dev/null; then
      pass "$f"
    else
      fail "$f — lua syntax error"
    fi
  done < <(find nvim/lua -name "*.lua" -print0 2>/dev/null)
elif command -v nvim &>/dev/null; then
  # Fallback: use nvim --headless to check lua
  while IFS= read -r -d '' f; do
    if nvim --headless -c "luafile $f" -c "qa!" 2>/dev/null; then
      pass "$f"
    else
      fail "$f — lua/nvim load error"
    fi
  done < <(find nvim/lua -name "*.lua" -print0 2>/dev/null)
else
  echo "  (skipped — luac and nvim not available)"
fi

# ── Tmux config ──────────────────────────────────────────────────────────────
section "Tmux config"
if command -v tmux &>/dev/null; then
  if tmux -f tmux/.tmux.conf new-session -d -s lint_check 2>/dev/null; then
    tmux kill-session -t lint_check 2>/dev/null || true
    pass "tmux/.tmux.conf"
  else
    fail "tmux/.tmux.conf — tmux config error"
  fi
else
  echo "  (skipped — tmux not available)"
fi

# ── Result ────────────────────────────────────────────────────────────────────
echo ""
if [ "$ERRORS" -eq 0 ]; then
  echo "All checks passed."
  exit 0
else
  echo "$ERRORS error(s) found."
  exit 1
fi
