{ pkgs, lib, ... }:
{
  services.swayidle =
    let
      lockCmd = "${lib.getExe pkgs.swaylock} -f && ${lib.getExe pkgs.playerctl} -a -i kdeconnect pause";
    in
    {
      enable = true;
      systemdTarget = "sway-session.target";
      events = [
        {
          event = "before-sleep";
          command = "${lockCmd}";
        }
        {
          event = "lock";
          command = "${lockCmd}";
        }
      ];
      timeouts = [
        {
          timeout = 600;
          command = "${pkgs.sway}/bin/swaymsg 'output * power off'";
          resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * power on'";
        }
        {
          timeout = 620;
          command = "${lockCmd}";
        }
      ];
    };
}
