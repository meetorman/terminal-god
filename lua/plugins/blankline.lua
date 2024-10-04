return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        -- your existing options here
    },
    config = function(_, opts)
        require("ibl").setup(opts)

        -- Disable for dashboard
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "dashboard",
            callback = function()
                require("ibl").setup_buffer(0, { enabled = false })
            end,
        })
    end,
}
