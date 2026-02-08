-- ------------------------------------------------------------------------------
-- alpha-nvim (goolord/alpha-nvim) — Startup dashboard
-- ------------------------------------------------------------------------------
-- What it does: Shows a startup screen with Neovim logo, quick-action buttons
--   (new file, find file, recent files, config, quit) and plugin load stats.
-- Keymaps: Dashboard buttons e, f, r, c, q (defined in config below).
-- Notes: Uses dashboard theme; depends on nvim-web-devicons for icons.
-- ------------------------------------------------------------------------------

return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- ------------------------------------------------------------------------------
		-- 🎨 Header (ASCII Art Logo)
		-- ------------------------------------------------------------------------------
		dashboard.section.header.val = {
			"                                                     ",
			"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			"                                                     ",
		}

		-- ------------------------------------------------------------------------------
		-- 🛠 Buttons (Quick Actions)
		-- ------------------------------------------------------------------------------
		dashboard.section.buttons.val = {
			dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "󰈞  Find File", ":Telescope find_files<CR>"),
			dashboard.button("r", "󰄉  Recent Files", ":Telescope oldfiles<CR>"),
			dashboard.button("c", "  Config", ":e $MYVIMRC<CR>"),
			dashboard.button("q", "  Quit", ":qa<CR>"),
		}

		-- ------------------------------------------------------------------------------
		-- 📈 Footer (Plugin Stats)
		-- ------------------------------------------------------------------------------
		dashboard.section.footer.val = function()
			local stats = require("lazy").stats()
			return "⚡ Neovim loaded "
				.. stats.count
				.. " plugins in "
				.. math.floor(stats.startuptime * 100 + 0.5) / 100
				.. "ms"
		end
		dashboard.section.footer.opts.hl = "Comment"

		-- ------------------------------------------------------------------------------
		-- 🚀 Setup Alpha
		-- ------------------------------------------------------------------------------
		alpha.setup(dashboard.config)
	end,
}
