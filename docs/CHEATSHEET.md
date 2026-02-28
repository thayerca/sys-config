# Cheatsheet — Keymaps & Functions

Quick reference for **Terminal (Zsh)**, **Tmux**, and **Neovim**: keybindings, commands, and how to interact with each part of the config.

| Context | Leader / prefix | Where bindings live |
|---------|-----------------|----------------------|
| **Neovim** | `<Space>` (leader) | `nvim/lua/cthayer/core/keymaps.lua` and each plugin in `nvim/lua/cthayer/plugins/*.lua` |
| **Tmux** | `Ctrl-A` (prefix) | `tmux/.tmux.conf` and TPM plugins |

**Other docs:** [INDEX.md](INDEX.md) (all docs) · [INSTALL.md](INSTALL.md) (install) · [DEBUG.md](DEBUG.md) (troubleshooting)

---

## Terminal (Zsh)

Your shell uses **vi-mode** (Oh My Zsh), **zsh-autosuggestions**, **zsh-autocomplete**, and **FZF**. New panes in tmux start with zsh.

### Vi-mode (Command-line editing)

| Key | Mode | Action |
|-----|------|--------|
| `Esc` or `Ctrl-[` | → Normal | Enter normal (command) mode |
| `i` or `a` | Normal → | Enter insert mode |
| `h` / `j` / `k` / `l` | Normal | Move cursor left/down/up/right |
| `w` / `b` | Normal | Next/previous word |
| `0` / `$` | Normal | Start/end of line |
| `^` | Normal | First non-blank of line |
| `gg` / `G` | Normal | Start/end of history |
| `x` | Normal | Delete char under cursor |
| `dd` | Normal | Delete entire line |
| `y` / `p` | Normal | Yank (copy) / put (paste) |
| `u` | Normal | Undo |
| `/` | Normal | Search history backward |
| `n` / `N` | Normal | Next/prev search result |

### Zsh-autosuggestions

| Key | Action |
|-----|--------|
| `→` (Right) or `End` | Accept suggestion (when cursor at end) |

### FZF (Fuzzy find — runs in tmux split when in tmux)

| Key | Action |
|-----|--------|
| `Ctrl-R` | Search command history, insert result |
| `Ctrl-E` | FZF file picker |
| `Alt-c` | FZF cd (change directory) |
| `Ctrl-O` | FZF launcher (files, dirs, history) |

### Insert-mode (when typing)

| Key | Action |
|-----|--------|
| `Ctrl-A` | Jump to line start |
| `Ctrl-E` | Jump to line end |
| `Ctrl-U` | Kill to line start |
| `Ctrl-K` | Kill to line end |
| `Ctrl-W` | Kill word before cursor |

### Completion & tools

- **Tab:** zsh-autocomplete — tab-complete commands, args, paths
- **kubectl, gcloud, pyenv:** Shell completions enabled
- **direnv:** Auto-loads `.envrc` in directories (use `da` to allow)
- **pyenv / fnm / nvm:** Python and Node version switching

---

## Tmux

**Prefix:** `Ctrl-A` (replaces default `Ctrl-B`)

### Sessions

| Key | Action |
|-----|--------|
| `prefix + d` | Detach from session |
| `prefix + s` | List sessions (switch) |
| `prefix + $` | Rename session |
| `prefix + F` | tmux-fzf: session, window, pane, command, keybinding, clipboard, process |

### Windows

| Key | Action |
|-----|--------|
| `prefix + c` | Create new window |
| `prefix + n` | Next window |
| `prefix + p` | Previous window |
| `prefix + 0-9` | Go to window 0–9 |
| `prefix + ,` | Rename current window |
| `prefix + &` | Kill current window |
| `prefix + w` | List windows (interactive) |

### Panes

| Key | Action |
|-----|--------|
| `prefix + \|` | Split vertical |
| `prefix + -` | Split horizontal |
| `prefix + h/j/k/l` | Move focus (vim-style) |
| `prefix + o` | Next pane |
| `prefix + ;` | Toggle last pane |
| `prefix + x` | Kill pane |
| `prefix + z` | Zoom pane (toggle) |
| Mouse | Click to focus; drag to resize |

### Copy mode (scrollback & copy)

| Key | Action |
|-----|--------|
| `prefix + v` | Enter copy mode |
| `v` | Start selection |
| `y` | Yank selection to clipboard (tmux-yank) |
| `Y` | Put (paste) from buffer |
| `Esc` or `q` | Exit copy mode |
| In copy mode: `h/j/k/l`, `/`, `n`, `N` | Vim-style navigation/search |

### tmux-yank (clipboard)

| Key | Action |
|-----|--------|
| `prefix + Y` | Yank current pane's working directory |
| Copy-mode `y` | Selection → system clipboard |

### TPM (plugin manager)

| Key | Action |
|-----|--------|
| `prefix + I` | Install plugins |
| `prefix + U` | Update plugins |
| `prefix + Alt-u` | Clean/uninstall plugins |

### Config & state

| Key | Action |
|-----|--------|
| `prefix + r` | Reload tmux config |
| `prefix + Ctrl-s` | Save session (tmux-resurrect) |
| `prefix + Ctrl-r` | Restore session (tmux-resurrect) |

### Misc

- **Mouse:** Enabled — click panes, scroll in copy mode
- **tmux-continuum:** Auto-save every 15 min; auto-restore on tmux start
- **vim-tmux-navigator:** `Ctrl-h/j/k/l` work across tmux panes and Neovim splits (no prefix)

---

## Neovim

### Core motions & editing (normal mode)

| Key | Action |
|-----|--------|
| `h` / `j` / `k` / `l` | Move left/down/up/right |
| `w` / `b` / `e` | Next/prev word, end of word |
| `0` / `^` / `$` | Line start, first char, line end |
| `gg` / `G` | File start/end |
| `Ctrl-u` / `Ctrl-d` | Half screen up/down |
| `Ctrl-b` / `Ctrl-f` | Page up/down |
| `%` | Match bracket |
| `*` / `#` | Next/prev word under cursor |
| `/` / `?` | Search forward/backward; `n` / `N` next/prev |
| `d` / `y` / `c` + motion | Delete, yank, change |
| `dd` / `yy` / `cc` | Line delete, yank, change |
| `u` / `Ctrl-r` | Undo / redo |
| `v` / `V` / `Ctrl-v` | Visual char/line/block |
| `o` (visual) | Toggle selection end |

### General

| Key | Action |
|-----|--------|
| `jk` | Exit insert mode (alternative to Escape) |
| `<Space>nh` | Clear search highlights |
| `<Space>+` | Increment number under cursor |
| `<Space>-` | Decrement number under cursor |

### Pane / Split Navigation (also works across Tmux)

| Key | Action |
|-----|--------|
| `Ctrl-h` | Move focus left |
| `Ctrl-j` | Move focus down |
| `Ctrl-k` | Move focus up |
| `Ctrl-l` | Move focus right |

### Window & Split Management

| Key | Action |
|-----|--------|
| `<Space>sv` | Split window vertically |
| `<Space>sh` | Split window horizontally |
| `<Space>se` | Equalize split dimensions |
| `<Space>sx` | Close current split |
| `<Space>sm` | Maximize/minimize current split |

### Tabs

| Key | Action |
|-----|--------|
| `<Space>to` | Open new tab |
| `<Space>tx` | Close current tab |
| `<Space>tn` | Go to next tab |
| `<Space>tp` | Go to previous tab |
| `<Space>tf` | Open current buffer in new tab |

### Telescope (Find & Search)

| Key | Action |
|-----|--------|
| `<Space>ff` | Fuzzy find files |
| `<Space>fr` | Recent files |
| `<Space>fs` | Live grep (find string in cwd) |
| `<Space>fc` | Find word under cursor |
| `<Space>ft` | Find TODO/FIXME comments |
| `<Space>fe` | File browser |
| `<Space>fp` | Switch projects |

### Harpoon (Pin Files)

| Key | Action |
|-----|--------|
| `<Space>a` | Add file to harpoon |
| `<Space>1` | Jump to file 1 |
| `<Space>2` | Jump to file 2 |
| `<Space>3` | Jump to file 3 |
| `<Space>4` | Jump to file 4 |
| `<Space>hm` | Harpoon menu |

### Neo-tree (File Explorer)

| Key | Action |
|-----|--------|
| `<Space>ee` | Filesystem (float) |
| `<Space>bf` | Buffers (float) |
| `<Space>eg` | Git status (float) |

### Oil (Edit Directory as Buffer)

| Key | Action |
|-----|--------|
| `<Space>o` | Edit current directory as buffer (rename, create, delete files) |

### Flash (Jump to Label)

| Key | Action |
|-----|--------|
| `<Space>j` | Jump to any visible position via labels (n/x/o modes) |

### Git — Fugitive & Gitsigns

| Key | Action |
|-----|--------|
| `<Space>gs` | Git status |
| `<Space>gd` | Git diff (vertical) |
| `<Space>gD` | Git diff (horizontal) |
| `<Space>gb` | Git blame |
| `<Space>gh` | Git commit log (file) |
| `<Space>lg` | Open LazyGit (repo) |
| `<Space>lG` | Open LazyGit (current file) |
| `<Space>lC` | Edit LazyGit config |
| `]h` / `[h` | Next/previous hunk |
| `<Space>hs` | Stage hunk |
| `<Space>hr` | Reset hunk |
| `<Space>hS` | Stage buffer |
| `<Space>hR` | Reset buffer |
| `<Space>hu` | Undo stage hunk |
| `<Space>hp` | Preview hunk |
| `<Space>hb` | Blame line (full) |
| `<Space>hB` | Toggle line blame |
| `<Space>hd` | Diff this |
| `<Space>hD` | Diff with ~ |
| `ih` (text object) | Select hunk |

### LSP

| Key | Action |
|-----|--------|
| `gD` | Go to declaration |
| `gd` | LSP definitions |
| `gi` | LSP implementations |
| `gt` | LSP type definitions |
| `gR` | LSP references |
| `K` | Hover |
| `<Space>ca` | Code actions |
| `<Space>rn` | Rename (inline preview) |
| `<Space>d` | Line diagnostics |
| `<Space>D` | Buffer diagnostics |
| `[d` / `]d` | Prev/next diagnostic |
| `<Space>rs` | Restart LSP |
| `<Space>uh` | Toggle inlay hints |
| `:Mason` | Open Mason (LSP/formatter installer) |

### Trouble (Diagnostics & Lists)

| Key | Action |
|-----|--------|
| `<Space>xx` | Toggle diagnostics |
| `<Space>xw` | Open workspace diagnostics |
| `<Space>xd` | Open document diagnostics |
| `<Space>xq` | Quickfix list |
| `<Space>xl` | Location list |
| `<Space>xt` | Todo comments in Trouble |
| `<Space>xr` | LSP references |

### Formatting

| Key | Action |
|-----|--------|
| `<Space>mp` | Format buffer or selection (conform, manual) |
| `<Space>gf` | Format file (LSP / null-ls) |

### Refactoring (visual mode for extract)

| Key | Action |
|-----|--------|
| `<Space>re` | Extract function (visual) |
| `<Space>rv` | Extract variable (visual) |
| `<Space>ri` | Inline variable (normal) |
| `<Space>rM` | Refactoring menu |

### Substitute (replace with motion)

| Key | Action |
|-----|--------|
| `s` + motion | Substitute with motion |
| `ss` | Substitute entire line |
| `S` | Substitute to end of line |
| `s` (visual) | Substitute selection |

### Comment

| Key | Action |
|-----|--------|
| `gcc` | Toggle line comment |
| `gbc` | Toggle block comment |
| `gc` + motion | Comment lines |
| `gb` + motion | Comment block |
| `gco` | Add comment above |
| `gcO` | Add comment below |
| `gcA` | Add comment at end of line |

### Surround (nvim-surround)

| Key | Action |
|-----|--------|
| `ys` + motion + char | Add surround |
| `cs` + old + new | Change surround |
| `ds` + char | Delete surround |
| e.g. `ysiw"` | Wrap word in double quotes |
| e.g. `cs"'` | Change `"` to `'` |

### Treesitter (incremental selection & text objects)

| Key | Action |
|-----|--------|
| `Ctrl-Space` | Init/expand selection (node) |
| `Backspace` | Shrink selection |
| `af` / `if` | Around/inner function |
| `ac` / `ic` | Around/inner class |
| `ab` / `ib` | Around/inner block |
| `]f` / `[f` | Next/prev function start |
| `]F` / `[F` | Next/prev function end |
| `]c` / `[c` | Next/prev class start |
| `]C` / `[C` | Next/prev class end |

### Todo Comments

| Key | Action |
|-----|--------|
| `]t` / `[t` | Next/previous TODO/FIXME |

### Undo Tree

| Key | Action |
|-----|--------|
| `<Space>uu` | Toggle undotree |

### Terminal

| Key | Action |
|-----|--------|
| `<Space>tt` | Toggle floating terminal |

### Alpha (Startup Dashboard)

| Key | Action |
|-----|--------|
| `e` | New file |
| `f` | Find file |
| `r` | Recent files |
| `c` | Open config |
| `q` | Quit |

### Claude Code (claudecode.nvim)

Requires [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) (`claude doctor`).

| Key | Action |
|-----|--------|
| `<Space>c` | Claude Code (group) |
| `<Space>cc` | Toggle Claude |
| `<Space>cf` | Focus Claude |
| `<Space>cw` | Switch to other window (editor ↔ Claude) |
| `Alt-w` | From Claude terminal input: switch to editor |
| `<Space>cr` | Resume Claude |
| `<Space>cC` | Continue Claude |
| `<Space>cm` | Select Claude model |
| `<Space>cb` | Add current buffer to Claude |
| `<Space>cs` | Send selection (visual); in neo-tree/oil: add file |
| `<Space>cA` | Accept diff |
| `<Space>cd` | Deny diff |

### Misc

| Key | Action |
|-----|--------|
| `<Space>z` | Toggle NoNeckPain (center buffer) |
| `<Space>?` | Show buffer-local keymaps (which-key) |

### Completion (Insert Mode)

| Key | Action |
|-----|--------|
| `Ctrl-Space` | Trigger completion |
| `Ctrl-k` / `Ctrl-j` | Prev/next item |
| `Ctrl-b` / `Ctrl-f` | Scroll docs |
| `Ctrl-e` | Abort completion |
| `Enter` | Confirm selection |

---

## Shell aliases & commands

Commands you type (from `aliases.shrc` and `functions.shrc`).

### Navigation

| Alias | Command |
|-------|---------|
| `...` | `cd ../..` |
| `cdh` | `cd $HOME` |
| `cdm` | `cd $HOME/ct` |
| `cdc` | `cd $HOME/ct/sys-config` |
| `pie` | `cd $HOME/phillies/pie` |
| `terraform` | `cd $HOME/phillies/terraform` |

### Editor

| Alias | Command |
|-------|---------|
| `vim` / `vv` | `nvim` |

### Shell

| Alias | Command |
|-------|---------|
| `c` | `clear` |
| `xx` | `exit` |
| `rsh` | `exec $SHELL` |
| `sz` | `source ~/.zshrc` |

### File Listing

| Alias | Command |
|-------|---------|
| `ls` | `eza -l --icons` |
| `ll` | `eza -l -a --icons` |
| `cat` | `bat` |

### Git

| Alias | Command |
|-------|---------|
| `g` | `git` |
| `ga` | `git add` |
| `gc` / `gm` | `git commit -m` |
| `gp` | `git push` |
| `gl` | `git log --oneline` |
| `gst` | `git status` |
| `gd` | `git diff` |
| `gdc` | `git diff --cached` |
| `gma` | `git commit -am` |
| `gb` | `git branch` |
| `gco` | `git checkout` |
| `gpu` | `git pull` |
| `gf` | `git fetch` |
| `gcl` | `git clone` |
| `gra` | `git remote add` |
| `grr` | `git remote rm` |
| `gcpr` | `gh pr create -w` |
| `gsync` | `git checkout main && git pull --rebase && git fetch --prune` |
| `glom` | `git pull origin main` |
| `lg` | `lazygit` |

### Docker

| Alias | Command |
|-------|---------|
| `dkps` | `docker ps` |
| `dkpsa` | `docker ps -a` |
| `dkimgs` | `docker images` |
| `dkst` | `docker stats` |
| `dkl` | `docker logs -f` |
| `dke` | `docker exec -it` |
| `dkclean` | `docker rm $(docker ps -aq)` |
| `dk-up` | `docker-compose up -d` |
| `dk-down` | `docker-compose down` |
| `dk-start` / `dk-stop` | Start/stop compose |
| `dk-clean` | `docker system prune -a --volumes` |

### Kubernetes

| Alias/Function | Command |
|----------------|---------|
| `kgp` | `kubectl get pods` |
| `kgj` | `kubectl get jobs` |
| `kjr` | `kubectl get jobs \| grep Running` |
| `kjf` | `kubectl get jobs \| grep Failed` |
| `ka <file>` | `kubectl apply -f <file>` |
| `kdj <job>` | `kubectl delete job <job>` |

### Python

| Alias | Command |
|-------|---------|
| `python` / `pip` | `python3` / `pip3` |
| `uvp` | `uv pip install -r pyproject.toml` |
| `uvr` | `uv pip uninstall -y -r <(uv pip freeze)` |

### Direnv

| Alias | Command |
|-------|---------|
| `da` | `direnv allow` |
| `dr` | `direnv reload` |

### R

| Alias | Command |
|-------|---------|
| `R` | `R --no-restore-data --no-save` |
| `r` | `radian` |

### Terraform

| Alias | Command |
|-------|---------|
| `tf` | `./terraform.sh` |

### DuckDB

| Alias | Command |
|-------|---------|
| `duckdb` | Launch DuckDB CLI |

### System / Network

| Alias | Command |
|-------|---------|
| `ports` | `lsof -i -P -n \| grep LISTEN` |
| `ip` | `curl ifconfig.me` |
| `devip` | `ipconfig getifaddr en0` |

---

## Shell Functions

### GCP

| Function | Description |
|----------|-------------|
| `gcpp` | Interactively switch gcloud config via fzf |

### Git

| Function | Description |
|----------|-------------|
| `glogone [n]` | Show last N commits (default 10) in oneline format |
| `delete_branches` | Interactively delete local branches (prompts each) |

### BigQuery / GCP Data

| Function | Description |
|----------|-------------|
| `query-gcp "SQL"` | Run BigQuery query with dry-run cost confirmation |
| `bigquery` | Open BigQuery console for current GCP project |

### Cloud SQL Proxy (Phillies)

| Function | Description |
|----------|-------------|
| `phil-db-up <name>` | Start proxy and connect to MySQL (e.g. `prod`, `biomech`) |
| `phil-db-up --all` | Start proxies for prod + biomech |
| `phil-db-switch` | Switch MySQL connection to another instance socket |
| `phil-db-status` | Show proxy PIDs and active sockets |
| `phil-db-down` | Stop proxies and clean socket files |

### Logging (from functions.shrc)

| Function | Description |
|----------|-------------|
| `log_info "msg"` | Blue INFO log |
| `log_warn "msg"` | Yellow WARN log |
| `log_error "msg"` | Red ERROR log |
| `log_ok "msg"` | Green OK log |
| `log_prompt "msg"` | Yellow PROMPT log |

---

## Tips

- **Neovim:** Press `<Space>` and wait — which-key shows available keymaps for that prefix.
- **Buffer-local keymaps:** `<Space>?` shows keymaps for the current buffer (e.g. LSP, gitsigns).
- **Forgot a keymap?** Check which-key groups: `<Space>f` (file), `<Space>g` (git), `<Space>h` (gitsigns), etc.
- **Tmux + Neovim:** `Ctrl-h/j/k/l` work across both — no prefix needed in Neovim splits.
- **Tmux:** `prefix + ?` lists every keybinding.
- **Terminal:** In vi-mode, press `Esc` to edit the line with vim keys; `i` or `a` to type again.
