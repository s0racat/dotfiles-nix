{
  dconf.settings = {
    # this is like a system-wide dark mode switch that some apps respect
    # equivalent of the following dconf command:
    # `dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"`
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/shell" = {
      # お気に入りのアプリ
      favorite-apps = [
        "Alacritty.desktop"
        "firefox.desktop"
        "org.keepassxc.KeePassXC.desktop"
        "nemo.desktop"
        "xed.desktop"
        # "chromium-browser.desktop"
        # "code.desktop"
        # "org.gnome.Nautilus.desktop"
        "gnome-system-monitor.desktop"
        "org.gnome.Console.desktop"
        # "org.gnome.TextEditor.desktop"
      ];
    };
  };
}
