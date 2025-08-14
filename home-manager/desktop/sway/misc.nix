{ config, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        width = 50;
        icon-theme = config.gtk.iconTheme.name;
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
