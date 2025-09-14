{ lib, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = lib.mkBefore (builtins.readFile ./lua/init.lua);
  };

  xdg.configFile."nvim/lua/conf" = {
    source = ./lua/conf;
  };
}
