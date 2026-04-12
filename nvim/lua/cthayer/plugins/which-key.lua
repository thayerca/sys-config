-- ------------------------------------------------------------------------------
-- which-key.nvim (folke/which-key.nvim) — Keymap prefix popup
-- ------------------------------------------------------------------------------
-- What it does: Shows a popup of available keymaps when you press a prefix
--   (e.g. <leader>f shows file-related keymaps). Reduces memorization.
-- Keymaps: <leader>? (buffer-local keymaps); <leader>f/g/b (group labels only).
-- Notes: Loads on VeryLazy; opts = {} uses defaults.
-- ------------------------------------------------------------------------------

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},

	keys = {
		{ "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Show buffer-local keymaps" },
		{ "<leader>a", name = "+harpoon" },
		{ "<leader>b", name = "+buffer" },
		{ "<leader>c", name = "+Claude Code" },
		{ "<leader>f", name = "+file/telescope" },
		{ "<leader>g", name = "+git" },
		{ "<leader>h", name = "+gitsigns/harpoon" },
		{ "<leader>i", name = "+octo/issue" },
		{ "<leader>j", name = "+flash" },
		{ "<leader>p", name = "+octo/pr" },
		{ "<leader>o", name = "+oil" },
		{ "<leader>r", name = "+refactor/LSP" },
		{ "<leader>t", name = "+tab/term/todo" },
		{ "<leader>u", name = "+undo/inlay" },
		{ "<leader>d", name = "+diagnostics" },
		{ "<leader>l", name = "+lazygit" },
		{ "<leader>m", name = "+format" },
		{ "<leader>s", name = "+splits" },
		{ "<leader>x", name = "+trouble" },
		{ "<leader>z", name = "+no-neck-pain" },
	},
}
