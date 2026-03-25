{
  lib,
  isNixOS,
  pkgs,
  osConfig,
  ...
}:
let
  nixosFlatpak = osConfig.services.flatpak.enable;
  flatpakUpdate = pkgs.writeShellScript "flatpak-update" ''
    sleep 20

    OUTPUT=$(flatpak update -y --noninteractive 2>&1)
    if echo "$OUTPUT" | grep -q "Nothing to do"; then
      exit 0
    else
      notify-send "📦 Flatpak Update" "flatpakアプリが更新されました"
    fi
  '';
in
lib.mkIf (!isNixOS || nixosFlatpak) {
  xdg.configFile."autostart/mintupdate.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Hidden=true
  '';

  xdg.configFile."autostart/flatpak-update.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Flatpak Update
    Exec=${flatpakUpdate}
    X-GNOME-Autostart-enabled=true
  '';
  wayland.windowManager.sway.config.startup = [
    { command = "${flatpakUpdate}"; }
  ];
}
