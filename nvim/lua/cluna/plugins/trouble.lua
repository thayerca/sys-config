-- ------------------------------------------------------------------------------
-- trouble.nvim (folke/trouble.nvim) — Diagnostics, quickfix, loclist, todos
-- ------------------------------------------------------------------------------
-- What it does: Toggleable panel for workspace/buffer diagnostics, LSP
--   references, quickfix list, location list, and TodoTrouble integration.
-- Keymaps: <leader>xx (toggle diagnostics), <leader>xw/xd (workspace/doc diagnostics), <leader>xq (qflist), <leader>xl (loclist), <leader>xt (todos), <leader>xr (LSP refs).
-- Notes: Depends on nvim-web-devicons and todo-comments.nvim.
-- ------------------------------------------------------------------------------

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
