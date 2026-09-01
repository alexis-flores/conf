return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#16130b',
				base01 = '#16130b',
				base02 = '#939088',
				base03 = '#939088',
				base04 = '#eeeadf',
				base05 = '#fffdf8',
				base06 = '#fffdf8',
				base07 = '#fffdf8',
				base08 = '#ffa49b',
				base09 = '#ffa49b',
				base0A = '#f9dc8b',
				base0B = '#afffa2',
				base0C = '#ffefc3',
				base0D = '#f9dc8b',
				base0E = '#ffe6a2',
				base0F = '#ffe6a2',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#939088',
				fg = '#fffdf8',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#f9dc8b',
				fg = '#16130b',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#939088' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffefc3', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#ffe6a2',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#f9dc8b',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#f9dc8b',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#ffefc3',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#afffa2',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#eeeadf' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#eeeadf' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#939088',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
