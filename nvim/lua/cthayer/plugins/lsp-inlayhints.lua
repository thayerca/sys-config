-- ------------------------------------------------------------------------------
-- lsp-inlayhints.nvim (lvimuser/lsp-inlayhints.nvim) — Inlay hints (params, types)
-- ------------------------------------------------------------------------------
-- What it does: Shows inlay hints (parameter names, types) from LSP. Toggle
--   with <leader>uh so it doesn't conflict with existing keys (leader+u free).
-- Keymaps: <leader>uh — toggle inlay hints.
-- Notes: Requires LSP with inlay hint support. Format on save can clear; opts can disable.
-- ------------------------------------------------------------------------------

return {
	"lvimuser/lsp-inlayhints.nvim",
	event = "LspAttach",
	opts = {
		inlay_hints = {
			highlight = "Comment",
			only_current_line = false,
		},
	},
	config = function(_, opts)
		local inlay = require("lsp-inlayhints")
		inlay.setup(opts)
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("LspInlayHints", {}),
			callback = function(ev)
				inlay.on_attach(ev.data.client, ev.buf)
			end,
		})
		vim.keymap.set("n", "<leader>uh", function() inlay.toggle() end, { desc = "Toggle inlay hints" })
	end,
}
