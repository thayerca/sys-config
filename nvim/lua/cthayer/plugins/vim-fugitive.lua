-- ------------------------------------------------------------------------------
-- vim-fugitive (tpope/vim-fugitive) — Git commands in Neovim
-- ------------------------------------------------------------------------------
-- What it does: :G (status), :Gdiffsplit/:Gvdiffsplit, :Gblame, :Gread/:Gwrite,
--   :G rebase -i. Renders git output in buffers; uses delta for diffs when available.
-- Keymaps: <leader>gs (status), <leader>gd/gD (diff), <leader>gb (blame), <leader>gh (file log), <leader>gr (rebase -i).
-- Notes: Loads on cmd/keys; init enables delta if executable.
-- ------------------------------------------------------------------------------

return {
	"tpope/vim-fugitive",
	cmd = { "G", "Git", "Gdiffsplit", "Gvdiffsplit", "Gblame" },
	keys = {
		{ "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
		{ "<leader>gd", "<cmd>Gvdiffsplit<CR>", desc = "Git diff (vertical)" },
		{ "<leader>gD", "<cmd>Gdiffsplit<CR>", desc = "Git diff (horizontal)" },
		{ "<leader>gb", "<cmd>Gblame<CR>", desc = "Git blame current file" },
		{ "<leader>gh", "<cmd>0Gclog<CR>", desc = "Git commit log (file)" },
		{ "<leader>gr", ":G rebase -i ", desc = "Git rebase -i (type branch, then Enter)" },
	},
	init = function()
		-- Enable Fugitive's use of delta for diffs if installed
		if vim.fn.executable("delta") == 1 then
			vim.g.fugitive_diff_option = "--tty --paginate --color=always | delta --dark"
			vim.g.fugitive_diff_executable = "delta"
		end
	end,
}
