{ pkgs, lib, ... }:
{
  services.swayidle =
    let
      command = "${lib.getExe pkgs.swaylock} -f && ${lib.getExe pkgs.playerctl} -a -i kdeconnect pause";
    in
    {
      enable = true;
      systemdTarget = "sway-session.target";
      events = [
        {
          event = "before-sleep";
          inherit command;
        }
        {
          # for loginctl lock-session
          event = "lock";
          inherit command;
        }
      ];
      timeouts = [
        # {
        #   timeout = 600;
        #   command = "${lib.getExe' pkgs.sway "swaymsg"} 'output * power off'";
        #   resumeCommand = "${lib.getExe' pkgs.sway "swaymsg"} 'output * power on'";
        # }
        {
          timeout = 600;
          command = "${lib.getExe' pkgs.systemd "systemctl"} suspend";
        }
      ];
    };
}
