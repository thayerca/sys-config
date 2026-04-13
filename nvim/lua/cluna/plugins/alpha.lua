-- ------------------------------------------------------------------------------
-- alpha-nvim (goolord/alpha-nvim) — Startup dashboard
-- ------------------------------------------------------------------------------
-- What it does: Shows a startup screen with time-of-day greeting,
--   git branch + cwd context, quick-action buttons grouped by purpose,
--   and lazy plugin stats in the footer.
-- Keymaps: n e f F w r b g t p c l q (see buttons below).
-- Notes: Uses dashboard theme; depends on nvim-web-devicons for icons.
-- Icon codepoints use vim.fn.nr2char() so they are explicit and encoding-safe.
--   All icons are Font Awesome classic (U+F000–U+F300), present in every
--   Nerd Font version. Reference: https://www.nerdfonts.com/cheat-sheet
-- ------------------------------------------------------------------------------

return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local c = vim.fn.nr2char -- shorthand: c(0xF002) → the glyph at U+F002

		-- ------------------------------------------------------------------------------
		-- Header: greeting + date + git branch + cwd
		-- nf-fa-moon-o      U+F186
		-- nf-fa-sun-o       U+F185
		-- nf-dev-git        U+E702
		-- nf-fa-folder-open U+F07C
		-- ------------------------------------------------------------------------------
		local moon = c(0xF186) -- nf-fa-moon-o
		local sunrise = c(0xF185) -- nf-fa-sun-o
		local sun = c(0xF185) -- nf-fa-sun-o
		local sunset = c(0xF186) -- nf-fa-moon-o (closest available)

		local function greeting()
			local hour = tonumber(os.date("%H"))
			if hour < 5 then
				return moon .. "  Still up?"
			end
			if hour < 12 then
				return sunrise .. "  Good morning"
			end
			if hour < 17 then
				return sun .. "  Good afternoon"
			end
			if hour < 21 then
				return sunset .. "  Good evening"
			end
			return moon .. "  Good night"
		end

		local function git_branch()
			local branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("\n", "")
			if branch == "" then
				return nil
			end
			return c(0xE702) .. "  " .. branch
		end

		local function cwd_short()
			local cwd = vim.fn.getcwd()
			-- show last two path components so you know project + parent
			local parts = {}
			for part in cwd:gmatch("[^/]+") do
				table.insert(parts, part)
			end
			local n = #parts
			if n >= 2 then
				return c(0xF07C) .. "  " .. parts[n - 1] .. "/" .. parts[n]
			end
			return c(0xF07C) .. "  " .. (parts[n] or cwd)
		end

		local header_lines = {
			"",
			greeting(),
			"  " .. os.date("%A, %B %d"),
			"",
		}
		local branch = git_branch()
		if branch then
			table.insert(header_lines, branch)
		end
		table.insert(header_lines, cwd_short())
		table.insert(header_lines, "")

		dashboard.section.header.val = header_lines
		dashboard.section.header.opts = { hl = "AlphaHeader", position = "center" }

		-- ------------------------------------------------------------------------------
		-- Buttons — key on left, description on right
		-- Grouped by purpose with separator lines between groups:
		--   Files & search | Git | Tools | Quit
		--
		-- nf-fa-file          U+F15B
		-- nf-fa-folder-open   U+F07C
		-- nf-fa-search        U+F002
		-- nf-dev-git          U+E702
		-- nf-fa-history       U+F1DA
		-- nf-fa-code-fork     U+F126
		-- nf-fa-check-square  U+F14A
		-- nf-fa-puzzle-piece  U+F12E
		-- nf-fa-cog           U+F013
		-- nf-fa-clock-o       U+F017
		-- nf-fa-power-off     U+F011
		-- ------------------------------------------------------------------------------
		local function btn(key, label, cmd)
			local b = dashboard.button(key, label, cmd)
			b.opts.align_shortcut = "left"
			return b
		end

		local function sep()
			return { type = "text", val = "", opts = { position = "center" } }
		end

		dashboard.section.buttons.val = {
			-- Files & search
			btn("n  ", c(0xF15B) .. "  New file", "<cmd>ene <BAR> startinsert<CR>"),
			btn("e  ", c(0xF07C) .. "  Explorer", "<cmd>Neotree toggle<CR>"),
			btn("f  ", c(0xF002) .. "  Find file", "<cmd>Telescope find_files<CR>"),
			btn("F  ", c(0xE702) .. "  Git files", "<cmd>Telescope git_files<CR>"),
			btn("w  ", c(0xF002) .. "  Find word", "<cmd>Telescope live_grep<CR>"),
			btn("r  ", c(0xF1DA) .. "  Recent files", "<cmd>Telescope oldfiles<CR>"),
			sep(),
			-- Git
			btn("b  ", c(0xF126) .. "  Git branches", "<cmd>Telescope git_branches<CR>"),
			btn("g  ", c(0xE702) .. "  Git status", "<cmd>LazyGit<CR>"),
			sep(),
			-- Tools
			btn("t  ", c(0xF14A) .. "  Find todos", "<cmd>TodoTelescope<CR>"),
			btn("p  ", c(0xF12E) .. "  Plugins", "<cmd>Lazy<CR>"),
			btn("c  ", c(0xF013) .. "  Config", "<cmd>e $MYVIMRC<CR>"),
			btn("l  ", c(0xF017) .. "  Changelog", "<cmd>LazyChangelog<CR>"),
			sep(),
			-- Quit
			btn("q  ", c(0xF011) .. "  Quit", "<cmd>qa<CR>"),
		}

		-- ------------------------------------------------------------------------------
		-- Footer: plugin count + load time
		-- ⚡ U+26A1 — standard Unicode, no Nerd Font required
		-- ------------------------------------------------------------------------------
		local function footer()
			local ok, lazy = pcall(require, "lazy")
			if not ok then
				return ""
			end
			local stats = lazy.stats()
			local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
			local updates = (stats.updates and stats.updates > 0)
					and ("  · " .. stats.updates .. " update" .. (stats.updates > 1 and "s" or "") .. " available")
				or ""
			return "⚡ " .. stats.count .. " plugins · loaded in " .. ms .. "ms" .. updates
		end

		dashboard.section.footer.val = footer()
		dashboard.section.footer.opts = { hl = "AlphaFooter", position = "center" }

		alpha.setup(dashboard.config)
	end,
}
