-- ------------------------------------------------------------------------------
-- nvim-lspconfig (neovim/nvim-lspconfig) — LSP client and server configs
-- ------------------------------------------------------------------------------
-- What it does: Configures the Neovim LSP client via vim.lsp.config (Neovim 0.11+).
--   Only enables a server if its binary is in PATH (avoids spawn errors for optional LSPs).
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
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()
		local keymap = vim.keymap

		-- File operations for neo-tree (nvim-lsp-file-operations); add to all LSP configs
		local ok, lsp_file_ops = pcall(require, "lsp-file-operations")
		if ok and lsp_file_ops and lsp_file_ops.default_capabilities then
			capabilities = vim.tbl_deep_extend("force", capabilities, lsp_file_ops.default_capabilities())
		end

		-- Diagnostic signs in the gutter
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Keymaps and server-specific behavior on LSP attach (buffer-local)
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if not client then
					return
				end
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
				keymap.set("n", "<leader>rs", "<cmd>lsp restart<CR>", { desc = "Restart LSP", unpack(opts) })
				-- Svelte: notify server on TS/JS file changes (replaces old on_attach)
				if client.name == "svelte" then
					vim.api.nvim_create_autocmd("BufWritePost", {
						group = vim.api.nvim_create_augroup("SvelteTsJsNotify", { clear = false }),
						pattern = { "*.js", "*.ts" },
						callback = function(ctx)
							client.notify("$/onDidChangeTsOrJsFile", { uri = vim.uri_from_fname(ctx.file) })
						end,
					})
				end
			end,
		})

		-- Server configs: register with vim.lsp.config, enable only if executable is in PATH (see :help lspconfig-nvim-0.11)
		local servers = {
			-- Shell: bash-language-server; covers .sh and .bash (install via Mason or: npm i -g bash-language-server)
			bashls = {
				filetypes = { "sh", "bash" },
			},
			cssls = {},
			dockerls = {},
			eslint = {},
			gopls = {},
			html = {},
			jsonls = {},
			-- Lua: lua_ls (sumneko); Neovim config and general Lua (install via Mason or system)
			lua_ls = {
				filetypes = { "lua" },
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						completion = { callSnippet = "Replace" },
						workspace = { checkThirdParty = false },
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
			svelte = {},
			astro = {},
			volar = {},
			graphql = {
				filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
			},
			r_language_server = {},
			ltex = {},        -- LaTeX/markdown grammar/spell; install ltex-ls or omit from list
			ansiblels = {},   -- Ansible; install ansible-language-server or omit
			lemminx = {},     -- XML; install lemminx or omit
			groovyls = {},    -- Groovy; install groovyls or omit
		}

		for server, custom in pairs(servers) do
			local config = vim.tbl_extend("keep", custom, { capabilities = capabilities })
			vim.lsp.config(server, config)
			-- Only enable if the server's cmd is available (nvim-lspconfig provides default configs with cmd)
			local resolved = vim.lsp.config[server]
			local cmd = resolved and resolved.cmd and resolved.cmd[1]
			if type(cmd) == "string" and vim.fn.executable(cmd) == 1 then
				vim.lsp.enable(server)
			end
		end
	end,
}
