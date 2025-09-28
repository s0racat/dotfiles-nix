{
  pkgs,
  lib,
  self,
  ...
}:
let
  substituteStrings = import "${self}/lib/substituteStrings.nix";
  buildPlugin =
    name:
    pkgs.vimUtils.buildVimPlugin {
      inherit (pkgs.sources.${name}) pname version src;
    };
  skkeleton_indicator = (buildPlugin "skkeleton_indicator").overrideAttrs {
    nvimRequireCheck = "skkeleton_indicator";
  };
in
{
  programs.neovim = {
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
      skkDictionaries.l
    ];
    plugins = with pkgs.vimPlugins; [ lazy-nvim ];
  };
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
          name = "rainbow-delimiters.nvim";
          path = rainbow-delimiters-nvim;
        }
        {
          name = "hlchunk.nvim";
          path = buildPlugin "hlchunk";
        }
        {
          name = "skkeleton_indicator.nvim";
          path = skkeleton_indicator;
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
        {
          name = "lazygit.nvim";
          path = buildPlugin "lazygit_nvim";
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
        file = ./lua/init-lazy.lua;
        replacements = [
          {
            old = "@lazyPath@";
            new = "${lazyPath}";
          }
        ];
      };

    in
    lib.mkAfter ''
      ${lazyConfig}
    '';

  xdg.dataFile = {
    "skk/SKK-JISYO.L".source = "${pkgs.skkDictionaries.l}/share/skk/SKK-JISYO.L";
  };

  xdg.configFile."nvim/lua/plugins/" = {
    source = ./lua/plugins;
  };
}
