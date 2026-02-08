# Testing and validation

This repo uses two kinds of checks: **lint** (config correctness, no install) and **validate** (post-install environment). No unit tests or heavy automation — the goal is to catch broken config before you commit and to verify a fresh install.

---

## Quick reference

| What | When to run | Command |
|------|-------------|---------|
| **Lint** | Before commit, or in CI. Ensures config files parse/load. | `bash scripts/lint.sh` |
| **Validate** | After running `setup.sh` or after pulling changes. Ensures symlinks and tools are correct. | `bash scripts/validate.sh` |

---

## Lint (no install required)

**Script:** `scripts/lint.sh`

**What it checks:**
- **Zsh syntax** — `zsh -n` on `.zshrc`, `.zprofile`, `aliases.shrc`, `functions.shrc` (no execution).
- **Bash syntax** — `bash -n` on `setup.sh`, `scripts/validate.sh`, `scripts/lint.sh`.
- **Tmux config** — `tmux -f repo/tmux/.tmux.conf start-server \; kill-server` (config parses and server starts).
- **Neovim config** — `XDG_CONFIG_HOME=repo nvim --headless +qa` (config loads without errors).
- **Optional** — If `shellcheck` is installed, runs it on the shell scripts.

**Requirements:** Run from repo root. Needs `zsh`, `tmux`, and `nvim` on PATH for full checks; if a tool is missing, that check is skipped. No symlinks or prior run of `setup.sh` needed.

**Use case:** Run locally before pushing, or in CI on every push/PR to catch syntax and load errors.

---

## Validate (after install)

**Script:** `scripts/validate.sh`

**What it checks:**
- Shell and Starship/fzf presence and config symlinks.
- Symlinks for `.zshrc`, `.zprofile`, `.tmux.conf`, `~/.config/nvim`, `~/.fzf`, `~/.config/starship.toml`.
- Git global config (pager, difftool).
- Neovim `checkhealth` (last 20 lines).

**Requirements:** Run after `setup.sh` (symlinks must exist). See `docs/DEBUG.md` if something is MISSING.

---

## Optional: CI (GitHub Actions)

You can run lint on every push/PR so broken config is caught before merge. Example: a workflow that checks out the repo, installs zsh/tmux/neovim (e.g. on `ubuntu-latest`), then runs `bash scripts/lint.sh`. Validate is usually run manually after a real install; running full `setup.sh` in CI is possible but heavier (Homebrew, etc.).

---

## Clean-room test (full install)

To simulate a new machine:

1. **Another user account** — Create a second macOS user, clone the repo there, run `setup.sh`, then run `validate.sh`.
2. **VM or container** — Clone in a minimal Ubuntu/macOS VM, install git/curl/zsh, run `setup.sh`, then `validate.sh`.

See `docs/INSTALL.md` for install steps and `docs/DEBUG.md` for troubleshooting.

---

## What we don’t do

- **Unit tests** — Config is declarative; “tests” are “does it parse/load?” (lint) and “is the environment correct?” (validate).
- **Integration tests** — No automated testing of every keybinding or plugin; that’s manual or documented in `docs/CHEATSHEET.md`.
- **Heavy CI** — Optional lint in CI is enough; full install in CI is optional and environment-dependent.
