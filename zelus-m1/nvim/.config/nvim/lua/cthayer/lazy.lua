local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

return require("lazy").setup({
  -- Litee.nvim: a framework for building Neovim plugins and UI components
  { "ldelossa/litee.nvim", event = "VeryLazy" },

  -- Color theme
  -- Kanagawa: Inspired by the colors of the famous Japanese artwork
  { "rebelot/kanagawa.nvim", event = "VeryLazy", priority = 1000, },

  -- gh.nvim: Integration with GitHub features
  {
    "ldelossa/gh.nvim",
    event = "VeryLazy",
    dependencies = { "ldelossa/litee.nvim" },
  },

   -- lsp-zero.nvim: A batteries-included LSP (Language Server Protocol) configuration.
  {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" }, -- Basic configurations for Neovim's LSP client
      {
        "williamboman/mason.nvim",
        config = function()
          require("mason").setup()
        end
      },
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
        local mason_tools = require("cthayer.mason_tools")
        require("mason-lspconfig").setup({
          ensure_installed = mason_tools,  -- Automatically install specified LSP servers
          automatic_installation = true,
        })
        end
      },

      -- Autocompletion plugins
      { "hrsh7th/nvim-cmp" }, -- Autocompletion plugin for Neovim
      { "hrsh7th/cmp-buffer" }, -- nvim-cmp source for buffer words
      { "hrsh7th/cmp-path" }, -- nvim-cmp source for filesystem paths
      { "saadparwaiz1/cmp_luasnip" }, -- nvim-cmp source for LuaSnip
      { "hrsh7th/cmp-nvim-lsp" }, -- nvim-cmp source for Neovim's built-in LSP
      { "hrsh7th/cmp-nvim-lua" }, -- nvim-cmp source for Neovim Lua API

      -- Snippets
      { "L3MON4D3/LuaSnip" }, -- Snippet engine for Neovim
      { "rafamadriz/friendly-snippets" }, -- Collection of snippets for multiple languages
    },
  },
  -- Nvim-R: R support for Neovim, enhancing R language development.
  { "jalvesaq/Nvim-R",
    config = function()
      vim.g.R_assign = 0  -- Disable automatic conversion of _ to <-
    end
  },
  -- ncm-R: Autocompletion for R language using NCM.
  { "gaalcaras/ncm-R" },
  -- ALE: Asynchronous Lint Engine, a plugin for linting and fixing code.
  { "dense-analysis/ale" },
    -- todo-comments.nvim: Highlight, list, and search todo comments in your projects.
  {
     "folke/todo-comments.nvim",
     event = "VeryLazy",
     dependencies = "nvim-lua/plenary.nvim",
     config = function()
       require("todo-comments").setup({
         vim.keymap.set("n", "<leader>tt", ":TodoTrouble<CR>", { noremap = true, silent = true }),
         vim.keymap.set("n", "<leader>tc", ":TodoTelescope<CR>", { noremap = true, silent = true }),
        })
    end,
  },
  -- nice diagnostic errors
  { "neovim/nvim-lspconfig", event = "VeryLazy" }, -- Basic configurations for Neovim's LSP client
  -- bufferline.nvim: A snazzy buffer line (tab bar) for Neovim, with devicons support.
  { "akinsho/bufferline.nvim", dependencies = "nvim-tree/nvim-web-devicons", event = "VeryLazy" },
  
  -- alpha-nvim: A Lua powered greeter like vim-startify / dashboard-nvim.
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  },
    -- telescope.nvim: Highly extendable fuzzy finder over lists.
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- vim-system-copy: System copy and paste support.
  { "christoomey/vim-system-copy", event = "VeryLazy" },
  -- vim-surround: Provides mappings to easily delete, change, and add surroundings.
  { "tpope/vim-surround", event = "VeryLazy" },

  -- vim-textobj-user: Framework for creating text objects.
  { "kana/vim-textobj-user", event = "VeryLazy" },
  -- vim-textobj-python: Python text objects for Vim, requires vim-textobj-user.
  { "bps/vim-textobj-python", event = "VeryLazy" },
  -- nvim-colorizer.lua: A fast colorizer for Neovim.
  { "norcalli/nvim-colorizer.lua", event = "VeryLazy" },
  -- vim-commentary: Comment stuff out with ease.
  { "tpope/vim-commentary", event = "VeryLazy" },

  -- nvim-treesitter: Neovim treesitter configurations for better syntax highlighting and additional text objects.
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects", -- Additional text objects based on treesitter
      "nvim-treesitter/nvim-treesitter-context", -- Show code context
    },
  },


  -- Python Black formatter
  { "psf/black", event = "VeryLazy" },

  -- vim-fugitive: A Git wrapper so awesome, it should be illegal.
  { "tpope/vim-fugitive", event = "VeryLazy" },
  -- vim-rhubarb: Complements vim-fugitive by adding GitHub integration.
  { "tpope/vim-rhubarb", event = "VeryLazy" },

  -- lazygit.nvim: Integration with lazygit, a simple terminal UI for git commands.
  { "kdheepak/lazygit.nvim", event = "VeryLazy" },
  -- diffview.nvim: A Git diff viewer.
  { "sindrets/diffview.nvim", event = "VeryLazy" },
  -- vim-signify: Show a git diff in the sign column.
  { "mhinz/vim-signify", event = "VeryLazy" },

  -- blamer.nvim: Show git blame information in the sign column, similar to GitLens in VSCode.
  { "APZelos/blamer.nvim", event = "VeryLazy" },

  -- plenary.nvim: A Lua library required by many other Neovim plugins for common operations.
  { "nvim-lua/plenary.nvim", event = "VeryLazy" },
  -- harpoon: A utility to quickly navigate and manage files in your Neovim project.
  { "ThePrimeagen/harpoon", event = "VeryLazy" },
  -- null-ls.nvim: A Neovim plugin for allowing lspconfig to interface with tools that provide code actions, diagnostics, etc.
  { "jose-elias-alvarez/null-ls.nvim", event = "VeryLazy" },

  -- vim-floaterm: Floating terminal window support.
  { "voldikss/vim-floaterm", event = "VeryLazy" },

  -- fzf: A command-line fuzzy finder.
  { "junegunn/fzf", build = ":call fzf#install()", event = "VeryLazy" },
  -- fzf.vim: Integrates the fzf command-line fuzzy finder with Neovim.
  { "junegunn/fzf.vim", event = "VeryLazy" },


  -- lualine.nvim: A blazing fast and easy-to-configure status line for Neovim.
  { "nvim-lualine/lualine.nvim", event = "VeryLazy" },
  -- vim-tmux-navigator: Seamless navigation between tmux panes and vim splits.
  { "christoomey/vim-tmux-navigator", event = "VeryLazy" },

  -- neo-tree.nvim: A file explorer plugin written in Lua that leverages Neovim's built-in features.
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- Icon support
      "MunifTanjim/nui.nvim", -- UI enhancements
    },
  },
  -- indent-blankline.nvim: Adds indentation guides to all lines (including empty lines).
  { "lukas-reineke/indent-blankline.nvim", event = "VeryLazy" },
  -- undotree: Visualize your undo tree to navigate through edits.
  { "mbbill/undotree", event = "VeryLazy" },
  -- vim-lastplace: Automatically reopen files at your last edit position.
  { "farmergreg/vim-lastplace" },

  -- neoformat: A plugin for formatting code.
  { "sbdchd/neoformat", event = "VeryLazy" },

  -- which-key.nvim: Displays a popup with possible keybindings of the command you started typing.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        triggers_blacklist = {
          n = { "s" },
          v = { "s" },
          i = { "<leader>" },
        },
      })
    end,
  },
  -- zen-mode.nvim: Distraction-free coding for Neovim.
  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    config = function()
      require("zen-mode").setup {}
    end,
  },

  -- wpm.nvim: Monitor your typing speed within Neovim.
  {
    "jcdickinson/wpm.nvim",
    event = "VeryLazy",
    config = function()
      require("wpm").setup({
        sections = {
          lualine_x = {
            require("wpm").wpm,
            require("wpm").historic_graph
          }
        }
      })
    end
  },

  -- markdown-preview.nvim: Preview Markdown files in your browser with live updates.
  {
    "iamcco/markdown-preview.nvim",
    event = "VeryLazy",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- symbols-outline.nvim: A symbol tree view for Neovim, like the outline view in VSCode.
  { "simrat39/symbols-outline.nvim", event = "VeryLazy" },
  -- aerial.nvim: A code outline window for navigating symbols using LSP.
  { "stevearc/aerial.nvim", event = "VeryLazy" },
  -- vim-markdown: Markdown Vim Mode with syntax highlighting and matching rules.
  { "preservim/vim-markdown", event = "VeryLazy" },
  -- tabular: Vim plugin for text filtering and alignment.
  { "godlygeek/tabular", event = "VeryLazy" },
  -- vim-jinja2-syntax: Syntax highlighting for Jinja2 templates.
  { "glench/vim-jinja2-syntax", event = "VeryLazy" },
})
