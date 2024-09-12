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
  config,
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
      nixfmt-rfc-style
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
        require('conf.options')
        require('conf.keymap')
        require('conf.yank')
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

  xdg.configFile."nvim/lua/plugins/skkeleton.lua" = {
    source = pkgs.substituteAll {
      src = ./plugins/skkeleton.lua;
      skk_dicts = "${pkgs.skk-dicts}";
    };
  };
  xdg.configFile."nvim/lua/plugins/git.lua" = {
    text = builtins.readFile ./plugins/git.lua;
  };
  xdg.configFile."nvim/lua/plugins/lspconfig.lua" = {
    text = builtins.readFile ./plugins/lspconfig.lua;
  };
  xdg.configFile."nvim/lua/plugins/misc.lua" = {
    text = builtins.readFile ./plugins/misc.lua;
  };
  xdg.configFile."nvim/lua/plugins/nvim-cmp.lua" = {
    text = builtins.readFile ./plugins/nvim-cmp.lua;
  };
  xdg.configFile."nvim/lua/plugins/telescope.lua" = {
    text = builtins.readFile ./plugins/telescope.lua;
  };
  xdg.configFile."nvim/lua/plugins/theme.lua" = {
    text = builtins.readFile ./plugins/theme.lua;
  };
  xdg.configFile."nvim/lua/plugins/treesitter.lua" = {
    text = builtins.readFile ./plugins/treesitter.lua;
  };
  xdg.configFile."nvim/lua/plugins/vim-suda.lua" = {
    text = builtins.readFile ./plugins/vim-suda.lua;
  };
  xdg.configFile."nvim/lua/conf" = {
    source = config.lib.file.mkOutOfStoreSymlink ./conf;
    recursive = true;
  };

}
