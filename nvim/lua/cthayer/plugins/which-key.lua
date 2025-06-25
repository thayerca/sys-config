return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},

	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Show buffer-local keymaps",
		},
		{ "<leader>f", name = "+file" },
		{ "<leader>g", name = "+git" },
		{ "<leader>b", name = "+buffer" },
	},
}
