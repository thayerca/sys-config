-- ------------------------------------------------------------------------------
-- bufferline.nvim (akinsho/bufferline.nvim) — Tabline for buffers/tabs
-- ------------------------------------------------------------------------------
-- What it does: Displays open buffers or tabs as a tabline at the top with
--   icons and LSP diagnostic indicators. Mode can be "tabs" or "buffers".
-- Keymaps: <Tab> next tab, <S-Tab> previous tab.
-- Notes: Depends on nvim-web-devicons; diagnostics shown from nvim_lsp.
-- ------------------------------------------------------------------------------

return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<Tab>",   "<cmd>BufferLineCycleNext<CR>", desc = "Next tab",     mode = "n" },
		{ "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous tab", mode = "n" },
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
