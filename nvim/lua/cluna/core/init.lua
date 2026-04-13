-- ------------------------------------------------------------------------------
-- core/init.lua — Core Neovim config loader
-- ------------------------------------------------------------------------------
-- What it does:
--   Requires options.lua (UI, tabs, search, clipboard, etc.) and keymaps.lua
--   (leader, window/split, tab keybindings). Plugin keymaps live in each plugin file.
--
-- How to interact:
--   Edit options in core/options.lua; edit core keymaps in core/keymaps.lua.
--   Restart Neovim or source to apply. See docs/CHEATSHEET.md for full keymap list.
--
-- Author: Casey A. Thayer
-- Location: ~/.config/nvim/lua/cluna/core/init.lua
-- ------------------------------------------------------------------------------

require("cluna.core.options") -- Basic editor settings (e.g., line numbers, tabstop)
require("cluna.core.keymaps") -- Custom keybindings (normal, visual, terminal)
