-- ------------------------------------------------------------------------------
-- nvim-cmp (hrsh7th/nvim-cmp) — Completion menu (LSP, snippets, buffer, path)
-- ------------------------------------------------------------------------------
-- What it does: Completion popup with LSP, Copilot, LuaSnip, buffer, path,
--   cmdline. Uses lspkind for icons; LuaSnip for snippet expansion.
-- Keymaps: <C-k>/<C-j> (prev/next), <C-b>/<C-f> (scroll docs), <C-Space> (complete), <C-e> (abort), <CR> (confirm).
-- Notes: Sources include copilot, nvim_lsp, luasnip, buffer, path, nvim_lua, spell. Cmdline / and :.
-- ------------------------------------------------------------------------------

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- buffer word completion
		"hrsh7th/cmp-path", -- filesystem path completion
		"hrsh7th/cmp-cmdline", -- command-line completion
		"hrsh7th/cmp-nvim-lsp", -- LSP completion
		"hrsh7th/cmp-nvim-lua", -- nvim Lua API completion
		{
			"L3MON4D3/LuaSnip", -- snippet engine
			version = "v2.*",
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- luasnip integration
		"rafamadriz/friendly-snippets", -- preconfigured snippets
		"onsails/lspkind.nvim", -- pictograms in completion
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- Load VSCode-style snippets from friendly-snippets
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			-- Configure completion popup behavior
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			-- Configure snippet expansion
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			-- Key mappings for completion behavior
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item
			}),
			-- Sources used for completion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- LSP first: precise type-aware completions
				{ name = "copilot" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "nvim_lua" },
				{ name = "spell" },
			}),
			-- Customize appearance with icons and ellipsis
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
			-- Sorting behavior for suggestions
			sorting = {
				priority_weight = 2,
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
					cmp.config.compare.kind,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
			-- Customize borders for completion/documentation popups
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
		})

		-- Enable cmdline completion for `/` and `:`
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
