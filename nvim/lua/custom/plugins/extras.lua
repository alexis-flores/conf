-- Harpoon
vim.pack.add { 'https://github.com/ThePrimeagen/harpoon' }
require('harpoon').setup {}

-- Fugitive
vim.pack.add { 'https://github.com/tpope/vim-fugitive' }

-- Trouble
vim.pack.add { 'https://github.com/folke/trouble.nvim' }
require('trouble').setup {}

-- Noice
vim.pack.add { 'https://github.com/folke/noice.nvim' }
vim.pack.add { 'https://github.com/MunifTanjim/nui.nvim' }
vim.pack.add { 'https://github.com/rcarriga/nvim-notify' }
require('noice').setup {}

-- Bufferline
vim.pack.add { 'https://github.com/akinsho/bufferline.nvim' }
require('bufferline').setup {}

-- Flash
vim.pack.add { 'https://github.com/folke/flash.nvim' }
require('flash').setup {}
vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end, { desc = 'Flash jump' })

-- Spectre
vim.pack.add { 'https://github.com/nvim-pack/nvim-spectre' }
require('spectre').setup {}

-- Smooth scrolling
vim.pack.add { 'https://github.com/karb94/neoscroll.nvim' }
require('neoscroll').setup {}

-- Smear cursor
vim.pack.add { 'https://github.com/sphamba/smear-cursor.nvim' }
require('smear_cursor').setup {}

-- Mini animate
require('mini.animate').setup {}
