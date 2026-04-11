return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- ── Header ──────────────────────────────────────────────────────────────
		local function greeting()
			local hour = tonumber(os.date("%H"))
			local greet
			if hour < 5 then
				greet = "  Still up?"
			elseif hour < 12 then
				greet = "  Good morning"
			elseif hour < 17 then
				greet = "  Good afternoon"
			elseif hour < 21 then
				greet = "  Good evening"
			else
				greet = "  Good night"
			end
			return greet
		end

		local function header()
			local date = os.date("  %A, %B %d")
			local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
			return {
				"",
				greeting(),
				date,
				"  " .. cwd,
				"",
			}
		end

		dashboard.section.header.val = header()
		dashboard.section.header.opts = {
			hl = "AlphaHeader",
			position = "center",
		}

		-- ── Buttons ──────────────────────────────────────────────────────────────
		dashboard.section.buttons.val = {
			dashboard.button("n", "  New file", "<cmd>ene <BAR> startinsert<CR>"),
			dashboard.button("e", "  Explorer", "<cmd>Neotree toggle<CR>"),
			dashboard.button("f", "  Find file", "<cmd>Telescope find_files<CR>"),
			dashboard.button("F", "  Git files", "<cmd>Telescope git_files<CR>"),
			dashboard.button("w", "  Find word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<CR>"),
			dashboard.button("b", "  Git branches", "<cmd>Telescope git_branches<CR>"),
			dashboard.button("g", "  Git status", "<cmd>LazyGit<CR>"),
			dashboard.button("t", "  Find todos", "<cmd>TodoTelescope<CR>"),
			dashboard.button("p", "  Plugins", "<cmd>Lazy<CR>"),
			dashboard.button("c", "  Config", "<cmd>e $MYVIMRC<CR>"),
			dashboard.button("l", "  Changelog", "<cmd>LazyChangelog<CR>"),
			dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
		}

		-- ── Footer ──────────────────────────────────────────────────────────────
		local function footer()
			local ok, lazy = pcall(require, "lazy")
			if not ok then
				return ""
			end
			local stats = lazy.stats()
			local updates = ""
			if stats.updates and stats.updates > 0 then
				updates = "  " .. stats.updates .. " update" .. (stats.updates > 1 and "s" or "") .. " available"
			end
			return "⚡ " .. stats.loaded .. "/" .. stats.count .. " plugins loaded" .. updates
		end

		dashboard.section.footer.val = footer()
		dashboard.section.footer.opts = {
			hl = "AlphaFooter",
			position = "center",
		}

		alpha.setup(dashboard.opts)
	end,
}
