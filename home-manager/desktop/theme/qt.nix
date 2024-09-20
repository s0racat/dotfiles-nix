{
  pkgs,
  config,
  lib,
  ...
}:
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };
  xdg.configFile = {
    "Kvantum/Nordic-bluish-solid".source = "${pkgs.nordic}/share/Kvantum/Nordic-bluish-solid";
    "Kvantum/kvantum.kvconfig".text = lib.generators.toINI { } {
      General = {
        theme = "Nordic-bluish-solid";
      };
    };
    "qt5ct/qt5ct.conf".text = lib.generators.toINI { } {
      Fonts = {
        fixed = ''"Roboto,12,-1,5,50,0,0,0,0,0,Regular"'';
        general = ''"Roboto,12,-1,5,50,0,0,0,0,0,Regular"'';
      };
      Appearance = {
        icon_theme = "Papirus-Dark";
        style = "kvantum";
      };
    };
    "qt6ct/qt6ct.conf".text = lib.generators.toINI { } {
      Fonts = {
        fixed = ''"Roboto,12,-1,5,50,0,0,0,0,0,Regular"'';
        general = ''"Roboto,12,-1,5,50,0,0,0,0,0,Regular"'';
      };
      Appearance = {
        icon_theme = "Papirus-Dark";
        style = "kvantum";
      };
    };
  };
}
