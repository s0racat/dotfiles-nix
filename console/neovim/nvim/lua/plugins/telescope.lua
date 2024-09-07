local spec = {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    cmd = 'Telescope',
    keys = {
      "<leader>?",
      "<leader><space>",
      "<leader>/",
      "<leader>gf",
      "<leader>sf",
      "<leader>sh",
      "<leader>sw",
      "<leader>sg",
      "<leader>sd"
    },
    config = function()
      require('conf.plugins.telescope')
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',

      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.

      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end
      }

    }
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",

    dependencies = { "nvim-telescope/telescope.nvim" },

    config = function()
      require("telescope").load_extension "file_browser"
    end,
    keys = {
      { id = 'fb', "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<cr>", mode = 'n' }
    }
  }
}

return spec
