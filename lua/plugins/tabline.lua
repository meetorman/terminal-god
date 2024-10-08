return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")

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
					fg = gray,
				},
				buffer_selected = {
					fg = links,
				},
				buffer_visible = {
					fg = gray,
				},
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

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = set_hlgroups
		})
	end,
}
