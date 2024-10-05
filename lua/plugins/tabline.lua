-- return {
--     'kdheepak/tabline.nvim',
--     dependencies = {
--         'nvim-lualine/lualine.nvim',
--         'kyazdani42/nvim-web-devicons'
--     },
--     config = function()
--         require('tabline').setup {
--             -- Defaults configuration options
--             enable = true,
--             options = {
--                 -- If lualine is installed tabline will use separators configured in lualine by default.
--                 -- These options can be used to override those settings.
--                 component_separators = { '', '' },
--                 section_separators = { '', '' },
--                 max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
--                 show_tabs_always = true, -- this shows tabs only when there are more than one tab or if the first tab is named
--                 show_devicons = true, -- this shows devicons in buffer section
--                 colored = true,
--                 show_bufnr = false, -- this appends [bufnr] to buffer section,
--                 tabline_show_last_separator = true,
--                 show_filename_only = true, -- shows base filename only instead of relative path in filename
--                 modified_icon = "+ ", -- change the default modified icon
--                 modified_italic = true, -- set to true by default; this determines whether the filename turns italic if modified
--                 show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
--             }
--         }
--         vim.cmd [[
--             set guioptions-=e " Use showtabline in gui vim
--             set sessionoptions+=tabpages,globals " store tabpages and globals in session
--         ]]
--     end,
-- }
return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")
		-- colors

		local black = "#45475a"
		local gray = "#585b70"
		local red = "#f38ba8"
		local green = "#a6e3a1"
		local yellow = "#f9e2af"
		local blue = "#89b4fa"
		local magenta = "#f5c2e7"
		local cyan = "#94e2d5"
		local white = "#bac2de"
		local fg = "#cdd6f4"
		local bg = "#1e1e2e"
		local links = "#89dceb"

		bufferline.setup({
			options = {
				mode = "buffers", -- set to "tabs" to only show tabpages instead
				numbers = "none",
				color_icons = true,
				separator_style = "padded_slant",
				indicator = {
					--icon = '▎', -- this should be omitted if indicator style is not 'icon'
					-- style = "underline",
				},
				modified_icon = "●",
				left_trunc_marker = "",
				right_trunc_marker = "",
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local s = " "

					for e, _ in pairs(diagnostics_dict) do
						local sym = e == "error" and " " or (e == "warning" and " " or " ")
						s = s .. sym
					end
					return s
				end,

				show_buffer_close_icon = false,
                show_buffer_close_icons = false,
				always_show_bufferline = true,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Explorer",
						highlight = "BufferLineOffsetText",
						-- separator = true,
                        -- separator_style = "thick",
                        text_align = "center"
					}
				},
				hover = {
					enabled = true,
					delay = 200,
					reveal = {'close'}
				},
			},
			highlights = {
				-- 	fill = {
				-- 		fg = "#ffffff",
				-- 		bg = "#1e1e2e",
				-- 	},
				background = {
					-- 		bg = "#1e1e2e",
					fg = gray,
				},
				buffer_selected = {
					fg = links,
				},
				buffer_visible = {
					fg = gray,
				},
				-- 	separator_selected = {
				-- 		fg = "#1e1e2e",
				-- 	},
				-- 	separator = {
				-- 		bg = "#1e1e2e",
				-- 		fg = "#1e1e2e",
				-- 	},
				diagnostic = {},
				hint = {
					fg = cyan,
					sp = cyan,
				},
				hint_selected = {
					fg = cyan,
					sp = cyan,
				},
				warning = {
					fg = yellow,
					sp = yellow,
				},

				warning_selected = {
					fg = yellow,
					sp = yellow,
				},
				error = {
					fg = red,
					sp = red,
				},
				error_selected = {
					fg = red,
					sp = red,
				},
				-- 	-- separator_visible = {
				-- 	-- 	bg = "#1e1e2e",
				-- 	-- 	fg = "#1e1e2e",
				-- 	-- },
				offset_separator = {
					fg = "#1e1e2e",
					bg = "#45475a",
				},
			},
		})

		local function set_hlgroups()
			vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator", { fg = "#0f0f19", bg = "#0f0f19" })
			vim.api.nvim_set_hl(0, "BufferLineOffsetText", { fg = "#cdd6f4", bg = "#0f0f19", bold = true })
		end

		set_hlgroups()

		-- Optionally, set up an autocmd to ensure the highlight is set after colorscheme changes
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = set_hlgroups
		})
	end,
}
