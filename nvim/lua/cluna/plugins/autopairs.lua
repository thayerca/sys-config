-- ------------------------------------------------------------------------------
-- nvim-autopairs (windwp/nvim-autopairs) — Auto-close brackets and quotes
-- ------------------------------------------------------------------------------
-- What it does: Inserts matching pairs ((), {}, "") and integrates with nvim-cmp
--   so completion confirm adds the closing character when appropriate.
-- Keymaps: None; works on insert (typing an opener inserts closer).
-- Notes: Uses Treesitter to avoid pairing inside strings/template literals.
-- ------------------------------------------------------------------------------

return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	dependencies = { "hrsh7th/nvim-cmp" },
	config = function()
		local autopairs = require("nvim-autopairs")

		autopairs.setup({
			check_ts = true, -- Use Treesitter to avoid pairing in certain syntax nodes
			ts_config = {
				lua = { "string" }, -- Don't pair inside lua string nodes
				javascript = { "template_string" }, -- Avoid pairing in JS template strings
				java = false, -- Disable Treesitter checks for Java (optional)
			},
		})

		local cmp = require("cmp")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
