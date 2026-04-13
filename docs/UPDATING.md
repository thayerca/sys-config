# Updating & Maintaining This Config

How to keep the config current, add new tools, make changes, and manage the repo.

---

## Updating tools

### Neovim plugins
```bash
# Inside Neovim
:Lazy update          # update all plugins
:Lazy sync            # install missing + update + clean unused
:Lazy clean           # remove unused plugins
```

After updating, check for errors on next Neovim startup. If something breaks:
- `:Lazy restore` to roll back to the last known-good `lazy-lock.json`
- Or revert `nvim/lazy-lock.json` in git: `git checkout HEAD -- nvim/lazy-lock.json`

### LSP servers, formatters, linters
```bash
# Inside Neovim
:Mason                # opens the installer UI
:MasonUpdate          # update all installed tools
```

To add a new tool: open `:Mason`, search, press `i` to install. It installs to `~/.local/share/nvim/mason/`. Mason-installed binaries are automatically available to LSP and none-ls.

### Homebrew (shell tools, apps)
```bash
brew update && brew upgrade          # update everything
brew bundle --file=Brewfile          # install anything missing from Brewfile
brew bundle cleanup --file=Brewfile  # remove things not in Brewfile (dry-run first)
```

### Tmux plugins (TPM)
Inside tmux: `prefix + U` to update all plugins.

### Node (fnm)
```bash
fnm install 22        # install Node 22 (required for Copilot)
fnm default 22        # set as default for new shells
```

---

## Making config changes

### Which file to edit
| What you want to change | File |
|-------------------------|------|
| Neovim plugin config | `nvim/lua/cthayer/plugins/<plugin>.lua` |
| Neovim options (line numbers, tabs, etc.) | `nvim/lua/cthayer/core/options.lua` |
| Neovim core keymaps (non-plugin) | `nvim/lua/cthayer/core/keymaps.lua` |
| Shell aliases | `zsh/aliases.shrc` |
| Shell functions | `zsh/functions.shrc` |
| Shell config, plugins, PATH | `zsh/.zshrc` |
| Login env, PATH, tool init | `zsh/.zprofile` |
| Tmux config | `tmux/.tmux.conf` |
| Installed tools (brew, casks) | `Brewfile` |
| Git config (user, aliases, delta) | `git-configs/.gitconfig` |
| Global gitignore | `git-configs/.gitignore_global` |
| Ghostty terminal config | `ghostty/config` |
| Starship prompt | `starship/starship.toml` |
| Bootstrap script | `setup.sh` |

All config files are symlinked from your home directory into this repo by `setup.sh`, so editing the file in the repo takes effect immediately (no copy step needed).

### Adding a new Neovim plugin

1. Create `nvim/lua/cthayer/plugins/<name>.lua` following the existing pattern:
```lua
-- Header comment explaining what it does and keymaps
return {
    "author/plugin-name",
    event = "VeryLazy",  -- or keys = {...} for lazy-loading
    opts = {},           -- or config = function() ... end for setup
}
```

2. If it adds keymaps under a new leader prefix, add a group label to `which-key.lua`:
```lua
{ "<leader>x", name = "+my-group" },
```

3. Lazy.nvim auto-discovers any file in `nvim/lua/cthayer/plugins/` — no import needed.

4. Restart Neovim; `:Lazy` will show the new plugin and install it.

### Removing a Neovim plugin

1. Delete `nvim/lua/cthayer/plugins/<name>.lua`
2. Run `:Lazy clean` in Neovim to remove the installed files
3. Remove any group label from `which-key.lua` if relevant
4. Remove from `nvim/lazy-lock.json` entry (Lazy handles this automatically)

### Adding a new shell alias or function
- Short aliases go in `zsh/aliases.shrc`
- Multi-line functions go in `zsh/functions.shrc`
- Run `sz` (or `source ~/.zshrc`) to reload without opening a new terminal

### Adding a Homebrew package
Edit `Brewfile`:
```ruby
brew "tool-name"           # CLI tool
cask "App Name"            # macOS app
```
Then run `brew bundle --file=Brewfile` to install.

---

## Verifying changes

### Before committing
```bash
bash scripts/lint.sh    # zsh syntax, bash syntax, tmux parse, nvim headless load
```

Fix any failures before pushing — CI runs the same checks on every PR.

### After pulling changes
```bash
bash scripts/validate.sh   # verifies symlinks, tools on PATH, key configs reachable
```

---

## Repo structure

```
sys-config/
├── Brewfile                    # Homebrew packages and casks
├── setup.sh                    # Bootstrap script (run once on fresh machine)
├── .gitignore / .luarc.json    # Repo-level config
├── docs/                       # This documentation
├── ghostty/config              # Ghostty terminal settings
├── git-configs/
│   ├── .gitconfig              # Git user, aliases, delta, LFS
│   └── .gitignore_global       # Global ignores (OS, Python, editors)
├── nvim/
│   ├── init.lua                # Entry point
│   ├── lazy-lock.json          # Plugin lockfile (commit after :Lazy update)
│   └── lua/cthayer/
│       ├── core/
│       │   ├── options.lua     # Vim options
│       │   └── keymaps.lua     # Core keymaps (non-plugin)
│       ├── lazy.lua            # lazy.nvim bootstrap
│       └── plugins/            # One file per plugin
├── scripts/
│   ├── lint.sh                 # Config syntax/load checks (CI + local)
│   ├── validate.sh             # Post-install symlink/tool verification
│   └── tmux-sessionizer        # Project session picker
├── starship/starship.toml      # Prompt
├── tmux/.tmux.conf             # Tmux config + TPM plugins
└── zsh/
    ├── .zshrc                  # Interactive shell config
    ├── .zprofile               # Login shell config
    ├── aliases.shrc            # All shell aliases
    └── functions.shrc          # Shell functions
```

---

## Git workflow for this repo

### Making a change
```bash
# Edit whatever you need
bash scripts/lint.sh    # verify it passes
git add <files>
git commit -m "type(scope): what and why"
git push
```

### Commit message conventions
```
feat(nvim): add telescope-file-browser plugin
fix(zsh): correct fzf-tab initialization order
chore(brew): update Brewfile with new tools
docs: update CHEATSHEET with new keymaps
```

### Pulling changes on an existing machine
```bash
cd ~/sys-config           # or wherever the repo lives
git pull
bash scripts/validate.sh  # verify everything is still wired up
# In Neovim: :Lazy sync   # install/update plugins to match lazy-lock.json
```

---

## Setting up a fresh machine

> Full step-by-step: [INSTALL.md](INSTALL.md)

```bash
# 1. Clone
git clone git@github.com:caseyluna/sys-config.git ~/sys-config
cd ~/sys-config

# 2. Bootstrap
bash setup.sh

# 3. Reload shell
exec $SHELL

# 4. Tmux plugins — attach tmux then:
# prefix + I

# 5. Node (for Copilot)
fnm install 22 && fnm default 22

# 6. Neovim — first launch auto-installs plugins via lazy.nvim
nvim
# then: :MasonUpdate to get all LSP servers/formatters
```

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Plugin error on startup | `:Lazy restore` to roll back, or check the plugin's GitHub for breaking changes |
| LSP not attaching | `:LspInfo` to see status; `:Mason` to verify the server is installed; `<Space>rs` to restart |
| Formatter not running | `:ConformInfo` to see what's configured for the filetype |
| Shell alias not found | `sz` to reload; check for typos in `aliases.shrc` |
| Tmux pane navigation broken | `prefix + r` to reload config; check vim-tmux-navigator is installed in both tmux and Neovim |
| Copilot Node.js warning | `fnm install 22 && fnm default 22`, then open a new terminal |
| Symlink broken after moving repo | Re-run `bash setup.sh` — it re-creates all symlinks pointing to the new path |

Full troubleshooting: [DEBUG.md](DEBUG.md)
