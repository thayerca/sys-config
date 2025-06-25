-- -----------------------------------------------------------------------------
-- 🔗 Plugin: lazygit.nvim
-- https://github.com/kdheepak/lazygit.nvim
--
-- Lightweight wrapper around LazyGit, integrated as a floating window in Neovim.
-- Lazy-loads on command or keypress to improve startup performance.
--
-- 🛠 How it works:
-- - Requires the `lazygit` CLI to be installed (https://github.com/jesseduffield/lazygit)
-- - Opens a floating terminal window running LazyGit
-- - Optional commands include filtering by file, editing config, etc.
--
-- 💡 Usage tips:
-- - Use `<leader>lg` to open LazyGit for the repo
-- - Use `<leader>lG` to open LazyGit scoped to the current file
-- -----------------------------------------------------------------------------

return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	dependencies = {
		"nvim-lua/plenary.nvim", -- required for plugin functionality
	},
	keys = {
		{ "<leader>lg", "<cmd>LazyGit<CR>", desc = "Open LazyGit (repo)" },
		{ "<leader>lG", "<cmd>LazyGitCurrentFile<CR>", desc = "Open LazyGit (current file)" },
		{ "<leader>lC", "<cmd>LazyGitConfig<CR>", desc = "Edit LazyGit config" },
	},
	config = function()
		-- Optional: Tweak floating window appearance
		vim.g.lazygit_floating_window_winblend = 10 -- transparency
		vim.g.lazygit_floating_window_scaling_factor = 0.9
		vim.g.lazygit_use_neovim_remote = 1

		-- Warn if LazyGit CLI is not installed
		if vim.fn.executable("lazygit") == 0 then
			vim.notify("⚠️ LazyGit is not installed on your system.", vim.log.levels.WARN)
		end
	end,
}
