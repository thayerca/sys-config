-- -----------------------------------------------------------------------------
-- 🔗 Plugin: substitute.nvim
-- https://github.com/gbprod/substitute.nvim
--
-- Drop-in replacement for `s`/`S` in normal and visual mode, providing enhanced
-- substitution behavior with motion support, similar to "change" commands.
--
-- 💡 How it works:
-- - `s{motion}` replaces text in-place using motion (e.g. `siw`)
-- - `ss` substitutes the entire line
-- - `S` substitutes from cursor to end-of-line
-- - Visual mode `s` substitutes the selected region
-- -----------------------------------------------------------------------------

return {
	"gbprod/substitute.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local substitute = require("substitute")
		substitute.setup()

		local keymap = vim.keymap -- alias for clarity

		-- Normal mode mappings
		keymap.set("n", "s", substitute.operator, { desc = "Substitute with motion" })
		keymap.set("n", "ss", substitute.line, { desc = "Substitute entire line" })
		keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line" })

		-- Visual mode mapping
		keymap.set("x", "s", substitute.visual, { desc = "Substitute selection" })
	end,
}
