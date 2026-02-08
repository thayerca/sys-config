-- ------------------------------------------------------------------------------
-- refactoring.nvim (ThePrimeagen/refactoring.nvim) — Extract, inline refactors
-- ------------------------------------------------------------------------------
-- What it does: Extract variable/function, inline variable, etc. from visual
--   selection. No conflict: <leader>re (extract), <leader>ri (inline); leader+rs is LSP restart.
-- Keymaps: <leader>re (extract), <leader>ri (inline), <leader>rb (block). Visual mode.
-- Notes: Depends on nvim-treesitter and plenary. Toggle refactor menu: <leader>rM.
-- ------------------------------------------------------------------------------

return {
	"ThePrimeagen/refactoring.nvim",
	event = "BufReadPre",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{ "<leader>re", function() require("refactoring").refactor("Extract Function") end, mode = "v", desc = "Refactor: extract function" },
		{ "<leader>rv", function() require("refactoring").refactor("Extract Variable") end, mode = "v", desc = "Refactor: extract variable" },
		{ "<leader>ri", function() require("refactoring").refactor("Inline Variable") end, mode = "n", desc = "Refactor: inline variable" },
		{ "<leader>rM", "<cmd>Refactoring<CR>", desc = "Refactor: menu" },
	},
	opts = {},
}
