local function get_neotree_info()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        if ft == 'neo-tree' then
            return true, vim.api.nvim_win_get_width(win)
        end
    end
    return false, 0
end

local old = {
    "nvim-lualine/lualine.nvim",
    config = function()
        require('lualine').setup({
            options = {
                theme = 'dracula'
            }
        })
    end
}

return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'kdheepak/tabline.nvim',
    },
    config = function()
        local colors = {
            red = '#cdd6f4',
            grey = '#181825',
            black = '#1e1e2e',
            white = '#313244',
            light_green = '#6c7086',
            orange = '#fab387',
            green = '#a6e3a1',
            blue = '#80A7EA',
        }

        local theme = {
            normal = {
                a = { fg = colors.black, bg = colors.blue },
                b = { fg = colors.blue, bg = colors.white },
                c = { fg = colors.white, bg = colors.black },
                z = { fg = colors.white, bg = colors.black },
            },
            insert = { a = { fg = colors.black, bg = colors.orange } },
            visual = { a = { fg = colors.black, bg = colors.green } },
            replace = { a = { fg = colors.black, bg = colors.green } },
        }

        local vim_icons = {
            function()
                return " "
            end,
            separator = { left = "", right = "" },
            color = { bg = "#313244", fg = "#80A7EA" },
        }

        local space = {
            function()
                return " "
            end,
            color = { bg = colors.black, fg = "#80A7EA" },
        }

        local filename = {
            'filename',
            color = { bg = "#80A7EA", fg = "#242735" },
            separator = { left = "", right = "" },
        }

        local filetype = {
            "filetype",
            icon_only = true,
            colored = true,
            color = { bg = "#313244" },
            separator = { left = "", right = "" },
        }

        local filetype_tab = {
            "filetype",
            icon_only = true,
            colored = true,
            color = { bg = "#313244" },
        }

        local buffer = {
            function()
                local is_neotree_open, neotree_width = get_neotree_info()
                if is_neotree_open then
                    local padding = string.rep(' ', math.floor(neotree_width / 2) - 4)
                    local explorer_text = padding .. "Explorer" .. padding
                    local remaining_padding = string.rep(' ', neotree_width - #explorer_text)
                    return "%#NeoTreeNormal#" .. explorer_text .. remaining_padding .. "%#Normal#" .. require('tabline').tabline_buffers()
                else
                    return require('tabline').tabline_buffers()
                end
            end,
            separator = { left = "", right = "" },
        }

        local tabs = {
            require 'tabline'.tabline_tabs,
            separator = { left = "", right = "" },
        }

        local fileformat = {
            'fileformat',
            symbols = {
                unix = "󰀵", -- Use an Apple icon for Unix-like systems (including macOS)
                dos = "󰀵", -- Windows icon
                mac = "󰀵", -- Alternative macOS icon
            },
            color = { bg = "#b4befe", fg = "#313244" },
            separator = { left = "", right = "" },
        }

        local encoding = {
            'encoding',
            color = { bg = "#313244", fg = "#80A7EA" },
            separator = { left = "", right = "" },
        }

        local branch = {
            'branch',
            color = { bg = "#a6e3a1", fg = "#313244" },
            separator = { left = "", right = "" },
        }

        local diff = {
            "diff",
            color = { bg = "#313244", fg = "#313244" },
            separator = { left = "", right = "" },
        }

        local modes = {
            'mode',
            fmt = function(str) return str:sub(1, 1) end,
            color = { bg = "#fab387		", fg = "#1e1e2e" },
            separator = { left = "", right = "" },
        }

        local function getLspName()
            local msg = 'No Active Lsp'
            local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
            local clients = vim.lsp.get_active_clients()
            if next(clients) == nil then
                return msg
            end
            local lsp_names = {}
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    if client.name ~= "null-ls" then
                        table.insert(lsp_names, 1, client.name)  -- Add non-null-ls clients to the front
                    else
                        table.insert(lsp_names, client.name)  -- Add null-ls to the back
                    end
                end
            end
            if #lsp_names > 0 then
                return "  " .. lsp_names[1]  -- Return the first (prioritized) LSP name
            end
            return "  " .. msg
        end

        local dia = {
            'diagnostics',
            color = { bg = "#313244", fg = "#80A7EA" },
            separator = { left = "", right = "" },
        }

        local lsp = {
            function()
                return getLspName()
            end,
            separator = { left = "", right = "" },
            color = { bg = "#f38ba8", fg = "#1e1e2e" },
        }

        require('lualine').setup {

            options = {
                icons_enabled = true,
                theme = theme,
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },

            sections = {
                lualine_a = {
                    modes,
                    vim_icons,
                },
                lualine_b = {
                    space,
                },
                lualine_c = {
                    filename,
                    filetype,
                    space,
                    branch,
                    diff,
                },
                lualine_x = {
                    space,
                },
                lualine_y = {
                    encoding,
                    fileformat,
                    space,
                },
                lualine_z = {
                    dia,
                    lsp,
                }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {
                lualine_a = {
                    buffer,
                },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {
                    tabs,
                },
                lualine_y = {
                    space,
                },
                lualine_z = {
                },
            },
            winbar = {},
            inactive_winbar = {},

        }

        require('lualine').setup {

            options = {
                icons_enabled = true,
                theme = theme,
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },

            sections = {
                lualine_a = {
                    modes,
                    vim_icons,
                },
                lualine_b = {
                    space,
                },
                lualine_c = {
                    filename,
                    filetype,
                    space,
                    branch,
                    diff,
                },
                lualine_x = {
                    space,
                },
                lualine_y = {
                    encoding,
                    fileformat,
                    space,
                },
                lualine_z = {
                    dia,
                    lsp,
                }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {
                lualine_a = {
                    buffer,
                },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {
                    tabs,
                },
                lualine_y = {
                    space,
                },
                lualine_z = {
                },
            },
            winbar = {},
            inactive_winbar = {},

        }

        -- Add this inside the config function
        vim.cmd([[
            augroup LualineCustom
                autocmd!
                autocmd ColorScheme * highlight NeoTreeNormal guibg=#1e1e2e guifg=#cdd6f4
            augroup END
        ]])
    end
}
