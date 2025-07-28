{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.wayland.windowManager.sway;
in
{
  # /usr/share/wayland-sessions/sway.desktop
  # < Exec=sway
  # ---
  # > Exec=bash -l -c "sway"

  wayland.windowManager.sway =
    let
      inherit (cfg.config) modifier;
    in
    {
      enable = true;
      package = null;
      #checkConfig = true;
      config =
        let
          system = "System (l) lock, (e) logout, (s) suspend, (h) hibernate, (r) reboot, (Shift+s) shutdown";
          colors = {
            "base00" = "#2E3440";
            "base01" = "#3B4252";
            "base02" = "#434C5E";
            "base03" = "#4C566A";
            "base04" = "#D8DEE9";
            "base05" = "#E5E9F0";
            "base06" = "#ECEFF4";
            "base07" = "#8FBCBB";
            "base08" = "#BF616A";
            "base09" = "#D08770";
            "base0A" = "#EBCB8B";
            "base0B" = "#A3BE8C";
            "base0C" = "#88C0D0";
            "base0D" = "#81A1C1";
            "base0E" = "#B48EAD";
            "base0F" = "#5E81AC";
          };
        in
        {
          keybindings = lib.mkOptionDefault {
            "${modifier}+q" = "kill";
            "${modifier}+Shift+f" = "exec pcmanfm-qt";
            "${modifier}+Shift+r" = "reload";
            "${modifier}+Shift+s" = ''exec grim -g "$(slurp)" - | swappy -f -'';
            "${modifier}+Shift+e" = ''mode ${lib.escapeShellArg system}'';
            "${modifier}+Shift+p" =
              ''[app_id="org.keepassxc.KeePassXC"] scratchpad show, move position center'';
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

          modes = lib.mkOptionDefault {
            # default値を引き継いでくれるらしい
            ${system} =
              let
                locker = "swaylock -f && sleep 1";
              in
              {
                l = "exec ${locker}, mode default";
                e = "exec swaymsg exit, mode default";
                s = "exec ${locker} && systemctl suspend, mode default";
                h = "exec ${locker} && systemctl hibernate, mode default";
                r = "exec systemctl reboot, mode default";
                "Shift+s" = "exec systemctl poweroff -i, mode default";
                # back to normal: Enter or Escape
                Return = "mode default";
                Escape = "mode default";
              };
          };

          terminal = "foot";
          output =
            let
              wallpaper = pkgs.fetchurl {
                url = "https://i.pximg.net/img-master/img/2024/09/13/19/05/54/122395805_p0_master1200.jpg";
                hash = "sha256-Zg9kY6oCbtzUfFIUne9Xy2JWeUk9Q4gyoSVRPcS98u8=";
                curlOptsList = [
                  "-H"
                  "User-Agent: Mozilla/5.0"
                  "-H"
                  "Referer: https://pixiv.net"
                ];
              };
            in
            {
              "HDMI-A-1" = {
                bg = "${wallpaper} fill";
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
              statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs";
              fonts = {
                names = [
                  "DejaVu Sans Mono"
                  "FontAwesome"
                ];
                size = 10.0;
              };
              colors = {
                background = "${colors.base00}";
                separator = "${colors.base01}";
                statusline = "${colors.base04}";
                focusedWorkspace = {
                  border = "${colors.base05}";
                  background = "${colors.base0D}";
                  text = "${colors.base00}";
                };
                activeWorkspace = {
                  border = "${colors.base05}";
                  background = "${colors.base03}";
                  text = "${colors.base00}";
                };
                inactiveWorkspace = {
                  border = "${colors.base03}";
                  background = "${colors.base01}";
                  text = "${colors.base05}";
                };
                urgentWorkspace = {
                  border = "${colors.base08}";
                  background = "${colors.base08}";
                  text = "${colors.base00}";
                };
                bindingMode = {
                  border = "${colors.base00}";
                  background = "${colors.base0A}";
                  text = "${colors.base00}";
                };
              };
            }
          ];
          colors = {
            focused = {
              border = "${colors.base05}";
              background = "${colors.base0D}";
              text = "${colors.base00}";
              indicator = "${colors.base0D}";
              childBorder = "${colors.base0C}";
            };
            focusedInactive = {
              border = "${colors.base01}";
              background = "${colors.base01}";
              text = "${colors.base05}";
              indicator = "${colors.base03}";
              childBorder = "${colors.base01}";
            };
            unfocused = {
              border = "${colors.base01}";
              background = "${colors.base00}";
              text = "${colors.base05}";
              indicator = "${colors.base01}";
              childBorder = "${colors.base01}";
            };
            urgent = {
              border = "${colors.base08}";
              background = "${colors.base08}";
              text = "${colors.base00}";
              indicator = "${colors.base08}";
              childBorder = "${colors.base08}";
            };
            placeholder = {
              border = "${colors.base00}";
              background = "${colors.base00}";
              text = "${colors.base05}";
              indicator = "${colors.base00}";
              childBorder = "${colors.base00}";
            };
            background = "${colors.base07}";
          };
          floating.titlebar = false;
          floating.criteria = [
            {
              app_id = "mpv";
            }
            {
              app_id = "org.kde.kdeconnect.handler";
            }
            {
              title = "Authentication Required";
            }
          ];
          window = {
            titlebar = false;
            commands = [
              {
                command = "floating enable, sticky enable";
                criteria = {
                  title = "(Picture-in-Picture|ピクチャーインピクチャー)";
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
          focus.mouseWarping = "container";
          gaps = {
            smartGaps = true;
            inner = 14;
          };
          modifier = "Mod4";
          menu = "wofi --show drun --allow-images --columns 2";
          startup = [
            { command = "lxqt-policykit-agent"; }
            { command = "fcitx5 -r -d"; }
            { command = "${pkgs.playerctl-notify}/bin/playerctl-notify"; }
            { command = "keepassxc"; }
          ];
        };
      extraConfig = ''
        for_window [all] inhibit_idle fullscreen
      '';
    };

  programs.zsh.profileExtra = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty2" ]; then
    	exec sway
    fi
  '';

  home.packages = [
    pkgs.font-awesome_4
  ];
}
