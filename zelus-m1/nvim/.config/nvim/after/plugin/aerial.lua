local aerial_on_attach = function(bufnr)
  require('aerial').on_attach(bufnr)
  -- Aerial key mappings
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>o', '<cmd>AerialToggle!<CR>', {})
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '{', '<cmd>AerialPrev<CR>', {})
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '}', '<cmd>AerialNext<CR>', {})
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[[', '<cmd>AerialPrevUp<CR>', {})
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']]', '<cmd>AerialNextUp<CR>', {})
end

-- R LSP
require('lspconfig')['r_language_server'].setup{
  on_attach = aerial_on_attach,
}

-- Python LSP with Pyright
require('lspconfig')['pyright'].setup{
  on_attach = aerial_on_attach,
}

-- SQL LSP (using sqls, adjust if using a different LSP for SQL)
require('lspconfig')['sqls'].setup{
  on_attach = aerial_on_attach,
}

-- Lua LSP (assuming using sumneko_lua)
require('lspconfig')['sumneko_lua'].setup{
  on_attach = aerial_on_attach,
}

-- Dockerfile LSP (using dockerls)
require('lspconfig')['dockerls'].setup{
  on_attach = aerial_on_attach,
}

-- YAML LSP (using yamlls)
require('lspconfig')['yamlls'].setup{
  on_attach = aerial_on_attach,
}
