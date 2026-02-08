-- ------------------------------------------------------------------------------
-- mason.nvim (williamboman/mason.nvim) — LSP/formatter/linter installer
-- ------------------------------------------------------------------------------
-- What it does: Installs LSP servers (lua_ls, pyright, etc.) and tools (stylua,
--   prettier, ruff, bash-language-server) via Mason. ensure_installed on startup.
-- Keymaps: :Mason to open UI; LSP/keymaps come from lspconfig.
-- Notes: mason-lspconfig bridges Mason with lspconfig; mason-tool-installer for non-LSP tools.
-- ------------------------------------------------------------------------------

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"cssls",
				"html",
				"bashls",
				"pyright",
				"jsonls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"ruff", -- Formatter + linter
				"stylua", -- Lua formatter
				"bash-language-server",
				"prettier",
			},
		})
	end,
}
