{
  config,
  lib,
  ...
}:
let
  style = "Fusion";
  color_scheme_path = "${config.xdg.configHome}/qt5ct/colors/base16-nord.conf";
  custom_palette = true;
in
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };
  xdg.configFile = {
    "qt5ct/qt5ct.conf".text =
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
    "qt6ct/qt6ct.conf".text =
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
    "qt5ct/colors/base16-nord.conf".text = ''
      /*
      *
      * Base16 Nord
      * Author: arcticicestudio
      *
      */

      [ColorScheme]
      active_colors=#ff88c0d0, #ff3b4252, #ff3b4252, #ffe5e9f0, #ff4c566a, #ffd8dee9, #ffb48ead, #ffeceff4, #ffe5e9f0, #ff3b4252, #ff2e3440, #ff4c566a, #ff434c5e, #ffb48ead, #ffd08770, #ffbf616a, #ff434c5e, #ffe5e9f0, #ff3b4252, #ffb48ead, #8fb48ead
      disabled_colors=#ff5e81ac, #ff3b4252, #ff3b4252, #ffe5e9f0, #ff4c566a, #ffd8dee9, #ff5e81ac, #ff5e81ac, #ff5e81ac, #ff3b4252, #ff2e3440, #ff4c566a, #ff434c5e, #ffb48ead, #ffd08770, #ffbf616a, #ff434c5e, #ffe5e9f0, #ff3b4252, #ff5e81ac, #8f5e81ac
      inactive_colors=#ff88c0d0, #ff3b4252, #ff3b4252, #ffe5e9f0, #ff4c566a, #ffd8dee9, #ffb48ead, #ffeceff4, #ffe5e9f0, #ff3b4252, #ff2e3440, #ff4c566a, #ff434c5e, #ffb48ead, #ffd08770, #ffbf616a, #ff434c5e, #ffe5e9f0, #ff3b4252, #ffb48ead, #8fb48ead
    '';
  };
}
