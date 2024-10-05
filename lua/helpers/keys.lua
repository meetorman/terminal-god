local M = {}

M.map = function(mode, lhs, rhs, opts)
	local options = { silent = true }
	if type(opts) == "table" then
		options = vim.tbl_extend("force", options, opts)
	elseif type(opts) == "string" then
		options.desc = opts
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

M.lsp_map = function(lhs, rhs, bufnr, desc)
	vim.keymap.set("n", lhs, rhs, { silent = true, buffer = bufnr, desc = desc })
end

M.dap_map = function(mode, lhs, rhs, desc)
	M.map(mode, lhs, rhs, { desc = desc })
end

M.set_leader = function(key)
	vim.g.mapleader = key
	vim.g.maplocalleader = key
	M.map({ "n", "v" }, key, "<nop>")
end

return M
