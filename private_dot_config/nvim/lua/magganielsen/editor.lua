local M = {}

function M.toggle_background()
	if vim.o.bg == "dark" then
		vim.o.bg = "light"
	else
		vim.o.bg = "dark"
	end
end

function M.open_terminal()
	vim.cmd.split()
	vim.cmd.terminal()
	vim.cmd.res(20)

	vim.wo.number = false
	vim.wo.relativenumber = false

	vim.bo.buflisted = false
end

return M
