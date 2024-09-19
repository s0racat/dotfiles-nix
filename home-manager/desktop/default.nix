{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ../console/default.nix
  ];
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    # noto-fonts-color-emoji
    twemoji-color-font
    roboto
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    libsForQt5.qtstyleplugin-kvantum
  ];
  home.sessionVariables = {
      KPXC_CONFIG_LOCAL= "${config.xdg.configHome}/keepassxc/keepassxc.ini";
  };
  programs.zsh.profileExtra = ''
      if [ -z $DISPLAY ]; then
      exec sway
    fi
  '';
  home.file.".bashrc".enable = false;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;

  };
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };
  xdg.configFile = {
    "Kvantum/Nordic-bluish-solid".source = "${pkgs.nordic}/share/Kvantum/Nordic-bluish-solid";
    "Kvantum/kvantum.kvconfig".text = lib.generators.toINI { } {
      General = {
        theme = "Nordic-bluish-solid";
      };
    };
    "qt5ct/qt5ct.conf".text = lib.generators.toINI { } {
      Fonts = {
        fixed = ''"Roboto,12,-1,5,50,0,0,0,0,0,Regular"'';
        general = ''"Roboto,12,-1,5,50,0,0,0,0,0,Regular"'';

      };
      Appearance = {
        icon_theme = "Papirus-Dark";
        style = "kvantum";
      };
    };
    "qt6ct/qt6ct.conf".text = lib.generators.toINI { } {
      Fonts = {
        fixed = ''"Roboto,12,-1,5,50,0,0,0,0,0,Regular"'';
        general = ''"Roboto,12,-1,5,50,0,0,0,0,0,Regular"'';

      };
      Appearance = {
        icon_theme = "Papirus-Dark";
        style = "kvantum";
      };
    };
    "foot/foot.ini".text = lib.generators.toINI { } {
      main = {
        shell = "zsh --login -c 'tmux attach || tmux'";
        font = "monospace:size=12";
        dpi-aware = "yes";

      };
      cursor = {
        style = "block";
        color = "2e3440 d7dee9";
        blink = "yes";
      };

      colors = {
        foreground = "d8dee9";
        background = "2e3440";
        regular0 = "3b4252";
        regular1 = "bf616a";
        regular2 = "a3be8c";
        regular3 = "ebcb8b";
        regular4 = "81a1c1";
        regular5 = "b48ead";
        regular6 = "88c0d0";
        regular7 = "e5e9f0";

        bright0 = "4c566a";
        bright1 = "bf616a";
        bright2 = "a3be8c";
        bright3 = "ebcb8b";
        bright4 = "81a1c1";
        bright5 = "b48ead";
        bright6 = "8fbcbb";
        bright7 = "eceff4";

        dim0 = "373e4d";
        dim1 = "94545d";
        dim2 = "809575";
        dim3 = "b29e75";
        dim4 = "68809a";
        dim5 = "8c738c";
        dim6 = "6d96a5";
        dim7 = "aeb3bb";
      };
    };
  };
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.nordzy-cursor-theme;
      name = "Nordzy-cursors";
      size = 24;

    };
    theme = {
      name = "Nordic-bluish-accent";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = (pkgs.papirus-nord.override { accent = "frostblue3"; });
    };
  };

  fonts = {
    # packages = with pkgs; [
    #   noto-fonts-cjk-sans
    #   noto-fonts-cjk-serif
    #   noto-fonts-color-emoji
    #   roboto-mono
    # ];
    fontconfig = {
      enable = true;
      defaultFonts = {

        sansSerif = [
          "Roboto"
          "Noto Sans CJK JP"
        ];
        serif = [
          "Noto Sans CJK JP"
        ];
        monospace = [
          "JetBrainsMono Nerd Font"
        ];
        emoji = [
          "Twitter Color Emoji"
        ];
      };

    };
  };
  programs.firefox = {
    enable = true;
    package = null;
    profiles = {
      default = {
        settings = {
          "media.ffmpeg.vaapi.enabled" = true;
        };

        bookmarks = [
          {
            name = "Nix sites";
            toolbar = true;
            bookmarks = [
              {
                name = "homepage";
                url = "https://nixos.org/";
              }
              {
                name = "wiki";
                tags = [
                  "wiki"
                  "nix"
                ];
                url = "https://wiki.nixos.org/";
              }
            ];
          }
        ];
      };
    };
  };
  programs.mpv.enable = true;
  wayland.windowManager.sway = {
    package = null;
    enable = true;
    #checkConfig = true;
    config = {

      window = {
        commands = [
          {
            command = "floating enable";
            criteria = {
              app_id = "mpv";
            };
          }
          {
            command = "floating enable";
            criteria = {
              app_id = "org.kde.kdeconnect.handler";
            };
          }
          {
            command = "floating enable";
            criteria = {
              app_id = "org.keepassxc.KeePassXC";
            };
          }
          {
            command = "floating enable";
            criteria = {
              title = "Authentication Required";
            };
          }
          {
            command = "border pixel 2";
            criteria = {
              app_id = "^.*";
              class = "^.*";
            };
          }
          {
            command = "inhibit_idle fullscreen";
            criteria = {
              app_id = ".*";
              class = ".*";
            };
          }

        ];
      };
      focus.followMouse = false;
      gaps = {
        #smartGaps = true;
        inner = 14;
        outer = 7;
      };
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${modifier}+q" = "kill";
          "${modifier}+Shift+f" = "pcmanfm-qt";
          "${modifier}+Shift+r" = "reload";
          "${modifier}+Shift+s" = ''exec grim -g "$(slurp)" - | swappy -f -'';
          "XF86MonBrightnessDown" = "exec light -U 5";
          "XF86MonBrightnessUp" = "exec light -A 5";
          "XF86AudioRaiseVolume" = "pamixer -ui 2";
          "XF86AudioLowerVolume" = "pamixer -ud 2";
          "XF86AudioMute" = "pamixer --toggle-mute";
          "${modifier}+period" = "wofi-emoji";
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
        };
      modifier = "Mod4";
      menu = "wofi --show drun --allow-iamges --columns 2";
      startup = [
        { command = "lxqt-policykit-agent"; }
        { command = "fcitx5 -r -d"; }
      ];
    };
  };
}
