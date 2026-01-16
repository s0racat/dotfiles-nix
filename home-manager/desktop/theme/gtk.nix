{ pkgs, ... }:
{
  gtk = {
    enable = true;
    font.name = "Roboto";
    font.size = 13;
    cursorTheme = {
      package = pkgs.nordzy-cursor-theme;
      name = "Nordzy-cursors";
      size = 32;
    };
    theme = {
      name = "Nordic-bluish-accent-standard-buttons";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-nord.override { accent = "frostblue3"; };
    };
  };
}
