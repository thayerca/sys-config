-- -----------------------------------------------------------------------------
-- 🎨 Plugin: catppuccin.nvim
-- https://github.com/catppuccin/nvim
--
-- A soothing pastel colorscheme for Neovim with multiple flavor variants.
-- Works well with LSP, Treesitter, and UI plugins like bufferline and lualine.
--
-- 🌈 How It Works:
-- Loads the Catppuccin colorscheme on startup using the "mocha" flavor.
-- Priority ensures it's loaded before other UI plugins that depend on highlights.
--
-- 🧠 Usage Tips:
-- - Change the flavor by using: "catppuccin-latte", "catppuccin-frappe", etc.
-- - Customize further with `require("catppuccin").setup()` for transparency,
--   integrations, or styles.
-- -----------------------------------------------------------------------------

return {
	{
		"catppuccin/nvim",
		lazy = false, -- Load immediately on startup
		name = "catppuccin", -- Alias for readability
		priority = 1000, -- Load before all other plugins
		config = function()
			vim.cmd.colorscheme("catppuccin-mocha") -- Set preferred flavor
		end,
	},
}
