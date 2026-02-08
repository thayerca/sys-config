-- ------------------------------------------------------------------------------
-- flash.nvim (folke/flash.nvim) — Label-based jump (EasyMotion-style)
-- ------------------------------------------------------------------------------
-- What it does: Press a key (we use <leader>j), then type a label to jump the
--   cursor to any visible position. Does not use "s" to avoid conflict with substitute.nvim.
-- Keymaps: <leader>j (jump; no conflict with existing leader keys).
-- Notes: Can also use in remote (tmux/ssh) with opts. Search mode: optional.
-- ------------------------------------------------------------------------------

return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"<leader>j",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash: jump to label",
		},
	},
}
