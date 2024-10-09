return {
	'nvimdev/dashboard-nvim',
	event = 'VimEnter',
	config = function()
		local function footer()
			local stats = require('lazy').stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			return { 
				'',
				'⚡ Terminal god loaded in ' .. ms .. 'ms' 
			}
		end

		require('dashboard').setup {
			theme = 'hyper',
			config = {
				week_header = {
					enable = true,
				},
				shortcut = {
						{ desc = ' Find File', group = 'DashboardShortCut', action = 'Telescope find_files', key = 'f' },
						{ desc = ' New File', group = 'DashboardShortCut', action = 'enew', key = 'n' },
						{ desc = ' Recent Files', group = 'DashboardShortCut', action = 'Telescope oldfiles', key = 'r' },
						{ desc = ' Settings', group = 'DashboardShortCut', action = 'edit $MYVIMRC', key = 's' },
				},
				packages = { enable = false },  -- Disable the package info
				project = { 
					enable = false, 
					limit = 8, 
					icon = '󰏓 ', 
					label = 'Recent Projects', 
					action = 'Telescope find_files cwd=' 
				},
				mru = { 
					limit = 10, 
					icon = '󰋚 ', 
					label = 'Recent Files', 
					cwd_only = false 
				},
				footer = footer,  -- Use the custom footer function
			}
		}
	end,
	dependencies = { {'nvim-tree/nvim-web-devicons'}}
}