{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.wofi.enable = true;
  services.mako = {
    enable = true;
    defaultTimeout = 10000;
    font = "monospace 10";
    backgroundColor = "#2E3440";
    extraConfig = ''
      [urgency=low]
      border-color=#8FBCBB

      [urgency=normal]
      border-color=#81A1C1

      [urgency=critical]
      border-color=#BF616A
    '';
  };
  programs.zsh.profileExtra = ''
    if [ -z $DISPLAY ]; then
    	exec sway
    fi
  '';
  xdg.configFile = {
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
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "loginctl lock-session";
      }
      {
        event = "lock";
        command = "${lib.getExe pkgs.swaylock} -f && ${lib.getExe pkgs.playerctl} -a -i kdeconnect pause";
      }
      {
        event = "after-resume";
        command = "${pkgs.sway-unwrapped}/bin/swaymsg 'output * power on'";
      }
    ];
    timeouts = [
      {
        timeout = 600;
        command = "${pkgs.sway-unwrapped}/bin/swaymsg 'output * power off'";
      }
      {
        timeout = 610;
        command = "loginctl lock-session";
      }
    ];
  };
  programs.swaylock = {
    enable = true;
    settings = {
      show-failed-attempts = true;
      show-keyboard-layout = true;
      indicator-caps-lock = true;
      #image = "/usr/share/backgrounds/nordic-wallpapers/pixelcity.png"
    };
  };
  wayland.windowManager.sway =
    let
      modifier = config.wayland.windowManager.sway.config.modifier;
    in
    {
      extraConfigEarly = ''
        set $Locker swaylock -f && sleep 1

        set $mode_system System (l) lock, (e) logout, (s) suspend, (h) hibernate, (r) reboot, (Shift+s) shutdown
        mode "$mode_system" {
            bindsym l exec --no-startup-id $Locker, mode "default"
            bindsym e exec --no-startup-id swaymsg exit, mode "default"
            bindsym s exec --no-startup-id $Locker && systemctl suspend, mode "default"
            bindsym h exec --no-startup-id $Locker && systemctl hibernate, mode "default"
            bindsym r exec --no-startup-id systemctl reboot, mode "default"
            bindsym Shift+s exec --no-startup-id systemctl poweroff -i, mode "default"

            # back to normal: Enter or Escape
            bindsym Return mode "default"
            bindsym Escape mode "default"
        }

        ## Base16 Nord
        # Author: arcticicestudio

        set $base00 #2E3440
        set $base01 #3B4252
        set $base02 #434C5E
        set $base03 #4C566A
        set $base04 #D8DEE9
        set $base05 #E5E9F0
        set $base06 #ECEFF4
        set $base07 #8FBCBB
        set $base08 #BF616A
        set $base09 #D08770
        set $base0A #EBCB8B
        set $base0B #A3BE8C
        set $base0C #88C0D0
        set $base0D #81A1C1
        set $base0E #B48EAD
        set $base0F #5E81AC
      '';
      package = null;
      enable = true;
      #checkConfig = true;
      config = {
        seat = {
          "*" = {
            hide_cursor = "when-typing enable";
            xcursor_theme = "Nordzy-cursors";
          };
        };
        fonts = {
          names = [ "monospace" ];
          size = 11.0;
        };

        input = {
          "type:keyboard" = {
            repeat_delay = "280";
            repeat_rate = "30";
            xkb_options = "caps:none";
          };
          "type:pointer" = {
            accel_profile = "adaptive";
          };
        };
        bars = [
          {
            id = "default";
            #command = "swaybar";
            statusCommand = "while date +'%Y-%m-%d %X'; do sleep 1; done";
            fonts = {
              names = [ "monospace" ];
              size = 11.0;
            };
            colors = {
              background = "$base00";
              separator = "$base01";
              statusline = "$base04";
              focusedWorkspace = {
                border = "$base05";
                background = "$base0D";
                text = "$base00";
              };
              activeWorkspace = {
                border = "$base05";
                background = "$base03";
                text = "$base00";
              };
              inactiveWorkspace = {
                border = "$base03";
                background = "$base01";
                text = "$base05";
              };
              urgentWorkspace = {
                border = "$base08";
                background = "$base08";
                text = "$base00";
              };
              bindingMode = {
                border = "$base00";
                background = "$base0A";
                text = "$base00";
              };
            };
          }
        ];
        colors = {
          focused = {
            border = "$base05";
            background = "$base0D";
            text = "$base00";
            indicator = "$base0D";
            childBorder = "$base0C";
          };
          focusedInactive = {
            border = "$base01";
            background = "$base01";
            text = "$base05";
            indicator = "$base03";
            childBorder = "$base01";
          };
          unfocused = {
            border = "$base01";
            background = "$base00";
            text = "$base05";
            indicator = "$base01";
            childBorder = "$base01";

          };
          urgent = {
            border = "$base08";
            background = "$base08";
            text = "$base00";
            indicator = "$base08";
            childBorder = "$base08";

          };
          placeholder = {
            border = "$base00";
            background = "$base00";
            text = "$base05";
            indicator = "$base00";
            childBorder = "$base00";
          };
          background = "$base07";
        };
        window = {
          commands = [
            {
              command = "floating enable";
              criteria = {
                title = "Picture-in-Picture";
              };
            }
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
            {
              command = "floating enable, resize set 800 620, move scratchpad, border pixel 5";
              criteria = {
                app_id = "org.keepassxc.KeePassXC";
              };
            }

          ];
        };
        focus.followMouse = false;
        gaps = {
          smartGaps = true;
          inner = 14;
        };
        keybindings = lib.mkOptionDefault {
          "${modifier}+q" = "kill";
          "${modifier}+Shift+f" = "pcmanfm-qt";
          "${modifier}+Shift+r" = "reload";
          "${modifier}+Shift+s" = ''exec grim -g "$(slurp)" - | swappy -f -'';
          "${modifier}+Shift+e" = ''mode "$mode_system"'';
          "${modifier}+Shift+p" = ''[app_id="org.keepassxc.KeePassXC"] scratchpad show, move position center'';
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
  programs.i3status-rust = {
    enable = true;
  };
}
