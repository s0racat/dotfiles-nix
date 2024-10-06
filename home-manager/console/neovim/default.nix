{
  lib,
  pkgs,
  ...
}:
let
  concatFiles = import ../../../lib/concatFiles.nix;
  substituteStrings = import ../../../lib/substituteStrings.nix;
in
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
      #bash-language-server
      nodePackages.bash-language-server
      vim-language-server
      emmet-language-server
      gopls
      nil
      pyright
      stylua
      nixfmt-rfc-style
      #skk-dicts-latest
      pkgs.skkDictionaries.l
    ];

    plugins = with pkgs.vimPlugins; [ lazy-nvim ];

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
        lazyConfig = substituteStrings {
          file = ./plugins/lazy-nvim.lua;
          replacements = [
            {
              old = "@lazyPath@";
              new = "${lazyPath}";
            }
          ];
        };
      in
      ''
        ${lazyConfig}
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

  xdg.configFile."nvim/lua/plugins.lua".text =
    let
      skkeletonConfig = substituteStrings {
        file = ./plugins/skkeleton.lua;
        replacements = [
          {
            old = "@skk_dictsL@";
            new = "${pkgs.skkDictionaries.l}";
          }
        ];
      };
    in
    ''
      return {
      ${concatFiles [
        ./plugins/git.lua
        ./plugins/lspconfig.lua
        ./plugins/misc.lua
        ./plugins/nvim-cmp.lua
        ./plugins/telescope.lua
        ./plugins/theme.lua
        ./plugins/treesitter.lua
        ./plugins/vim-suda.lua
      ]}
      ${skkeletonConfig}
      }
    '';

  xdg.configFile."nvim/lua/conf" = {
    source = ./conf;
    recursive = true;
  };

}
