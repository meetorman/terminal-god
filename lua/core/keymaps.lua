local map = require("helpers.keys").map
local wk = require("which-key")
-- Unmap default comment keybindings
vim.keymap.del('n', 'gc')
vim.keymap.del('n', 'gcc')
vim.keymap.del('x', 'gc')
vim.keymap.del('o', 'gc')
vim.keymap.del('n', 'gx') 
vim.keymap.del('n', 'g%') 
-- Function to create the pass-through mapping
local function z_passthrough()
    local key = vim.fn.getchar()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("z" .. string.char(key), true, false, true), 'n', false)
end

-- Keep your existing non-which-key mappings as they are

-- Use wk.add to configure your keymaps
wk.add({
  { "<leader>l", name = "Language (LSP)", group = "Language", icon="" }, 
  { "<leader>lb", vim.lsp.buf.format, mode = "n", desc = "Format file", icon="󰉵" },

    
  -- Movement and Selection
  { "J", ":m '>+1<CR>gv=gv", mode = "v", desc = "Move selected lines down" },
  { "K", ":m '<-2<CR>gv=gv", mode = "v", desc = "Move selected lines up" },

  -- Scrolling and Centering
  { "<C-u>", "<C-u>zz", mode = "n", desc = "Scroll up and center" },
  { "<C-d>", "<C-d>zz", mode = "n", desc = "Scroll down and center" },
  { "J", "mzJ`z", mode = "n", desc = "Join lines and keep cursor position" },
  { "n", "nzzzv", mode = "n", desc = "Next search result and center" },
  { "N", "Nzzzv", mode = "n", desc = "Previous search result and center" },

  -- Clipboard Operations
  { "<leader>p", [["_dP]], mode = "x", desc = "Paste (without yanking)" },
  { "<leader>y", [["+y]], mode = { "n", "v" }, desc = "Yank to clipboard", icon="󰅍" },
--   { "<leader>Y", [["+Y]], mode = "n", desc = "Yank line to system clipboard" },
--   { "<leader>d", [["_d]], mode = { "n", "v" }, desc = "Delete without yanking" },

  -- Miscellaneous
  -- { "Q", "<nop>", mode = "n", desc = "Disable Ex mode" },
  { "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", mode = "n", desc = "Open tmux sessionizer" },

  -- Quickfix and Location List Navigation
--   { "<C-S-k>", "<cmd>cnext<CR>zz", mode = "n", desc = "Next quickfix item" },
--   { "<C-S-j>", "<cmd>cprev<CR>zz", mode = "n", desc = "Previous quickfix item" },
--   { "<leader>k", "<cmd>lnext<CR>zz", mode = "n", desc = "Next location list item" },
--   { "<leader>j", "<cmd>lprev<CR>zz", mode = "n", desc = "Previous location list item" },

  -- Search and Replace
  { "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], mode = "n", desc = "Search/Replace", icon="󰛔" },
  { "<leader>s", [["hy:%s/<C-r>h//gc<left><left><left>]], mode = "v", desc = "Search/Replace (selected text)", icon="󰑑" },

  -- File Operations
--   { "<leader>x", "<cmd>!chmod +x %<CR>", mode = "n", desc = "Make current file executable" },

  -- Fun
--   { "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", mode = "n", desc = "Cellular automaton animation" },

  -- Reload Current File
--   { "<leader><leader>", function() vim.cmd("so") end, mode = "n", desc = "Reload current file" },

  -- NeoTree
  { "<leader>e", ":Neotree toggle<CR>", mode = "n", desc = "Explorer", icon=""},

  {"<leader>a", group = "AI", icon = "󱚟" },
  -- ChatGPT mappings
  { "<leader>ag", name = "ChatGPT", group = "ChatGPT" },
  { "<leader>agc", ":ChatGPT<CR>", mode = "n", desc = "Open ChatGPT Conversation" },
  { "<leader>agd", ":ChatGPTRun explain_code<CR>", mode = "n", desc = "Explain Code" },
  { "<leader>age", ":ChatGPTEditWithInstruction<CR>", mode = { "n", "v" }, desc = "Edit with Instruction" },

  -- ProjectMgr mapping
  { "<leader>p", ":lua require'telescope'.extensions.project.project{}<CR>", mode = "n", desc = "Projects", icon="󱂵" },

  -- Telescope mappings
  {"<leader>f", group = "Files", icon = "" },
  
--   ["<leader>/"] = { 
--     function()
--       require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
--         winblend = 10,
--         previewer = false,
--       }))
--     end,
--     "Search in current buffer",
--     mode = "n"
--   },

  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n", icon="󰈞" },
  { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "References", mode = "n", icon="" },
  { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks", mode = "n", icon="󰮯" },
  { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Jump List", mode = "n", icon="󱋿" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help", mode = "n", icon="" },
  { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Current word", mode = "n", icon="󰍉" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep", mode = "n", icon={icon="󰍉", color = "green"} },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers", mode = "n", icon=""},
  { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics", mode = "n" },
--   ["<C-p>"] = { require("telescope.builtin").keymaps, "Search keymaps", mode = "n" },

  -- Undo Tree
  { "<leader>u", "<cmd>UndotreeToggle<cr>", mode = "n", desc = "Undo Tree", icon = "󰣜"},
  { "<leader>ld", vim.lsp.buf.declaration, mode = "n", desc = "Declaration", icon = "" },
  { "<leader>lf", vim.lsp.buf.definition, mode = "n", desc = "Definition", icon = "" },
  { "<leader>li", vim.lsp.buf.implementation, mode = "n", desc = "Implementation", icon = "" },
  { "<leader>lr", vim.lsp.buf.references, mode = "n", desc = "References", icon = "" },
  { "<leader>lh", vim.lsp.buf.hover, mode = "n", desc = "Hover", icon = "" },
  -- ... (keep your other existing mappings)
  {"<leader>lc", group = "Comment", icon = "" },
  { "<leader>lcc", function() require("Comment.api").toggle.linewise.current() end, mode = "n", desc = "Toggle comment" },
  { "<leader>lcb", function() require("Comment.api").toggle.blockwise.current() end, mode = "n", desc = "Toggle block comment" },
  { "<leader>lcO", function() require("Comment.api").insert.linewise.above() end, mode = "n", desc = "Comment above" },
  { "<leader>lco", function() require("Comment.api").insert.linewise.below() end, mode = "n", desc = "Comment below" },
  { "<leader>lcA", function() require("Comment.api").insert.linewise.eol() end, mode = "n", desc = "Comment at end of line" },
  { "<leader>g", "<cmd>Neogit<cr>", mode = "n", desc = "Git", icon="" },
  
})
vim.keymap.set('n', 'Q', '<nop>', { noremap = true, silent = true })

-- If you need to use setup_lsp_keymaps elsewhere, you can define it here
-- local function setup_lsp_keymaps(bufnr)
--   local opts = { buffer = bufnr, silent = true }
  
--   wk.register({
--     g = {
--       name = "+Go to",
--       { "D", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Declaration", icon = "" },
--       { "d", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Definition", icon = "" },
--       { "i", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Implementation", icon = "" },
--       { "r", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "References", icon = "" },
--     },
--     K = { vim.lsp.buf.hover, "Hover Information" },
--     ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature Help" },
--     ["<leader>lh"] = { vim.lsp.buf.hover, "Hover Information" },
--     ["<leader>ls"] = { vim.lsp.buf.signature_help, "Signature Help" },
--     ["<space>"] = {
--       { "D", vim.lsp.buf.type_definition, desc = "Type Definition", icon = "" },
--       { "rn", vim.lsp.buf.rename, desc = "Rename", icon = "" },
--       { "ca", vim.lsp.buf.code_action, desc = "Code Action", icon = "" },
--     },
--   }, opts)
-- end

-- -- Return the setup_lsp_keymaps function if needed elsewhere
-- return {
--     setup_lsp_keymaps = setup_lsp_keymaps
-- }
