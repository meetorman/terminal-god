-- Install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local ok, lazy = pcall(require, "lazy")
if not ok then
	return
end

-- We have to set the leader key here for lazy.nvim to work
require("helpers.keys").set_leader(" ")



-- Custom loader function to ignore specified plugins
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

-- Add auto-command to reload dashboard on configuration file changes
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*/nvim/*.lua" },
	command = "source <afile> | DashboardReload",
})

-- Function to notify recording status
local function notify_recording(status, register)
    local message
    if status == "started" then
        message = string.format('Recording started with register "%s"', register)
    else
        message = string.format('Recording ended, replay with @%s', register)
    end
    vim.notify(message, "info", {
        title = "Macro Recording",
        timeout = 2000,
    })
end

-- Autocommands for macro recording notifications
vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = function()
        local register = vim.fn.reg_recording()
        notify_recording("started", register)
    end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
    callback = function()
        local register = vim.fn.reg_recording()
        notify_recording("stopped", register)
    end,
})
