{
  pkgs,
  lib,
  self,
  config,
  ...
}:
let
  substituteStrings = import "${self}/lib/substituteStrings.nix";
a = "a";
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

        telescope-fzf-native-nvim

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
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles-nix/home-manager/console/neovim/lua/plugins";
  };
}
