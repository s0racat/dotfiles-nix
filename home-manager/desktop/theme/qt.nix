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
  xdg.configFile."kdeglobals".source = pkgs.fetchurl {
    url = "raw.githubusercontent.com/EliverLara/Nordic/8f87b9e582020269d39ac7041cbe6e84c031a848/kde/colorschemes/nordicbluish.colors";
    hash = "sha256-G4L5kkuHr6sZTS0dUDOnIgEs3d1wueYBtQOYHkbWKE0=";
  };
  xdg.configFile = {
    "qt5ct/qt5ct.conf".text = qtctConf;
    "qt6ct/qt6ct.conf".text = qtctConf;
  };
}
