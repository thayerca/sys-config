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
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		require("formatter").setup({
			filetype = {
				sh = {
					-- Shell Script Formatter
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
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
