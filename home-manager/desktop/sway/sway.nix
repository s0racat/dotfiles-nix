{
  pkgs,
  config,
  lib,
  ...
}:
{

  wayland.windowManager.sway =
    let
      modifier = config.wayland.windowManager.sway.config.modifier;
    in
    {
      enable = true;
      package = null;
      #checkConfig = true;
      #systemd.enable = false;
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
      config = {
        terminal = "foot";
        output = {
          "HDMI-A-1" = {
            # bg = "${
            #   pkgs.fetchurl {
            #     url = "https://raw.githubusercontent.com/linuxdotexe/nordic-wallpapers/fd5814f83df436166bbaa68af1d9833181f771f7/wallpapers/nixos.png";
            #     sha256 = "1lvy7bpiqm3pyc47q55vxz01zfwi8sm960jdgqnjsa8cy3afl7lc";
            #   }
            # } fill";
            bg = "${
              pkgs.fetchurl {
                url = "https://i.pximg.net/img-master/img/2024/09/13/19/05/54/122395805_p0_master1200.jpg";
                sha256 = "sha256-Zg9kY6oCbtzUfFIUne9Xy2JWeUk9Q4gyoSVRPcS98u8=";
                curlOptsList = [
                  "-H"
                  "User-Agent: Mozilla/5.0"
                  "-H"
                  "Referer: https://pixiv.net"
                ];
              }
            } fill";
          };
        };

        seat = {
          "*" = {
            hide_cursor = "when-typing enable";
            xcursor_theme = with config.gtk.cursorTheme; "${name} ${toString size}";
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
            #statusCommand = "while date +'%Y-%m-%d %X'; do sleep 1; done";
            statusCommand = "i3status-rs ${config.xdg.configHome}/i3status-rust/config.toml";
            fonts = {
              names = [
                "DejaVu Sans Mono"
                "FontAwesome"
              ];
              size = 10.0;
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
                title = "(Picture-in-Picture|ピクチャーインピクチャー)";
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
          "${modifier}+Shift+f" = "exec pcmanfm-qt";
          "${modifier}+Shift+r" = "reload";
          "${modifier}+Shift+s" = ''exec grim -g "$(slurp)" - | swappy -f -'';
          "${modifier}+Shift+e" = ''mode "$mode_system"'';
          "${modifier}+Shift+p" = ''[app_id="org.keepassxc.KeePassXC"] scratchpad show, move position center'';
          "XF86MonBrightnessDown" = "exec swayosd-client --brightness lower";
          "XF86MonBrightnessUp" = "exec swayosd-client --brightness raise";
          "XF86AudioRaiseVolume" = "exec swayosd-client --output-volume raise";
          "XF86AudioLowerVolume" = "exec swayosd-client --output-volume lower";
          "XF86AudioMute" = "exec swayosd-client --output-volume mute-toggle";
          "${modifier}+period" = "exec wofi-emoji";
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "${modifier}+x" = "exec cliphist list | wofi --show dmenu | cliphist decode | wl-copy";
        };
        modifier = "Mod4";
        menu = "wofi --show drun --allow-images --columns 2";
        startup = [
          { command = "lxqt-policykit-agent"; }
          { command = "fcitx5 -r -d"; }
          { command = "playerctl-notify"; }
          { command = "keepassxc"; }
        ];
      };
    };

  programs.zsh.profileExtra = ''
    if [ -z $DISPLAY ]; then
    	exec sway
    fi
  '';
}
