-- -----------------------------------------------------------------------------
-- 💄 Plugin: dressing.nvim
-- https://github.com/stevearc/dressing.nvim
--
-- Enhances built-in UI prompts like vim.input() and vim.select() with a
-- more stylish and configurable interface, improving the UX of Neovim core
-- and other plugins that rely on these built-ins (e.g., Telescope, LSP).
--
-- Usage:
--   dressing.nvim automatically overrides vim.input() and vim.select()
--   when lazy-loaded. No additional configuration is required unless
--   you want to customize the behavior.
--
-- Example:
--   Used by plugins like `nvim-lspconfig`, `noice.nvim`, and `telescope.nvim`
--   for better selection menus, renaming, or command prompts.
--
-- Tips:
--   - Works great when paired with `noice.nvim`
--   - You can override prompt behavior using `require("dressing").setup({})`
-- -----------------------------------------------------------------------------

return {
	"stevearc/dressing.nvim",
	event = "VeryLazy", -- Delay load until vim.input or vim.select is called
}
