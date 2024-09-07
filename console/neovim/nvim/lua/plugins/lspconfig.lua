local spec = {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = {'BufNewFile', 'BufReadPre'},
    config = function()
      require('conf.plugins.lspconfig')
    end,
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim

      {
        'williamboman/mason.nvim',
        config = function()
          require('mason').setup({
            ui = {
              icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
              }
            }
          })
        end,
      },

      'williamboman/mason-lspconfig.nvim',

      {
        'folke/neodev.nvim',
        config = function()
          require('neodev').setup()
        end
      },

      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} }

    },
  },
}

return spec
