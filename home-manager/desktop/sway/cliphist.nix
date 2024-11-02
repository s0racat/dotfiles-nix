{ pkgs, lib, ... }:
let
  isNixOS = (import ./isNixOS.nix).isNixOS;
  swaymsg = if isNixOS then lib.getExe' pkgs.sway "swaymsg" else "/usr/bin/swaymsg";
  wl-paste = if isNixOS then lib.getExe' pkgs.wl-clipboard "wl-paste" else "/usr/bin/wl-paste";
  cliphist-wrapper = pkgs.writeShellScript "cliphist-wrapper" ''
    app_id=$(${swaymsg} -t get_tree | ${lib.getExe pkgs.jq} -r '.. | select(.type?) | select(.focused==true) | .app_id')
    if [[ $app_id != "org.keepassxc.KeePassXC" ]]; then
      ${lib.getExe pkgs.cliphist} store
    fi
  '';
  systemdTarget = "sway-session.target";
in
{
  systemd.user.services.cliphist = {
    Unit = {
      Description = "Clipboard management daemon";
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${wl-paste} --watch ${cliphist-wrapper}";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "${systemdTarget}" ];
    };
  };
  home.packages = with pkgs; [
    cliphist
    jq
  ];
}
