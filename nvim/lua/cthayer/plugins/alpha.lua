-- ------------------------------------------------------------------------------
-- alpha-nvim (goolord/alpha-nvim) — Startup dashboard
-- ------------------------------------------------------------------------------
-- What it does: Shows a startup screen with time-of-day greeting,
--   quick-action buttons (key left, description right), and lazy plugin stats.
-- Keymaps: n e f F w r b g t p c l q (see buttons below).
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
		-- 🌅 Header: greeting + date
		-- ------------------------------------------------------------------------------
		local function greeting()
			local hour = tonumber(os.date("%H"))
			if hour < 5  then return "🌙  Still up?" end
			if hour < 12 then return "🌅  Good morning" end
			if hour < 17 then return "☀️   Good afternoon" end
			if hour < 21 then return "🌆  Good evening" end
			return "🌙  Good night"
		end

		dashboard.section.header.val = {
			"",
			greeting(),
			"  " .. os.date("%A, %B %d"),
			"",
		}
		dashboard.section.header.opts = { hl = "AlphaHeader", position = "center" }

		-- ------------------------------------------------------------------------------
		-- 🛠 Buttons — key on left, description on right
		-- ------------------------------------------------------------------------------
		local function btn(key, label, cmd)
			local b = dashboard.button(key, label, cmd)
			b.opts.align_shortcut = "left"
			return b
		end

		dashboard.section.buttons.val = {
			btn("n", "  New file",        "<cmd>ene <BAR> startinsert<CR>"),
			btn("e", "  Explorer",        "<cmd>Neotree toggle<CR>"),
			btn("f", "  Find file",       "<cmd>Telescope find_files<CR>"),
			btn("F", "  Git files",       "<cmd>Telescope git_files<CR>"),
			btn("w", "  Find word",       "<cmd>Telescope live_grep<CR>"),
			btn("r", "  Recent files",    "<cmd>Telescope oldfiles<CR>"),
			btn("b", "  Git branches",    "<cmd>Telescope git_branches<CR>"),
			btn("g", "  Git status",      "<cmd>LazyGit<CR>"),
			btn("t", "  Find todos",      "<cmd>TodoTelescope<CR>"),
			btn("p", "  Plugins",         "<cmd>Lazy<CR>"),
			btn("c", "  Config",          "<cmd>e $MYVIMRC<CR>"),
			btn("l", "  Changelog",       "<cmd>LazyChangelog<CR>"),
			btn("q", "  Quit",            "<cmd>qa<CR>"),
		}

		-- ------------------------------------------------------------------------------
		-- 📈 Footer: plugin count + load time
		-- ------------------------------------------------------------------------------
		local function footer()
			local ok, lazy = pcall(require, "lazy")
			if not ok then return "" end
			local stats = lazy.stats()
			local updates = (stats.updates and stats.updates > 0)
				and ("  " .. stats.updates .. " update" .. (stats.updates > 1 and "s" or "") .. " available")
				or ""
			return "⚡ " .. stats.loaded .. "/" .. stats.count .. " plugins loaded" .. updates
		end

		dashboard.section.footer.val = footer()
		dashboard.section.footer.opts = { hl = "AlphaFooter", position = "center" }

		alpha.setup(dashboard.config)
	end,
}
