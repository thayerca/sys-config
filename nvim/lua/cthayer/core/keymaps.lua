-- ------------------------------------------------------------------------------
-- 🎹 keymaps.lua — Custom Key Bindings
-- ------------------------------------------------------------------------------
-- Description:
--   Sets custom keymaps for better navigation, window management, etc.
--
-- Author: Casey A. Thayer
-- Location: ~/.config/nvim/lua/cthayer/core/keymaps.lua
-- ------------------------------------------------------------------------------

vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness

-- ------------------------------------------------------------------------------
-- ⌨️ General
-- ------------------------------------------------------------------------------

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- ------------------------------------------------------------------------------
-- 🔢 Numbers
-- ------------------------------------------------------------------------------

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- ------------------------------------------------------------------------------
-- 🔲 Window Management
-- ------------------------------------------------------------------------------

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize split dimensions" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- ------------------------------------------------------------------------------
-- 🗂 Tab Management
-- ------------------------------------------------------------------------------

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- ------------------------------------------------------------------------------
-- 🧭 Navigation Between Splits
-- ------------------------------------------------------------------------------

keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to split below" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to split above" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
