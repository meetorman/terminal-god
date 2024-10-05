return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
        local opts = {
            config = {
                -- Your dashboard configuration here
                -- Keep it minimal to allow lualine to handle the centering
            },
        }
        return opts
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
}