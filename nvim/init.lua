-- ------------------------------------------------------------------------------
-- 🚀 init.lua — Neovim Entry Point
-- ------------------------------------------------------------------------------
-- Description:
--   Loads core Neovim settings and lazy.nvim plugin setup.
--   This is the only file at the root; all logic is in `lua/cthayer/`.
--
-- Author: Casey A. Thayer
-- Location: ~/.config/nvim/init.lua
-- ------------------------------------------------------------------------------

-- 🧠 Load core settings (options, keymaps, autocmds, etc.)
require("cthayer.core")

-- 📦 Load plugins via lazy.nvim
require("cthayer.lazy")

vim.g.python3_host_prog = vim.fn.expand("~/.venvs/global/bin/python3")
