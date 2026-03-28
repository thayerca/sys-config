-- ------------------------------------------------------------------------------
-- conform.nvim (stevearc/conform.nvim) — Format on save and manual format
-- ------------------------------------------------------------------------------
-- What it does: Runs formatters (prettier, black, stylua, shfmt, etc.) on save
--   or on demand. formatter.nvim used for shell/.shrc; conform for the rest.
-- Keymaps: <leader>mp — format buffer or visual selection manually.
-- Notes: Formatters must be installed (Mason or system). .shrc → filetype sh.
-- ------------------------------------------------------------------------------

return {
	"stevearc/conform.nvim",
	dependencies = {
		"mhartington/formatter.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				-- 🖼️ Frontend / Web
				css = { "prettier" },
				scss = { "prettier" },
				less = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "markdownlint", "prettier" },
				["markdown.mdx"] = { "markdownlint", "prettier" },

				-- 💻 JavaScript / TypeScript
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },

				-- 🐍 Python
				-- for phillies stuff keep black
				python = { "isort", "black" },
				-- TODO: for personal stuff
				-- python = { "ruff" },

				-- 🛠️ Lua
				lua = { "stylua" },

				-- 🐚 Shell
				sh = { "shfmt" },

				-- 🐘 SQL
				sql = { "sql-formatter" },

				-- 🐳 Docker
				dockerfile = { "prettier" },

				-- 🔧 Configs
				toml = { "taplo" },
				xml = { "xmlformat" },

				-- 🚀 Systems Languages
				rust = { "rustfmt" },
				go = { "gofmt" },
				java = { "google-java-format" },
				c = { "clang-format" },
				cpp = { "clang-format" },
			},

			-- 🔁 Format-on-save behavior
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 5000,
			},
		})

		-- Separate shell formatter using formatter.nvim (for shfmt edge case)
		require("formatter").setup({
			filetype = {
				sh = {
					function()
						return {
							exe = "shfmt",
							args = { "-i", "2" },
							stdin = true,
						}
					end,
				},
				["shrc"] = {
					function()
						return {
							exe = "shfmt",
							args = { "-i", "2" },
							stdin = true,
						}
					end,
				},
			},
		})

		-- Set filetype for .shrc files
		vim.cmd([[
      autocmd BufRead,BufNewFile *.shrc set filetype=sh
    ]])

		-- 🔑 Keymap for manual format trigger
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
