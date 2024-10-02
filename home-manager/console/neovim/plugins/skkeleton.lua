  {
    'vim-skk/skkeleton',
    config = function()
      local skk_dicts = {}
      table.insert(skk_dicts, "@skk_dictsL@" .. "/share/skk/SKK-JISYO.L")
      vim.fn["skkeleton#config"] {
        eggLikeNewline = true,
        globalDictionaries = skk_dicts,

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
