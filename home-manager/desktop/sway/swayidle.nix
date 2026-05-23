{
  pkgs,
  lib,
  isNixOS,
  ...
}:
let
  swaylock = if isNixOS then lib.getExe pkgs.swaylock else "/usr/bin/swaylock";
  command = "${lib.getExe pkgs.playerctl} -a -i kdeconnect pause; ${swaylock} -f";
  suspendCommand =
    if isNixOS then lib.getExe' pkgs.systemd "systemctl" + " suspend" else "/usr/bin/systemctl suspend";
in
{
  services.swayidle = {
    events = [
      {
        event = "before-sleep";
        inherit command;
      }
    ];
    timeouts = [
      {
        timeout = 600;
        command = suspendCommand;
      }
    ];
  };
  services.swayidle.enable = true;
}
