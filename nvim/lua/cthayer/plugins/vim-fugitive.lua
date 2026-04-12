-- ------------------------------------------------------------------------------
-- vim-fugitive (tpope/vim-fugitive) — Git commands in Neovim
-- ------------------------------------------------------------------------------
-- What it does: :G (status), :Gdiffsplit/:Gvdiffsplit, :Gblame, :Gread/:Gwrite,
--   :G rebase -i. Renders git output in buffers.
-- Keymaps: <leader>gs (status), <leader>gv/gD (diff), <leader>gb (blame), <leader>gL (file log), <leader>gr (rebase -i).
-- Notes: Loads on cmd/keys.
-- <leader>gd/gh/gH/gc are reserved for diffview.nvim.
-- ------------------------------------------------------------------------------

return {
	"tpope/vim-fugitive",
	cmd = { "G", "Git", "Gdiffsplit", "Gvdiffsplit", "Gblame" },
	keys = {
		{ "<leader>gs", "<cmd>Git<CR>",          desc = "Git status" },
		{ "<leader>gv", "<cmd>Gvdiffsplit<CR>",  desc = "Git diff (vertical split)" },
		{ "<leader>gD", "<cmd>Gdiffsplit<CR>",   desc = "Git diff (horizontal split)" },
		{ "<leader>gb", "<cmd>Gblame<CR>",        desc = "Git blame current file" },
		{ "<leader>gL", "<cmd>0Gclog<CR>",        desc = "Git commit log (file)" },
		{ "<leader>gr", ":G rebase -i ",          desc = "Git rebase -i (type branch, then Enter)" },
	},
}
