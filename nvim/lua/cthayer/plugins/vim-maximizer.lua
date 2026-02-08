-- ------------------------------------------------------------------------------
-- vim-maximizer (szw/vim-maximizer) — Maximize current split
-- ------------------------------------------------------------------------------
-- What it does: Toggles the current window to fill the screen (hides others);
--   toggle again to restore. Loads on command/key.
-- Keymaps: <leader>sm — MaximizerToggle
-- Notes: cmd = MaximizerToggle; keys lazy-load the plugin.
-- ------------------------------------------------------------------------------

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
