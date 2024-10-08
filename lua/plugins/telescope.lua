return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
            {"smartpde/telescope-recent-files"},
            {"nvim-telescope/telescope-project.nvim"},
            {"nvim-telescope/telescope-file-browser.nvim"},
            {"echasnovski/mini.icons"},
        },
        config = function()
            require('telescope').setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-h>"] = "which_key"
                        }
                    }
                },
                pickers = {},
                extensions = {},
            })
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "recent_files")
            pcall(require("telescope").load_extension, "project")

            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")

            require("telescope").setup({
                pickers = {
                    buffers = {
                        attach_mappings = function(prompt_bufnr, map)
                            local delete_buf = function()
                                local selection = action_state.get_selected_entry()
                                actions.close(prompt_bufnr)
                                vim.api.nvim_buf_delete(selection.bufnr, { force = true })
                                require('telescope.builtin').buffers()
                            end

                            map('i', '<c-x>', delete_buf)
                            map('n', 'x', delete_buf)

                            return true
                        end,
                    },
                },
            })
        end,
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                        }
                    }
                }
            })
            require("telescope").load_extension("ui-select")
        end
    },
}
