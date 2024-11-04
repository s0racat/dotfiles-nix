{
  pkgs,
  config,
  lib,
  ...
}:
let
  style = "Fusion";
  color_scheme_path = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/indicozy/wmtm/fafcd8a3e3eb09858a365d036e5912627e15b229/configs/Green/config/qt5ct/colors/Nord.conf";
    hash = "sha256-unWtU48YAuonuCDnegvVvKyEvh7Lu5AtgzUaFKYK53c=";
  };
  custom_palette = true;
  qtctConf =
    with config.gtk;
    lib.generators.toINI { } {
      Fonts = {
        fixed = ''"${font.name},${toString font.size},-1,5,50,0,0,0,0,0,Regular"'';
        general = ''"${font.name},${toString font.size},-1,5,50,0,0,0,0,0,Regular"'';
      };
      Appearance = {
        icon_theme = "${iconTheme.name}";
        inherit style color_scheme_path custom_palette;
      };
    };

in
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };
  xdg.configFile = {
    "qt5ct/qt5ct.conf".text = qtctConf;
    "qt6ct/qt6ct.conf".text = qtctConf;
  };
}
