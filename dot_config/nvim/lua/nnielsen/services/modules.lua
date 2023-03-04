local modules = {}

local enabled_modules = {
	features = {
		["comment"] = true,
		["explorer"] = true,
		["focus"] = true,
		["lsp"] = true,
		["pandoc"] = false,
		["tabular"] = true,
		["telescope"] = true,
		["tmux"] = true,
		["ui"] = true,
		["vim-surround"] = true,
		["vim-unimpaired"] = true,
	},
	langs = {},
}

local required_modules = {
	core = {
		["core"] = true,
		["treesitter"] = true,
	},
}

--- @type table<string,table<string,boolean>>
modules.enabled_modules = vim.tbl_deep_extend("keep", required_modules, enabled_modules)

-- P(modules.enabled_modules)
--- Initialize plugin manager. Bootstrap packer.nvim if necessary.
modules.init = function()
	modules._needs_sync = require("nnielsen.utils").ensure_packer()
	local packer = require("packer")
	packer.init()
	-- Ensure plugin specifications are reinitialized by reseting the
	-- packer-internal managed plugins list.
	packer.reset()
end

modules.load = function()
	local use = require("packer").use

	for section_name, module_list in pairs(modules.enabled_modules) do
		for module_name, is_enabled in pairs(module_list) do
			if is_enabled then
				-- print(("module: '%s' was enabled"):format(module_name))
				local path = ("nnielsen.modules.%s.%s"):format(section_name, module_name)
				local ok, module = pcall(require, path)
				-- P(module)
				if not ok then
					--TODO: Log message here
					print(("Problem with loading %s"):format(path))
				else
					if module.packages then
						for package_name, packer_spec in pairs(module.packages) do
							if module.configs and module.configs[package_name] then
								packer_spec.config = module.configs[package_name]
							end
							use(packer_spec)
						end
					end
				end
			else
				-- print(("module: %s was not enabled"):format(module_name))
			end
		end
	end

	if modules._needs_sync then
		require("packer").sync()
	end
end

return modules
