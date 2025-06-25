-- -----------------------------------------------------------------------------
-- 🔧 Plugin: gitsigns.nvim
-- https://github.com/lewis6991/gitsigns.nvim
--
-- Adds Git integration directly into the sign column and buffer.
-- Shows changes as signs, enables staging/resetting hunks, blame info, and diffs.
--
-- 🧠 How it works:
-- Hooks into your Git repo to track line changes (additions, deletions, modifications)
-- and visually indicates them beside the line number gutter.
--
-- 💡 Usage tips:
-- - Navigate between hunks: `]h` / `[h`
-- - Stage/reset hunks: `<leader>hs` / `<leader>hr`
-- - Toggle blame: `<leader>hB`
-- - Preview diffs or blame: `<leader>hp` / `<leader>hb`
-- - Use `ih` text object in operator/visual mode to select a hunk
-- -----------------------------------------------------------------------------

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
			end

			-- 📍 Navigation
			map("n", "]h", gs.next_hunk, "Next Hunk")
			map("n", "[h", gs.prev_hunk, "Previous Hunk")

			-- 🛠️ Actions on Hunks
			map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
			map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
			map("v", "<leader>hs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Stage selected hunk")
			map("v", "<leader>hr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Reset selected hunk")

			-- 📦 Buffer-wide Actions
			map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
			map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")

			-- ↩️ Undo
			map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")

			-- 👀 Preview
			map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")

			-- 🕵️ Blame
			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, "Blame line (full)")
			map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")

			-- 🧾 Diffs
			map("n", "<leader>hd", gs.diffthis, "Diff this")
			map("n", "<leader>hD", function()
				gs.diffthis("~")
			end, "Diff with ~")

			-- 🎯 Text Object for Hunks
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
		end,
	},
}
