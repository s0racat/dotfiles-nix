{
  pkgs,
  config,
  lib,
  ...
}:
let
  style = "kvantum";
in
rec {
  qt = {
    enable = true;
    platformTheme.name = "qtct";
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
          inherit style;
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
          inherit style;
        };
      };
  };
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
  ];
}
