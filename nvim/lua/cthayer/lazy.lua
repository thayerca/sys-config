-- ------------------------------------------------------------------------------
-- lazy.lua — Plugin manager (lazy.nvim) bootstrap and config
-- ------------------------------------------------------------------------------
-- What it does:
--   Bootstraps lazy.nvim from data dir, prepends to rtp, then loads all specs
--   from lua/cthayer/plugins/ (each file is auto-imported). Enables checker,
--   install of missing plugins, and disables several built-in plugins for performance.
--
-- How to interact:
--   Add a plugin: create lua/cthayer/plugins/name.lua that returns a lazy.nvim
--   spec (table or array of tables). Restart Neovim; lazy will install. Open
--   :Lazy to manage plugins. See docs/PLUGIN-RECOMMENDATIONS.md for ideas.
--
-- Author: Casey A. Thayer
-- Location: ~/.config/nvim/lua/cthayer/lazy.lua
-- ------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Clone lazy.nvim if missing (first run or fresh install)
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load all plugin specs from cthayer.plugins (each file in plugins/ is auto-imported)
require("lazy").setup({
	{ import = "cthayer.plugins" },
}, {
	checker = { enabled = true, notify = false },
	change_detection = {
		notify = false, -- Don’t spam about config changes
	},
	install = {
		missing = true, -- Auto-install missing plugins on startup
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
