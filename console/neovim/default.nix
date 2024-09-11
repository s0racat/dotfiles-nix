# { pkgs, ... }:
# {
#   imports = [
#     # inputs.nixvim.homeManagerModules.nixvim
#     # ./plugins/lazy-nvim.nix
#   ];
#   # programs.nixvim = {
#   #   enable = true;
#   #   plugins.lazy.enable = true;
#   # };
#   programs.neovim = {
#     enable = true;
#     defaultEditor = true;
#     viAlias = true;
#     vimAlias = true;
#     vimdiffAlias = true;
#     # extraLuaPackages = luaPkgs: with luaPkgs; [ 
#     #   luarocks
#     #  ];
#     plugins = with pkgs.vimPlugins; [
#       {
#         plugin = lazy-nvim;
#         type = "lua";
#         config = builtins.readFile ./lazy-nvim.lua;
#       }

#     ];
#     extraLuaConfig = ''
#       require('conf.options')
#       require('conf.keymap')
#       require('conf.yank')
#     '';
#   };
# }

{
  lib,
  pkgs,
  ...
}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
      lua-language-server
      nodePackages.typescript-language-server
      bash-language-server
      vim-language-server
      emmet-language-server
      gopls
      nil
      pyright
      stylua
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraLuaConfig =
      let
        plugins = with pkgs.vimPlugins; [
          gitsigns-nvim
          nvim-lspconfig
          fidget-nvim
          # vimdoc-ja
          nvim-autopairs
          registers-nvim
          nvim-colorizer-lua
          # winresizer
          nvim-cmp
          cmp-buffer
          cmp-nvim-lsp
          cmp-path
          cmp-cmdline
          cmp_luasnip
          cmp-nvim-lsp-signature-help
          # skkeleton
          denops-vim
          vim-suda
          friendly-snippets
          indent-blankline-nvim
          lualine-nvim
          nvim-treesitter
          nvim-treesitter-textobjects
          nvim-web-devicons
          plenary-nvim
          telescope-fzf-native-nvim
          telescope-nvim
          nord-nvim
          {
            name = "LuaSnip";
            path = luasnip;
          }
        ];
        mkEntryFromDrv =
          drv:
          if lib.isDerivation drv then
            {
              name = "${lib.getName drv}";
              path = drv;
            }
          else
            drv;
        lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
      in
      ''
          require("lazy").setup(
            "plugins",
            {
                defaults = {
                    lazy = true,
                },
                dev = {
                    -- reuse files from pkgs.vimPlugins.*
                    path = "${lazyPath}",
                    patterns = { "." },
                    -- fallback to download
                    fallback = true,
                },
                performance = {
                    cache = {
                        enabled = true,
                    },
                    reset_packpath = true, -- reset the package path to improve startup time
                    rtp = {
                        reset = true,      -- reset the runtime path to $VIMRUNTIME and your config directory
                        ---@type string[]
                        paths = {},        -- add any custom paths here that you want to includes in the rtp
                        ---@type string[] list any plugins you want to disable here
                        disabled_plugins = {
                            "gzip",
                            "matchit",
                            "matchparen",
                            "netrwPlugin",
                            "tarPlugin",
                            "tohtml",
                            "tutor",
                            "zipPlugin",
                        },
                    },
                },
            })
        require('conf.options')
        require('conf.keymap')
        require('conf.yank')
      '';
  };

  # https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
  xdg.configFile."nvim/parser".source =
    let
      parsers = pkgs.symlinkJoin {
        name = "treesitter-parsers";
        paths =
          (pkgs.vimPlugins.nvim-treesitter.withPlugins (
            plugins: with plugins; [
              go
              nix
              tsx
              bash
            ]
          )).dependencies;
      };
    in
    "${parsers}/parser";

  # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
  # xdg.configFile."nvim/lua".source = ./lua;
}
