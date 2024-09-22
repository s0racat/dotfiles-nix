{
  pkgs,
  config,
  lib,
  ...
}:
{
  xdg.configFile = {
    "fcitx5" = {
      source = ./fcitx5;
      recursive = true;
      force = true;
    };
    "libskk" = {
      source = ./libskk;
      recursive = true;
    };
  };
}
