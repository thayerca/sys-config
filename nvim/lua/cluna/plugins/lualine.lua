-- ------------------------------------------------------------------------------
-- lualine.nvim (nvim-lualine/lualine.nvim) — Statusline
-- ------------------------------------------------------------------------------
-- What it does: Statusline with mode, branch, diff, diagnostics, filename,
--   encoding, filetype, active LSP servers, and optional Lazy plugin update indicator.
-- Keymaps: None.
-- Notes: Custom theme in config; depends on nvim-web-devicons.
-- ------------------------------------------------------------------------------
-- (Original: https://github.com/nvim-lualine/lualine.nvim)
--
-- A fast and customizable statusline plugin written in Lua.
--
-- 🛠 How it works:
-- - Displays current mode, file info, diagnostics, encoding, etc.
-- - Highly customizable themes and sections
-- - Integrates with other plugins like `lazy.nvim` to show updates
--
-- 💡 Usage tips:
-- - Customize `lualine_x` to display what’s most useful to you
-- - Use `lazy.status.has_updates()` and `lazy.status.updates` to show pending plugin updates
-- -----------------------------------------------------------------------------

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		-- Returns names of active LSP servers for the current buffer
		local function lsp_status()
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			if #clients == 0 then return "" end
			local names = {}
			for _, c in ipairs(clients) do
				table.insert(names, c.name)
			end
			return "\u{f489} " .. table.concat(names, " ")
		end

		-- 🎨 Define a custom color palette for the theme
		local colors = {
			blue = "#65D1FF",
			green = "#3EFFDC",
			violet = "#FF61EF",
			yellow = "#FFDA7B",
			red = "#FF4A4A",
			fg = "#c3ccdc",
			bg = "#112638",
			inactive_bg = "#2c3043",
			semilightgray = "#6c7086",
		}
		local my_lualine_theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
				b = { bg = colors.inactive_bg, fg = colors.semilightgray },
				c = { bg = colors.inactive_bg, fg = colors.semilightgray },
			},
		}
		lualine.setup({
			options = {
				icons_enabled = true,
				theme = my_lualine_theme,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = {
					-- Show pending Lazy plugin updates
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ lsp_status, color = { fg = colors.green } },
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		})
	end,
}
