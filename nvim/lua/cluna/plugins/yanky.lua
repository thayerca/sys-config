-- ------------------------------------------------------------------------------
-- yanky.nvim (gbprod/yanky.nvim) — Yank ring and paste enhancements
-- ------------------------------------------------------------------------------
-- What it does: Maintains a yank history ring so you can cycle through previous
--   yanks after pasting. Highlights the yanked region briefly. Integrates with
--   Telescope for a fuzzy yank-history picker.
-- Keymaps:
--   p / P         — enhanced paste (replaces built-in; same behavior by default)
--   <C-n> / <C-p> — after pasting, cycle to next/previous yank in ring
--   y             — enhanced yank (same behavior, adds to ring)
--   <leader>fy    — Telescope yank history picker
-- Notes: Uses vim.highlight.on_yank internally (replaces autocmd approach).
--   Ring is stored in memory per session; not persisted across restarts.
-- Depends on: nvim-nio (for async operations), telescope.nvim (picker).
-- ------------------------------------------------------------------------------

return {
	"gbprod/yanky.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "y",          "<Plug>(YankyYank)",                 mode = { "n", "x" }, desc = "Yanky: yank" },
		{ "p",          "<Plug>(YankyPutAfter)",             mode = { "n", "x" }, desc = "Yanky: paste after" },
		{ "P",          "<Plug>(YankyPutBefore)",            mode = { "n", "x" }, desc = "Yanky: paste before" },
		{ "gp",         "<Plug>(YankyGPutAfter)",            mode = { "n", "x" }, desc = "Yanky: gput after" },
		{ "gP",         "<Plug>(YankyGPutBefore)",           mode = { "n", "x" }, desc = "Yanky: gput before" },
		{ "<C-n>",      "<Plug>(YankyCycleForward)",                               desc = "Yanky: cycle forward in ring" },
		{ "<C-p>",      "<Plug>(YankyCycleBackward)",                              desc = "Yanky: cycle backward in ring" },
		{ "<leader>fy", function() require("telescope").extensions.yank_history.yank_history({}) end,
		                                                                            desc = "Telescope: yank history" },
	},

	config = function()
		require("yanky").setup({
			ring = {
				history_length    = 50,
				storage           = "memory",  -- keep in memory (fast, no persistence)
				sync_with_numbered_registers = true,
			},
			highlight = {
				on_put  = true,
				on_yank = true,
				timer   = 150,  -- ms to highlight the yanked region
			},
		})

		-- Register Telescope extension
		local ok, telescope = pcall(require, "telescope")
		if ok then
			telescope.load_extension("yank_history")
		end
	end,
}
