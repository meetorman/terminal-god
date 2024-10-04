local util = require("vim.lsp.util")

local function split_lines(value)
  value = string.gsub(value, "&nbsp;", " ")
  value = string.gsub(value, "&gt;", ">")
  value = string.gsub(value, "&lt;", "<")
  value = string.gsub(value, "\\", "")
  value = string.gsub(value, "```python", "")
  value = string.gsub(value, "```", "")
  return vim.split(value, "\n", { plain = true, trimempty = true })
end

local function convert_input_to_markdown_lines(input, contents)
  contents = contents or {}
  assert(type(input) == "table", "Expected a table for LSP input")
  if input.kind then
    local value = input.value or ""
    vim.list_extend(contents, split_lines(value))
  end
  if (contents[1] == "" or contents[1] == nil) and #contents == 1 then
    return {}
  end
  return contents
end

local function hover(_, result, ctx, config)
  config = config or {}
  config.focus_id = ctx.method
  if vim.api.nvim_get_current_buf() ~= ctx.bufnr then
    return
  end
  if not (result and result.contents) then
    if config.silent ~= true then
      vim.notify("No information available")
    end
    return
  end
  local contents = convert_input_to_markdown_lines(result.contents)
  if vim.tbl_isempty(contents) then
    if config.silent ~= true then
      vim.notify("No information available")
    end
    return
  end
  return util.open_floating_preview(contents, "plaintext", config)
end

return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "L3MON4D3/LuaSnip" },
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require("cmp")
            local cmp_action = lsp_zero.cmp_action()
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local cmp_jump = { behavior = cmp.SelectBehavior.Select, count = 4 }

            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                formatting = lsp_zero.cmp_format(),
                mapping = cmp.mapping.preset.insert({
                    -- ["<C-Space>"] = cmp.mapping.complete(),
                    -- ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    -- ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    -- ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    -- ["<C-b>"] = cmp_action.luasnip_jump_backward(),
                    ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_jump),
                    ["<C-n>"] = cmp.mapping.select_next_item(cmp_jump),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
            })
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright",
                    -- ... other language servers ...
                },
                handlers = {
                    lsp_zero.default_setup,
                    pyright = function()
                        require("lspconfig").pyright.setup({
                            handlers = {
                                ["textDocument/publishDiagnostics"] = function() end,  -- Disable diagnostics if you're using ruff
                                ["textDocument/hover"] = vim.lsp.with(hover, {
                                    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                                    title = " Hover ",
                                    max_width = 120,
                                    zindex = 500,
                                }),
                            },
                            settings = {
                                pyright = {
                                    disableOrganizeImports = false,
                                },
                                python = {
                                    analysis = {
                                        autoImportCompletions = true,
                                        autoSearchPaths = true,
                                        diagnosticMode = "workspace",  -- or "off" if you want to disable
                                        typeCheckingMode = "off",
                                        useLibraryCodeForTypes = true,
                                    },
                                },
                            },
                        })
                    end,
                    -- ... other language server configurations ...
                },
            })

            -- ... rest of your LSP configuration ...
        end,
    },

    -- null-ls configuration
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.isort,
                    -- ... other null-ls sources ...
                },
            })
        end,
    },
}
-- return {
--     {
--         "VonHeikemen/lsp-zero.nvim",
--         branch = "v3.x",
--     },
--     {
--         "williamboman/mason.nvim",
--         config = function()
--             require("mason").setup({})
--         end,
--     },
--     {
--         "williamboman/mason-lspconfig.nvim",
--         config = function()
--             require("mason-lspconfig").setup({
--                 -- ensure_installed = { "lua_ls", "tsserver", "clangd", "cmake", "cssls", "html", "pyright" }
--                 auto_installed = true,
--             })
--         end,
--     },
--     {
--         "neovim/nvim-lspconfig",
--         config = function()
--             local lspconfig = require("lspconfig")
--             lspconfig.lua_ls.setup({})
--             lspconfig.tsserver.setup({})
--             lspconfig.clangd.setup({
--                 -- cmd = {"/usr/bin/clangd", "--tab-width=4"},
--                 -- root_dir = lspconfig.util.root_pattern('.git');
--             })
--             lspconfig.cmake.setup({})
--             lspconfig.cssls.setup({})
--             lspconfig.html.setup({})
--
--             local map = require("helpers.keys").map
--             map("n", "K", vim.lsp.buf.hover, {})
--             map("n", "gd", vim.lsp.buf.definition, {})
--             map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
--         end,
--     },
-- }
