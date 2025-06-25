-- Plugin: vim-maximizer (https://github.com/szw/vim-maximizer)
-- Description: Toggle maximizing the current split window in Neovim
-- How it works: Temporarily hides other windows to focus on the active split; toggles back
-- Usage Tips:
--   - Use `<leader>sm` to toggle maximization
--   - Works well with split-heavy workflows or tmux integration
return {
	"szw/vim-maximizer",
	lazy = true,
	cmd = { "MaximizerToggle" }, -- Load only when the command is called
	keys = {
		{
			"<leader>sm",
			"<cmd>MaximizerToggle<CR>",
			desc = "Maximize/minimize split window",
		},
	},
}
