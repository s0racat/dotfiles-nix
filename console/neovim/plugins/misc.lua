local spec = {
  { 'tpope/vim-sleuth', event = 'VeryLazy' },

  {
    'folke/which-key.nvim',
    opts = {},
    keys = {
      "<leader>", "<C-w>", "<C-e>"
    }
  },

  {
    'numToStr/Comment.nvim',
    opts = {},
    keys = {
      { "gcc", mode = "n",          desc = "Comment toggle current line" },
      { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n",          desc = "Comment toggle current block" },
      { "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" }
    }
  },

  {
    'vim-jp/vimdoc-ja',
    event = 'CmdlineEnter',
    config = function()
      vim.o.helplang = "ja,en"
    end
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },

  {
    'tversteeg/registers.nvim',
    config = function()
      require('registers').setup()
    end,
    keys = {
      { '"',     mode = { "n", "v" } },
      { "<C-R>", mode = "i" }
    },
    cmd = "Registers"
  },

  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
    ft = { 'lua', 'css', 'html', 'sass', 'less', 'typescriptreact', 'conf', 'vim', 'i3config', 'swayconfig' }
  },

  {
    'simeji/winresizer',
    keys = {
      "<C-e>"
    }
  },

	{
		'alvan/vim-closetag',
		ft = { 'javascript', 'html'}
	}

}

return spec
