-- -----------------------------------------------------------------------------
-- ⚙️ Plugin: nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig
-- -----------------------------------------------------------------------------

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()
		local keymap = vim.keymap

		-- Diagnostic signs
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Set keymaps on LSP attach
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", unpack(opts) })
				keymap.set(
					"n",
					"gd",
					"<cmd>Telescope lsp_definitions<CR>",
					{ desc = "Show LSP definitions", unpack(opts) }
				)
				keymap.set(
					"n",
					"gi",
					"<cmd>Telescope lsp_implementations<CR>",
					{ desc = "Show LSP implementations", unpack(opts) }
				)
				keymap.set(
					"n",
					"gt",
					"<cmd>Telescope lsp_type_definitions<CR>",
					{ desc = "Show LSP type definitions", unpack(opts) }
				)
				keymap.set(
					"n",
					"gR",
					"<cmd>Telescope lsp_references<CR>",
					{ desc = "Show LSP references", unpack(opts) }
				)
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions", unpack(opts) })
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename", unpack(opts) })
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics", unpack(opts) })
				keymap.set(
					"n",
					"<leader>D",
					"<cmd>Telescope diagnostics bufnr=0<CR>",
					{ desc = "Buffer diagnostics", unpack(opts) }
				)
				keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic", unpack(opts) })
				keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic", unpack(opts) })
				keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover doc", unpack(opts) })
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP", unpack(opts) })
			end,
		})

		-- Modular LSP config
		local servers = {
			-- Core LSPs
			bashls = {},
			cssls = {},
			dockerls = {},
			eslint = {},
			gopls = {},
			html = {},
			jsonls = {},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						completion = { callSnippet = "Replace" },
					},
				},
			},
			marksman = {},
			pyright = {},
			tailwindcss = {},
			terraformls = {},
			yamlls = {},
			clangd = {},
			sqlls = {},

			-- Web / JS / TS
			emmet_ls = {
				filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"svelte",
				},
			},
			svelte = {
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePost", {
						pattern = { "*.js", "*.ts" },
						callback = function(ctx)
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
						end,
					})
				end,
			},
			astro = {},
			volar = {},

			-- Misc
			graphql = {
				filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
			},
			r_language_server = {},
			ltex = {},
			ansiblels = {},
			lemminx = {},
			groovyls = {},
		}

		for server, config in pairs(servers) do
			config.capabilities = capabilities
			lspconfig[server].setup(config)
		end
	end,
}
