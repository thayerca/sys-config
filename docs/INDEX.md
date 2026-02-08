# Documentation Index

This folder is the single place for all **human-readable documentation** for sys-config. Each document has a specific purpose; use this index to find the right one.

---

## When to use which doc

| Document | Use when you want to… |
|----------|------------------------|
| **[INSTALL.md](INSTALL.md)** | Install the config on a new machine, understand what gets symlinked, verify the setup, or run clean-room tests. |
| **[DEBUG.md](DEBUG.md)** | Something broke after install or after pulling changes: shell, tmux, Neovim, git, or setup script. Step-by-step fixes and a validation checklist. |
| **[CHEATSHEET.md](CHEATSHEET.md)** | Look up keybindings and commands: Zsh (vi-mode, FZF), Tmux (prefix keybindings, copy mode, plugins), Neovim (leader keymaps, LSP, Telescope, Git, etc.). |
| **[GIT-REBASE.md](GIT-REBASE.md)** | Run an interactive rebase: with Fugitive (`<Space>gr`), LazyGit, or the terminal. Explains pick/reword/squash and continue/abort. |
| **[AUDIT-AND-PLAN.md](AUDIT-AND-PLAN.md)** | Historical audit snapshot (deprecated). Inventory and recommendations are out of date; see repo and [CHEATSHEET.md](CHEATSHEET.md) for current plugins/keymaps. |
| **[TESTING.md](TESTING.md)** | How to run lint (config parse/load) and validate (post-install); optional CI. |

---

## Quick reference

- **Neovim leader:** `<Space>` — see [CHEATSHEET.md](CHEATSHEET.md) for all `<Space>…` bindings.
- **Tmux prefix:** `Ctrl-A` — see [CHEATSHEET.md](CHEATSHEET.md) for all `prefix + …` bindings.
- **Install from scratch:** [INSTALL.md](INSTALL.md) → clone repo → `bash setup.sh` → `exec $SHELL` → tmux: `prefix + I`.
- **Something’s wrong:** [DEBUG.md](DEBUG.md) and/or `bash scripts/validate.sh`.
- **Config checks:** `bash scripts/lint.sh` (before commit); `bash scripts/validate.sh` (after install). See [TESTING.md](TESTING.md).

---

## Repo layout (where config lives)

| Path | What it is |
|------|------------|
| `README.md` | Project overview and quick start (points here). |
| `setup.sh` | One-shot bootstrap: Homebrew, Brewfile, symlinks, Oh My Zsh, fzf, TPM, pyenv. |
| `scripts/validate.sh` | Checks symlinks and basic config; run after install or pull. |
| `scripts/lint.sh` | Checks config syntax/load (zsh, tmux, nvim); run before commit or in CI. |
| `zsh/` | `.zshrc`, `.zprofile`, `aliases.shrc`, `functions.shrc` — shell config (symlinked to `~`). |
| `tmux/.tmux.conf` | Tmux config and TPM plugin list (symlinked to `~/.tmux.conf`). |
| `nvim/` | Neovim config: `init.lua`, `lua/cthayer/` (core + plugins). Symlinked to `~/.config/nvim`. |
| `git-configs/` | `.gitconfig`, `.gitignore_global` (symlinked to `~`). |
| `starship/` | `starship.toml` (symlinked to `~/.config/starship.toml`). |
| `fzf/.fzf/` | FZF key-bindings and widgets; `~/.fzf` symlinks here. |
| `Brewfile` | Homebrew formulas and casks installed by `setup.sh`. |

Config files in this repo are intended to be edited in the repo; symlinks make your home directory use them. After editing, reload as needed (e.g. `source ~/.zshrc`, tmux `prefix + r`, or restart Neovim).
