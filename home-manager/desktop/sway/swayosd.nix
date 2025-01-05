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
        PartOf = lib.mkForce [ "${systemdTarget}" ];
        After = lib.mkForce [ "${systemdTarget}" ];
      };

      Service = {
        ExecStart = lib.mkForce ''
          ${lib.getExe' pkgs.swayosd "swayosd-server"} ${
            lib.optionalString (!isNixOS) "-s ${pkgs.swayosd}/etc/xdg/swayosd/style.css"
          }
        '';
        Environment = lib.mkIf (!isNixOS) (
          lib.mkForce [ "XDG_DATA_DIRS=/usr/share:${config.home.profileDirectory}/share" ]
        );

      };
      Install = {
        WantedBy = lib.mkForce [ "${systemdTarget}" ];
      };
    };
  };

  services.swayosd.enable = true;
}
