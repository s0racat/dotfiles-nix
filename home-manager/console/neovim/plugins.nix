{
  pkgs,
  lib,
  sources,
  ...
}:
let
  substituteStrings = import ../../../lib/substituteStrings.nix;

  vimdoc-ja = pkgs.vimUtils.buildVimPlugin {
    inherit (sources.vimdoc-ja) pname version src;
  };
  winresizer-vim = pkgs.vimUtils.buildVimPlugin {
    inherit (sources.winresizer) pname version src;
  };
  skkeleton = pkgs.vimUtils.buildVimPlugin {
    inherit (sources.skkeleton) pname version src;
  };
  hlchunk-nvim = pkgs.vimUtils.buildVimPlugin {
    inherit (sources.hlchunk) pname version src;
  };
  skkeleton_indicator-nvim = pkgs.vimUtils.buildVimPlugin {
    inherit (sources.hlchunk) pname version src;
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
        vimdoc-ja
        nvim-autopairs
        registers-nvim
        nvim-colorizer-lua
        winresizer-vim
        nvim-cmp
        cmp-buffer
        cmp-nvim-lsp
        cmp-path
        cmp-cmdline
        cmp_luasnip
        cmp-nvim-lsp-signature-help
        skkeleton
        denops-vim
        vim-suda
        friendly-snippets
        #indent-blankline-nvim
        lualine-nvim
        # おまえらなに
        nvim-treesitter
        nvim-treesitter-textobjects
        nvim-web-devicons
        # telescope 整理するか
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
          path = hlchunk-nvim;
        }
        {
          name = "skkeleton_indicator.nvim";
          path = skkeleton_indicator-nvim;
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
        file = ./lazy-nvim.lua;
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
  xdg.configFile."nvim/lua/plugins/skkeleton.lua".text =
    let
      skkeletonConfig = substituteStrings {
        file = ./skkeleton.lua;
        replacements = [
          {
            old = "@skk_dictsL@";
            new = "${pkgs.skkDictionaries.l}";
          }
        ];
      };
    in
    ''
      ${skkeletonConfig}
    '';

  xdg.configFile."nvim/lua/plugins/" = {
    source = ./plugins;
    recursive = true;
  };
}
