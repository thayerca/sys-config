# sys-config: Dotfiles Audit & Improvement Plan

**Audit date:** 2025-02-08  
**Scope:** Full repo audit for “clone → one script → done” bootstrap, environment hygiene, Neovim, and tmux.  
**Constraints:** No new Neovim/tmux plugins in this pass; recommend only.

---

## Deprecated — historical reference only

**This document is out of date.** It describes the repo as it was at audit time. Use it only for context; for current layout and usage see [INDEX.md](INDEX.md) and the repo itself.

**Updates since audit:**
- **Bash removed:** Repo is zsh-only. `bash/` and `ct-bash.shrc` no longer exist; setup and docs do not reference bash config.
- **Setup:** Preflight (git, curl, zsh), backup of existing dotfiles, and clear execution flow are in place. Python default is 3.13 (optional).
- **Validation:** `scripts/validate.sh` (post-install) and `scripts/lint.sh` (syntax/load, no install) exist. See [TESTING.md](TESTING.md).
- **Plugins:** Neovim and tmux plugin set may differ from the "24 plugin" count here; see `nvim/lua/cluna/plugins/` and `tmux/.tmux.conf`.
- **Docs:** INSTALL, DEBUG, CHEATSHEET, GIT-REBASE, TESTING, INDEX are the current docs.

---

## 1. Inventory & Load Order (snapshot at audit time)

### 1.1 Directory Tree (config-relevant only) — *bash/ since removed*

```
sys-config/
├── Brewfile                  # Homebrew bundle (formulas + casks)
├── fzf/
│   └── .fzf/
│       ├── key-bindings.zsh  # Sources widgets
│       └── widgets/
│           ├── cd-widget.zsh
│           ├── file-widget.zsh
│           ├── history-widget.zsh
│           └── launcher-widget.zsh
├── git-configs/
│   ├── .gitconfig            # User, core, diff/merge, delta, LFS, colors
│   └── .gitignore_global     # OS, Python, editor, secrets
├── ghostty/
│   └── config                # theme = catppuccin-mocha (minimal)
├── iterm/
│   └── catppuccin-mocha.itermcolors
├── kitty/
│   └── kitty.conf            # Font, term, padding, keys, clipboard, Catppuccin
├── nvim/
│   ├── init.lua              # Entry: core + lazy + python3_host_prog
│   ├── lazy-lock.json        # Lockfile for lazy.nvim
│   └── lua/cluna/
│       ├── core/
│       │   ├── init.lua      # Requires options + keymaps
│       │   ├── options.lua   # UI, tabs, search, clipboard, splits, files, perf
│       │   └── keymaps.lua   # Leader, numbers, windows, tabs, <C-h/j/k/l> splits
│       ├── lazy.lua          # Bootstrap lazy.nvim, rtp, plugin setup
│       └── plugins/          # 24 plugin specs (alpha, LSP, telescope, etc.)
├── powerline/
│   └── .p10k.zsh             # Powerlevel10k config (currently unused; Starship active)
├── setup.sh                  # Single bootstrap script (brew, symlinks, fonts, omz, fzf, tpm, pyenv)
├── starship/
│   └── starship.toml         # Prompt config (Catppuccin Mocha, segments)
├── tmux/
│   ├── .tmux.conf            # Shell, term, mouse, prefix, copy-mode, TPM, Catppuccin
│   └── .tmux/plugins/        # TPM-managed plugins (e.g. vim-tmux-navigator) — TPM installs to ~/.tmux/plugins/
└── zsh/
    ├── .zprofile             # Login: brew, pyenv, EDITOR, PATH ($HOME/bin)
    ├── .zshrc                # Interactive: OMZ, starship, PATH, tools, aliases, functions
    ├── aliases.shrc          # Aliases (python, editor, nav, ls/cat, git, docker, k8s, R, tf, etc.)
    └── functions.shrc        # Functions (gcp, glogone, query-gcp, bigquery, delete_branches, phil-db-*)
```

### 1.2 What Each File Does (short)

| Path | Purpose |
|------|--------|
| `setup.sh` | Install brew, Brewfile, symlinks, Powerline fonts, Oh My Zsh, fzf install, TPM, pyenv + Python 3.13 (optional). |
| `zsh/.zprofile` | Login env: Homebrew, pyenv shims, EDITOR, $HOME/bin. |
| `zsh/.zshrc` | OMZ, starship, PATH, history, direnv, fzf, pyenv, kubectl, gcloud, aliases, functions, fnm, nvm. |
| `zsh/aliases.shrc` | Aliases for python/pip, nvim, nav, eza/bat, direnv, git, docker, k8s, R, duckdb, tf, ports/ip. |
| `zsh/functions.shrc` | gcp, glogone, query-gcp, bigquery, delete_branches, phil-db-up/switch/status/down. |
| ~~`bash/ct-bash.shrc`~~ | *Removed; repo is zsh-only.* |
| `tmux/.tmux.conf` | default-shell zsh, 256color, mouse, prefix C-a, vim copy-mode, TPM + plugins (yank, catppuccin, fzf, vim-tmux-navigator). |
| `nvim/init.lua` | Load core + lazy; set `python3_host_prog`. |
| `nvim/lua/cluna/core/*` | Options and keymaps (no autocmds in core). |
| `nvim/lua/cluna/lazy.lua` | Lazy bootstrap + disabled_plugins, checker, format_on_save implied by plugins. |
| `nvim/lua/cluna/plugins/*` | LSP, Mason, Telescope, Catppuccin, formatting (conform + formatter.nvim), none-ls, etc. |
| `git-configs/*` | Global git identity, pager (delta), difftool/mergetool (nvim), LFS, colors. |
| `starship/starship.toml` | Prompt layout and Catppuccin Mocha palette. |
| `powerline/.p10k.zsh` | P10k theme config; **not sourced** (Starship used instead). |
| `Brewfile` | Formulas (cli, shell, dev, langs, python, db, k8s, fonts) and casks. |

### 1.3 Load Order (what loads what, when)

- **Login shell (e.g. Terminal.app):**  
  `~/.zprofile` → then for interactive: `~/.zshrc`.
- **`.zprofile`:** brew shellenv, PYENV_ROOT + PATH shims, EDITOR, $HOME/bin.
- **`.zshrc`:**  
  1. ZSH, brew shellenv, ZSH_HIGHLIGHT_*, ZSH_COMPDUMP, **starship init**  
  2. plugins + `source $ZSH/oh-my-zsh.sh`  
  3. (commented) p10k  
  4. **starship init** again  
  5. SHELL, **brew shellenv** again, PATH exports (homebrew, local/bin, openssl, llvm, dagger)  
  6. History, direnv, fzf key-bindings, pyenv/virtualenv, kubectl, gcloud  
  7. uv aliases, source aliases.shrc + functions.shrc  
  8. colors, compinit skip, fnm, nvm
- **Aliases/functions:** `~/.aliases.shrc`, `~/.functions.shrc` (both from .zshrc). *(Bash config was removed; repo is zsh-only.)*
- **tmux:** Started by user or by Ghostty (if TERM_PROGRAM=ghostty). Reads `~/.tmux.conf` once; runs TPM from `~/.tmux/plugins/tpm/tpm`.
- **Neovim:** Reads `~/.config/nvim/init.lua` → `cluna.core` (options, keymaps) → `cluna.lazy` (plugins). LSP/tools assume PATH from the shell that launched nvim (login/zprofile + zshrc).

### 1.4 Duplicates / Conflicting Responsibilities

| Issue | Locations | Notes |
|-------|-----------|--------|
| **starship init twice** | `zsh/.zshrc` ~L23, ~L49 | Redundant; remove one. |
| **brew shellenv twice** | `zsh/.zshrc` ~L19, ~L55 | Redundant; keep one (after ZSH set). |
| **EDITOR set in two places** | `zsh/.zprofile` L20–21, `zsh/aliases.shrc` L28 | Prefer .zprofile for env; aliases can drop `export EDITOR`. |
| **PATH / pyenv** | .zprofile (login) vs .zshrc (pyenv init -) | Intended: .zprofile for GUI, .zshrc for interactive; ensure no duplicate PATH appends. |
| **fzf-history + bindkey ^R** | .zshrc only | *Obsolete: bash removed.* could live in a shared “fzf” snippet. |
| **FZF_TMUX / FZF_TMUX_HEIGHT** | .zshrc only | *Obsolete: single source now.* |
| **HIST* / history** | .zshrc only | *Obsolete: single source now.* shell’s rc or document single source. |
| **p10k symlinked but unused** | setup.sh L26, powerline/.p10k.zsh, .zshrc p10k commented | Dead config; either remove from setup + repo or document “optional p10k”. |
| **Neovim <C-h/j/k/l>** | core/keymaps.lua (splits) vs vim-tmux-navigator (tmux panes) | Plugin overrides; keymaps.lua entries for splits are redundant when plugin is loaded. |
| **Formatting** | conform.nvim (format on save + <leader>mp) and none-ls (formatting sources + <leader>gf) | Both present; <leader>gf uses vim.lsp.buf.format (can trigger LSP or null-ls). Document or unify. |
| **Git nvim path** | git-configs/.gitconfig difftool/mergetool `path = /opt/homebrew/bin/nvim` | macOS/Homebrew-specific; breaks on Linux. |

---

## 2. Reproducibility & Bootstrap Design

### 2.1 “Clone → one script → done”

- **Gaps:**
  - **Repo path hardcoded:** `setup.sh` and Brewfile reference `~/sys-config`. Fails if repo is cloned elsewhere (e.g. `~/.config/sys-config` or `~/dotfiles`).
  - **Starship config not symlinked:** `starship/starship.toml` exists but is not linked to `~/.config/starship.toml`, so Starship uses defaults.
  - **Oh My Zsh overwrites .zshrc:** Install is run *after* symlinking `.zshrc`; default install script backs up and replaces `.zshrc`. Need `KEEP_ZSHRC=yes` (or symlink after OMZ).
  - **fzf symlink wrong:** `ln -sf ~/sys-config/fzf/ ~/.fzf` makes `~/.fzf` point at `sys-config/fzf/`, but key-bindings live in `fzf/.fzf/key-bindings.zsh`. So `~/.fzf/key-bindings.zsh` does not exist; .zshrc source fails.
  - **TPM not run after clone:** Plugins are declared in .tmux.conf but user must run `prefix + I` (or equivalent) to install; setup doesn’t do that.
  - **No dependency checks:** Script doesn’t verify bash, zsh, git, curl, or OS before running.
  - **Destructive/risky:** `set -e` is good; no backup of existing dotfiles before symlink; `brew bundle` can upgrade/change system.
  - **Linux:** `/opt/homebrew` and many paths are macOS-specific; single script is not portable without branching or a small “platform” layer.

### 2.2 Recommended layout

- **config/** — All dotfile content (grouped by domain): e.g. `config/shell/`, `config/tmux/`, `config/nvim/`, `config/git/`, `config/terminals/`, `config/prompt/`.
- **scripts/** — Bootstrap and helpers: `scripts/setup.sh`, `scripts/check-deps.sh`, `scripts/backup-dotfiles.sh`, OS-specific `scripts/macos.sh` / `scripts/linux.sh` if needed.
- **docs/** — README, AUDIT, INSTALL, DEBUG, optional “optional components” (p10k, iterm, etc.).
- **OS-specific:** Under `config/` use subdirs or suffixes, e.g. `config/shell/zshrc.macos` / `zshrc.linux` and source conditionally, or a single small “env” file that sets REPO_ROOT and OS.

### 2.3 Setup script: idempotency, safety, logging

- **Idempotency:** Symlinks with `ln -sf` are idempotent. Brew bundle is idempotent. Oh My Zsh and TPM clones check for existing dirs; pyenv block checks `command -v pyenv`. Fonts clone is not idempotent (removes ~/fonts after install). Making script re-runnable: avoid `rm -rf ~/fonts` or guard so we only install once.
- **Safety:** Add “preflight”: check required commands (bash, git, curl, zsh), optionally create backup dir and copy existing `~/.zshrc`, `~/.tmux.conf`, `~/.config/nvim` if they exist and are not already symlinks. No unconfirmed destructive ops.
- **Logging:** Use a simple log function (e.g. `log "Installing Homebrew..."`) and print section headers so logs are parseable.

### 2.4 Standard checks to recommend

- **Dependencies:** `command -v git curl zsh [brew]`; on macOS also `xcode-select -p` or similar if needed.
- **Shell:** Script should run with `#!/usr/bin/env bash` and explicitly use `bash` for the script; ensure default shell for user is zsh if desired (chsh).
- **Symlinks:** After setup, verify critical links: `~/.zshrc` → repo, `~/.tmux.conf` → repo, `~/.config/nvim` → repo, `~/.fzf` → repo (with correct target), `~/.config/starship.toml` → repo.
- **Backups:** Copy existing dotfiles to `~/.dotfiles-backup.YYYYMMDD` (or under repo `backups/`) before overwriting.
- **Rollback:** Document how to remove symlinks and restore from backup; optional `scripts/teardown.sh` that removes symlinks and optionally restores backup.

---

## 3. Environment Hygiene (“Pollution”) Audit

### 3.1 Every place env and PATH are modified

| File | What’s set |
|------|------------|
| **zsh/.zprofile** | `eval brew shellenv`, PYENV_ROOT, PATH (pyenv shims, $HOME/bin), EDITOR, VISUAL. |
| **zsh/.zshrc** | ZSH, brew shellenv (×2), PATH (/opt/homebrew/bin, /usr/local/bin, .local/bin, openssl, llvm, .dagger/bin), SHELL, HIST*, FZF_TMUX, FZF_TMUX_HEIGHT, (pyenv/virtualenv via eval). |
| **zsh/aliases.shrc** | EDITOR (redundant). |
| ~~bash/ct-bash.shrc~~ | *Removed; repo is zsh-only.* |
| **tmux/.tmux.conf** | No export; sets default-shell and terminal options only. |
| **nvim** | No PATH export; sets `vim.g.python3_host_prog` to a fixed path. |
| **setup.sh** | During run: PATH and pyenv evals for the subshell that installs pyenv/Python; does not persist. |

### 3.2 Risky patterns

- **PATH exported many times in .zshrc:** Multiple `export PATH="X:$PATH"` lines; order and duplicates can grow. Prefer building PATH once (e.g. array then `export PATH="${(j.:.)path_array}"`) or one block with comments.
- **Sourcing slow files unconditionally:** `.zshrc` sources OMZ, gcloud path.zsh.inc, nvm (if present). nvm in particular is slow; consider lazy-loading or fnm-only.
- **Duplicate init blocks:** starship and brew shellenv twice; pyenv in both .zprofile (shims for GUI) and .zshrc (init -); keep one of each in .zshrc.
- **Global aliases that shadow commands:** `aliases.shrc` has `ls='eza -l --icons'`, `cat='bat'`, `python=python3`, `pip=pip3`. If eza/bat/python3 not installed, interactive shell can break. Guard with `command -v eza` or document as required.
- **.zprofile vs .zshrc:** Login shells source .zprofile then .zshrc; non-interactive only .zprofile (often). So GUI apps get .zprofile PATH/EDITOR; that’s good. Avoid duplicating the same PATH entries in .zshrc if they’re already in .zprofile.

### 3.3 Single source of truth recommendation

- **Env vars (EDITOR, VISUAL, PYENV_ROOT, FZF_*):** Put in one file, e.g. `config/shell/env.zsh`, and source it from both .zprofile (for login/GUI) and .zshrc (for interactive). For Bash, source the same or a small env.bash that sets the same vars.
- **PATH:** Build in one place (e.g. .zprofile for login and GUI, and source that from .zshrc so interactive gets the same PATH without re-appending), or build in .zshrc once in a single block.
- **Interactive-only:** Completions, OMZ, starship init, keybindings, aliases — only in .zshrc. Optionally guard with `[[ -o interactive ]]` at top of .zshrc.

---

## 4. Neovim Audit (no new plugins)

### 4.1 Structure and documentation

- **Layout:** Single entry `init.lua` → `cluna.core` (options, keymaps) → `cluna.lazy` (plugin specs). Plugin specs live in `lua/cluna/plugins/`; each file is a module returning a spec. Good and modular.
- **Comments:** Most files have a header block; plugin files describe purpose and sometimes usage. Add short comments for any non-obvious option (e.g. `lazyredraw`, `synmaxcol`) and for leader keymap groups.

### 4.2 Footguns and fixes

| Area | Issue | Recommendation |
|------|--------|----------------|
| **Runtimepath** | lazy.nvim prepends its path; disabled_plugins listed. | No issue; keep as is. |
| **Redundant settings** | core/keymaps.lua sets <C-h/j/k/l> to window nav; vim-tmux-navigator overrides. | Remove <C-h/j/k/l> from core/keymaps.lua to avoid confusion; plugin is single source. |
| **Autocmd duplication** | LspAttach in lspconfig; BufRead/BufNewFile in formatting for *.shrc. | No duplication; fine. |
| **Filetype** | conform + formatter use `sh` and custom `shrc`; none-ls has many filetypes. | Ensure none-ls and conform don’t double-format same buffer (they use different mechanisms; document). |
| **Startup** | lazy.nvim defers most plugins; colorscheme priority 1000. | Good. Optional: measure with `--startuptime` and document. |
| **Clipboard** | `opt.clipboard:append("unnamedplus")`; requires terminal/session to support. | Document: on macOS ensure `pbpaste`/`pbcopy`; in tmux consider OSC 52 / tmux-yank. |
| **Terminal** | No explicit :terminal keymaps in core; plugins may add. | Document expected behavior in tmux (e.g. vim-tmux-navigator). |
| **LSP/tooling** | Mason ensures several LSPs + ruff, stylua, etc.; lspconfig sets many servers. | Some LSPs (e.g. astro, volar, svelte, r_language_server, ltex, ansiblels, lemminx, groovyls) may not be in Mason ensure_installed; document “install via Mason or system”. |
| **python3_host_prog** | Points to `~/.venvs/global/bin/python3`. | That venv is not created by setup; document or add optional setup step. |
| **none-ls** | Plugin name “none-ls.nvim”; Lua require still `null_ls`. | Verify package and require name match after any upgrade. |
| **Formatting** | conform format_on_save; none-ls also has formatters; <leader>gf calls vim.lsp.buf.format. | Keep; document that <leader>gf is “format via LSP/null-ls” and <leader>mp is “conform format”; clarify which runs on save (conform). |

### 4.3 “Known good” baseline structure

- **init.lua:** Only require core, require lazy, optional one or two global sets (e.g. python3_host_prog) with a comment.
- **lua/cluna/core/:** options.lua (all opt/g sets), keymaps.lua (leader + non-plugin keymaps only), optional autocmds.lua if needed later.
- **lua/cluna/plugins/:** One file per plugin or logical group; each returns a lazy spec. Comments at top: what it does, key maps it adds, and any dependency (e.g. “requires node for prettier”).
- **Where comments live:** Top of each file (purpose); above non-obvious options; above keymap blocks (e.g. “Window management”).

### 4.4 Validation checklist

- Startup: `nvim --startuptime /tmp/nvim-startup.log` then inspect; aim for &lt; 100ms to first paint if possible.
- `:checkhealth` and fix any red (provider python3, clipboard, LSP).
- Clean env: run from minimal shell (`env -i HOME=$HOME USER=$USER nvim`) and confirm no errors (optional).
- Keymaps: Leader, <C-h/j/k/l> (tmux nav), <leader>gf, <leader>mp, telescope, LSP (gd, K, etc.).
- Filetypes: Open a .lua, .py, .sh, .md and confirm LSP/formatting/treesitter as expected.

---

## 5. Tmux Audit (no new plugins)

### 5.1 Portability and correctness

| Topic | Current | Recommendation |
|-------|---------|----------------|
| **Term** | `default-terminal "tmux-256color"`, `terminal-overrides ",xterm-256color:Tc"` | Good for truecolor. On older systems ensure `tmux-256color` or `screen-256color` is available (ncurses terminfo). |
| **Truecolor** | Override with `Tc` for xterm-256color. | Add `,tmux-256color:Tc` if ever needed for consistency. |
| **Escape time** | Not set (default 500 ms). | Optional: `set -s escape-time 50` for more responsive prefix. |
| **Prefix** | C-a; C-b unbound. | Good. |
| **Key conflicts** | Vim copy-mode v/y; no conflict with prefix. | Fine. |
| **Mouse** | `set -g mouse on`. | Good. |
| **Copy-mode** | Vi-style; y copies. tmux-yank with OSC 52 / external clipboard. | Good; ensure terminal supports clipboard (e.g. Ghostty/Kitty). |
| **Default shell** | `default-shell /bin/zsh`. | Good; matches primary shell. On some Linux use `/usr/bin/zsh` if needed. |
| **TPM** | `run '~/.tmux/plugins/tpm/tpm'` at end. | Correct. |

### 5.2 Env and shell

- Tmux does not export env; it inherits from the session where it was started. So PATH/EDITOR come from the shell that started tmux (e.g. .zprofile + .zshrc). No change needed; document that “tmux inherits env from the shell that runs `tmux`”.
- If users start tmux from a login shell, they get .zprofile + .zshrc; if they start from a non-login context, they might miss .zprofile. Recommend starting tmux from an interactive zsh (e.g. after full login).

### 5.3 Separation of concerns

- **Tmux:** Keybindings, copy-mode, status line, TPM, default-shell — all in .tmux.conf. Good.
- **Shell:** PATH, EDITOR, aliases, prompt (starship) — in zsh/bash configs. Good.
- **Apps (e.g. nvim):** Own config; only assume EDITOR and PATH from environment. Good.

### 5.4 Verification checklist (fresh machine)

- Start tmux: `tmux new -s test`; detach (prefix d), attach `tmux attach -t test`.
- Pane creation: prefix | and prefix -; resize/drag with mouse.
- Copy/paste: Enter copy-mode (prefix v or v in copy-mode), select, y; paste with prefix p or terminal paste. Check system clipboard if using tmux-yank.
- Colors: Open nvim with a colorscheme; check truecolor in status line and in nvim.
- SSH: Start tmux locally then ssh; or ssh and start tmux there — confirm no double prefix and that TERM is passed (SendEnv AcceptEnv if needed).
- Nested tmux: Optional: document “inner session use different prefix” if you ever need nested sessions.

---

## 6. Concrete Outputs

### 6.1 Prioritized issues

**P0 (breaks bootstrap or critical path)**

| ID | File(s) | Location / Pattern | Why it matters | Proposed change |
|----|---------|--------------------|----------------|-----------------|
| P0-1 | setup.sh | Symlink `~/sys-config/fzf/` → `~/.fzf` | Key-bindings live in `fzf/.fzf/`, so `~/.fzf/key-bindings.zsh` is missing; fzf in shell broken. | Symlink `~/sys-config/fzf/.fzf` → `~/.fzf` (so `~/.fzf/key-bindings.zsh` exists). |
| P0-2 | setup.sh | Oh My Zsh install after .zshrc symlink | OMZ install script replaces .zshrc; repo config is lost. | Run OMZ with `KEEP_ZSHRC=yes` (or set env before curl \| sh). |
| P0-3 | setup.sh | No starship config symlink | Starship uses default config, not repo’s. | Add: `mkdir -p ~/.config && ln -sf "$REPO/starship/starship.toml" ~/.config/starship.toml`. |

**P1 (should fix)**

| ID | File(s) | Location / Pattern | Why it matters | Proposed change |
|----|---------|--------------------|----------------|-----------------|
| P1-1 | zsh/.zshrc | L23 and L49 | Duplicate `eval "$(starship init zsh)"`. | Remove one (e.g. keep after OMZ, remove the earlier one). |
| P1-2 | zsh/.zshrc | L19 and L55 | Duplicate `eval "$(/opt/homebrew/bin/brew shellenv)"`. | Keep once (e.g. in “env” block after ZSH); remove the other. |
| P1-3 | zsh/.zshrc | Source `$HOME/.fzf/key-bindings.zsh` | Depends on P0-1; after fix path is correct. | After P0-1, optionally use `"${XDG_CONFIG_HOME:-$HOME/.config}/fzf/key-bindings.zsh"` if you move fzf under config later. |
| P1-4 | setup.sh | Hardcoded `~/sys-config` | Fails when repo is cloned elsewhere. | Set `REPO="${REPO:-$HOME/sys-config}"` at top (or detect from script path); use `$REPO` in all paths. |
| P1-5 | git-configs/.gitconfig | difftool/mergetool `path = /opt/homebrew/bin/nvim` | Breaks on Linux. | Use `path = nvim` (rely on PATH) or a wrapper that runs `nvim` from PATH. |
| P1-6 | nvim/lua/cluna/core/keymaps.lua | <C-h/j/k/l> for window nav | Overridden by vim-tmux-navigator; redundant. | Remove the four <C-h/j/k/l> lines; add comment that tmux-style nav is in plugin. |
| P1-7 | zsh/aliases.shrc | `export EDITOR="nvim"` | Duplicate of .zprofile. | Remove; keep EDITOR in .zprofile (and optional env file). |
| P1-8 | setup.sh | Powerline fonts: `rm -rf ~/fonts` | Not idempotent; removes dir every run. | Only remove after successful install, or skip clone if fonts already installed. |

**P2 (nice-to-have)**

| ID | File(s) | Location / Pattern | Why it matters | Proposed change |
|----|---------|--------------------|----------------|-----------------|
| P2-1 | setup.sh | No backup of existing dotfiles | User may lose local customizations. | Before symlinks, copy existing ~/.zshrc, ~/.tmux.conf, ~/.config/nvim to ~/.dotfiles-backup.* if they exist and are not symlinks. |
| P2-2 | setup.sh | No dependency check | Can fail mid-run. | At start: check for git, curl, zsh (and optionally brew); exit with clear message. |
| P2-3 | zsh/.zshrc | nvm load unconditionally | Slow; many use fnm. | Lazy-load nvm (e.g. only when `nvm` or `node` is run) or document “use fnm only” and remove nvm block. |
| P2-4 | powerline/.p10k.zsh + setup | Symlink and large file | Dead config; clutters repo and setup. | Remove p10k symlink from setup; move powerline/ to docs/optional or delete; document in README. |
| P2-5 | starship/starship.toml | `vimcmd_symbol` typo | Line has `creen` instead of `green`. | Fix to `green`. |
| P2-6 | docs | No INSTALL / DEBUG | Hard for “future you” to onboard. | Add docs/INSTALL.md (clone, deps, run script, verify) and docs/DEBUG.md (common failures, logs, healthchecks). |
| P2-7 | tmux | TPM plugins not installed by script | User must remember prefix+I. | After TPM clone, run `~/.tmux/plugins/tpm/bin/install_plugins` (or document step in INSTALL). |
| P2-8 | nvim | python3_host_prog | Venv not created by setup. | Document in README or add optional `python3 -m venv ~/.venvs/global` and pip install neovim. |

### 6.2 Diff plan (file-by-file)

- **setup.sh**
  - Add at top: `REPO="${REPO:-$(cd "$(dirname "$0")" && pwd)}"` (or keep `$HOME/sys-config` and document).
  - Replace all `~/sys-config` with `"$REPO"`.
  - Change fzf symlink to: `ln -sf "$REPO/fzf/.fzf" "$HOME/.fzf"`.
  - Before OMZ: `export KEEP_ZSHRC=yes`; then run install.
  - Add starship: `mkdir -p "$HOME/.config" && ln -sf "$REPO/starship/starship.toml" "$HOME/.config/starship.toml"`.
  - Optional: preflight checks (git, curl, zsh); backup existing dotfiles; run TPM install_plugins; guard fonts cleanup.
- **zsh/.zshrc**
  - Remove first `eval "$(starship init zsh)"` (keep the one after OMZ).
  - Remove second `eval "$(/opt/homebrew/bin/brew shellenv)"` (keep the first or move to one block).
- **zsh/aliases.shrc**
  - Remove the line `export EDITOR="nvim"`.
- **git-configs/.gitconfig**
  - In `[difftool "nvimdiff"]` and `[mergetool "nvimdiff"]`, change `path = /opt/homebrew/bin/nvim` to `path = nvim` (or omit and rely on PATH).
- **nvim/lua/cluna/core/keymaps.lua**
  - Remove the four keymap.set lines for <C-h>, <C-j>, <C-k>, <C-l> (window nav); add comment: “Pane/split nav: vim-tmux-navigator plugin”.
- **starship/starship.toml**
  - Fix `vimcmd_symbol` value: `creen` → `green`.
- **powerline / setup**
  - Remove `ln -sf ... powerline/.p10k.zsh ...` from setup (or keep and document “optional p10k”); optionally move powerline to docs/optional or .gitignore.

### 6.3 Golden path guide

**Install**

1. Clone: `git clone <repo> ~/sys-config` (or desired path; set REPO if different).
2. Dependencies: Install Xcode CLI (macOS), git, curl, zsh. Optional: Homebrew first then run script.
3. Run: `bash ~/sys-config/setup.sh` (or `"$REPO/setup.sh"`).
4. Shell: Ensure login shell is zsh: `chsh -s /bin/zsh` (or path to zsh).
5. Tmux: Start tmux, run prefix+I to install TPM plugins.
6. Neovim: First run will pull lazy.nvim and plugins; create optional `~/.venvs/global` and pip install neovim if using Python provider.

**Debug**

- Shell: `zsh -x` to trace; check `echo $PATH`, `which nvim`, `starship --version`.
- Tmux: `tmux -L test new` for a clean server; check `tmux show -g default-shell`; run `~/.tmux/plugins/tpm/bin/install_plugins`.
- Neovim: `nvim --startuptime /tmp/startup.log`; `:checkhealth`; `:Lazy` for plugin status.
- Env: Compare `env` in terminal vs inside tmux vs inside nvim (`:!env`).

**Extend without sprawl**

- New env vars: Add to one place (e.g. `config/shell/env.zsh`) and source from .zprofile and .zshrc.
- New aliases: Prefer `aliases.shrc`; if many, split by topic and source from .zshrc.
- New Neovim plugin: Add a file under `lua/cluna/plugins/` returning a lazy spec; no new plugins in this pass, but when you do, keep one file per plugin.
- New tmux plugin: Add to @plugin list in .tmux.conf; run prefix+I.
- OS-specific: Use a single small “platform” include (e.g. `[[ -f ~/.config/sys-config/env.$(uname).zsh ]] && source ...`) or branch in setup.sh.

---

## 7. Validation

### 7.1 Minimal test plan (after changes)

Run on a machine that just ran setup (or after applying the diff plan):

**Shell**

```bash
# Default shell
echo $SHELL
# Expect: /bin/zsh (or path to zsh)

# Starship and fzf
type starship
[[ -f ~/.config/starship.toml ]] && echo "starship config linked"
[[ -f ~/.fzf/key-bindings.zsh ]] && echo "fzf key-bindings present"

# Critical symlinks
ls -la ~/.zshrc ~/.zprofile ~/.tmux.conf ~/.config/nvim ~/.fzf ~/.config/starship.toml
# All should point into repo (or expected paths)

# No duplicate inits (manual check)
grep -n "starship init\|brew shellenv" ~/.zshrc
# Expect one of each (or one block)
```

**Tmux**

```bash
tmux new -s verify -d
tmux send -t verify 'echo $SHELL' Enter
tmux capture-pane -t verify -p
tmux kill-session -t verify
# Expect zsh and clean prompt
```

**Neovim**

```bash
nvim --headless +"checkhealth" +qa 2>&1 | head -80
nvim --startuptime /tmp/nvim-startup.log +qa
tail -5 /tmp/nvim-startup.log
# No errors; startup time reasonable
```

**Git**

```bash
git config --global core.pager
# Expect: delta
git config --global difftool.nvimdiff.path
# Expect: nvim or path that exists
```

### 7.2 Clean-room test strategy

- **Option A — New user (macOS):** Create a new user account; clone repo into that user’s home; run setup as that user; run the tests above. Ensures no pollution from existing dotfiles.
- **Option B — Container (Linux):** Use a minimal image (e.g. Ubuntu or Debian), install git, curl, zsh, and optionally a minimal brew-equivalent or skip brew and symlink only; clone repo; run a “symlink-only” or “no-brew” path of setup; run shell and nvim checks. Validates layout and script logic.
- **Option C — Temp home:** `HOME=/tmp/dotfiles-test bash setup.sh` (and adjust script to use a temporary HOME if you add support). Then run tests with `HOME=/tmp/dotfiles-test zsh -l -c '...'`. Avoids touching real home.

Document the chosen strategy in docs/INSTALL.md or docs/DEBUG.md so future-you can re-validate after big changes.

---

*End of audit. Apply the diff plan in a branch, run the validation steps, then merge when satisfied. No edits were made to config files in this pass; only this audit document was added.*
