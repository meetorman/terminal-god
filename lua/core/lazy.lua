local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then
	return
end

require("helpers.keys").set_leader(" ")

local function load_plugins(plugin_folder)
    local plugins = {}
    local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/" .. plugin_folder .. "/*.lua")
    for _, file in ipairs(vim.split(plugin_files, "\n")) do
        local plugin_name = vim.fn.fnamemodify(file, ":t:r")
        if not _G.ignore_plugins or not vim.tbl_contains(_G.ignore_plugins, plugin_name) then
            table.insert(plugins, require(plugin_folder .. "." .. plugin_name))
        end
    end
    return plugins
end

lazy.setup(load_plugins("plugins"))



