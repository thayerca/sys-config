-- ------------------------------------------------------------------------------
-- substitute.nvim (gbprod/substitute.nvim) — Enhanced s/S substitution
-- ------------------------------------------------------------------------------
-- What it does: Replaces default s/S with in-place substitute: s{motion}, ss
--   (whole line), S (to EOL), and visual s for selection. Like change with motion.
-- Keymaps: n s (operator), n ss (line), n S (to EOL), x s (selection).
-- Notes: No extra config; keymaps set in config below.
-- ------------------------------------------------------------------------------

return {
	"gbprod/substitute.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local substitute = require("substitute")
		substitute.setup()
		local keymap = vim.keymap
		keymap.set("n", "s", substitute.operator, { desc = "Substitute with motion" })
		keymap.set("n", "ss", substitute.line, { desc = "Substitute entire line" })
		keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line" })
		keymap.set("x", "s", substitute.visual, { desc = "Substitute selection" })
	end,
}
