{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (config.wayland.systemd) target;
in
{
  home.packages = [ pkgs.sway-audio-idle-inhibit ];

  systemd.user.services.sway-audio-idle-inhibit = {
    Unit = {
      Description = "sway-audio-idle-inhibit";
      PartOf = lib.toList target;
      After = lib.toList target;
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.sway-audio-idle-inhibit}/bin/sway-audio-idle-inhibit";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = lib.toList target;
    };
  };

}
