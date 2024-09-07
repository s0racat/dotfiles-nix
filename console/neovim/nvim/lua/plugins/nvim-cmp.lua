local spec = {

  {
    'hrsh7th/nvim-cmp',
    config = function()
      require('conf.plugins.nvim-cmp')
    end,
  },

  -- {
  --   'rinx/cmp-skkeleton',
  --   event = 'InsertEnter',
  --   dependencies = { 'skkeleton', 'nvim-cmp' },
  -- },

  {
    'saadparwaiz1/cmp_luasnip',
    config = function()
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}
    end,
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'nvim-cmp'
    },
  },

  {
    'hrsh7th/cmp-nvim-lsp',
    event = 'InsertEnter',
    dependencies = { 'nvim-lspconfig', 'nvim-cmp' },
  },

  {
    'hrsh7th/cmp-nvim-lsp-signature-help',
    event = 'InsertEnter',
    dependencies = { 'nvim-lspconfig', 'nvim-cmp' },
  },

  {
    'hrsh7th/cmp-cmdline',
    event = 'CmdlineEnter',
    dependencies = 'nvim-cmp'
  },

  {
    'hrsh7th/cmp-buffer',
    event = 'InsertEnter',
    dependencies = 'nvim-cmp',
  },

  {
    'hrsh7th/cmp-path',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = 'nvim-cmp'
  },

}

return spec
