-- ------------------------------------------------------------------------------
-- harpoon (ThePrimeagen/harpoon) — Pin files and jump with one key
-- ------------------------------------------------------------------------------
-- What it does: Mark up to 4 (or more) files and jump to them with number keys.
--   No conflict: <leader>a (add), <leader>1/2/3/4 (go to); leader+5+ for more.
-- Keymaps: <leader>a (add file), <leader>1/2/3/4 (go to file 1–4), <leader>hm (menu).
-- Notes: Depends on plenary. which-key: we add "a" and "1"-"4" as harpoon group.
-- ------------------------------------------------------------------------------

return {
	"ThePrimeagen/harpoon",
	event = "BufReadPre",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Harpoon: add file" },
		{ "<leader>1", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon: go to file 1" },
		{ "<leader>2", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon: go to file 2" },
		{ "<leader>3", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon: go to file 3" },
		{ "<leader>4", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon: go to file 4" },
		{ "<leader>hm", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon: menu" },
	},
	opts = {},
}
