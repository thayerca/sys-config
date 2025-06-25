-- -----------------------------------------------------------------------------
-- 🔧 Plugin: vim-fugitive
-- https://github.com/tpope/vim-fugitive
--
-- Comprehensive Git integration inside Neovim:
-- • `:G` opens Git status, staging, committing, rebasing, etc.
-- • `:Gdiffsplit`, `:Gvdiffsplit` for inline diffs.
-- • `:Gblame` with navigable blame info.
-- • `:Gread`, `:Gwrite` to checkout or add hunks.
--
-- How it works:
-- Internally runs Git commands and renders results in buffers, blends with
-- diff/quickfix lists, and supports split/diff modes seamlessly.
--
-- Usage tips:
-- • Launch `:G` or press `<leader>gs` for quick status.
-- • Use `<leader>gd` for vertical diff of current file.
-- • `<leader>gb` opens blame info; press `<Enter>` on lines to jump to commit.
-- • Stage/unstage hunks via interactive diff splits.
-- -----------------------------------------------------------------------------
return {
	"tpope/vim-fugitive",
	cmd = { "G", "Git", "Gdiffsplit", "Gvdiffsplit", "Gblame" },
	keys = {
		{ "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
		{ "<leader>gd", "<cmd>Gvdiffsplit<CR>", desc = "Git diff (vertical)" },
		{ "<leader>gD", "<cmd>Gdiffsplit<CR>", desc = "Git diff (horizontal)" },
		{ "<leader>gb", "<cmd>Gblame<CR>", desc = "Git blame current file" },
		{ "<leader>gh", "<cmd>0Gclog<CR>", desc = "Git commit log (file)" },
	},
	init = function()
		-- Enable Fugitive's use of delta for diffs if installed
		if vim.fn.executable("delta") == 1 then
			vim.g.fugitive_diff_option = "--tty --paginate --color=always | delta --dark"
			vim.g.fugitive_diff_executable = "delta"
		end
	end,
}
