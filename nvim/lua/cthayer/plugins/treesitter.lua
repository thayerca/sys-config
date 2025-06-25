-- Plugin: nvim-treesitter/nvim-treesitter
-- URL: https://github.com/nvim-treesitter/nvim-treesitter
-- Description: Syntax highlighting, code navigation, and more using Tree-sitter parsers.
-- How it works: Installs and configures language parsers for better syntax awareness and code manipulation.
-- Usage Tips:
--   - Run :TSInstall <language> to install a parser manually
--   - Use incremental selection: <C-space> to expand, <bs> to shrink selection
--   - Enable `nvim-ts-autotag` for auto-updating HTML/XML tags on edit
return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag", -- For auto-closing/renaming tags in HTML/JSX
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			-- Required empty table to suppress warnings about missing modules
			modules = {},

			-- Auto-install missing parsers when entering buffer
			auto_install = true,

			-- Install parsers synchronously (only affects ensure_installed)
			sync_install = false,

			-- Parsers to ignore installing
			ignore_install = {},

			-- Enable syntax highlighting
			highlight = {
				enable = true,
			},

			-- Enable smart indentation
			indent = {
				enable = true,
			},

			-- Enable auto-tagging for HTML, JSX, etc.
			autotag = {
				enable = true,
			},

			-- Enable incremental selection
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					node_decremental = "<BS>",
					scope_incremental = false, -- set to a key if desired
				},
			},

			-- Ensure the following parsers are always installed
			ensure_installed = {
				"json",
				"yaml",
				"html",
				"css",
				"markdown",
				"markdown_inline",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"vimdoc",
				"python",
			},
		})
	end,
}
