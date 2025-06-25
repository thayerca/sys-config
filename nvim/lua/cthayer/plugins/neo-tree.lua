-- -----------------------------------------------------------------------------
-- 📁 Plugin: neo-tree.nvim
-- https://github.com/nvim-neo-tree/neo-tree.nvim
--
-- A modern file explorer that replaces netrw and nvim-tree.
-- Supports viewing files, buffers, and git status in a floating or split view.
--
-- 🛠 How it works:
-- - Displays project files in a sidebar or floating window
-- - Highly customizable; supports filtering dotfiles and gitignored files
-- - Can show buffers, git status, and diagnostics
--
-- 💡 Usage tips:
-- - <leader>ee opens the file system in a floating window
-- - <leader>bf opens the buffer list
-- - Easily switch to sidebar mode by replacing `float` with `left`
-- -----------------------------------------------------------------------------

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree", -- Lazy-load on command
	event = "VeryLazy", -- Also lazy-load on common UI events
	dependencies = {
		"s1n7ax/nvim-window-picker", -- 🔲 Allows interactive window selection (e.g., choose where to open files)
		"nvim-lua/plenary.nvim", -- 🧰 Utility functions used by many plugins (required dependency)
		"nvim-tree/nvim-web-devicons", -- 🎨 Adds filetype icons for a better UI experience
		"MunifTanjim/nui.nvim", -- 🧱 UI component library used by Neo-tree (e.g., modals, popups)
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
