return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    opts = function(_, opts)
        opts.routes = opts.routes or {}
        table.insert(opts.routes, {
            filter = {
                event = "notify",
                find = "No information available",
            },
            opts = { skip = true },
        })
        local focused = true
        vim.api.nvim_create_autocmd("FocusGained", {
            callback = function()
                focused = true
            end,
        })
        vim.api.nvim_create_autocmd("FocusLost", {
            callback = function()
                focused = false
            end,
        })
        table.insert(opts.routes, 1, {
            filter = {
                cond = function()
                    return not focused
                end,
            },
            view = "notify_send",
            opts = { stop = false },
        })

        opts.commands = {
            all = {
                -- options for the message history that you get with `:Noice`
                view = "split",
                opts = { enter = true, format = "details" },
                filter = {},
            },
        }

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function(event)
                vim.schedule(function()
                    require("noice.text.markdown").keys(event.buf)
                end)
            end,
        })

        opts.presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = true
        }

        -- Ensure Noice doesn't override notify
        opts.notify = {
            enabled = true,
            view = "notify",
        }

        -- Correctly configure the LSP utility function overrides
        opts.lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
        }

        return opts
    end,
}