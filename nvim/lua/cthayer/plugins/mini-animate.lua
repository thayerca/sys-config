-- ------------------------------------------------------------------------------
-- mini.animate (echasnovski/mini.animate) — Subtle scroll/cursor animations
-- ------------------------------------------------------------------------------
-- What it does: Adds smooth animations for scroll, cursor move, and window
--   resize. Can be disabled per animation in opts if distracting.
-- Keymaps: None; affects default motions.
-- Notes: No keymap conflicts. Set enabled = false for a module to disable it.
-- ------------------------------------------------------------------------------

return {
	"echasnovski/mini.animate",
	event = "VeryLazy",
	opts = function()
		return {
			cursor = { enable = true },
			scroll = { enable = true },
			resize = { enable = true },
			open = { enable = true },
			close = { enable = true },
		}
	end,
	config = function(_, opts)
		require("mini.animate").setup(opts)
	end,
}
