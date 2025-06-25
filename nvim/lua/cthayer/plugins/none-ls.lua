-- -----------------------------------------------------------------------------
-- 🧰 Plugin: none-ls.nvim
-- https://github.com/nvimtools/none-ls.nvim
--
-- Provides additional LSP-like capabilities using external tools such as
-- formatters, linters, and completion engines. Configured modularly here
-- for flexibility and easy removal or addition of sources.
--
-- 🧠 How it works:
-- Registers formatters, linters, and completion tools as LSP sources so they
-- can be invoked via LSP actions (e.g. `vim.lsp.buf.format()`).
--
-- 💡 Usage Tips:
-- - Use `<leader>gf` to format the current file with LSP/null-ls.
-- - Sources are lazily used per filetype when supported.
-- - Make sure tools are installed locally or globally (e.g. via Mason, Homebrew, etc).
-- -----------------------------------------------------------------------------

return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics
		local completion = null_ls.builtins.completion

		null_ls.setup({
			sources = {
				-- 🧹 Formatters
				formatting.stylua, -- Lua
				formatting.prettier, -- JS/TS, HTML, etc.
				formatting.shfmt, -- Shell
				formatting.beautysh, -- Alternative Shell formatter
				formatting.dockfmt, -- Dockerfiles
				formatting.terraform_fmt, -- Terraform
				formatting.sqlfluff, -- SQL
				formatting.pg_format, -- PostgreSQL
				formatting.rustfmt, -- Rust
				formatting.gofmt, -- Go
				formatting.goimports, -- Go
				formatting.ruff, -- Python (formatter)

				-- 🔍 Linters
				diagnostics.ruff, -- Python (linter)
				diagnostics.eslint_d, -- JS/TS
				diagnostics.stylelint, -- CSS/SCSS
				diagnostics.yamllint, -- YAML
				diagnostics.shellcheck, -- Shell
				diagnostics.markdownlint, -- Markdown

				-- 🔤 Completion
				completion.spell, -- Spell checking
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format file (LSP or null-ls)" })
	end,
}
