{
  pkgs,
  lib,
  config,
  isNixOS,
  ...
}:
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
        ExecStart = ''
          ${lib.getExe' pkgs.swayosd "swayosd-server"} ${
            lib.optionalString (!isNixOS) "-s ${pkgs.swayosd}/etc/xdg/swayosd/style.css"
          }
        '';

        Restart = "always";
        Environment = lib.mkIf (!isNixOS) [
          "XDG_DATA_DIRS=/usr/share:${config.home.profileDirectory}/share"
        ];
      };

      Install = {
        WantedBy = [ "${systemdTarget}" ];
      };
    };
  };
  home.packages = [ pkgs.swayosd ];
}
