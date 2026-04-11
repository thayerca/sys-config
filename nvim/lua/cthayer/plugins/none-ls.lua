return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		local function cond(bin)
			return function()
				return vim.fn.executable(bin) == 1
			end
		end

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua.with({ condition = cond("stylua") }),
				null_ls.builtins.formatting.prettier.with({ condition = cond("prettier") }),
				null_ls.builtins.formatting.black.with({ condition = cond("black") }),
				null_ls.builtins.formatting.isort.with({ condition = cond("isort") }),
				null_ls.builtins.completion.spell,
				null_ls.builtins.diagnostics.pylint.with({
					extra_args = { "--rcfile=" .. vim.fn.expand("~/.pylintrc") },
					condition = cond("pylint"),
				}),
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
