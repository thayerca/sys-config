# sys-config: Install Guide

**Goal:** Clone this repo and run one script to get a working shell, tmux, Neovim, and git config on a new machine.

**See also:** [docs/INDEX.md](INDEX.md) for all documentation; [docs/DEBUG.md](DEBUG.md) for troubleshooting.

---

## Overview

| Step | Action |
|------|--------|
| 1 | Clone repo (any path; script detects location or use `REPO=…`). |
| 2 | Run `bash setup.sh` — installs Homebrew, Brewfile, symlinks, Oh My Zsh, fzf, TPM, optional pyenv. |
| 3 | Restart shell: `exec $SHELL`. |
| 4 | In tmux: **prefix + I** to install tmux plugins (prefix is Ctrl-A). |
| 5 | Neovim: on first run, lazy.nvim installs plugins automatically. |

---

## Prerequisites

- **macOS or Linux** (setup script is written for both; Homebrew is optional on Linux)
- **Git** and **curl** (to clone and fetch installers)
- **Zsh** (install via your package manager if missing; setup assumes zsh as default shell)

On macOS, the Xcode Command Line Tools are usually enough for git/curl. Install with:

```bash
xcode-select --install
```

---

## Quick install

1. **Clone the repo** (use any path you like; the script detects its own location):

   ```bash
   git clone <your-repo-url> ~/sys-config
   cd ~/sys-config
   ```

   If you use a different path (e.g. `~/.config/dotfiles`), you can set `REPO` when running setup:

   ```bash
   REPO=~/.config/dotfiles bash setup.sh
   ```

2. **Run the setup script:**

   ```bash
   bash setup.sh
   ```

   The script will:

   - Install Homebrew (if missing)
   - Run `brew bundle` from the repo’s Brewfile
   - Back up existing dotfiles to `~/.dotfiles-backup.YYYYMMDD` if they exist
   - Create symlinks from your home directory to the repo (e.g. `~/.zshrc` → repo)
   - Install Powerline fonts (optional), Oh My Zsh (with `KEEP_ZSHRC=yes`), fzf shell integration, TPM, and pyenv + Python 3.13 (optional)

3. **Restart your shell** (or open a new terminal):

   ```bash
   exec $SHELL
   ```

4. **Tmux plugins:** The first time you start tmux, press **prefix + I** (capital I) to install plugins. Prefix is **Ctrl-A**. If the script ran TPM’s `install_plugins`, they may already be installed.

5. **Neovim:** On first run, Neovim will pull lazy.nvim and all plugins. Optional: create a Python venv for the Python provider:

   ```bash
   python3 -m venv ~/.venvs/global
   ~/.venvs/global/bin/pip install neovim
   ```

---

## What gets symlinked

| Symlink | Points to |
|--------|------------|
| `~/.zshrc` | `repo/zsh/.zshrc` |
| `~/.zprofile` | `repo/zsh/.zprofile` |
| `~/.aliases.shrc` | `repo/zsh/aliases.shrc` |
| `~/.functions.shrc` | `repo/zsh/functions.shrc` |
| `~/.tmux.conf` | `repo/tmux/.tmux.conf` |
| `~/.fzf` | `repo/fzf/.fzf` (so `~/.fzf/key-bindings.zsh` works) |
| `~/.gitconfig` | `repo/git-configs/.gitconfig` |
| `~/.gitignore_global` | `repo/git-configs/.gitignore_global` |
| `~/.config/nvim` | `repo/nvim` |
| `~/.config/starship.toml` | `repo/starship/starship.toml` |
| `~/.config/kitty` | `repo/kitty` |
| `~/.p10k.zsh` | `repo/powerline/.p10k.zsh` (optional; p10k is commented out in .zshrc) |

---

## Verification (after install)

Run these to confirm things are wired correctly:

```bash
# Shell and prompt
echo $SHELL
type starship
[[ -f ~/.config/starship.toml ]] && echo "starship config linked"

# FZF (key bindings from repo)
[[ -f ~/.fzf/key-bindings.zsh ]] && echo "fzf key-bindings present"

# Symlinks (should point into your repo)
ls -la ~/.zshrc ~/.zprofile ~/.tmux.conf ~/.config/nvim ~/.fzf ~/.config/starship.toml

# Git
git config --global core.pager
# Should show: delta
```

**Neovim:**

```bash
nvim --headless +"checkhealth" +qa 2>&1 | head -60
nvim --startuptime /tmp/nvim-startup.log +qa && tail -5 /tmp/nvim-startup.log
```

**Tmux:** Start tmux, create a pane (prefix + `|` or `-`), then press prefix + h/j/k/l to move. Press prefix + I if plugins aren’t installed yet.

---

## Clean-room testing (optional)

To simulate a fresh machine without touching your real home directory:

- **New macOS user:** Create a second user account, clone the repo there, and run `setup.sh`.
- **Temporary HOME:** Run with a fake home (script uses `$REPO` from its path; you’d need to set `HOME` and possibly adjust script to not rely on `$HOME` for critical tools, or use a VM).

See **docs/DEBUG.md** for troubleshooting and more validation steps.
