local spec = {
  {
    'vim-skk/skkeleton',
    config = function()
      vim.fn["skkeleton#config"] {
        eggLikeNewline = true
      }
    end,

    dependencies = {
      'vim-denops/denops.vim'
    },

    keys = {
      { id = 'skkeleton-enable', "<C-j>", "<Plug>(skkeleton-enable)", mode = { "i", "c", "t" }, noremap = false }
    },

  }
}

return spec
