-- ------------------------------------------------------------------------------
-- telescope.nvim (nvim-telescope/telescope.nvim) — Fuzzy finder + extensions
-- ------------------------------------------------------------------------------
-- What it does: Find files, recent, grep, todos; project switch.
--   Extensions: ui-select (LSP menus), fzf-native (faster sort), project.
-- Keymaps: <leader>ff/fr/fs/fc/ft, <leader>fp (projects).
-- Notes: fzf-native improves fuzzy sort; project extension needs this config.
-- ------------------------------------------------------------------------------

return {
	{ "nvim-telescope/telescope-ui-select.nvim" },

	-- Native fzf sorter for Telescope (must be built on install)
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	{ "nvim-telescope/telescope-project.nvim" },

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-project.nvim",
		},
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					project = { base_dirs = { "~/.config", "~" }, hidden_files = true },
				},
			})

			telescope.load_extension("ui-select")
			telescope.load_extension("fzf")
			telescope.load_extension("project")

			local keymap = vim.keymap
			keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
			keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
			keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
			keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find word under cursor" })
			keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
			keymap.set("n", "<leader>fp", "<cmd>Telescope project<cr>", { desc = "Telescope projects" })
		end,
	},
}
