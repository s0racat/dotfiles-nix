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
    "qt5ct/qt5ct.conf".text =
      with config.gtk;
      lib.generators.toINI { } {
        Fonts = {
          fixed = ''"${font.name},${toString font.size},-1,5,50,0,0,0,0,0,Regular"'';
          general = ''"${font.name},${toString font.size},-1,5,50,0,0,0,0,0,Regular"'';
        };
        Appearance = {
          icon_theme = "${iconTheme.name}";
          style = "${config.qt.style.name}";
        };
      };
    "qt6ct/qt6ct.conf".text =
      with config.gtk;
      lib.generators.toINI { } {
        Fonts = {
          fixed = ''"${font.name},${toString font.size},-1,5,50,0,0,0,0,0,Regular"'';
          general = ''"${font.name},${toString font.size},-1,5,50,0,0,0,0,0,Regular"'';
        };
        Appearance = {
          icon_theme = "${iconTheme.name}";
          style = "${config.qt.style.name}";
        };
      };
  };
}
