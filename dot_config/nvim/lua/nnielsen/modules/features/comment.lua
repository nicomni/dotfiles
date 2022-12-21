---@type Module
local comment = {}

comment.packages = {
	["Comment.nvim"] = { "numToStr/Comment.nvim" }, -- Comments
}

comment.configs = {
	["Comment.nvim"] = function()
		require("Comment").setup()
	end,
}

return comment
