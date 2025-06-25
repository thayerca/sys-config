-- -----------------------------------------------------------------------------
-- 🔗 Plugin: nvim-autopairs
-- https://github.com/windwp/nvim-autopairs
--
-- Automatically inserts matching pairs (e.g. (), {}, "", etc.)
-- and integrates with nvim-cmp to insert closing characters after completion.
-- -----------------------------------------------------------------------------

return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	dependencies = {
		"hrsh7th/nvim-cmp", -- Completion plugin for integration
	},
	config = function()
		-- 🧠 Import autopairs module
		local autopairs = require("nvim-autopairs")

		-- ⚙️ Setup autopairs with Treesitter integration
		autopairs.setup({
			check_ts = true, -- Use Treesitter to avoid pairing in certain syntax nodes
			ts_config = {
				lua = { "string" }, -- Don't pair inside lua string nodes
				javascript = { "template_string" }, -- Avoid pairing in JS template strings
				java = false, -- Disable Treesitter checks for Java (optional)
			},
		})

		-- 🔗 Integration with nvim-cmp for autopair on completion confirm
		local cmp = require("cmp")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
