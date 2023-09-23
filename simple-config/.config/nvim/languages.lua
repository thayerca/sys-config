-- Coc.nvim configuration
vim.cmd([[let g:coc_global_extensions = ['coc-python', 'coc-r-lsp', 'coc-json', 'coc-yaml', 'coc-sql']])

-- Enable virtual text for linting
vim.cmd([[autocmd BufEnter * if index(g:coc_enabled_extensions, &filetype) >= 0 | CocActive() | endif]])

-- Additional Coc.nvim configuration settings
-- You can add specific configurations for each language server here
-- For example, for Python:
vim.cmd([[autocmd FileType python let g:coc_filetype_map = {'python': 'pyright'}]])
vim.cmd([[autocmd FileType python let g:coc_root_patterns = ['pyproject.toml', 'setup.py', '.git', 'venv', '.venv']])
-- Add similar configurations for other languages as needed


-- JSON-specific settings
vim.cmd([[autocmd FileType json setlocal tabstop=2]])
vim.cmd([[autocmd FileType json setlocal shiftwidth=2]])
vim.cmd([[autocmd FileType json setlocal expandtab]])

-- Python-specific settings
vim.cmd([[autocmd FileType python setlocal tabstop=4]])
vim.cmd([[autocmd FileType python setlocal shiftwidth=4]])
vim.cmd([[autocmd FileType python setlocal expandtab]])
-- Python-specific key mappings
vim.api.nvim_set_keymap('n', '<leader>r', ':RunPythonScript<CR>', { noremap = true, silent = true })

-- R-specific settings
vim.cmd([[autocmd FileType r setlocal tabstop=2]])
vim.cmd([[autocmd FileType r setlocal shiftwidth=2]])
vim.cmd([[autocmd FileType r setlocal expandtab]])

-- SQL-specific settings
vim.cmd([[autocmd FileType sql setlocal tabstop=4]])
vim.cmd([[autocmd FileType sql setlocal shiftwidth=4]])
vim.cmd([[autocmd FileType sql setlocal expandtab]])

-- YAML-specific settings
vim.cmd([[autocmd FileType yaml setlocal tabstop=2]])
vim.cmd([[autocmd FileType yaml setlocal shiftwidth=2]])
vim.cmd([[autocmd FileType yaml setlocal expandtab]])

