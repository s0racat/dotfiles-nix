{ pkgs, lib, ... }:
let
  systemdTarget = "sway-session.target";
in
{
  systemd.user = {
    services.swayosd = {
      Unit = {
        Description = "Volume/backlight OSD indicator";
        PartOf = [ "${systemdTarget}" ];
        After = [ "${systemdTarget}" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Documentation = "man:swayosd(1)";
      };

      Service = {
        Type = "simple";
        ExecStart = "${lib.getExe' pkgs.swayosd "swayosd-server"}";
        Restart = "always";
      };

      Install = {
        WantedBy = [ "${systemdTarget}" ];
      };
    };
  };
  home.packages = [ pkgs.swayosd ];
}
