return {
    "rcarriga/nvim-notify",
    config = function()
        local notify = require("notify")

        -- Custom render function
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

        -- Setup notify with custom render function
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
    end
}