{ config, ... }:
{
  dconf.settings = {

    "org/cinnamon/desktop/wm/preferences" = {
      titlebar-font = "Roboto Medium 11";
    };
    "org/x/apps/portal".color-scheme = "prefer-dark";
    "org/cinnamon/desktop/interface" = with config.gtk; {
      icon-theme = iconTheme.name;
      gtk-theme = theme.name;
      cursor-theme = cursorTheme.name;
      font-name = "Roboto 12";
    };
  };

}
