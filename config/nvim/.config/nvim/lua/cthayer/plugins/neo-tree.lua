return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true, -- Make filtered items visible
					hide_dotfiles = false, -- Set to false to show dotfiles
					hide_gitignored = false,
				},
			},
			-- other configurations can be added here if needed
		})
		vim.keymap.set("n", "<leader>ee", ":Neotree filesystem reveal float<CR>", {})
		vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
	end,
}
