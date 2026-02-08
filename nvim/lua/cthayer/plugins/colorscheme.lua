-- ------------------------------------------------------------------------------
-- catppuccin.nvim (catppuccin/nvim) — Colorscheme
-- ------------------------------------------------------------------------------
-- What it does: Pastel colorscheme with multiple flavors (mocha, frappe, etc.).
--   Loaded early (priority 1000) so UI plugins pick up highlights.
-- Keymaps: None.
-- Notes: Change flavor to "catppuccin-latte", "catppuccin-frappe", etc. in config.
-- ------------------------------------------------------------------------------

return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
}
