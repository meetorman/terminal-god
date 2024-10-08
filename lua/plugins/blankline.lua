return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function(_, opts)
        require("ibl").setup(opts)
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "dashboard",
            callback = function()
                require("ibl").setup_buffer(0, { enabled = false })
            end,
        })
    end,
}
