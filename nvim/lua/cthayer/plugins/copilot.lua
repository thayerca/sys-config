-- ------------------------------------------------------------------------------
-- copilot-cmp (zbirenbaum/copilot-cmp) — GitHub Copilot in completion menu
-- ------------------------------------------------------------------------------
-- What it does: Injects Copilot suggestions into nvim-cmp completion. Copilot
--   Lua runs the backend; suggestion/panel can be toggled separately.
-- Keymaps: Same as nvim-cmp (Tab to accept, etc.); Copilot appears as a source.
-- Notes: Depends on copilot.lua; suggestion/panel disabled here, enable if needed.
-- ------------------------------------------------------------------------------

return {
	"zbirenbaum/copilot-cmp",
	event = "InsertEnter",
	config = function()
		require("copilot_cmp").setup()
	end,
	dependencies = {
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
}
