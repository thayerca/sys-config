-- -----------------------------------------------------------------------------
-- 🚀 Plugin: alpha-nvim
-- https://github.com/goolord/alpha-nvim
--
-- Customizable startup screen for Neovim.
-- This config uses the "startify" theme with a styled header and menu.
-- -----------------------------------------------------------------------------

return {
	"goolord/alpha-nvim", -- ✨ Start screen plugin for Neovim
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- Adds icons to the dashboard
	event = "VimEnter", -- Load on VimEnter for speed
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
