{
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
    extraLuaConfig = builtins.readFile ./lua/init.lua;
  };

  xdg.configFile."nvim/lua/conf" = {
    source = ./lua/conf;
  };
}
