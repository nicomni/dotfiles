local utils = {}
--- Bootstrap packer.nvim if not installed.
--- Thanks to packer.nvim author wbthomason.
--- Ref: https://github.com/wbthomason/packer.nvim#bootstrapping
--- @return boolean # Whether or not packer.nvim was bootstrapped
utils.ensure_packer = function()
	local packer_install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	local fn = vim.fn
	local has_packer = pcall(require, "packer")
	if not has_packer then
		print("Installing packer")
		fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			packer_install_path,
		})
		vim.cmd([[packadd packer.nvim]])
		print("Finished installing packer.nvim")
		return true
	end
	return false
end

return utils
