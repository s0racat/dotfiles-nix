{
  pkgs,
  lib,
  isNixOS,
  ...
}:
let
  swaylock = if isNixOS then lib.getExe pkgs.swaylock else "/usr/bin/swaylock";
  systemdTarget = "sway-session.target";
  command = "${swaylock} -f && ${lib.getExe pkgs.playerctl} -a -i kdeconnect pause";
  suspendCommand =
    if isNixOS then lib.getExe' pkgs.systemd "systemctl" + " suspend" else "/usr/bin/systemctl suspend";
in
{
  systemd.user.services.swayidle = {
    Service = {
      ExecStart = lib.mkForce "${lib.getExe pkgs.swayidle} -w timeout 600 ${lib.escapeShellArg suspendCommand} before-sleep ${lib.escapeShellArg command} lock ${lib.escapeShellArg command}";
    };
    Install = {
      WantedBy = lib.mkForce [ "${systemdTarget}" ];
    };
  };
  services.swayidle.enable = true;
}
