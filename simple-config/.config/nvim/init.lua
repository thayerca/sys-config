-- Neovim settings
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

vim.opt.listchars = { eol = "↵", tab = "→  ", trail = "·", extends = "$" }


-- Mappings
vim.keymap.set('n', 'st', ':NeoTreeFloatToggle<CR>')
-- Plugins
return require('packer').startup(function()
    -- Packer.nvim can manage itself
    use 'wbthomason/packer.nvim'

    -- Statusline plugin
    use 'vim-airline/vim-airline'

    -- Coc.nvim for autocompletion and LSP support
    use {
        'neoclide/coc.nvim',
        branch = 'release'
    }

    -- File explorer
    use 'preservim/nerdtree'

    -- Start screen
    use 'mhinz/vim-startify'

    -- Telescope for fuzzy finding
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim' -- Optional but improves FZF integration
        }
    }

    -- FZF for fuzzy searching (used by Telescope)
    use 'junegunn/fzf'

    -- LazyGit for a terminal-based Git UI
    use 'kdheepak/lazygit'

    -- You can add more plugins here as needed
end)
