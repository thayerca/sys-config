-- ------------------------------------------------------------------------------
-- neotest (nvim-neotest/neotest) — Test runner framework for Neovim
-- ------------------------------------------------------------------------------
-- What it does: Unified test runner UI that works with multiple test frameworks.
--   Runs tests in the background, shows results inline (pass/fail signs in the
--   gutter), surfaces output/errors in a split, and integrates with nvim-dap
--   for debugging individual tests.
-- Keymaps (all under <leader>T):
--   <leader>Tr  — run nearest test
--   <leader>TT  — run all tests in file
--   <leader>Ts  — toggle test summary panel
--   <leader>To  — show test output for nearest test
--   <leader>TO  — open output in a floating window
--   <leader>Td  — debug nearest test (requires nvim-dap)
--   <leader>Tx  — stop running tests
-- Adapters bundled:
--   neotest-python   — pytest / unittest
--   neotest-go       — go test
--   neotest-jest     — Jest (JS/TS)
--   neotest-vitest   — Vitest (JS/TS)
-- Notes: Adapters are lazy-loaded; only the ones matching the current file type
--   actually run. Additional adapters can be added to the adapters list.
-- Depends on: nvim-nio, plenary, nvim-treesitter.
-- ------------------------------------------------------------------------------

return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- Language adapters
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-go",
		"marilari88/neotest-vitest",
		{ "haydenmeade/neotest-jest", lazy = true },
	},
	keys = {
		{ "<leader>Tr", function() require("neotest").run.run() end,                          desc = "Neotest: run nearest test" },
		{ "<leader>TT", function() require("neotest").run.run(vim.fn.expand("%")) end,        desc = "Neotest: run file" },
		{ "<leader>Ts", function() require("neotest").summary.toggle() end,                   desc = "Neotest: toggle summary" },
		{ "<leader>To", function() require("neotest").output.open({ enter = true }) end,      desc = "Neotest: show output" },
		{ "<leader>TO", function() require("neotest").output_panel.toggle() end,              desc = "Neotest: toggle output panel" },
		{ "<leader>Td", function() require("neotest").run.run({ strategy = "dap" }) end,      desc = "Neotest: debug nearest test" },
		{ "<leader>Tx", function() require("neotest").run.stop() end,                         desc = "Neotest: stop tests" },
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
					runner = "pytest",
				}),
				require("neotest-go")({
					experimental = { test_table = true },
				}),
				require("neotest-jest")({
					jestCommand = "npx jest",
					jestConfigFile = "jest.config.js",
				}),
				require("neotest-vitest"),
			},

			-- Show diagnostics inline for failed tests
			diagnostic = {
				enabled = true,
				severity = vim.diagnostic.severity.ERROR,
			},

			-- Status icons in sign column
			icons = {
				passed    = "✓",
				failed    = "✗",
				running   = "◌",
				skipped   = "○",
				unknown   = "?",
				watching  = "◎",
			},

			output = { open_on_run = false },  -- don't auto-open; use <leader>To
		})
	end,
}
