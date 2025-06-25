-- -----------------------------------------------------------------------------
-- 📏 Plugin: indent-blankline.nvim
-- https://github.com/lukas-reineke/indent-blankline.nvim
--
-- Visually displays indentation levels with vertical lines.
-- Helps you understand code structure at a glance.
--
-- How it works:
--   - Shows a character (like '┊') for each indent level.
--   - Optionally supports context-aware highlighting (e.g., current scope).
--   - Can be customized per filetype or disabled on demand.
--
-- Tips:
--   - Toggle visibility with `:IBLToggle`
--   - Customize with `vim.g` or `opts` in Lazy config
-- -----------------------------------------------------------------------------

return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
	opts = {
		indent = {
			char = "┊", -- Character used to draw indent lines
			tab_char = nil,
		},
		scope = {
			enabled = true, -- Highlight current scope (based on Treesitter)
			show_start = false,
			show_end = false,
		},
		exclude = {
			filetypes = {
				"help",
				"terminal",
				"lazy",
				"lspinfo",
				"TelescopePrompt",
				"TelescopeResults",
				"mason",
			},
			buftypes = { "terminal", "nofile" },
		},
	},
}
