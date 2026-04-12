-- ------------------------------------------------------------------------------
-- none-ls.nvim (nvimtools/none-ls.nvim) — Formatters, linters, spell as LSP
-- ------------------------------------------------------------------------------
-- What it does: Registers external tools (stylua, prettier, shfmt, yamllint,
--   markdownlint, hadolint, spell) as LSP sources so vim.lsp.buf.format() and
--   diagnostics use them. Some diagnostics commented out until executables exist.
-- Keymaps: <leader>gf — format file (LSP or null-ls).
-- Notes: shellcheck removed — not available in none-ls core or extras.
--   Install tools via Mason or system; add/remove sources in setup.
-- ------------------------------------------------------------------------------

return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvimtools/none-ls-extras.nvim", -- eslint_d, shellcheck, and others moved here
	},
	config = function()
		local null_ls = require("null-ls")
		local helpers = require("null-ls.helpers")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics
		local completion = null_ls.builtins.completion

		-- Markdown: auto-fix all markdownlint rules (run with <leader>gf or format-on-save)
		local markdownlint_fix = helpers.formatter_factory({
			command = "markdownlint",
			args = { "--fix", "$FILENAME" },
			to_temp_file = true,
			from_temp_file = true,
		})

		null_ls.setup({
			sources = {
				-- 🧹 Formatters
				formatting.stylua, -- Lua
				formatting.prettier, -- JS/TS, HTML, etc.
				formatting.shfmt, -- Shell
				formatting.terraform_fmt, -- Terraform
				formatting.sqlfluff, -- SQL
				formatting.pg_format, -- PostgreSQL
				-- Python: ruff diagnostics and formatting handled by ruff LSP server
				-- Markdown: fix all markdownlint violations
				{
					method = null_ls.methods.FORMATTING,
					filetypes = { "markdown" },
					generator = markdownlint_fix,
				},

				-- 🔍 Linters
				-- guarded: only register if binary is installed
				-- eslint_d moved to none-ls-extras; shellcheck removed from none-ls (not in core or extras)
				vim.fn.executable("eslint_d") == 1 and require("none-ls.diagnostics.eslint_d") or nil,
				diagnostics.stylelint, -- CSS/SCSS
				diagnostics.yamllint, -- YAML
				diagnostics.markdownlint, -- Markdown
				diagnostics.hadolint, -- Dockerfiles

				-- 🔤 Completion
				completion.spell, -- Spell checking
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format file (LSP or null-ls)" })
	end,
}
