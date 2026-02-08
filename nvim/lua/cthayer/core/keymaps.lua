-- ------------------------------------------------------------------------------
-- keymaps.lua — Core key bindings (non-plugin)
-- ------------------------------------------------------------------------------
-- What it does:
--   Sets leader to <Space> and defines: jk (exit insert), <leader>nh (nohl),
--   <leader>+/- (increment/decrement number), <leader>sv/sh/se/sx (splits),
--   <leader>to/tx/tn/tp/tf (tabs). Pane navigation <C-h/j/k/l> is in
--   plugins/vim-tmux-navigator.lua so it works across tmux and Neovim.
--
-- How to interact:
--   Add keymaps with vim.keymap.set(mode, lhs, rhs, { desc = "..." }).
--   Plugin keymaps are in each file under lua/cthayer/plugins/. Full list: docs/CHEATSHEET.md.
--
-- Author: Casey A. Thayer
-- Location: ~/.config/nvim/lua/cthayer/core/keymaps.lua
-- ------------------------------------------------------------------------------

vim.g.mapleader = " "
local keymap = vim.keymap

-- ------------------------------------------------------------------------------
-- ⌨️ General
-- ------------------------------------------------------------------------------
-- jk in insert mode: fast way to leave insert without reaching for Escape
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
-- <leader>nh: clear search highlight after / or ? search
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- ------------------------------------------------------------------------------
-- 🔢 Numbers (under cursor or visual selection)
-- ------------------------------------------------------------------------------
-- <leader>+ / <leader>-: increment/decrement number at cursor (like Ctrl-A/Ctrl-X)
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- ------------------------------------------------------------------------------
-- 🔲 Window / split management
-- ------------------------------------------------------------------------------
-- <leader>s + v/h/e/x: split vertical, split horizontal, equalize, close
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize split dimensions" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- ------------------------------------------------------------------------------
-- 🗂 Tab management
-- ------------------------------------------------------------------------------
-- <leader>t + o/x/n/p/f: new tab, close tab, next tab, previous tab, current buffer in new tab
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
