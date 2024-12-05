{
  pkgs,
  lib,
  config,
  ...
}:
let
  substituteStrings = import ../../../lib/substituteStrings.nix;

  pwd = (import ./pwd.nix { inherit config; }).pwd;
  buildPlugin =
    name:
    pkgs.vimUtils.buildVimPlugin {
      inherit (pkgs.sources.${name}) pname version src;
    };

in
{
  programs.neovim.extraLuaConfig =

    let
      plugins = with pkgs.vimPlugins; [
        vim-closetag
        gitsigns-nvim
        nvim-lspconfig
        fidget-nvim
        (buildPlugin "vimdoc-ja")
        nvim-autopairs
        registers-nvim
        nvim-colorizer-lua
        (buildPlugin "winresizer")
        nvim-cmp
        cmp-buffer
        cmp-nvim-lsp
        cmp-path
        cmp-cmdline
        cmp_luasnip
        cmp-nvim-lsp-signature-help
        (buildPlugin "skkeleton")
        denops-vim
        vim-suda
        friendly-snippets
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
        {
          name = "hlchunk.nvim";
          path = (buildPlugin "hlchunk");
        }
        {
          name = "skkeleton_indicator.nvim";
          path = (buildPlugin "skkeleton_indicator");
        }
        {
          name = "dial.nvim";
          path = dial-nvim;
        }
        {
          name = "bufferline.nvim";
          path = bufferline-nvim;
        }
        {
          name = "telescope-file-browser.nvim";
          path = telescope-file-browser-nvim;
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
        file = ./init.lua;
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

  xdg.dataFile = {
    "skk/SKK-JISYO.L".source = "${pkgs.skkDictionaries.l}/share/skk/SKK-JISYO.L";
  };

  xdg.configFile."nvim/lua/plugins/" = {
    source = config.lib.file.mkOutOfStoreSymlink "${pwd}/plugins";
  };
}
