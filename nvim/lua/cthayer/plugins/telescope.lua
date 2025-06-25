-- Plugin: telescope.nvim (with telescope-ui-select)
-- URL: https://github.com/nvim-telescope/telescope.nvim
-- Description: Fuzzy finder for files, text, buffers, and more. Extensible with useful extensions like `ui-select`.
-- How it works: Provides interactive search via fuzzy matching and integrates with many core Neovim features.
-- Usage tips:
--   - `<leader>ff` – Find files in the current working directory
--   - `<leader>fr` – Open recently opened files
--   - `<leader>fs` – Search for a string in the current working directory (live grep)
--   - `<leader>fc` – Search for the word under your cursor
--   - `<leader>ft` – Open TODO comments via TodoTelescope
--   - Can also be used for LSP actions via ui-select extension
-- Recommended extensions: `fzf`, `file_browser`, `projects`, `ui-select`

return {
	-- UI select extension for Telescope (used in code actions, etc.)
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},

	-- Core Telescope plugin
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required dependency
		},
		config = function()
			local telescope = require("telescope")

			-- Configure Telescope with extensions
			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}), -- Use dropdown style for UI select
					},
				},
			})

			-- Load the ui-select extension
			telescope.load_extension("ui-select")

			-- Set keymaps for Telescope
			local keymap = vim.keymap -- for conciseness

			keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
			keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
			keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
			keymap.set(
				"n",
				"<leader>fc",
				"<cmd>Telescope grep_string<cr>",
				{ desc = "Find string under cursor in cwd" }
			)
			keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		end,
	},
}
