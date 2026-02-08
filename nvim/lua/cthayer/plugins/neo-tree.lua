-- ------------------------------------------------------------------------------
-- neo-tree.nvim (nvim-neo-tree/neo-tree.nvim) — File and buffer explorer
-- ------------------------------------------------------------------------------
-- What it does: File tree, buffer list, and git status in a float or sidebar.
--   Replaces netrw; supports filtering and follow-current-file.
-- Keymaps: <leader>ee (filesystem float), <leader>bf (buffers), <leader>eg (git status).
-- Notes: Depends on nvim-window-picker, plenary, web-devicons, nui. Branch v3.x.
-- ------------------------------------------------------------------------------

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	event = "VeryLazy",
	dependencies = {
		"s1n7ax/nvim-window-picker",
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true, -- Show hidden and gitignored files
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				follow_current_file = { enabled = true }, -- auto-focus on current file
			},
			buffers = {
				follow_current_file = true,
			},
			git_status = {
				window = {
					position = "float",
				},
			},
			window = {
				position = "float",
				popup = {
					size = {
						height = "80%",
						width = "60%",
					},
					border = "rounded",
				},
				mappings = {
					["o"] = "open",
					["<cr>"] = "open_with_window_picker",
				},
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
		})

		-- Keybindings for Neo-tree views
		vim.keymap.set(
			"n",
			"<leader>ee",
			":Neotree filesystem reveal float<CR>",
			{ desc = "NeoTree: Show Filesystem (float)" }
		)
		vim.keymap.set(
			"n",
			"<leader>bf",
			":Neotree buffers reveal float<CR>",
			{ desc = "NeoTree: Show Buffers (float)" }
		)
		vim.keymap.set(
			"n",
			"<leader>eg",
			":Neotree git_status reveal float<CR>",
			{ desc = "NeoTree: Show Git Status (float)" }
		)
	end,
}
