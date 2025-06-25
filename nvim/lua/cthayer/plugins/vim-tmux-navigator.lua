-- -----------------------------------------------------------------------------
-- 🔀 Plugin: nvim-tmux-navigation
-- https://github.com/alexghergh/nvim-tmux-navigation
--
-- Seamlessly navigate between Neovim splits and tmux panes using <C-h/j/k/l>.
-- -----------------------------------------------------------------------------

return {
	"alexghergh/nvim-tmux-navigation",
	lazy = false, -- Ensure it loads early so mappings work immediately
	config = function()
		local nav = require("nvim-tmux-navigation")

		nav.setup({
			disable_when_zoomed = true, -- Optional: disable tmux navigation when zoomed
		})

		local map = vim.keymap.set
		local opts = { silent = true, noremap = true, desc = "Tmux window navigation" }

		map("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", opts)
		map("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", opts)
		map("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", opts)
		map("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", opts)
	end,
}
