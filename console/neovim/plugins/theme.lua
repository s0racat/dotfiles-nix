 {
    'shaunsingh/nord.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd.colorscheme 'nord'
    end
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    event = 'VeryLazy',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'nord',
        -- component_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' }
      }
    }
  },

  { 'nvim-tree/nvim-web-devicons', opt = true },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    main = 'ibl',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {}
  },
