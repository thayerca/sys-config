# sys-config: Debug & Troubleshooting

Use this when something doesn’t work after install or after pulling changes.

**Quick check:** Run `bash scripts/validate.sh` to verify symlinks and basic config.  
**Full doc index:** [docs/INDEX.md](INDEX.md).

---

## Shell (zsh)

**Prompt or PATH wrong**

- Check that your login shell is zsh: `echo $SHELL` (should be `/bin/zsh` or path to zsh). Change with: `chsh -s $(which zsh)`.
- Ensure `~/.zprofile` and `~/.zshrc` are symlinks into the repo: `ls -la ~/.zshrc ~/.zprofile`. If they’re not, re-run setup or fix symlinks manually.
- Reload config: `source ~/.zshrc` (or open a new terminal).

**Starship not loading / default prompt**

- Starship looks for `~/.config/starship.toml`. Confirm: `ls -la ~/.config/starship.toml` (should point to repo). If missing, run setup again or: `ln -sf "$REPO/starship/starship.toml" ~/.config/starship.toml`.
- Check: `type starship` and `starship --version`.

**FZF key bindings not working**

- Setup symlinks `~/.fzf` to `repo/fzf/.fzf` so that `~/.fzf/key-bindings.zsh` exists. Check: `[[ -f ~/.fzf/key-bindings.zsh ]] && echo ok`.
- In .zshrc we source that file; if you moved the repo, re-run setup so symlinks use the new path.

**Duplicate or slow startup**

- Grep for duplicate inits: `grep -n "starship init\|brew shellenv" ~/.zshrc`. There should be one of each (or one block). Remove extras.
- If nvm is slow: consider lazy-loading it or using only fnm; see .zshrc comments.

**Trace loading**

- Run with trace: `zsh -x` then look at where it fails or loops.

---

## Tmux

**Plugins not loading / “run '~/.tmux/plugins/tpm/tpm'” errors**

- TPM must be cloned: `ls ~/.tmux/plugins/tpm/tpm`. If missing, run setup again or: `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`.
- After TPM is present, start tmux and press **prefix + I** (capital I) to install plugins. Prefix is **Ctrl-A**.

**Wrong shell inside tmux**

- Tmux uses `default-shell` from .tmux.conf (we set `/bin/zsh`). Check: `tmux show -g default-shell`. If you use a different zsh path, edit `repo/tmux/.tmux.conf` and change `default-shell`.

**Colors look wrong**

- We set `default-terminal "tmux-256color"` and `terminal-overrides ",xterm-256color:Tc"`. If your terminal doesn’t support that, you may need a different TERM or terminfo. Test: run `nvim` in a tmux pane and check if the colorscheme looks right.

**Copy/paste not working**

- Copy-mode: prefix + v, then v to select, y to copy. The tmux-yank plugin sends to system clipboard when possible (OSC52 or external tool). If clipboard still doesn’t work, check your terminal’s clipboard support and tmux-yank docs.

---

## Neovim

**Errors on startup**

- Run: `nvim --headless +"checkhealth" +qa 2>&1`. Fix any red lines (e.g. missing Python provider, clipboard).
- Check for Lua errors: `nvim -V3log /tmp/nvim.log` then inspect `/tmp/nvim.log`.

**Plugins not installing**

- Lazy.nvim should auto-install. Open Neovim and run `:Lazy` to see status; use “Install” or “Update” as needed. Ensure you have git and network.

**Python provider**

- We set `vim.g.python3_host_prog` to `~/.venvs/global/bin/python3`. If that path doesn’t exist, create it: `python3 -m venv ~/.venvs/global && ~/.venvs/global/bin/pip install neovim`. Or point the option to another Python with the neovim package.

**Startup time**

- Measure: `nvim --startuptime /tmp/startup.log +qa` then `tail -20 /tmp/startup.log`. Most time is usually lazy.nvim and plugins; disable or lazy-load heavy ones if needed.

**Keymaps not working**

- Pane/split navigation: <C-h/j/k/l> are set by the vim-tmux-navigator plugin. If they don’t work in tmux, ensure the TPM plugin `christoomey/vim-tmux-navigator` is installed (prefix + I).
- Leader is Space; Telescope: <leader>ff, <leader>fr, etc. See `nvim/lua/cluna/plugins/*.lua` for comments.

---

## Git

**Delta or difftool not working**

- Delta: `git config --global core.pager` should be `delta`. Install with `brew install git-delta` (or your package manager).
- Difftool/mergetool use `nvim` from PATH. Check: `git config --global difftool.nvimdiff.path` (we set `nvim`). Run `which nvim` and ensure it’s on your PATH when you run git.

---

## Setup script

**“Missing required command”**

- Setup checks for `git`, `curl`, `zsh`. Install them and re-run.

**Symlinks point to wrong place**

- Script sets `REPO` from the directory containing the script. If you run from another directory or moved the repo, set `REPO` explicitly: `REPO=/path/to/repo bash /path/to/repo/setup.sh`.

**Oh My Zsh overwrote my .zshrc**

- We pass `KEEP_ZSHRC=yes` and run OMZ after symlinking, so the symlinked .zshrc should be kept. If you already had OMZ installed before and it replaced .zshrc, re-run setup to re-create the symlink.

**Backups**

- Existing dotfiles (when not already symlinks into the repo) are copied to `~/.dotfiles-backup.YYYYMMDD`. To restore: copy from there back to `~/.zshrc` (etc.) and remove the symlink if you want to stop using the repo for that file.

---

## Validation checklist (copy-paste)

Run after install or after big config changes:

```bash
echo "=== Shell ==="
echo $SHELL
type starship
[[ -f ~/.config/starship.toml ]] && echo "starship: linked" || echo "starship: MISSING"
[[ -f ~/.fzf/key-bindings.zsh ]] && echo "fzf: present" || echo "fzf: MISSING"

echo "=== Symlinks ==="
ls -la ~/.zshrc ~/.zprofile ~/.tmux.conf ~/.config/nvim ~/.fzf ~/.config/starship.toml 2>/dev/null || true

echo "=== Git ==="
git config --global core.pager
git config --global difftool.nvimdiff.path 2>/dev/null || true

echo "=== Neovim ==="
nvim --headless +"checkhealth" +qa 2>&1 | tail -30
```

Fix any MISSING or wrong paths using the sections above.
