-- ------------------------------------------------------------------------------
-- kulala.nvim (mistweaverco/kulala.nvim) — HTTP client for Neovim
-- ------------------------------------------------------------------------------
-- What it does: Execute HTTP requests directly from .http / .rest files inside
--   Neovim. Supports variables, environments, authentication, response preview,
--   and scripting. A Neovim-native alternative to REST Client / Insomnia.
-- Keymaps (active in .http / .rest buffers):
--   <leader>kr  — send request under cursor
--   <leader>kA  — send all requests in file
--   <leader>kt  — toggle response window
--   <leader>kc  — copy response to clipboard
--   <leader>ke  — set environment (dev/staging/prod)
--   <leader>kl  — jump to last response
-- File types: .http and .rest files. Write requests in standard HTTP format:
--   GET https://api.example.com/users
--   Content-Type: application/json
--
--   ###
--   POST https://api.example.com/users
--   Content-Type: application/json
--
--   { "name": "casey" }
-- Notes: Requires curl (already in Brewfile). Supports dotenv files for secrets.
-- ------------------------------------------------------------------------------

return {
	"mistweaverco/kulala.nvim",
	ft = { "http", "rest" },
	keys = {
		{ "<leader>kr", function() require("kulala").run() end,                desc = "Kulala: send request",       ft = "http" },
		{ "<leader>kA", function() require("kulala").run_all() end,            desc = "Kulala: send all requests",  ft = "http" },
		{ "<leader>kt", function() require("kulala").toggle_view() end,        desc = "Kulala: toggle response",    ft = "http" },
		{ "<leader>kc", function() require("kulala").copy() end,               desc = "Kulala: copy response",      ft = "http" },
		{ "<leader>ke", function() require("kulala").set_selected_env() end,   desc = "Kulala: set environment",    ft = "http" },
		{ "<leader>kl", function() require("kulala").jump_prev() end,          desc = "Kulala: previous response",  ft = "http" },
	},
	opts = {
		-- Show response headers in the split (set false for body-only)
		show_headers = true,
		-- Default response split: "horizontal" or "vertical"
		split_direction = "vertical",
		-- Default environment variable file (relative to workspace root)
		environment_file = ".env",
	},
}
