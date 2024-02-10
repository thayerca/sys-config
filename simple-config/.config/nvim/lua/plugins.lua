-- plugins.lua

return require('packer').startup(function()
    -- Packer can manage itself as a plugin
    use 'wbthomason/packer.nvim'

    -- LSP (Language Server Protocol) support
    use {
        'neovim/nvim-lspconfig',         -- LSP configuration
    }
    use 'kabouzeid/nvim-lspinstall'     -- Easy LSP installation
    use {
        'onsails/lspkind-nvim',         -- LSP symbol icons
        config = function()
            require('lspkind').init()   -- Initialize lspkind
        end,
    }

    -- TODO Comments and Symbols
    use {
        'folke/todo-comments.nvim',     -- Highlight TODO, FIXME, etc.
        config = function()
            require('todo-comments').setup{}
        end,
    }
    use 'simrat39/symbols-outline.nvim'-- Symbol outline viewer

    -- Bufferline for managing buffers
    use {
        'akinsho/nvim-bufferline.lua',  -- Bufferline
        config = function()
            require('bufferline').setup{}
        end,
    }
    use 'glepnir/dashboard-nvim'
    -- Comment plugin
    use 'b3nj5m1n/kommentary'          -- Kommentary

    -- Git integration and lazygit
    use 'tpope/vim-fugitive'           -- Git commands
    use {
        'kdheepak/lazygit.nvim',       -- Lazygit integration
    }

    -- Statusline
    use {
        'hoob3rt/lualine.nvim',         -- Lualine
    }

    -- Additional plugins
    use 'editorconfig/editorconfig-vim'-- EditorConfig support
    use 'tpope/vim-surround'           -- Surround text objects
    use 'windwp/nvim-autopairs'        -- Autopairs
    use 'tpope/vim-commentary'         -- Commenting motions

    -- Add more plugins and customize them as needed
end)
