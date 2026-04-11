-- ------------------------------------------------------------------------------
-- alpha-nvim (goolord/alpha-nvim) — Startup dashboard
-- ------------------------------------------------------------------------------
-- What it does: Shows a startup screen with time-of-day greeting, date, cwd,
--   quick-action buttons, and lazy.nvim plugin stats in the footer.
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
		-- 🌅 Header: greeting + date + cwd
		-- ------------------------------------------------------------------------------
		local function greeting()
			local hour = tonumber(os.date("%H"))
			if hour < 5 then return "  Still up?" end
			if hour < 12 then return "  Good morning" end
			if hour < 17 then return "  Good afternoon" end
			if hour < 21 then return "  Good evening" end
			return "  Good night"
		end

		dashboard.section.header.val = {
			"",
			greeting(),
			"  " .. os.date("%A, %B %d"),
			"  " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":~"),
			"",
		}
		dashboard.section.header.opts = { hl = "AlphaHeader", position = "center" }

		-- ------------------------------------------------------------------------------
		-- 🛠 Buttons (Quick Actions)
		-- ------------------------------------------------------------------------------
		dashboard.section.buttons.val = {
			dashboard.button("n", "  New file",        "<cmd>ene <BAR> startinsert<CR>"),
			dashboard.button("e", "  Explorer",        "<cmd>Neotree toggle<CR>"),
			dashboard.button("f", "  Find file",       "<cmd>Telescope find_files<CR>"),
			dashboard.button("F", "  Git files",       "<cmd>Telescope git_files<CR>"),
			dashboard.button("w", "  Find word",       "<cmd>Telescope live_grep<CR>"),
			dashboard.button("r", "  Recent files",    "<cmd>Telescope oldfiles<CR>"),
			dashboard.button("b", "  Git branches",   "<cmd>Telescope git_branches<CR>"),
			dashboard.button("g", "  Git status",      "<cmd>LazyGit<CR>"),
			dashboard.button("t", "  Find todos",      "<cmd>TodoTelescope<CR>"),
			dashboard.button("p", "  Plugins",         "<cmd>Lazy<CR>"),
			dashboard.button("c", "  Config",          "<cmd>e $MYVIMRC<CR>"),
			dashboard.button("l", "  Changelog",       "<cmd>LazyChangelog<CR>"),
			dashboard.button("q", "  Quit",            "<cmd>qa<CR>"),
		}

		-- ------------------------------------------------------------------------------
		-- 📈 Footer: plugin count + pending updates
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
