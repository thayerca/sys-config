-- ------------------------------------------------------------------------------
-- claudecode.nvim (coder/claudecode.nvim) — Claude Code IDE in Neovim
-- ------------------------------------------------------------------------------
-- What it does: Neovim integration for Claude Code (Anthropic's AI coding assistant).
--   Uses the same WebSocket MCP protocol as the official VS Code extension.
--   Requires: Claude Code CLI (claude doctor), folke/snacks.nvim (dependency).
-- Keymaps: <leader>c (group), <leader>cc toggle, <leader>cf focus, <leader>cw switch
--   (normal mode). In Claude terminal input: Alt+w switches to editor (terminal-mode).
--   <leader>cs send, <leader>cA/cd diff. (cA avoids conflict with LSP <leader>ca.)
-- ------------------------------------------------------------------------------

return {
	"coder/claudecode.nvim",
	dependencies = { "folke/snacks.nvim" },
	config = function()
		require("claudecode").setup()
		-- From terminal mode (e.g. typing in Claude): Alt+w → switch to other window
		vim.keymap.set("t", "<A-w>", "<C-\\><C-n><C-w>p", { desc = "Switch to other window (editor ↔ Claude)" })
	end,
	keys = {
		{ "<leader>cc", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude" },
		{ "<leader>cf", "<cmd>ClaudeCodeFocus<CR>", desc = "Focus Claude" },
		{ "<leader>cw", "<C-w>p", desc = "Switch to other window (editor ↔ Claude)" },
		{ "<leader>cr", "<cmd>ClaudeCode --resume<CR>", desc = "Resume Claude" },
		{ "<leader>cC", "<cmd>ClaudeCode --continue<CR>", desc = "Continue Claude" },
		{ "<leader>cm", "<cmd>ClaudeCodeSelectModel<CR>", desc = "Select Claude model" },
		{ "<leader>cb", "<cmd>ClaudeCodeAdd %<CR>", desc = "Add current buffer" },
		{ "<leader>cs", "<cmd>ClaudeCodeSend<CR>", mode = "v", desc = "Send to Claude" },
		{
			"<leader>cs",
			"<cmd>ClaudeCodeTreeAdd<CR>",
			desc = "Add file (neo-tree/oil)",
			ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
		},
		{ "<leader>cA", "<cmd>ClaudeCodeDiffAccept<CR>", desc = "Accept diff" },
		{ "<leader>cd", "<cmd>ClaudeCodeDiffDeny<CR>", desc = "Deny diff" },
	},
}
