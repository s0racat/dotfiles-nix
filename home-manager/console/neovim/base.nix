{ lib, config, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    initLua = lib.mkBefore (builtins.readFile ./lua/init.lua);
    withRuby = false;
    withPython3 = false;
  };

  xdg.configFile."nvim/lua/conf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles-nix/home-manager/console/neovim/lua/conf";
  };
}
