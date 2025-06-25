-- -----------------------------------------------------------------------------
-- 🔗 Plugin: nvim-surround
-- https://github.com/kylechui/nvim-surround
--
-- Adds text objects to easily add, change, or delete surrounding characters
-- like parentheses, quotes, brackets, tags, etc.
--
-- 🛠️ Usage Examples:
-- - `ysiw"` → add `"` around inner word
-- - `cs"'` → change surrounding `"` to `'`
-- - `ds"` → delete surrounding `"`
--
-- 💡 Works in normal, visual, and operator-pending modes.
-- -----------------------------------------------------------------------------

return {
	"kylechui/nvim-surround",
	event = { "BufReadPre", "BufNewFile" },
	version = "*", -- Use the latest stable release
	config = true, -- Uses default configuration; set to a function for custom setup
}
