-- ------------------------------------------------------------------------------
-- copilot-cmp (zbirenbaum/copilot-cmp) — GitHub Copilot in completion menu
-- ------------------------------------------------------------------------------
-- What it does: Injects Copilot suggestions into nvim-cmp completion. Copilot
--   Lua runs the backend; suggestion/panel can be toggled separately.
-- Keymaps: Same as nvim-cmp (Tab to accept, etc.); Copilot appears as a source.
-- Notes: Depends on copilot.lua. Requires Node.js 22+ (auto-detects nvm/fnm paths).
-- ------------------------------------------------------------------------------

local function find_node22()
	-- Prefer Node 22+ from PATH (e.g. nvm use 22)
	local node = vim.fn.exepath("node")
	if node ~= "" then
		local out = vim.fn.system({ node, "--version" }):gsub("%s+", "")
		local major = tonumber(out:match("v(%d+)"))
		if major and major >= 22 then
			return node
		end
	end
	-- Try nvm: ~/.nvm/versions/node/v22* or $NVM_DIR
	local nvm_dir = vim.env.NVM_DIR or (vim.env.HOME .. "/.nvm")
	local versions = vim.fn.glob(nvm_dir .. "/versions/node/v22*", true, true)
	if versions and #versions > 0 then
		table.sort(versions)
		local candidate = versions[#versions] .. "/bin/node"
		if vim.fn.executable(candidate) == 1 then
			return candidate
		end
	end
	-- Try fnm: ~/.local/share/fnm/node-versions or $FNM_DIR
	local fnm_dir = vim.env.FNM_DIR or (vim.env.HOME .. "/.local/share/fnm")
	local fnm_versions = vim.fn.glob(fnm_dir .. "/node-versions/*/installation/bin/node", true, true)
	if fnm_versions and #fnm_versions > 0 then
		for _, p in ipairs(fnm_versions) do
			local out = vim.fn.system({ p, "--version" }):gsub("%s+", "")
			local major = tonumber(out:match("v(%d+)"))
			if major and major >= 22 then
				return p
			end
		end
	end
	return "node" -- fallback; will error if < 22
end

return {
	"zbirenbaum/copilot-cmp",
	version = "*",
	event = "InsertEnter",
	config = function()
		require("copilot_cmp").setup()
	end,
	dependencies = {
		{
			"zbirenbaum/copilot.lua",
			version = "*",
			cmd = "Copilot",
			config = function()
				require("copilot").setup({
					copilot_node_command = find_node22(),
					suggestion = { enabled = false },
					panel = { enabled = false },
				})
			end,
		},
	},
}
