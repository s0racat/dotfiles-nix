{ pkgs, ... }:
let
  fcitxEnv = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
  };
in
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
  home.sessionVariables = fcitxEnv;
  systemd.user.sessionVariables = fcitxEnv;
  xdg.dataFile = {
    "fcitx5/themes" = {
      source = "${pkgs.fcitx5-nord}/share/fcitx5/themes";
      recursive = true;
    };
  };
}
