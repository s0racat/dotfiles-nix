{ pkgs, lib, ... }:
{
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;


      # お気に入りのアプリ
      favorite-apps = [
        "Alacritty.desktop"
        "firefox.desktop"
        "org.keepassxc.KeePassXC.desktop"
        "nemo.desktop"
        "org.x.editor.desktop"
        # "chromium-browser.desktop"
        # "code.desktop"
        # "org.gnome.Nautilus.desktop"
        "org.gnome.SystemMonitor.desktop"
        "org.gnome.Terminal.desktop"
        # "org.gnome.TextEditor.desktop"
      ];
    };
    "org/gnome/desktop/background" = {
      picture-uri-dark = "file://${
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/linuxdotexe/nordic-wallpapers/1b0102fb3fc39d29bf9d1c5385b1c1ad873c7e54/wallpapers/ign_cityRain.png";
          hash = "sha256-RdHQa9UoSqhAv74FWaZmcnkxbNNTXwSOlHX5iiF8b08=";
        }
      }";
      picture-uri = "file://${
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/linuxdotexe/nordic-wallpapers/1b0102fb3fc39d29bf9d1c5385b1c1ad873c7e54/wallpapers/ign_cityRain.png";
          hash = "sha256-RdHQa9UoSqhAv74FWaZmcnkxbNNTXwSOlHX5iiF8b08=";
        }
      }";
    };

    "org/gnome/desktop/screensaver".picture-uri = "file://${
      pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/linuxdotexe/nordic-wallpapers/1b0102fb3fc39d29bf9d1c5385b1c1ad873c7e54/wallpapers/ign_cityRain.png";
        hash = "sha256-RdHQa9UoSqhAv74FWaZmcnkxbNNTXwSOlHX5iiF8b08=";
      }
    }";


    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-left = [ "<Control><Super>Left" ];
      switch-to-workspace-right = [ "<Control><Super>Right" ];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = [ "<Super>z" ];
      home = [  ];
      email = [  ];
      www = [  ];
      terminal = [  ];
      search = [ "<Super>d" ];
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>t";
      command = "alacritty";
      name = "terminal";

    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>e";
      command = "nemo";
      name = "file manager";

    };
    "org/gnome/desktop/peripherals/keyboard" = {
      repeat-interval = lib.hm.gvariant.mkUint32 30;
      delay = lib.hm.gvariant.mkUint32 280;
    };
    "org/gnome/desktop/input-sources".xkb-options = [ "caps:none" ];

  };
}
