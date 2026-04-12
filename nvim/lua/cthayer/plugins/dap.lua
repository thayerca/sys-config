-- ------------------------------------------------------------------------------
-- nvim-dap + nvim-dap-ui (mfussenegger/nvim-dap, rcarriga/nvim-dap-ui)
-- ------------------------------------------------------------------------------
-- What it does: Full Debug Adapter Protocol integration for Neovim.
--   nvim-dap is the core DAP client; nvim-dap-ui provides a floating panel
--   layout with scopes, watches, call stack, breakpoints, and a REPL.
--   nvim-dap-virtual-text shows current variable values inline as virtual text.
-- Keymaps (all under <leader>d):
--   <leader>db  — toggle breakpoint
--   <leader>dB  — set conditional breakpoint (prompts for condition)
--   <leader>dc  — continue / start debug session
--   <leader>dn  — step over (next)
--   <leader>di  — step into
--   <leader>do  — step out
--   <leader>dr  — open REPL
--   <leader>dl  — run last debug config
--   <leader>du  — toggle dap-ui panels
--   <leader>de  — evaluate expression under cursor (hover)
-- Notes:
--   Adapters (e.g. codelldb, debugpy, js-debug-adapter) must be installed via
--   Mason or system. See :help dap-adapter for configuration per language.
--   nvim-dap-ui opens automatically when a debug session starts and closes
--   when it ends.
-- Depends on: nvim-nio (required by nvim-dap-ui v4+).
-- ------------------------------------------------------------------------------

return {
	-- Core DAP client
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- UI panels: scopes, watches, call stack, REPL
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-neotest/nvim-nio" },
				config = function()
					local dap = require("dap")
					local dapui = require("dapui")

					dapui.setup({
						icons = { expanded = "", collapsed = "", current_frame = "" },
						layouts = {
							{
								elements = {
									{ id = "scopes",      size = 0.35 },
									{ id = "breakpoints", size = 0.15 },
									{ id = "stacks",      size = 0.30 },
									{ id = "watches",     size = 0.20 },
								},
								size = 40,
								position = "left",
							},
							{
								elements = {
									{ id = "repl",    size = 0.5 },
									{ id = "console", size = 0.5 },
								},
								size = 12,
								position = "bottom",
							},
						},
					})

					-- Auto-open/close UI with session lifecycle
					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open()
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close()
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close()
					end
				end,
			},

			-- Inline variable values as virtual text during debug sessions
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {
					commented = true,  -- show as comment-style virtual text
				},
			},
		},

		keys = {
			{ "<leader>db", function() require("dap").toggle_breakpoint() end,                                           desc = "DAP: toggle breakpoint" },
			{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,        desc = "DAP: conditional breakpoint" },
			{ "<leader>dc", function() require("dap").continue() end,                                                    desc = "DAP: continue / start" },
			{ "<leader>dn", function() require("dap").step_over() end,                                                   desc = "DAP: step over" },
			{ "<leader>di", function() require("dap").step_into() end,                                                   desc = "DAP: step into" },
			{ "<leader>do", function() require("dap").step_out() end,                                                    desc = "DAP: step out" },
			{ "<leader>dr", function() require("dap").repl.open() end,                                                   desc = "DAP: open REPL" },
			{ "<leader>dl", function() require("dap").run_last() end,                                                    desc = "DAP: run last config" },
			{ "<leader>du", function() require("dapui").toggle() end,                                                    desc = "DAP: toggle UI" },
			{ "<leader>de", function() require("dapui").eval() end,         mode = { "n", "v" },                         desc = "DAP: evaluate expression" },
			{ "<leader>dx", function() require("dap").terminate() end,                                                   desc = "DAP: terminate session" },
		},

		config = function()
			local dap = require("dap")

			-- Sign column icons for breakpoints
			vim.fn.sign_define("DapBreakpoint",          { text = "●", texthl = "DapBreakpoint",          linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected",  { text = "○", texthl = "DapBreakpointRejected",  linehl = "", numhl = "" })
			vim.fn.sign_define("DapLogPoint",            { text = "◉", texthl = "DapLogPoint",            linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped",             { text = "▶", texthl = "DapStopped",             linehl = "DapStoppedLine", numhl = "" })

			-- Python: uses debugpy installed via Mason
			dap.adapters.python = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
				args = { "-m", "debugpy.adapter" },
			}
			dap.configurations.python = {
				{
					type    = "python",
					request = "launch",
					name    = "Launch file",
					program = "${file}",
					pythonPath = function()
						local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
						if venv then return venv .. "/bin/python" end
						return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
					end,
				},
				{
					type    = "python",
					request = "launch",
					name    = "Launch file with args",
					program = "${file}",
					args    = function()
						local args = vim.fn.input("Args: ")
						return vim.split(args, " ", { trimempty = true })
					end,
					pythonPath = function()
						local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
						if venv then return venv .. "/bin/python" end
						return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
					end,
				},
			}

			-- JavaScript / TypeScript: uses js-debug-adapter installed via Mason
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}
			for _, lang in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
				dap.configurations[lang] = {
					{
						type    = "pwa-node",
						request = "launch",
						name    = "Launch file",
						program = "${file}",
						cwd     = "${workspaceFolder}",
					},
					{
						type    = "pwa-node",
						request = "attach",
						name    = "Attach to process",
						processId = require("dap.utils").pick_process,
						cwd     = "${workspaceFolder}",
					},
				}
			end
		end,
	},
}
