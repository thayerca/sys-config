-- ~/.config/nvim/lua/settings.lua

-- setup must be called before loading
--vim.cmd("colorscheme kanagawa") --#kanagawa

-- Basic Neovim settings
vim.o.number = true -- Enable line numbers
vim.opt.relativenumber = true -- Enable relative line numbers
vim.opt.syntax = "on" -- Enables syntax highlighing

vim.opt.ruler = true -- show the cursor position all the time
vim.opt.showcmd = true -- display incomplete commands
vim.opt.laststatus = 3 -- 3: Only show global status line in acitve window 2: Always display the status line

--fold settings
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 5
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

-- search related
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true

vim.opt.updatetime = 200 -- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.

-- Ignore files
vim.opt.wildignore = "*.pyc,*_build/*,**/coverage/*,**/.git/*,**/__pycache__/*"

vim.opt.syntax = "on" -- Enables syntax highlighing
vim.opt.smartcase = true -- Do not ignore case with capitals
vim.opt.conceallevel = 0 -- So that I can see `` in markdown files
vim.opt.tabstop = 2 -- Insert 2 spaces for a tab
vim.opt.shiftwidth = 2 -- Change the number of space characters inserted for indentation
vim.opt.softtabstop = 2 --Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>

--wrap lines for markdown only
vim.opt.wrap = false -- Display long lines as just one line
vim.cmd("autocmd FileType markdown setlocal wrap")

vim.opt.expandtab = true -- Converts tabs to spaces
vim.opt.smarttab = true -- Makes tabbing smarter will realize you have 2 vs 4
vim.opt.smartindent = true -- Makes indenting smart
vim.opt.autoindent = true -- Good auto indent
vim.opt.splitbelow = true -- Horizontal splits will automatically be below
vim.opt.splitright = true -- Vertical splits will automatically be to the right
-- vim.opt.t_Co=256                            -- Support 256 colors
vim.opt.termguicolors = true -- True color support
vim.opt.cmdheight = 2 -- More space for displaying messages
vim.opt.pumheight = 10 -- Makes popup menu smaller
vim.opt.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.opt.timeoutlen = 500 -- By default timeoutlen is 1000 ms

vim.opt.scrolloff = 8

vim.opt.encoding = "utf8"

-- Highlight what I yanked
vim.cmd("autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=500 }")
-- In line characters
vim.opt.listchars = { eol = "↵", tab = "→  ", trail = "·", extends = "$" }

vim.cmd([[
" Python: auto format on save with Black
autocmd BufWritePre *.py execute ':Black'
]])

