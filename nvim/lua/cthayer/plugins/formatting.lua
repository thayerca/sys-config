-- -----------------------------------------------------------------------------
-- 🧹 Plugin: conform.nvim + formatter.nvim
-- https://github.com/stevearc/conform.nvim
-- https://github.com/mhartington/formatter.nvim
--
-- Provides format-on-save and manual formatting with support for multiple
-- filetypes and external formatters. `conform.nvim` is the primary tool,
-- while `formatter.nvim` is used for shell-specific formatting.
--
-- 💡 How it works:
-- - `conform.nvim` auto-formats files using language-specific tools
--   (like `black` for Python, `prettier` for HTML/JS/CSS, `stylua` for Lua).
-- - `formatter.nvim` is used for shell scripts (`.sh`, `.shrc`) via `shfmt`.
-- - `<leader>mp` manually formats the buffer or visual selection.
--
-- 🧠 Tips:
-- - Conform will auto-format on save unless you disable it.
-- - You can configure `.shrc` files to be recognized properly via `autocmd`.
-- - Install formatters using your system package manager or Mason.
-- -----------------------------------------------------------------------------

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
				markdown = { "prettier" },
				["markdown.mdx"] = { "prettier" },

				-- 💻 JavaScript / TypeScript
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },

				-- 🐍 Python
				python = { "isort", "black" },

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
				timeout_ms = 1000,
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
