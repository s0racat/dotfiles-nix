{
  pkgs,
  lib,
  isNixOS,
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
in
{
  systemd.user.services.cliphist = {
    Service = {
      ExecStart = lib.mkForce "${pkgs.wl-clipboard}/bin/wl-paste --watch ${cliphist-wrapper}";
    };

  };
  services.cliphist.enable = true;
  services.cliphist.allowImages = false;

}
