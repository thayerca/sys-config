return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    spec = {
      { "<leader>c", group = "code actions" },
      { "<leader>d", group = "diagnostics" },
      { "<leader>g", group = "git/format" },
      { "<leader>l", group = "lazygit" },
      { "<leader>m", group = "format" },
      { "<leader>r", group = "rename/restart" },
      { "<leader>s", group = "splits" },
      { "<leader>t", group = "tabs" },
      { "<leader>x", group = "trouble" },
    },
  },
}
