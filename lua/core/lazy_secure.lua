-- Import plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)
require("helpers.keys").set_leader(" ")
-- Configure Lazy
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	defaults = {
		lazy = false,
		version = false,
	},
	install = { 
		colorscheme = { "catppuccin" },
		missing = false,  -- Prevent automatic installation of missing plugins
	},
	checker = { enabled = false },  -- Disable update checking
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	git = {
		timeout = 0,  -- Disable Git operations
	},
	ui = {
		custom_keys = {
			["<localleader>u"] = false,  -- Disable the update key
		},
	},
})


-- Debug information
local lazy_path = vim.fn.stdpath("data") .. "/lazy"
for _, plugin in ipairs(vim.fn.readdir(lazy_path) or {}) do
end

-- Disable Lazy
if _G.disable_lazy then
	print("Lazy is disabled")
	return
end

