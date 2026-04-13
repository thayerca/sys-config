-- ------------------------------------------------------------------------------
-- harpoon (ThePrimeagen/harpoon) — Pin files and jump with one key (v2)
-- ------------------------------------------------------------------------------
-- What it does: Mark up to 4 (or more) files and jump to them with number keys.
--   No conflict: <leader>a (add), <leader>1/2/3/4 (go to); <leader>hm (menu).
-- Keymaps: <leader>a (add file), <leader>1/2/3/4 (go to file 1–4), <leader>hm (menu).
-- Notes: Uses Harpoon v2 API (branch = "harpoon2"). Plenary no longer required.
-- ------------------------------------------------------------------------------

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	event = "BufReadPre",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: add file" })
		vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: menu" })

		vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: go to file 1" })
		vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: go to file 2" })
		vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: go to file 3" })
		vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: go to file 4" })
	end,
}
