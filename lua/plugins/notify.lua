return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        local notify = require("notify")

        -- Custom render function for notify
        local custom_render = function(bufnr, notif, highlights, config)
            local namespace = vim.api.nvim_create_namespace("notify")
            local icon = notif.icon
            local title = notif.title[1]
            local message = notif.message[1]

            -- Convert to 12-hour format
            local time = os.date("*t")
            local hour = time.hour % 12
            if hour == 0 then hour = 12 end
            local ampm = time.hour < 12 and "AM" or "PM"
            local timestamp = string.format("%02d:%02d %s", hour, time.min, ampm)

            -- Render the notification
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
                string.format("%s %s - %s", icon, title, timestamp),
                message
            })

            -- Apply highlights
            vim.api.nvim_buf_add_highlight(bufnr, namespace, highlights.icon, 0, 0, #icon + 1)
            vim.api.nvim_buf_add_highlight(bufnr, namespace, highlights.title, 0, #icon + 1, -1)
            vim.api.nvim_buf_add_highlight(bufnr, namespace, highlights.body, 1, 0, -1)
        end

        -- Setup notify
        notify.setup({
            render = custom_render,
            background_colour = "#000000",
            fps = 30,
            icons = {
                DEBUG = "",
                ERROR = "",
                INFO = "",
                TRACE = "✎",
                WARN = ""
            },
            level = 2,
            minimum_width = 50,
            stages = "fade_in_slide_out",
            timeout = 5000,
            top_down = true
        })

        -- Set as default notify function
        vim.notify = notify

        -- Noice configuration
        require("noice").setup({
            routes = {
                {
                    filter = {
                        event = "notify",
                        find = "No information available",
                    },
                    opts = { skip = true },
                },
                {
                    filter = {
                        cond = function()
                            return not vim.g.focused
                        end,
                    },
                    view = "notify_send",
                    opts = { stop = false },
                },
            },
            commands = {
                all = {
                    view = "split",
                    opts = { enter = true, format = "details" },
                    filter = {},
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = true
            },
            notify = {
                enabled = true,
                view = "notify",
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
            },
        })

        -- Autocmds for focus events
        vim.api.nvim_create_autocmd("FocusGained", {
            callback = function()
                vim.g.focused = true
            end,
        })
        vim.api.nvim_create_autocmd("FocusLost", {
            callback = function()
                vim.g.focused = false
            end,
        })

        -- Autocmd for markdown files
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function(event)
                vim.schedule(function()
                    require("noice.text.markdown").keys(event.buf)
                end)
            end,
        })

        -- Function for macro recording notifications
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

        -- Autocmds for macro recording
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

        vim.api.nvim_create_user_command("Notify", function(opts)
            vim.notify(opts.args, "info", {
                title = "Custom Notification",
                timeout = 2000,
            })
        end, { nargs = "+" })
    end
}