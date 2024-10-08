return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")
		local colors = require("core.colors")

		bufferline.setup({
			options = {
				numbers = "none",
				color_icons = true,
				separator_style = "padded_slant",
				indicator = {
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
				background = {
					fg = colors.bufferline_gray,
				},
				buffer_selected = {
					fg = colors.bufferline_links,
				},
				buffer_visible = {
					fg = colors.bufferline_gray,
				},
				diagnostic = {},
				hint = {
					fg = colors.bufferline_cyan,
					sp = colors.bufferline_cyan,
				},
				hint_selected = {
					fg = colors.bufferline_cyan,
					sp = colors.bufferline_cyan,
				},
				warning = {
					fg = colors.bufferline_yellow,
					sp = colors.bufferline_yellow,
				},

				warning_selected = {
					fg = colors.bufferline_yellow,
					sp = colors.bufferline_yellow,
				},
				error = {
					fg = colors.bufferline_red,
					sp = colors.bufferline_red,
				},
				error_selected = {
					fg = colors.bufferline_red,
					sp = colors.bufferline_red,
				},
				offset_separator = {
					fg = colors.bufferline_offset_separator_fg,
					bg = colors.bufferline_offset_separator_bg,
				},
			},
		})

		local function set_hlgroups()
			vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator", { fg = colors.bufferline_offset_separator_custom, bg = colors.bufferline_offset_separator_custom })
			vim.api.nvim_set_hl(0, "BufferLineOffsetText", { fg = colors.bufferline_offset_text_fg, bg = colors.bufferline_offset_text_bg, bold = true })
		end

		set_hlgroups()

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = set_hlgroups
		})
	end,
}
