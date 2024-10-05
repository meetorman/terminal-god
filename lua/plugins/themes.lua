return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup {
                color_overrides = {
                    all = {
                        text = "#ffffff",
                    },
                    mocha = {
                        base = "#1e1e2e",
                    },
                    frappe = {},
                    macchiato = {},
                    latte = {},
                }
            }
        end
    },
    -- { "miikanissi/modus-themes.nvim", priority = 1000 }
}
