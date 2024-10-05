return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
            -- recent files plugin
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
            -- Enable telescope fzf native, if installed
            pcall(require("telescope").load_extension, "fzf")
            -- Enable recent files extension, if installed
            pcall(require("telescope").load_extension, "recent_files")
            pcall(require("telescope").load_extension, "project")

            -- local map = require("helpers.keys").map
            -- map("n", "<leader>fr", require('telescope').extensions.recent_files.pick, "Recently opened")
            -- -- map("n", "<leader><space>", require("telescope.builtin").buffers, "Open buffers")
            -- map("n", "<leader>/", function()
            --     -- You can pass additional configuration to telescope to change theme, layout, etc.
            --     require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            --         winblend = 10,
            --         previewer = false,
            --     }))
            -- end, "Search in current buffer")

            -- map("n", "<leader>ff", require("telescope.builtin").find_files, "Files")
            -- map("n", "<leader>fr", require("telescope.builtin").lsp_references, "References")
            -- map("n", "<leader>fm", require("telescope.builtin").marks, "Marks")
            -- map("n", "<leader>fj", require("telescope.builtin").jumplist, "Jump List")
            -- map("n", "<leader>fh", require("telescope.builtin").help_tags, "Help")
            -- map("n", "<leader>fw", require("telescope.builtin").grep_string, "Current word")
            -- map("n", "<leader>fg", require("telescope.builtin").live_grep, "Grep")
            -- map("n", "<leader>fb", require("telescope.builtin").buffers, "Grep")
            -- map("n", "<leader>fd", require("telescope.builtin").diagnostics, "Diagnostics")

            -- map("n", "<C-p>", require("telescope.builtin").keymaps, "Search keymaps")

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
                                -- Reopen the buffer picker
                                require('telescope.builtin').buffers()
                            end

                            -- Map Ctrl-u to delete the selected buffer
                            map('i', '<c-x>', delete_buf)
                            map('n', 'x', delete_buf)

                            -- Return true to keep default mappings
                            return true
                        end,
                    },
                },
            })
        end,
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        -- This is your opts table
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
