-- ------------------------------------------------------------------------------
-- conform.nvim (stevearc/conform.nvim) — Format on save and manual format
-- ------------------------------------------------------------------------------
-- What it does: Runs formatters (prettier, black, stylua, shfmt, etc.) on save
--   or on demand.
-- Keymaps: <leader>mp — format buffer or visual selection manually.
-- Notes: Formatters must be installed (Mason or system). .shrc → filetype sh.
-- ------------------------------------------------------------------------------

return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- Register .shrc extension as shell filetype (idiomatic Neovim 0.8+ API)
		vim.filetype.add({ extension = { shrc = "sh" } })

		local conform = require("conform")

		conform.setup({
			-- Suppress notifications when a formatter binary is not installed.
			-- Formatters silently skip; LSP fallback handles the rest.
			notify_on_error = false,

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
				python = { "isort", "black" },

				-- 🛠️ Lua
				lua = { "stylua" },

				-- 🐚 Shell (covers .sh and .shrc via vim.filetype.add above)
				sh = { "shfmt" },

				-- 🐘 SQL
				sql = { "sql-formatter" },

				-- 🐳 Docker
				dockerfile = { "prettier" },

				-- 🌍 Terraform
				terraform = { "terraform_fmt" },
				["terraform-vars"] = { "terraform_fmt" },

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

		-- 🔑 Keymaps for manual format trigger
		local fmt = function()
			conform.format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
		end
		vim.keymap.set({ "n", "v" }, "<leader>mp", fmt, { desc = "Format file or range (in visual mode)" })
		vim.keymap.set("n", "<leader>gf", fmt, { desc = "Format file (conform)" })
	end,
}
