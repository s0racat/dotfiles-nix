{
  dconf.settings = {
    # this is like a system-wide dark mode switch that some apps respect
    # equivalent of the following dconf command:
    # `dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"`
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
