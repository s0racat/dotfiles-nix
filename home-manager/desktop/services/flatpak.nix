{ lib, isNixOS, ... }:

lib.mkIf (!isNixOS) {
  systemd.user.services.flatpak-update = {
    Unit.Description = "flatpak-update";
    Service = {
      ExecStart = "/usr/bin/flatpak update --assumeyes --noninteractive";
      Type = "oneshot";
    };
  };

  systemd.user.timers.flatpak-update = {
    Unit.Description = "flatpak-update";
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
