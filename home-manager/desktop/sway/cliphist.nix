{
  pkgs,
  lib,
  isNixOS,
  config,
  ...
}:
let
  swaymsg = if isNixOS then lib.getExe' pkgs.sway "swaymsg" else "/usr/bin/swaymsg";
  cliphist-wrapper = pkgs.writeShellScript "cliphist-wrapper" ''
    app_id=$(${swaymsg} -t get_tree | ${lib.getExe pkgs.jq} -r '.. | select(.type?) | select(.focused==true) | .app_id')
    if [[ $app_id != "org.keepassxc.KeePassXC" ]]; then
      ${lib.getExe pkgs.cliphist} store
    fi
  '';
  inherit (config.wayland.systemd) target;
in
{
  home.packages = [ pkgs.cliphist ];

  systemd.user.services.mycliphist = {
    Unit = {
      Description = "Clipboard management daemon";
      PartOf = lib.toList target;
      After = lib.toList target;
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${cliphist-wrapper}";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = lib.toList target;
    };
  };

}
