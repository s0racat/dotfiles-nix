{ config, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        width = 50;
        icon-theme = config.gtk.iconTheme.name;
        filter-desktop = true;
        font = "monospace:size=14";
        launch-prefix = "env LANG=ja_JP.UTF-8";
      };
      colors = {

        background = "2E3440ff";
        text = "E5E9F0ff";
        match = "EBCB8Bff";
        selection = "4C566Aff";
        selection-text = "ECEFF4ff";
        selection-match = "EBCB8Bff";
        border = "E5E9F0ff";
      };
    };
  };

}
