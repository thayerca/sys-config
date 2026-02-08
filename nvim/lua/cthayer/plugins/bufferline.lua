-- ------------------------------------------------------------------------------
-- bufferline.nvim (akinsho/bufferline.nvim) — Tabline for buffers/tabs
-- ------------------------------------------------------------------------------
-- What it does: Displays open buffers or tabs as a tabline at the top with
--   icons and LSP diagnostic indicators. Mode can be "tabs" or "buffers".
-- Keymaps: Use <Tab> / <S-Tab> or your window/tab keymaps to switch.
-- Notes: Depends on nvim-web-devicons; diagnostics shown from nvim_lsp.
-- ------------------------------------------------------------------------------

return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
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
