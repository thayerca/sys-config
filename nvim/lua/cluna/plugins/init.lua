-- ------------------------------------------------------------------------------
-- plugins/init.lua — Shared plugin dependencies (loaded first by lazy.nvim)
-- ------------------------------------------------------------------------------
-- What it does:
--   First file lazy.nvim imports from cluna.plugins. Returns shared
--   dependencies (e.g. plenary.nvim) used by Telescope, none-ls, and others.
--
-- How to interact:
--   Add a new plugin by creating a new .lua file in this directory that returns
--   a lazy.nvim spec. Do not add heavy plugins here; keep this list minimal.
--
-- Author: Casey A. Thayer
-- Location: ~/.config/nvim/lua/cluna/plugins/init.lua
-- ------------------------------------------------------------------------------

return {
	"nvim-lua/plenary.nvim", -- Lua utility library; required by Telescope, none-ls, etc.
}
