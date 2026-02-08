-- ------------------------------------------------------------------------------
-- init.lua — Neovim entry point
-- ------------------------------------------------------------------------------
-- What it does:
--   Loads core (options + keymaps) then lazy.nvim, which loads all specs from
--   lua/cthayer/plugins/. Leader is Space; pane navigation is Ctrl-h/j/k/l (vim-tmux-navigator).
--
-- How to interact:
--   Config lives in this repo under nvim/; symlink: ~/.config/nvim → repo.
--   Add plugins: create a new .lua in lua/cthayer/plugins/ returning a lazy spec.
--   Keymaps: see lua/cthayer/core/keymaps.lua and each plugin file; full list in docs/CHEATSHEET.md.
--
-- Author: Casey A. Thayer
-- Location: ~/.config/nvim/init.lua
-- ------------------------------------------------------------------------------

-- Core: options (UI, tabs, search, clipboard, etc.) and keymaps (leader, windows, tabs)
require("cthayer.core")

-- Plugins: lazy.nvim loads everything in lua/cthayer/plugins/
require("cthayer.lazy")

-- Optional: Python host for plugins that need Python (e.g. some legacy ones).
-- Create with: python3 -m venv ~/.venvs/global && ~/.venvs/global/bin/pip install neovim
vim.g.python3_host_prog = vim.fn.expand("~/.venvs/global/bin/python3")
