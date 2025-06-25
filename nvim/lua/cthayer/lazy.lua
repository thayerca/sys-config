-- ------------------------------------------------------------------------------
-- 💤 lazy.lua — Plugin Manager Bootstrap & Setup
-- ------------------------------------------------------------------------------
-- Author: Casey A. Thayer
-- Location: ~/.config/nvim/lua/cthayer/lazy.lua
-- ------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Bootstrap lazy.nvim if not already installed
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

-- Configure and load plugin specs
require("lazy").setup({
	{ import = "cthayer.plugins" },
},
{
	checker = {
		enabled = true, -- Periodically check for plugin updates
		notify = false, -- Silence update messages
	},
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
