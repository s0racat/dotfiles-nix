{ pkgs, lib, ... }:
let
  isNixOS = (import ./isNixOS.nix).isNixOS;
  swayidle = if isNixOS then lib.getExe pkgs.swayidle else "/usr/bin/swayidle";
  swaylock = if isNixOS then lib.getExe pkgs.swaylock else "/usr/bin/swaylock";
  systemdTarget = "sway-session.target";
  command = "${swaylock} -f && ${lib.getExe pkgs.playerctl} -a -i kdeconnect pause";
  suspendCommand =
    if isNixOS then lib.getExe' pkgs.systemd "systemctl" + "suspend" else "/usr/bin/systemctl suspend";
in
{
  systemd.user.services.swayidle = {
    Unit = {
      Description = "Idle manager for Wayland";
      Documentation = "man:swayidle(1)";
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      Restart = "always";
      # swayidle executes commands using "sh -c", so the PATH needs to contain a shell.
      Environment = [ "PATH=${lib.makeBinPath [ pkgs.bash ]}" ];
      ExecStart = "${swayidle} -w timeout 600 '${suspendCommand}' before-sleep '${command}' lock '${command}'";
    };

    Install = {
      WantedBy = [ "${systemdTarget}" ];
    };
  };
}
