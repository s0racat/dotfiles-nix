{
  pkgs,
  lib,
  config,
  ...
}:
let
  systemdTarget = "sway-session.target";
  isNixOS = (import ./isNixOS.nix).isNixOS;
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
        Environment = lib.mkIf (!isNixOS) [ "/usr/share:${config.home.profileDirectory}/share" ];
      };

      Install = {
        WantedBy = [ "${systemdTarget}" ];
      };
    };
  };
  home.packages = [ pkgs.swayosd ];
}
