-- Disable Plugins
-- Uncomment line below to disable plugins in list
-- _G.ignore_plugins = { "copilot", "chatgpt" }

-- Handle plugins with lazy.nvim
require("core.lazy")

-- Other options
require("core.options")

-- General Neovim keymaps
require("core.keymaps")
