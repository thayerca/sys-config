-- ------------------------------------------------------------------------------
-- lsp_signature (ray-x/lsp_signature.nvim) — Function signature on type
-- ------------------------------------------------------------------------------
-- What it does: Shows function signature and docs in a floating window as you
--   type (e.g. when calling a function). No keymap; triggers automatically.
-- Keymaps: None; appears on insert. Optional: move with ]h and [h in signature help.
-- Notes: No conflict. Can customize border, max_height, etc. in opts.
-- ------------------------------------------------------------------------------

return {
	"ray-x/lsp_signature.nvim",
	event = "LspAttach",
	opts = {
		bind = true,
		handler_opts = { border = "rounded" },
		hint_enable = true,
		hint_prefix = "󰘴 ",
		hi_parameter = "LspSignatureActiveParameter",
		zindex = 50,
		max_height = 12,
		max_width = 80,
		wrap = true,
	},
}
