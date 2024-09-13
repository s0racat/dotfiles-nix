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
    ft = { 'javascript', 'html' }
  },
