{
  pkgs,
  lib,
  isNixOS,
  ...
}:
let
  swaylock = if isNixOS then lib.getExe pkgs.swaylock else "/usr/bin/swaylock";
  swaymsg = if isNixOS then lib.getExe' pkgs.sway "swaymsg" else "/usr/bin/swaymsg";
  pgrep = if isNixOS then lib.getExe' pkgs.procps "pgrep" else "/usr/bin/pgrep";
  command = "${lib.getExe pkgs.playerctl} -a -i kdeconnect pause; ${pgrep} -x swaylock >/dev/null || ${swaylock} -f";
  suspendCommand =
    if isNixOS then "${lib.getExe' pkgs.systemd "systemctl"} suspend" else "/usr/bin/systemctl suspend";
  display = status: "${swaymsg} 'output * power ${status}'";
in
{
  services.swayidle = {
    timeouts = [
      {
        timeout = 300;
        inherit command;
      }
      {
        timeout = 330;
        command = display "off";
        resumeCommand = display "on";
      }
      {
        timeout = 600;
        command = suspendCommand;
      }
    ];
    events = [
      {
        event = "before-sleep";
        inherit command;
      }
    ];
  };
  services.swayidle.enable = true;
}
