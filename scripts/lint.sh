#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# lint.sh — Config syntax and load checks (no install required)
# ------------------------------------------------------------------------------
# What it does:
#   Validates that config files in the repo parse/load correctly. Run from
#   repo root before committing or in CI. Does NOT require setup.sh or
#   symlinks; only needs zsh, tmux, and nvim on PATH.
#
# Checks:
#   - Zsh: zsh -n on .zshrc, .zprofile, aliases.shrc, functions.shrc
#   - Bash: bash -n on setup.sh, validate.sh, this script
#   - Tmux: tmux -f repo/tmux/.tmux.conf start-server \; kill-server
#   - Neovim: XDG_CONFIG_HOME=repo nvim --headless +qa (config loads)
#   - Optional: shellcheck on setup.sh and validate.sh if available
#
# Usage:
#   cd /path/to/sys-config && bash scripts/lint.sh
#
# Exit: 0 if all checks pass, 1 if any fail. See docs/TESTING.md.
# ------------------------------------------------------------------------------

set -e

REPO="${REPO:-$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)}"
FAILED=0

log() { echo "[lint] $*"; }
ok() { echo "[lint]   OK: $*"; }
fail() { echo "[lint]   FAIL: $*"; FAILED=1; }

# ------------------------------------------------------------------------------
# Zsh syntax (no execution)
# ------------------------------------------------------------------------------
log "Checking Zsh syntax..."
for f in "$REPO/zsh/.zshrc" "$REPO/zsh/.zprofile" "$REPO/zsh/aliases.shrc" "$REPO/zsh/functions.shrc"; do
  if [[ ! -f "$f" ]]; then
    fail "missing: $f"
  elif zsh -n "$f" 2>/dev/null; then
    ok "$f"
  else
    fail "$f (zsh -n failed)"
  fi
done

# ------------------------------------------------------------------------------
# Bash syntax (setup and scripts)
# ------------------------------------------------------------------------------
log "Checking Bash syntax..."
for f in "$REPO/setup.sh" "$REPO/scripts/validate.sh" "$REPO/scripts/lint.sh"; do
  if [[ ! -f "$f" ]]; then
    fail "missing: $f"
  elif bash -n "$f" 2>/dev/null; then
    ok "$f"
  else
    fail "$f (bash -n failed)"
  fi
done

# ------------------------------------------------------------------------------
# Tmux config (parse and start-server then kill; use private socket for isolation)
# ------------------------------------------------------------------------------
log "Checking Tmux config..."
TMUX_CONF="$REPO/tmux/.tmux.conf"
TMUX_SOCK="${TMUX_SOCK:-$REPO/.tmp/lint-tmux.sock}"
if [[ ! -f "$TMUX_CONF" ]]; then
  fail "missing: $TMUX_CONF"
elif command -v tmux &>/dev/null; then
  mkdir -p "$(dirname "$TMUX_SOCK")"
  if tmux -f "$TMUX_CONF" -S "$TMUX_SOCK" start-server \; kill-server 2>/dev/null; then
    ok "tmux config"
    rm -f "$TMUX_SOCK"
  else
    fail "tmux config (start-server failed)"
  fi
else
  log "  skip: tmux not on PATH"
fi

# ------------------------------------------------------------------------------
# Neovim config (load from repo without symlinks)
# ------------------------------------------------------------------------------
log "Checking Neovim config load..."
if command -v nvim &>/dev/null; then
  if XDG_CONFIG_HOME="$REPO" nvim --headless +qa 2>/dev/null; then
    ok "nvim config"
  else
    fail "nvim config (--headless +qa failed)"
  fi
else
  log "  skip: nvim not on PATH"
fi

# ------------------------------------------------------------------------------
# Optional: shellcheck (if installed)
# ------------------------------------------------------------------------------
if command -v shellcheck &>/dev/null; then
  log "Running shellcheck on setup.sh and scripts..."
  for f in "$REPO/setup.sh" "$REPO/scripts/validate.sh" "$REPO/scripts/lint.sh"; do
    if shellcheck -x "$f" 2>/dev/null; then
      ok "shellcheck $f"
    else
      fail "shellcheck $f"
    fi
  done
else
  log "  skip: shellcheck not installed (optional)"
fi

# ------------------------------------------------------------------------------
# Summary
# ------------------------------------------------------------------------------
echo ""
if [[ $FAILED -eq 0 ]]; then
  log "All checks passed."
  exit 0
else
  log "Some checks failed. Fix errors above and re-run."
  exit 1
fi
