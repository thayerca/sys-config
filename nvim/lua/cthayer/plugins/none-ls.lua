-- ------------------------------------------------------------------------------
-- none-ls.nvim (nvimtools/none-ls.nvim) — Formatters, linters, spell as LSP
-- ------------------------------------------------------------------------------
-- What it does: Registers external tools (stylua, prettier, shfmt, yamllint,
--   markdownlint, hadolint, spell) as LSP sources so vim.lsp.buf.format() and
--   diagnostics use them. Some diagnostics commented out until executables exist.
-- Keymaps: <leader>gf — format file (LSP or null-ls).
-- Notes: Install tools via Mason or system; add/remove sources in setup.
-- ------------------------------------------------------------------------------

return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
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
				-- 🔍 Linters
				--TODO: fix these built-ins executables are not being found
				--diagnostics.ruff, -- Python (linter)
				--diagnostics.eslint_d, -- JS/TS
				--diagnostics.shellcheck, -- Shell
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
