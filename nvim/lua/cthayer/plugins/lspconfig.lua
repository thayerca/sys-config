-- ------------------------------------------------------------------------------
-- nvim-lspconfig (neovim/nvim-lspconfig) — LSP client and server configs
-- ------------------------------------------------------------------------------
-- What it does: Configures the Neovim LSP client and sets up language servers
--   (bashls, pyright, lua_ls, etc.). Only starts a server if its binary is in
--   PATH, so optional servers (e.g. ltex-ls, ansiblels) won't error when missing.
-- Keymaps (LSP attach): gD gd gi gt gR, <leader>ca rn d D, [d ]d, K, <leader>rs
-- Notes: Install servers via Mason or system; add new servers to the `servers` table.
-- ------------------------------------------------------------------------------

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

		-- Diagnostic signs in the gutter
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Keymaps on LSP attach (buffer-local)
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }
				keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", unpack(opts) })
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "LSP definitions", unpack(opts) })
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "LSP implementations", unpack(opts) })
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "LSP type definitions", unpack(opts) })
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "LSP references", unpack(opts) })
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions", unpack(opts) })
				-- Rename: use inc-rename (inline preview) when available, else LSP rename
				keymap.set("n", "<leader>rn", function()
					local ok = pcall(require, "inc_rename")
					if ok then
						vim.cmd("IncRename " .. vim.fn.expand("<cword>"))
					else
						vim.lsp.buf.rename()
					end
				end, { desc = "Rename (inline preview)", unpack(opts) })
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics", unpack(opts) })
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Buffer diagnostics", unpack(opts) })
				keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic", unpack(opts) })
				keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic", unpack(opts) })
				keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover", unpack(opts) })
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP", unpack(opts) })
			end,
		})

		-- Server configs: only setup if the server's executable is in PATH (avoids spawn errors for optional LSPs like ltex-ls)
		local servers = {
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
			emmet_ls = {
				filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
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
			graphql = {
				filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
			},
			r_language_server = {},
			ltex = {},        -- LaTeX/markdown grammar/spell; install ltex-ls or omit from list
			ansiblels = {},   -- Ansible; install ansible-language-server or omit
			lemminx = {},    -- XML; install lemminx or omit
			groovyls = {},   -- Groovy; install groovyls or omit
		}

		for server, config in pairs(servers) do
			local ok, default_config = pcall(function()
				return lspconfig[server].document_config.default_config
			end)
			local cmd = ok and default_config and default_config.cmd and default_config.cmd[1]
			if type(cmd) == "string" and vim.fn.executable(cmd) == 1 then
				config.capabilities = capabilities
				lspconfig[server].setup(config)
			end
			-- If cmd missing or not in PATH, skip (no spawn error); install the binary to enable
		end
	end,
}
