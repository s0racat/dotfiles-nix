local spec = {
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    build = ':TSUpdate',
    config = function()
      require('conf.plugins.treesitter')
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects'
    }
  }
}

return spec
