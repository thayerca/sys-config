-- ------------------------------------------------------------------------------
-- dressing.nvim (stevearc/dressing.nvim) — Better input/select UI
-- ------------------------------------------------------------------------------
-- What it does: Replaces vim.input() and vim.select() with a styled UI used
--   by LSP rename, Telescope, and other plugins for prompts and menus.
-- Keymaps: None; overrides built-in prompts when they are shown.
-- Notes: Loads on VeryLazy; customize with require("dressing").setup({}).
-- ------------------------------------------------------------------------------

return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
}
