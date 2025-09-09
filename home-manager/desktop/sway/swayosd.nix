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

      Service = {
        ExecStart = lib.mkForce ''${lib.getExe' pkgs.swayosd "swayosd-server"}'';
        Environment = lib.mkIf (!isNixOS) (
          lib.mkForce [ "XDG_DATA_DIRS=/usr/share:${config.home.profileDirectory}/share" ]
        );

      };
    };
  };

  services.swayosd.enable = true;
  services.swayosd.stylePath = "${pkgs.swayosd}/etc/xdg/swayosd/style.css";
}
