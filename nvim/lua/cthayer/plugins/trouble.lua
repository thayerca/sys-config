-- ========================================
--  Trouble.nvim
--  URL: https://github.com/folke/trouble.nvim
--  Description: A pretty diagnostics, references, telescope results, quickfix and location list
--  How it works: Provides a toggleable panel for workspace/document diagnostics, LSP references, quickfix list, and todos
--  Usage tips:
--    - <leader>xx toggles the trouble list
--    - Use other keybindings for quick access to diagnostics and todos
-- ========================================

return {
	"folke/trouble.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- Adds file icons
		"folke/todo-comments.nvim", -- Integrates todo-comments into the Trouble UI
	},
	keys = {
		{
			"<leader>xx",
			function()
				require("trouble").toggle("diagnostics")
			end,
			desc = "Toggle Trouble (Workspace Diagnostics)",
		},
		{
			"<leader>xw",
			function()
				require("trouble").open("diagnostics")
			end,
			desc = "Open Workspace Diagnostics",
		},
		{
			"<leader>xd",
			function()
				require("trouble").open("diagnostics") -- Will default to current buffer's diagnostics
			end,
			desc = "Open Document Diagnostics",
		},
		{
			"<leader>xq",
			function()
				require("trouble").open("qflist")
			end,
			desc = "Open Quickfix List",
		},
		{
			"<leader>xl",
			function()
				require("trouble").open("loclist")
			end,
			desc = "Open Location List",
		},
		{
			"<leader>xt",
			"<cmd>TodoTrouble<CR>",
			desc = "Todo Comments in Trouble",
		},
		{
			"<leader>xr",
			function()
				require("trouble").open("lsp")
			end,
			desc = "LSP References",
		},
	},
	config = function()
		require("trouble").setup({
			focus = true,
			auto_open = false,
			auto_close = false,
			auto_preview = true,
			height = 10,
			padding = true,
			use_diagnostic_signs = true,
		})

		vim.cmd([[highlight! link TroubleText DiagnosticVirtualTextWarn]])
	end,
}
