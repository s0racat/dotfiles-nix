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
  home.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
  };
  xdg.dataFile = {
    "fcitx5/themes" = {
      source = "${pkgs.fcitx5-nord}/share/fcitx5/themes";
      recursive = true;
    };
  };
}
