# sys-config

Dotfiles and bootstrap for **zsh**, **tmux**, **Neovim**, **git**, and **Starship**.  
Designed so you can **clone the repo and run one script** to get a working setup on a new machine.

---

## Quick start

```bash
git clone <this-repo> ~/sys-config
cd ~/sys-config
bash setup.sh
exec $SHELL
```

Then start **tmux** and press **Ctrl-A**, then **I** (capital I) to install tmux plugins.

| Next step | Where to look |
|-----------|----------------|
| Full install steps, symlinks, verification | [docs/INSTALL.md](docs/INSTALL.md) |
| Something broke | [docs/DEBUG.md](docs/DEBUG.md) |
| All keybindings and commands | [docs/CHEATSHEET.md](docs/CHEATSHEET.md) |
| **All docs in one place** | [docs/INDEX.md](docs/INDEX.md) |

**Validation:** `bash scripts/validate.sh` (after install). **Lint (before commit):** `bash scripts/lint.sh`. See [docs/TESTING.md](docs/TESTING.md).

---

## What’s in the repo

| Area | What it does | How you interact |
|------|----------------|------------------|
| **Shell** | zsh (`.zshrc`, `.zprofile`), aliases, functions | Edit files in `zsh/`; symlinks from `~`. Reload: `source ~/.zshrc`. |
| **Prompt** | Starship (`starship.toml`) | Config: `starship/starship.toml`. Optional Powerlevel10k in `powerline/`. |
| **Tmux** | Sessions, panes, copy mode, TPM plugins (Catppuccin, resurrect, continuum, fzf, yank, vim-tmux-navigator) | Config: `tmux/.tmux.conf`. Prefix: **Ctrl-A**. Reload: prefix + `r`. Install plugins: prefix + `I`. |
| **Neovim** | Full Lua config: options, keymaps, lazy.nvim, LSP (Mason), Telescope, Git (Fugitive, gitsigns, LazyGit), etc. | Config: `nvim/`. Leader: **Space**. See [docs/CHEATSHEET.md](docs/CHEATSHEET.md) for keymaps. |
| **Git** | Global `.gitconfig` (delta, nvim difftool/mergetool), `.gitignore_global` | Config: `git-configs/`. Commands: `git diff`, `git difftool`, etc. |
| **Bootstrap** | `setup.sh`: Homebrew, Brewfile, symlinks, Oh My Zsh, fzf, TPM, pyenv | Run once per machine (or after cloning elsewhere). See [docs/INSTALL.md](docs/INSTALL.md). |

---

## Documentation (full index)

All documentation lives under **docs/** and is listed in **[docs/INDEX.md](docs/INDEX.md)** with a short description and “when to use” for each file:

- **[docs/INSTALL.md](docs/INSTALL.md)** — Prerequisites, install steps, symlink table, verification, clean-room testing.
- **[docs/DEBUG.md](docs/DEBUG.md)** — Troubleshooting shell, tmux, Neovim, git, setup script; validation checklist.
- **[docs/CHEATSHEET.md](docs/CHEATSHEET.md)** — Keymaps and commands for Zsh, Tmux, and Neovim (comprehensive).
- **[docs/GIT-REBASE.md](docs/GIT-REBASE.md)** — Interactive rebase with Fugitive, LazyGit, or terminal.
- **[docs/TESTING.md](docs/TESTING.md)** — Lint and validate scripts; optional CI.
- **[docs/AUDIT-AND-PLAN.md](docs/AUDIT-AND-PLAN.md)** — Historical audit (deprecated; see INDEX for current docs).

---

## Optional follow-ups

- **Reorganize:** Optional future layout could use `config/`, `scripts/`, `docs/` more explicitly.
- **macOS defaults / fonts:** Optional scripts or docs (not included yet).
- **More plugins:** Add Neovim plugins under `nvim/lua/cthayer/plugins/`, tmux plugins in `tmux/.tmux.conf`. Keymaps are in [docs/CHEATSHEET.md](docs/CHEATSHEET.md).
