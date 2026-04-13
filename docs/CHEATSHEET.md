# Cheatsheet — Keymaps & Commands

Quick reference for every tool in this config. Press `<Space>` in Neovim and pause — which-key shows all available keymaps for that prefix.

| Context | Leader / prefix | Source |
|---------|-----------------|--------|
| **Neovim** | `<Space>` | `nvim/lua/cluna/plugins/*.lua` |
| **Tmux** | `Ctrl-A` | `tmux/.tmux.conf` |

---

## Terminal (Zsh)

### Navigation
| Key / Alias | Action |
|-------------|--------|
| `z <partial>` | Jump to frecent directory (zoxide) |
| `zi` | Interactive directory picker (zoxide + fzf) |
| `Tab` | fzf-powered completion popup |
| `Ctrl-R` | Atuin history search (fuzzy, synced) |
| `...` | `cd ../..` |
| `cdh` / `cdm` / `cdc` | Home / `~/ct` / sys-config |
| `pie` | `~/phillies/pie` |

### Shell aliases (quick reference)
| Alias | Expands to |
|-------|-----------|
| `vim` / `vv` | `nvim` |
| `c` | `clear` |
| `xx` | `exit` |
| `rsh` | `exec $SHELL` (reload shell) |
| `sz` | `source ~/.zshrc` |
| `ls` / `ll` | `eza -l --icons` / `eza -l -a --icons` |
| `cat` | `bat` (syntax-highlighted cat) |
| `lg` | `lazygit` |
| `g` / `ga` / `gc` / `gp` | `git` / `add` / `commit -m` / `push` |
| `gst` / `gd` / `gco` | `status` / `diff` / `checkout` |
| `gsync` | `checkout main && pull --rebase && fetch --prune` |
| `gcpr` | `gh pr create -w` |
| `da` / `dr` | `direnv allow` / `direnv reload` |
| `dev` | Start dev tmux session (nvim + terminal + Claude) |

### Shell functions
| Function | Description |
|----------|-------------|
| `glogone [n]` | Last N commits one-line (default 10) |
| `delete_branches` | Interactively delete local branches |
| `gcpp` | Switch gcloud config via fzf |
| `query-gcp "SQL"` | Run BigQuery query with dry-run cost prompt |

### Vi-mode (command-line editing)
| Key | Action |
|-----|--------|
| `Esc` | Enter normal mode |
| `i` / `a` | Back to insert mode |
| `w` / `b` | Word forward/back |
| `0` / `$` | Line start/end |
| `dd` | Delete line |
| `/` | Search history |
| `Ctrl-A` / `Ctrl-E` | Line start/end (insert mode) |
| `Ctrl-W` | Delete word before cursor |
| `→` / `End` | Accept autosuggestion |

---

## Tmux

**Prefix:** `Ctrl-A`

### Sessions & windows
| Key | Action |
|-----|--------|
| `prefix + d` | Detach |
| `prefix + s` | List/switch sessions |
| `prefix + $` | Rename session |
| `prefix + c` | New window |
| `prefix + n` / `p` | Next/prev window |
| `prefix + 0–9` | Go to window N |
| `prefix + ,` | Rename window |
| `prefix + w` | Window list (interactive) |
| `prefix + F` | tmux-fzf (sessions, windows, panes, commands) |

### Panes
| Key | Action |
|-----|--------|
| `prefix + \|` | Split right |
| `prefix + -` | Split down |
| `prefix + h/j/k/l` | Move focus (vim-style) |
| `Ctrl-h/j/k/l` | Move across tmux panes **and** Neovim splits (no prefix) |
| `prefix + z` | Zoom pane (toggle fullscreen) |
| `prefix + x` | Kill pane |
| Mouse | Click to focus; drag border to resize |

### Copy mode
| Key | Action |
|-----|--------|
| `prefix + v` | Enter copy mode |
| `v` | Start visual selection |
| `y` | Yank to clipboard |
| `h/j/k/l`, `/`, `n/N` | Vim-style navigation |
| `q` / `Esc` | Exit copy mode |

### tmux-sessionizer
| Key / Command | Action |
|---------------|--------|
| `prefix + f` | Open project picker (fzf over `~/ct`, `~/phillies`, `~`) |
| `tmux-sessionizer <path>` | Create/attach session for that directory |

### TPM & config
| Key | Action |
|-----|--------|
| `prefix + I` | Install plugins |
| `prefix + U` | Update plugins |
| `prefix + r` | Reload config |
| `prefix + Ctrl-s` / `Ctrl-r` | Save / restore session (resurrect) |

---

## Neovim

**Leader:** `<Space>`  
**Tip:** Press `<Space>?` for buffer-local keymaps; press any group prefix and wait for which-key popup.

### Core editing
| Key | Action |
|-----|--------|
| `jk` | Exit insert mode |
| `<Space>nh` | Clear search highlights |
| `<Space>+` / `<Space>-` | Increment / decrement number |
| `u` / `Ctrl-r` | Undo / redo |
| `<Space>uu` | Toggle undotree (visual undo history) |

### Splits & tabs
| Key | Action |
|-----|--------|
| `<Space>sv` / `sh` | Split vertical / horizontal |
| `<Space>se` / `sx` | Equalize / close split |
| `<Space>sm` | Maximize/restore split |
| `Ctrl-h/j/k/l` | Navigate splits (works across tmux too) |
| `<Tab>` / `<S-Tab>` | Next / previous tab (bufferline) |
| `<Space>to` / `tx` | New tab / close tab |
| `<Space>tn` / `tp` | Next / prev tab |
| `<Space>tf` | Open current buffer in new tab |

### File navigation
| Key | Action |
|-----|--------|
| `<Space>ff` | Find files (Telescope) |
| `<Space>fr` | Recent files |
| `<Space>fs` | Live grep |
| `<Space>fc` | Find word under cursor |
| `<Space>ft` | Find TODO/FIXME comments |
| `<Space>fb` | List open buffers |
| `<Space>fg` | Git files |
| `<Space>ee` | File explorer (Neo-tree, float) |
| `<Space>eg` | Git status tree |
| `<Space>o` | Edit directory as buffer (Oil — rename/create/delete) |

### Harpoon (pin files)
| Key | Action |
|-----|--------|
| `<Space>a` | Add file to harpoon |
| `<Space>hm` | Open harpoon menu |
| `<Space>1–4` | Jump to pinned file 1–4 |

### Jump navigation
| Key | Action |
|-----|--------|
| `<Space>j` | Flash: jump to visible position via labels |
| `s` + motion | Substitute with motion (replaces `s`) |
| `ss` | Substitute entire line |
| `S` | Substitute to end of line |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gt` | Go to type definition |
| `gR` | Show references |
| `K` | Hover docs |
| `<Space>ca` | Code action |
| `<Space>rn` | Rename symbol (inline preview) |
| `<Space>rs` | Restart LSP |
| `<Space>uh` | Toggle inlay hints |
| `[d` / `]d` | Previous / next diagnostic |
| `<Space>d` | Line diagnostics popup |
| `<Space>ra` | Aerial: toggle symbol outline |
| `<Space>rA` | Aerial: fuzzy symbol search (Telescope) |
| `:Mason` | Open tool installer |

### Diagnostics & Trouble
| Key | Action |
|-----|--------|
| `<Space>xx` | Toggle Trouble (diagnostics panel) |
| `<Space>xw` | Workspace diagnostics |
| `<Space>xd` | Document diagnostics |
| `<Space>xq` | Quickfix list |
| `<Space>xl` | Location list |
| `<Space>xt` | TODO comments |

### Git — Fugitive
| Key | Action |
|-----|--------|
| `<Space>gs` | Git status (`:G`) |
| `<Space>gv` | Diff working tree vs index (vertical split) |
| `<Space>gD` | Diff working tree vs index (horizontal split) |
| `<Space>gb` | Git blame |
| `<Space>gL` | File commit log (`:0Gclog`) |
| `<Space>gr` | Interactive rebase (type branch + Enter) |

### Git — Diffview
| Key | Action |
|-----|--------|
| `<Space>gd` | Open diff vs HEAD (full UI) |
| `<Space>gh` | File history for current buffer |
| `<Space>gH` | Repo-wide file history |
| `<Space>gc` | Close diffview |

### Git — Gitsigns (hunk operations)
| Key | Action |
|-----|--------|
| `]h` / `[h` | Next / prev hunk |
| `<Space>hs` | Stage hunk |
| `<Space>hr` | Reset hunk |
| `<Space>hS` | Stage entire buffer |
| `<Space>hR` | Reset entire buffer |
| `<Space>hu` | Undo stage hunk |
| `<Space>hp` | Preview hunk inline |
| `<Space>hb` | Blame line (full commit info) |
| `<Space>hB` | Toggle inline blame |
| `<Space>hd` | Diff this hunk |
| `ih` | Text object: select hunk (use with `d`, `y`, `c`) |

### Git — LazyGit
| Key | Action |
|-----|--------|
| `<Space>lg` | Open LazyGit (full repo) |
| `<Space>lG` | Open LazyGit (current file) |
| `<Space>lC` | Edit LazyGit config |

### Git — Octo (GitHub PRs & issues in Neovim)
| Key | Action |
|-----|--------|
| `<Space>go` | List PRs |
| `<Space>gi` | List issues |
| `<Space>gR` | Start review |
| **Inside PR buffers:** | |
| `<Space>po` | Checkout PR |
| `<Space>pm` / `pM` | Merge / squash-merge |
| `<Space>pd` | Show diff |
| `<Space>pf` | List changed files |
| `<Space>pc` | List commits |
| `<Space>pv` / `pV` | Add / remove reviewer |
| `<Space>px` / `pO` | Close / reopen PR |
| `<Space>pu` / `pb` | Copy URL / open in browser |
| **Inside issue buffers:** | |
| `<Space>ix` / `io` | Close / reopen issue |
| `<Space>il` | List repo issues |
| `<Space>ia` | Add assignee |
| `<Space>iL` | Add label |
| `<Space>iu` / `ib` | Copy URL / open in browser |
| **Review threads:** | |
| `<Space>ca` | Add comment |
| `<Space>vs` | Submit review |
| `<Space>va` / `vr` | Approve / request changes |

### Yanky (yank ring)
| Key | Action |
|-----|--------|
| `p` / `P` | Paste after / before (enhanced, adds to ring) |
| `<C-n>` / `<C-p>` | After pasting: cycle forward / back through yank ring |
| `y` | Yank (adds to ring) |
| `<Space>fy` | Telescope yank history picker |

### Session management (Persistence)
| Key | Action |
|-----|--------|
| `<Space>qs` | Restore session for current directory |
| `<Space>ql` | Restore last session (any directory) |
| `<Space>qd` | Delete / stop saving session |
| `<Space>qq` | Quit without saving session |

### Find & replace (Spectre)
| Key | Action |
|-----|--------|
| `<Space>S` | Open Spectre (project-wide find/replace) |
| `<Space>sw` | Search word under cursor across project |
| `<Space>sw` (visual) | Search selected text |
| `<Space>sf` | Search in current file only |

### Debugging (nvim-dap)
| Key | Action |
|-----|--------|
| `<Space>db` | Toggle breakpoint |
| `<Space>dB` | Conditional breakpoint (prompts for expression) |
| `<Space>dc` | Continue / start debug session |
| `<Space>dn` | Step over |
| `<Space>di` | Step into |
| `<Space>do` | Step out |
| `<Space>dr` | Open REPL |
| `<Space>dl` | Run last debug config |
| `<Space>du` | Toggle DAP UI panels |
| `<Space>de` | Evaluate expression (normal or visual) |
| `<Space>dx` | Terminate session |

### Testing (Neotest)
| Key | Action |
|-----|--------|
| `<Space>Tr` | Run nearest test |
| `<Space>TT` | Run all tests in file |
| `<Space>Ts` | Toggle test summary panel |
| `<Space>To` | Show output for nearest test |
| `<Space>TO` | Toggle output panel |
| `<Space>Td` | Debug nearest test (uses DAP) |
| `<Space>Tx` | Stop running tests |

### Formatting
| Key | Action |
|-----|--------|
| `<Space>mp` | Format buffer / selection (conform, manual) |
| `<Space>gf` | Format file (LSP / null-ls) |
| *(auto)* | Format on save (conform) |

### Refactoring
| Key | Action |
|-----|--------|
| `<Space>re` | Extract function (visual) |
| `<Space>rv` | Extract variable (visual) |
| `<Space>ri` | Inline variable |
| `<Space>rM` | Refactoring menu |

### Comments
| Key | Action |
|-----|--------|
| `gcc` | Toggle line comment |
| `gbc` | Toggle block comment |
| `gc` + motion | Comment range |
| `gco` / `gcO` | Add comment above / below |
| `gcA` | Append comment at end of line |

### Surround
| Key | Action |
|-----|--------|
| `ys` + motion + char | Add surround (e.g. `ysiw"` → `"word"`) |
| `cs` + old + new | Change surround (e.g. `cs"'`) |
| `ds` + char | Delete surround |

### Treesitter text objects
| Key | Action |
|-----|--------|
| `Ctrl-Space` | Expand selection to node |
| `Backspace` | Shrink selection |
| `af` / `if` | Around / inner function |
| `ac` / `ic` | Around / inner class |
| `ab` / `ib` | Around / inner block |
| `]f` / `[f` | Next / prev function |
| `]c` / `[c` | Next / prev class |

### Completion (insert mode)
| Key | Action |
|-----|--------|
| `Ctrl-Space` | Trigger completion |
| `Ctrl-k` / `Ctrl-j` | Prev / next item |
| `Ctrl-b` / `Ctrl-f` | Scroll docs |
| `Ctrl-e` | Abort |
| `Enter` | Confirm |

### Claude Code
| Key | Action |
|-----|--------|
| `<Space>cc` | Toggle Claude panel |
| `<Space>cf` | Focus Claude |
| `Alt-w` | Switch editor ↔ Claude (works from either side) |
| `<Space>cr` | Resume last Claude session |
| `<Space>cC` | Continue Claude |
| `<Space>cm` | Select model |
| `<Space>cb` | Add current buffer to Claude |
| `<Space>cs` (visual) | Send selection to Claude |
| `<Space>cs` (neo-tree/oil) | Add file to Claude |
| `<Space>cA` / `cd` | Accept / deny diff |

### Misc
| Key | Action |
|-----|--------|
| `<Space>?` | Show buffer-local keymaps (which-key) |
| `<Space>z` | Toggle NoNeckPain (center buffer) |
| `<Space>tt` | Toggle floating terminal |
| `]t` / `[t` | Next / prev TODO comment |
| `<Space>uu` | Toggle undotree |

### Alpha dashboard (startup)
| Key | Action |
|-----|--------|
| `n` | New file |
| `e` | File explorer |
| `f` / `F` | Find file / Git files |
| `w` | Find word (live grep) |
| `r` | Recent files |
| `b` | Git branches |
| `g` | LazyGit |
| `t` | Find TODOs |
| `p` | Plugins (Lazy) |
| `c` | Config (`$MYVIMRC`) |
| `l` | Lazy changelog |
| `q` | Quit |
