local map = require("helpers.keys").map
local wk = require("which-key")
vim.keymap.del('n', 'gc')
vim.keymap.del('n', 'gcc')
vim.keymap.del('x', 'gc')
vim.keymap.del('o', 'gc')
vim.keymap.del('n', 'gx') 
vim.keymap.del('n', 'g%') 
local function z_passthrough()
    local key = vim.fn.getchar()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("z" .. string.char(key), true, false, true), 'n', false)
end


wk.add({
  { "<leader>l", name = "Language (LSP)", group = "Language", icon="" }, 
  { "<leader>lb", vim.lsp.buf.format, mode = "n", desc = "Format file", icon="󰉵" },
  { "<leader>lm", ":RenderMarkdown toggle<cr>", mode = "n", desc = "Markdown", icon="󰉵" },

    
  { "J", ":m '>+1<CR>gv=gv", mode = "v", desc = "Move selected lines down" },
  { "K", ":m '<-2<CR>gv=gv", mode = "v", desc = "Move selected lines up" },

  { "<C-u>", "<C-u>zz", mode = "n", desc = "Scroll up and center" },
  { "<C-d>", "<C-d>zz", mode = "n", desc = "Scroll down and center" },
  { "J", "mzJ`z", mode = "n", desc = "Join lines and keep cursor position" },
  { "n", "nzzzv", mode = "n", desc = "Next search result and center" },
  { "N", "Nzzzv", mode = "n", desc = "Previous search result and center" },

  { "<leader>p", [["_dP]], mode = "x", desc = "Paste (without yanking)" },
  { "<leader>y", [["+y]], mode = { "n", "v" }, desc = "Yank to clipboard", icon="󰅍" },

  { "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", mode = "n", desc = "Open tmux sessionizer" },


  { "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], mode = "n", desc = "Search/Replace", icon="󰛔" },
  { "<leader>s", [["hy:%s/<C-r>h//gc<left><left><left>]], mode = "v", desc = "Search/Replace (selected text)", icon="󰑑" },




  { "<leader>e", ":Neotree toggle<CR>", mode = "n", desc = "Explorer", icon=""},

  {"<leader>a", group = "AI", icon = "󱚟" },
  { "<leader>ag", name = "ChatGPT", group = "ChatGPT" },
  { "<leader>agc", ":ChatGPT<CR>", mode = "n", desc = "Open ChatGPT Conversation" },
  { "<leader>agd", ":ChatGPTRun explain_code<CR>", mode = "n", desc = "Explain Code" },
  { "<leader>age", ":ChatGPTEditWithInstruction<CR>", mode = { "n", "v" }, desc = "Edit with Instruction" },

  { "<leader>p", ":lua require'telescope'.extensions.project.project{}<CR>", mode = "n", desc = "Projects", icon="󱂵" },

  {"<leader>f", group = "Files", icon = "" },
  

  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n", icon="󰈞" },
  { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "References", mode = "n", icon="" },
  { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks", mode = "n", icon="󰮯" },
  { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Jump List", mode = "n", icon="󱋿" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help", mode = "n", icon="" },
  { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Current word", mode = "n", icon="󰍉" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep", mode = "n", icon={icon="󰍉", color = "green"} },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers", mode = "n", icon=""},
  { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics", mode = "n" },

  { "<leader>u", "<cmd>UndotreeToggle<cr>", mode = "n", desc = "Undo Tree", icon = "󰣜"},
  { "<leader>ld", vim.lsp.buf.declaration, mode = "n", desc = "Declaration", icon = "" },
  { "<leader>lf", vim.lsp.buf.definition, mode = "n", desc = "Definition", icon = "" },
  { "<leader>li", vim.lsp.buf.implementation, mode = "n", desc = "Implementation", icon = "" },
  { "<leader>lr", vim.lsp.buf.references, mode = "n", desc = "References", icon = "" },
  { "<leader>lh", vim.lsp.buf.hover, mode = "n", desc = "Hover", icon = "" },
  {"<leader>lc", group = "Comment", icon = "" },
  { "<leader>lcc", function() require("Comment.api").toggle.linewise.current() end, mode = "n", desc = "Toggle comment" },
  { "<leader>lcb", function() require("Comment.api").toggle.blockwise.current() end, mode = "n", desc = "Toggle block comment" },
  { "<leader>lcO", function() require("Comment.api").insert.linewise.above() end, mode = "n", desc = "Comment above" },
  { "<leader>lco", function() require("Comment.api").insert.linewise.below() end, mode = "n", desc = "Comment below" },
  { "<leader>lcA", function() require("Comment.api").insert.linewise.eol() end, mode = "n", desc = "Comment at end of line" },
  { "<leader>g", "<cmd>Neogit<cr>", mode = "n", desc = "Git", icon="" },
  
})
vim.keymap.set('n', 'Q', '<nop>', { noremap = true, silent = true })

  

