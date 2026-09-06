return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#cdb27b',
				base01 = '#cdb27b',
				base02 = '#6c6a69',
				base03 = '#6c6a69',
				base04 = '#232221',
				base05 = '#bfbcba',
				base06 = '#bfbcba',
				base07 = '#bfbcba',
				base08 = '#99413c',
				base09 = '#99413c',
				base0A = '#8c592e',
				base0B = '#001800',
				base0C = '#9e846e',
				base0D = '#8c592e',
				base0E = '#d7c1ae',
				base0F = '#d7c1ae',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#6c6a69',
				fg = '#bfbcba',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#8c592e',
				fg = '#cdb27b',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#6c6a69' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#9e846e', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#d7c1ae',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#8c592e',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#8c592e',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#9e846e',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#001800',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#232221' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#232221' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#6c6a69',
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
