-- ------------------------------------------------------------------------------
-- 🧠 core/init.lua — Core Neovim Configuration
-- ------------------------------------------------------------------------------
-- Description:
--   Loads base editor settings (options) and key mappings.
--   Keeps top-level init.lua clean and focused.
--
-- Author: Casey A. Thayer
-- Location: ~/.config/nvim/lua/cthayer/core/init.lua
-- ------------------------------------------------------------------------------

require("cthayer.core.options") -- Basic editor settings (e.g., line numbers, tabstop)
require("cthayer.core.keymaps") -- Custom keybindings (normal, visual, terminal)
