-- -----------------------------------------------------------------------------
-- 📑 Plugin: bufferline.nvim
-- https://github.com/akinsho/bufferline.nvim
--
-- Provides a nice tabline interface using Neovim buffers or tabs.
-- Integrates with devicons and supports custom behaviors and styling.
--
-- 🔧 How It Works:
-- This plugin displays open buffers or tabs as a visual tabline at the top.
-- You can customize it to use buffer mode (more common) or tab mode (as below).
-- Works well with `nvim-web-devicons` for rich icons.
--
-- 🧠 Usage Tips:
-- - Use `<Tab>` / `<S-Tab>` or custom keymaps to switch between tabs or buffers.
-- - You can set `mode = "buffers"` for a more traditional bufferline.
-- -----------------------------------------------------------------------------

return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- Provides icons for buffers/tabs
	},
	opts = {
		options = {
			mode = "tabs", -- You can change this to "buffers" if preferred
			separator_style = "slant", -- Looks cleaner with most color schemes
			show_close_icon = false,
			show_tab_indicators = true,
			enforce_regular_tabs = true,
			diagnostics = "nvim_lsp", -- Adds LSP diagnostics as icons in tabline
			always_show_bufferline = true,
		},
	},
}
