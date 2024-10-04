-- Disable Netrw (these are global options)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Local options
local local_opts = {
    shiftwidth = 4,
    tabstop = 4,
    expandtab = true,
    wrap = false,
    number = true,
    relativenumber = true,
    swapfile = false,
    backup = false,
    undofile = true,
    incsearch = true,
    hlsearch = true,
    scrolloff = 8,
    signcolumn = "yes",
    -- colorcolumn = 80,
}

-- Global options
local global_opts = {
    termguicolors = true,
    undodir = os.getenv("HOME") .. "/.vim.undodir",
    updatetime = 250,
    pumheight = 10,
}

-- Set local options
for opt, val in pairs(local_opts) do
    vim.opt[opt] = val
end

-- Set global options
for opt, val in pairs(global_opts) do
    vim.o[opt] = val
end

-- Set other options
local colorscheme = require("helpers.colorscheme")
vim.cmd.colorscheme(colorscheme)

-- Remove ~ from empty lines
vim.opt.fillchars = vim.opt.fillchars + { eob = " " }


