return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local colors= require('core.colors')

        local theme = {
            normal = {
                a = { fg = colors.lualine_black, bg = colors.lualine_blue },
                b = { fg = colors.lualine_blue, bg = colors.lualine_white },
                c = { fg = colors.lualine_white, bg = colors.lualine_black },
                z = { fg = colors.lualine_white, bg = colors.lualine_black },
            },
            insert = { a = { fg = colors.lualine_black, bg = colors.lualine_orange } },
            visual = { a = { fg = colors.lualine_black, bg = colors.lualine_green } },
            replace = { a = { fg = colors.lualine_black, bg = colors.lualine_green } },
        }

        local vim_icons = {
            function()
                return " "
            end,
            separator = { left = "", right = "" },
            color = { bg = colors.lualine_vim_icons_bg, fg = colors.lualine_vim_icons_fg },
        }

        local space = {
            function()
                return " "
            end,
            color = { bg = colors.lualine_black, fg = colors.lualine_space_fg },
        }

        local filename = {
            'filename',
            color = { bg = colors.lualine_filename_bg, fg = colors.lualine_filename_fg },
            separator = { left = "", right = "" },
        }

        local filetype = {
            "filetype",
            icon_only = true,
            colored = true,
            color = { bg = colors.lualine_filetype_bg },
            separator = { left = "", right = "" },
        }

        local filetype_tab = {
            "filetype",
            icon_only = true,
            colored = true,
            color = { bg = colors.lualine_filetype_bg },
        }

        local buffer = {}

        local tabs = {}

        local fileformat = {
            'fileformat',
            symbols = {
                unix = "󰀵",
                dos = "󰀵",
                mac = "󰀵",
            },
            color = { bg = colors.lualine_fileformat_bg, fg = colors.lualine_fileformat_fg },
            separator = { left = "", right = "" },
        }

        local encoding = {
            'encoding',
            color = { bg = colors.lualine_encoding_bg, fg = colors.lualine_encoding_fg },
            separator = { left = "", right = "" },
        }

        local branch = {
            'branch',
            color = { bg = colors.lualine_branch_bg, fg = colors.lualine_branch_fg },
            separator = { left = "", right = "" },
        }

        local diff = {
            "diff",
            color = { bg = colors.lualine_diff_bg, fg = colors.lualine_diff_fg },
            separator = { left = "", right = "" },
        }

        local modes = {
            'mode',
            fmt = function(str) return str:sub(1, 1) end,
            color = { bg = colors.lualine_modes_bg, fg = colors.lualine_modes_fg },
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
                        table.insert(lsp_names, 1, client.name)
                    else
                        table.insert(lsp_names, client.name)
                    end
                end
            end
            if #lsp_names > 0 then
                return "  " .. lsp_names[1]
            end
            return "  " .. msg
        end

        local dia = {
            'diagnostics',
            color = { bg = colors.lualine_dia_bg, fg = colors.lualine_dia_fg },
            separator = { left = "", right = "" },
        }

        local lsp = {
            function()
                return getLspName()
            end,
            separator = { left = "", right = "" },
            color = { bg = colors.lualine_lsp_bg, fg = colors.lualine_lsp_fg },
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
            winbar = {},
            inactive_winbar = {},

        }
        vim.cmd([[
            augroup LualineCustom
                autocmd!
                autocmd ColorScheme * highlight NeoTreeNormal guibg=#1e1e2e guifg=#cdd6f4
            augroup END
        ]])
    end
}
