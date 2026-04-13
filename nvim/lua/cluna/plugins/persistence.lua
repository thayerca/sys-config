-- ------------------------------------------------------------------------------
-- persistence.nvim (folke/persistence.nvim) — Automatic session management
-- ------------------------------------------------------------------------------
-- What it does: Automatically saves the current Neovim session (open buffers,
--   window layout, cursor positions) when you exit, keyed by the current
--   working directory. Restores that session the next time you open Neovim
--   in the same directory. No manual :mksession needed.
-- Keymaps (all under <leader>q):
--   <leader>qs  — restore session for current directory
--   <leader>ql  — restore last session (most recently saved, any directory)
--   <leader>qd  — delete session for current directory
--   <leader>qq  — stop persistence (don't save on exit this time)
-- Notes: Sessions are stored in vim.fn.stdpath("state") .. "/sessions/".
--   Works well with telescope-project or harpoon for per-project workflows.
-- ------------------------------------------------------------------------------

return {
	"folke/persistence.nvim",
	event = "BufReadPre",  -- restore session before first buffer is read

	keys = {
		{ "<leader>qs", function() require("persistence").load() end,                desc = "Session: restore for cwd" },
		{ "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Session: restore last" },
		{ "<leader>qd", function() require("persistence").stop() end,                desc = "Session: delete / stop saving" },
		{ "<leader>qq", function() require("persistence").stop() end,                desc = "Session: quit without saving" },
	},

	opts = {
		-- Save dir: ~/.local/state/nvim/sessions/ (XDG compliant)
		dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
		-- Objects to save in the session
		options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
		-- Auto-save session on VimLeavePre
		pre_save = nil,
	},
}
