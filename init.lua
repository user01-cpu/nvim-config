--Auto install packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({'git', 'clone', '--depth', '1', 'htpps://github.com/wbthomason/packer.nvim', install_path})
	vim.cmd 'packadd packer.nvim'
end

--user packer for plugins
require ('packer').startup(function(use)
	use 'wbthomason/packer.nvim'


	--file tree
	use 'kyazdani42/nvim-tree.lua'
	use 'kyazdani42/nvim-web-devicons'

	--lsp and autocomplete
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use 'onsails/lspkind-nvim'

	--tab
	use 'akinsho/bufferline.nvim'
	use 'nvim-lua/plenary.nvim'
end)


--config


--nvim-tree
require ('nvim-tree').setup {
	view = {
		width = 30,
		side = 'left',
	},
	renderer = {
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
		},
	},
}

vim.api.nvim_set_keymap ('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})


--nvim-cmp
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({ select = true}),
	}),
	sources = cmp.config.sources({
		{name = 'nvim_lsp' },
		{name = 'buffer' },
	})
})

--lsp severs
require'lspconfig'.pyright.setup{}


--tabs
require ('bufferline').setup {
	options = {
		numbers = "none",
		close_command = "bdelete! %d",
		right_mouse_command = "bdelete! %d",
		seperator_style = "slant",
		offsets = {{ filetype = "NvimTree", test = "File Explorer", padding = 1}},
	}
}

vim.api.nvim_set_keymap('n', '<C-1>', ':BufferLineGoToBuffer 1<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-2>', ':BufferLineGoToBuffer 2<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-3>', ':BufferLineGoToBuffer 3<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-4>', ':BufferLineGoToBuffer 4<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-5>', ':BufferLineGoToBuffer 5<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-Tab>', ':BufferLineCycleNext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-S-Tab>', 'BufferLineCyclePrev<CR>', {noremap = true, silent = true})

vim.cmd('highlight Normal guibg=NONE ctermbg=NONE ctermfg=NONE')
vim.cmd('colorscheme retrobox')
