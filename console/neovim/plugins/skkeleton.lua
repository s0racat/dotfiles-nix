local spec = {
  {
    'vim-skk/skkeleton',
    config = function()
      vim.fn["skkeleton#config"] {
        eggLikeNewline = true
      }
    end,
    cond = function()
      return os.getenv("WSLENV") == nil
    end,

    dependencies = {
      'vim-denops/denops.vim',
      { "delphinus/skkeleton_indicator.nvim", opts = {} }

    },

    keys = {
      { id = 'skkeleton-enable', "<C-j>", "<Plug>(skkeleton-enable)", mode = { "i", "c", "t" }, noremap = false }
    },


  },

}

return spec
